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
        lexer.leer()
        #puts "mis errores son: #{lexer.errores}"
        if !(lexer.errores.empty?)
            lexer.errores.each do |imp|
                imp.imprimir()
            end
        else
            begin

                puts "#{lexer.tokens}"
                pars = Parser.new(lexer.listaTokens)
                ast =  pars.parse

                puts ast.to_s()
                rescue ErrorSintactico => e

                puts "soy el problema: #{e}"
                return

            end
        end
    end
end

main