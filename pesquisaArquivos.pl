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

sub encontraLetraDupla{
	my $arquivo = $_[0];
	my $trecho1 = $_[1];
	my $trecho2 = $_[2];
	my $arquivoUmaLinha = $arquivo;
	
	$arquivoUmaLinha =~ tr{\n\n}{ };
	$arquivoUmaLinha =~ tr{\n}{ };
	if ($arquivoUmaLinha =~ /\sLetra:.*$trecho1.*$trecho2.*/i) {
		return $arquivo;
	}
	return 0;
}

sub encontraAutor{
	my $arquivo = $_[0];
	my ($autor);
	
	($autor) = ($arquivo =~ /^Autor:([^\n\r]*)/i);
	return $autor;
}

sub encontraTitulo{
	my $arquivo = $_[0];
	my ($titulo);
	
	($titulo) = ($arquivo =~ /[\n\r]Titulo:([^\n\r]*)/i);
	return $titulo;
}

sub encontraLetra{
	my $arquivo = $_[0];
	my $trecho = $_[1];
	my $arquivoUmaLinha = $arquivo;
	
	$arquivoUmaLinha =~ tr{\n\n}{ };
	$arquivoUmaLinha =~ tr{\n}{ };
	if ($arquivoUmaLinha =~ /\sLetra:.*$trecho.*/i) {
		return 1;
	}
	return 0;
}

sub encontraData{
	my $arquivo = $_[0];
	my ($dia,$mes,$ano);
	
	($dia, $mes, $ano) = ($arquivo =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/);
	return ($dia,$mes,$ano);
}

sub pesquisaGlobal{
my $tipoPesquisa = $_[0];
my $procurado = $_[1];
my $termo1 = $_[2];
my @arquivos = <songs/*.txt>;
my ($achados,$atual,$dia,$mes,$ano);
$achados = "";
	foreach my $arquivos (@arquivos) {
		open FILE, $arquivos or die "Couldn't open file: $!";
		my $arquivo = do {local $/; <FILE>};
		
		if ($tipoPesquisa =~ /a(?:utor)?/i) {
			$atual = encontraAutor($arquivo);
			if ($atual=~ /^$procurado$/i) {
				$achados .= "Musica dele:";
				$achados .= encontraTitulo($arquivo);
				$achados .= "\n";
			}
			else {
				if ($atual =~ /[\w\s]*$procurado[\w\s]*/i) {
					if (!($achados =~ /[\w\s]*$atual[\w\s]*/i)){
						$achados .= "Artista possivel:$atual\n";
					}
				}
			}
		}
		if ($tipoPesquisa =~ /t(?:itulo)?/i) {
			if ($atual=~ /[\w\s]*$procurado[\w\s]*/i) {
				$achados .= $atual;
				$achados .= "\n";
			}		
		}
		if ($tipoPesquisa =~ /p(?:edaço)?/i) {
			if (encontraLetra($arquivo,$termo1)) {
				$achados .= encontraTitulo($arquivo);
				$achados .= "\n";
			}
		}
		if ($tipoPesquisa =~ /d(?:upla)?/i) {
			if (encontraLetraDupla($procurado,$termo1)) {
				$achados .= encontraTitulo($arquivo);
				$achados .= "\n";
			}			
		}
		if ($tipoPesquisa =~ /L(?:ançamento)?/i) {
			($dia,$mes,$ano) = encontraAutor($arquivo);#nao uso o dia e o mes pra nada ainda, fica pro futuro
			if ($procurado==$ano) {
				$achados .= encontraTitulo($arquivo);
				$achados .= "\n";
			}			
		}
	}
	print "Procurou por: $procurado\n";
	print "Encontrados:\n$achados";
}

pesquisaGlobal("a","Michael");