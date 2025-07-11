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
package Number::Phone::StubCountry::BI;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20250605193633;

my $formatters = [
                {
                  'format' => '$1 $2 $3 $4',
                  'leading_digits' => '[2367]',
                  'pattern' => '(\\d{2})(\\d{2})(\\d{2})(\\d{2})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            22|
            31
          )\\d{6}
        ',
                'geographic' => '
          (?:
            22|
            31
          )\\d{6}
        ',
                'mobile' => '
          (?:
            29|
            6[124-9]|
            7[125-9]
          )\\d{6}
        ',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '',
                'voip' => ''
              };
my %areanames = ();
$areanames{en} = {"2572225", "Bujumbura",
"2572221", "Bujumbura",
"2572240", "Central\ east\ zone",
"2572230", "North\ zone",
"2572222", "Bujumbura",
"2572223", "Bujumbura",
"2572227", "Rural\ areas",
"2572224", "Bujumbura",
"2572220", "Bujumbura",
"2572226", "West\ zone",
"2572250", "South\ zone",};
my $timezones = {
               '' => [
                       'Africa/Bujumbura'
                     ]
             };

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+257|\D)//g;
      my $self = bless({ country_code => '257', number => $number, formatters => $formatters, validators => $validators, timezones => $timezones, areanames => \%areanames}, $class);
        return $self->is_valid() ? $self : undef;
    }
1;