# UPDATE YOUR BOOKMARKS

This project is deprecated: no new releases will be made available.

Please visit [App-SpamcupNG](https://github.com/glasswalk3r/App-SpamcupNG) for the same aplication and functionallity, but
on a different Perl distribution name!

# DESCRIPTION

spamcupNG is a Perl web crawler for finishing [SpamCop.net](https://www.spamcop.net/) reports automatically.

It will use your account details to login into SpamCop.net web page and finish reporting your SPAM. Spamcup NG tries to be as polite as possible, 
introducing forced delays to not overwhelm SpamCop.net website. All reports are sent sequentially.

spamcupNG is a fork from the original Spamcup project.

Spamcup is copyright (C) Toni Willberg <toniw@iki.fi>.

# INTRO

In your favorite shell:

    $ spamcup

That's it! See the configuration file details.

You can also provide all the parameters in the command line. spamcupNG should be compatible with the command line options
of Spamcup: check out the program Pod for more information (`perldoc spamcup`).

Usage:

    $ spamcup -h
    spamcup <options> <SpamCop-Username>

    Options:
     -n Does nothing, just shows if you have unreported spam or not.
     -a Run in a loop untill all spam is reported.
     -s Stupid. Runs without asking confirmation. Use with care.
     -c Alternate method for signifying code. (Unpaid users WITHOUT username & password)
     -l Alternate method for providing username. (Paid & unpaid users with password)
     -p Method for providing password. (Required for users with password)
     -v Show version and quit.
     -V Verbosity mode. Running "perldoc SpamcupNG" will provide more information on that.
     -h You are reading it.

# WARNINGS

Some important warnings before starting using it:

- The script does NOT know where the spam report will be sent so IT'S YOUR RESPONSIBILITY!
- If the script asks spamcop to send reports to wrong places IT'S YOUR FAULT!
- If the script has a bug that causes same report being sent thousand times IT'S YOUR MAIL ADDRESSES!
- DO NOT USE THIS SCRIPT IF YOU DON'T UNDERSTAND WHAT IT DOES! IT'S YOUR SHAME!

# SETUP

spamcupNG is distribuited as a regular Perl distribution, so you can do it from [CPAN](http://search.cpan.org) by downloading it with your preferred CPAN client or directly, 
by downloading the tarball (and doing the traditional `perl Makefile.PL; make; make test; make install`).

Additionally, spamcupNG ships with a `cpanfile`, which can allow you to install directly from Github. See [here](http://blogs.perl.org/users/mark_allen/2013/07/why-i-use-cpanfile-and-you-should-too.html)
for more details on that.

You will need administrator rights to install this globally unless you're on a UNIX-like OS that has your own perl interpreter (like installed by [perlbrew](https://perlbrew.pl/)).

# CONFIGURATION FILE

You can also provide a configuratio file to avoid having to provide the same information everytime you want to execute the program.

The program will look for a configuration file name `.spamcupNG.yml` in the corresponding home directory of the user (that will dependend on the OS you're executing it). Pay attention to the dot ('.') in front of the file.

The configuration file must be written as an YAML file, with the exact properties below:

```YAML
---
ExecutionOptions:
  all: y
  stupid: y
  nothing: n
  alt_code: n
  alt_user: n
  verbosity: INFO
Accounts:
  Yahoo!:
    e-mail: account@provider1.com.br
    password: FOOBAR
  Gmail:
    e-mail: account@provider2.com.br
    password: FOOBAR
```
All those options have their corresponding command line parameter. Be sure to take care of file permissions to avoid disclosure of your SpamCop.net password!

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 of Alceu Rodrigues de Freitas Junior, <arfreitas@cpan.org>

This file is part of spamcupNG distribution.

spamcupNG is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

spamcupNG is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with spamcupNG. If not, see http://www.gnu.org/licenses/.
