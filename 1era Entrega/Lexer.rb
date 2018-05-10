class ExcepcionLexer


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
end

