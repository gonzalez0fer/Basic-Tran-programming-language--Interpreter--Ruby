
require_relative 'AST_yo'
require_relative 'Parser'

#crearemos nuestra tabla de scopes
$scopes = []
$scopeImp =[]
$tam = 0
$idFor = 0
$idF = ""
#verificamos si el id ya existe en la tabla de simbolos actuales
def existeYa(tabla, id)
	if tabla.empty?
		return false
	else
		return tabla.has_key?(id)
	end
end

def Encontrar(id)
	$scopes.each do |alcance|
		#puts alcance
		if existeYa(alcance,id)
			return true, alcance[id]
		end
	end

	return false, "error"
end

##############################################################
class ErrorYaExiste< ErrorContexto
	def initialize(token)
		@token = token
	end

	def to_s()
		"\n Error: Ya se encuentra declarada '#{@token}' en el mismo bloque "

	end
end

class ErrorNoCoincide< ErrorContexto
	def initialize(token,valor,tipo)
		@token = token
		@valor  = valor
		@tipo = tipo
	end

	def to_s()
		"\n Error: la expresion #{@valor} asignada a: #{@token} no es del tipo #{@tipo} "

	end
end

class ErrorNoDeclarado< ErrorContexto
	def initialize(token)
		@token = token
	end

	def to_s()
		"\nError: #{@token.valor} no esta declarada "
	end
end

class Incompatibles <ErrorContexto
	def initialize(token1,token2)
		@token1 = token1
		@token2 = token2
	end

	def to_s()
		"\nError: #{@token1} no se puede operar con #{@token2} "
	end
end

class IncompatiblesSigno <ErrorContexto
	def initialize(token1,token2, oper)
		@token1 = token1
		@token2 = token2
		@oper = oper
	end

	def to_s()
		"\nError: #{@token1} #{$simbolos[@oper]} #{@token2} no se puede operar."
	end
end

class ErrorTipo< ErrorContexto
	def initialize(token, tipo)
		@token = token
		@tipo = tipo
	end

	def to_s()
		"\nError: la asignacion hecha a #{@token} no es de tipo #{@tipo} "
	end
end

########################################################################
class Programa
	def verificacion()
		if @instruccion != nil 
			 @instruccion.verificacion()
			 puts "\n##################################################"
			 puts "############## Tabla de Simbolos #################"
			 puts $scopeImp
			 puts "################################################## \n"

		end
	end
end

class WBloque

	def verificacion()

		tabla = Hash.new
		$tam += 1
		@declaraciones.verificacion(tabla)
		$scopes.unshift(tabla)
		$scopeImp << tabla
		@instrucciones.verificacion()
		$scopes.delete(tabla)
		$tam -= 1

	end
end

class LDeclaracionS

	def verificacion(tabla)
		@declaracion.verificacion(tabla)
	end
end

class LDeclaracionRec

	def verificacion(tabla)
		@declaraciones.verificacion(tabla)
		@declaracion.verificacion(tabla)

	end
end

class Declaracion

	def verificacion(tabla)
		@argumentos.verificacion(tabla, @tipo)
	end
end

class Argumento
	def verificacion(tabla, tipoP)
		if existeYa(tabla,@id)
			puts ErrorYaExiste.new(@id).to_s()
			exit
		else
			if @exp == nil 
				tabla[@id]= tipoP
			elsif tipoP.tipo == @tipo
				tabla[@id]= tipoP.tipo
			else
				puts ErrorNoCoincide.new(@id,@exp.valor,tipoP.tipo).to_s()
				exit
			end
		end
		if @arg != nil
			@arg.verificacion(tabla, tipoP)
		end
	end
end

class ArgumentoId
	def verificacion(tabla, tipoP)
		if existeYa(tabla,@id)
			ErrorYaExiste(@id.valor)
		else	
			tabla[@id]= tipoP.tipo
		end
		@exp.verificacion(tabla, tipoP)
	end
end

class Asignacion
	
	def verificacion()
		if $idFor == 1 && @id== $idF
			puts "\n No puedes realizar asignaciones sobre '#{@id}' dentro de este bloque"
			exit
		end

		esta, tipo = Encontrar(@id.valor)
		#puts "soy #{@id.valor} #{tipo}"
		if esta
			if tipo != @tipo && @tipo != "variable"
				puts ErrorTipo.new(@id,tipo).to_s()
				exit
			elsif tipo != @tipo && @tipo == "variable"
				#puts "entre"
				#puts @tipo
				@expresion.verificacion()
				@tipo = @expresion.tipo

				#puts "soy #{@tipo}"
				if  tipo != @tipo
					puts ErrorTipo.new(@id,tipo).to_s()
					exit
				end
			end
		else
			puts ErrorNoDeclarado.new(@id).to_s()
				exit
		end
	end
end

class ExpresionDosOper
	def decidir()
		if @oper == "Concatenacion" && @tipo == "caracter"
			@tipo = @tipo
			
		elsif (@oper == "Suma" ||  @oper == "Multiplicacion" || @oper == "Resta" || @oper == "Division" || @oper == "Punto" || @oper == "Modulo") && @op2.tipo== "entero"
			@tipo = "entero"
			#puts "aqui"
		else 
			if (@oper == "Desigualdad" ||  @oper == "Menor" || @oper == "MenorIgual" || @oper == "Igual" || @oper == "Mayor" || @oper == "MayorIgual" || @oper == "Conjuncion" || @oper == "Disyuncion")
				@tipo = "booleano"
				#puts @tipo
			else
				@tipo = "error"
			end
		end
		#puts @tipo
	end

	def verificacion()
		
		if @op1.tipo == "variable" && @op2.tipo == "variable"
			@op2.verificacion()
			@op1.verificacion()

			#puts "entre"
			#puts @op2.tipo
			#puts @op1.tipo
			#puts @oper
			#puts "-------------------"
			
				if @op2.tipo != @op1.tipo
					puts Incompatibles.new(@op1.valor,@op2.valor).to_s()
					exit
				else

					decidir()
					#puts @tipo
				end
				if @tipo == "error"
					puts  IncompatiblesSigno.new(@op1.valor,@op2.valor,@oper).to_s()
					exit
				end
			

		elsif @op2.tipo == "variable"
			esta, @tipo1 = Encontrar(@op2.verificacion())

			#puts "entre"
			#puts "------"
			if esta
				if @tipo1 != @op1.tipo
					puts Incompatibles.new(@op1.valor,@op2.valor).to_s()
					exit
				else
					decidir()
					
				end
			else
				puts ErrorNoDeclarado.new(@op2.valor).to_s()
					exit
			end

		elsif @op1.tipo == "variable"
			esta, @tipo1 = Encontrar(@op1.verificacion())
			#puts @tipo1
			#puts @op2.tipo
			#puts "------"
			if esta
				if @tipo1 != @op2.tipo
					puts Incompatibles.new(@op1.valor,@op2.valor).to_s()
					exit
				else
					decidir()
					#puts @tipo
				end
			else

				puts ErrorNoDeclarado.new(@op1.valor).to_s()
				exit
			end
		elsif  @op1.tipo != "variable" && @op2.tipo != "variable"
			#puts "entrw"
			#puts  @op1.valor
			#puts @op2.valor
			#puts "------"
			if @op1.tipo != @op2.tipo
				puts  IncompatiblesSigno.new(@op1.valor,@op2.valor,$simbolos[@oper]).to_s()
				exit
			else
				@tipo = @op1.tipo
				if (@tipo == "entero" || @tipo == "booleano") &&  (@oper == "Desigualdad" ||  @oper == "Menor" || @oper == "MenorIgual" || @oper == "Igual" || @oper == "Mayor" || @oper == "MayorIgual" || @oper == "And" || @oper == "Or")
						@tipo = "booleano"
						return @tipo
					else
						return @tipo
					#puts @tipo
					end
				#puts @tipo
			end
		end
	end
end

class Literal
	def verificacion()
		return @valor
	end
end

class ExpresionUnOperIzq
	
	def verificacion()
		
	end
end

class ExpresionUnOperDer
	def decidir()
		if @oper== "Not" && @tipo2 == "booleano"
				@tipo = "booleano"
		elsif @oper== "MenosUnario" && @tipo2 == "entero"
				@tipo = "entero"
		else
			if @tipo2 == "caracter"
				@tipo = "caracter"
			else
				@tipo = "error"
			end
		end
	end

	def verificacion()
		if @op1.tipo == "variable"
			esta, @tipo2 = Encontrar(@op1.verificacion())
			if esta
				decidir()
				if @tipo =="error"
					puts ErrorTipo.new(@op1.valor,tipo).to_s()
					exit
				else
					return @tipo
				end
			else
				puts ErrorNoDeclarado.new(@op1.valor).to_s()
				exit
			end
					
		end
	end
end

class Iteracion_DetStep
	def verificacion()
		esta, tipo = Encontrar(@id)
		$idFor = 1
		$idF = @id
		if esta
			tabla1 = Hash.new
			tabla1[@id] = "entero"
			$tam += 1
			$scopes.unshift(tabla1)
			$scopeImp << tabla1
			@inst.verificacion()
			$scopes.delete(tabla1)
			$tam -= 1
		else
			@inst.verificacion()
		end
		$idFor = 0
		$idF = ""
	end
end

class Iteracion_Det
	def verificacion()
		esta, tipo = Encontrar(@id)
		$idFor = 1
		$idF = @id
		if esta
			tabla = Hash.new
			tabla[@id] = "entero"
			$tam += 1
			$scopes.unshift(tabla)
			$scopeImp << tabla
			@inst.verificacion()
			$scopes.delete(tabla)
			$tam -= 1
		else
			@inst.verificacion()
		end
		$idFor = 0
		$idF = ""
	end
end

class Read
	def verificacion()
		esta, tipo = Encontrar(@id.valor)
		if esta
			if tipo != "entero" && tipo != "booleano" && tipo != "caracter"
				puts "\n El identificador #{id} de archivo, no tiene un tipo permitido"
				exit
			end
		else
			puts ErrorNoDeclarado.new(@id).to_s()
			exit
		end
	end
end

class Print
	def verificacion()
		@salida.verificacion()
	end
end

class Iteracion_Indet
	def verificacion()
		@condicional.verificacion()
		@inst.verificacion()
	end
end

class IfOtherEnd
	def verificacion()
		@guardia.verificacion()
		@intr.verificacion()
		@intr2.verificacion()
	end
end

class IfEnd
	def verificacion()
		@guardia.verificacion()
		@intr.verificacion()
	end
end

class Bloque
	def verificacion()
		@instrucciones.verificacion()
	end
end

class Instrucciones
	def verificacion()
		@instrucciones.verificacion()
		@accion.verificacion()
	end
end