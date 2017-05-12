package Lingua::Numending;
use utf8;
use 5.006;
use strict;
use warnings;

=head1 NAME

Lingua::Numending - Package generates morphological end of units.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 DESCRIPTION

Lingua :: Numending is a Perl module that provides provides the 
formation of morphological endings of any units for the East Slavic group of languages (Russian, Ukrainian, Belarusian).

=head1 SYNOPSIS

    # load module
    use Lingua::Numending qw(cyr_units);
    
    #Examples for the Russian language
    #Units: ���� (hours)
    printf cyr_units (72, "����� ��� ����");
    # 72 ����
    # Transliteration of above line is: 72 hours
    
    #Units: ������ (minutes)
    printf cyr_units (30, "����� ������ ������");
    # 30 �����
    # Transliteration of above line is: 30 minutes
    
    #Units: ������� (seconds)
    printf cyr_units (3, "������ ������� �������");
    # 3 �������
    # Transliteration of above line is: 3 seconds
    
    #Units: �������� (pages)
    printf cyr_units (20, "������� �������� ��������");
    # 20 �������
    # Transliteration of above line is: 20 pages
    
    #Units: ������� (drawings)
    printf cyr_units (5, "�������� ������� �������");
    # 5 ��������
    # Transliteration of above line is: 5 drawings
    
    #Units: ����� (rubles)
    printf cyr_units (200, "������ ����� �����");
    # 200 ������
    # Transliteration of above line is: 200 rubles
    
    #Examples for the Ukrainian language
    #Units: ���� (hours)
    printf cyr_units (72, "����� ������ ������");
    # 72 ������
    # Transliteration of above line is: 72 hours
    
    #Units: ������ (minutes)
    printf cyr_units (30, "������ ������� �������");
    # 30 ������
    # Transliteration of above line is: 30 minutes
    
    #Units: ������� (seconds)
    printf cyr_units (3, "������ ������� �������");
    # 3 �������
    # Transliteration of above line is: 3 seconds
    
    #Units: �������� (pages)
    printf cyr_units (20, "����i��� ����i��� ����i���");
    # 20 ����i���
    # Transliteration of above line is: 20 pages
    
    #Units: ������� (drawings)
    printf cyr_units (5, "������i� ������� �������");
    # 5 ������i�
    # Transliteration of above line is: 5 drawing
    
    #Units: ����� (rubles)
    printf cyr_units (200, "����i� ����� �����");
    # 200 ����i�
    # Transliteration of above line is: 200 rubles
    
    #Examples for the Belarusian language
    #Units: ���� (hours)
    printf cyr_units (72, "����i� ����i�� ����i��");
    # 72 ����i��
    # Transliteration of above line is: 72 hours
    
    #Units: ������ (minutes)
    printf cyr_units (30, "��i�i� ��i�i�� ��i�i��");
    # 30 ��i�i�
    # Transliteration of above line is: 30 minutes
    
    #Units: ������� (seconds)
    printf cyr_units (3, "������ ������� �������");
    # 3 �������
    # Transliteration of above line is: 3 seconds
    
    #Units: �������� (pages)
    printf cyr_units (20, "�������� �������� �������i");
    # 20 ��������
    # Transliteration of above line is: 20 pages
    
    #Units: ������� (drawings)
    printf cyr_units (5, "������� ������� �������");
    # 5 �������
    # Transliteration of above line is: 5 drawings
    
    #Units: ����� (rubles)
    printf cyr_units (200, "���븢 ������ �����");
    # 200 ���븢
    # Transliteration of above line is: 200 rubles
    
=head1 FUNCTIONS

=head2 cyr_units

English ending 's' plural in Cyrillic languages correspond to different endings and
package makes the right choice.

Function calculates and returns the category to which the number relates.
All three categories.

To tell time, say a  number such as ����, ���, ���, etc. + ���/����/�����. 

If the category number 1, use "���" for the word hour.

If the category number 2, use "����" for the word hours.

If the category number 0, use "�����" for the word hours.

=cut

# Exporter module to export names
use Exporter qw(import);  
# The names are placed in the array and they will be added to the namespace of the calling package
our @EXPORT_OK = qw(cyr_units);

sub cyr_units{
	my $count = shift @_;
	my $temp_str = shift @_;
	my @words = split / /, $temp_str;
	my $number;
	my $dec = $count %10;
	my $sot = $count %100;
	if ( ($dec == 1) && ($sot != 11) ) {$number = 1}
	elsif ( ($dec >= 2) && ($dec <= 4) && ($sot != 12) && ($sot != 13) && ($sot != 14) ) { $number = 2} # ��������� ����� 2;
	else {$number = 0};
	my $str = $_;
	$str = join " ", $count, $words[$number];
	return $str;
}

=head1 AUTHOR

Dariya Kirillova, C<< <kirillova at cpan.org> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::Numending

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Dariya Kirillova.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Lingua::Numending
