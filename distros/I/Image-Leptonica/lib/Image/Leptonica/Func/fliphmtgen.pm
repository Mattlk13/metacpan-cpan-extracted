package Image::Leptonica::Func::fliphmtgen;
$Image::Leptonica::Func::fliphmtgen::VERSION = '0.04';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Image::Leptonica::Func::fliphmtgen

=head1 VERSION

version 0.04

=head1 C<fliphmtgen.c>

    fliphmtgen.c

       DWA implementation of hit-miss transforms with auto-generated sels
       for pixOrientDetectDwa() and pixUpDownDetectDwa() in flipdetect.c

            PIX             *pixFlipFHMTGen()
              static l_int32   flipfhmtgen_low()  -- dispatcher
                static void      fhmt_1_0()
                static void      fhmt_1_1()
                static void      fhmt_1_2()
                static void      fhmt_1_3()

       The code (rearranged) was generated by prog/flipselgen.c

=head1 FUNCTIONS

=head2 pixFlipFHMTGen

PIX * pixFlipFHMTGen ( PIX *pixd, PIX *pixs, char *selname )

  pixFlipFHMTGen()

     Input:  pixd (usual 3 choices: null, == pixs, != pixs)
             pixs
             sel name (one of four defined in SEL_NAMES[])
     Return: pixd

     Action: hit-miss transform on pixs by the sel
     N.B.: the sel must have at least one hit, and it
           can have any number of misses.

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
