#
#   Universidade Federal do Rio de Janeiro
#   Departamento de Eletronica e de Computacao
#   Linguagens de Programacao
#
#   Trabalho 02 - Perl para trabalhar com as letras de música
#
#   Grupo:
#      Krishynan Shanty
#      Nicholas Quagliani

use warnings;
use strict;
sub encontraData{
	my $arquivo = $_[0];
	my ($dia,$mes,$ano);
	
	print $arquivo;
	($dia, $mes, $ano) = ($arquivo =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/);
	print "dentro|", $dia, $mes, $ano, "|dentro\n";
	return ($dia,$mes,$ano);
}

local $/=undef;
open FILE, "songs/song1.txt" or die "Couldn't open file: $!";
my $string = <FILE>;

print "antes|", $string, "|antes\n";
my @data = encontraData($string);
print @data, "\n";
print "depois\n";
close FILE;