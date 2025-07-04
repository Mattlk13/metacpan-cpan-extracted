# automatically generated file, don't edit



# Copyright 2025 David Cantrell, derived from data from libphonenumber
# http://code.google.com/p/libphonenumber/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
package Number::Phone::StubCountry::HN;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20250605193635;

my $formatters = [
                {
                  'format' => '$1-$2',
                  'leading_digits' => '[237-9]',
                  'pattern' => '(\\d{4})(\\d{4})'
                },
                {
                  'format' => '$1 $2 $3',
                  'intl_format' => 'NA',
                  'leading_digits' => '8',
                  'pattern' => '(\\d{3})(\\d{4})(\\d{4})'
                }
              ];

my $validators = {
                'fixed_line' => '
          2(?:
            2(?:
              0[0-59]|
              1[1-9]|
              [23]\\d|
              4[02-7]|
              5[57]|
              6[245]|
              7[0135689]|
              8[01346-9]|
              9[0-2]
            )|
            4(?:
              0[578]|
              2[3-59]|
              3[13-9]|
              4[0-68]|
              5[1-3589]
            )|
            5(?:
              0[2357-9]|
              1[1-356]|
              4[03-5]|
              5\\d|
              6[014-69]|
              7[04]|
              80
            )|
            6(?:
              [056]\\d|
              17|
              2[067]|
              3[047]|
              4[0-378]|
              [78][0-8]|
              9[01]
            )|
            7(?:
              0[5-79]|
              6[46-9]|
              7[02-9]|
              8[034]|
              91
            )|
            8(?:
              79|
              8[0-357-9]|
              9[1-57-9]
            )
          )\\d{4}
        ',
                'geographic' => '
          2(?:
            2(?:
              0[0-59]|
              1[1-9]|
              [23]\\d|
              4[02-7]|
              5[57]|
              6[245]|
              7[0135689]|
              8[01346-9]|
              9[0-2]
            )|
            4(?:
              0[578]|
              2[3-59]|
              3[13-9]|
              4[0-68]|
              5[1-3589]
            )|
            5(?:
              0[2357-9]|
              1[1-356]|
              4[03-5]|
              5\\d|
              6[014-69]|
              7[04]|
              80
            )|
            6(?:
              [056]\\d|
              17|
              2[067]|
              3[047]|
              4[0-378]|
              [78][0-8]|
              9[01]
            )|
            7(?:
              0[5-79]|
              6[46-9]|
              7[02-9]|
              8[034]|
              91
            )|
            8(?:
              79|
              8[0-357-9]|
              9[1-57-9]
            )
          )\\d{4}
        ',
                'mobile' => '[37-9]\\d{7}',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '8002\\d{7}',
                'voip' => ''
              };
my %areanames = ();
$areanames{en} = {"5042671", "Yoro",
"5042888", "S\.\ Marcos\/Proy\.\ Ala",
"5042453", "Guanaja",
"5042691", "Morazán",
"5042675", "Villa\ Nueva",
"5042650", "San\ Manuel\/Rio\ Lindo",
"5042892", "Yuscarán",
"5042448", "Tela",
"5042637", "Santa\ Barbra",
"5042505", "Cortes",
"5042899", "Catacamas",
"5042423", "La\ Ceiba",
"5042516", "San\ Pedro\ Sula\,\ Cortés",
"5042778", "Centros\ Comunitarios",
"5042240", "Kennedy\,\ Tegucigalpa",
"5042552", "San\ Pedro\ Sula\,\ Cortés",
"5042674", "Sulaco\/Los\ Orcones",
"5042559", "Col\.\ Satélite",
"5042407", "Roatán\,\ Bay\ Islands",
"5042452", "Coyoles\ Central",
"5042244", "Tegucigalpa",
"5042893", "El\ Paraíso",
"5042459", "Atlantida",
"5042670", "Villa\ Nueva",
"5042566", "Jardines\ Del\ Valle",
"5042214", "Francisco\ Morazan",
"5042655", "Lepaera\/Corquín",
"5042446", "Olanchito",
"5042769", "Guaimaca",
"5042690", "El\ Negrito",
"5042651", "Cucuyagua\/Copán",
"5042783", "La\ Esperanza",
"5042215", "Francisco\ Morazan",
"5042657", "El\ Naranjo\ Sta\ Bárbara",
"5042654", "Santa\ Cruz",
"5042553", "San\ Pedro\ Sula\,\ Cortés",
"5042211", "El\ Picacho",
"5042776", "Zamorano",
"5042281", "Francisco\ Morazan",
"5042433", "Arenal",
"5042405", "Atlantida",
"5042429", "San\ Alejo\/Mesapa",
"5042245", "La\ Vega\,\ Tegucigalpa",
"5042435", "Oakridge",
"504270", "Olancho",
"5042283", "Francisco\ Morazan",
"5042431", "San\ Francisco\,\ Atlántida",
"5042897", "San\ Fco\.\ De\ Becerra",
"5042894", "Amatillo\/Goascorán",
"5042213", "Telef\.\ Inalámbrica\ Tegucig\.",
"5042551", "Monte\ Prieto",
"5042555", "Rivera\ Hernandez\,\ San\ Pedro\ Sula",
"5042570", "Cortes",
"5042784", "La\ Libertad",
"5042653", "Nueva\ Ocotepeque",
"5042557", "San\ Pedro\ Sula\,\ Cortés",
"5042236", "Almendros",
"5042554", "Monte\ Prieto",
"5042502", "Cortes",
"5042434", "Trujillo",
"5042228", "Kennedy\,\ Tegucigalpa",
"5042648", "Progreso\/Santa\ Cruz",
"5042891", "S\.\ Franc\.\ De\ La\ Paz",
"5042672", "Cofradía",
"5042895", "Nacaome\/Amapala",
"504268", "La\ Lima",
"5042242", "Francisco\ Morazan",
"5042550", "San\ Pedro\ Sula\,\ Cortés",
"5042219", "Francisco\ Morazan",
"5042764", "Amarat\/Marcala",
"5042780", "Choluteca",
"5042767", "Ojojona",
"5042212", "Rdsi\ Tegucigalpa\ \(Pri3\)",
"5042425", "Utila\,\ Bay\ Islands",
"504261", "Choloma\,\ Cortés",
"5042238", "Principal",
"5042424", "Sabá",
"5042652", "Agua\ Caliente",
"5042503", "Cortes",
"5042455", "French\ Harbour",
"5042659", "El\ Mochito\/Quimistán",
"5042574", "Búfalo",
"5042673", "Potrerillos",
"5042226", "Loarque",
"5042451", "Sonaguera",
"5042458", "Atlantida",
"5042883", "Danli",
"5042768", "Sabana\ Grande",
"5042443", "La\ Ceiba",
"5042235", "Miraflores",
"5042203", "Polo\ Paz",
"5042220", "Principal",
"5042231", "Miraflores",
"5042640", "C\.\ Comunitarios",
"5042234", "Toncontín",
"5042556", "La\ Puerta",
"5042237", "Principal",
"5042773", "Siguatepeque",
"5042512", "San\ Pedro\ Sula\,\ Cortés",
"5042436", "La\ Masica",
"504287", "Choluteca",
"5042291", "Toncontin",
"5042766", "Valle\ De\ Ángeles",
"5042882", "Choluteca",
"5042209", "Res\.\ Centro\ América\,\ Tegucigalpa",
"5042225", "La\ Granja",
"5042221", "Almendros",
"5042230", "Kennedy\,\ Tegucigalpa",
"5042569", "Cortes",
"5042898", "Domsat",
"5042641", "C\.\ Comunitarios",
"5042442", "La\ Ceiba",
"5042889", "Campamento",
"5042202", "Tegucigalpa",
"5042257", "Prados\ Universitarios",
"5042255", "El\ Hato",
"5042772", "Comayagua",
"5042558", "San\ Pedro\ Sula\,\ Cortés",
"5042513", "Cortes",
"5042290", "Toncontin",
"5042438", "Bonito\ Oriental",
"5042227", "Res\.\ Centro\ América\,\ Tegucigalpa",
"5042224", "Cerro\ Grande",
"5042779", "Santa\ Lucía",
"5042647", "Progreso",
"5042543", "Inalámbrica\ Sps",
"5042545", "San\ Pedro\ Sula\,\ Cortés",
"5042770", "Comayagua",
"5042218", "Francisco\ Morazan",
"5042511", "Cortes",
"5042515", "Cortes",
"5042232", "Miraflores",
"5042658", "Macueliso\ Omoa\/Trascerros",
"5042880", "Choluteca",
"5042239", "Miraflores",
"5042223", "Polo\ Paz",
"5042643", "Santa\ Bárbara",
"5042440", "La\ Ceiba",
"5042544", "Rdsi\ San\ Pedro\ Sula",
"5042200", "Polo\ Paz",
"5042887", "Proyecto\ Ala",
"5042246", "La\ Vega\,\ Tegucigalpa",
"5042540", "San\ Pedro\ Sula\,\ Cortés",
"5042204", "Francisco\ Morazan",
"5042444", "Tocoa\,\ Colón",
"5042775", "Talanga",
"5042216", "Rdsi\ Tegucigalpa\ \(Pri3\)",
"5042564", "San\ Pedro\ Sula\,\ Cortés",
"5042229", "El\ Ocotal",
"5042233", "Toncontín",
"5042445", "Coxin\ Hole\,\ Roatán",
"5042777", "Proyecto\ Ala",
"5042774", "La\ Paz",
"5042201", "Polo\ Paz",
"5042565", "Chamelecón",
"5042656", "Gracias\/S\.R\.Copán",
"5042222", "Principal",
"5042885", "Juticalpa",
"5042642", "C\.\ Comunitarios",
"5042678", "Potrerillos",
"5042881", "San\ Lorenzo",};
my $timezones = {
               '' => [
                       'America/Tegucigalpa'
                     ]
             };

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+504|\D)//g;
      my $self = bless({ country_code => '504', number => $number, formatters => $formatters, validators => $validators, timezones => $timezones, areanames => \%areanames}, $class);
        return $self->is_valid() ? $self : undef;
    }
1;