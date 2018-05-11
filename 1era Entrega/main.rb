#!/usr/bin/env ruby
require 'Lexer'

def main
	$ErroresContexto = []

	# Leemos la entrada del archivo
	archivo = File::read(ARGV[0])

	#creamos un Lexer que analice la entrada
	lexer = Lexer::new archivo

	aux = false
	while (!aux) do
		aux = lexer.yylex.nill?
	end
	
	puts lexer 
end

main