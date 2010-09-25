signature ParserBase =
sig
  type ('a, 'x) reader = ('a, 'x) StringCvt.reader
  type 'x state
  type ('a, 'x) consumer
  type ('a, 'b, 'x) parser = ('a, 'x) consumer -> ('b, 'x) consumer
  type ('a, 'b) result

  (* Look ma' - a (plus/state) monad *)
  val --> : ('a, 'b, 'x) parser * ('b -> ('a, 'c, 'x) parser) -> ('a, 'c, 'x) parser
  val return : 'b -> ('a, 'b, 'x) parser
  val fail : ('a, 'b, 'x) parser
  val ||| : ('a, 'b, 'x) parser * ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
  val getState : ('a, 'x state, 'x) parser
  val setState : 'x state -> ('a, unit, 'x) parser

  val ??? : ('a, 'b, 'x) parser * string -> ('a, 'b, 'x) parser
  val any : ('a, 'a, 'x) parser
  val try : ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser

  val parse : ('a, 'b, 'x) parser ->
              ('a -> string) ->
              ('a, 'x) reader ->
              'x -> ('a, 'b) result * 'x
  val scan : (''a, ''b, 'x) parser -> (''a, 'x) reader -> (''b, 'x) reader

end
