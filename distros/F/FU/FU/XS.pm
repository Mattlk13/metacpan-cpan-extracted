# This module is for internal use by other FU modules.
package FU::XS 1.0;
use Carp; # may be called by XS.
use XSLoader;
XSLoader::load('FU');
1;
