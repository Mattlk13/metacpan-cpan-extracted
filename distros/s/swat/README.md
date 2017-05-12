# NAME

Swat

# SYNOPSIS

Web testinfg framework consuming [Outthentic::DSL](https://github.com/melezhik/outthentic-dsl).

# What does swat stand for?

    [S]imple
    [W]eb
    [A]application
    [T]est
    
# Description

* Swat is a powerful and yet simple and flexible tool for rapid automated web tests development.

* Swat is a web application oriented test framework, this means that it equips you with all you need for a web test development
and yet it's not burdened by many other "generic" things that you probably won't ever use.

* Swat does not carry all heavy load on it's shoulders, with the help of it's "elder brother" - curl
swat makes a http requests in a smart way. This means if you know and love curl swat might be easy way to go.
Swat just passes all curl related parameter as is to curl and let curl do it's job.

* Swat is a text oriented tool, for good or for bad it does not provide any level of http DOM or xpath hacking ( _but_ see  [process http responses](#process-http-responses) section ). It does not even try to decouple http headers from a body. Actually _it just returns you a text_ where you can find and grep in old good unix way. Does this sound suspiciously simple? I believe that most of things could be tested in a simple way.

* Swat is extendable by writing custom perl code, this is where you may add desired complexity to your test stories. Check out swat API for details. 

* And finally swat relies on prove as internal test runner - this has many, many good results:

    * swat transparently passes all it's arguments to prove which makes it simple to adjust swat runner behavior in a prove way

    * swat tests might be easily embedded as unit tests into a cpan distributions.

    * test reports are emitted in a TAP format which is portable and easy to read.

Ok, now I hope you are ready to dive into swat tutorial! :)

# Install

    $ sudo apt-get install curl
    $ sudo cpanm swat

Or install from source:

    # could be useful for contributors and developers

    $ perl Makefile.PL
    $ make
    $ make test
    $ make install

# Write your swat story

Swat test stories always answers on 2 type of questions:

* _What kind of_ http request should be sent.
* _What kind of_ http response should be received.

As swat is a web test oriented tool it deals with some http related stuff as:

* http methods
* http resources
* http responses

Swat leverages Unix file system to build an _analogy_ for these things:

## HTTP resources

_HTTP resource is just a directory_. You have to create a directory to define a http resource:

    mkdir foo/
    mkdir -p bar/baz

This code defines two http resources for your application - '/foo/' and '/bar/baz'

## HTTP methods

_HTTP method is just a file_. You have to create a file to define a http method.

    touch foo/get.txt
    touch foo/put.txt
    touch bar/baz/post.txt

Obviously \`http methods' files should be located at \`http resource' directories.

The list below describes two http resources ( /foo, /bar/baz ) and three http methods for these resources ( GET, PUT, DELETE ):

    * GET  /foo
    * PUT  /foo
    * POST /bar/baz

Here is the list of _predefined_ file names for a http methods files:

    get.txt      --> GET      method
    post.txt     --> POST     method
    put.txt      --> PUT      method
    delete.txt   --> DELETE   method

There is also special predefined file name \`meta.txt', see [meta stories](#meta-stories).

# Hostname / IP Address

You need to define hostname or ip address to send request to. 

Just write it up to a special file  called \`host' and swat will use it.

    echo 'app.local' > host
    

As swat makes http requests with the help of curl, the host name should be compliant with curl requirements, this
for example means you may define a http schema or port here:

    echo 'https://app.local' >> host
    echo 'app.local:8080' >> host

## HTTP Response

Swat makes request to a given http resources with a given http methods and then validates a response.
Swat does this with the help so called _check lists_, check lists are defined at \`http methods' files.


Check list is just a list of expressions a response should match. It might be a set of plain strings or regular expressions:

    echo 200 OK > foo/get.txt
    echo 'Hello I am foo' >> foo/get.txt

The code above defines two checks for response from \`GET /foo':

* it should contain "200 OK"
* it should contain "Hello I am foo"

You may add some regular expressions checks as well:

    # for example check if we got something like 'date':
    echo 'regexp: \d\d\d\d-\d\d-\d\d' >> foo/get.txt

# Bringing all together

All these things like http method, http resource and check list build up an essential swat entity called a _swat story_.

Swat story is a very simple test plan, which could be expressed in a cucumber language as follows:

    Given I have web application 'http://my.cool.app:80'
    And I have http method 'GET'
    And make http request 'GET /foo'
    Then I should have response matches '200 OK'
    And I should have response matches 'Hello I am foo'
    And I should have response matches '\d\d\d\d-\d\d-\d\d'

From the file system point of view swat story is a:

* http method - the \`http method' file
* http resource - the directory where \`http method file' located in
* check list - the content of a \`http method' file

## Swat Project

Swat project is a bunch of a related swat stories kept under a single directory. This directory is called _project root directory_.
The project root directory name could be any, swat just searches for swat story files in it and then "execute" found stories.
See [swat runner](#swat-runner) section for full explanation of this process.

This is an example swat project layout:

    $ tree my/swat/project
      my/swat/project
      |--- host
      |----FOO
      |-----|----BAR
      |           |---- post.txt
      |--- FOO
            |--- get.txt

    3 directories, 3 files

When you ask swat to execute swat stories you have to point it a project root directory or \`cd' to it and run swat without arguments:

    swat my/swat/project

    # or

    cd my/swat/project && swat

Note, that project root directory path will be removed from http resources paths during execution:

* GET  /FOO
* POST /FOO/BAR

Also notice that if you pass first argument ( which is project root directory ) to swat client, then the second argument _could be_ a hostname ( in case you don't want to use one defined at host file or you do not have one ):

      # inside project root directory 
      swat ./ 127.0.0.1

      # outside of project root directory 
      swat /path/to/project/root/directory/ 127.0.0.1

Follow [swat client](#swat-client) section for full explanation of swat client command line API.

# Swat check lists

Swat check lists complies [Outthentic DSL](https://github.com/melezhik/outthentic-dsl) format.

There are lot of possibilities here!

( For full explanation of outthentic DSL please follow [documentation](https://github.com/melezhik/outthentic-dsl). )

A few examples:

* plain string checks

Often all you need is to ensure that http response has some strings in:


    # http response
    200 OK
    HELLO
    HELLO WORLD


    # check list
    200 OK
    HELLO

    # swat output
    OK - output matches '200 OK'
    OK - output matches 'HELLO'

* regular expressions

You may use regular expressions as well:


    # http response
    My birth day is: 1977-04-16


    # check list
    regexp: \d\d\d\d-\d\d-\d\d


    # swat output
    OK - output matches /\d\d\d\d-\d\d-\d\d/

Follow [https://github.com/melezhik/outthentic-dsl#check-expressions](https://github.com/melezhik/outthentic-dsl#check-expressions) to know more.

* generators

Yes you may generate new check list on run time:

    # original check list
   
    Say
    HELLO
   
    # this generator creates 3 new check expressions:
   
    generator: [ qw{ say hello again } ]
   
    # final check list:
   
    Say
    HELLO
    say
    hello
    again

Follow [https://github.com/melezhik/outthentic-dsl#generators](https://github.com/melezhik/outthentic-dsl#generators) to know more.
   
* inline perl code

What about inline arbitrary perl code? Well, it's easy!


    # check list
    regexp: number: (\d+)
    validator: [ ( capture()->[0] '>=' 0 ), 'got none zero number') ];

Follow [https://github.com/melezhik/outthentic-dsl#validators](https://github.com/melezhik/outthentic-dsl#validators) to know more.

* text blocks

Need to validate that some lines goes in response successively ?

        # http response

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
            another one string
            # regexps patterns:
        regexp: with (this|that) \S+
            # and the last one in a block
            at the very end
        end:

Follow [https://github.com/melezhik/outthentic-dsl#comments-blank-lines-and-text-blocks](https://github.com/melezhik/outthentic-dsl#comments-blank-lines-and-text-blocks)
to know more.

# Swat ini files

Every swat story comes with some settings you may define to adjust swat behavior.
These type of settings could be defined at swat ini files.

Swat ini files are file called "swat.ini" and located at \`resources' directory:

     foo/bar/get.txt
     foo/bar/swat.ini

The content of swat ini file is the list of variables definitions in bash format:

    $name=value

As swat ini files is bash scripts you may use bash expressions here:

    if [ some condition ]; then
        $name=value
    fi

Following is the list of swat variables you may define at swat ini files, it could be divided on two groups:

* **swat variables**
* **curl parameters**

## swat variables

Swat variables define swat  basic configuration, like logging mode, prove runner settings, etc. Here is the list:

* `skip_story` - skip story, default value is \`0'. Set to \`1' if you want skip store for some reasons.

For example:

    # swat.ini
    # assume that we set profile variable somewhere else
    # 

    if test "${profile}" = 'production'; then
        skip_story=1 # we don't want this one for production
    fi

* `ignore_http_err` - ignore http related errors; default value is \`1' ( do not ignore ) 

    * swat runs curl command and then checks http status code
    * in case of bad http status code returns (  0 or >= 400 ) a proper swat assert fails
    * settings ignore\_http\_err to \`1' only makes a warning in case of bad http status code and does not trigger assert failure 

* `prove_options` - prove options to be passed to prove runner,  default value is \`-v`. See [Prove settings](#prove-settings) section.

* `debug` - enable swat debugging

    * Increasing debug value results in more low level information appeared at output

    * Default value is 0, which means no debugging

    * Possible values: 0,1,2,3

* `debug_bytes` - number of bytes of http response to be dumped out when debug is on. default value is \`500'.

* `match_l` - in TAP output truncate matching strings to {match_l} bytes;  default value is \`40'.

* `swat_purge_cache` - remove swat cache files at the end of test run; default value is `\0' ( do not remove ).

## curl parameters

Curl parameters relates to curl client. Here is the list:

* `try_num` - a number of requests to be send in case curl get unsuccessful return,  similar to curl \`--retry' , default value is \`2'.

* `curl_params` - additional curl parameters being add to http requests, default value is `""`.

Here are some examples:

    # -d curl parameter
    curl_params='-d name=daniel -d skill=lousy' # post data sending via form submit.

    # --data-binary curl parameter
    curl_params=`echo -E "--data-binary '{\"name\":\"alex\",\"last_name\":\"melezhik\"}'"`

    # set http header
    curl_params="-H 'Content-Type: application/json'"


Follow curl documentation to get more examples.

* `curl_connect_timeout` - maximum time in seconds that you allow the connection to the server to take, follow curl documentation for full explanation.

* `curl_max_time` - maximum time in seconds that you allow the whole operation to take, follow curl documentation for full explanation.

* `curl_follow_redirect` - make curl to respect http redirects. default value is \`1' ( respect ), set this setting to \`0' if you don't want for some reasons follow http redirects

* `port`  - http port of tested host, default value is \`80'.

## other variables

This is the list of helpful variables  you may use in swat ini files:

* $resource
* $resource_dir
* $test\_root\_dir
* $hostname
* $http_method

## Alternative swat ini files locations

Swat try to find swat ini files at these locations ( listed in order )

* **~/swat.ini** * home directory

* **$project\_root\_directory/swat.ini** -  project root directory

## Settings priority table

This table describes all possible locations for swat ini files. Swat try to find swat ini files in order:

    | location                                  | order N     |
    | --------------------------------------------------------|
    | ~/swat.ini                                | 1           |
    | `project_root_directory'/swat.ini         | 2           |
    | `http resource' directory/swat.ini file   | 3           |
    | environment variables                     | 4           |


In case the same variable is defined more than once at swat ini files with different locations, the file loaded last win:

    curl_params="-H 'Foo: Bar'" # in a ~/swat.ini
    curl_params="-H 'Bar: Baz'" # in a project_root_directory/swat.ini

    # actual curl_params value:
    "-H 'Bar: Baz'"

If you want concatenation mode use name="$name value" expression:

    curl_params="-H 'Foo: Bar'" # in a ~/swat.ini
    curl_params="$curl_params -H 'Bar: Baz'" # in a project_root_directory/swat.ini

    # actual curl_params value:
    "-H 'Foo: Bar' -H 'Bar: Baz'"

In case you need provide default value for some variable use name=${name default_value} expression:

    # port will be set 80 unless it's not set somewhere else
    port=${port:=80} # in a ~/swat.ini
      

# Hooks

Hooks are extension points to hack into swat runtime phase. It's just files with perl code gets executed in the beginning of swat story.
You should named your hook file as \`hook.pm' and place it into \`resource' directory:


    # foo/hook.pm
    diag "hello, I am swat hook";
    sub red_green_blue_generator { [ qw /red green blue/ ] }
   

    # foo/get.txt
    generator: red_green_blue_generator()


There are lot of reasons why you might need a hooks. To say a few:

* define swat generators
* redefine http responses
* process http responses 
* redefine http resources
* call downstream stories
* other custom code


# Hooks API

Swat hooks API provides several functions to change swat story at runtime

## Redefine http responses

*set_response(STRING)*

Using set_response means that you never make a real request to a web application, but instead set response on your own side.

This feature is helpful when you need to mock up http responses instead of having them requested from a real web application.
For example in absence of an access to a tested application or if response is too slow or it involves too much data
which make it hard to execute a swat stories often.

This is an example of setting server response inside swat hook:

    # hook.pm
    set_response("THIS IS I FAKE RESPONSE\n HELLO WORLD");

    # get.txt
    THIS IS A FAKE RESPONSE
    HELLO WORLD


You may call \`set_response' more then once:


    set_response("HELLO WORLD");
    set_response("HELLO WORLD2");

A final response will be:

    HELLO WORLD
    HELLO WORLD2

Another interesting idea about set\_response feature is a _conditional_ http requests.

Let say we have \`POST /login' request for user authentication, this is a simple swat story for it:

    # login/post.txt
    200 OK
   
Good. But what if you need to skip authentication under some conditions, like if you are already logged in before?
We could write such a code:

    # login/post.txt
    generator:
    $logged_in ? [ 'I am already logged in' : '200 OK' ]

    # login/hook.pm
    if ( ... check if user is logged in .... ){
        set_response('I am already logged in');
    }


## Process http responses 


*set_response_processor(CODEREF)*


Response processors are custom perl function to modify content returned from server _before_ invoking a validation process.
Processor code should be _defined_ by calling a process_response function with parameter as reference to processor function:

For example:

       set_response_processor( sub { 
          my $headers   = shift; # original response, http headers, String
          my $body      = shift; # original response, body, String
          $body=~s/hello/swat/;
          return $body;          # modified response will be return value of sub {} 
        });
        

What you should know about processor functions:

* They should be simple, it is good to follow KISS paradigm.

* They are not for validating content, use check lists for this.

* Basicly processor code _prepare_ a content to be validated by check lists.

* When processor function gets called it is supplied with $body parameter which is a http body of original http response relieved from server.

* Remember that if processor function gets called - the content get passed into validation process will be altered as if you use a classic UNIX  pipeline, see schema below.

* In case of response processor function gets called, the original http headers and processor function return value be sent as input for validation process. 

* If no processor function gets called an original http response ( http headers and the body ) will be sent as input for validation process.

This is a rough schema of full process:


     # without processor function
     curl -i some-http-URL | validation-process

     # with processor script exists:
     curl -i some-http-URL | processor-function| validation-process

The _possible_ usage of processor functions:

* handling json, xml, yaml data

For example:
     

      # server response in json format
      {
          "Foo": {
              "Bar" : "Baz"
           }
      }

      # processor function
      my $headers   = shift;
      my $body      = shift;
      use JSON;
      $hash = decode_json($body);
      return 'Foo.Bar.Baz :'.( $hash->{Foo}->{Bar}->{Baz} )."\n";
      

      # server response in xml format
      <foo>
        <bar>
          <baz>aaa</baz>
        </bar>  
      </foo>

      # processor function
      my $headers   = shift;
      my $body      = shift;
      use XML:LibXML;
      my $doc = XML::LibXML->parse_string($body);
      return 'Foo.Bar.Baz :'.( $doc->find("string(/foo/bar/baz)")->string_value )."\n";
      


## Redefine http resources

*modify_resource(CODEREF)*

To modify existed resource use modify_resource function:

    # foo/bar/baz/ - resource
   
    # hook.pm
    modify_resource( sub { my $resource = shift; s/bar/bbaarr/, s/baz/bbaazz/ for $resource; $resource  } );

    # modified resource
    foo/bbaarr/bbaazz


## Upstream and downstream stories

Swat allow you to call one story from another, using notion of swat modules.

Swat modules are reusable swat stories. Swat never executes swat modules directly, instead you have to call swat module from your swat story.
Story calling another story is named a _upstream story_, story is being called is named a _downstream_ story.
( This kind of analogy is taken from Jenkins CI )


Let show how this work on a previous \`login' example. We need to ensure that user is logged in before
doing some other action, like checking email list:

    # email/list/get.txt
    200 OK
    email list

    # email/list/hook.pm
    run_swat_module( POST => '/login', { user => 'alex', password => 'swat' } )  

    # and finally this is
    # login/post.txt
    200 OK

    # login/swat.ini
    swat_module=1 # this story is a swat module
    curl_params="-d 'user=%user%' -d 'password=%password%'"

Here are the brief comments to the example above:

* \`set_module=1' declare swat story as swat module; now swat will never execute this story directly, upstream story should call it.

* call \`run\_swat\_module(method,resource,variables)' function inside upstream story hook to run downstream story.

* you can call as many downstream stories as you wish.

* you can call the same downstream story more than once.

Here is an example code snippet:

    # hook.pm
    run_swat_module( GET => '/foo/' )
    run_swat_module( POST => '/foo/bar' )
    run_swat_module( GET => '/foo/' )


* swat modules have a variables

Use hash passed as third parameter of run_swat_module function:

    run_swat_module( GET => '/foo', { var1 => 'value1', var2 => 'value2', var3=>'value3'   }  )

Swat _interpolates_ module variables into \`curl_params' variable in swat module story:


    # swat module
    # swat.ini
    swat_module=1
    # initial value of curl_params variable:
    curl_params='-d var1=%var1% -d var2=%var2% -d var3=%var3%'

    # real value of curl_params variable
    # during execution of swat module:
    curl_param='-d var1=value1 -d var2=value2 -d var3=value3'


Use `%[\w\d_]+%` placeholders in a curl_params variable to insert module variables here

Access to a module variables is provided by \`module_variable' function:

    # hook.pm
    module_variable('var1');
    module_variable('var2');

* swat modules could call other swat modules

* you can't use module variables in a story which is not a swat_module

One word about sharing state between upstream story and swat modules. As swat modules get executed in the same process
as upstream story there is no magic about sharing data between upstream and downstream stories.
The straightforward way to share state is to use global variables :

    # upstream story hook:
    our $state = [ 'this is upstream story' ]

    # downstream story hook:
    push our @$state, 'I was here'
   
Of course more proper approaches for state sharing could be used as singeltones or something else.

## swat variables accessors

There are some accessors to a common swat variables:

* project\_root\_dir()

* test\_root\_dir()

* resource()

* resource\_dir()

* http\_method()

* hostname()

* ignore\_http\_err()

* config() - returns hash of test suite configuration

See [test suite ini file](#test-suite-ini-file) section for details.

Be aware of that these functions are readers.

## meta stories

Meta stories are special type of swat stories. 

The essential property of meta story is it has no related http request:

    # foo/bar story
    mkdir foo/bar

    # it's a meta story
    touch foo/bar/meta.txt

As meta story does not have any related http request, it has no \`http method' file either.

A `meta.txt' file should be treated as meta request file denoted that story is meta.

You may live \`meta.txt' empty file or add some useful description to be printed  when story is executed:

    nano foo/bar/meta.txt

        This is my cool story. 
        Take a look at this!

How one could use meta stories?

Meta stories are just _containers_ for other downstream stories. Usually one defines some downstream
stories call inside meta story's hook file:

    nano foo/bar/hook.pm

        run_swat_module( POST => '/baz' );
        run_swat_module( POST => '/baz/bar' );



Meta stories are very close to upstream stories with spoofed server response, 
with the only exclusion that as meta story has no real http request related to it, 
there is no need for spoofing.


Meta stories can be also called as downstream stories:

    # I am downstream story
    # you can call me from somewhere else
    nano foo/bar/swat.ini
        swat_module=1


## PERL5LIB

Swat adds \`project\_root\_directory/lib' path to PERL5LIB path, which make it easy to add some modules and use them:

    # my-app/lib/Foo/Bar/Baz.pm
    package Foo::Bar::Baz;
    ...
   
    # hook.pm
    use Foo::Bar::Baz;
    ...
   

# Swat runner

Swat runner - is a script to run swat stories. It is called `swat`.

Runner consequentially goes several phases:

## A compilation phase.

Stories are converted into perl test files \*.t ( compilation phase ) and saved into temporary directory.

## An execution phase.

[Prove](https://metacpan.org/pod/distribution/Test-Harness/bin/prove) utility recursively executes
test files under temporary directory and thus gives a final suite execution status.

So after all swat project is just perl test project with \*.t files inside, the difference is that
while with common test project \*.t files _are created by user_, in outthentic project \*.t files _are generated_
by story files.


# TAP

Swat produces output in [TAP](https://testanything.org/) format, that means you may use your favorite tap parsers to bring result to
another test / reporting systems, follow TAP documentation to get more on this.

Here is example for converting swat tests into JUNIT format:

    swat --prove '--formatter TAP::Formatter::JUnit'

# Prove settings

Swat utilize [prove utility](http://search.cpan.org/perldoc?prove) to run tests, 
all prove related parameters could be passed via \`--prove' option to prove runner.

Here are some examples:

    swat --prove -Q # don't show anythings unless test summary

    swat --prove '-q -s' # run prove tests in random and quite mode


# Suite configuration

Swat test suites could be configurable. Configuration files contain a supplemental data to adjust suite behavior

There are two type of configuration files are supported:

* .Ini style format
* YAML format

.Ini  style configuration files are passed by \`--ini' parameter

    $ swat --ini /etc/suites/foo.ini

    $ cat /etc/suites/foo.ini

    [main]

    foo = 1
    bar = 2

There is no special magic behind ini files, except this should be [Config Tiny](https://metacpan.org/pod/Config::Tiny) compliant configuration file.

Or you can choose YAML format for suite configuration by using \`--yaml' parameter:

    $ swat --ini /etc/suites/foo.yaml

    $ cat /etc/suites/foo.yaml

    main:
      foo : 1
      bar : 2


Unless user sets path to configuration file explicitly by \`--ini' or \'--yaml' swat runner looks for the 
files named suite.ini and _then_ ( if suite.ini is not found ) for suite.yaml at the current working directory.

If configuration file is passed and read a related configuration data is accessible via config() function, for example in story.pm file:

    # cat story.pm

    my $foo = config()->{main}{foo};
    my $bar = config()->{main}{bar};

# Misc settings

* swat\_purge\_cache

    * Set to \`1', in case you need to clear swat cache directory, useful when swat tests get run periodically and a lot of cache files are created.
    * Default value is \`0' ( do not clear cache ).

* swat\_disable\_color - disable color output

    * Set this 1 if you want to disable color output in swat test report. 

    * By default this setting is off.

* output_mod - setting TAP output mode

    * \`cpanparty' - format output for cpanparty service

    * `\default' - this is default value, no formatting at all 

# Swat client

Once swat is installed you get swat client at the \`PATH':

    swat [[project_root_dir] [host:port]] [swat_command_line_parameters]

* **project\_root\_dir** - swat project root directory

In case you don't set one, swat assume it equal to current working directory. Examples:

    # setup project root directory explicitly
    swat /foo/bar/baz

    # project root directory is CWD
    swat 

* **host** - basic URL of tested application, should be in curl compatible format

In case host parameter is missing , swat tries to read it up from \`host' file. Examples:

    # setup host explicitly
    swat /foo/bar/baz 127.0.0.1

    # host entry gets read from CWD/host file 
    swat /foo/bar/baz
 
    # project root directory is CWD
    # host entry gets read from CWD/host file 
    swat

List of swat command line parameters:

* **--prove|prove-opts** - sets prove parameters

See [prove settings](prove-settings)

* **-t|--test**

Sets a distinct sub sets of stories to execute, see [Running subset of stories](#Running-subset-of-stories)

* **--ini** - suite configuration ini file path

* **--yaml** - suite configuration yaml file path

See [suite configuration](#suite-configuration) section for details.

* **--debug|d** - sets value for swat debug parameter

Override the value for swat debug variable, see [swat variables](#swat-variables) section:

    debug=1 swat --debug 2 # set debug to 2

# Running subset of stories

Use \`-t' options to execute a subset of swat stories:

    # run `FOO/*' stories
    swat example/my-app 127.0.0.1 -t FOO/

* \`-t' option should point to a resource(s) path and be relative to the project root directory 

* \`-t' option should not contain extension part - \`.txt'

* it is possible to use more than one \`t' options

For example:

    -t FOO/BAR -t BAR -t FOO/BAZ  

* Or even path more than one argument for -t parameter:

For example:

    -t FOO/BAR FOO/BAZ BAR

# Examples

There is plenty of examples at ./examples directory

# AUTHOR

[Aleksei Melezhik](mailto:melezhik@gmail.com)

# Home Page

http://swatpm.org

# See also

* [Sparrow](https://github.com/melezhik/sparrow) - outthentic suites manager.

* [Outthentic](https://github.com/melezhik/outthentic) - generic testing, reporting, monitoring framework consuming Outthentic::DSL.

* [Outthentic::DSL](https://github.com/melezhik/outthentic-dsl) - Outthentic::DSL specification.


* Perl prove, TAP, Test::More

# Thanks

To God as the One Who inspires me to do my job!

