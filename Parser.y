#	Irina Marcano 13-10805
#	Fernando Gonzalez 08-10464 


class Parser

    #Procedemos a declarar los tokens de BasicTran

    token   ',' '.' ';' ':' '(' ')' '[' ']' '{' '}' '->' '<-'
            '+' '-' '*' '/' '%' '/\' '\/' 'not' '/=' '<' '<='
            '>' '>=' '=' '++' '--' '#' '::' '$' 'with' 'true' 
            'false' 'var' 'begin' 'end' 'int' 'while' 'if' 
            'else' 'bool' 'char' 'array' 'read' 'of' 'print' 
            'for' 'step' 'from' 'to' UMINUS
           
    #Declaramos la presedencia de los operadores donde el de mayor presedencia
    #se encuentra de primero en la tabla

    prechigh
        nonassoc    UMINUS
        left        '*' '/' '%'            
        left        '+' '-'   
        left        'not'   
        left        '/\'            
        left        '\/'   
        left        '#'   
        left        '--'   
        left        '++'   
        left        '[]'   
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
        ']'         'TkCorcheteCierra'
        '{'         'TkLlaveAbre'
        '}'         'TkLlaveCierra'
        '-'         'TkResta'
        '->'        'TkHacer'
        '<-'        'TkAsignacion'
        '+'         'TkSuma'
        '/='        'TkDesigual'
        ';'         'TkPuntoYComa'
        '*'         'TkMult'
        '/'         'TkDiv'
        '%'         'TkMod'
        '/\'        'TkConjuncion'
        '\/'        'TkDisyuncion'
        'not'       'TkNegacion'
        '<'         'TkMenor'
        '<='        'TkMenorIgual'
        '>'         'TkMayorIgual'
        '='         'Tkigual'
        '++'        'TkSiguienteCar'
        '--'        'TkAnteriorCar'
        '#'         'TkValorAscii'
        '::'        'TkConcatenacion'
        '$'         'TkShift'     
        'with'      'Tkwith' 
        'true'      'Tktrue' 
        'false'     'Tkfalse' 
        'var'       'Tkvar'   
        'begin'     'Tkbegin' 
        'end'       'Tkend' 
        'int'       'Tkint' 
        'while'     'Tkwhile' 
        'if'        'Tkif' 
        'else'      'Tkelse' 
        'bool'      'Tkbool' 
        'char'      'Tkchar' 
        'array'     'Tkarray' 
        'read'      'Tkread' 
        'of'        'Tkof' 
        'print'     'Tkprint' 
        'for'       'Tkfor' 
        'step'      'Tkstep'
        'from'      'Tkfrom' 
        'to'        'Tkto'
    end


#declarando la gramatica

rule

    Instruccion:    'id' '<-' Expresion                                            {  result = Asignacion::new(val[0], val[2]) }

                |   'begin' Instrucciones 'end'                                         {  result = Bloque::new(val[1])}

                |   'read' 'id'                                                         {  result = Read::new(val[1])  }

                |   'print' ElementoSalida                                              {  result = Print::new(val[1]) }

                |   'if' Expresion 'else' Instruccion                           { result = Condicional_Else::new(val[1], val[3])}

                |'for' 'id' 'from' Expresion 'to' Expresion '->'Instruccion  
                                          {result = Iteracion_Det::new(val[1],val[3], val[5]), val[7]}

                |'for' 'id' 'from' Expresion 'to' Expresion '[' 'step' Paso ']' '->' Instruccion              
                                          {result = Iteracion_Det::new(val[1],val[3], val[5], val[8], val[11])}

                |   'while' Expresion '->' Instruccion                        { result = Iteracion_Indet::new(val[1], val[3]) }

                ;
  
    Declaraciones: 'with' LDeclaraciones                                           { result = Declaraciones::new(val[1]) }
                |                                                                  { result = Declaraciones::new([])     }
                ;

    LDeclaraciones: Declaracion                                                         { result = [val[0]] }
                | LDeclaraciones ';' Declaracion                                        { result = val[0] + [val[2]] }
                ;

    Declaracion: 'var' Variables ':' Tipo                           { result = Declaracion::new(val[1], val[3]) }
                | 'var' Variables ':' 'array' '[' Paso ']' 'of' Tipo 
                                                          { result = Declaracion::new(val[1], val[3], val[5], val[8])}
                ;

           Tipo: 'int'                                                                  { result = val[0] }
                | 'bool'                                                                { result = val[0] }
                ;

        Variables: Variables ',' 'id'                                                   { result = val[0] + [val[2]]  }
               | 'id'                                                                   { result = [val[0]]           }
               ;

  Instrucciones: Instruccion                                                            { result = [val[0]]           }
               | Instrucciones ';' Instruccion                                          { result = val[0] + [val[2]]  }
               ;

ElementosSalida: ElementoSalida                                                         { result = [val[0]]           }
               | ElementosSalida ',' ElementoSalida                                     { result = val[0] + [val[2]]  }
               ;

 ElementoSalida: 'char'                                                                 { result = val[0]             }
               | Expresion                                                              { result = val[0]             }
               ;

           Paso: 'num'                                                      {result = Entero::new(val[0])} 
               ;


      Expresion:    'num'                                                       { result = Entero::new(val[0])         }
               |    'true'                                                      { result = True::new()                 }
               |    'false'                                                     { result = False::new()                }
               |    'id'                                                        { result = Variable::new(val[0])       }
               |    '#'                                                         { result = ValorAscii::new(val[0])     }
               |    Expresion '%'   Expresion                                   { result = Modulo::new(val[0], val[2]) }
               |    Expresion '++'                                              { result = SiguienteCar::new(val[0])   }
               |    Expresion '--'                                              { result = AnteriorCar::new(val[0])    }
               |    Expresion '::'  Expresion                                   { result = Concatenacion::new(val[0], val[2])   }
               |    Expresion '*'   Expresion                                   { result = Multiplicacion::new(val[0], val[2])  }
               |    Expresion '+'   Expresion                                   { result = Suma::new(val[0], val[2])            }
               |    Expresion '-'   Expresion                                   { result = Resta::new(val[0], val[2])           }
               |    Expresion '/'   Expresion                                   { result = Division::new(val[0], val[2])        }
               |    Expresion '/='  Expresion                                   { result = Desigual::new(val[0], val[2])        }
               |    Expresion '<'   Expresion                                   { result = Menor::new(val[0], val[2])           }
               |    Expresion '<='  Expresion                                   { result = MenorIgual::new(val[0], val[2])      }
               |    Expresion '='   Expresion                                   { result = Igual::new(val[0], val[2])           }
               |    Expresion '>'   Expresion                                   { result = Mayor::new(val[0], val[2])           }
               |    Expresion '>='  Expresion                                   { result = MayorIgual::new(val[0], val[2])      }
               |    Expresion '/\'  Expresion                                           { result = And::new(val[0], val[2])     }
               |    Expresion '\/'  Expresion                                           { result = Or::new(val[0], val[2])      }
               |    'not' Expresion                                                     { result = Not::new(val[1])             }
               |    '$' Expresion                                                       { result = Shift::new(val[1])           }
               |    Expresion '.' Expresion                                             { result = Punto::new(val[0], val[2])   }
               |    '-'   Expresion = UMINUS                                            { result = Menos_Unario::new(val[1])    }
               |    '(' Expresion ')'                                                   { result = val[1]                       }
               |    '[' Expresion ']'                                                   { result = val[1]                       }
               |    '{' Expresion '}'                                                   { result = val[1]                       }
               ;