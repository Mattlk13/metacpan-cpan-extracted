#!/usr/bin/perl

no utf8;

# Net::Radius test input
# Made with $Id: cisco-acs-ar-01.p 64 2007-01-09 20:01:04Z lem $

$VAR1 = {
          'packet' => '� Vb���͑��v�D�mdia27�mo  � CiscoSecure ACS v4.0(1.27)ke��`���f~�]�',
          'secret' => undef,
          'description' => 'CiscoSecure ACS v4.0 (1.27) - Access-Request',
          'authenticator' => 'b���͑��v�D�',
          'identifier' => 214,
          'dictionary' => undef,
          'opts' => {
                      'secret' => undef,
                      'output' => 'packets/cisco-acs-ar-01',
                      'description' => 'CiscoSecure ACS v4.0 (1.27) - Access-Request',
                      'authenticator' => 'b���͑��v�D�',
                      'identifier' => 214,
                      'dictionary' => [
                                        'dicts/dictionary'
                                      ],
                      'dont-embed-dict' => 1,
                      'noprompt' => 1,
                      'slots' => 5
                    },
          'slots' => 5
        };
