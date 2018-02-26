package GFwxFrame;
   
   use strict;
   use warnings;

   our $VERSION = '0.052';
   
   use Exporter 'import';
   our @EXPORT_OK      = qw<addButton addStatText addTextCtrl addMenuBits addPanel setScale>;
   
   use Wx qw(wxMODERN wxTE_PASSWORD wxTE_PROCESS_ENTER wxDEFAULT wxNORMAL
          wxFONTENCODING_DEFAULT wxTE_MULTILINE wxHSCROLL wxDefaultPosition wxFD_SAVE
          wxYES wxFD_OPEN wxFD_FILE_MUST_EXIST wxFD_CHANGE_DIR wxID_CANCEL
          wxYES_NO wxCANCEL wxOK  wxCENTRE  wxICON_EXCLAMATION  wxICON_HAND 
          wxICON_ERROR  wxICON_QUESTION  wxICON_INFORMATION);
          
   use Wx::Event qw( EVT_BUTTON EVT_TEXT_ENTER EVT_UPDATE_UI EVT_MENU);
   use Wx::Perl::Imagick;                 #for image panels
   
   use base qw(Wx::Frame); # Inherit from Wx::Frame
   
   # these arrays will contain the widgets each as an arrayref of the parameters
   my @buttons=();
   my @textctrls=();
   my @stattexts=();
   my @menu=();
   my @subpanels=();
   my %styles;
   
   my $lastMenuLabel;  #bug workaround in menu generator
   
   my $winScale=8;
   my $font = Wx::Font->new(     3*$winScale,
                                wxDEFAULT,
                                wxNORMAL,
                                wxNORMAL,
                                0,
                                "",
                                wxFONTENCODING_DEFAULT);
   
   sub new
   {
    my $class = shift;    
    my $self = $class->SUPER::new(@_);  # call the superclass' constructor
    
    # Then define a Panel to put the content on
    my $panel = Wx::Panel->new( $self,-1); # parent, id
    setupContent($self,$panel);  #then add content
    return $self;
   }
   
   sub setupContent{
	   my ($self,$panel)=@_;
	   
       foreach my $button  (@buttons){
		   aBt($self, $panel, @$button)
	   }
	   foreach my $textctrl (@textctrls){
		   aTC($self,$panel,@$textctrl)
	   }
	   foreach my $stattxt (@stattexts){
		   aST($self,$panel,@$stattxt)
	   }
	   if (scalar @menu){   #menu exists
		   $self ->{"menubar"} = Wx::MenuBar->new();
		   $self->SetMenuBar($self ->{"menubar"});
		   my $currentMenu;
		   foreach my $menuBits (@menu){ 
			  $currentMenu=aMB($self,$panel,$currentMenu,@$menuBits)
	       }
	       # a bug seems to make a menuhead to be also ia menuitem---

	   }
	   foreach my $sp (@subpanels){
		   aSP($self,$panel,@$sp);
	   }
	   
	   sub aMB{
	     my ($self,$panel,$currentMenu, $id, $label, $type, $action)=@_;
	     if (($lastMenuLabel) &&($label eq $lastMenuLabel)){return $currentMenu} # bug workaround 
	     else {$lastMenuLabel=$label};	                                         # in menu generator
	    
	     
	       if ($type eq "menuhead"){
			   $currentMenu="menu".$id;
			   $self ->{$currentMenu} =  Wx::Menu->new();
		       $self ->{"menubar"}->Append($self ->{$currentMenu}, $label);
		   }
		   elsif ($type eq "radio"){
			   $self ->{$currentMenu}->AppendRadioItem($id, $label);
			   EVT_MENU( $self, $id, $action )
		   }
		   elsif ($type eq "check"){
			   $self ->{$currentMenu}->AppendCheckItem($id, $label);
			   EVT_MENU( $self, $id, $action )
		   }
		   elsif ($type eq "separator"){
			   $self ->{$currentMenu}->AppendSeparator();
		   }
		   else{
			   if($currentMenu!~m/$label/){
			     $self ->{$currentMenu}->Append($id, $label);
			     EVT_MENU( $self, $id, $action )
			 }
		   }
		   # logging menu generator print "$currentMenu---$id----$label---$type\n";
		   return $currentMenu;
	   }
	   
       sub aBt{
	    my ($self,$panel, $id, $label, $location, $size, $action)=@_;
	    $self->{"btn".$id} = Wx::Button->new(     $panel,      # parent
                                        $id,             # ButtonID
                                        $label,          # label
                                        $location,       # position
                                        $size            # size
                                       );
        EVT_BUTTON( $self, $id, $action );  #object to bind to, buton id, and subroutine to call
        }
         
        sub aTC{
			 my ($self,$panel, $id, $text, $location, $size, $action)=@_;
			 $self->{"txtctrl".$id} = Wx::TextCtrl->new(
                                        $panel,
                                        $id,
                                        $text,
                                        $location,
                                        $size,
                                        wxTE_PROCESS_ENTER
                                        );
            EVT_TEXT_ENTER( $self, $id, $action );
		 }
         
         sub aST{
			  my ($self,$panel, $id, $text, $location)=@_;
			 $self->{"stattext".$id} = Wx::StaticText->new( $panel,             # parent
                                        $id,                  # id
                                        $text,                # label
                                        $location            # position
                                      );	
             $self->{"stattext".$id}->SetFont($font);		 
		 }
		 sub aSP{
			 my ($self,$panel, $id, $panelType, $content, $location, $size)=@_;
			 $self->{"subpanel".$id}= Wx::Panel->new( $panel,# parent
			                                         $id,# id
			                                         $location,
			                                         $size			                                         
			                                         ); 
			
			if ($panelType eq "I"){  # Image panels start with I
				$content=~s/^\s+|\s+$//g;
				if (! -e $content){ return; }
				no warnings;   # sorry about that...suppresses a "Useless string used in void context"
			    my $image = Wx::Perl::Imagick->new($content);
			    if ($image){
			      my $bmp;    # used to hold the bitmap.
			      my $geom=${$size}[0]."x".${$size}[1]."!";
			      $image->Resize(geometry => $geom);
			      $bmp = $image->ConvertToBitmap();
			        if( $bmp->Ok() ) {
                     $self->{"Image".($id+1)}= Wx::StaticBitmap->new($self->{"subpanel".$id}, $id+1, $bmp);
                    }
				 }
				 else {"print failed to load image $content \n";}
			 }
			if ($panelType eq "T"){  # handle
				$content=~s/^\s+|\s+$//g;
				
				$self->{"TextCtrl".($id+1)} = Wx::TextCtrl->new(
                   $self->{"subpanel".$id}, 
                   $id+1,
                   $content, 
                   wxDefaultPosition, 
                   $size, 
                   wxTE_MULTILINE|wxHSCROLL 
                  );
                $self->{"TextCtrl".($id+1)}->SetFont(Wx::Font->new(10, wxMODERN, wxNORMAL, wxNORMAL ));
			 }
		 }
   }
   
   sub addButton{
	   push (@buttons,shift );
   }
   sub addTextCtrl{
	   push (@textctrls,shift );
   }
   sub addStatText{
	   push (@stattexts,shift );
   }
   sub addMenuBits{
	   push (@menu, shift);
   }
    sub addPanel{
	   push (@subpanels, shift);
   }
   sub addStyle{
	   my ($name,$style)=@_;
	   $styles{$name}=$style;
   }
   
   sub setImage{
	   my ($self,$file,$id)=@_;
	   my $size=getPanelSize($self,$id);
	   if ($size){
	       my $image = Wx::Perl::Imagick->new($file);
		   if ($image){
			  my $bmp;    # used to hold the bitmap.
			  my $geom=${$size}[0]."x".${$size}[1]."!";
			      $image->Resize(geometry => $geom);
			      $bmp = $image->ConvertToBitmap();
			        if( $bmp->Ok() ) {
                     $self->{"Image".($id+1)}= Wx::StaticBitmap->new($self->{"subpanel".$id}, $id+1, $bmp);
                    }
				 }
				 else {"print failed to load image $file \n";}
			 }
		  else {print "Panel not found"}
			 
	   
   }
   sub setScale{
	   $winScale=shift;
	   $font = Wx::Font->new(     3*$winScale,
                                wxDEFAULT,
                                wxNORMAL,
                                wxNORMAL,
                                0,
                                "",
                                wxFONTENCODING_DEFAULT);	   
   }
   
   sub showFileSelectorDialog{
	 
     my ($self, $message,$load) = @_;
     my $loadOptions=wxFD_OPEN|wxFD_FILE_MUST_EXIST|wxFD_CHANGE_DIR;
     my $saveOptions=wxFD_SAVE|wxFD_CHANGE_DIR;
     my $fd = Wx::FileDialog->new( $self, $message, ".", q{},
				"All files|*|Data (*.dat)|*.dat",
				$load?$loadOptions:$saveOptions,
				wxDefaultPosition);
    if ($fd->ShowModal == wxID_CANCEL) {
      print "Data import cancelled\n";
      return;
    };
    return $fd->GetPath;

   };
   
   sub showDialog{
	   my ($self, $title, $message,$response,$icon) = @_;
	   my %responses=( YNC=>wxYES_NO|wxCANCEL|wxCENTRE,
	                   YN =>wxYES_NO|wxCENTRE,
	                   OK =>wxOK|wxCENTRE,
	                   OKC=>wxOK|wxCANCEL|wxCENTRE );
	                   
	   my %icons= (  "!"=>wxICON_EXCLAMATION,
	                 "?"=>wxICON_QUESTION,
	                 "E"=>wxICON_ERROR,
	                 "H"=>wxICON_HAND,
	                 "I"=>wxICON_INFORMATION );
	   $response=$response?$responses{$response}:wxOK|wxCENTRE;
	   $icon=$icon?$icons{$icon}:wxICON_INFORMATION;
	   my $answer= Wx::MessageBox( $message, 
                       $title, 
                       $response|$icon, 
                       $self);
       return (($answer==wxOK)||($answer==wxYES))
	   
   };
   
   sub getPanelSize{
	   my ($self,$id)=@_;
	   my $found=getPanel($self,$id);
	   return ( $found!=-1) ? $subpanels[$found][4]:0;
	   
   }
   sub getPanel{
	   my ($self,$id)=@_;
	   my $i=0; my $found=-1;
	   while ($i<@subpanels){
		   if ($subpanels[$i][0]==$id) {
			   $found=$i;
			   }
		   $i++;
	   }
	   return $found;
   }
   sub reSize{
	   my ($self,$id,$newSize)=@_;
	   
   }
   sub quit{
	   my ($self) = @_;
	   $self ->Close(1);
   }



