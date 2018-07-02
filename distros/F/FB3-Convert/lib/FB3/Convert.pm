package FB3::Convert;

use strict;
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use Data::Dumper;
use Term::ANSIColor;
use File::Temp;
use XML::LibXSLT;
use XML::LibXML;
use File::Basename;
use Hash::Merge;
use Cwd qw(cwd abs_path getcwd realpath);
use UUID::Tiny ':std';
use File::Copy qw(copy);
use File::Temp qw/ tempfile tempdir /;
use FB3::Validator;
use utf8;
use Encode qw(encode_utf8 decode_utf8);
use XML::Entities;
use XML::Entities::Data;
use Time::HiRes qw(gettimeofday sleep);
binmode(STDOUT,':utf8');

our $VERSION = 0.08;

=head1 NAME

FB3::Convert - scripts and API for converting FB3 from and to different formats

=cut

my %MODULES;
# каким плагином работать - определяется тупо по расширению файла (см. ключ в хэше)
%MODULES = (
  'epub' => {
    'class' => 'FB3::Convert::Epub',
    'unpack' => 1,
  },
  'fb2' => { #не реализовано. просто пример подключения модуля в конвертор
    'class' => 'FB3::Convert::FB2',
    'unpack' => ['fb2.zip']
  },
  'fb2.zip' => \$MODULES{'fb2'},
);

my @BlockLevel =
('address','article','aside','blockquote','canvas','dd','div','dl','dt','fieldset','figcaption','figure','footer','form',
'h1','h2','h3','h4','h5','h6',
'header','hr','li','main','nav','noscript','ol','output','p','pre','section','table','tfoot','ul','video',
#формально не блок-левел, но нам их тоже приводить к нормальному виду
'th','tr','td'
);

my $AllEntities = XML::Entities::Data::all;
delete $AllEntities->{'lt'};
delete $AllEntities->{'gt'};
delete $AllEntities->{'quot'};
delete $AllEntities->{'apos'};
delete $AllEntities->{'amp'};

#Элементы, которые парсим в контенте и сохраняем в структуру 
our $ElsMainList = {
  'span'=>undef,
  'a'=>undef,
  'em'=>undef,
  'sub'=>undef,
  'sup'=>undef,
  'code'=>undef,
  'img'=>undef,
  'i'=>undef,
  'u'=>undef,
  'underline'=>undef,
  'b'=>undef,
  'strong'=>undef,
};

our $ElsMainList2={};
map {$ElsMainList2->{$_}=undef;} keys %$ElsMainList;
$ElsMainList2->{p}=undef;

my %AllowElementsMain = (
  'table' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => {'tr'=>undef},
  },
  'tr' => {
    'allow_attributes' => ['id','align'],
    'allow_elements_inside' => {'th'=>undef,'td'=>undef},
  },
  'th' => {
    'allow_attributes' => ['colspan','rowspan','align','valign'],
    'allow_elements_inside' => $ElsMainList2,
  },
  'td' => {
    'allow_attributes' => ['colspan','rowspan','align','valign'],
    'allow_elements_inside' => $ElsMainList2,
  },
  'i' => {
    'allow_attributes' => [],
    'allow_elements_inside' => $ElsMainList,
  },
  'strong' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => $ElsMainList,
  },
  'underline' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => $ElsMainList,
  },
  'em' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => $ElsMainList,
  },
  'u' => {
    'allow_attributes' => ['id']  
  },
  'sup' => {
    'allow_attributes' => ['id']  
  },
  'sub' => {
    'allow_attributes' => ['id']  
  },
  'p' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => $ElsMainList,
    'exclude_if_inside' => ['ul','ol','table'], #с этими вариантами лучше схлопнуться родительскому 'p'
  },
  'span' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => $ElsMainList,
  },
  'title' => {
    'processor' => \&Transform2Valid,
    'allow_attributes' => ['id'],
    'allow_elements_inside' => {'p'=>undef},
  },
  'subtitle' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => $ElsMainList,
  },
  'ul' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => {'li'=>undef, 'title'=>undef, 'epigraph'=>undef},
  },
  'ol' => {
    'allow_attributes' => ['id'],
    'allow_elements_inside' => {'li'=>undef, 'title'=>undef, 'epigraph'=>undef},
  },
  'li' => {
    'allow_attributes' => [],
    'allow_elements_inside' => {'em'=>undef,a=>undef},
  },
  'root_fb3_container' => {
    'allow_elements_inside' => {
      'underline'=>undef,
      'b'=>undef,
      'strong'=>undef,
      'span'=>undef, 
      'div'=>undef,
      'b'=>undef,
      'h1'=>undef,
      'h2'=>undef,
      'h3'=>undef,
      'h4'=>undef,
      'h5'=>undef,
      'h6'=>undef,
      'table'=>undef,
      'ul'=>undef, 
      'ol'=>undef, #полноправные элементы корня
      'p'=>undef,  # см. ^^^
      'title'=>undef, #разрешен, так как нужен в заголовочном section, но в body его необходимо удалять
      'subtitle'=>undef,
      'img' => undef, #некоторые элементы попадаются в корне, их так же нужно разрешить. Transform2Valid() их обрамит в <p> 
      'a' => undef # см. ^^^
    }
  },
  
);

my %GenreTranslate = (
  'accounting'=>'Бухучет, налогообложение, аудит',
  'adventure'=>'Приключения',
  'adv_animal'=>'Природа и животные',
  'adv_geo'=>'Книги о Путешествиях',
  'adv_history'=>'Исторические приключения',
  'adv_maritime'=>'Морские приключения',
  'adv_western'=>'Вестерны',
  'antique'=>'Старинная литература',
  'antique_ant'=>'Античная литература',
  'antique_east'=>'Древневосточная литература',
  'antique_european'=>'Европейская старинная литература',
  'antique_myths'=>'Мифы. Легенды. Эпос',
  'antique_russian'=>'Древнерусская литература',
  'aphorism_quote'=>'Афоризмы и цитаты',
  'architecture_book'=>'Архитектура',
  'auto_regulations'=>'Автомобили и ПДД',
  'banking'=>'Банковское дело',
  'beginning_authors'=>'Начинающие авторы',
  'samizdat'=>'Самиздат',
  'children'=>'Книги для детей',
  'child_adv'=>'Детские приключения',
  'child_det'=>'Детские детективы',
  'child_education'=>'Учебная литература',
  'child_prose'=>'Детская проза',
  'child_sf'=>'Детская фантастика',
  'child_tale'=>'Сказки',
  'child_verse'=>'Детские стихи',
  'cinema_theatre'=>'Кинематограф, театр',
  'city_fantasy'=>'Городское фэнтези',
  'computers'=>'Компьютеры',
  'comp_db'=>'Базы данных',
  'comp_hard'=>'Компьютерное Железо',
  'comp_osnet'=>'ОС и Сети',
  'comp_programming'=>'Программирование',
  'comp_soft'=>'Программы',
  'comp_www'=>'Интернет',
  'detective'=>'Современные детективы',
  'det_action'=>'Боевики',
  'det_classic'=>'Классические детективы',
  'det_crime'=>'Криминальные боевики',
  'det_espionage'=>'Шпионские детективы',
  'det_hard'=>'Крутой детектив',
  'det_history'=>'Исторические детективы',
  'det_irony'=>'Иронические детективы',
  'det_police'=>'Полицейские детективы',
  'det_political'=>'Политические детективы',
  'dragon_fantasy'=>'Фэнтези про драконов',
  'dramaturgy'=>'Драматургия',
  'economics'=>'Экономика',
  'essays'=>'Эссе',
  'fantasy_fight'=>'Боевое фэнтези',
  'foreign_action'=>'Зарубежные боевики',
  'foreign_adventure'=>'Зарубежные приключения',
  'foreign_antique'=>'Зарубежная старинная литература',
  'foreign_business'=>'Зарубежная деловая литература',
  'foreign_children'=>'Зарубежные детские книги',
  'foreign_comp'=>'Зарубежная компьютерная литература',
  'foreign_contemporary'=>'Современная зарубежная литература',
  'foreign_desc'=>'Зарубежная справочная литература',
  'foreign_detective'=>'Зарубежные детективы',
  'foreign_dramaturgy'=>'Зарубежная драматургия',
  'foreign_edu'=>'Зарубежная образовательная литература',
  'foreign_fantasy'=>'Зарубежное фэнтези',
  'foreign_home'=>'Зарубежная прикладная и научно-популярная литература',
  'foreign_humor'=>'Зарубежный юмор',
  'foreign_language'=>'Иностранные языки',
  'foreign_love'=>'Зарубежные любовные романы',
  'foreign_other'=>'Зарубежное',
  'foreign_poetry'=>'Зарубежные стихи',
  'foreign_prose'=>'Зарубежная классика',
  'foreign_psychology'=>'Зарубежная психология',
  'foreign_publicism'=>'Зарубежная публицистика',
  'foreign_religion'=>'Зарубежная эзотерическая и религиозная литература',
  'foreign_sf'=>'Зарубежная фантастика',
  'geography_book'=>'География',
  'geo_guides'=>'Путеводители',
  'global_economy'=>'ВЭД',
  'historical_fantasy'=>'Историческое фэнтези',
  'home'=>'Дом и Семья',
  'home_cooking'=>'Кулинария',
  'home_crafts'=>'Хобби, Ремесла',
  'home_diy'=>'Сделай Сам',
  'home_entertain'=>'Развлечения',
  'home_garden'=>'Сад и Огород',
  'home_health'=>'Здоровье',
  'home_pets'=>'Домашние Животные',
  'home_sex'=>'Эротика, Секс',
  'home_sport'=>'Спорт, фитнес',
  'humor'=>'Юмор',
  'humor_anecdote'=>'Анекдоты',
  'humor_fantasy'=>'Юмористическое фэнтези',
  'humor_prose'=>'Юмористическая проза',
  'humor_verse'=>'Юмористические стихи',
  'industries'=>'Отраслевые издания',
  'job_hunting'=>'Поиск работы, карьера',
  'literature_18'=>'Литература 18 века',
  'literature_19'=>'Литература 19 века',
  'literature_20'=>'Литература 20 века',
  'love_contemporary'=>'Современные любовные романы',
  'love_detective'=>'Остросюжетные любовные романы',
  'love_erotica'=>'Эротическая литература',
  'love_fantasy'=>'Любовное фэнтези',
  'love_history'=>'Исторические любовные романы',
  'love_sf'=>'Любовно-фантастические романы',
  'love_short'=>'Короткие любовные романы',
  'magician_book'=>'Книги про волшебников',
  'management'=>'Управление, подбор персонала',
  'marketing'=>'Маркетинг, PR, реклама',
  'military_special'=>'Военное дело, спецслужбы',
  'music_dancing'=>'Музыка, балет',
  'narrative'=>'Повести',
  'newspapers'=>'Газеты',
  'nonfiction'=>'Документальная литература',
  'nonf_biography'=>'Биографии и Мемуары',
  'nonf_criticism'=>'Критика',
  'nonf_publicism'=>'Публицистика',
  'org_behavior'=>'Корпоративная культура',
  'paper_work'=>'Делопроизводство',
  'pedagogy_book'=>'Педагогика',
  'periodic'=>'Журналы',
  'personal_finance'=>'Личные финансы',
  'poetry'=>'Поэзия',
  'popadanec'=>'Попаданцы',
  'popular_business'=>'О бизнесе популярно',
  'prose_classic'=>'Классическая проза',
  'prose_counter'=>'Контркультура',
  'prose_history'=>'Историческая литература',
  'prose_military'=>'Книги о войне',
  'prose_rus_classic'=>'Русская классика',
  'prose_su_classics'=>'Советская литература',
  'psy_alassic'=>'Классики психологии',
  'psy_childs'=>'Детская психология',
  'psy_generic'=>'Общая психология',
  'psy_personal'=>'Личностный рост',
  'psy_sex_and_family'=>'Секс и семейная психология',
  'psy_social'=>'Социальная психология',
  'psy_theraphy'=>'Психотерапия и консультирование',
  'real_estate'=>'Недвижимость',
  'reference'=>'Справочная литература',
  'ref_dict'=>'Словари',
  'ref_encyc'=>'Энциклопедии',
  'ref_guide'=>'Руководства',
  'ref_ref'=>'Справочники',
  'religion'=>'Религия',
  'religion_esoterics'=>'Эзотерика',
  'religion_rel'=>'Религиозные тексты',
  'religion_self'=>'Самосовершенствование',
  'russian_contemporary'=>'Современная русская литература',
  'russian_fantasy'=>'Русское фэнтези',
  'science'=>'Прочая образовательная литература',
  'sci_biology'=>'Биология',
  'sci_chem'=>'Химия',
  'sci_culture'=>'Культурология',
  'sci_history'=>'История',
  'sci_juris'=>'Юриспруденция, право',
  'sci_linguistic'=>'Языкознание',
  'sci_math'=>'Математика',
  'sci_medicine'=>'Медицина',
  'sci_philosophy'=>'Философия',
  'sci_phys'=>'Физика',
  'sci_politics'=>'Политика, политология',
  'sci_religion'=>'Религиоведение',
  'sci_tech'=>'Техническая литература',
  'sf'=>'Научная фантастика',
  'sf_action'=>'Боевая фантастика',
  'sf_cyberpunk'=>'Киберпанк',
  'sf_detective'=>'Детективная фантастика',
  'sf_heroic'=>'Героическая фантастика',
  'sf_history'=>'Историческая фантастика',
  'sf_horror'=>'Ужасы и Мистика',
  'sf_humor'=>'Юмористическая фантастика',
  'sf_social'=>'Социальная фантастика',
  'sf_space'=>'Космическая фантастика',
  'short_story'=>'Рассказы',
  'sketch'=>'Очерки',
  'small_business'=>'Малый бизнес',
  'sociology_book'=>'Социология',
  'stock'=>'Ценные бумаги, инвестиции',
  'thriller'=>'Триллеры',
  'upbringing_book'=>'Воспитание детей',
  'vampire_book'=>'Книги про вампиров',
  'visual_arts'=>'Изобразительное искусство, фотография',
);

my $XSLT = XML::LibXSLT->new;
my $XC = XML::LibXML::XPathContext->new();
my $Parser = XML::LibXML->new();

use constant {
	NS_FB3_DESCRIPTION => 'http://www.fictionbook.org/FictionBook3/description'
};

sub new {
  my $class = shift;
  my $X = {};
  my %Args = @_;
  
  if ($Args{'empty'}) {
    bless $X, $class;
    return $X;
  }

  my $SourcePath = $Args{'source'};
  my $SourceFileName = $SourcePath;
  $SourceFileName =~ s/.*?([^\/]+)$/$1/g;

  my $DestinationDir = $Args{'destination_dir'} || tempdir();
  my $DestinationFile = $Args{'destination_file'};

  if ($DestinationFile) {    
    if ($DestinationFile =~ /^[^\/]/) {
      $DestinationFile = cwd()."/".$DestinationFile;
    }
    my $DstFileDir = dirname($DestinationFile);
    Error($X,"Directory for destination file not found! : ".$DstFileDir) unless -d $DstFileDir;
    $DestinationFile = Cwd::realpath($DestinationFile);
  }

  Error($X,"source file not defined") unless $SourcePath;
  Error($X,"source file '".$SourcePath."' not exists") unless -f $SourcePath;

  $SourcePath =~ /\.([^\.]+)$/;
  my $FileType = $1;
  Error($X, "File '".$SourcePath."' format not detected") unless $MODULES{$FileType};
  my $Sub = $FileType;

  my $Module = $MODULES{$Sub}->{class};
  #подгружаем нужный модуль
  eval {
    (my $MFile = $Module) =~ s|::|/|g;
    require $MFile . '.pm';
    1;
  } or do {
    Error($X, "Can't load module ".$Module." ".$@);
  };

  $X->{'ClassName'} = $Sub;
  $X->{'Source'} = $SourcePath;
  $X->{'SourceFileName'} = $SourceFileName;
  $X->{'SourceDir'} = undef;
  $X->{'DestinationDir'} = $DestinationDir;
  $X->{'DestinationFile'} = $DestinationFile;
  $X->{'Module'} = $Module;
  $X->{'verbose'} = $Args{'verbose'} ? $Args{'verbose'} : 0;
  $X->{'euristic'} = $Args{'euristic'} || undef;
  $X->{'euristic_debug'} = $Args{'euristic_debug'} || undef;
  $X->{'phantom_js_path'} = $Args{'phantom_js_path'} || undef;
  $X->{'showname'} = $Args{'showname'} ? 1 : 0;
  $X->{'allow_elements'} = \%AllowElementsMain;
  $X->{'href_list'} = {}; #собираем ссылки в документе
  $X->{'id_list'} = {}; #собираем ссылки в документе
  $X->{'bench'} = $Args{'bench'} ? 1 : 0; #бенчмарк режим в stdout
  $X->{'bench2file'} = $Args{'bench2file'} ? $Args{'bench2file'} : 0; #бенчмарк режим в файл
  $X->{'bench_list'} = {}; #бенчмарк режим

  #Наша внутренняя структура данных конвертора. шаг влево  - расстрел
  $X->{'STRUCTURE'} = {

  'DESCRIPTION' => {
    'TITLE-INFO' => {
      'COVER' => undef,
        'AUTHORS' => undef, #[
                    #{
                    #  'first-name' => "Иван",
                    #  'id' => 'bcf95bde-eedc-49ef-926c-588bd4cfd9cd',
                    #  'middle-name' => undef,
                    #  'last-name' => "Растеряйло"
                    #},
                  #],
        'PUBLISHER' => undef,
        'ANNOTATION' => undef,
        'BOOK-TITLE' => undef,
        'GENRES' => undef, #[
                  # 'humor_prose',
                  # 'prose_su_classics'
                  #],
    },
    'DOCUMENT-INFO' => {
      'DATE' => undef, #{
        #'attributes' => {
        #  'value' => undef
        #}
      #},
      'TIME' => {
        'attributes' => {
          'value' => "00:00:00",
        }
      },
      'LANGUAGE' => undef,
      'ID' => undef
    }
  },
  'IMG_LIST' => [ # сюда складывает все встреченные картинки. Их ведь нужно копировать в новую папку, и rels строить
    # {
    #   'src_path' => 'images/_1000516292.jpg',
    #   'id' => 'img1',
    #   'new_path' => 'img/794__1000516292.jpg'
    # }
  ],
  'CSS_LIST' => [ # так же со стилями
    #{
    #  'id' => 'mainCSS',
    #  'new_path' => undef,
    #  'src_path' => 'css/main.css'
    #},
  ],
  'PAGES' => { # контент для body
  'attributes' => {
                   'CP_compact' => 1 # узлы  без контейнеров
                            },
  'value' => [
                        {} # дерево любой вложенности. см sub Obj2DOM
                       ]
             }
  };
   
  bless $X, $class;
  Init($X);
   
  #мета из файла (->fb3/description.xml)
  if ($Args{'metadata'}) {
    $X->Error("Meta file ".$Args{'metadata'}." not exists\n") unless -f $Args{'metadata'};
    $X->{'metadata'} = $Args{'metadata'};
    $X->ParseMetaFile();     
    File::Copy::copy($X->{'metadata'}, $X->{'DestinationDir'}."/fb3/description.xml");
  } else {
    #или мета из  параметров  
    $X->BuildOuterMeta(meta => $Args{'meta'});
  }

  return $X;
}

sub Init {
  my $X = shift;
  Msg($X,"Init\n");
  my $FB3Path = $X->{'DestinationDir'};

  if (-d $FB3Path) {
    $X->Msg("Remove old destination dir: ".$FB3Path."\n","w");
    ForceRmDir($X, $FB3Path);
  }

  Msg($X,"Create FB3 directory: ".$FB3Path."\n");
  mkdir "$FB3Path" or $X->Error("$FB3Path : $!");

  for my $Dir ("/fb3", "/fb3/img", "/fb3/style", "/fb3/meta", "/fb3/_rels", "/_rels") {
    mkdir "$FB3Path$Dir" or $X->Error("$FB3Path$Dir : $!");
  }
  Msg($X,"FB3: Directory structure is created successfully.\n");

}

sub Reap {
  my $X = shift;
  my $Processor = $MODULES{$X->{'ClassName'}};
  my $File = $X->{'Source'};

  $X->Msg("working with file ".$File."\n",'w',1) if $X->{'showname'} || $X->{'verbose'};

  $X->_bs('unpack','Распаковка Epub');
  $File = $Processor->{class}->_Unpacker($X,$File) if $Processor->{'unpack'};
  $X->_be('unpack');

  $X->_bs('reap','Потрошение Epub, cборка данных');
  $Processor->{'class'}->Reaper($X, source => ($File || $X->{'Source'}));
  $X->_be('reap');

  return $X->{'STRUCTURE'};
}

# -- методы могут быть переопределены в дочернем классе --

#Распаковывает файл как zip, на выходе отдает директорию
sub _Unpacker {
  my $self = shift;
  my $X = shift;
  my $Source = shift;

  my $TMPPath = tempdir(CLEANUP=>1);

  $X->{'SourceDir'} = $TMPPath;
  $X->{'unzipped'} = 1;

  my $Zip = Archive::Zip->new();

  unless ($Zip->read($Source) == Archive::Zip::AZ_OK ) {
    Error("Error reading file '".$Source."' as zip");
	}
	
  my @FilesInZip = $Zip->members(); 
	
  Msg($X,"Unzip epub to directory: ".$TMPPath."\n");
  foreach (@FilesInZip) {
    my $ExtFile = $TMPPath.'/'.$_->fileName;
    Error($X,"can't unpuck ".$_->fileName." from ".$Source." archive") unless $Zip->extractMember($_, $ExtFile) == AZ_OK;
  } 
 
  return $TMPPath;
}

sub FB3Create {
  my $X = shift;
  Msg($X,"Create FB3\n");

  my $Structure = shift || $X->{'STRUCTURE'} || $X->Error("Structure is empty");
  my $FB3Path = $X->{'DestinationDir'};

  #compile required files
  my $CoverSrc = $Structure->{'DESCRIPTION'}->{'TITLE-INFO'}->{'COVER'};

  Msg($X,"FB3: Create /_rels/.rels\n","w");
  my $FNrels="$FB3Path/_rels/.rels";
  open FHrels, ">$FNrels" or $X->Error("$FNrels: $!");
  print FHrels qq{<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">}.
  ( $CoverSrc ? qq{
  <Relationship Id="rId0" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/thumbnail" Target="$CoverSrc"/>} : '' ).qq{
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="fb3/meta/core.xml"/>
  <Relationship Id="rId2" Type="http://www.fictionbook.org/FictionBook3/relationships/Book" Target="fb3/description.xml"/>
  </Relationships>};
  close FHrels;

  Msg($X,"FB3: Create [Content_Types].xml\n","w");
  my $FNct="$FB3Path/[Content_Types].xml";
  open FHct, ">$FNct" or $X->Error("$FNct: $!");
  print FHct qq{<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
   	<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" />
   	<Default Extension="png" ContentType="image/png"/>
   	<Default Extension="jpg" ContentType="image/jpeg"/>
    <Default Extension="jpeg" ContentType="image/jpeg"/>
   	<Default Extension="gif" ContentType="image/gif"/>
   	<Default Extension="svg" ContentType="image/svg+xml"/>
   	<Default Extension="xml" ContentType="application/xml"/>
   	<Default Extension="css" ContentType="text/css"/>
   	<Override PartName="/fb3/meta/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
   	<Override PartName="/fb3/description.xml" ContentType="application/fb3-description+xml"/>
   	<Override PartName="/fb3/body.xml" ContentType="application/fb3-body+xml"/>
  </Types>};
  close FHct;

  Msg($X,"FB3: Create /fb3/_rels/description.xml.rels\n","w");
  my $FNdrels="$FB3Path/fb3/_rels/description.xml.rels";
  open FHdrels, ">$FNdrels" or $X->Error("$FNdrels: $!");
  print FHdrels qq{<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
   	<Relationship Id="rId0"
    		Target="body.xml"
    		Type="http://www.fictionbook.org/FictionBook3/relationships/body" />
  </Relationships>};
  close FHdrels;

 # !! Стили пока не трогаем !!
  #Скопируем стили
#  foreach my $css (@{$Structure->{'CSS_LIST'}}) {
#    my $SrcPath = $X->{'ContentDir'}."/".$css->{'src_path'};
#    my $CssDestPath = $X->{'DestinationDir'}."/fb3/style";
#    my $CssFile = $css->{'src_path'};
#    $CssFile =~ s/.*\/([^\/]+)/$1/g;
#    my $DstPath = $CssDestPath."/".$CssFile;
#    $X->Msg("copy $SrcPath -> $DstPath\n","w");
#    copy($SrcPath, $DstPath) or $X->Error($!);
#    $css->{'new_path'} = "style/".$CssFile;
#  }

  #ДО ЭТОГО МОМЕНТА МЫ МОЖЕМ ИЗМЕНЯТЬ $Structure, ТО ЕСТЬ ВМЕШИВАТЬСЯ В КОНЕЧНЫЙ РЕЗУЛЬТАТ ОТРИСОВКИ FB3
 # print Data::Dumper::Dumper($Structure);
 # exit;
  
  my $GlobalID = $Structure->{'DESCRIPTION'}->{'DOCUMENT-INFO'}->{'ID'};
  my $TitleInfo = $Structure->{'DESCRIPTION'}->{'TITLE-INFO'};
  my $DocInfo = $Structure->{'DESCRIPTION'}->{'DOCUMENT-INFO'};
  
  #Пишем body
  Msg($X,"FB3: Create /fb3/body.xml\n","w");
  my $FNbody="$FB3Path/fb3/body.xml";
  my $BodyAttr = {
  	'xmlns'=>"http://www.fictionbook.org/FictionBook3/body",
    'xmlns:xlink'=>"http://www.w3.org/1999/xlink",
    'id'=>$GlobalID,
  };

  $X->_bs('Obj2DOM_body','PAGES => DOM');
  my $Body = Obj2DOM($X,
              obj=>{
                attributes=>{CP_compact=>1},
                value=>$Structure->{'PAGES'}->{'value'}
              },
              root=>{name=>'fb3-body', attributes=>$BodyAttr}
            );  
  $X->_be('Obj2DOM_body');
  
  #финальное приведение section к валидному виду
  foreach my $Section ($XC->findnodes( "/fb3-body/section/section", $Body), $XC->findnodes( "/fb3-body/section", $Body)) {
    $Section = $X->Transform2Valid(node=>$Section);
  }

  #финальное приведение table к валидному виду
  foreach my $Table ($XC->findnodes( "/fb3-body//table", $Body)) {
    $Table = $X->TransformTable2Valid(node=>$Table);
  }

  open FHbody, ">$FNbody" or $X->Error("$FNbody: $!");
  print FHbody $Body->toString(1);
  close FHbody;

  #Пишем мету
  #Превращаем перл-структуру в DOM
  delete $Structure->{'PAGES'};
  $X->_bs('Obj2DOM_meta','META => DOM');
  my $Doc = Obj2DOM($X, obj=>$Structure, like_parent=>0, compact=>0 ); 
  $X->_be('Obj2DOM_meta');

  #Пишем rels
  Msg($X,"FB3: Create /fb3/_rels/body.xml.rels\n","w");
  my $FNbodyrels="$FB3Path/fb3/_rels/body.xml.rels";
  open FHbodyrels, ">$FNbodyrels" or $X->Error("$FNbodyrels: $!");
  print FHbodyrels qq{<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.openxmlformats.org/package/2006/relationships" xmlns:xlink="http://www.w3.org/1999/xlink">
};
  foreach (@{$Structure->{'IMG_LIST'}}) {
    print FHbodyrels qq{  <Relationship Id="$_->{'id'}" Type="http://www.fictionbook.org/FictionBook3/relationships/image" Target="$_->{'new_path'}"/>
};
  }
  print FHbodyrels qq{</Relationships>};
  close FHbodyrels;
  
  #Пишем core
  Msg($X,"FB3: Create /fb3/meta/core.xml\n","w");
  my $FNcore="$FB3Path/fb3/meta/core.xml";
  open FHcore, ">$FNcore" or $X->Error("$FNcore: $!");
  print FHcore qq{<?xml version="1.0" encoding="UTF-8"?>
  <cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.fictionbook.org/FictionBook3/description" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/">
    <dc:title>}.$TitleInfo->{'BOOK-TITLE'}.qq{</dc:title>
    <dc:subject>}.$TitleInfo->{'ANNOTATION'}.qq{</dc:subject>
    <dc:creator>};
  
  my $c=1;         
  foreach (@{$TitleInfo->{'AUTHORS'}}) {
    print FHcore $_->{'first-name'}." ".$_->{'last-name'};
    print FHcore ", " if $c < scalar @{$TitleInfo->{'AUTHORS'}};
    $c++;
  }
  
  print FHcore qq{</dc:creator>
    <dc:description>}.$TitleInfo->{'ANNOTATION'}.qq{</dc:description>
    <cp:keywords>XML, FictionBook, eBook, OPC</cp:keywords>
    <cp:revision>1.00</cp:revision>
    }.
  ($DocInfo->{'DATE'}->{'attributes'}->{'value'}?qq{<dcterms:created xsi:type="dcterms:W3CDTF">}.$DocInfo->{'DATE'}->{'attributes'}->{'value'}.qq{</dcterms:created>
    }:'')
  .qq{<cp:contentStatus>Draft</cp:contentStatus>
    <cp:category>};
  
  my $c=1;         
  foreach (@{$TitleInfo->{'GENRES'}}) {
    print FHcore $_;
    print FHcore ", " if $c < scalar @{$TitleInfo->{'GENRES'}};
    $c++;
  }

  print FHcore qq{</cp:category>
  </cp:coreProperties>};
  close FHcore;
  #Пишем description
  Msg($X,"FB3: Create /fb3/description.xml\n","w");
  my $FNdesc="$FB3Path/fb3/description.xml";
  open FHdesc, ">$FNdesc" or $X->Error("$FNdesc: $!");
  print FHdesc qq{<?xml version="1.0" encoding="UTF-8"?>
<fb3-description xmlns="http://www.fictionbook.org/FictionBook3/description" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" id="}.$GlobalID.qq{" version="1.0">
  };

  print FHdesc qq{<title>
    <main>}.$TitleInfo->{'BOOK-TITLE'}.qq{</main>
  </title>
  };
    
  print FHdesc qq{<fb3-relations>
    };

  foreach (@{$TitleInfo->{'AUTHORS'}}) {

    my $First = $_->{'first-name'};
    my $Middle = $_->{'middle-name'};
    my $Last = $_->{'last-name'}||"Unknown";

    print FHdesc qq{<subject link="author" id="}.($_->{'id'}||'00000000-0000-0000-0000-000000000000').qq{">
      <title>
        <main>
          }.
      ($First?$First.' '.$Last:$Last).qq{
        </main>
      </title>}
      .($First?qq{
      <first-name>}.$First.'</first-name>':'')
      .($Middle?qq{
      <middle-name>}.$Middle.qq{</middle-name>}:'')
      .qq{
      <last-name>}.$Last.qq{</last-name>
    </subject>
  };
  }

  print FHdesc qq{</fb3-relations>
  };

  
  print FHdesc qq{<fb3-classification>
    };
  foreach (@{$TitleInfo->{'GENRES'}}) {
    print FHdesc qq{<subject>}.(exists $GenreTranslate{$_}?$GenreTranslate{$_}:$_).qq{</subject>
    };
  }
  print FHdesc qq{</fb3-classification>
  };
  

  print FHdesc qq{<lang>}.$DocInfo->{'LANGUAGE'}.qq{</lang>
  <written>
    <lang>}.$DocInfo->{'LANGUAGE'}.qq{</lang>
  </written>
  };

  my $DCDate = $DocInfo->{'DATE'}->{'attributes'}->{'value'}."T".$DocInfo->{'TIME'}->{'attributes'}->{'value'};
  print FHdesc qq{<document-info created="}.$DCDate.qq{" updated="}.$DCDate.qq{"/>
};

  print FHdesc qq{  <annotation>
    <p>}.$TitleInfo->{'ANNOTATION'}.qq{</p>
  </annotation>
} if $TitleInfo->{'ANNOTATION'};

  print FHdesc qq{</fb3-description>};
  close FHdesc;
 
  return $FB3Path;
}

sub FB3_2_Zip {
  my $X = shift;
  my %Args = @_;

  Msg($X,"Create Zip from FB3: ".$X->{'DestinationFile'}."\n");

  my $old_dir = cwd();
  chdir("$X->{'DestinationDir'}");
  system("/usr/bin/zip -rq9 '".$X->{'DestinationFile'}."' ./*");
  chdir $old_dir if $old_dir;
  Msg($X,"Delete dir after zip: $X->{'DestinationDir'}\n");
  ForceRmDir($X,$X->{'DestinationDir'});
  Msg($X,"OK\n");
}

sub InNode {
  my $X = shift;
  my $Node = shift;
  join "",map {$_->toString} $Node->childNodes;
}

# function Obj2DOM()
# 
# example:
# my $Doc = Obj2DOM($X,
#  obj => {
#         attributes => {attr1 => 1, attr2 => 2},
#         title0 => 'TITLE0',
#             title1 => {
#                 attributes => {attr3 => 3, attr4 => 4},
#                 value => 'TITLE1',
#             },
#             title2 => {
#                 attributes => {attr5 => 5, attr6 => 6},
#                 value => [7,8,{item9=>[10,12,{item12=>12}]}],
#             },
#             title3 => [
#                 {'item13' => 13},
#                 {'item14' => 14},
#                 15,16,
#       '_17','_18',
#             ],
#   'title4' => {
#                 attributes => {CP_compact => 1},
#                 value => [123,{span=>'spanvalue'}]
#             }
#         }
# );
# print $Doc->toString(
#     1 #pretty
# );
# 
# (hashes sorted by keys) =>
# <?xml version="1.0" encoding="utf-8"?>
# <root attr1="1" attr2="2">
#   <title0>TITLE0</title0>
#   <title1 attr4="4" attr3="3">TITLE1</title1>
#   <title2 attr6="6" attr5="5">
#     <item>7</item>
#     <item>8</item>
#     <item>
#       <item>10</item>
#       <item>12</item>
#       <item12>12</item12>
#     </item9>
#   </title2>
#   <title3>
#     <item13>13</item13>
#     <item14>14</item14>
#     <item>15</item>
#     <item>16</item>
#     <item>_17</item>
#     <item>_18</item>
#   </title3>
#   <title4>
#     123<span>spanvalue</span>
#   </title4>
# </root>

my $Doc;
sub Obj2DOM {
  my $X = shift;
  my %Args = @_;

  my $Obj = $Args{'obj'};
  my $Parent = $Args{'parent'} || undef;
  my $Sub = $Args{'sub'} || 0;
  my $Root = $Args{'root'} || {name=>'root'};

  #параметры, влияющие на поведение отрисовки DOM
  my $ArrayNodeNameLikeParent = $Args{'like_parent'} || 0; # title1 =>[{},{}] ==> <title1><title1/><title1/></title1>
  my $Compact = $Args{'compact'} || 0;  # like_parent не актуально. элементы не обрамляются в item-контейнеры

  undef $Doc unless $Sub; #первый заход парсинга. $Doc fresh and virginity

  unless ($Doc) {
    $Doc = XML::LibXML::Document->new('1.0', 'utf-8');
  }

  my $First=0;
  if (!$Parent) {
    $First=1;
    $Parent = $Doc->createElement($Root->{'name'});
    if ($Root->{'attributes'}) {
      foreach my $RAttr ( keys %{$Root->{'attributes'}}) {
        $Parent->addChild($Doc->createAttribute( $RAttr => $Root->{'attributes'}->{$RAttr} ));
      }
    }
  }

  if (ref $Obj eq 'HASH') {

    foreach my $Key (sort keys %$Obj) {
      my $Value = $Obj->{$Key};

      if ($Key eq 'attributes') {
        foreach (sort keys %{$Obj->{'attributes'}}) {
          $Compact = 1 if $_ eq 'CP_compact' && $Obj->{'attributes'}->{$_}; #все следующие вложенные ноды - в формате compact
          $Parent->addChild($Doc->createAttribute( $_ => $Obj->{'attributes'}->{$_} )) unless $First;
        }
      } elsif ($Key eq 'value') {
        Obj2DOM($X, sub=>1, obj => $Obj->{$Key}, parent => $Parent, like_parent => $ArrayNodeNameLikeParent, compact => $Compact);
      } else {
        my $Child = $Doc->createElement($Key);
        Obj2DOM($X, sub=>1, obj => $Obj->{$Key}, parent => $Child, like_parent => $ArrayNodeNameLikeParent, compact => $Compact);            
        $Parent->addChild($Child); 
      }

    }

  } elsif (ref $Obj eq 'ARRAY') {
    foreach my $Item (@$Obj) {
      if (ref $Item eq ''
         || (!$Compact && ref $Item eq 'HASH')
         ) {
        my $Child;
        $Child = $Doc->createElement($ArrayNodeNameLikeParent?$Parent->nodeName:'item') unless $Compact;
        Obj2DOM($X, sub=>1, obj => $Item, parent => ($Compact ? $Parent : $Child), like_parent => $ArrayNodeNameLikeParent, compact => $Compact);            
        $Parent->addChild($Child) unless $Compact;     
      } else {
        Obj2DOM($X, sub=>1, obj => $Item, parent => $Parent, like_parent => $ArrayNodeNameLikeParent, compact => $Compact);
      }
    }
  } elsif (ref $Obj eq '') {
    $Parent->appendTextNode($Obj);
  }

  $Doc->setDocumentElement($Parent) unless $Sub;
  return $Doc;
}

sub Content2Tree {
  my $X = shift;
  my $Obj = shift;
  my $Content = $Obj->{'content'};
  my $File = $Obj->{'file'};

  $Content = $X->trim($Content);

  #ровняем пробелы у block-level
  my $BlockRegExp = '('.(join "|", @BlockLevel).')';
  $Content =~ s#\s*(</?$BlockRegExp[^>]*>)\s*#$1#gi;

  my $XMLDoc = XML::LibXML->new(
      expand_entities => 0, # не считать & за entity
      no_network => 1, # не будем тянуть внешние вложения
      recover => ($X->{'verbose'} && $X->{'verbose'} > 1 ? 1 : 2), # не падать при кривой структуре. например, не закрыт тег. entity и пр | => 1 - вопить, 2 - совсем молчать
      load_ext_dtd => 0, # полный молчок про dtd
  );

  my $NodeDoc = $XMLDoc->parse_string('<root_fb3_container>'.$Content.'</root_fb3_container>') || $X->Error("Can't parse! ".$!);

  my $RootEl = $NodeDoc->getDocumentElement;
  my $Result = &ProcNode($X,$RootEl,$File,'root_fb3_container');

  return {
    content => $X->NormalizeTree($Result),
    ID => $X->Path2ID($File,undef,'main_section'), #main-sectioon
    ID_SUB => $X->UUID(), #sub-section
  };
}

sub NormalizeTree {
  my $X = shift;
  my $Data = shift;
  
  return unless ref $Data eq 'ARRAY';

  my @Ar;
  foreach my $Item (@$Data) {

    if (ref $Item eq 'HASH') {
      foreach (keys %$Item) {
        $Item->{$_}->{'value'} = NormalizeTree($X,$Item->{$_}->{'value'})
          if ref $Item->{$_} eq 'HASH' && exists $Item->{$_}->{'value'};
      }
    }

    if (ref $Item eq 'ARRAY') {
    $Item = NormalizeTree($X,$Item);
     push @Ar, @$Item;
     next;
    }

    if (!ref $Item) {
      my $Str;
      unless ($Item =~ /^\s+$/) {
        $Str = $X->trim($Item);
      } else {
        $Str = $Item;
      }
      $Str =~ s/[\n\r]//g;
      next if $Str eq '';
    }

    push @Ar, $Item;
  }

  @$Data = @Ar;
  return \@Ar; 
}

sub ProcNode {
  my $X = shift;
  my $Node = shift;
  my $RelPath = shift;
  my $LastGoodParent = lc(shift);
  my @Dist;
 
  my %AllowElements = %{$X->{'allow_elements'}};
 
  foreach my $Child ( $Node->getChildnodes ) {

    my $ChildNodeName = lc($Child->nodeName);
  
    my $Allow = 1;
    
    if ($AllowElements{$ChildNodeName}->{'exclude_if_inside'}) { #проверка на вшивость 1
      $Allow = 0 if $X->NodeHaveInside($Child, $AllowElements{$ChildNodeName}->{'exclude_if_inside'});
    }

    if ($Allow) { #проверка на вшивость 2
      $Allow =
        ($Child->nodeName !~ /#text/i
        && exists $AllowElements{$LastGoodParent}
        && (
           # !$AllowElements{$LastGoodParent}->{'allow_elements_inside'} ||
            exists $AllowElements{$LastGoodParent}->{'allow_elements_inside'}->{$ChildNodeName}) )
        ? 1 : 0;
    }

    #если ноду прибиваем, нужно чтобы дочерние работали по правилам пэрент-ноды (она ведь теперь и есть пэрент для последующих вложенных)      
    my $GoodParent = $Allow ? $ChildNodeName : $LastGoodParent; #если нода прошла разрешение, то теперь она становится последней parent в ветке и далее равняемся на ее правила 
      
    #разрешенные атрибуты текущей ноды
    my $AllowAttributes =
      $Allow
      && exists $AllowElements{$ChildNodeName}->{'allow_attributes'}
      && $AllowElements{$ChildNodeName}->{'allow_attributes'}
      ? $X->NodeGetAllowAttributes($Child)
      : 0;
        
    if ($Allow && $AllowElements{$ChildNodeName}->{'processor'}) {
      $Child =  $AllowElements{$ChildNodeName}->{'processor'}->($X,'node'=>$Child, 'relpath'=>$RelPath, params=>$AllowElements{$ChildNodeName}->{'processor_params'});
    }
    
    my $NodeName = $Child->nodeName; #имя могло измениться процессором
        
    push @Dist, $NodeName =~ /#text/i
      ? unquot($X,$Child->toString) #текстовая нода
      :
        $Allow
        ? { #тэг в ноде выводим
          $NodeName => $AllowAttributes
            ? {attributes => ConvertIds($X,$X->NodeGetAllowAttributes($Child),$RelPath), 'value' => &ProcNode($X,$Child,$RelPath,$GoodParent)} # надо с атрибутами выводить
            : &ProcNode($X,$Child,$RelPath,$GoodParent), # дочку строим по упрощенной схеме ('value' не обязателен)  
          }
        :   &ProcNode($X,$Child,$RelPath,$GoodParent) # не выводим тэг, шагаем дальше строить дерево
        ;
  }

  return \@Dist;
}

sub NodeHaveInside {
  my $X = shift;
  my $Node = shift;
  my $Elements = shift;
  
  my %H = map {lc($_)=>1} @$Elements;
  
  foreach my $Child ( $Node->getChildnodes ) {
    if (exists $H{lc($Child->nodeName())}) {
      undef %H;
      return 1;
    }
  }
  
  undef %H;
  return 0;
}

sub ConvertIds {
  my $X = shift;
  my $Attributes = shift;
  my $RelPath = shift;

  #если есть рутовое имя, соорудим новый id-атрибут
  if ($RelPath && exists $Attributes->{'id'}) {
   my $Href = $RelPath."#".$Attributes->{'id'};
    #так же должны быть преобразованы <a href !!!
    my $Id = $X->Path2ID($Href,undef,'convert_id');
    $Attributes->{'id'} = 'link_'.$Id;
    $X->{'id_list'}->{$Attributes->{'id'}} = $Href;
  }

  return $Attributes;
}

sub Path2ID {
  my $X = shift;
  my $DestPath = shift || return undef; #Искомый путь
  my $LocalPath = shift || undef; #путь, относительно которого вычисляем Искомый
  my $Debug = shift;

  unless ($LocalPath) {
    $LocalPath = $X->{'ContentDir'}; #Если не указан, работаем от корневой папки с контентом
  } else {
    $LocalPath = dirname($X->RealPath($X->{'ContentDir'}.'/'.$LocalPath));
  }

  my $Link = $X->RealPath($LocalPath.'/'.$DestPath, $Debug);
  my $Path = $X->UUID($Link);

  return $Path;
}

sub RealPath {
  my $X = shift;
  my $Path = shift;
  my $Debug = shift;
  my $RealPath = undef;
  
  if ($RealPath = Cwd::realpath($Path)) {
    $RealPath =~ s/%20/ /g;
    my $RealPath2 = $RealPath;
    $RealPath2 =~ s/#.*$//g;
    $RealPath = undef if !-f $RealPath2 && !-d $RealPath2;
  }
  $X->Error("Wrong path!\n$! $Path".($Debug?' ('.$Debug.')':'')) unless $RealPath;
  return $RealPath;
}

sub NodeGetAllowAttributes {
  my $X = shift;
  my $Node = shift;

  my %AllowElements = %{$X->{'allow_elements'}};

  my %Attrs;
  my @Attrs = $Node->findnodes( "./@*");
  foreach my $Attr (@Attrs)  {
    $Attrs{$Attr->nodeName} = $Attr->value
    if
      (ref $AllowElements{$Node->nodeName}->{'allow_attributes'} eq 'ARRAY'
       && grep {$Attr->nodeName eq $_} @{$AllowElements{$Node->nodeName}->{'allow_attributes'}}
      );
  }

  return \%Attrs;
}

sub UUID {
  my $X = shift;
  my $Str = shift || '';
  return $Str ? lc(uuid_to_string(create_uuid(UUID_V5,$Str))) : lc(create_uuid_as_string(UUID_V4));
}

sub trim {
  my $X = shift;
  my $str = shift;
  $str =~ s/\t/ /g;
  $str =~ s/\s+/ /g;
  $str =~ s/^\s*//;
  $str =~ s/\s*$//;
  $str =~ s/^\t*//;
  $str =~ s/\t*$//;
  return $str;
}

sub trim_soft {
  my $X = shift;
  my $str = shift;
  $str =~ s/^\s*//;
  $str =~ s/\s*$//;
  $str =~ s/^\t*//;
  $str =~ s/\t*$//;
  return $str;
}

sub unquot {
  my $X = shift;
  my $str = shift;

  $str =~ s/&amp;/&/g;
  $str =~ s/&lt;/</g;
  $str =~ s/&gt;/>/g;
  $str =~ s/&guot;/"/g;
  $str =~ s/&apos;/'/g;

  return $str; 
}

sub quot {
  my $X = shift;
  my $str = shift;

  $str  =~ s/&amp;/&/g;
  $str  =~ s/&/&amp;/g;
  $str  =~ s/&nbsp;/ /g;
  $str  =~ s/</&lt;/g;
  $str  =~ s/>/&gt;/g;
  $str  =~ s/"/&quot;/g;
  $str  =~ s/"/&apos;/g;

  return $str;
}

sub qent {
  my $X = shift;
  my $Str = shift;

  $Str =~ s/&#(0+)?60;/&lt;/g;
  $Str =~ s/&#(0+)?62;/&gt;/g;
  $Str =~ s/&#x(0+)?3e;/&gt;/gi;
  $Str =~ s/&#x(0+)?3c;/&lt;/gi;

  $Str =~ s/&#(0+)?38;/&amp;/g;
  $Str =~ s/&#x(0+)?26;/&amp;/g;

  $Str =~ s/&#(0+)?34;/&quot;/g;
  $Str =~ s/&#x(0+)?22;/&quot;/g;

  $Str =~ s/&#(0+)?39;/&apos;/g;
  $Str =~ s/&#x(0+)?27;/&apos;/g;

  XML::Entities::_decode_entities($Str, $AllEntities, 0);
  $Str =~ s/&(?!amp;|quot;|apos;|lt;|gt;)/&amp;/gi;
  return $Str;
}

sub html_trim {
  my $X = shift;
  my $str = shift;
  
  $str = quot($X,trim($X,$str));
 
  return $str;
}

sub EraseTags {
  my $X = shift;
  my $str = shift;
  $str =~ s/<.*?>//g;
  return $str;
}

# <= string, [type (i|w|e) ]
sub Msg {
  my $X = shift;
  my $Str = shift;
  my $Type = shift || 'i';
  my $Force = shift;

  return if !$X->{'verbose'} && $Type ne 'e' && !$Force;

  my $Color;
  if ($Type eq 'w') {
    $Color = "bold green";
  } elsif ($Type eq 'e') {
    $Color = "bold red";
  }

  print color($Color) if $Color;
  print $Str;
  print color('reset') if $Color;
}

sub Error {
  my $X = shift;
  my $ErrStr = shift;
  Msg($X,$ErrStr."\n",'e');
  Cleanup($X,1);
  exit;
}

#проверка валидности полученного FB3
sub Validate {
  my $X = shift;
  my %Args = @_;
  my $ValidateDir = $Args{'path'};
  my $XsdPath = $Args{'xsd'};
  
  $X->Msg("Validate result\n");
  my $Valid = FB3::Validator->new( $XsdPath );
  return $Valid->Validate($ValidateDir||$X->{'DestinationDir'});
}

sub Cleanup {
  my $X = shift;
  my $CleanDest = shift;
  
  if ($X->{'unzipped'} && $X->{'SourceDir'}) { #если наследили распаковкой в tmp
    ForceRmDir($X,$X->{'SourceDir'});
    Msg($X,"Clean tmp directory ".$X->{'SourceDir'}."\n");
  }
  
  #просят почистить результат
  if ($CleanDest) {
    ForceRmDir($X,$X->{'DestinationDir'}) if $X->{'DestinationDir'};
  }
  
}

sub ForceRmDir{
  my $X = shift;
  my $DirToClean=shift;
	return unless -e $DirToClean;
	my @FilesToKill;
	opendir(INPUT_FOLDER, $DirToClean);
	for (readdir(INPUT_FOLDER)){
		next if /\A\.\Z|(\A\.\.\Z)/;
		if (-d "$DirToClean/$_"){
			ForceRmDir($X,"$DirToClean/$_")
		} else {
			push (@FilesToKill, $_)
		}
	}
	closedir(INPUT_FOLDER);
	for (@FilesToKill){
		unlink "$DirToClean/$_" or warn "error '$!' deleting file '$DirToClean/$_'"
	}
	rmdir($DirToClean) or $X->Error("Error removing dir $DirToClean!\n$!");
}

sub Reaper {
  print "This method in package " . __PACKAGE__ . " and not defined in Processor class\n";
}

sub TransformTable2Valid {
  my $X = shift;
  my %Args = @_;
  my $Node = $Args{'node'};

  foreach my $TH ($Node->findnodes('./tr/th')) {
    $TH->addChild(XML::LibXML::Text->new('')) unless $TH->getChildnodes;
    $X->Transform2Valid(node=>$TH);
  }
  foreach my $TD ($Node->findnodes('./tr/td')) {
    $TD->addChild(XML::LibXML::Text->new('')) unless $TD->getChildnodes;
    $X->Transform2Valid(node=>$TD);
  }

  return $Node;
}

sub Transform2Valid {
  my $X = shift;
  my %Args = @_;
  my $Node = $Args{'node'};

  my $NewNode = XML::LibXML::Element->new($Node->nodeName); #будем собирать новую ноду
  foreach ($Node->getAttributes) { #скопируем атрибуты
    $NewNode->setAttribute($_->name => $_->value);
  }

  my $Wrap = XML::LibXML::Element->new("p");

  foreach my $Child ($Node->getChildnodes) {
    if ($Child->nodeName =~ /^(p|table|ul|ol|title|subtitle|section)$/) {
      if ($Wrap->hasChildNodes) {
        #закроем текуший враппер и создадим новый
        $NewNode->addChild($Wrap->cloneNode(1));
        $Wrap = XML::LibXML::Element->new("p") if $Wrap->hasChildNodes;
      }
      #на текущие ноды не применяем враппер
      $NewNode->addChild($Child->cloneNode(1));
      next;
    }

    # остальные в <p>node</p>
    $Wrap->addChild($Child->cloneNode(1));

  }

  #закрываем остатки враппера
  $NewNode->addChild($Wrap->cloneNode(1)) if $Wrap->hasChildNodes;

  $Node->replaceNode($NewNode);
  return $Node;
}

sub BuildOuterMeta {
  my $X = shift;
  my %Args = @_;

  my $Meta = $Args{'meta'};

  my $ID = $Meta->{'id'};
  my $LANGUAGE = $Meta->{'language'};
  my $TITLE = $Meta->{'title'};
  my $ANNOTATION = $Meta->{'annotation'};
  my $GENRES = $Meta->{'genres'};
  my $AUTHORS = $Meta->{'authors'};
  my $DATE = $Meta->{'date'};

  my $MetaFile = $X->{'metadata'} if -s $X->{'metadata'};
	if (-s $MetaFile) {
    my $xpc = XML::LibXML::XPathContext->new($Parser->load_xml(
      location =>  $MetaFile,
      expand_entities => 0,
      no_network => 1,
      load_ext_dtd => 0
    ));
    $xpc->registerNs('fbd', &NS_FB3_DESCRIPTION);
		$ID = ($xpc->findnodes('/fbd:fb3-description')->[0])->getAttribute('id');
	};

  my $DESCRIPTION = $X->{'STRUCTURE'}->{'DESCRIPTION'};

  $DESCRIPTION->{'DOCUMENT-INFO'}->{'ID'} = $ID if defined $ID;
  $DESCRIPTION->{'DOCUMENT-INFO'}->{'LANGUAGE'} = $LANGUAGE if defined $LANGUAGE;
  $DESCRIPTION->{'DOCUMENT-INFO'}->{'DATE'} = {'attributes'=>{'value'=>$DATE}} if defined $DATE;
  $DESCRIPTION->{'TITLE-INFO'}->{'BOOK-TITLE'} = $TITLE if defined $TITLE;
  $DESCRIPTION->{'TITLE-INFO'}->{'ANNOTATION'} = $ANNOTATION if defined $ANNOTATION;

  $DESCRIPTION->{'TITLE-INFO'}->{'GENRES'} = [ map { trim($X,$_) } split /,/,$GENRES ] if defined $GENRES;
  $DESCRIPTION->{'TITLE-INFO'}->{'AUTHORS'} = [ map { BuildAuthorName($X,$_) } split /,/,$AUTHORS ] if defined $AUTHORS;

}

sub BuildAuthorName  {
  my $X = shift;
  my ($FirstName, $MiddleName, $LastName) = split /\s/,shift,3;
  unless ($LastName) {
    $LastName = $MiddleName;
    $MiddleName =  undef;
  }

  return {
    'id' => UUID(),
    'first-name' => $FirstName,
    'middle-name' => $MiddleName,
    'last-name' => $LastName,
  };
}

sub EncodeUtf8 {
  my $X = shift;
  my $Out = shift;
  $Out = Encode::encode_utf8($Out);
  return $Out;
}

sub IsEmptyLineValue {
  my $X = shift;
  my $Item = shift;
  return 0 unless ref $Item eq 'ARRAY';
  
  return 1 if (!scalar @$Item || (scalar @$Item == 1 && $Item->[0] =~ /^[\s\t\n\r]+$/) );
  return 0;
}

sub CutLinkDiez {
  my $X = shift;
  my $Str = shift;
  $Str =~ s/^#//;
  return $Str;
}

sub CorrectOuterLink{
  my $X = shift;
  my $Str = shift;

  unless ($Str =~ /^(http|https|mailto|ftp)\:(.+)/i) {
    $X->Msg("Find not valid Link and delete [$Str]\n");
    return "";
  }

  my $Protocol = $1;
  my $Link = $2;
  $Link = $X->trim_soft($Link);

  if ($Protocol eq 'mailto') {
    unless (ValidEMAIL($Link)) {
      $X->Msg("Find not valid Email and delete [".$Protocol.":".$Link."]\n");
      return "";
    }
  } else {
    unless (ValidURL($Protocol.':'.$Link)) {
      $X->Msg("Find not valid URL and delete [".$Protocol.":".$Link."]\n");
      return "";
    }
  }

  return $Protocol.':'.$Link;
}

sub ValidURL{
  my $Url=shift;
  return 0 unless $Url;
  return 0 if length($Url)>300;

  my $RegExp =
  '^(https|http|ftp):\/\/'.                                  # protocol
  '(([a-z0-9$_\.\+!\*\'\(\),;\?&=-]|%[0-9a-f]{2})+'.         # username
  '(:([a-z0-9$_\.\+!\*\'\(\),;\?&=-]|%[0-9a-f]{2})+)?'.      # password
  '@)?(?#'.                                                  # auth requires @
  ')((([a-z0-9]\.|[a-z0-9][a-z0-9-]*[a-z0-9]\.)*'.           # domain segments AND
  '[a-z][a-z0-9-]*[a-z0-9]'.                                 # top level domain  OR
  '|((\d|[1-9]\d|1\d{2}|2[0-4][0-9]|25[0-5])\.){3}'.
  '(\d|[1-9]\d|1\d{2}|2[0-4][0-9]|25[0-5])'.                 # IP address
  ')(:\d{1,5})?'.                                            # port
  ')(((\/+([a-z0-9$_\.\+!\*\'\(\),;:@&=-]|%[0-9a-f]{2})*)*'. # path
  '(\?([a-z0-9$_\.\+!\*\'\(\),;:@&=-]|%[0-9a-f]{2})*)'.      # query string
  '?)?)?'.                                                   # path and query string optional
  '(#([a-z0-9$_\.\+!\*\'\(\),;:@&=-]|%[0-9a-f]{2})*)?'.      # fragment
  '$';
	
  return $Url=~/$RegExp/i;
}

sub ValidEMAIL{
  my $Email=shift;
  return 0 unless $Email;
  return 0 if length($Email)>50;
  return $Email=~ /^[-+a-z0-9_]+(\.[-+a-z0-9_]+)*\@([-a-z0-9_]+\.)+[a-z]{2,10}$/i;
}

sub ShitFixFile {
  my $X = shift;
  my $Fname = shift;

  my $Content;
  open my $Fo,"<".$Fname or $X->Error("Can't open file $Fname: $!");
  map {$Content.=$_;} <$Fo>;
  close $Fo;

  $Content = $X->ShitFix($Content); 

  open my $Fs,">".$Fname or $X->Error("Can't open file $Fname: $!");
  print $Fs $Content;
  close $Fs;
}

sub MetaFix {
  my $X = shift;
  my $Str = shift;
  # закрываем то, что в html не обязано
  $Str =~ s/<\s*\/\s*(meta|link)\s*>//gi;
  $Str =~ s/(<(meta|link|img)[^>]+?)\s*?(\/?\s*?)>/$1\/>/g;

  return $Str;
}

#phantomjs любит превращать кое-что в нечитаемое для Libxml
sub SomeFix {
  my $X = shift;
  my $Str = shift;

  $Str =~ s/<\s*[bB][rR]\s*>/<br\/>/g; # <br> => <br/>

  return $Str;
}


sub ShitFix {
  my $X = shift;
  my $Str = shift;
  # /i здесь вызывает невероятные тормоза к сожалению
  $Str =~ s#<([iI][mM][gG]) ([^>]+?/?)>\s*</\1>#<img $2>#g; # <img> </img> => <img/>t

  #DOM такое не любит
  $Str =~ s/<([aA])([^>]*?)\/\s*>/<$1$2><\/$1>/g; # <a/> => <a></a>
  $Str =~ s/<([dD][iI][vV])([^>]*?)\/\s*>/<$1$2><\/$1>/g; # <div/> => <div></div>

  $Str = $X->SomeFix($Str);
  $Str = $X->MetaFix($Str);

  return $Str;
}

sub ParseMetaFile {
  my $X = shift;

  my $MetaFile = $X->{'metadata'} if -f $X->{'metadata'};

  if ($MetaFile) {

    my $DESCRIPTION = $X->{'STRUCTURE'}->{'DESCRIPTION'};
 
    Msg($X,"Parse metafile ".$MetaFile."\n");
    my $xpc = XML::LibXML::XPathContext->new($Parser->load_xml(
      location => $MetaFile,
      expand_entities => 0,
      no_network => 1,
      load_ext_dtd => 0
    ));
    $xpc->registerNs('fbd', &NS_FB3_DESCRIPTION);

    my $ID = ($xpc->findnodes('/fbd:fb3-description')->[0])->getAttribute('id');
    $DESCRIPTION->{'DOCUMENT-INFO'}->{'ID'} = $ID if defined $ID;

    my $TITLE = $xpc->findnodes('/fbd:fb3-description/fbd:title/fbd:main')->[0]->string_value;
    $DESCRIPTION->{'TITLE-INFO'}->{'BOOK-TITLE'} = $TITLE if defined $TITLE;

    my $ANNOTATION = $xpc->findnodes('/fbd:fb3-description/fbd:annotation/fbd:p')->[0]->string_value;;
    $DESCRIPTION->{'TITLE-INFO'}->{'ANNOTATION'} = $ANNOTATION if defined $ANNOTATION;

    my $LANGUAGE = $xpc->findnodes('/fbd:fb3-description/fbd:lang')->[0]->string_value; 
    $DESCRIPTION->{'DOCUMENT-INFO'}->{'LANGUAGE'} = $LANGUAGE if defined $LANGUAGE;

    my @GENRES = map {$_->string_value} ($xpc->findnodes('/fbd:fb3-description/fbd:fb3-classification/fbd:subject'));
    $DESCRIPTION->{'TITLE-INFO'}->{'GENRES'} = [ @GENRES ];

    my @AUTHORS;
    foreach my $Subject ($xpc->findnodes('/fbd:fb3-description/fbd:fb3-relations/fbd:subject')) {
      my $SubjID = $Subject->getAttribute("id");
      my $SubjLink = $Subject->getAttribute("link");
      my $SubjPercent = $Subject->getAttribute("percent");
      my $SubjNAME = $Subject->getElementsByTagName("main");

      my ($FirstName, $MiddleName, $LastName) = split /\s+/, $SubjNAME, 3;

      unless ($LastName) {
        $LastName = $MiddleName;
        $MiddleName =  undef;
      }

      push @AUTHORS, {
        'id' => $SubjID,
        'link' => $SubjLink,
        'percent' => $SubjPercent,
        'first-name' => $FirstName,
        'middle-name' => $MiddleName,
        'last-name' => $LastName,
      };
    }
    $DESCRIPTION->{'TITLE-INFO'}->{'AUTHORS'} = [ @AUTHORS ];

  }

}

### BENCHMARK

#Точка старта
sub _bs {
  my $X = shift;
  my $Key = shift;
  my $Desc = shift || undef;
  return if ( !(exists $X->{'bench'} && $X->{'bench'}) && !(exists $X->{'bench2file'} && $X->{'bench2file'}) );

  $X->Error("Bench: _bs(); key not defined in string format") unless $Key;
  $X->Error("Bench: _bs(): Key is not a string") if ref $Key;

    $X->{'bench_list'}->{$Key} = {
      'desc' => $Desc,
      'timers' => []
    } unless exists $X->{'bench_list'}->{$Key};
  
  my $Timers = $X->{'bench_list'}->{$Key}->{'timers'};

  if (@$Timers) {
    $X->Error("Bench: last timer don't closed with X->_be('$Key') function")
      if exists $Timers->[scalar @$Timers - 1]->{'start'} && !exists $Timers->[scalar @$Timers - 1]->{'end'};
  }

  my $ts = gettimeofday();
  push @$Timers, {
    'start' => $ts,
  };
}

#Точка окончания
sub _be {
  my $X = shift;
  my $Key = shift;
  return if ( !(exists $X->{'bench'} && $X->{'bench'}) && !(exists $X->{'bench2file'} && $X->{'bench2file'}) );

  $X->Error("Bench: _be(); key not defined in string format") unless $Key;
  $X->Error("Bench: _be(): Key is not a string") if ref $Key;

  $X->Error("Bench: _be(); Key '$Key' not exists. Do you make X->_bs($Key)??") unless exists $X->{'bench_list'}->{$Key};

  my $Timers = $X->{'bench_list'}->{$Key}->{'timers'};
  $X->Error("Bench: _be(): Can't close timer. Two o more calls of _be($Key)??")
    if exists $Timers->[scalar @$Timers - 1]->{'end'};
  my $te = gettimeofday();
  $Timers->[scalar @$Timers - 1]->{'end'} = $te;
}

#Сброс статистики
sub _bf {
  my $X = shift;
  return if ( !(exists $X->{'bench'} && $X->{'bench'}) && !(exists $X->{'bench2file'} && $X->{'bench2file'}) );

  my $Out = "BENCHMARK ".localtime().":\n\n";

  foreach my $Key (sort keys %{$X->{'bench_list'}}) {
    my $Item = $X->{'bench_list'}->{$Key};
    my $Cnt = scalar @{$Item->{'timers'}};
    my $Summ=0;
    $Out .= "[key: '$Key'] ";
    $Out .= "[cnt: $Cnt] ";
    foreach my $t ( @{$Item->{'timers'}} ) {
      $Summ += ($t->{'end'} - $t->{'start'});
    }
    $Out .= "[time: ".sprintf('%.4f',$Summ)." sec] ";
    $Out .= "[avg: ".sprintf('%.4f',$Summ/$Cnt)." sec]\n";
    $Out .= "desc: ".$Item->{'desc'}."\n\n" if $Item->{'desc'};
  }

  $X->{'bench_list'} = {};

  $X->Msg("\n".$Out,'w',1) if $X->{'bench'};

  if ($X->{'bench2file'}) {
    open my $F,">>:utf8",$X->{'bench2file'} or $X->Error($!);
    print $F $Out;
    close $F;
  }

}


=head1 LICENSE AND COPYRIGHT

Copyright (C) 2018 Litres.ru

The GNU Lesser General Public License version 3.0

FB3::Convert is free software: you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3.0 of the License.

FB3::Convert is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
License for more details.

Full text of License L<http://www.gnu.org/licenses/lgpl-3.0.en.html>.

=cut

  
1;
