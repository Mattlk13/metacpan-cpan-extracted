use ExtUtils::MakeMaker;
print <<'CAMEL_GREETING';
                   ######
    #####        #########
##########      ###########
 ##########    #############
   #######   ################
  ######## ###################
  ####### #####################
  #############################
   #############################
   ##############################
    #############################
     ######################### ##
       ## ############### #### ##
          ####  ########   ### #
          ###   #### ###   ###
          ###  ##### ##     ##
          ###  ####  ##     ##
          ##   #     ##     ##
          ##    #    #      #
          ##     #  #       #
          #       ###       #
          #      ## ##      #
         ##    ####  #     ##
       ####               ####
CAMEL_GREETING
WriteMakefile(
   NAME     => 'Acme::EyeDrops',
   VERSION  => '1.62',
   PL_FILES => {}
);
