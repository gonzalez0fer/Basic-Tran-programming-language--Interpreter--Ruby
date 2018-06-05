#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.14
# from Racc grammer file "".
#

require 'racc/parser.rb'


require_relative 'Lexer'
require_relative 'AST'


class ErrorSintactico < RuntimeError
  def initialize(token)
    @token = token
  end

  def to_s
    "Error de sintaxis en linea #{@token.linea}, columna #{@token.columna}, token '#{@token.contenido}' inesperado."
  end
end
class Parser < Racc::Parser

module_eval(<<'...end Parser.y/module_eval...', 'Parser.y', 199)

    def on_error(id, token, stack)
      raise ErrorSintactico::new(token)
    end

    def next_token
      token = @lexer.shift
      puts "#{token}"
      return [false, false] unless token
      return [token.class, token]
    end

    def parse(lexer)
      @yydebug = true # DEBUG
      @lexer  = lexer
      @tokens = []
      begin
        ast = do_parse
      rescue Error => error
        t = false
        while (!t) do
          begin
            t = lexer.shift.nil?
            rescue Error => error
          end
        end
        puts lexer
      end
      return ast
    end
...end Parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    69,   117,    18,    69,    19,    69,    20,   101,    69,    69,
   124,    17,    18,    69,    19,   113,    20,    15,   100,   114,
    18,    17,    19,   115,    20,   113,    14,    15,    16,    17,
    12,    13,    69,   125,   121,    15,    14,   156,    16,   110,
    12,    13,   145,   139,    14,   126,    16,   123,    12,    13,
    11,    33,   120,    31,    24,    18,   102,    19,   114,    20,
    11,    33,   115,    31,    17,    73,    68,    72,    11,    33,
    15,   114,   114,    66,   147,   115,   115,   101,    98,    14,
    99,    16,     3,    12,    13,    35,     4,   147,   100,     9,
     7,   128,    18,   129,    19,     5,    20,     6,     8,   101,
   130,    17,   111,    11,     2,    28,   132,    15,   133,   117,
   100,    43,    44,    42,    45,    38,    14,    24,    16,     3,
    12,    13,    71,     4,   138,   103,     9,     7,   140,    18,
    22,    19,     5,    20,     6,     8,   142,   143,    17,   144,
    11,     2,    54,    61,    15,    18,   149,    19,   150,    20,
    42,    45,    38,    14,    17,    16,   151,    12,    13,   152,
    15,    43,    44,    42,    45,    38,    52,   153,    21,    14,
   155,    16,     3,    12,    13,    75,     4,    11,    33,     9,
     7,   157,    18,   158,    19,     5,    20,     6,     8,   159,
    63,    17,   nil,    11,     2,   nil,   nil,    15,    43,    44,
    42,    45,    38,    42,    45,    38,    14,   nil,    16,     3,
    12,    13,   nil,     4,   nil,   nil,     9,     7,   nil,    18,
   nil,    19,     5,    20,     6,     8,   nil,   nil,    17,   nil,
    11,     2,   nil,   nil,    15,    18,   nil,    19,   nil,    20,
   nil,   nil,   nil,    14,    17,    16,   nil,    12,    13,   nil,
    15,    18,   nil,    19,   nil,    20,   nil,   nil,   nil,    14,
    17,    16,   nil,    12,    13,   nil,    15,    11,    33,   nil,
   nil,   nil,   nil,   nil,   nil,    14,   nil,    16,     3,    12,
    13,   nil,     4,    11,    33,     9,     7,   nil,    18,   nil,
    19,     5,    20,     6,     8,   nil,   nil,    17,   nil,    11,
     2,   nil,   nil,    15,    18,   nil,    19,   nil,    20,   nil,
   nil,   nil,    14,    17,    16,   nil,    12,    13,   nil,    15,
    18,   nil,    19,   nil,    20,   nil,   nil,   nil,    14,    17,
    16,   nil,    12,    13,   nil,    15,    11,    33,   nil,   nil,
   nil,   nil,   nil,   nil,    14,   nil,    16,   nil,    12,    13,
   nil,   nil,    11,    33,   nil,    18,   nil,    19,   nil,    20,
   nil,   nil,   nil,    18,    17,    19,   nil,    20,    11,    33,
    15,    18,    17,    19,   nil,    20,   nil,   nil,    15,    14,
    17,    16,   nil,    12,    13,   nil,    15,    14,   nil,    16,
   nil,    12,    13,   nil,   nil,    14,   nil,    16,   nil,    12,
    13,   nil,   nil,    11,    33,   nil,    18,   nil,    19,   nil,
    20,    11,    33,   nil,    18,    17,    19,   nil,    20,    11,
    33,    15,   nil,    17,   nil,   nil,   nil,   nil,   nil,    15,
    14,   nil,    16,   nil,    12,    13,   nil,   nil,    14,   nil,
    16,   nil,    12,    13,    18,   nil,    19,   nil,    20,   nil,
   nil,   nil,   nil,    17,    11,    33,   nil,   nil,   nil,    15,
   nil,   nil,    11,    33,   nil,   nil,   nil,   nil,    14,   nil,
    16,     3,    12,    13,   nil,     4,   nil,   nil,     9,     7,
   nil,    18,   nil,    19,     5,    20,     6,     8,   nil,   nil,
    17,   nil,    11,     2,   nil,   nil,    15,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    14,   nil,    16,     3,    12,
    13,   nil,     4,   nil,   nil,     9,     7,   nil,    18,   nil,
    19,     5,    20,     6,     8,   nil,   nil,    17,   nil,    11,
     2,   nil,   nil,    15,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    14,   nil,    16,     3,    12,    13,   nil,     4,
   nil,   nil,     9,     7,   nil,    18,   nil,    19,     5,    20,
     6,     8,   nil,   nil,    17,   nil,    11,     2,   nil,   nil,
    15,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    14,
   nil,    16,     3,    12,    13,   nil,     4,   nil,   nil,     9,
     7,   nil,    18,   nil,    19,     5,    20,     6,     8,   nil,
   nil,    17,   nil,    11,     2,   nil,   nil,    15,    18,   nil,
    19,   nil,    20,   nil,   nil,   nil,    14,    17,    16,   nil,
    12,    13,   nil,    15,    18,   nil,    19,   nil,    20,   nil,
   nil,   nil,    14,    17,    16,   nil,    12,    13,   nil,    15,
    11,    33,   nil,   nil,   nil,   nil,   nil,   nil,    14,   nil,
    16,   nil,    12,    13,   nil,   nil,    11,    33,   nil,    18,
   nil,    19,   nil,    20,   nil,   nil,   nil,    18,    17,    19,
   nil,    20,    11,    33,    15,    18,    17,    19,   nil,    20,
   nil,   nil,    15,    14,    17,    16,   nil,    12,    13,   nil,
    15,    14,   nil,    16,   nil,    12,    13,   nil,   nil,    14,
   nil,    16,   nil,    12,    13,   nil,   nil,    11,    33,   nil,
    18,   nil,    19,   nil,    20,    11,    33,   nil,    18,    17,
    19,   nil,    20,    11,    33,    15,    18,    17,    19,   nil,
    20,   nil,   nil,    15,    14,    17,    16,   nil,    12,    13,
   nil,    15,    14,   nil,    16,   nil,    12,    13,   nil,   nil,
    14,   nil,    16,   nil,    12,    13,   nil,   nil,    11,    33,
   nil,    18,   nil,    19,   nil,    20,    11,    33,   nil,    18,
    17,    19,   nil,    20,    11,    33,    15,    18,    17,    19,
   nil,    20,   nil,   nil,    15,    14,    17,    16,   nil,    12,
    13,   nil,    15,    14,   nil,    16,   nil,    12,    13,   nil,
   nil,    14,   nil,    16,   nil,    12,    13,   nil,   nil,    11,
    33,   nil,    18,   nil,    19,   nil,    20,    11,    33,   nil,
    18,    17,    19,   nil,    20,    11,    33,    15,    18,    17,
    19,   nil,    20,   nil,   nil,    15,    14,    17,    16,   nil,
    12,    13,   nil,    15,    14,   nil,    16,   nil,    12,    13,
   nil,   nil,    14,   nil,    16,   nil,    12,    13,   nil,   nil,
    11,    33,   nil,   nil,   nil,   nil,   nil,   nil,    11,    33,
   nil,   nil,   nil,   nil,   nil,   nil,    11,    33,    43,    44,
    42,    45,    38,    52,    53,   127,    46,    47,    48,    50,
    51,    49,    39,    40,   nil,    41,   nil,    43,    44,    42,
    45,    38,    52,    53,   nil,    46,    47,    48,    50,    51,
    49,    39,    40,    37,    41,   nil,   122,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    43,    44,    42,    45,    38,    52,
    53,    37,    46,    47,    48,    50,    51,    49,    39,    40,
   nil,    41,    43,    44,    42,    45,    38,    52,    53,   nil,
    46,    47,    48,    50,    51,    49,    39,    40,   nil,    41,
    37,    70,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    43,    44,    42,    45,    38,    52,    53,   nil,    46,
    47,    48,    50,    51,    49,    39,    40,    95,    41,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    43,    44,    42,
    45,    38,    52,    53,   nil,    46,    47,    48,    50,    51,
    49,    39,    40,    92,    41,   nil,   nil,   nil,   nil,   nil,
    43,    44,    42,    45,    38,    52,    53,   nil,    46,    47,
    48,    50,    51,    49,    39,    40,   136,    41,   nil,   nil,
   137,   nil,    43,    44,    42,    45,    38,    52,    53,   nil,
    46,    47,    48,    50,    51,    49,    39,    40,    93,    41,
   nil,   nil,   nil,    43,    44,    42,    45,    38,    52,    53,
   nil,    46,    47,    48,    50,    51,    49,    39,    40,    94,
    41,   nil,    43,    44,    42,    45,    38,    52,    53,   nil,
    46,    47,    48,    50,    51,    49,    39,    40,    74,    41,
    43,    44,    42,    45,    38,    52,    53,   nil,    46,    47,
    48,    50,    51,    49,    39,    40,    76,    41,    43,    44,
    42,    45,    38,    52,    53,   nil,    46,    47,    48,    50,
    51,    49,    39,    40,   nil,    41,    43,    44,    42,    45,
    38,    52,    53,   nil,    46,    47,    48,    50,    51,    49,
    39,    40,   nil,    41,    43,    44,    42,    45,    38,    52,
    53,   nil,    46,    47,    48,    50,    51,    49,    39,    40,
   nil,    41,    43,    44,    42,    45,    38,    52,    53,   nil,
    46,    47,    48,    50,    51,    49,    39,    40,    43,    44,
    42,    45,    38,    52,    53,   nil,    46,    47,    48,    50,
    51,    49,    39,    40,    43,    44,    42,    45,    38,    52,
    53,   nil,   nil,    47,    48,    50,    51,    43,    44,    42,
    45,    38,    52,    53,   nil,   nil,   -60,   -60,   -60,   -60,
    43,    44,    42,    45,    38,    52,    53,   nil,   nil,   -60,
   -60,   -60,   -60,    43,    44,    42,    45,    38,    52,    53,
   nil,   nil,    47,    48,    50,    51,    43,    44,    42,    45,
    38,    52,    53,   nil,   nil,   -60,   -60,   -60,   -60,    43,
    44,    42,    45,    38,    52,    53,   nil,   nil,   -60,   -60,
   -60,   -60 ]

racc_action_check = [
   107,   101,     6,   154,     6,    96,     6,   117,   141,   135,
   110,     6,    73,   109,    73,   111,    73,     6,   117,    99,
   122,    73,   122,    99,   122,    99,     6,    73,     6,   122,
     6,     6,    25,   112,   107,   122,    73,   154,    73,    96,
    73,    73,   141,   135,   122,   113,   122,   109,   122,   122,
     6,     6,   107,     6,    24,   137,    67,   137,   142,   137,
    73,    73,   142,    73,   137,    29,    25,    29,   122,   122,
   137,   159,   102,    24,   142,   159,   102,    66,    65,   137,
    66,   137,   137,   137,   137,     8,   137,   159,    66,   137,
   137,   119,   152,   120,   152,   137,   152,   137,   137,    98,
   121,   152,    98,   137,   137,     5,   123,   152,   126,   127,
    98,    55,    55,    55,    55,    55,   152,     3,   152,   152,
   152,   152,    28,   152,   133,    68,   152,   152,   136,     7,
     2,     7,   152,     7,   152,   152,   138,   139,     7,   140,
   152,   152,    14,    21,     7,     4,   144,     4,   147,     4,
    82,    82,    82,     7,     4,     7,   148,     7,     7,   149,
     4,    91,    91,    91,    91,    91,    91,   150,     1,     4,
   153,     4,     4,     4,     4,    35,     4,     7,     7,     4,
     4,   155,   129,   157,   129,     4,   129,     4,     4,   158,
    23,   129,   nil,     4,     4,   nil,   nil,   129,    90,    90,
    90,    90,    90,    81,    81,    81,   129,   nil,   129,   129,
   129,   129,   nil,   129,   nil,   nil,   129,   129,   nil,     9,
   nil,     9,   129,     9,   129,   129,   nil,   nil,     9,   nil,
   129,   129,   nil,   nil,     9,   100,   nil,   100,   nil,   100,
   nil,   nil,   nil,     9,   100,     9,   nil,     9,     9,   nil,
   100,    76,   nil,    76,   nil,    76,   nil,   nil,   nil,   100,
    76,   100,   nil,   100,   100,   nil,    76,     9,     9,   nil,
   nil,   nil,   nil,   nil,   nil,    76,   nil,    76,    76,    76,
    76,   nil,    76,   100,   100,    76,    76,   nil,    15,   nil,
    15,    76,    15,    76,    76,   nil,   nil,    15,   nil,    76,
    76,   nil,   nil,    15,    16,   nil,    16,   nil,    16,   nil,
   nil,   nil,    15,    16,    15,   nil,    15,    15,   nil,    16,
    17,   nil,    17,   nil,    17,   nil,   nil,   nil,    16,    17,
    16,   nil,    16,    16,   nil,    17,    15,    15,   nil,   nil,
   nil,   nil,   nil,   nil,    17,   nil,    17,   nil,    17,    17,
   nil,   nil,    16,    16,   nil,    18,   nil,    18,   nil,    18,
   nil,   nil,   nil,    19,    18,    19,   nil,    19,    17,    17,
    18,    20,    19,    20,   nil,    20,   nil,   nil,    19,    18,
    20,    18,   nil,    18,    18,   nil,    20,    19,   nil,    19,
   nil,    19,    19,   nil,   nil,    20,   nil,    20,   nil,    20,
    20,   nil,   nil,    18,    18,   nil,    75,   nil,    75,   nil,
    75,    19,    19,   nil,    22,    75,    22,   nil,    22,    20,
    20,    75,   nil,    22,   nil,   nil,   nil,   nil,   nil,    22,
    75,   nil,    75,   nil,    75,    75,   nil,   nil,    22,   nil,
    22,   nil,    22,    22,    74,   nil,    74,   nil,    74,   nil,
   nil,   nil,   nil,    74,    75,    75,   nil,   nil,   nil,    74,
   nil,   nil,    22,    22,   nil,   nil,   nil,   nil,    74,   nil,
    74,    74,    74,    74,   nil,    74,   nil,   nil,    74,    74,
   nil,     0,   nil,     0,    74,     0,    74,    74,   nil,   nil,
     0,   nil,    74,    74,   nil,   nil,     0,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     0,   nil,     0,     0,     0,
     0,   nil,     0,   nil,   nil,     0,     0,   nil,    69,   nil,
    69,     0,    69,     0,     0,   nil,   nil,    69,   nil,     0,
     0,   nil,   nil,    69,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    69,   nil,    69,    69,    69,    69,   nil,    69,
   nil,   nil,    69,    69,   nil,    63,   nil,    63,    69,    63,
    69,    69,   nil,   nil,    63,   nil,    69,    69,   nil,   nil,
    63,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    63,
   nil,    63,    63,    63,    63,   nil,    63,   nil,   nil,    63,
    63,   nil,    53,   nil,    53,    63,    53,    63,    63,   nil,
   nil,    53,   nil,    63,    63,   nil,   nil,    53,    52,   nil,
    52,   nil,    52,   nil,   nil,   nil,    53,    52,    53,   nil,
    53,    53,   nil,    52,    51,   nil,    51,   nil,    51,   nil,
   nil,   nil,    52,    51,    52,   nil,    52,    52,   nil,    51,
    53,    53,   nil,   nil,   nil,   nil,   nil,   nil,    51,   nil,
    51,   nil,    51,    51,   nil,   nil,    52,    52,   nil,    50,
   nil,    50,   nil,    50,   nil,   nil,   nil,    49,    50,    49,
   nil,    49,    51,    51,    50,    48,    49,    48,   nil,    48,
   nil,   nil,    49,    50,    48,    50,   nil,    50,    50,   nil,
    48,    49,   nil,    49,   nil,    49,    49,   nil,   nil,    48,
   nil,    48,   nil,    48,    48,   nil,   nil,    50,    50,   nil,
    37,   nil,    37,   nil,    37,    49,    49,   nil,    38,    37,
    38,   nil,    38,    48,    48,    37,    41,    38,    41,   nil,
    41,   nil,   nil,    38,    37,    41,    37,   nil,    37,    37,
   nil,    41,    38,   nil,    38,   nil,    38,    38,   nil,   nil,
    41,   nil,    41,   nil,    41,    41,   nil,   nil,    37,    37,
   nil,    42,   nil,    42,   nil,    42,    38,    38,   nil,    43,
    42,    43,   nil,    43,    41,    41,    42,    44,    43,    44,
   nil,    44,   nil,   nil,    43,    42,    44,    42,   nil,    42,
    42,   nil,    44,    43,   nil,    43,   nil,    43,    43,   nil,
   nil,    44,   nil,    44,   nil,    44,    44,   nil,   nil,    42,
    42,   nil,    45,   nil,    45,   nil,    45,    43,    43,   nil,
    46,    45,    46,   nil,    46,    44,    44,    45,    47,    46,
    47,   nil,    47,   nil,   nil,    46,    45,    47,    45,   nil,
    45,    45,   nil,    47,    46,   nil,    46,   nil,    46,    46,
   nil,   nil,    47,   nil,    47,   nil,    47,    47,   nil,   nil,
    45,    45,   nil,   nil,   nil,   nil,   nil,   nil,    46,    46,
   nil,   nil,   nil,   nil,   nil,   nil,    47,    47,   108,   108,
   108,   108,   108,   108,   108,   116,   108,   108,   108,   108,
   108,   108,   108,   108,   nil,   108,   nil,   116,   116,   116,
   116,   116,   116,   116,   nil,   116,   116,   116,   116,   116,
   116,   116,   116,    10,   116,   nil,   108,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    10,    10,    10,    10,    10,    10,
    10,   104,    10,    10,    10,    10,    10,    10,    10,    10,
   nil,    10,   104,   104,   104,   104,   104,   104,   104,   nil,
   104,   104,   104,   104,   104,   104,   104,   104,   nil,   104,
    26,    26,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    26,    26,    26,    26,    26,    26,    26,   nil,    26,
    26,    26,    26,    26,    26,    26,    26,    62,    26,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    62,    62,    62,
    62,    62,    62,    62,   nil,    62,    62,    62,    62,    62,
    62,    62,    62,    58,    62,   nil,   nil,   nil,   nil,   nil,
    58,    58,    58,    58,    58,    58,    58,   nil,    58,    58,
    58,    58,    58,    58,    58,    58,   131,    58,   nil,   nil,
   131,   nil,   131,   131,   131,   131,   131,   131,   131,   nil,
   131,   131,   131,   131,   131,   131,   131,   131,    59,   131,
   nil,   nil,   nil,    59,    59,    59,    59,    59,    59,    59,
   nil,    59,    59,    59,    59,    59,    59,    59,    59,    60,
    59,   nil,    60,    60,    60,    60,    60,    60,    60,   nil,
    60,    60,    60,    60,    60,    60,    60,    60,    34,    60,
    34,    34,    34,    34,    34,    34,    34,   nil,    34,    34,
    34,    34,    34,    34,    34,    34,    36,    34,    36,    36,
    36,    36,    36,    36,    36,   nil,    36,    36,    36,    36,
    36,    36,    36,    36,   nil,    36,    32,    32,    32,    32,
    32,    32,    32,   nil,    32,    32,    32,    32,    32,    32,
    32,    32,   nil,    32,    77,    77,    77,    77,    77,    77,
    77,   nil,    77,    77,    77,    77,    77,    77,    77,    77,
   nil,    77,    79,    79,    79,    79,    79,    79,    79,   nil,
    79,    79,    79,    79,    79,    79,    79,    79,    56,    56,
    56,    56,    56,    56,    56,   nil,    56,    56,    56,    56,
    56,    56,    56,    56,    84,    84,    84,    84,    84,    84,
    84,   nil,   nil,    84,    84,    84,    84,    85,    85,    85,
    85,    85,    85,    85,   nil,   nil,    85,    85,    85,    85,
    86,    86,    86,    86,    86,    86,    86,   nil,   nil,    86,
    86,    86,    86,    87,    87,    87,    87,    87,    87,    87,
   nil,   nil,    87,    87,    87,    87,    88,    88,    88,    88,
    88,    88,    88,   nil,   nil,    88,    88,    88,    88,    89,
    89,    89,    89,    89,    89,    89,   nil,   nil,    89,    89,
    89,    89 ]

racc_action_pointer = [
   475,   168,   117,    81,   139,    50,    -4,   123,    30,   213,
   910,   nil,   nil,   nil,    85,   282,   298,   314,   349,   357,
   365,   143,   408,   153,    18,    28,   957,   nil,   118,    63,
   nil,   nil,  1122,   nil,  1086,   124,  1104,   704,   712,   nil,
   nil,   720,   755,   763,   771,   806,   814,   822,   669,   661,
   653,   618,   602,   586,   nil,    97,  1174,   nil,  1006,  1049,
  1068,   nil,   983,   549,   nil,    23,    75,    51,   121,   512,
   nil,   nil,   nil,     6,   438,   400,   245,  1140,   nil,  1158,
   nil,   187,   134,   nil,  1190,  1203,  1216,  1229,  1242,  1255,
   184,   147,   nil,   nil,   nil,   nil,     1,   nil,    97,   -20,
   229,   -54,    33,   nil,   928,   nil,   nil,    -4,   864,     9,
     6,   -30,    29,    37,   nil,   nil,   883,     5,   nil,    87,
    81,    96,    14,   102,   nil,   nil,    54,    54,   nil,   176,
   nil,  1028,   nil,   115,   nil,     5,    78,    49,    89,   133,
    85,     4,    19,   nil,   137,   nil,   nil,   143,   152,   147,
   122,   nil,    86,   162,    -1,   127,   nil,   174,   142,    32,
   nil ]

racc_action_default = [
   -60,   -60,   -36,   -60,   -60,   -60,   -60,   -60,   -60,   -60,
   -60,   -33,   -34,   -35,   -60,   -60,   -60,   -60,   -60,   -60,
   -60,   -60,   -60,   -60,   -26,   -60,   -60,   -12,   -60,   -60,
   -29,   -31,   -32,   -36,   -60,   -60,   -60,   -60,   -60,   -39,
   -40,   -60,   -60,   -60,   -60,   -60,   -60,   -60,   -60,   -60,
   -60,   -60,   -60,   -60,   -37,   -54,   -55,   -56,   -60,   -60,
   -60,   161,   -60,   -60,   -16,   -26,   -60,   -60,   -60,   -60,
   -13,    -4,    -5,   -60,   -60,   -60,   -60,   -11,   -38,   -41,
   -42,   -43,   -44,   -45,   -46,   -47,   -48,   -49,   -50,   -51,
   -52,   -53,   -57,   -58,   -59,    -1,   -60,   -17,   -60,   -60,
   -60,   -26,   -60,    -3,   -15,   -14,   -30,   -60,   -60,   -60,
   -60,   -60,   -60,   -60,   -27,   -28,   -25,   -60,   -24,   -60,
   -60,   -60,   -60,   -60,    -2,   -18,   -60,   -26,   -19,   -60,
    -7,   -60,   -10,   -60,   -23,   -60,   -60,   -60,   -60,   -60,
   -60,   -60,   -60,    -6,   -60,    -9,   -20,   -60,   -60,   -60,
   -60,   -22,   -60,   -60,   -60,   -60,    -8,   -60,   -60,   -60,
   -21 ]

racc_goto_table = [
    25,    30,    10,   118,     1,    23,   146,   112,    32,    34,
   119,    36,    29,   nil,   nil,    64,   nil,    55,    56,    57,
    58,    59,    60,   160,    62,   nil,    65,   nil,   nil,   134,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    77,
    78,   nil,   nil,    79,    80,    81,    82,    83,    84,    85,
    86,    87,    88,    89,    90,    91,    97,   nil,   nil,    96,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   106,   nil,
   107,   104,   109,   105,   nil,    32,   nil,   108,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   116,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   131,   135,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   141,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   154 ]

racc_goto_check = [
     4,    10,     2,     8,     1,     3,     9,     7,     2,     2,
     7,     2,     5,   nil,   nil,     6,   nil,     2,     2,     2,
     2,     2,     2,     9,     2,   nil,     3,   nil,   nil,     8,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     2,
     2,   nil,   nil,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     6,   nil,   nil,     4,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    10,   nil,
     4,     2,     4,     1,   nil,     2,   nil,     2,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,     2,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,     2,     4,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     4,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4 ]

racc_goto_pointer = [
   nil,     4,     2,     2,    -4,     6,    -9,   -92,   -98,  -136,
    -5 ]

racc_goto_default = [
   nil,    27,    26,   nil,   nil,   nil,   nil,   148,    67,   nil,
   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  4, 59, :_reduce_1,
  6, 59, :_reduce_2,
  4, 59, :_reduce_3,
  3, 59, :_reduce_4,
  3, 59, :_reduce_5,
  9, 59, :_reduce_6,
  6, 59, :_reduce_7,
  13, 59, :_reduce_8,
  9, 59, :_reduce_9,
  6, 59, :_reduce_10,
  3, 59, :_reduce_11,
  1, 62, :_reduce_12,
  2, 62, :_reduce_13,
  3, 62, :_reduce_14,
  3, 62, :_reduce_15,
  2, 61, :_reduce_16,
  3, 61, :_reduce_17,
  5, 61, :_reduce_18,
  4, 64, :_reduce_19,
  8, 64, :_reduce_20,
  8, 67, :_reduce_21,
  2, 67, :_reduce_22,
  5, 66, :_reduce_23,
  3, 66, :_reduce_24,
  3, 66, :_reduce_25,
  0, 66, :_reduce_26,
  1, 65, :_reduce_27,
  1, 65, :_reduce_28,
  1, 63, :_reduce_29,
  3, 63, :_reduce_30,
  1, 68, :_reduce_31,
  1, 68, :_reduce_32,
  1, 60, :_reduce_33,
  1, 60, :_reduce_34,
  1, 60, :_reduce_35,
  1, 60, :_reduce_36,
  2, 60, :_reduce_37,
  3, 60, :_reduce_38,
  2, 60, :_reduce_39,
  2, 60, :_reduce_40,
  3, 60, :_reduce_41,
  3, 60, :_reduce_42,
  3, 60, :_reduce_43,
  3, 60, :_reduce_44,
  3, 60, :_reduce_45,
  3, 60, :_reduce_46,
  3, 60, :_reduce_47,
  3, 60, :_reduce_48,
  3, 60, :_reduce_49,
  3, 60, :_reduce_50,
  3, 60, :_reduce_51,
  3, 60, :_reduce_52,
  3, 60, :_reduce_53,
  2, 60, :_reduce_54,
  2, 60, :_reduce_55,
  2, 60, :_reduce_56,
  3, 60, :_reduce_57,
  3, 60, :_reduce_58,
  3, 60, :_reduce_59 ]

racc_reduce_n = 60

racc_shift_n = 161

racc_token_table = {
  false => 0,
  :error => 1,
  TkComa => 2,
  TkPunto => 3,
  TkPuntoYComa => 4,
  TkDosPuntos => 5,
  TkParAbre => 6,
  TkParCierra => 7,
  TkCorcheteAbre => 8,
  TkCorcheteCierre => 9,
  TkLlaveAbre => 10,
  TkLlaveCierra => 11,
  TkHacer => 12,
  TkAsignacion => 13,
  TkSuma => 14,
  TkResta => 15,
  TkMult => 16,
  TkDiv => 17,
  TkMod => 18,
  TkConjuncion => 19,
  TkDisyuncion => 20,
  TkNegacion => 21,
  TkDesigualdad => 22,
  TkMenor => 23,
  TkMenorIgual => 24,
  TkMayor => 25,
  TkMayorIgual => 26,
  TkIgual => 27,
  TkSiguienteCar => 28,
  TkAnteriorCar => 29,
  TkValorAscii => 30,
  TkConcatenacion => 31,
  TkShift => 32,
  TkWith => 33,
  TkTrue => 34,
  TkFalse => 35,
  TkVar => 36,
  TkBegin => 37,
  TkEnd => 38,
  TkInt => 39,
  TkWhile => 40,
  TkIf => 41,
  TkElse => 42,
  TkBool => 43,
  TkChar => 44,
  TkArray => 45,
  TkRead => 46,
  TkOf => 47,
  TkPrint => 48,
  TkFor => 49,
  TkStep => 50,
  TkFrom => 51,
  TkTo => 52,
  :UMINUS => 53,
  TkNum => 54,
  TkId => 55,
  "otherwise" => 56,
  "caracter" => 57 }

racc_nt_base = 58

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "\",\"",
  "\".\"",
  "\";\"",
  "\":\"",
  "\"(\"",
  "\")\"",
  "\"[\"",
  "\"]\"",
  "\"{\"",
  "\"}\"",
  "\"->\"",
  "\"<-\"",
  "\"+\"",
  "\"-\"",
  "\"*\"",
  "\"\\\\/\"",
  "\"%\"",
  "\"\\\\/\\\\\"",
  "\"\\\\\\\\/\"",
  "\"not\"",
  "\"/=\"",
  "\"<\"",
  "\"<=\"",
  "\">\"",
  "\">=\"",
  "\"=\"",
  "\"++\"",
  "\"--\"",
  "\"#\"",
  "\"::\"",
  "\"$\"",
  "\"with\"",
  "\"true\"",
  "\"false\"",
  "\"var\"",
  "\"begin\"",
  "\"end\"",
  "\"int\"",
  "\"while\"",
  "\"if\"",
  "\"else\"",
  "\"bool\"",
  "\"char\"",
  "\"array\"",
  "\"read\"",
  "\"of\"",
  "\"print\"",
  "\"for\"",
  "\"step\"",
  "\"from\"",
  "\"to\"",
  "UMINUS",
  "\"num\"",
  "\"id\"",
  "\"otherwise\"",
  "\"caracter\"",
  "$start",
  "Instruccion",
  "Expresion",
  "LDeclaraciones",
  "Instrucciones",
  "ElementosSalida",
  "Declaracion",
  "Tipo",
  "Argumentos",
  "Array",
  "ElementoSalida" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'Parser.y', 97)
  def _reduce_1(val, _values, result)
      result = Asignacion::new(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 98)
  def _reduce_2(val, _values, result)
     result = WBloque::new(val[1], val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 99)
  def _reduce_3(val, _values, result)
      result = Bloque::new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 100)
  def _reduce_4(val, _values, result)
      result = Read::new(val[1])  
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 101)
  def _reduce_5(val, _values, result)
      result = Print::new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 103)
  def _reduce_6(val, _values, result)
     result = IfOtherEnd::new(val[1], val[3])
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 104)
  def _reduce_7(val, _values, result)
     result = IfEnd::new(val[1], [val[3]])
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 107)
  def _reduce_8(val, _values, result)
    result = Iteracion_DetStep::new(val[1],val[3], val[5], val[8], val[11])
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 109)
  def _reduce_9(val, _values, result)
    result = Iteracion_Det::new(val[1],val[3], val[5]), val[7]
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 111)
  def _reduce_10(val, _values, result)
     result = Iteracion_Indet::new(val[1], val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 112)
  def _reduce_11(val, _values, result)
     result = Punto::new(val[0], val[2])   
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 115)
  def _reduce_12(val, _values, result)
     result = [val[0]]           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 116)
  def _reduce_13(val, _values, result)
     result = [val[0]]           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 117)
  def _reduce_14(val, _values, result)
     result = val[0] + [val[2]]  
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 118)
  def _reduce_15(val, _values, result)
     result = val[0] + [val[2]]  
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 121)
  def _reduce_16(val, _values, result)
     result = LDeclaracion::new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 122)
  def _reduce_17(val, _values, result)
     result = LDeclaracionRec::new(val[1], val[2] )
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 123)
  def _reduce_18(val, _values, result)
     result = LDeclaracionId::new(val[1], val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 126)
  def _reduce_19(val, _values, result)
     result = Declaracion::new(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 127)
  def _reduce_20(val, _values, result)
     result = DeclaracionMatriz::new(val[0], val[4], val[6])
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 130)
  def _reduce_21(val, _values, result)
     result = DeclaracionMatriz::new(val[0], val[4], val[6])
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 131)
  def _reduce_22(val, _values, result)
     result = val[0]
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 135)
  def _reduce_23(val, _values, result)
     result = val[0] + val[2] + [val[4]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 136)
  def _reduce_24(val, _values, result)
     result = val[0] + [val[2]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 137)
  def _reduce_25(val, _values, result)
     result = val[0] + val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 138)
  def _reduce_26(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 141)
  def _reduce_27(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 142)
  def _reduce_28(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 145)
  def _reduce_29(val, _values, result)
     result = [val[0]]           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 146)
  def _reduce_30(val, _values, result)
     result = val[0] + [val[2]]  
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 149)
  def _reduce_31(val, _values, result)
     result = val[0]             
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 150)
  def _reduce_32(val, _values, result)
     result = val[0]             
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 153)
  def _reduce_33(val, _values, result)
     result = Entero::new(val[0])         
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 154)
  def _reduce_34(val, _values, result)
     result = True::new()                 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 155)
  def _reduce_35(val, _values, result)
     result = False::new()                
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 156)
  def _reduce_36(val, _values, result)
     result = Variable::new(val[0])       
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 157)
  def _reduce_37(val, _values, result)
     result = ValorAscii::new(val[0])     
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 158)
  def _reduce_38(val, _values, result)
     result = Modulo::new(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 159)
  def _reduce_39(val, _values, result)
     result = SiguienteCar::new(val[0])   
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 160)
  def _reduce_40(val, _values, result)
     result = AnteriorCar::new(val[0])    
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 161)
  def _reduce_41(val, _values, result)
     result = Concatenacion::new(val[0], val[2])   
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 162)
  def _reduce_42(val, _values, result)
     result = Multiplicacion::new(val[0], val[2])  
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 163)
  def _reduce_43(val, _values, result)
     result = Suma::new(val[0], val[2])            
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 164)
  def _reduce_44(val, _values, result)
     result = Resta::new(val[0], val[2])           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 165)
  def _reduce_45(val, _values, result)
     result = Division::new(val[0], val[2])        
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 166)
  def _reduce_46(val, _values, result)
     result = Desigualdad::new(val[0], val[2])     
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 167)
  def _reduce_47(val, _values, result)
     result = Menor::new(val[0], val[2])           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 168)
  def _reduce_48(val, _values, result)
     result = MenorIgual::new(val[0], val[2])      
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 169)
  def _reduce_49(val, _values, result)
     result = Igual::new(val[0], val[2])           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 170)
  def _reduce_50(val, _values, result)
     result = Mayor::new(val[0], val[2])           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 171)
  def _reduce_51(val, _values, result)
     result = MayorIgual::new(val[0], val[2])      
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 172)
  def _reduce_52(val, _values, result)
     result = And::new(val[0], val[2])     
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 173)
  def _reduce_53(val, _values, result)
     result = Or::new(val[0], val[2])      
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 174)
  def _reduce_54(val, _values, result)
     result = Not::new(val[1])             
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 175)
  def _reduce_55(val, _values, result)
     result = Shift::new(val[1])           
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 176)
  def _reduce_56(val, _values, result)
     result = MenosUnario::new(val[1])    
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 177)
  def _reduce_57(val, _values, result)
     result = val[1]                       
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 178)
  def _reduce_58(val, _values, result)
     result = val[1]                       
    result
  end
.,.,

module_eval(<<'.,.,', 'Parser.y', 179)
  def _reduce_59(val, _values, result)
     result = val[1]                       
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

end   # class Parser
