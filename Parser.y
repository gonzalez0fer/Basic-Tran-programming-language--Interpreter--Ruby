#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 

class Parser

    #Procedemos a declarar los tokens de BasicTran

    token   ',' '.' ';' ':' '(' ')' '[' ']'  '->' '<-'
            '+' '-' '*' '\/' '%' '\/\\' '\\\/' 'not' '/=' '<' '<='
            '>' '>=' '=' '++' '--' '#' '::' '$' 'with' 'true' 
            'false' 'var' 'begin' 'end' 'int' 'while' 'if' 
            'otherwise' 'bool' 'char' 'array' 'read' 'of' 'print' 
            'for' 'step' 'from' 'to' UMINUS
           
    #Declaramos la presedencia de los operadores donde el de mayor presedencia
    #se encuentra de primero en la tabla

    prechigh
        nonassoc    UMINUS
        left        '*' '\/' '%'            
        left        '+' '-' 
        left        'not'   
        left        '\/\\'            
        left        '\\\/'  
        nonassoc    '<' '<=' '>=' '>'
        left        '=' '/=' 
        left        '#' 
        left        '--'   
        left        '++'
        left        '[' ']'  
        left        '$'   
        left        '::'  
    preclow

    #Procedemos a indicar las equivalencia de los Tokens con los signos
    convert
        '.'         'TkPunto' 
        'num'       'TkNum'
        'char'      'TkCaracter'
        'id'        'TkId'
        ','         'TkComa'
        ':'         'TkDosPuntos'
        '('         'TkParAbre'
        ')'         'TkParCierra'
        '['         'TkCorcheteAbre'
        ']'         'TkCorcheteCierre'
        '-'         'TkResta'
        '->'        'TkHacer'
        '<-'        'TkAsignacion'
        '+'         'TkSuma'
        '/='        'TkDesigualdad'
        ';'         'TkPuntoYComa'
        '*'         'TkMult'
        '\/'         'TkDiv'
        '%'         'TkMod'
        '\/\\'        'TkConjuncion'
        '\\\/'        'TkDisyuncion'
        'not'       'TkNegacion'
        '<'         'TkMenor'
        '<='        'TkMenorIgual'
        '>'        'TkMayor'
        '>='         'TkMayorIgual'
        '='         'TkIgual'
        '++'        'TkSiguienteCar'
        '--'        'TkAnteriorCar'
        '#'         'TkValorAscii'
        '::'        'TkConcatenacion'
        '$'         'TkShift'     
        'with'      'TkWith' 
        'true'      'TkTrue' 
        'false'     'TkFalse' 
        'var'       'TkVar'   
        'begin'     'TkBegin' 
        'end'       'TkEnd' 
        'int'       'TkInt' 
        'while'     'TkWhile' 
        'if'        'TkIf' 
        'otherwise' 'TkOtherwise' 
        'bool'      'TkBool' 
        'char'      'TkChar' 
        'array'     'TkArray' 
        'read'      'TkRead' 
        'of'        'TkOf' 
        'print'     'TkPrint' 
        'for'       'TkFor' 
        'step'      'TkStep'
        'from'      'TkFrom' 
        'to'        'TkTo'
    end


#declarando la gramatica

rule
    Programa: Instruccion                                                   {result = Programa.new(val[0])}
            ;

    Instruccion: 'id' '<-' Expresion  ';'                               {  result = Asignacion.new(val[0].contenido, val[2]) }
                |'with' LDeclaraciones 'begin' Instrucciones 'end'       { result = WBloque.new(val[1], val[3]) }
                |'begin' Instrucciones 'end'                              {  result = Bloque.new([val[1]])}
                |'read' 'id' ';'                                             {  result = Read.new(val[1].contenido)  }
                |'print' ElementosSalida  ';'                                {  result = Print.new(val[1]) }
                |'if' Expresion '->' Instrucciones 'otherwise' '->' Instrucciones 'end'                     
                                                                      { result = IfOtherEnd.new(val[1], val[3], val[6])}
                |'if' Expresion '->' Instrucciones 'end'         { result = IfEnd.new(val[1], val[3])}

                |'for' 'id' 'from' Expresion 'to' Expresion '[' 'step' 'num' ']' '->' Instrucciones 'end'
                                    {result = Iteracion_DetStep.new(val[1].contenido,val[3], val[5], val[8], val[11])}
                |'for' 'id' 'from' Expresion 'to' Expresion '->' Instrucciones 'end'
                                            {result = Iteracion_Det.new(val[1].contenido,val[3], val[5], val[7])}

                | 'while' Expresion '->' Instrucciones  'end'            { result = Iteracion_Indet.new(val[1], val[3]) }
                | 'id' '.' 'num'                                   { result = Punto.new(val[0].contenido, val[2].contenido)   }
                ;

     Instrucciones: Instruccion                                                          { result = val[0]           }
                | Expresion  ';'                                                         { result = val[0]           }
                | Instrucciones ';' Instruccion                                          { result = val[0] , val[2]  }
                | Instrucciones ';' Expresion                                            { result = val[0] , val[2]  }
                ;

  LDeclaraciones: 'var' Declaracion                                    { result = LDeclaracionS.new(val[1]) }
                | 'var' LDeclaraciones Declaracion                     { result = LDeclaracionRec.new(val[1].contenido, val[2] )}
                | 'var' 'id' ':' Tipo ';'                              { result = LDeclaracionId.new(val[1].contenido , val[3]) }
                ;          

    Declaracion: Argumentos ':' Tipo ';'                         { result = Declaracion.new(val[0], val[2]) }
                |'id' ':' 'array' '[' 'num' ']' 'of' Array       { result = DeclaracionMatriz.new(val[0].contenido, val[4].contenido, val[6])}
                ;

            Array: 'id' ':' 'array' '[' 'num' ']' 'of' Array        { result = DeclaracionMatriz.new(val[0].contenido, val[4].contenido, val[6])}
                | Tipo  ';'                                         { result = val[0]}
                ;

      Argumentos: 'id' '<-' Expresion                            { result = Argumento.new(val[0].contenido , val[2], nil)}
                |'id' '<-' Expresion ',' Argumentos              { result = Argumento.new(val[0].contenido , val[2] , val[4]) }
                | 'id' ',' Argumentos                           { result = Argumento.new(val[0].contenido , val[2], nil) }
                |                                               { result = Argumento.new(nil , nil, nil) }
                ;

           Tipo:  'int'                                                                 { result = Int.new() }
                | 'bool'                                                                { result = Bool.new() }
                ;

ElementosSalida: ElementoSalida                                                         { result = Salida.new(nil, val[0])          }
               | ElementosSalida ',' ElementoSalida                                     { result = Salida.new(val[0] , val[2])  }
               ;

 ElementoSalida: 'caracter'                                                    { result = Caracter.new(val[0].contenido )       }
               | Expresion                                                     { result = val[0]             }
               ;

      Expresion:    'num'                                                       { result = Entero.new(val[0].contenido)         }
               |    'true'                                                      { result = True.new()                 }
               |    'false'                                                     { result = False.new()                }
               |    'id'                                                        { result = Variable.new(val[0].contenido)       }
               |    '#' 'caracter'                                              { result = ValorAscii.new(val[0].contenido)     }
               |    Expresion '%'   Expresion                                   { result = Modulo.new(val[0], val[2]) }
               |    Expresion '++'                                              { result = SiguienteCar.new(val[0])   }
               |    Expresion '--'                                              { result = AnteriorCar.new(val[0])    }
               |    Expresion '::'  Expresion                                   { result = Concatenacion.new(val[0], val[2])   }
               |    Expresion '*'   Expresion                                   { result = Multiplicacion.new(val[0], val[2])  }
               |    Expresion '+'   Expresion                                   { result = Suma.new(val[0], val[2])            }
               |    Expresion '-'   Expresion                                   { result = Resta.new(val[0], val[2])           }
               |    Expresion '\/'   Expresion                                  { result = Division.new(val[0], val[2])        }
               |    Expresion '/='  Expresion                                   { result = Desigualdad.new(val[0], val[2])     }
               |    Expresion '<'   Expresion                                   { result = Menor.new(val[0], val[2])           }
               |    Expresion '<='  Expresion                                   { result = MenorIgual.new(val[0], val[2])      }
               |    Expresion '='   Expresion                                   { result = Igual.new(val[0], val[2])           }
               |    Expresion '>'   Expresion                                   { result = Mayor.new(val[0], val[2])           }
               |    Expresion '>='  Expresion                                   { result = MayorIgual.new(val[0], val[2])      }
               |    Expresion '\/\\'  Expresion                                         { result = And.new(val[0], val[2])     }
               |    Expresion '\\\/'  Expresion                                         { result = Or.new(val[0], val[2])      }
               |    'not' Expresion                                                     { result = Not.new(val[1])             }
               |    '$' Expresion                                                      { result = Shift.new(val[1])           }
               |    '-' Expresion = UMINUS                                            { result = MenosUnario.new(val[1])    }
               |    '(' Expresion ')'                                                 { result = val[1]                       }
               |    '[' Expresion ']'                                                 { result = val[1]                       }
               ;

---- header ----

require_relative 'Lexer'
require_relative 'AST_yo'


class ErrorSintactico < RuntimeError
  def initialize(token)
    @token = token
  end

  def to_s
    "Error de sintaxis en linea #{@token.linea}, columna #{@token.columna}, token '#{@token.contenido}' inesperado."
  end
end

---- inner ----

    def initialize(lexer)
      @lexer = lexer
      @yydebug = true
      super()
    end 

    def on_error(id, token, stack)
      raise ErrorSintactico.new(token)
    end

    def next_token
      @lexer.shift
    end

    def parse
      do_parse
    end