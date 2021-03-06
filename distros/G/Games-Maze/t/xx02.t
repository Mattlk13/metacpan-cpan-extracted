#
#
#

use Test::Simple tests => 4;

use Games::Maze;

my $correct_make = 
q(                                 
             __/  \__               
          __/   __/  \__            
       __/   __/  \     \__         
    __/   __/  \     \  /  \__      
 __/   __/  \     \__/  \     \__   
/   __/  \     \__/   __/  \  /  \  
\  /  \     \__/   __/  \  /  \  /  
/  \     \__/   __/  \     \  /  \  
\  /  \__/   __/  \     \__/  \  /  
/  \  /   __/  \     \__/   __/  \  
\  /  \  /  \     \__/   __/  \  /  
/  \  /  \     \__/   __/  \     \  
\__   \  /  \__/   __/  \     \__/  
   \__/  \  /   __/  \     \  /     
      \__   \  /  \     \__/        
         \__/  \     \__/           
            \__   \__/              
               \__/                 
                                    
                                    
);

my $correct_solve = 
q(                                 
             __/ *\__               
          __/ * __/ *\__            
       __/ * __/ *\    *\__         
    __/ * __/ *\    *\  / *\__      
 __/ * __/ *\    *\__/ *\    *\__   
/ * __/ *\    *\__/ * __/ *\  /  \  
\  / *\    *\__/ * __/ *\  / *\  /  
/ *\    *\__/ * __/ *\    *\  /  \  
\  / *\__/ * __/ *\    *\__/ *\  /  
/ *\  / * __/ *\    *\__/ * __/  \  
\  / *\  / *\    *\__/ * __/  \  /  
/ *\  / *\    *\__/ * __/ *\     \  
\__  *\  / *\__/ * __/ *\    *\__/  
   \__/ *\  / * __/ *\    *\  /     
      \__  *\  / *\    *\__/        
         \__/ *\    *\__/           
            \__  *\__/              
               \__/                 
                                    
                                    
);

my $correct_hex =
q( 016b 016b 016b 016b 016b 014b 016b 0143 016b 016b 016b 016b 016b
 016b 016b 016b 014b 014b 8108 8009 8060 0143 0143 016b 016b 016b
 016b 014b 014b 8108 8108 8060 8060 8003 8022 8060 0143 0143 016b
 016b 8120 8108 8060 8060 8003 8003 8108 8009 8021 8022 0020 0163
 016b 8021 8060 8003 8003 8108 8108 8060 8060 8003 8021 0021 0161
 016b 8021 8021 8120 8108 8060 8060 8003 8003 8108 8009 0021 0161
 016b 8041 8021 8021 8060 8003 8003 8108 8108 8060 0060 0003 0161
 016b 016b 8003 8041 8021 8120 8108 8060 8060 8003 8023 0169 0169
 016b 016b 016b 016b 8003 8041 8060 8003 8003 0169 0169 016b 016b
 016b 016b 016b 016b 016b 016b 8003 0169 0169 016b 016b 016b 016b
 016b 016b 016b 016b 016b 016b 016b 016b 016b 016b 016b 016b 016b
);

my $minos = Games::Maze->new(
		dimensions => [6, 4, 1], cell => 'hex', form => 'Hexagon',
		entry => [6,1,1], exit => [10,7,1],
		start => [6,1,1], fn_choosedir => \&first_dir
		);


$minos->make();
my $maze_form = $minos->to_ascii();
ok(($maze_form eq $correct_make), "->make() check");

$minos->solve();
$maze_form = $minos->to_ascii();
ok(($maze_form eq $correct_solve), "->solve() check");

$maze_form = $minos->to_hex_dump();
ok(($maze_form eq $correct_hex), "->to_hex_dump() check");

$minos->unsolve();
$maze_form = $minos->to_ascii();
ok(($maze_form eq $correct_make), "->unsolve() check");

exit(0);

sub first_dir
{
	return ${$_[0]}[0];
}
