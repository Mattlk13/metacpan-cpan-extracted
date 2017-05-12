use Mojo::Base -strict;
use Test::Mojo;
use Test::More;

use Mojolicious::Lite;
post "/echo" => sub {
  my $c = shift->openapi->valid_input or return;
  my $data = {body => $c->validation->param("body")};
  $c->reply->openapi(200 => $data);
  },
  "echo";

plugin OpenAPI => {url => "data://main/echo.json"};

my $t = Test::Mojo->new;
$t->post_ok('/api/echo' => json => {foo => 123})->status_is(200)->json_is('/body/foo' => 123);

done_testing;

__DATA__
@@ echo.json
{
  "swagger" : "2.0",
  "info" : { "version": "0.8", "title" : "Pets" },
  "schemes" : [ "http" ],
  "basePath" : "/api",
  "paths" : {
    "/echo" : {
      "post" : {
        "x-mojo-name" : "echo",
        "parameters" : [
          { "in": "body", "name": "body", "schema": { "type" : "object" } }
        ],
        "responses" : {
          "200": {
            "description": "Echo response",
            "schema": { "type": "object" }
          }
        }
      }
    }
  }
}
