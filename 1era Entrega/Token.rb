#Irina Marcano 13-10805
#Fernando Gonzalez 08-10464 

#Como la mayoria de las clases tienen un contenido vacio, pondremos en la clase Token contenido vacio,
#mas adelante modificaremos el contenido a aquellas que lo requieran
class Token < ObjetoDeTexto
	class << self
		attr_accesor :regex
	end
	attr_accesor :linea, :columna, :contenido

	def cont
		''
	end

	def imprimir
		 "#{self.class.name} #{cont} #{@linea},#{@columna}"
end

#definimos el Diccionario de las ER para los tokens existentes

tokens = {
	'Coma' => /\A,/		       ,
	'Punto' => /\A./           ,
	'DosPuntos' => /\A:/       ,
	'ParAbre' => /\A\( /       ,
	'ParCierra' => /\A\)/      ,
	'CorcheteAbre' => /\A\[/   ,
	'CorcheteCierre' => /\A\]/ ,
	'LlaveAbre' => /\A\{/      ,
	'LlaveCierra' => /\A\}/	   ,
	'Hacer' =>/\A->(?!>)/         ,
	'Asignacion' => /\A<-(?!-)/   ,
	'Suma' => /\A\+/              ,
	'Resta' =>/\A-(?!>)/          ,
	'Mult' => /\A\*/              ,
	'Div' => /\A\/(?!=)/          ,
	'Mod' => /\A%(?!=)/           ,
	'Conjuncion' => /\A\/\\/      ,
	'Disyuncion' => /\A\\\//      ,
	'Negacion' => /\Anot/         ,
	'Menor' => /\A</              ,
	'MenorIgual' => /\A<=/        ,
	'Mayor' => /\A>/              ,
	'MayorIgual' => /\A=>/        ,
	'Igual' => /\A=/              ,
	'SiguienteCar' => /\A\+\+/    ,
	'AnteriorCar' => /\A--/       ,
	'ValorAscii' => /\A#/                 ,
	'Concatenacion' => /\A::/             ,
	'Shift' => /\A\$/                     ,
	'Num' => /\A[0-9]+/                   ,
	'Id' => /\A([a-zA-Z_][a-z0-9A-Z_]*)/  ,
	'Caracter' => /\A'([^"\\]|\\[n\\"])*'/,
}

#Escribimos las palabras reservadas del lenguaje
palabras_reservadas = %w(with true false var begin end int while if else bool char array read)

#Procedemos a meter dentro de nuestro diccionario de tokens, los
#tokens relacionados a nuestras palabras reservadas.
palabras_reservadas.each do |tpr|
	tokens[tpr.capitalize] = /\A#{tpr}\b/
end

#Creamos las clases para cada tipo de token que poseemos en nuestro diccionario de tokens,
#(las cuales pertenecen a la clase Token) , las mismas se inicializan para tener el contexto
#del token esto incluye: linea y columna donde es encontrado el texto y el posible contenido
#que tenga el token, luego procedemos a renombrar cada clase como TK + nombre del token
tokens.each do |name, regex|
	nuevaClase = Class::new(Token) do
		@regex = regex

		def initialize(linea, columna, contenido)
			@linea = linea
			@columna = columna
			@contenido = contenido
		end
	end

	Object::const_set "Tk#{name}", nuevaClase
end

#como TkNum, TkId, TkCaracter deben almacenar algun tipo de contenido vamos a modificar directamente
#esas clases

class TkNum
	#debe devolver el numero para poder imprimirlo por pantalla
	def cont
		@contenido.inspect
	end
	def imprimir
		"#{self.class.name} (#{cont}) #{@linea},#{@columna}"
	end
end

class TkId
	#debe devolver el identificador de la variable que corresponde al acompañante de un var
	def cont
		@contenido.inspect
	end
	def imprimir
		"#{self.class.name} ('"'#{cont}'"') #{@linea},#{@columna}"
end

class TkCaracter
	#debe devolver el string que se encuentra entre comillas simples o dobles
	def cont
		@contenido.inspect
	end
end

#procedemos a asignar los tipos a las clases que lo requieran
class TkInt
	def to_type
		Rangex::int 
	end
end
class TkBool
	def to_type
		Rangex::bool 
	end
end
class TkChar
	def to_type
		Rangex::char 
	end
end