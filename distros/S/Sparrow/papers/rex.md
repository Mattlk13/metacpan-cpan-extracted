# SYNOPSIS

Server automation with rex and sparrow

# Using rex and sparrow to automate your server infrastructure

[Rex](http://rexify.org) - is a server automation tool written on perl, using ssh rex allow you execute various commands
on your server remotely. Well rex is able to do more ;), check out rex documentation!

[Sparrow](https://github.com/melezhik/sparrow) is a tool to install and run outthentic test suites - various tests to ensure your system
works as expected. Under the hood every sparrow plugin ( test suite ) - is small test case to
run some system commands and verify/analyze their output. It is very similar to what a system
administrators do on daily basis, but this could be done automatically!

# Hello world example

Consider simple example of installing web application from source code using carton and
ensure it runs ok, namely a proper process is seen in the processes list and pid file provides
valid process ID.


# Application

Let's create a simple dancer application:

  
    $ cat app.pl
  
    use Dancer2;
    get '/' => sub { "Hello World" };
    dance;    
    

That's it. Real application is of course has more files and complex structure but for the 
purpose of this tutorial it is enough.


Let's keep source code at git repository:

  
    $ git init
    $ git add app.pl
    $ git commit -m initial-commit -a
    $ git remote add origin https://github.com/melezhik/web-app.git
    $ git push -u origin master
  

Ok. Now we are ready to deploy things with rex:


# Rexfile


Rexfile should defined a task to `git clone` our source code and run dancer application:


    $ cat Rexfile
  
    use Rex::Misc::ShellBlock;
    
    task "deploy", sub {
      shell_block <<'EOF';
        test -f ~/web-app/app.pid && kill `cat ~/web-app/app.pid`
        rm -rf ~/web-app
        git clone https://github.com/melezhik/web-app.git ~/web-app
        cd ~/web-app
        nohup plackup app.pl 1>nohup.log 2>&1 & echo -n $! > app.pid
    EOF
    };
    
        
Again for the sake of simplicity of our tutorial we intentionally assume that some conditions are met on our
server:

* we have git installed
* we have Dancer2 package installed
* we have nohup utility

Ok now let run our rex task:


    $ rex -H 127.0.0.1 deploy
    [2016-04-11 13:45:42] INFO - Running task deploy on <local>
    [2016-04-11 13:45:44] INFO - All tasks successful on all hosts

If everything is fine, we will have our application running on our server.

# Sparrow plugin

But could we ensure that application is running? Beside doing some http requests and 
receiving a proper response, which could be thought as integration tests first of all
let's do simple check which probably would be done by every system administrator -
check if process given by pid file exists:

    $ ps --pid `cat ~/web-app/app.pid`

Ok this trivial check let us know at least that application is running from the *system point of view*.

Let's write sparrow plugin to automate such a checking:


First of all let's keep test source code under git, the same as we did with application source code:

    $ git init .
    $ git remote add origin https://github.com/melezhik/web-app-check.git
    

Then let's create a sparrow json file to define plugin metadata:

    $ nano sparrow.json

    {
      "engine" : "generic"
    }    

A few explanation here. Not to dive into sparrow tool guts we only have to define here a engine for our plugin.
As we want make some system level tests and do not want to have http related tests we choose here "generic"
engine, more details on sparrow json file syntax could be found at sparrow [documentation](https://github.com/melezhik/sparrow#create-sparrowjson-file)
 

Ok, the let's commit our changes:


    $ git add sparrow.json
    $ git commit -a -m 'add plugin metadata'

Now let's create a our test, as you can see it simple! A few perl code and some [outthentic DSL](https://github.com/melezhik/outthentic-dsl)


    $ nano story.pl

    exec 'ps --pid `cat ~/app/app.pid`'


    $ nano story.check

    plackup


Here we state that process by PID taken from pid file `~/app/app.pid` should exist and should relate to
plackup script. That is it!


Other considerations on _why_ PID based check is important:

* PID file could be removed ( while application is running ) which is BAD
* PID file could exist while application is not running which is BAD as well

And finaly lets create cpanfile to declare CPAN dependencies as sparrow uses carton/cpanfile mechanism to hanlder
prerequisitives. Right now it is one dependency - is a [Outthentic](https://github.com/melezhik/outthentic) test suite runner:


    $ nano cpanfile

    requires "Outthentic";

Now let's commit our changes


    $ git add .
    $ git commit -m 'add simple story' -a
    $ git push

# Using Rex::Misc::Sparrow module to run sparrow plugin


Running sparrow plugin with rex is easy using Rex::Misc::Sparrow, let's
amend Rexfile a little bit:


    $ nano Rexfile

    use Rex::Misc::ShellBlock;
    use Rex::CMDB;

    set cmdb => { type => 'YAML', path => 'cmdb' };
    require Rex::Misc::Sparrow;

    task "deploy", sub {
      shell_block <<'EOF';
        test -f ~/web-app/app.pid && kill `cat ~/web-app/app.pid`
        rm -rf ~/web-app
        git clone https://github.com/melezhik/web-app.git ~/web-app
        cd ~/web-app
        nohup plackup app.pl 1>nohup.log 2>&1 & echo -n $! > app.pid
    EOF
    };


Now haiving add Rex::Misc::Sparrow tasks into our Rexfile let's create cmdb file:


    $ mkdir cmdb
    $ nano cmdb/default.yml


    sparrow:
        system:
            - checkname: webapp
              plugin: private@web-app-check
    
Now running `rex -T` examine what has changed:


    $ rex -T

    Tasks
     deploy        
    
     Misc:Sparrow:check    Runs sparrow checks
     Misc:Sparrow:configure    Configure sparrow checks
     Misc:Sparrow:dump_config  Dumps sparrow configuration
     Misc:Sparrow:setup    Setup sparrow
    
As we can see new task are available. We are almost done, all we have to do now is to:

* setup [SPL](https://github.com/melezhik/sparrow#spl-file) file as we use [private](https://github.com/melezhik/sparrow#private-plugins) sparrow plguins ( the one we have just create and committed )
* describe desired sparrow plugins configuration via CMDB file


## Setup SPL file

As SPL file is just a index file  to describe availbale sparrow plguins delivered via git repositories
it is convenient to set it up via rex template:


    $ nano Rexfile


    task set_spl => sub {
      file "~/sparrow.list",
        content => template(
          'files/sparrow.list', 
          list => { 'web-app-check' => 'https://github.com/melezhik/web-app-check.git' } 
        );
    }

    $ mkdir files
    $ nano files/sparrow.list
    <% for my $plg (keys %{ $list }) { %>
    <%= $plg %> <%= $list->{$plg} %>
    <% } %>



Ok. Let's go ahead and try our new tasks.

## Set_spl

    $ rex set_spl
    [2016-04-11 13:59:15] INFO - Running task set_spl on <local>
    [2016-04-11 13:59:16] INFO - All tasks successful on all hosts

Once set_spl task is applied it results in SPL file being created on target server:

    $ cat ~/sparrow.list

    web-app-check https://github.com/melezhik/web-app-check.git

Which makes it possible to install private sparrow plugin from remote git repository.


## Misc:Sparrow:setup


  $ rex Misc:Sparrow:setup

