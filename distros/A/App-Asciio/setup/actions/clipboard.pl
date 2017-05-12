
use List::Util qw(min max) ;

#----------------------------------------------------------------------------------------------

register_action_handlers
	(
	'Copy to clipboard' => 
		[
		['C00-c', 'C00-Insert']
		, \&copy_to_clipboard
		],
		
	'Insert from clipboard' => 
		[
		['C00-v', '00S-Insert']
		, \&insert_from_clipboard
		],
	) ;


#----------------------------------------------------------------------------------------------

sub copy_to_clipboard
{
my ($self) = @_ ;

my @selected_elements = $self->get_selected_elements(1) ;
return unless @selected_elements ;

my %selected_elements = map { $_ => 1} @selected_elements ;

my @connections =
	grep 
		{
		exists $selected_elements{$_->{CONNECTED}} && exists $selected_elements{$_->{CONNECTEE}}
		} 
		$self->get_connections_containing(@selected_elements)  ;

my $elements_and_connections =
	{
	ELEMENTS =>  \@selected_elements,
	CONNECTIONS => \@connections ,
	};
	
$self->{CLIPBOARD} =  Clone::clone($elements_and_connections) ;
} ;	
	
#----------------------------------------------------------------------------------------------

sub insert_from_clipboard
{
my ($self, $x_offset, $y_offset) = @_ ;

if(defined $self->{CLIPBOARD}{ELEMENTS} && @{$self->{CLIPBOARD}{ELEMENTS}})
	{
	$self->create_undo_snapshot() ;

	$self->deselect_all_elements() ;
		
	unless(defined $x_offset)
		{
		my $min_x = min(map {$_->{X}} @{$self->{CLIPBOARD}{ELEMENTS}}) ;
		$x_offset = $min_x - $self->{MOUSE_X} ;
		}

	unless(defined $y_offset)
		{
		my $min_y = min(map {$_->{Y}} @{$self->{CLIPBOARD}{ELEMENTS}}) ;
		$y_offset = $min_y  - $self->{MOUSE_Y} ;
		}

	my %new_group ;

	for my $element (@{$self->{CLIPBOARD}{ELEMENTS}})
		{
		@$element{'X', 'Y'}= ($element->{X} - $x_offset, $element->{Y} - $y_offset) ;
					
		if(exists $element->{GROUP} && scalar(@{$element->{GROUP}}) > 0)
			{
			my $group = $element->{GROUP}[-1] ;
			
			unless(exists $new_group{$group})
				{
				$new_group{$group} = {'GROUP_COLOR' => $self->get_group_color()} ;
				}
				
			pop @{$element->{GROUP}} ;
			push @{$element->{GROUP}}, $new_group{$group} ;
			}
		else
			{
			delete $element->{GROUP} ;
			}
		}

	my $clipboard = Clone::clone($self->{CLIPBOARD}) ;

	$self->add_elements_no_connection(@{$clipboard->{ELEMENTS}}) ;
	$self->add_connections(@{$clipboard->{CONNECTIONS}}) ;

	$self->update_display() ;
	}
} ;	
	
