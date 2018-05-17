#!/usr/bin/ruby
# = Lexer.rb
#
#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 
#
#

class ObjetoDeTexto
	attr_accessor :linea, :columna, :contenido
end

#Como la mayoria de las clases tienen un contenido vacio, pondremos en la clase Token contenido vacio,
#mas adelante modificaremos el contenido a aquellas que lo requieran
class Token < ObjetoDeTexto
	class << self
		attr_accessor :basicTran
	end
	attr_accessor :linea, :columna

end
class ErrorLexicografico < ObjetoDeTexto
	def initialize(linea, columna, contenido)
    	@linea   = linea
    	@columna = columna
    	@contenido   = contenido
  	end
   	def imprimir()
   		puts "Error: caracter inesperado \"#{@contenido}\" en línea #{@linea}, columna #{@columna}."
  	end
end

#definimos el Diccionario de las ER para los tokens existentes

dicTokens = {
	'Punto' => /\A\./           ,
	'Num' => /^[0-9]*$/                   ,
	'Caracter' => /^\'.*\'$/,
	'Id' => /^[a-z][a-zA-Z0-9_]*/,
	
	'Coma' => /\A,/		       ,
	'DosPuntos' => /\A:/       ,
	'ParAbre' => /\A\(/       ,
	'ParCierra' => /\A\)/      ,
	'CorcheteAbre' => /\A\[/   ,
	'CorcheteCierre' => /\A\]/ ,
	'LlaveAbre' => /\A\{/      ,
	'LlaveCierra' => /\A\}/	   ,
	'Resta' =>/\A-(?!>)$/ 		,
	'Hacer' =>/\A->(?!>)/         ,
	'Asignacion' => /\A<-(?!-)/   ,
	'Suma' => /\A\+/              ,
	'Desigualdad' => /\A\/=/	,
	'PuntoYComa' => /\A;/ ,
	'Mult' => /\A\*/              ,
	'Div' => /\A\/(?!=)/          ,
	'Mod' => /\A%(?!=)/           ,
	'Conjuncion' => /\A\/\\/      ,
	'Disyuncion' => /\A\\\//      ,
	'Negacion' => /\Anot/         ,
	'Menor' => /\A<$/              ,
	'MenorIgual' => /\A<=/        ,
	'Mayor' => /\A>$/              ,
	'MayorIgual' => /\A>=/        ,
	'Igual' => /\A=/              ,
	'SiguienteCar' => /\A\+\+/    ,
	'AnteriorCar' => /\A--/       ,
	'ValorAscii' => /\A#/                 ,
	'Concatenacion' => /\A::/             ,
	'Shift' => /\A\$/                     ,
	
}

#Escribimos las palabras reservadas del lenguaje
palabras_reservadas = %w(with true false var begin end int while if else bool char array read of)

#Procedemos a meter dentro de nuestro diccionario de tokens, los
#tokens relacionados a nuestras palabras reservadas.
palabras_reservadas.each do |tpr|
	dicTokens[tpr.capitalize] = /\A#{tpr}\b/
end

#Creamos las clases para cada tipo de token que poseemos en nuestro diccionario de tokens,
#(las cuales pertenecen a la clase Token) , las mismas se inicializan para tener el contexto
#del token esto incluye: linea y columna donde es encontrado el texto y el posible contenido
#que tenga el token, luego procedemos a renombrar cada clase como TK + nombre del token
dicTokens.each do |name, basicTran|
	nuevaClase = Class::new(Token) do
		@basicTran = basicTran

		def initialize(linea, columna, contenido)
			@linea = linea
			@columna = columna
			@contenido = contenido
		end

	end

	Object::const_set "Tk#{name}", nuevaClase
end

$dicTokens = []
ObjectSpace.each_object(Class) do |obj|
	$dicTokens << obj if obj.ancestors.include? Token and obj!=TkId and obj!=Token
end

class Token
	def cont
		''
	end
	def imprimir
		puts "#{self.class.name} #{cont} #{@linea},#{@columna}"
	end
end
#como TkNum, TkId, TkCaracter deben almacenar algun tipo de contenido vamos a modificar directamente
#esas clases

class TkNum
	#debe devolver el numero para poder imprimirlo por pantalla
	def cont
		@contenido.inspect
	end
	def imprimir
		puts "#{self.class.name} (#{cont}) #{@linea},#{@columna}"
	end
end

class TkId
	#debe devolver el identificador de la variable que corresponde al acompañante de un var
	def cont
		@contenido.inspect
	end
	def imprimir
		puts "#{self.class.name} (#{cont}) #{@linea},#{@columna}"
	end
end

class TkCaracter
	#debe devolver el string que se encuentra entre comillas simples o dobles
	def cont
		a = @contenido.inspect
		real = a[1..-3] + '\''
		return real
	end
	def imprimir
		puts "#{self.class.name} #{cont} #{@linea},#{@columna}"
	end

end

class Lexer
	attr_reader :tokens, :errores

	def to_exception
		ExcepcionLexer::new self
	end

	def initialize(archivo)
		@errores = []
		@tokens = []
		@linea = 1
		@columna = 1
		@archivo = archivo
	end

	def buscar(p)
			$dicTokens.each do |t|
				if p =~ t.basicTran
					#puts "hizo match #{t}"
						nuevo = t.new(@linea,@colInicio,p)
						@tokens << nuevo
						return
				end
			end
			if p =~ /^[a-z][a-zA-Z0-9_]*/
				nuevo = TkId.new(@linea,@colInicio,p)
				@tokens << nuevo
				return
			else
				
				error = ErrorLexicografico.new(@linea,@colInicio,p)
				@errores << error
				return
			end
	end

	def mostrarResultado()
		if @errores.empty?
			@tokens.each do |l|
				l.imprimir
			end
		else
			@errores.each do |imp|
				imp.imprimir()
			end
		end
	end

	def leer()
		p = ''
		@var = []
		str = 0 	#semaforo para detectar cadena de caracteres de mas de una palabra
		num = 0 	#semaforo para detectar numeros pegados a otras cosas
		sim = 0 	#semaforo para detectar simbolos pegados a otras cosas
		ltr = 0 
		@colInicio= @columna
		return nil if @archivo.empty?
		@archivo.each_char do |simbolo|
			if ((simbolo == " ") or (simbolo == "\t")) && str == 0
				if p!= ''
					buscar(p)
					@columna += 1
					@colInicio= @columna
					num = 0
					sim = 0
					ltr=0
					p = ''
				else
					@columna += 1
					@colInicio= @columna
				end
			elsif (simbolo =="\n")
				puts "estoy slach:  #{p}"
				if p!= ''
					buscar(p)
					@linea += 1
					@columna = 1
					@colInicio= @columna
					p = ''
					num = 0
					sim = 0
					ltr=0
				else
					@columna += 1
				end
			elsif simbolo=~ TkNum.basicTran && p==''
					@columna += 1
					num = 1
					p = p + simbolo
										
			elsif simbolo=~ TkNum.basicTran && sim ==1
					buscar(p)
					num = 1
					sim = 0
					ltr=0
					p =''
					@columna += 1
					@colInicio= @columna
					p = p + simbolo
					puts p
			elsif simbolo=~ TkNum.basicTran && num == 1
					@columna += 1
					p = p + simbolo
										
			elsif !(simbolo=~ TkNum.basicTran) && num == 1
										
					num = 0
					buscar(p)
					
					@colInicio= @columna
					@columna += 1
					p = ''
					if simbolo=~ TkId.basicTran
						p = p + simbolo
						ltr = 1
					elsif simbolo == "-"|| simbolo=="+"|| simbolo == "<" || simbolo =="=" || simbolo =="."|| simbolo ==","|| simbolo ==";"|| simbolo ==":" || simbolo ==">" || simbolo =="/" || simbolo =="\\"
						sim = 1
						p =p +simbolo
						puts p
					end
			elsif simbolo=~ TkId.basicTran && sim == 1
					sim = 0
					buscar(p)
					@columna += 1
					@colInicio= @columna
					p=''
					p =p +simbolo

			elsif not(simbolo=~ TkId.basicTran) && sim ==1
					sim = 0
					p =p +simbolo
					buscar(p)
					@columna += 1
					@colInicio= @columna
					p = ''
			elsif simbolo=~ TkId.basicTran
					p =p +simbolo
					@columna += 1
					ltr = 1
					puts "hola #{p}"
			elsif simbolo=~ TkNum.basicTran && ltr == 1
					p =p +simbolo
					@columna += 1
			elsif !(simbolo=~ TkId.basicTran) && ltr == 1
				buscar(p)
				ltr =0
				p=''
				sim = 1
				p =p +simbolo
				@colInicio= @columna
				@columna += 1
				puts "entre: soy #{p}"
			elsif !(simbolo=~ TkId.basicTran)
				sim = 1
				p =p +simbolo
				@columna += 1 
				puts "entre: soy #{p}"
			elsif (simbolo == '\'')
				str += 1
				p = p + simbolo
				@columna += 1
				if str == 2
					buscar(p)
					@colInicio= @columna
					str = 0
					p = ''
				end
			
			else
				p = p + simbolo
				@columna += 1
									puts "default: soy #{p}"
			end

		end
		mostrarResultado()
	end
end

if ARGV.length != 1
    puts "We need exactly one parameter. The name of a file."
    exit;
end
archivo = File::read(ARGV[0])
#creamos un Lexer que analice la entrada
lexer = Lexer::new archivo
lexer.leer()
