# automatically generated file, don't edit



# Copyright 2011 David Cantrell, derived from data from libphonenumber
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
package Number::Phone::StubCountry::GY;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20201204215956;

my $formatters = [
                {
                  'format' => '$1 $2',
                  'leading_digits' => '[2-46-9]',
                  'pattern' => '(\\d{3})(\\d{4})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            2(?:
              1[6-9]|
              2[0-35-9]|
              3[1-4]|
              5[3-9]|
              6\\d|
              7[0-24-79]
            )|
            3(?:
              2[25-9]|
              3\\d
            )|
            4(?:
              4[0-24]|
              5[56]
            )|
            77[1-57]
          )\\d{4}
        ',
                'geographic' => '
          (?:
            2(?:
              1[6-9]|
              2[0-35-9]|
              3[1-4]|
              5[3-9]|
              6\\d|
              7[0-24-79]
            )|
            3(?:
              2[25-9]|
              3\\d
            )|
            4(?:
              4[0-24]|
              5[56]
            )|
            77[1-57]
          )\\d{4}
        ',
                'mobile' => '6\\d{6}',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '(9008\\d{3})',
                'toll_free' => '
          (?:
            289|
            862
          )\\d{4}
        ',
                'voip' => ''
              };
my %areanames = ();
$areanames{en} = {"592277", "Zeeburg\/Uitvlugt",
"592325", "Mibikuri\/No\:\ 34\/Joppa\/Brighton",
"592221", "Mahaicony",
"592265", "Diamond",
"592777", "Mabaruma\/Port\ Kaituma",
"592264", "Vreed\-en\-Hoop",
"592330", "Rosignol\/Shieldstown",
"592455", "Bartica",
"592233", "Agricola\/Houston\/Eccles\/Nandy\ Park",
"592276", "Anna\ Catherina\/\ Cornelia\ Ida\/Hague\/Fellowship",
"592222", "B\/V\ West",
"592326", "Adelphi\/Fryish\/No\.\ 40",
"592444", "Linden\/Canvas\ City\/Wisroc",
"592266", "New\ Hope\/Friendship\/Grove\/Land\ of\ Canaan",
"592775", "Matthews\ Ridge",
"592267", "Wales",
"592258", "Planters\ Hall\/Mortice",
"592456", "Mahdia",
"592338", "Benab\/No\.\ 65\ Village\/Massiah",
"592275", "Met\-en\-Meer\-Zorg",
"592327", "Blairmont\/Cumberland",
"592274", "Vigilance",
"592229", "Enterprise\/Cove\ \&\ John",
"592331", "Adventure\/Joanna",
"592217", "Mocha",
"592234", "B\/V\ Central",
"592216", "Diamond\/Grove",
"592220", "B\/V\ Central",
"592773", "Aishalton",
"592332", "Sheet\ Anchor\/Susannah",
"592339", "No\:\ 52\/Skeldon",
"592259", "Clonbrook\/Unity",
"592228", "Mahaica\/Belmont",
"592272", "B\/V\ West",
"592333", "New\ Amsterdam",
"592253", "La\ Grange\/Goed\ Fortuin",
"592772", "Lethem",
"592218", "Georgetown\ \(S\/R\/Veldt\)",
"592225", "Georgetown",
"592261", "Timehri\/Long\ Creek\/Soesdyke",
"592442", "Christianburg\/Amelia\’s\ Ward",
"592279", "Good\ Hope\/Stanleytown",
"592329", "Willemstad\/Fort\ Wellington\/Ithaca",
"592227", "Georgetown",
"592271", "Canal\ No\.\ 1\/Canal\ No\.\ 2",
"592269", "Windsor\ Forest",
"592441", "Ituni",
"592262", "Parika",
"592226", "Georgetown",
"592322", "Kilcoy\/Hampshire\/Nigg",
"592223", "Georgetown",
"592260", "Tuschen\/Parika",
"592254", "New\ Road\/Best",
"592334", "New\ Amsterdam",
"592255", "Paradise\/Golden\ Grove\/Haslington",
"592335", "Crabwood\ Creek\/No\:\ 76\/Corentyne",
"592219", "Georgetown\,Sophia",
"592231", "Georgetown",
"592328", "Cottage\/Tempe\/Onverwagt\/Bath\/Waterloo",
"592440", "Kwakwani",
"592268", "Leonora",
"592257", "Cane\ Grove\/Strangroen",
"592337", "Whim\/Bloomfield\/Liverpool\/Rose\ Hall",
"592336", "Edinburg\/Port\ Mourant",
"592232", "Novar\/Catherine\/Belladrum\/Bush\ Lot",
"592256", "Victoria\/Hope\ West",
"592270", "Melanie\/Non\ Pariel\/Enmore",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+592|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
        return $self->is_valid() ? $self : undef;
    }
1;