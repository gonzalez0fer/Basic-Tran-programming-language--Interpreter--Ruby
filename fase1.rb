class Token < ObjetoDeTexto
	class << self
		attr_accesor :regex
	end
	attr_accesor :linea, :columna
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
	'ValorAscii' => /\A#/         ,
	'Concatenacion' => /\A::/     ,
	'Shift' => /\A\$/             ,
}

palabras_reservadas = %w(with var begin end int while if else bool char num array read)