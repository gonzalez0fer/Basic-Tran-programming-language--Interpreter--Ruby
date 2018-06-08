#!/usr/bin/env ruby

# = Main.rb
#
#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 
#
#

require_relative 'Lexer'
require_relative 'Parser'

def main
    if ARGV.length != 1
    puts "Solo admite un parametro, el nombre del archivo."
    exit;
    end
    archivo = File::read(ARGV[0])
    begin
        #creamos un Lexer que analice la entrada
        lexer = Lexer::new archivo
        tokens, errores = lexer.leer()
        if !errores.empty?
            errores.each do |imp|
                imp.imprimir()
            end
        else
            begin
                pars = Parser.new()
                ast =  pars.parse(tokens)
                puts ast.to_s()
                rescue ErrorSintactico => e
                puts e
                return

            end
        end
    end
end

main