# == Clase Asignacion
#
class Asignacion

	# == Atributos
	#
	# id: identificador del parametro
	# expresion: expresion que se le asigna al id
	attr_accessor  :id, :expresion

	def initialize(id, expresion)
		@id = id
		@expresion = expresion
	end

	def to_s(tab)
		s << (" "*(tab+2)) + "identificador: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "expresion: \n" + @expresion.to_s(tab+4)
		if @expresion != nil
			s << @expresion.to_s(tab)
		end
		return s
	end
end

# == Clase Asignacion
#
class Read

	# == Atributos
	#
	# id: identificador del parametro
	attr_accessor  :id

	def initialize(id)
		@id = id

	end

	def to_s(tab)
		s = (" "*tab) + "Lectura:\n"
		s << (" "*(tab+2)) + "archivo: \n" + @id.to_s(tab+4)
		return s
	end
end

class Print

	# == Atributos
	#
	# id: identificador del parametro
	attr_accessor  :salida

	def initialize(salida)
		@salida = salida

	end

	def to_s(tab)
		s = (" "*tab) + "Impresion:\n"
		s << (" "*(tab+2)) + "salida: \n" + @salida.to_s(tab+4)
		return s
	end
end

class IfOtherEnd

	# == Atributos
	#
	# guardia: guardia relacionada con el if
	# intr: instruccion a realizar si se cumple la comdicion
	# intr2: instruccion q se realiza si no se cumple la condicion del if 
	attr_accessor  :guardia, :intr, :intr2

	def initialize(guardia, intr, intr2)
		@guardia = guardia
		@intr = intr
		@intr2 = intr2

	end

	def to_s(tab)
		s = (" "*tab) + "Condicional If/Otherwise/End:\n"
		s << (" "*(tab+2)) + "guardia: \n" + @guardia.to_s(tab+4)
		s << (" "*(tab+2)) + "Instrucciones If: \n" + @intr.to_s(tab+4)
		s << (" "*(tab+2)) + "Instrucciones Otherwise: \n" + @intr2.to_s(tab+4)
		return s
	end
end

class IfEnd

	# == Atributos
	#
	# guardia: guardia relacionada con el if
	# intr: instruccion a realizar si se cumple la comdicion
	attr_accessor  :guardia, :intr

	def initialize(guardia, intr)
		@guardia = guardia
		@intr = intr

	end

	def to_s(tab)
		s = (" "*tab) + "Condicional If/End:\n"
		s << (" "*(tab+2)) + "guardia: \n" + @guardia.to_s(tab+4)
		s << (" "*(tab+2)) + "Instrucciones If: \n" + @intr.to_s(tab+4)
		return s
	end
end

class Bloque

	# == Atributos
	#
	# guardia: guardia relacionada con el if
	# intr: instruccion a realizar si se cumple la comdicion
	attr_accessor  :instrucciones

	def initialize(instrucciones)
		@instrucciones = instrucciones

	end

	def to_s(tab)
		s = (" "*tab) + "Nuevo Bloque:\n"
		s << (" "*(tab+2)) + "Instrucciones: \n" + @instrucciones.to_s(tab+4)
		s << (" "*(tab+2)) + "Fin del bloque \n"

		return s
	end
end
class WBloque

	# == Atributos
	#
	# guardia: guardia relacionada con el if
	# intr: instruccion a realizar si se cumple la comdicion
	attr_accessor  :declaraciones,:instrucciones

	def initialize(declaraciones,instrucciones)
		@declaraciones = declaraciones
		@instrucciones = instrucciones

	end

	def to_s(tab)
		s = (" "*tab) + "Nuevo Bloque:\n"
		s << (" "*(tab+2)) + "Instrucciones: \n" + @instrucciones.to_s(tab+4)
		s << (" "*(tab+2)) + "Fin del bloque \n"
		return s
	end
end


class Iteracion_DetStep

	# == Atributos
	#
	# id: parametro sobre el cual se itera
	# start : punto de inicio para el ciclo
	# final: punto para finalizar el ciclo
	# step: paso paso
	# intr: instruccion a realizar si se cumple la comdicion
	attr_accessor  :id,:start, :final, :step, :inst

	def initialize(id,start, final, step, inst)
		@id = id
		@start = start
		@final = final 
		@step = step
		@inst = inst

	end

	def to_s(tab)
		s = (" "*tab) + "Ciclo For:\n"
		s << (" "*(tab+2)) + "Iterador: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "Inicio del ciclo: \n" + @start.to_s(tab+4)
		s << (" "*(tab+2)) + "final del ciclo: \n" + @final.to_s(tab+4)
		s << (" "*(tab+2)) + "Paso: \n" + @step.to_s(tab+4)
		s << (" "*(tab+2)) + "Instrucciones: \n" + @inst.to_s(tab+4)
		s << (" "*(tab+2)) + "Fin del ciclo \n"
		return s
	end
end

class Iteracion_Det

	# == Atributos
	#
	# id: parametro sobre el cual se itera
	# start : punto de inicio para el ciclo
	# final: punto para finalizar el ciclo
	# intr: instruccion a realizar si se cumple la comdicion
	attr_accessor  :id,:start, :final, :inst

	def initialize(id,start, final, inst)
		@id = id
		@start = start
		@final = final 
		@inst = inst

	end

	def to_s(tab)
		s = (" "*tab) + "Ciclo For:\n"
		s << (" "*(tab+2)) + "Iterador: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "Inicio del ciclo: \n" + @start.to_s(tab+4)
		s << (" "*(tab+2)) + "final del ciclo: \n" + @final.to_s(tab+4)
		s << (" "*(tab+2)) + "Instrucciones: \n" + @inst.to_s(tab+4)
		s << (" "*(tab+2)) + "Fin del ciclo \n"
		return s
	end
end

class Programa

	# == Atributos
	#
	# Instrucciones: Secuencia de instrucciones definidas en el programa
	attr_accessor :instruccion

	def initialize(instruccion)
		@instruccion = instruccion
	end

	def to_s()
		s = ""
		if @instruccion != nil 
			s = "Programa: \n" 
			s << @instruccion.to_s(4)
		end
		return s
	end
end

class Iteracion_Indet

	# == Atributos
	#
	# condicional: regla para mantenerse iterando
	# intr: instruccion a realizar si se cumple la comdicion
	attr_accessor  :condicional, :inst

	def initialize(condicional, inst)
		@condicional= condicional 
		@inst = inst

	end

	def to_s(tab)
		s = (" "*tab) + "Ciclo While:\n"
		s << (" "*(tab+2)) + "Condicional: \n" + @condicional.to_s(tab+4)
		s << (" "*(tab+2)) + "Instrucciones: \n" + @inst.to_s(tab+4)
		s << (" "*(tab+2)) + "Fin del ciclo \n"
		return s
	end
end

class Punto

	# == Atributos
	#
	# id: elemento al que se le asignara la resta resultante
	# num: cantidad que se le resta a lo que tenga el id
	attr_accessor  :id, :num

	def initialize(id, num)
		@id= id 
		@num = num

	end

	def to_s(tab)
		s = (" "*tab) + "Instruccion Punto:\n"
		s << (" "*(tab+2)) + "Variable a modificar: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "Valor a restar: \n" + @num.to_s(tab+4)
		return s
	end
end

class LDeclaracionS

	# == Atributos
	#
	# declaracion: referido a una declaracion de una sola variable
	attr_accessor  :declaracion

	def initialize(declaracion)
		@declaracion= declaracion

	end

	def to_s(tab)
		s = (" "*tab) + "Declaracion:\n"
		s << (" "*(tab+2)) + "Variable: \n" + @declaracion.to_s(tab+4)
		return s
	end
end

class LDeclaracionRec

	# == Atributos
	#
	# declaraciones: referido a declaraciones de conjuntos de distintos tipos de varible
	# declaracion: declaracion de tipo de variable
	attr_accessor  :declaraciones, :declaracion

	def initialize(declaraciones,declaracion)
		@declaracion= declaracion
		@declaraciones= declaraciones

	end

	def to_s(tab)
		s = (" "*tab) + "Declaraciones:\n"
		s << (" "*(tab+2)) + "Variable: \n" + @declaraciones.to_s(tab+4)
		s << (" "*(tab+2)) + "Propiedades: \n" + @declaracion.to_s(tab+4)
		return s
	end
end

class LDeclaracionId

	# == Atributos
	#
	# id: id correspondiente a la variable que se esta declarando
	# tipo: tipo de la variable que se esta declarando
	attr_accessor  :id, :tipo

	def initialize(id, tipo)
		@id = id
		@tipo= tipo
	end

	def to_s(tab)
		s << (" "*(tab+2)) + "Identificador: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "Tipo: \n" + @tipo.to_s(tab+4)
		return s
	end
end

class Declaracion

	# == Atributos
	#
	# argumentos: argumentos correspondiente a la declaracion, referente a la declaracion de un conjunto de variable del mismo tipo
	# tipo: tipo de la variable que se esta declarando
	attr_accessor  :argumentos, :tipo

	def initialize(argumentos, tipo)
		@argumentos = argumentos
		@tipo= tipo
	end

	def to_s(tab)
		s << (" "*(tab+2)) + "Argumentos: \n" + @argumentos.to_s(tab+4)
		s << (" "*(tab+2)) + "Tipo: \n" + @tipo.to_s(tab+4)
		return s
	end
end

class DeclaracionMatriz

	# == Atributos
	#
	# id: identificador del arreglo
	# tam: tamano del arreglo
	# tipo: tipo de la variable que se esta declarando
	attr_accessor  :id,:tam, :tipo

	def initialize(id,tam, tipo)
		@id = id
		@tam = tam
		@tipo= tipo
	end

	def to_s(tab)
		s << (" "*(tab+2)) + "Identificador: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "Tamaño del arreglo: \n" + @tam.to_s(tab+4)
		s << (" "*(tab+2)) + "Tipo: \n" + @tipo.to_s(tab+4)
		return s
	end
end

class Argumento

	# == Atributos
	#
	# id: identificador del arreglo
	# exp: expresion que se le asignara a la nueva variable
	# arg: permite la definicion de los argumentos de varias variables
	attr_accessor  :id,:exp, :arg

	def initialize(id,tam, arg)
		@id = id
		@exp = exp
		@arg= arg
	end

	def to_s(tab)
		s << (" "*(tab+2)) + "Identificador: \n" + @id.to_s(tab+4)
		s << (" "*(tab+2)) + "Expresion a Asignar: \n" + @exp.to_s(tab+4)
		if @arg!= nil
			s << (" "*(tab+2)) + "Siguiente declaracion: \n" + @arg.to_s(tab+4)
		end
		return s
	end
end

class Tipo

	# == Atributos
	#
	# tipo 	: 	Tipo de dato (num o bool)
	attr_accessor :tipo

	def initialize( tipo )
		@tipo = tipo
	end

	def to_s(tab)
		return (" "*tab) + "Tipo: \n" + (" "*(tab+2)) + "nombre: " + @tipo.to_s() + "\n"
	end
end

# == Clase TipoNum
#
# Clase que representa el nodo de un tipo numérico. Hereda de Tipo.
class Int < Tipo

	def initialize()
		super("entero")
	end
end

# == Clase TipoBoolean
#
# Clase que representa el nodo de un tipo booleano. Hereda de Tipo.
class Bool < Tipo

	def initialize()
		super("booleano")
	end
end


class Salida

	# == Atributos
	#
	# iteracion: recorre para poder imprimir todo lo que se le pase
	# salida: imprime la expresion o caracter correspondiente
	attr_accessor  :iteracion,:salida

	def initialize(iteracion,salida)
		@iteracion = iteracion
		@salida = salida
	end

	def to_s(tab)
		s = ""
    	s << (" "*(tab+2)) + @salida.to_s(tab+4)
    	return s
	end
end

class Caracter

	# Representa a la clase de los caracteres

	attr_accessor  :caracter

	def initialize(caracter)
		@caracter = caracter
	end

	def to_s(tab)
		s = (" "*tab) + "Caracter: \n"
		s << (" "*(tab+2)) + "nombre: " + @caracter.to_s()
		return s + "\n"
	end
end

class ExpresionDosOper
	# op1 	: 	Operador izquierdo de la expresión
	# op2 	: 	Operador derecho de la expresión
	# oper 	: 	Operación correspondiente a la expresión
	attr_accessor :op1, :op2, :oper

	def initialize(op1, op2, oper)
		@op1 = op1
		@op2 = op2
		@oper = oper
	end

	def to_s(tab)
		s = (" "*tab) + @oper + ": \n" 
		s << (" "*(tab+2)) + "oper izquierdo: \n" + @op1.to_s(tab+4)
		s << (" "*(tab+2)) + "oper derecho: \n" + @op2.to_s(tab+4)
		return s
	end
end


class Modulo < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Modulo")
    end
end


class Concatenacion < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Concatenacion")
    end
end


class Multiplicacion < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Multiplicacion")
    end
end


class Suma < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Suma")
    end
end


class Resta < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Resta")
    end
end


class Division < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Division")
    end
end


class Desigualdad < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Desigualdad")
    end
end


class Menor < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Menor")
    end
end


class MenorIgual < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"MenorIgual")
    end
end


class Igual < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Igual")
    end
end


class Mayor < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Mayor")
    end
end


class MayorIgual < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"MayorIgual")
    end
end


class And < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Conjuncion")
    end
end


class Or < ExpresionDosOper

    def initialize(op1,op2)
        super(op1, op2,"Disyuncion")
    end
end


class ExpresionUnOperDer
	# op 	: 	Recibe el operador que afecta la expresión.
	# oper 	: 	Recibe el operando que es afectado por el operador unario.
	attr_accessor :op, :oper

	def initialize(op, oper)
		@op = op
		@oper = oper
	end

	def to_s(tab)
		return (" "*tab) + @oper + ": \n" + (" "*(tab+2)) + "lado derecho: \n" + @op.to_s(tab+4)
	end
end


class Not < ExpresionUnOperDer

	def initialize(op)
        super(op,"Not")
    end
end


class Shift < ExpresionUnOperDer

	def initialize(op)
        super(op,"Shift")
    end
end


class MenosUnario < ExpresionUnOperDer

	def initialize(op)
        super(op,"MenosUnario")
    end
end


class ValorAscii < ExpresionUnOperDer

	def initialize(op)
        super(op,"ValorAscii")
    end
end




class ExpresionUnOperIzq
	# op 	: 	Recibe el operador que afecta la expresión.
	# oper 	: 	Recibe el operando que es afectado por el operador unario.
	attr_accessor :op, :oper

	def initialize(op, oper)
		@op = op
		@oper = oper
	end

	def to_s(tab)
		return (" "*tab) + @oper + ": \n" + (" "*(tab+2)) + "lado izquierdo: \n" + @op.to_s(tab+4)
	end
end


class SiguienteCar < ExpresionUnOperIzq

	def initialize(op)
        super(op,"SiguienteCar")
    end
end


class AnteriorCar < ExpresionUnOperIzq

	def initialize(op)
        super(op,"AnteriorCar")
    end
end




class Literal

	attr_accessor :valor, :tipo

	def initialize(valor, tipo)
		@valor = valor
		@tipo = tipo
	end

	def to_s(tab)
		return (" "*tab) + "valor: " + @valor.to_s() + "\n"
	end
end


class Entero < Literal

	def initialize(valor)
		super(valor, "valor numerico: \n")
	end
end


class True < Literal

    def initialize(valor)
        valor = 'True'
		super(valor, "Valor booleano: \n")
	end
end

class False < Literal

    def initialize(valor)
        valor = 'False'
		super(valor, "Valor booleano: \n")
	end
end


class Variable < Literal

	def initialize(valor)
		super(valor, "Variable: \n")
	end
end
