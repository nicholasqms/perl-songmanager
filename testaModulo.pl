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
use songmanager ':all';

open FILE, "songs/song1.txt" or die "Couldn't open file: $!";
my $arquivo = do {local $/; <FILE>};

my $data = EncontraAutor($arquivo);
print "Autor: $data";
close FILE;

PesquisaGlobal("p","walk");