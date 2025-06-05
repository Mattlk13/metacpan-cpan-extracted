use Test::More;
use Doubly;

ok(my $linked_list = Doubly->new());

ok($linked_list->insert(sub { 1 }, { c => 3 })); # first always get set
#ok($linked_list = $linked_list->insert(sub{ $_[0]->{c} == 3 }, { b => 2 }));
#ok($linked_list->insert(sub {$_[0]->{b} == 2}, { a => 1 }));

ok($linked_list = $linked_list->start);

is($linked_list->data->{c}, 3);
#is($linked_list->next->data->{b}, 2);
#is($linked_list->next->next->data->{c}, 3);

done_testing();
