#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 


def generaClase(superclase, nombre, atributos)

  clase = Class::new(superclase) do
    @atributos = atributos
    class << self
      attr_accessor :atributos
    end

    def initialize(*argumentos)
      raise ArgumentError::new("wrong number of arguments (#{ argumentos.length } for #{ self.class.atributos.length })") if argumentos.length != self.class.atributos.length
      @hijos = [self.class.atributos, argumentos].transpose
    end
  end

  Object::const_set nombre, clase
end

generaClase(Object, 'AST', [])

  generaClase(AST, 'Expresion', [])
    generaClase(Expresion, 'Modulo'         , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'SiguienteCar'   , ['operando'])
    generaClase(Expresion, 'AnteriorCar'    , ['operando'])
    generaClase(Expresion, 'ValorAscii'     , ['operando'])
    generaClase(Expresion, 'Concatenacion'  , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Multiplicacion' , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Suma'           , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Resta'          , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Division'       , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Diferencia'     , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Desigualdad'    , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Menor'          , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'MenorIgual'     , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Igual'          , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Mayor'          , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'MayorIgual'     , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'And'            , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Or'             , ['operando izquierdo', 'operando derecho'])
    generaClase(Expresion, 'Not'            , ['operando'])
    generaClase(Expresion, 'Shift'          , ['operando'])
    generaClase(Expresion, 'MenosUnario'    , ['operando'])
    generaClase(Expresion, 'Entero'         , ['valor'])
    generaClase(Expresion, 'True'           , [])
    generaClase(Expresion, 'False'          , [])
    generaClase(Expresion, 'Variable'       , ['nombre'])

  generaClase(AST, 'Instruccion', [])
    generaClase(Instruccion, 'Asignacion'      , ['var', 'val'])
    generaClase(Instruccion, 'Bloque'          , ['.declaraciones', '-instrucciones'])
    generaClase(Instruccion, 'Read'            , ['variable'])
    generaClase(Instruccion, 'Print'           , ['elementos'])

    generaClase(Instruccion, 'Iteracion_Det'   , ['variable', 'exp1', 'exp2', 'instruccion'])
    generaClase(Instruccion, 'Iteracion_DetStep'   , ['variable', 'exp1', 'exp2', 'exp3', 'instruccion'])
    generaClase(Instruccion, 'Iteracion_Indet' , ['condicion', 'instruccion'])

#bloque de prints textual por ahora

# Modificamos la clase AST para agregarle el to_s y to_string
class AST
  # Se encarga de pasar a string el AST llamando a to_string con profundidad cero
  # y eliminando cualquier salto de línea del inicio y cualquier cantidad de
  # espacios en blancos.
  def to_s
    (to_string 0).sub(/\A[\n ]*/, '').gsub(/\s+$/, '')
  end

  # Se encarga de pasar a string el AST a la profundidad indicada.
  def to_string(profundidad)
    # Creamos un string con el nombre de la clase en mayusculas
    # continuado por el string generado por to_string de sus hijos.
    @hijos.inject("\n" + self.class.to_s.upcase) do |acum, cont|
      # Se utiliza un formato que permite ignorar la impresion de ciertos
      # nombres de atributos y/o elementos de alguna clase. Por ejemplo:
      # No se deben imprimir las declaraciones ni la palabra 'instrucciones'
      # para un bloque. De este modo se le coloca un . a lo que no queremos imprimir
      # (declaraciones) y un - a los titulos de atributos que no queremos imprimir
      # (instrucciones)
      case cont[0]
        # Si el primer caracter es un '.' se genera solamente lo que se lleva acumulado
        when /\A\./
          acum
        # Si el primer caracter es un '-' se genera el string acumulado mas el to_string
        # del contenido del atributo
        when /\A-/
          acum + cont[1].to_string(1)
        # En cualquier otro caso se genera el string que contiene el nombre del atributo
        # seguido por dos puntos y luego el to_string del contenido del atributo
        else
          acum + "\n  #{cont[0]}: #{ cont[1].to_string(2) }"
        end
    # Por ultimo se identa adecuadamente sustituyendo el inicio del string por la cantidad
    # de espacios en blanco necesarios (2*profundidad)
    end.gsub(/^/, '  '*profundidad)
  end
end

# Modificamos la clase Programa para agregar un to_string diferente
class Programa
  # Se encarga de imprimir el contenido del programa
  # sin imprimir la palabra 'PROGRAMA' en el AST
  def to_string(profundidad)
    @hijos[0][1].to_string(profundidad)
  end
end