#!/usr/bin/env ruby
require 'Lexer'

def main
	$ErroresContexto = []

	# Leemos la entrada del archivo
	archivo = File::read(ARGV[0])

	#creamos un Lexer

	L = Lexer::new archivo
end