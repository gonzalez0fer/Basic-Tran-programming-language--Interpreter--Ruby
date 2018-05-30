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


    