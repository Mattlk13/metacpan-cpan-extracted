# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Bots that lookup JIRA tickets",
  "AUTHOR" => "Andrew Sterling Hanenkamp <hanenkamp\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Bot-Backbone-Service-Ticket-Tracker-JIRA",
  "LICENSE" => "perl",
  "NAME" => "Bot::Backbone::Service::Ticket::Tracker::JIRA",
  "PREREQ_PM" => {
    "Bot::Backbone::Service::Ticket::Tracker" => 0,
    "JIRA::REST" => 0,
    "Moose" => 0
  },
  "VERSION" => "0.160490",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Bot::Backbone::Service::Ticket::Tracker" => 0,
  "JIRA::REST" => 0,
  "Moose" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
