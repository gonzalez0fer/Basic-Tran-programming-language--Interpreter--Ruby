#Irina Marcano 13-10805
#Fernando Gonzalez 08-10464 

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
   def imprimir
    "Error: caracter inesperado \"#{@contenido}\" en línea #{@linea}, columna #{@columna}."
  end
end

#definimos el Diccionario de las ER para los tokens existentes

dicTokens = {
	'Num' => /\A[0-9]+/                   ,
	'Id' => /\A([a-zA-Z_][a-z0-9A-Z_]*)/  ,
	'Caracter' => /\A'([^"\\]|\\[n\\"])*'/,
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
		if @tokens.last.class.name =="TkVar"
			nuevo = TkId.new(@linea,@colInicio, p)
			@tokens << nuevo
			@var << p
			return
		end
		@var.each do |v|
			if p == v
				nuevo = TkId.new(@linea,@colInicio, p)
				@tokens << nuevo
				return
			end
		end
		$dicTokens.each do |t|
			if p =~ t.basicTran 
			#falta ver el contenido
				nuevo = t.new(@linea,@colInicio,' ')
				@tokens << nuevo
				break
			else
				error = ErrorLexicografico.new(@linea,@colInicio,' ')
				@errores << error
			end
		end
	end

	def leer()
		p = ''
		@var = []
		@colInicio= @columna
		return nil if @archivo.empty?
		@archivo.each_char do |simbolo|
			#puts "ahora la columna es #{@columna}"
			if (simbolo == ' ') or (simbolo == '	')
				#puts "estoy espacio #{p}"
				buscar(p)
				@columna += 1
				@colInicio= @columna
				p = ''
			elsif (simbolo =="\n")
				#puts "estoy slach #{p} #{@columna}"
				buscar(p)
				@linea += 1
				@columna = 1
				@colInicio= @columna
				p = ''
			else
				p = p + simbolo
				@columna += 1
			end
		end
		@tokens.each do |l|
			l.imprimir
		end
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