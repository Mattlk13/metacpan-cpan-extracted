# Name

Outthentic

# Synopsis

Multipurpose scenarios framework.

# Build status

[![Build Status](https://travis-ci.org/melezhik/outthentic.svg)](https://travis-ci.org/melezhik/outthentic)


# Install

    $ cpanm Outthentic

# Short introduction

This is a quick tutorial on outthentic usage.

## Run your scenarios

Scenario is just a script that you **run** and that yields something into **stdout**.

Perl scenario example:

    $ cat story.pl

    print "I am OK\n";
    print "I am outthentic\n";

Bash scenario example:

    $ cat story.bash

    echo I am OK
    echo I am outthentic

Python scenario example:

    $ cat story.py

    print "I am OK"
    print "I am outthentic"

Ruby scenario example:

    $ cat story.rb

    puts "I am OK"
    puts "I am outthentic"


Outthentic scenarios could be written on one of four languages:

* Perl 
* Bash
* Python
* Ruby

Choose you favorite language ;) !

Outthentic relies on file names to determine scenario language. 

This is the table to describe language / file name conventions:

    +-----------+--------------+
    | Language  | File         |
    +-----------+--------------+
    | Perl      | story.pl     |
    | Bash      | story.bash   |
    | Python    | story.py     |
    | Ruby      | story.rb     |
    +-----------+--------------+
  

## Check file

Check file contains rules to **verify** a stdout produced by scenario script. 

Here we require that our scenario should produce  \`I am OK' and \`I am outthentic' lines in stdout:

    $ cat story.check

    I am OK
    I am outthentic

NOTE: You can leave check file empty, but it's required anyway

    $ touch story.check

Empty check file means you just want to ensure that your story succeed ( exit code 0 ) and don't want
run any checks for story stdout.

## Story

Outthentic story is a scenarios + check file. When outthentic **run** story it:

* executes scenario script and saves stdout into file.
* verifies stdout against a check file

See also [story runner](#story-runner).

## Suite

Outthentic suites are a bunch of related stories. You may also call suites as (outthentic) projects.

One may have more then one story at the project.

Just create a new directories with a story data inside:

    $ mkdir perl-story
    $ echo 'print "hello from perl";' > perl-story/story.pl
    $ echo 'hello from perl' > perl-story/story.check

    $ mkdir bash-story
    $ echo 'echo hello from bash' > bash-story/story.bash
    $ echo 'hello from bash' > bash-story/story.check

    $ mkdir python-story
    $ echo 'print "hello from python"' > python-story/story.rb
    $ echo 'print from python' > python-story/story.check

    $ mkdir ruby-story
    $ echo 'puts "hello from ruby"' > ruby-story/story.rb
    $ echo 'hello from ruby' > ruby-story/story.check


Now, let's use `strun` command to run suite stories:

    $ strun --story perl-story

    /perl-story/ started
    
    hello from perl
    OK  scenario succeeded
    OK  output match 'hello from perl'
    ---
    STATUS  SUCCEED

    $ strun --story bash-story # so on ...
    
Summary:

* Stories are just a directories with story scenarios and check files.        

* Strun - a [S]tory [R]unner - a console script to execute story scenarios and validate output by given check lists.

* Outthentic suites are bunches of _related_ stories.

* By default strun looks for story.(pl|rb|bash) file at the project root directory. This is so called a default story.

* One can point strun a distinct story by `--story` parameter:

    $ strun --root /path/to/project/root/ --story /path/to/story/directory/inside/project/root

`Story` should point a directory relative to project root directory.

* Project root directory - a directory holding all related stories. 

A project root directory could be set explicitly using `--root` parameter:

    $ strun --root /path/to/my/root/

If `--root` is not set strun assumes project root directory to be equal current working directory:

    $ strun # all the stories should be here

# Calculator project example

Here is more detailed tutorial where we will build a test suite for calculator program.

Let's repeat it again - there are three basic outthentic entities: 

* suite
* scenarios 
* check files

## Project

Outthentic project is a bunch of related stories. Every project is _represented_ by a directory.

Let's create a project to test a simple calculator application:

    $ mkdir calc-app
    $ cd calc-app

## Scenarios

Scenarios are just a scripts to be executed so that their output to be verified by rules defined at check files.

In other words, every story is like a small program to be executed and then gets tested ( by it's output )

Let's create two stories for our calc project. One story for \`addition' operation and another for \`multiplication':

    # story directories

    $ mkdir addition # a+b
    $ mkdir multiplication # a*b


    # scenarios

    $ cat  addition/story.pl
    use MyCalc;
    my $calc = MyCalc->new();
    print $calc->add(2,2), "\n";
    print $calc->add(3,3), "\n";

    $ cat  multiplication/story.pl
    use MyCalc;
    my $calc = MyCalc->new();
    print $calc->mult(2,3), "\n";
    print $calc->mult(3,4), "\n";
 

## Check files

Check file contains validation rules to test script output. Every scenario **is always accompanied by** story check file. 

Check files should be placed at the same directory as scenario and be named as `story.check`.

Lets add some rules for \`multiplication' and \`addition' stories:

    $ cat addition/story.check
    4
    6
 
    $ cat multiplication/story.check
    6
    12
 

And finally lets run our suite:

    $ strun

# Story runner

Story runner - is a script to run outthentic stories. It is called `strun`.

Runner consequentially goes several phases:

## A compilation phase. 

Stories are converted into perl files \*.pl ( compilation phase ) and saved into temporary directory.

## An execution phase. 

Perl executes a compiled perl file. As it was told before if not set explicitly strun looks for 
something like story.(pl|rb|bash) at the top of project root directory and then compiles it in 
regular perl script and then give it Perl to run to execute such a script.
 
# Check files syntax

Outthentic consumes [Outthentic::DSL](https://github.com/melezhik/outthentic-dsl), so check files contain
rules defined in terms of Outthentic DSL - a language to validate unstructured text data.

Below some examples of check file syntax, you may learn more at Outthentic::DSL documentation.

## plain strings checks

Often all you need is to ensure that stdout has some strings in:


    # scenario stdout

    HELLO
    HELLO WORLD
    123456


    # check file

    HELLO
    123

    # verification output

    OK - output matches 'HELLO'
    OK - output matches 'HELLO WORLD'
    OK - output matches '123'

## regular expressions

You may use regular expressions as well:


    # check file

    regexp: L+
    regexp: \d


    # verification output

    OK - output matches /L+/
    OK - output matches /\d/

See [check-expressions](https://github.com/melezhik/outthentic-dsl#check-expressions) in Outthentic::DSL documentation pages.

## inline code, generators and asserts

You may inline code from other language to add some extra logic into your check file:

### Inline code

    # check file

    code: <<CODE
    !bash
    echo 'this is debug message will be shown at console'
    CODE

    code: <<CODE
    !python
    print 'this is debug message will be shown at console'
    CODE

    code: <<CODE
    !ruby
    puts 'this is debug message will be shown at console'
    CODE

    code: <<CODE
    # by default Perl language is used
    print("this is debug message will be shown at console\n");
    CODE

### generators

You may generate new **check entries** on runtime:

    # check file
    # with 2 check entries
   
    Say
    HELLO
   
    generator: <<CODE
    !bash

    echo say 
    echo hello 
    echo again

    CODE

    # a new check list would be:
   
    Say
    HELLO
    say
    hello
    again

Here examples on using other languages in generator expressions:

Perl:

    generator: <<CODE
    !perl
    [ 
      qw { say hello again } 
    ]

    CODE

Python:

    generator: <<CODE
    !python
    print 'say'
    print 'hello'
    print 'again'

    CODE

Ruby:

    generator: <<CODE
    !ruby
    puts 'say'
    puts 'hello'
    puts 'again'

    CODE


###  asserts

Asserts are statements returning true of false with some extra text description.

Asserts are very powerful feature when combined with **captures** and **generators**:


    # scenario output

    ten       for 10
    twenty   for 20
    thirty    for 30

    # check file
    
    regexp: \w+\s+for\s(\d+)

    generator: <<CODE
    !ruby
      sum=0
      (captures()).each do |c|
        sum+=c.first
      end
    puts "assert: #{sum==60} sum should be 60!"
    CODE  
    

Follow [code expressions](https://github.com/melezhik/outthentic-dsl#code-expressions), [generators](https://github.com/melezhik/outthentic-dsl#generators) and [asserts](https://github.com/melezhik/outthentic-dsl#asserts)
in Outthentic::DSL documentation pages to learn more about code expressions, generators and asserts.


### text blocks

Need to validate that some lines goes successively?
    
    # stdout
    
    this string followed by
    that string followed by
    another one string
    with that string
    at the very end.
    
    
    # check list
    # this text block
    # consists of 5 strings
    # goes consequentially
    # line by line:
    
    begin:
        # plain strings
        this string followed by
        that string followed by
        another one
        # regexp patterns:
    regexp: with (this|that)
        # and the last one in a block
        at the very end
    end:
    
See [comments-blank-lines-and-text-blocks](https://github.com/melezhik/outthentic-dsl#comments-blank-lines-and-text-blocks) in Outthentic::DSL documentation pages.

# Hooks

Story hooks are extension points to change [story runner](#story-runner) behavior. 

It's just a scripts gets executed _before scenario script_. 
  
You should name your hooks as `hook.*` and place them into story directory


    $ cat perl/hook.pl
    
    print "this is a story hook!";

Hooks could be written on one of three languages:

* Perl 
* Bash
* Python
* Ruby

Here is naming convention for hook files:


    +-----------+--------------+
    | Language  | File         |
    +-----------+--------------+
    | Perl      | hook.pl      |
    | Bash      | hook.bash    |
    | Python    | hook.py      |
    | Ruby      | hook.rb      |
    +-----------+--------------+

Reasons why you might need a hooks:

* execute some *initialization code* before running a scenario script
* redefine scenario stdout
* call downstream stories

# Hooks API

Story hooks API provides several functions to hack into story runner execution process:

## Redefine stdout

Redefining stdout feature means you define a scenario output on the hook side ( thus scenario script is never executed ). 

This might be helpful when for some reasons you do not want to run or you don't have by hand a proper scenario script.

This is simple an example:

    $ cat hook.pl
    set_stdout("THIS IS I FAKE RESPONSE \n HELLO WORLD");

    $ cat story.check
    THIS IS FAKE RESPONSE
    HELLO WORLD

You may call `set_stdout()` more then once:

    set_stdout("HELLO WORLD");
    set_stdout("HELLO WORLD2");

An effective scenario stdout will be:

    HELLO WORLD
    HELLO WORLD2

Here is `set_stdout()` function signatures list for various languages:

    +-----------+-----------------------+
    | Language  | signature             |
    +-----------+-----------------------+
    | Perl      | set_stdout(SCALAR)    |
    | Bash      | set_stdout(STRING)    |
    | Python(*) | set_stdout(STRING)    |
    | Ruby      | set_stdout(STRING)    |
    +-----------+-----------------------+

IMPORTANT: You should only use a set\_stdout inside story hook, not scenario file.

(*) you need to `from outthentic import *` in Python to import set_stdout function.

## Upstream and downstream stories

It is possible to run one story from another with the help of downstream stories.

Downstream stories are reusable stories ( aka modules ). 

Story runner never executes downstream stories _directly_.

Downstream story always gets called from the _upstream_ one. This is example:

    $ cat modules/knock-the-door/story.rb

    # this is a downstream story
    # to make story downstream
    # simply create story files 
    # in modules/ directory

    puts 'knock-knock!'
 
    $ cat modules/knock-the-door/story.check
    knock-knock!

 
    $ cat open-the-door/hook.rb

    # this is a upstream story
    # to run downstream story
    # call run_story function
    # inside upstream story hook

    # with a single parameter - story path,
    # notice that you have to remove
    # `modules/' chunk from story path parameter

    run_story( 'knock-the-door' );

    $ cat open-the-door/story.rb
    puts 'opening ...' 

    $ cat open-the-door/story.check
    opening

    $ strun --story open-the-door/
 
    /modules/knock-the-door/ started
    
    knock-knock!
    OK  scenario succeeded
    OK  output match 'knock-knock!'
    
    /open-the-door/ started
    
    opening ...
    OK  scenario succeeded
    OK  output match 'opening'
    ---
    STATUS  SUCCEED
    
    
Summary:

* to make story a downstream simply create a story  in a `modules/` directory.

* to run downstream story call `run_story(story_path)` function inside upstream story hook.

* you can call as many downstream stories as you wish.

* you can call the same downstream story more than once.

* downstream stories in turn may call other downstream stories.

Here is an example of multiple downstream story calls:

    $ mkdir module/up
    $ mkdir module/down
    $ echo 'UP!' > module/up/story.check
    $ echo 'and DOWN!' > module/down/story.check
    $ echo 'print qq{UP!}' > modules/up/story.pl 
    $ echo 'print qq{DOWN!}' > modules/down/story.pl 

    $ cat two-jumps/hook.pl

    run_story( 'up' );
    run_story( 'down' );
    run_story( 'up' );
    run_story( 'down' );

### story variables 

You may pass a variables to downstream story using second argument of `run_story()`  function. For example:

    $ mkdir modules/greeting

    $ cat hook.pl

    run_story( 
      'greeting', {  name => 'Alexey' , message => 'hello' }  
    );

Or using Ruby:

    $ cat hook.rb

    run_story  'greeting', {  'name' => 'Alexey' , 'message' => 'hello' }

Or using Python:

    from outthentic import *
    run_story('greeting', {  'name' : 'Alexey' , 'message' : 'hello' })

Or Bash:

    $ cat hook.bash

    run_story  greeting name Alexey message hello 


Here is the `run_story` signature list for various languages:

    +-----------+----------------------------------------------+
    | Language  | signature                                    |
    +-----------+----------------------------------------------+
    | Perl      | run_story(SCALAR,HASHREF)                    |
    | Bash      | run_story(STORY_NAME NAME VAL NAME2 VAL2 ... | 
    | Python    | run_story(STRING,DICT)                       | 
    | Ruby      | run_story(STRING,HASH)                       | 
    +-----------+----------------------------------------------+

Story variables are accessible via `story_var()` function. 

Examples:

In Perl:

    $ cat modules/greeting/story.pl

    print story_var('name'), 'say ', story_var('message');

In Python:

    $ cat modules/greeting/story.py

    from outthentic import *
    print story_var('name') + 'say ' + story_var('message')

In Ruby:

    $ cat modules/greeting/story.rb

    puts "#{story_var('name')} say #{story_var('message')}"


In Bash (1-st way):

    $ cat modules/greeting/story.bash

    echo $name say $message

In Bash (2-nd way):

    $ cat modules/greeting/story.bash

    echo $(story_var name) say $(story_var message)


You may access story variables inside story hooks and check files as well.

And finally:

* downstream stories may invoke other downstream stories.

* you can't only use story variables inside downstream stories.

Here is the how you access story variable in all three languages

    +------------------+---------------------------------------------+
    | Language         | signature                                   |
    +------------------+---------------------------------------------+
    | Perl             | story_var(SCALAR)                           |
    | Python(*)        | story_var(STRING)                           | 
    | Ruby             | story_var(STRING)                           | 
    | Bash (1-st way)  | $foo $bar ...                               |
    | Bash (2-nd way)  | $(story_var foo.bar)                        |
    +------------------+---------------------------------------------+

(*) you need to `from outthentic import *` in Python to import story_var() function.

## Story properties

Some story properties have a proper accessors functions. Here is the list:

* `project_root_dir()` - Root directory of outthentic project.

* `test_root_dir()` - Test root directory. Root directory of generated perl test files , see also [story runner](#story-runner).

* `config()` - Returns suite configuration hash object. See also [suite configuration](#suite-configuration).

## Helper functions and variables

Outthentic provides some helpers and variables:

    +------------------+-----------------------------------------------------+
    | Language         | Type     | Name | Comment                           |
    +------------------+-----------------------------------------------------+
    | Perl             | function | os() | get a name of OS distribution     |
    | Bash             | variable | os   | get a name of OS distribution     |
    | Python(*)        | function | os() | get a name of OS distribution     |
    | Ruby             | function | os() | get a name of OS distribution     |
    +------------------+-----------------------------------------------------+

(*) you need to `from outthentic import *` in Python to import os() function.

### Recognized OS list

- centos5
- centos6
- centos7
- ubuntu
- debian
- minoca
- archlinux
- fedora
- amazon

## Meta stories

Meta stories are special type of outthentic stories.

The essential property of meta story is it has no scenario file at all:

    # foo/bar story
    mkdir foo/bar

    # it's a meta story
    touch foo/bar/meta.txt

Placing a special `meta.txt' file into story directory makes that story a meta.

You may live \`meta.txt' empty file or add some useful description to be printed  when story is executed:

    nano foo/bar/meta.txt

        This is my cool story.
        Take a look at this!

How one could use meta stories?

Meta stories are just _containers_ for other downstream stories. Usually one defines some downstream
stories call inside meta story's hook file:

    nano foo/bar/hook.pm

        run_story( '/story1' );
        run_story( '/story2' );



Meta stories are very similar to upstream stories with redefined stdout, with the only exclusion 
that as meta story has no scenario file there is no need for redefining a stdout.

You may also call meta stories as downstream stories:


    nano modules/foo/bar/meta.txt


## Ignore unsuccessful story code

Every story is a script gets executed and thus returning an exit code. If exit code is bad (!=0)
this is treated as story verification failure. 

Use `ignore_story_err(int)` function to ignore unsuccessful story code:

    # Python

    $ cat hook.py
    from outthentic import *
    ignore_story_err(1)


    # Ruby

    $ cat hook.rb
    ignore_story_err 1

    # Perl

    $ cat hook.pl
    ignore_story_err(1)

    # Bash

    $ cat hook.bash
    ignore_story_err 1

## Story libraries

Story libraries are files to keep your libraries code to _automatically required_ into story hooks and check files context:

Here are some examples:

Perl:

    $ cat common.pm
    sub abc_generator {
      print $_, "\n" for a..z;
    } 

    $ cat story.check

    generator: <<CODE;
    !perl
      abc_generator()
    CODE


Ruby:

    $ cat common.rb
    def super_utility arg1, arg2
      # I am cool! But I do nothing!
    end

    $ cat hook.pl

    super_utility 'foo', 'bar'

Here is the list for library file names for various languages:

    +-----------+-----------------+
    | Language  | file            |
    +-----------+-----------------+
    | Perl      | common.pm       |
    | Bash      | common.bash     |
    | Ruby      | common.rb       |
    +-----------+-----------------+

***NOTE!***  Story libraries are not supported for Python
    
# Language libraries

## Perl

*PERL5LIB*

$project\_root\_directory/lib path gets added to $PERL5LIB variable. 

This make it easy to place custom Perl modules under project root directory:

    $ cat my-app/lib/Foo/Bar/Baz.pm
    package Foo::Bar::Baz;
    1;

    $ cat common.pm
    use Foo::Bar::Baz;

# Story runner client

    $ strun <options>
 
## Options

* `--root`  

Root directory of outthentic project. If root parameter is not set current working directory is assumed as project root directory.

* `--debug` 

Enable/disable debug mode:

    * Increasing debug value results in more low level information appeared at output

    * Default value is 0, which means no debugging 

    * Possible values: 0,1,2,3

* `--format` 

Sets report format. Available formats: `concise|default`. Default value is `default`.

In concise format strun shrink output to only STDOUT/STDERR comes from story scenarios.
It's useful when you want to parse "raw" script output by external commands.


* `--purge-cache`

Purge strun cache upon exit. By default `--purge-cache` is disabled ( cache remains to allow debugging and troubleshooting ).
 

* `--match_l` 

Truncate matching strings. In a TAP output truncate matching strings to {match_l} bytes;  default value is 200.

* `--story` 

Run only single story. This should be path to a directory containing story inside project. A path should 
be relative against project root directory. Examples:

    # A project  with 3 stories
    foo/story.pl
    foo/bar/story.rb
    bar/story.pl

    # Run various stories
    --story foo # runs foo/ stories
    --story foo/story # runs foo/story.pl
    --story foo/bar/ # runs foo/bar/ stories


* `--ini`  

Configuration ini file path.

See [suite configuration](#suite-configuration) section for details.

* `--yaml` 

YAML configuration file path. 

See [suite configuration](#suite-configuration) section for details.

* `--json` 

JSON configuration file path. 

See [suite configuration](#suite-configuration) section for details.

* `--nocolor`

If set - disable color output. By default `strun` prints with colors.

* `--dump-config`

If set - dumps a suite configuration and exit not doing any other actions. See also suite configuration section.


# Suite configuration

Outthentic projects are configurable. Configuration data is passed via configuration files.

There are three type of configuration files are supported:

* Config::General format
* YAML format
* JSON format

Config::General  style configuration files are passed by `--ini` parameter

    $ strun --ini /etc/suites/foo.ini

    $ cat /etc/suites/foo.ini

    <main>

      foo 1
      bar 2

    </main>

There is no special magic behind ini files, except this should be [Config::General](https://metacpan.org/pod/Config::General) compliant configuration file.

Or you can choose YAML format for suite configuration by using `--yaml` parameter:

    $ strun --yaml /etc/suites/foo.yaml

    $ cat /etc/suites/foo.yaml

    main :
      foo : 1
      bar : 2


Unless user sets path to configuration file explicitly by `--ini` or `--yaml` or `--json`  story runner looks for the 
files named suite.ini and _then_ ( if suite.ini is not found ) for suite.yaml, suite.json at the current working directory.

If configuration file is passed and read a related configuration data is accessible via config() function, 
for example in story hook file:

    $ cat hook.pl

    my $foo = config()->{main}->{foo};
    my $bar = config()->{main}->{bar};

Examples for other languages:

Bash:

    $ cat hook.bash

    foo=$(config main.foo )
    bar=$(config main.bar )

Python:

    $ cat hook.py


    from outthentic import *

    foo = config()['main']['foo']
    bar = config()['main']['bar']


Ruby:

    $ cat hook.rb

    foo = config['main']['foo']
    bar = config['main']['bar']



# Runtime configuration

Runtime configuration parameters is way to override suite configuration data. Consider this example:

    $ cat suite.ini
    <foo>
      bar 10
    </foo>
  
    $ strun --param foo.bar=20
  
This way we will override foo.bar to value \`20'.

# Environment variables

* `match_l` - In a suite runner output truncate matching strings to {match_l} bytes. See also `--match_l` in [options](#options).

* `SPARROW_ROOT` - if set, used as prefix for test root directory.

* `SPARROW_NO_COLOR` - disable color output (see --nocolor option of `strun`)

Test root directory resolution table:
    
    +---------------------+----------------------+
    | Test root directory | SPARROW_ROOT Is Set? |
    +---------------------+----------------------+
    | ~/.outthentic/tmp/  | No                   |
    | $SPARROW_ROOT/tmp/  | Yes                  |
    +---------------------+----------------------+
    
        
# Examples

An example outthentic project lives at examples/ directory, to run it say this:

    $ strun --root examples/

# AUTHOR

[Aleksei Melezhik](mailto:melezhik@gmail.com)

# Home Page

[https://github.com/melezhik/outthentic](https://github.com/melezhik/outthentic)

# See also

* [Sparrow](https://github.com/melezhik/sparrow) - outthentic suites manager.

* [Outthentic::DSL](https://github.com/melezhik/outthentic-dsl) - Outthentic::DSL specification.

* [Swat](https://github.com/melezhik/swat) - web testing framework consuming Outthentic::DSL.

# Thanks

To God as the One Who inspires me to do my job!


