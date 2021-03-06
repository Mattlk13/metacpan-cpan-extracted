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
package Number::Phone::StubCountry::AO;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20201204215954;

my $formatters = [
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '[29]',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{3})'
                }
              ];

my $validators = {
                'fixed_line' => '
          2\\d(?:
            [0134][25-9]|
            [25-9]\\d
          )\\d{5}
        ',
                'geographic' => '
          2\\d(?:
            [0134][25-9]|
            [25-9]\\d
          )\\d{5}
        ',
                'mobile' => '9[1-49]\\d{7}',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '',
                'voip' => ''
              };
my %areanames = ();
$areanames{en} = {"2442536", "Lunda\ Sul",
"244235", "Cuanza\ Norte",
"2442726", "Bela\ Vista",
"244251", "Malange",
"244249", "Cuando\ Cubango",
"2442542", "Moxico",
"2442655", "Ondjiva",
"2442616", "Huila",
"2442485", "Kuito",
"2442321", "Soyo",
"244236", "Cuanza\ Sul",
"244252", "Lunda\ Norte",
"2442539", "Lunda\ Sul",
"2442729", "Catumbela",
"2442777", "Dama\ Universal",
"2442363", "Sumbe",
"2442619", "Huila",
"2442548", "Moxico",
"244241", "Huambo",
"2442612", "Lubango",
"244265", "Cunene",
"244264", "Namibe",
"244248", "Bie",
"24422", "Luanda",
"244233", "Uige",
"2442345", "Bengo",
"2442546", "Luena",
"2442532", "Lunda\ Sul",
"2442722", "Lobito",
"2442538", "Lunda\ Sul",
"2442728", "Baia\ Farta",
"2442347", "Bengo",
"2442618", "Huila",
"2442549", "Moxico",
"2442615", "Huila",
"2442342", "Bengo",
"244231", "Cabinda",
"2442535", "Saurimo",
"2442498", "Menongue",
"2442358", "N\'Dalatando",
"2442348", "Caxito",
"2442537", "Lunda\ Sul",
"2442524", "Lucapa",
"2442364", "Porto\ Amboim",
"2442617", "Huila",
"244232", "Zaire",
"244272", "Benguela",
"2442545", "Moxico",
"2442346", "Bengo",
"2442652", "Kuroka",
"2442349", "Bengo",
"2442526", "Dundo",
"2442547", "Moxico",};
$areanames{pt} = {"2442618", "Huíla",
"2442538", "Lunda\-Sul",
"2442728", "Baía\ Farta",
"244233", "Uíge",
"2442532", "Lunda\-Sul",
"244248", "Bié",
"2442619", "Huíla",
"244252", "Lunda\-Norte",
"244236", "Kwanza\-Sul",
"2442539", "Lunda\-Sul",
"2442616", "Huíla",
"2442536", "Lunda\-Sul",
"244235", "Kwanza\-Norte",
"244249", "Cuando\-Cubango",
"244251", "Malanje",
"2442652", "Curoca",
"2442617", "Huíla",
"2442537", "Lunda\-Sul",
"2442615", "Huíla",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+244|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
        return $self->is_valid() ? $self : undef;
    }
1;