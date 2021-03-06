# configuration file for GMA programs, including SIMR and map2lm 
# Copyright (C) 2000 by I. Dan Melamed

# All parameters are mandatory unless otherwise indicated.
# Lines starting with '#' like this one are comments and will be ignored.
# Other lines should have the parameter name and value(s) separated by whitespace.

# This is the master configuration file, but it can "include" other
# configuration files like this: #INCLUDE	another_config_file_name
# This is useful if you want to, e.g., separate out the numeric
# parameters for optimization.
# You must specify explicit path names for the #INCLUDE'd config files.

#############################################################################
# End of segment marker
# MAKE SURE THERE IS NO CARRIAGE RETURN AT THE END OF THE MARKER !!!
# I.e. the parameter line should end with only a newline, not CR+NL.
# Otherwise, the CR becomes part of the EOSMarker, which will not
# match the markers in the axes, so GMA will think that the whole input
# is just one line.

###############################################
##				   	     ##
## ----- property file for GMA program ----- ##
## 			  	      	     ##
###############################################



## ----- program parameters -----



####################
##
## end of segment marker
##
##
####################

eosMarker = <EOS>

# SIMR parameters
#
# <changepath>
#INCLUDE ./config/SIMR.config.F.E

# GSA parameters
#
# <changepath>
#INCLUDE ./config/GSA.config.default




## ----- input file parameters -----



####################
##
## X axis file
##
## usually specified as command line argument
## uncomment if needed
##
####################

# <changepath>
#xAxisFile = ./validation/french-test1.axis



####################
##
## Y axis file
##
## usually specified as command line argument
## uncomment if needed
##
####################

# <changepath>
#yAxisFile = ./validation/english-test1.axis



####################
##
## axis file suffix
##
## suffix to denote that X and Y axis files are converted from text to axis file
## default to axis
##
####################

axisFileSuffix = axis



####################
##
## X axis stop list file
##
## comment out if not needed
##
####################

# <changepath>
xStopWordFile = ./rc/french.stoplist



####################
##
## Y axis stop list file
##
## comment out if not needed
##
####################

# <changepath>
yStopWordFile = ./rc/english.stoplist



####################
##
## anchor file
##
## uncomment if needed
##
####################

#anchorFile = anc-file-name



## ----- output file parameters -----



####################
##
## SIMR output file
##
####################

# <changepath>
simr.outputFile = ./validation/temp/simrOutput.txt



####################
##
## GSA output file
##
####################

# <changepath>
gsa.outputFile = ./validation/temp/gsaOutput.txt




## ----- other parameters -----



