use 5.012;
use warnings;
use lib 't/lib';
use PXSTest 'full';

# Child Class + Other Class in a single object (join)

ok(!defined new Panda::XS::Test::MyOther(0, 0), "output OEXT-join returns undef for NULL RETVALs");
my $obj = new Panda::XS::Test::MyOther(10, 20);
is(ref $obj, 'Panda::XS::Test::MyOther', "output OEXT-join returns object");
is($obj->val, 10, "input OEXT-join THIS base method works");
is($obj->val2, 20, "input OEXT-join THIS child method works");
is($obj->other_val, 30, "input OEXT-join THIS other method works");
$obj->set_from(undef);
is($obj->val.$obj->val2.$obj->other_val, "102030", "input arg for OEXT-join allows undefs");
ok(!eval{$obj->set_from(new Panda::XS::Test::MyChild(10, 20)); 1}, "input OEXT-join arg doesnt allow wrong type objects");
is($obj->val.$obj->val2.$obj->other_val, "102030", "input OEXT-join arg doesnt allow wrong type objects");
is(dcnt(), 2, 'tmp obj OEXT desctructors called');
$obj->set_from(new Panda::XS::Test::MyOther(30, 40));
is($obj->val.$obj->val2.$obj->other_val, "304070", "input OEXT-join arg works");
is(dcnt(), 5, 'tmp obj OEXT-join desctructors called');
undef $obj;
is(dcnt(), 8, 'obj OEXT-join desctructors called');

done_testing();
