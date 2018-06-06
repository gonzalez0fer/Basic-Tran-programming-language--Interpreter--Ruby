#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 


def crearClase(superclase, nombre, atributos)

  clase = Class::new(superclase) do
    @atributos = atributos
    class << self
      attr_accessor :atributos
    end

    def initialize(*argumentos)
      raise ArgumentError::new("numero incorrecto de argumentos (#{ argumentos.length } for #{ self.class.atributos.length })") if argumentos.length != self.class.atributos.length
      @hijos = [self.class.atributos, argumentos].transpose
    end
  end

  Object::const_set nombre, clase
end

crearClase(Object, 'AST', [])
  crearClase(AST, 'Instruccion', [])
    crearClase(Instruccion, 'Asignacion'      , ['value1', 'value2'])
    crearClase(Instruccion, 'WBloque'          , ['ldeclaraciones', 'instrucciones'])
    crearClase(Instruccion, 'Bloque'          , ['instrucciones'])
    crearClase(Instruccion, 'IfOtherEnd'          , ['expresion', 'instrucciones', 'instrucciones'])
    crearClase(Instruccion, 'IfEnd'          , ['expresion','instrucciones'])
    crearClase(Instruccion, 'Read'            , ['variable'])
    crearClase(Instruccion, 'Print'           , ['elementos'])
    crearClase(Instruccion, 'Punto'           , ['expresion', 'expresion'])
    crearClase(Instruccion, 'Iteracion_Det'   , ['variable', 'exp1', 'exp2', 'instruccion'])
    crearClase(Instruccion, 'Iteracion_DetStep'   , ['variable', 'exp1', 'exp2', 'exp3', 'instruccion'])
    crearClase(Instruccion, 'Iteracion_Indet' , ['condicion', 'instruccion'])
    crearClase(Instruccion, 'LDeclaracion', ['declaraciones'])

  crearClase(LDeclaracion, 'Declaracion', ['variables', 'tipo'])
  crearClase(LDeclaracion, 'Declaraciones', ['declaraciones'])
  crearClase(Instruccion, 'Expresion', [])
    crearClase(Expresion, 'Modulo'         , ['oper izq', 'oper der'])
    crearClase(Expresion, 'SiguienteCar'   , ['oper'])
    crearClase(Expresion, 'AnteriorCar'    , ['oper'])
    crearClase(Expresion, 'ValorAscii'     , ['oper'])
    crearClase(Expresion, 'Concatenacion'  , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Multiplicacion' , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Suma'           , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Resta'          , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Division'       , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Diferencia'     , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Desigualdad'    , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Menor'          , ['oper izq', 'oper der'])
    crearClase(Expresion, 'MenorIgual'     , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Igual'          , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Mayor'          , ['oper izq', 'oper der'])
    crearClase(Expresion, 'MayorIgual'     , ['oper izq', 'oper der'])
    crearClase(Expresion, 'And'            , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Or'             , ['oper izq', 'oper der'])
    crearClase(Expresion, 'Not'            , ['oper'])
    crearClase(Expresion, 'Shift'          , ['oper'])
    crearClase(Expresion, 'MenosUnario'    , ['oper'])
    crearClase(Expresion, 'Entero'         , ['valor'])
    crearClase(Expresion, 'True'           , [])
    crearClase(Expresion, 'False'          , [])
    crearClase(Expresion, 'Variable'       , ['nombre'])


#bloque de prints textual por ahora

# Modificamos la clase AST para agregarle el to_s y to_string
class AST

  def to_s
    (to_string 0).sub(/\A[\n ]*/, '').gsub(/\s+$/, '')
  end

  def to_string(profundidad)

    @hijos.inject("\n" + self.class.to_s.upcase) do |acum, cont|
      puts "estoy en ast"
      acum + "#{cont[0]}"
    # Por ultimo se identa adecuadamente sustituyendo el inicio del string por la cantidad
    # de espacios en blanco necesarios (2*profundidad)
    end
  end
end
