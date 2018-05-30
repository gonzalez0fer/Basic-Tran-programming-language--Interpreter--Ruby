#!/usr/bin/env ruby

# = Main.rb
#
#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 
#
#

require_relative 'Lexer'

def main
    if ARGV.length != 1
    puts "Solo admite un parametro, el nombre del archivo."
    exit;
    end
    archivo = File::read(ARGV[0])

    
    #creamos un Lexer que analice la entrada
    lexer = Lexer::new archivo
    lexer.leer()
end

main