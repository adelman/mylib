(* This here is a hack. Since the preprocessor don't know about comments in mlb-files it will preprocess these files: /home/mortenbp/code/sml/mylib/class/Func.preml.sig /home/mortenbp/code/sml/mylib/class/Idiom.preml.sig /home/mortenbp/code/sml/mylib/class/Idiom.preml.fun /home/mortenbp/code/sml/mylib/class/Monad.preml.sig /home/mortenbp/code/sml/mylib/class/Monad.preml.fun /home/mortenbp/code/sml/mylib/class/Alt.preml.sig /home/mortenbp/code/sml/mylib/class/Alt.preml.fun /home/mortenbp/code/sml/mylib/class/MonadP.preml.sig /home/mortenbp/code/sml/mylib/class/MonadP.preml.fun /home/mortenbp/code/sml/mylib/class/Foldable.preml.sig /home/mortenbp/code/sml/mylib/class/Enumerable.preml.sig /home/mortenbp/code/sml/mylib/class/Enumerable.preml.fun /home/mortenbp/code/sml/mylib/class/Unfoldable.preml.sig /home/mortenbp/code/sml/mylib/class/Unfoldable.preml.fun /home/mortenbp/code/sml/mylib/class/MonoMonad.preml.sig /home/mortenbp/code/sml/mylib/class/MonoMonad.preml.fun /home/mortenbp/code/sml/mylib/class/MonoMonadP.preml.sig /home/mortenbp/code/sml/mylib/class/MonoMonadP.preml.fun /home/mortenbp/code/sml/mylib/class/MonoFoldable.preml.sig /home/mortenbp/code/sml/mylib/class/MonoEnumerable.preml.sig /home/mortenbp/code/sml/mylib/class/MonoEnumerable.preml.fun /home/mortenbp/code/sml/mylib/class/MonoUnfoldable.preml.sig /home/mortenbp/code/sml/mylib/class/MonoUnfoldable.preml.fun /home/mortenbp/code/sml/mylib/class/Ordered.preml.sig /home/mortenbp/code/sml/mylib/class/Ordered.preml.fun /home/mortenbp/code/sml/mylib/class/PolyOrdered.preml.sig /home/mortenbp/code/sml/mylib/class/PolyOrdered.preml.fun /home/mortenbp/code/sml/mylib/class/Range.preml.sig /home/mortenbp/code/sml/mylib/class/Range.preml.fun /home/mortenbp/code/sml/mylib/class/Pickler.preml.sig /home/mortenbp/code/sml/mylib/class/Unpickler.preml.sig /home/mortenbp/code/sml/mylib/data/Option.preml.sml /home/mortenbp/code/sml/mylib/data/Unit.preml.sml /home/mortenbp/code/sml/mylib/data/Bool.preml.sml /home/mortenbp/code/sml/mylib/data/Order.preml.sml /home/mortenbp/code/sml/mylib/class/Set.preml.sig /home/mortenbp/code/sml/mylib/class/Set.preml.fun /home/mortenbp/code/sml/mylib/class/Map.preml.sig /home/mortenbp/code/sml/mylib/class/Sequence.preml.sig /home/mortenbp/code/sml/mylib/control/Identity.preml.sml /home/mortenbp/code/sml/mylib/control/StateT.preml.fun /home/mortenbp/code/sml/mylib/control/StateTP.preml.fun /home/mortenbp/code/sml/mylib/control/ErrorT.preml.fun /home/mortenbp/code/sml/mylib/io/Reader.preml.sml /home/mortenbp/code/sml/mylib/data/Int.preml.sml 

*)
local structure Util =
struct
fun genFoldr foldl f b xs =
    foldl (fn (x, k) => fn b => k (f (x, b))) (fn b => b) xs b

fun die s =
    (print ("An unexpected error occured in MyLib.\n\
            \Please email me at mortenbp@gmail.com.\n\
            \\n\
            \Error message:\n\
            \" ^ s
           )
   ; OS.Process.exit OS.Process.failure
    )
end
 structure Iso = struct type ('a, 'b) t = ('a -> 'b) * ('b -> 'a) end
structure Emb = struct type ('a, 'b) t = ('a -> 'b) * ('b -> 'a option) end
structure Fn = struct type ('a, 'b) t = 'a -> 'b end
structure BinFn = struct type ('a, 'b) t = 'a * 'a -> 'b end
structure Effect = struct type 'a t = 'a -> unit end
structure Thunk = struct type 'a t = unit -> 'a end
structure Cmp = struct type 'a t = 'a * 'a -> order end
structure UnOp = struct type 'a t = 'a -> 'a end
structure BinOp = struct type 'a t = 'a * 'a -> 'a end
structure UnPred = struct type 'a t = 'a -> bool end
structure BinPred = struct type 'a t = 'a * 'a -> bool end
structure Fix = struct type 'a t = 'a UnOp.t -> 'a end
structure Cont = struct type ('a, 'b) t = ('a -> 'b) -> 'b end
structure ViewL = struct datatype ('a, 'b) t = nill | <:: of 'a * 'b end
structure ViewR = struct datatype ('a, 'b) t = nilr | ::> of 'b * 'a end
structure Either = struct datatype ('a, 'b) t = Left of 'a | Right of 'b end
structure Product = struct datatype ('a, 'b) t = & of 'a * 'b end
structure Reader = struct type ('a, 'x) t = 'x -> ('a * 'x) option end
structure Writer = struct type ('a, 'x) t = 'a * 'x -> 'x end
structure Scanner = struct type ('a, 'b, 'x) t =
                                ('a, 'x) Reader.t -> ('b, 'x) Reader.t
                    end
structure Packer = struct type ('a, 'b, 'x) t =
                               ('a, 'x) Writer.t -> ('b, 'x) Writer.t
                   end

structure Exn = struct type t = exn end
structure Unit = struct type t = unit end
structure Bool = struct open Bool datatype t = datatype bool end
structure Array = struct open Array type 'a t = 'a array end
(* structure ArraySlice = struct open ArraySlice type 'a t = 'a slice end *)
structure Char = struct open Char type t = char end
structure CharArray = struct open CharArray type t = array end
(* structure CharArraySlice = struct open CharArraySlice type t = slice end *)
structure CharVector = struct open CharVector type t = vector end
(* structure CharVectorSlice = struct open CharVectorSlice type t = slice end *)
structure FixedInt = struct open FixedInt type t = int end
structure Int = struct open Int type t = int end
structure Real = struct open Real type t = real end
structure LargeInt = struct open LargeInt type t = int end
structure LargeReal = struct open LargeReal type t = real end
structure LargeWord = struct open LargeWord type t = word end
structure List = struct open List type 'a t = 'a list end
structure Option = struct open Option type 'a t = 'a option end
structure Order = struct datatype t = datatype order end
structure Substring = struct open Substring type t = substring end
structure Vector = struct open Vector type 'a t = 'a vector end
structure VectorSlice = struct open VectorSlice type 'a t = 'a slice end
structure Word = struct open Word type t = word end
structure Word8 = struct open Word8 type t = word end
structure Word8Array = struct open Word8Array type t = array end
structure Word8ArraySlice = struct open Word8ArraySlice type t = slice end
structure Word8Vector = struct open Word8Vector type t = vector end
structure Word8VectorSlice = struct open Word8VectorSlice type t = slice end
structure Ref = struct type 'a t = 'a ref end
structure Time = struct open Time type t = time end
 structure Lazy =
struct
datatype 'a t_ = T of unit -> 'a t
               | V of 'a
               | E of exn
withtype 'a t = 'a t_ ref

fun delay t = ref (T t)
fun eager v = ref (V v)
fun force p =
    case !p of
      V v => v
    | E e => raise e
    | T t =>
      let
        val p' = t ()
      in
        p := !p'
      ; force p
      end
      handle e => (p := E e ; raise e)
fun lazy t = delay
                (fn _ =>
                    ref (V (t ()) handle e => E e)
                )

fun thunk p () = force p
fun memoise t = thunk (lazy t)
end
 (*   Sequences based on 2-3 finger trees
 *
 * In [Hinze & Paterson, 2006] it is suggested that performance is improved by
 * using a specialised digit datatype alá
 *   datatype 'a digit =
 *            One of 'a
 *          | Two of 'a * 'a
 *          | Three of 'a * 'a * 'a
 *          | Four of 'a * 'a * 'a * 'a
 *
 * However this seems not to be the case (using MLTon at least). On top of that
 * the implementation is much more complicated. For those reasons this
 * implementation models digits (and tree nodes) using lists.
 *
 * The implementation suggested by [Hinze & Paterson, 2006] can be found in
 * SeqHinzePaterson.sml. The append function is generated by GenSeqApp.sml.
 *
 *
 * [Hinze & Paterson, 2006]
 *   Ralf Hinze and Ross Paterson,
 *   "Finger trees: a simple general-purpose data structure"
 *   Journal of Functional Programming 16:2 (2006) pp 197-217
 *   http://www.soi.city.ac.uk/~ross/papers/FingerTree.html
 *)

structure Seq =
struct val die = Util.die
infix <| |> ><
datatype 'a t =
         E
       | S of 'a tree
       | D of int * 'a tree digit * 'a t * 'a tree digit
     and 'a tree =
         N of 'a
       | B of int * 'a tree list
withtype 'a digit = 'a list

val empty = E
fun genEmpty () = E

fun null E = true
  | null _ = false

fun singleton x = S (N x)

fun length' t =
    case t of
      N _ => 1
    | B (s, _) => s

fun length'' ts = List.foldl (fn (t, s) => length' t + s) 0 ts

fun length xs =
    case xs of
      E => 0
    | S t => length' t
    | D (s, _, _, _) => s

fun branch ts =
    case ts of
      [t1, t2] => B (length' t1 + length' t2, ts)
    | [t1, t2, t3] => B (length' t1 + length' t2 + length' t3, ts)
    | _ => die "Seq.branch: not 2 or 3 subtrees"
fun unbranch t =
    case t of
      B (_, ts) => ts
    | _ => die "Seq.unbranch: node"

fun cons' (x, xs) =
    case xs of
      E => S x
    | S y => D (length' x + length' y, [x], E, [y])
    | D (s, a :: (pr as [_, _, _]), m, sf) =>
      D (s + length' x, [x, a], cons' (branch pr, m), sf)
    | D (s, pr, m, sf) =>
      D (s + length' x, x :: pr, m, sf)

fun snoc' (x, xs) =
    case xs of
      E => S x
    | S y => D (length' x + length' y, [y], E, [x])
    | D (s, pr, m, d :: (sf as [_, _, _])) =>
      D (s + length' x, pr, snoc' (branch sf, m), [x, d])
    | D (s, pr, m, sf) =>
      D (s + length' x, pr, m, x :: sf)

fun x <| xs = cons' (N x, xs)
fun xs |> x = snoc' (N x, xs)

fun getl' xs =
    case xs of
      E => NONE
    | S x => SOME (x, E)
    | D (s, pr, m, sf) =>
      case pr of
        [x] =>
        SOME
          (x,
           case getl' m of
             NONE =>
             (case sf of
                [y] => S y
              | y :: ys => D (s - length' x, rev ys, E, [y])
              | _ => die "Seq.viewl': empty suffix"
             )
           | SOME (t, m) => D (s - length' x, unbranch t, m, sf)
          )
      | x :: pr =>
        SOME (x, D (s - length' x, pr, m, sf))
      | _ => die "Seq.viewl': empty prefix"

fun getr' xs =
    case xs of
      E => NONE
    | S x => SOME (x, E)
    | D (s, pr, m, sf) =>
      case sf of
        [x] =>
        SOME
          (x,
           case getr' m of
             NONE =>
             (case pr of
                [y] => S y
              | y :: ys => D (s - length' x, [y], E, rev ys)
              | _ => die "Seq.viewr': got empty prefix"
             )
           | SOME (t, m) => D (s - length' x, pr, m, unbranch t)
          )
      | x :: sf =>
        SOME (x, D (s - length' x, pr, m, sf))
      | _ => die "Seq.viewr': got empty suffix"

fun getl xs =
    case getl' xs of
      NONE => NONE
    | SOME (N x, xs) => SOME (x, xs)
    | _ => die "Seq.viewl: got a branch"

fun getr xs =
    case getr' xs of
      NONE => NONE
    | SOME (N x, xs) => SOME (x, xs)
    | _ => die "Seq.viewr: got a branch"

fun swapdir s n = s - n - 1

fun split'' n ts =
    case ts of
      t :: ts =>
      let
        val s = length' t
      in
        if s <= n then
          let
            val (ts, t', us) = split'' (n - s) ts
          in
            (t :: ts, t', us)
          end
        else
          (nil, t, ts)
      end
    | _ => die "Seq.split''"

fun liftl ts =
    case ts of
      nil => E
    | [t] => S t
    | t :: ts' => D (length'' ts, [t], E, rev ts')

and liftr ts =
    case ts of
      nil => E
    | [t] => S t
    | t :: ts' => D (length'' ts, rev ts', E, [t])

and deepl pr m sf =
    case pr of
      nil =>
      (case getl' m of
         NONE =>
         liftr sf
       | SOME (t, m) =>
         D (length' t + length m + length'' sf, unbranch t, m, sf)
      )
    | _ =>
      D (length'' pr + length m + length'' sf, pr, m, sf)

and deepr pr m sf =
    case sf of
      nil =>
      (case getr' m of
         NONE =>
         liftl pr
       | SOME (t, m) =>
         D (length'' pr + length m + length' t, pr, m, unbranch t)
      )
    | _ =>
      D (length'' pr + length m + length'' sf, pr, m, sf)

fun digest n (d as (s, pr, m, sf)) dpr dm dsf =
    if n < s div 2 then
      let
        val lpr = length'' pr
      in
        if n < lpr then
          dpr (n, d)
        else
          let
            val lm = length m
            val n' = n - lpr
          in
            if n' < lm then
              dm (n', d)
            else
              dsf (swapdir s n, d)
          end
      end
    else
      let
        val n' = swapdir s n
        val lsf = length'' sf
      in
        if n' < lsf then
          dsf (n', d)
        else
          let
            val lm = length m
            val n' = swapdir lm (n' - lsf)
          in
            if n' >= 0 then
              dm (n', d)
            else
              dpr (n, d)
          end
      end

fun guardIndex n xs =
    if n < 0 orelse n >= length xs then
      raise Subscript
    else
      ()

fun split n xs =
    case xs of
      E => raise Subscript
    | S x => (E, x, E)
    | D d =>
      digest n d
             (fn (n, (_, pr, m, sf)) =>
                 let
                   val (l, x, r) = split'' n pr
                 in
                   (liftl l, x, deepl r m sf)
                 end)
             (fn (n, (_, pr, m, sf)) =>
                 let
                   val (ml, xs, mr) = split n m
                   val (l, x, r) = split'' (n - length ml) (unbranch xs)
                 in
                   (deepr pr ml l, x, deepl r mr sf)
                 end)
             (fn (n, (_, pr, m, sf)) =>
                 let
                   val (r, x, l) = split'' n sf
                 in
                   (deepr pr m l, x, liftr r)
                 end)

fun splitAt n xs =
    (guardIndex n xs
   ; case split n xs of
       (l, N x, r) => (l, x, r)
     | _ => die "Seq.splitAt: branch"
    )

fun ad'' ad' f n ts =
    case ts of
      t :: ts =>
      let
        val s = length' t
      in
        if s <= n then
          t :: ad'' ad' f (n - s) ts
        else
          ad' f n t :: ts
      end
    | _ => die "Seq.ad'': n > s"

fun adl' f n t =
    case t of
      N x => N (f x)
    | B (s, ts) => B (s, ad'' adl' f n ts)

fun adr' f n t =
    adl' f (swapdir (length' t) n) t

fun ad f n xs =
    case xs of
      E => raise Subscript
    | S t => S (adl' f n t)
    | D d =>
      digest n d
             (fn (n, (s, pr, m, sf)) =>
                 D (s, ad'' adl' f n pr, m, sf)
             )
             (fn (n, (s, pr, m, sf)) =>
                 D (s, pr, ad f n m, sf)
             )
             (fn (n, (s, pr, m, sf)) =>
                 D (s, pr, m, ad'' adr' f n sf)
             )

fun adjust f n xs =
    (guardIndex n xs ; ad f n xs)

and ind'' ind' n ts =
    case ts of
      t :: ts =>
      let
        val s = length' t
      in
        if s <= n then
          ind'' ind' (n - s) ts
        else
          ind' n t
      end
    | _ => die "Seq.ind'': n > s"

fun indl' n t =
    case t of
      N x => x
    | B (s, ts) => ind'' indl' n ts

fun indr' n t =
    indl' (swapdir (length' t) n) t

fun indl n xs =
    case xs of
      E => raise Subscript
    | S t => indl' n t
    | D d =>
      digest n d
             (fn (n, (_, pr, _, _)) =>
                 ind'' indl' n pr
             )
             (fn (n, (_, _, m, _)) =>
                 indl n m
             )
             (fn (n, (_, _, _, sf)) =>
                 ind'' indr' n sf
             )

fun index n xs =
    (guardIndex n xs ; indl n xs)

fun foldl'many f b ts = List.foldl (fn (t, b) => foldl' f b t) b ts
and foldl' f b t =
    case t of
      N x => f (x, b)
    | B (_, ts) => foldl'many f b ts
fun foldl f b xs =
    case xs of
      E => b
    | S t => foldl' f b t
    | D (_, pr, m, sf) =>
      foldl'many f (foldl f (foldl'many f b pr) m) sf

fun foldr'many f b ts = List.foldr (fn (t, b) => foldr' f b t) b ts
and foldr' f b t =
    case t of
      N x => f (x, b)
    | B (_, ts) => foldr'many f b ts
fun foldr f b xs =
    case xs of
      E => b
    | S t => foldr' f b t
    | D (_, pr, m, sf) =>
      foldl'many f (foldr f (foldl'many f b sf) m) pr

fun map' f t =
    case t of
      N x => N (f x)
    | B (s, ts) => B (s, List.map (map' f) ts)
fun map f xs =
    case xs of
      E => E
    | S t => S (map' f t)
    | D (s, pr, m, sf) =>
      D (s, List.map (map' f) pr, map f m, List.map (map' f) sf)

fun app (xs, ts, ys) =
    let
      fun cons'many (ts, xs) = List.foldr cons' xs ts
      fun snoc'many (ts, xs) = List.foldl snoc' xs ts
      fun node xs =
          case xs of
            nil => nil
          | [a, b] => [branch [a, b]]
          | [a, b, c, d] => [branch [a, b], branch [c, d]]
          | a :: b :: c :: xs => branch [a, b, c] :: node xs
          | _ => die "Seq.app.node: got singleton list"
    in
      case (xs, ys) of
        (E, _) => cons'many (ts, ys)
      | (_, E) => snoc'many (ts, xs)
      | (S x, _) => cons' (x, cons'many (ts, ys))
      | (_, S y) => snoc' (y, snoc'many (ts, xs))
      | (D (sl, prl, ml, sfl), D (sr, prr, mr, sfr)) =>
        D (sl + length'' ts + sr, prl, app (ml, node (sfl @ ts @ prr), mr), sfr)
    end

fun xs >< ys = app (xs, nil, ys)

fun rev' t =
    case t of
      N _ => t
    | B (s, ts) => B (s, rev'' ts)
and rev'' ts = List.rev (List.map rev' ts)

fun rev xs =
    case xs of
      E => xs
    | S _ => xs
    | D (s, pr, m, sf) => D (s, rev'' pr, rev m, rev'' sf)
end
 structure Stream =
struct
infix <|

val F = Lazy.force
val E = Lazy.eager

datatype 'a t' = Cons of 'a * 'a t
               | Nil
withtype 'a t = 'a t' Lazy.t

fun genEmpty () = E Nil

fun x <| xs = E (Cons (x, xs))

fun viewl xs =
    case F xs of
      Cons x => ViewL.<:: x
    | Nil    => ViewL.nill

fun getl xs =
    case F xs of
      Cons (x, xs) => SOME (x, xs)
    | Nil          => NONE
end
 structure String =
struct
open String
type t = string

fun foldl f b s =
    let
      val l = size s
      fun loop n b =
          if Int.>= (n, l)
          then b
          else loop (n + 1) (f (String.sub(s, n), b))
    in
      loop 0 b
    end

fun foldr f b s =
    let
      fun loop ~1 b = b
        | loop n b = loop (n - 1) (f (String.sub(s, n), b))
    in
      loop (size s - 1) b
    end
end
 in signature Fn =
sig
  type ('a, 'b) t = 'a -> 'b

  val curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
  val uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c
  val curry3 : ('a * 'b * 'c -> 'd) -> 'a -> 'b -> 'c -> 'd
  val uncurry3 : ('a -> 'b -> 'c -> 'd) -> 'a * 'b * 'c -> 'd
  val curry4 : ('a * 'b * 'c * 'd -> 'e) -> 'a -> 'b -> 'c -> 'd -> 'e
  val uncurry4 : ('a -> 'b -> 'c -> 'd -> 'e) -> 'a * 'b * 'c * 'd-> 'e

  val lift : ('c -> 'a) * ('b -> 'd) -> ('a -> 'b) -> 'c -> 'd
  val const : 'a -> ('b, 'a) t
  val eta : ('a -> 'b -> 'c) -> 'a -> 'b -> 'c
  val fix : ('a -> 'b) Fix.t
  val repeat : Int.t -> ('a -> 'a) -> 'a -> 'a
  val flip : ('a * 'b -> 'c) -> 'b * 'a -> 'c
  val flipc : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c
  val id : 'a -> 'a
  val seal : ('a -> 'b) -> 'a -> 'b Thunk.t
  val first : ('a -> 'b) -> 'a * 'c -> 'b * 'c
  val second : ('a -> 'b) -> 'c * 'a -> 'c * 'b
  val o : ('b -> 'c) * ('a -> 'b) -> 'a -> 'c
  val <\ : 'a * ('a * 'b -> 'c) -> 'b -> 'c
  val \> : ('a -> 'b) * 'a -> 'b
  val </ : 'a * ('a -> 'b) -> 'b
  val /> : ('a * 'b -> 'c) * 'b -> 'a -> 'c
  val $ : ('a -> 'b) * 'a -> 'b
  val >- : 'a * ('a -> 'b) -> 'b
end
                                    (**) structure Fn :> Fn =
struct
type ('a, 'b) t = 'a -> 'b

fun curry f a b = f (a, b)
fun uncurry f (a, b) = f a b
fun curry3 f a b c = f (a, b, c)
fun uncurry3 f (a, b, c) = f a b c
fun curry4 f a b c d = f (a, b, c, d)
fun uncurry4 f (a, b, c, d) = f a b c d

fun lift (c2a, b2d) f = b2d o f o c2a
fun const x _ = x
fun eta f x y = f x y
fun fix f x = f (fix f) x
fun repeat n f x =
    if n < 0
    then raise Domain
    else fix
           (fn loop =>
            fn (0, x) => x
             | (n, x) => loop (n - 1, f x)
           )
           (n, x)
fun flipc f x y = f y x
fun flip f (x, y) = f (y, x)
fun id x = x
fun seal f x () = f x
fun first a (x, y) = (a x, y)
fun second a (x, y) = (x, a y)
val op o = op o
fun op <\ (x, f) y = f (x, y)
fun op \> (f, y) = f y
fun op /> (f, y) x = f (x, y)
fun op </ (x, f) = f x
val op $ = op \>
val op >- = op </
end
 signature BinFn =
sig
  type ('a, 'b) t = 'a * 'a -> 'b

  val lift : ('c -> 'a) * ('b -> 'd) -> ('a, 'b) t -> ('c, 'd) t
end
                                    (**) structure BinFn =
struct
type ('a, 'b) t = 'a * 'a -> 'b

fun lift (c2a, b2d) f (x, y) = b2d (f (c2a x, c2a y))
end
 signature Effect =
sig
type 'a t = 'a -> Unit.t

val ignore : 'a t -> 'b t
val attach : 'a t -> 'a -> 'a

val tabulate : (Int.t * Int.t t) t

val lift : ('a -> 'b) -> 'b t -> 'a t
val iso : ('a, 'b) Iso.t -> ('a t, 'b t) Iso.t
end
                                    (**) structure Effect :> Effect =
struct
type 'a t = 'a -> Unit.t

fun ignore _ _ = ()
fun attach ef x = (ef x ; x)

fun tabulate (n, ef) =
    ( Fn.repeat n (fn i => (ef i ; i + 1)) 0
    ; ()
    )

fun lift f ef = ef o f
fun iso (a2b, b2a) = (lift b2a, lift a2b)
end
 signature Thunk =
sig
  type 'a t = Unit.t -> 'a
  val force : 'a t -> 'a
  val eager : 'a -> 'a t
  val delay : 'a t t -> 'a t
  val lift : ('a -> 'b) -> 'a t -> 'b t
  val iso : ('a, 'b) Iso.t -> ('a t, 'b t) Iso.t
end
                                    (**) structure Thunk :> Thunk =
struct
type 'a t = Unit.t -> 'a

fun force th = th ()

fun eager x () = x

fun delay th () = force (th ())

fun lift f th = f o th

fun iso (a2b, b2a) = (lift a2b, lift b2a)
end
 signature Cont =
sig
  type ('a, 'r) t = ('a -> 'r) -> 'r

  val return : 'a -> ('a, 'r) t
  val >>= : ('a, 'r) t * ('a -> ('b, 'r) t) -> ('b, 'r) t

  val callCC : ('a -> 'r, ('a, 'r) t) t
  val throw : ('a -> 'r) -> 'a -> ('b, 'r) t
end
                                    (**) structure Cont :> Cont =
struct
type ('a, 'r) t = ('a -> 'r) -> 'r

fun return x c = c x
fun op >>= (m, k) c = m (fn a => k a c)

fun callCC f c = f c c
fun throw c a _ = c a
end
 signature Cmp =
sig
  type 'a t = 'a * 'a -> Order.t

  val map : ('b -> 'a) -> 'a t -> 'b t
end
                                    (**) structure Cmp =
struct
type 'a t = 'a * 'a -> Order.t
fun map f c (x, y) = c (f x, f y)
end
 signature UnOp =
sig
  type 'a t = 'a -> 'a

  val lift : ('a, 'b) Iso.t -> 'b t -> 'a t
end
                                    (**) structure UnOp =
struct
type 'a t = 'a -> 'a

fun lift (a2b, b2a) f = b2a o f o a2b
end
 signature BinOp =
sig
  type 'a t = 'a * 'a -> 'a

  val lift : ('a, 'b) Iso.t -> 'b t -> 'a t
end
                                    (**) structure BinOp =
struct
type 'a t = 'a * 'a -> 'a

val lift = BinFn.lift
end
 signature UnPred =
sig
  type 'a t = 'a -> Bool.t

  val lift : ('a -> 'b) -> 'b t -> 'a t
  val andAlso : 'a t BinOp.t
  val orElse : 'a t BinOp.t
  val neg : 'a t UnOp.t
end
                                    (**) structure UnPred :> UnPred =
struct
type 'a t = 'a -> Bool.t

fun lift f p = p o f
fun neg p = not o p
fun andAlso (p, q) x = p x andalso q x
fun orElse (p, q) x = p x orelse q x
end
 signature BinPred =
sig
  type 'a t = 'a * 'a -> Bool.t

  val lift : ('a -> 'b) -> 'b t -> 'a t
end
                                    (**) structure BinPred :> BinPred =
struct
type 'a t = 'a * 'a -> Bool.t

fun lift a2b f (x, y) = f (a2b x, a2b y)
end
 signature Fix =
sig
  type 'a t = ('a -> 'a) -> 'a
end
                                    (**) structure Fix :> Fix =
struct
  type 'a t = ('a -> 'a) -> 'a
end
 signature Func = sig
  type 'a t val map : ('a -> 'b) -> 'a t -> 'b t
 
end

signature FuncEX = sig
  include Func val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
 end                                      (**) functor Func (F : Func) : FuncEX =
struct
open F infix $$ $|
fun app f a = (map (fn x => (f x ; ())) a ; ())
fun a $$ b = map a b
fun x $| a = (fn _ => x) $$ a
end
 signature Idiom = sig
  type 'a t val pure : 'a -> 'a t
val ** : ('a -> 'b) t * 'a t -> 'b t
 end

signature IdiomEX = sig
  include Idiom val >> : 'a t * 'b t -> 'b t
val << : 'a t * 'b t -> 'a t
val -- : 'a t * 'b t -> ('a * 'b) t
val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
val map3 : ('a -> 'b -> 'c -> 'r) ->
            'a t -> 'b t -> 'c t -> 'r t
val map4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
            'a t -> 'b t -> 'c t -> 'd t -> 'r t
val mergerBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val mergelBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val cartesian : 'a t -> 'b t -> ('a * 'b) t
 val map : ('a -> 'b) -> 'a t -> 'b t
 val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
 end                                      (**) functor Idiom (I : Idiom) : IdiomEX =
struct
open Fn infixr $
open I infix $$ ** >> << -- local structure PreML__TMP__nETNHomCTy = 
     Func(
type 'a t = 'a t
fun map f a = pure f ** a
) in open PreML__TMP__nETNHomCTy end 

fun a >> b = (fn _ => fn y => y) $$ a ** b
fun a << b = (fn x => fn _ => x) $$ a ** b
fun map2 f a b = f $$ a ** b
fun map3 f a b c = f $$ a ** b ** c
fun map4 f a b c d = f $$ a ** b ** c ** d
fun a -- b = curry id $$ a ** b
fun cartesian a b = a -- b

fun mergerBy f xs =
    case xs of
      nil    => NONE
    | x ::xs => SOME $ List.foldr (fn (x, a) => curry f $$ x ** a) x xs
fun mergelBy f xs =
    case xs of
      nil    => NONE
    | x ::xs => SOME $ List.foldl (fn (x, a) => curry f $$ x ** a) x xs
end signature Monad = sig
  type 'a t val return : 'a -> 'a t
val >>= : 'a t * ('a -> 'b t) -> 'b t
 end

signature MonadEX =
sig
  include Monad val fail : String.t -> 'a t
val join : 'a t t -> 'a t
val mapM : ('a -> 'b t) -> 'a List.t -> 'b List.t t
val mapMPartial : ('a -> 'b Option.t t) -> 'a List.t -> 'b List.t t
val mapM' : ('a -> 'b t) -> 'a List.t -> Unit.t t
val seq : 'a t List.t -> 'a List.t t
val seq' : 'a t List.t -> Unit.t t
val =<< : ('a -> 'b t) * 'a t -> 'b t
val >=> : ('a -> 'b t) * ('b -> 'c t) -> 'a -> 'c t
val <=< : ('b -> 'c t) * ('a -> 'b t) -> 'a -> 'c t
val forever : 'a t -> 'b t
val foreverWithDelay : Int.t -> 'a t -> 'b t
val ignore : 'a t -> Unit.t t
val keepM : ('a -> Bool.t t) -> 'a List.t -> 'a List.t t
val rejectM : ('a -> Bool.t t) -> 'a List.t -> 'a List.t t
val mapAndUnzipM : ('a -> ('b * 'c) t) -> 'a List.t ->
                   ('b List.t * 'c List.t) t
val zipWithM : ('a * 'b -> 'c t) -> 'a List.t * 'b List.t -> 'c List.t t
val zipWithM' : ('a * 'b -> 'c t) -> 'a List.t * 'b List.t -> Unit.t t
val foldlM : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> 'b t
val foldlM' : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> Unit.t t
val foldrM : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> 'b t
val foldrM' : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> Unit.t t
val tabulateM : Int.t -> (Int.t -> 'a t) -> 'a List.t t
val tabulateM' : Int.t -> (Int.t -> 'a t) -> Unit.t t
val when : Bool.t -> Unit.t t -> Unit.t t
val unless : Bool.t -> Unit.t t -> Unit.t t
 val map : ('a -> 'b) -> 'a t -> 'b t
 val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
 val pure : 'a -> 'a t
val ** : ('a -> 'b) t * 'a t -> 'b t
 val >> : 'a t * 'b t -> 'b t
val << : 'a t * 'b t -> 'a t
val -- : 'a t * 'b t -> ('a * 'b) t
val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
val map3 : ('a -> 'b -> 'c -> 'r) ->
            'a t -> 'b t -> 'c t -> 'r t
val map4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
            'a t -> 'b t -> 'c t -> 'd t -> 'r t
val mergerBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val mergelBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val cartesian : 'a t -> 'b t -> ('a * 'b) t
 end                                      (**) functor Monad (M : Monad) : MonadEX = struct local structure PreML__TMP__MDSUVsHFaf = struct 

open Fn infixr $
open M infix >>= =<< >=> <=< ** >>

(* Idiom interface *)
val pure = return
fun a ** b = let infix 0 >>= in ( 
            a ) >>= (fn  f => ( 
            b ) >>= (fn  x => 
       return $ f x ) ) end 


fun a >> b = a >>= (fn _ => b)

fun fail e = return () >>= (fn _ => raise Fail e)

fun join x = x >>= id

fun seq ms =
    List.foldr
      (fn (m, m') => let infix 0 >>= in ( 
                  m ) >>= (fn  x => ( 
                   m' ) >>= (fn  xs => 
             return $ x :: xs ) ) end 

      )
      (return nil)
      ms

fun seq' ms = List.foldr op>> (return ()) ms

fun mapM f xs = seq $ List.map f xs

fun mapMPartial f xs =
    List.foldr
      (fn (x, m') => let infix 0 >>= in ( 
                   f x ) >>= (fn  mx => 
             case mx of
               NONE   => m'
             | SOME x => let infix 0 >>= in ( 
                        m' ) >>= (fn  xs => 
                  return $ x :: xs ) end ) end 


      )
      (return nil)
      xs

fun mapM' f xs = seq' $ List.map f xs

fun keepM p xs =
    case xs of
      nil     => return nil
    | x :: xs => let infix 0 >>= in ( 
               p x ) >>= (fn  px => ( 
               keepM p xs ) >>= (fn  ys => 
         return (if px then x :: ys else ys) ) ) end 


fun rejectM p xs = keepM (fn x => p x >>= return o not) xs

fun m =<< n = n >>= m

fun (f >=> g) x = f x >>= g

fun (f <=< g) x = g x >>= f

fun forever m = m >>= (fn _ => forever m)

fun foreverWithDelay d m =
    let
      fun sleep () = OS.Process.sleep $
                     Time.fromMilliseconds $
                     LargeInt.fromInt d
      fun loop m = m >>= (fn _ => (sleep () ; loop m))
    in
      loop m
    end

fun ignore m = m >> return ()

fun mapAndUnzipM f xs =
    seq (List.map f xs) >>= (return o ListPair.unzip)

fun zipWithM f ls =
    seq $ List.map f $ ListPair.zip ls

fun zipWithM' f ls =
    seq' $ List.map f $ ListPair.zip ls

fun foldlM _ b nil = return b
  | foldlM f b (x :: xs) = let infix 0 >>= in ( f (x, b) ) >>= (fn  b' => foldlM f b' xs ) end 

fun foldlM' f b xs = ignore $ foldlM f b xs

fun foldrM f b = foldlM f b o rev

fun foldrM' f b = foldlM' f b o rev

fun tabulateM n m =
    seq $ List.tabulate (n, m)

fun tabulateM' n m =
    seq' $ List.tabulate (n, m)

fun when p m = if p then m else return ()

fun unless p m = if p then return () else m end local structure PreML__TMP__ziiXUvquMm = Idiom ( open PreML__TMP__MDSUVsHFaf ) structure PreML__TMP__erxyEfjgrR = Func ( open PreML__TMP__ziiXUvquMm PreML__TMP__MDSUVsHFaf ) in structure PreML__TMP__MDSUVsHFaf = struct open PreML__TMP__ziiXUvquMm PreML__TMP__erxyEfjgrR PreML__TMP__MDSUVsHFaf end end in open PreML__TMP__MDSUVsHFaf end end signature Alt = sig
  type 'a t val pure : 'a -> 'a t
val ** : ('a -> 'b) t * 'a t -> 'b t
 val || : 'a t BinOp.t
val genZero : 'a t Thunk.t
 end

signature AltEX = sig
  include Alt val plus : 'a t -> 'a t -> 'a t
val optional : 'a t -> 'a Option.t t
val merger : 'a t List.t -> 'a t
val mergel : 'a t List.t -> 'a t
val guard : Bool.t -> Unit.t t
 val map : ('a -> 'b) -> 'a t -> 'b t
 val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
 val >> : 'a t * 'b t -> 'b t
val << : 'a t * 'b t -> 'a t
val -- : 'a t * 'b t -> ('a * 'b) t
val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
val map3 : ('a -> 'b -> 'c -> 'r) ->
            'a t -> 'b t -> 'c t -> 'r t
val map4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
            'a t -> 'b t -> 'c t -> 'd t -> 'r t
val mergerBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val mergelBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val cartesian : 'a t -> 'b t -> ('a * 'b) t
 end                                      (**) functor Alt (A : Alt) : AltEX = struct local structure PreML__TMP__JOseeYnjzB = struct 

open A
infix || **

fun plus a b = a || b
fun optional xs = (pure SOME ** xs) || pure NONE
fun merger ms = List.foldr op|| (genZero ()) ms
fun mergel ms = List.foldl op|| (genZero ()) ms
fun guard true  = pure ()
  | guard false = genZero () end local structure PreML__TMP__qcFJaODyDM = Idiom ( open PreML__TMP__JOseeYnjzB ) structure PreML__TMP__jRIakawwVQ = Func ( open PreML__TMP__qcFJaODyDM PreML__TMP__JOseeYnjzB ) in structure PreML__TMP__JOseeYnjzB = struct open PreML__TMP__qcFJaODyDM PreML__TMP__jRIakawwVQ PreML__TMP__JOseeYnjzB end end in open PreML__TMP__JOseeYnjzB end end signature MonadP =
sig
  type 'a t val || : 'a t BinOp.t
val genZero : 'a t Thunk.t
 val return : 'a -> 'a t
val >>= : 'a t * ('a -> 'b t) -> 'b t
 end

signature MonadPEX =
sig
  include MonadP val mapPartial : ('a -> 'a Option.t) -> 'a t UnOp.t
val keep : 'a UnPred.t -> 'a t UnOp.t
val reject : 'a UnPred.t -> 'a t UnOp.t
 val fail : String.t -> 'a t
val join : 'a t t -> 'a t
val mapM : ('a -> 'b t) -> 'a List.t -> 'b List.t t
val mapMPartial : ('a -> 'b Option.t t) -> 'a List.t -> 'b List.t t
val mapM' : ('a -> 'b t) -> 'a List.t -> Unit.t t
val seq : 'a t List.t -> 'a List.t t
val seq' : 'a t List.t -> Unit.t t
val =<< : ('a -> 'b t) * 'a t -> 'b t
val >=> : ('a -> 'b t) * ('b -> 'c t) -> 'a -> 'c t
val <=< : ('b -> 'c t) * ('a -> 'b t) -> 'a -> 'c t
val forever : 'a t -> 'b t
val foreverWithDelay : Int.t -> 'a t -> 'b t
val ignore : 'a t -> Unit.t t
val keepM : ('a -> Bool.t t) -> 'a List.t -> 'a List.t t
val rejectM : ('a -> Bool.t t) -> 'a List.t -> 'a List.t t
val mapAndUnzipM : ('a -> ('b * 'c) t) -> 'a List.t ->
                   ('b List.t * 'c List.t) t
val zipWithM : ('a * 'b -> 'c t) -> 'a List.t * 'b List.t -> 'c List.t t
val zipWithM' : ('a * 'b -> 'c t) -> 'a List.t * 'b List.t -> Unit.t t
val foldlM : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> 'b t
val foldlM' : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> Unit.t t
val foldrM : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> 'b t
val foldrM' : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> Unit.t t
val tabulateM : Int.t -> (Int.t -> 'a t) -> 'a List.t t
val tabulateM' : Int.t -> (Int.t -> 'a t) -> Unit.t t
val when : Bool.t -> Unit.t t -> Unit.t t
val unless : Bool.t -> Unit.t t -> Unit.t t
 val plus : 'a t -> 'a t -> 'a t
val optional : 'a t -> 'a Option.t t
val merger : 'a t List.t -> 'a t
val mergel : 'a t List.t -> 'a t
val guard : Bool.t -> Unit.t t
 val map : ('a -> 'b) -> 'a t -> 'b t
 val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
 val pure : 'a -> 'a t
val ** : ('a -> 'b) t * 'a t -> 'b t
 val >> : 'a t * 'b t -> 'b t
val << : 'a t * 'b t -> 'a t
val -- : 'a t * 'b t -> ('a * 'b) t
val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
val map3 : ('a -> 'b -> 'c -> 'r) ->
            'a t -> 'b t -> 'c t -> 'r t
val map4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
            'a t -> 'b t -> 'c t -> 'd t -> 'r t
val mergerBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val mergelBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val cartesian : 'a t -> 'b t -> ('a * 'b) t
 end                                      (**) functor MonadP (MP : MonadP) : MonadPEX = struct local structure PreML__TMP__wKwbBEZycH = struct 

open MP

fun mapPartial f m = let infix 0 >>= in ( 
            m ) >>= (fn  x => 
       case f x of
         SOME y => return y
       | NONE   => genZero () ) end 


fun keep p m = let infix 0 >>= in ( 
            m ) >>= (fn  x => 
       if p x then return x else genZero () ) end 


fun reject p = keep (not o p) end local structure PreML__TMP__PGkVNbABWg = Monad ( open PreML__TMP__wKwbBEZycH ) structure PreML__TMP__bPkNXljkSp = Alt ( open PreML__TMP__PGkVNbABWg PreML__TMP__wKwbBEZycH ) in structure PreML__TMP__wKwbBEZycH = struct open PreML__TMP__PGkVNbABWg PreML__TMP__bPkNXljkSp PreML__TMP__wKwbBEZycH end end in open PreML__TMP__wKwbBEZycH end end signature Foldable = sig
  type 'a t val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
 end

signature FoldableEX = sig
  type 'a t (* Implemented using continuations:
 *   fun foldr f b xs = foldl (fn (x, k) => fn b => k (f (x, b))) id xs b
 * This is actually faster than the default implementation of List.foldr in
 * MLTon.
 *)

val foldr1 : 'a BinOp.t -> 'a t -> 'a Option.t
val foldl1 : 'a BinOp.t -> 'a t -> 'a Option.t
val foldrWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b
val foldlWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b
val appl : 'a Effect.t -> 'a t Effect.t
val appr : 'a Effect.t -> 'a t Effect.t
val applWhile : ('a -> Bool.t) -> 'a t Effect.t
val apprWhile : ('a -> Bool.t) -> 'a t Effect.t
val concatFoldable : 'a List.t t -> 'a List.t
val concatList : 'a t List.t -> 'a List.t
val conjoin : Bool.t t UnPred.t
val disjoin : Bool.t t UnPred.t
val any : 'a UnPred.t -> 'a t UnPred.t
val all : 'a UnPred.t -> 'a t UnPred.t
val find : 'a UnPred.t -> 'a t -> 'a Option.t
val findr : 'a UnPred.t -> 'a t -> 'a Option.t
val findl : 'a UnPred.t -> 'a t -> 'a Option.t
val member : ''a -> ''a t UnPred.t
val notMember : ''a -> ''a t UnPred.t
val maximumBy : 'a Cmp.t -> 'a t -> 'a Option.t
val minimumBy : 'a Cmp.t -> 'a t -> 'a Option.t
val intSum : Int.t t -> Int.t
val realSum : Real.t t -> Real.t
val intProduct : Int.t t -> Int.t
val realProduct : Real.t t -> Real.t
val leftmost  : 'a Option.t t -> 'a Option.t
val rightmost : 'a Option.t t -> 'a Option.t
val first : 'a t -> 'a
val last : 'a t -> 'a
 end                                      (**) functor Foldable (F : Foldable) :  FoldableEX =
struct
open Fn infixr $
open F

fun foldr f b xs = foldl (fn (x, k) => fn b => k $ f (x, b)) id xs b

local
  fun maybe f (x, yop) =
      SOME
        (case yop of
           SOME y => f (x, y)
         | NONE   => x
        )
in
fun foldr1 f xs =
    foldr (maybe f) NONE xs
fun foldl1 f xs =
    foldl (maybe f) NONE xs
end

local
  fun foldWhile fold f (b : 'b) xs =
      let
        exception Stop of 'b
      in
        fold
          (fn (x, b) =>
              let
                val (b, cont) = f (x, b)
              in
                if cont then
                  b
                else
                  raise Stop b
              end
          )
          b
          xs
          handle Stop b => b
      end
in
fun foldrWhile f = foldWhile foldr f
fun foldlWhile f = foldWhile foldl f
end

fun appr ef xs = foldr (fn (x, _) => ef x) () xs
fun appl ef xs = foldl (fn (x, _) => ef x) () xs
fun apprWhile ef xs = foldrWhile (fn (x, _) => ((), ef x)) () xs
fun applWhile ef xs = foldlWhile (fn (x, _) => ((), ef x)) () xs

fun rightmost xs =
    foldrWhile (fn (x, _) => (x, not (Option.isSome x))) NONE xs
fun leftmost xs =
    foldlWhile (fn (x, _) => (x, not (Option.isSome x))) NONE xs

fun toList xs = foldr op:: nil xs

fun concatFoldable xss = foldr op@ nil xss
fun concatList xss =
    List.foldr (fn (x, a) => toList x @ a) nil xss

fun conjoin xs =
    foldr (fn (x, a) => x andalso a) true xs

fun disjoin xs =
    foldr (fn (x, a) => x orelse a) false xs

fun all p xs =
    foldlWhile (fn (x, _) => if p x then (true, true) else (false, false))
               true xs
fun any p xs =
    foldlWhile (fn (x, _) => if p x then (true, false) else (false, true))
               false xs

fun maximumBy cmp xs =
    foldl1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => a
               | EQUAL   => a
               | GREATER => x
           )
           xs

fun minimumBy cmp xs =
    foldl1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => x
               | EQUAL   => x
               | GREATER => a
           )
           xs

fun findr p xs =
    foldrWhile (fn (x, _) => if p x then (SOME x, false) else (NONE, true))
               NONE xs

fun findl p xs =
    foldlWhile (fn (x, _) => if p x then (SOME x, false) else (NONE, true))
               NONE xs

val find = findl

fun member x xs =
    any (fn y => x = y) xs

fun notMember x xs = not $ member x xs

fun intSum xs = foldl op+ 0 xs

fun realSum xs = foldl op+ 0.0 xs

fun intProduct xs = foldl op* 1 xs

fun realProduct xs = foldl op* 1.0 xs

local
  fun getIt fold (xs : 'a t) =
      let
        exception GotIt of 'a
      in
        fold (fn (x, _) => raise GotIt x) (fn _ => raise Empty) xs ()
        handle GotIt x => x
      end
in
fun first xs = getIt foldl xs
fun last xs = getIt foldr xs
end
end
 signature Enumerable = sig
  type 'a t val read : ('a, 'a t) Reader.t
 
end

signature EnumerableEX = sig
  type 'a t val toList : 'a t -> 'a list
val toSeq : 'a t -> 'a Seq.t
val toVector : 'a t -> 'a vector
val toStream : 'a t -> 'a Stream.t
val packer : ('a, 'a t, 'x) Packer.t
val scan : ('a, 'b, 'a t) Scanner.t -> 'a t -> 'b Option.t
 end                                      (**) functor Enumerable (E : Enumerable) : EnumerableEX = struct
open E

fun packer write (s, empty) =
    case read s of
      SOME (x, a') => write (x, packer write (a', empty))
    | NONE         => empty

fun mk write empty s = packer write (s, empty)

fun toList xs = mk op:: nil xs
fun toSeq xs = mk Seq.<| (Seq.genEmpty ()) xs
fun toVector xs = Vector.fromList (toList xs)
fun toStream xs = mk Stream.<| (Stream.genEmpty ()) xs

fun scan scanner = Option.map (fn (a, _) => a) o scanner read
end

 signature Unfoldable = sig
  type 'a t val write : ('a, 'a t) Writer.t
val genEmpty : 'a t Thunk.t
 end

signature UnfoldableEX = sig
  type 'a t val fromList : 'a List.t -> 'a t
val fromSeq : 'a Seq.t -> 'a t
val fromVector : 'a Vector.t -> 'a t
val fromStream : 'a Stream.t -> 'a t
val scanner : ('a, 'a t, 'x) Scanner.t
val pack : ('a, 'b, 'a t) Packer.t -> 'b -> 'a t
 end                                      (**) functor Unfoldable (U : Unfoldable) : UnfoldableEX = struct
open ViewL infix <::
open Fn infixr $
open U

fun scanner' read s =
          case read s of
            SOME (x, s) =>
            let
              val (xs, s) = scanner' read s
            in
              (write (x, xs), s)
            end
          | NONE         => (genEmpty (), s)

fun scanner read s = SOME $ scanner' read s
fun pack packer b = packer write (b, genEmpty ())

fun mk foldr = foldr write $ genEmpty ()
fun fromList xs = mk List.foldr xs
fun fromVector xs = mk Vector.foldr xs
fun fromSeq xs = mk Seq.foldr xs

fun fromStream xs =
    Fn.fix (fn loop =>
            fn (xs, k) =>
               case Stream.viewl xs of
                 x <:: xs => loop (xs, fn b => k (write (x, b)))
               | nill     => k (genEmpty ())
           ) (xs, id)
end

 signature Mono =
sig
  type elm
  type t
end
 signature MonoMonad = sig
  include Mono val return : elm -> t
val >>= : t * (elm -> t) -> t
 end

signature MonoMonadEX = sig
  include Mono val map : elm UnOp.t -> t UnOp.t
val map2 : (elm -> elm -> elm) ->
           t -> t -> t
val map3 : (elm -> elm -> elm -> elm) ->
           t -> t -> t -> t
val map4 : (elm -> elm -> elm -> elm -> elm) ->
           t -> t -> t -> t -> t
val app : elm Effect.t -> t Effect.t
val $$ : elm UnOp.t * t -> t
val $| : elm * t -> t

val >> : t BinOp.t
val << : t BinOp.t
val mergerBy : elm BinOp.t -> t List.t -> t Option.t
val mergelBy : elm BinOp.t -> t List.t -> t Option.t

val =<< : (elm -> t) * t -> t
val >=> : (elm -> t) * (elm -> t) -> elm -> t
val <=< : (elm -> t) * (elm -> t) -> elm -> t
val forever : t UnOp.t
val foreverWithDelay : int -> t UnOp.t
val foldlM : ('a * elm -> t) -> elm -> 'a List.t -> t
val foldrM : ('a * elm -> t) -> elm -> 'a List.t -> t
 end                                      (**) functor MonoMonad (M : MonoMonad) : MonoMonadEX =
struct
open Fn infixr $
open M infix $$ $| << >> =<< >>= <=< >=>

fun map f m = m >>= return o f

fun app f m = (map (fn x => (f x; x)) m ; ())

fun f $$ m = map f m

fun x $| m = const x $$ m

fun m >> n = m >>= (fn x => n >>= (fn _ => return x))

fun m << n = m >>= (fn _ => n >>= (fn x => return x))

fun map2 f am bm = let infix 0 >>= in ( 
            am ) >>= (fn  a => ( 
            bm ) >>= (fn  b => 
       return $ f a b ) ) end 

fun map3 f am bm cm = let infix 0 >>= in ( 
            am ) >>= (fn  a => ( 
            bm ) >>= (fn  b => ( 
            cm ) >>= (fn  c => 
       return $ f a b c ) ) ) end 

fun map4 f am bm cm dm = let infix 0 >>= in ( 
            am ) >>= (fn  a => ( 
            bm ) >>= (fn  b => ( 
            cm ) >>= (fn  c => ( 
            dm ) >>= (fn  d => 
       return $ f a b c d ) ) ) ) end 


fun mergerBy _ nil = NONE
  | mergerBy f (m :: ms) =
    SOME (
    case mergerBy f ms of
      NONE   => m
    | SOME n => let infix 0 >>= in ( 
              n ) >>= (fn  y => ( 
              m ) >>= (fn  x => 
         return $ f (x, y) ) ) end 

    )

fun mergelBy f = mergerBy f o rev

fun m =<< n = n >>= m

fun (f >=> g) x = f x >>= g

fun (f <=< g) x = g x >>= f

fun forever m = m >>= (fn _ => forever m)

fun foreverWithDelay d m =
    let
      fun sleep () = OS.Process.sleep $ Time.fromMilliseconds $ LargeInt.fromInt d
      fun loop m = m >>= (fn _ => (sleep () ; loop m))
    in
      loop m
    end

fun foldlM _ b nil = return b
  | foldlM f b (x :: xs) = f (x, b) >>= (fn b' => foldlM f b' xs)

fun foldrM f b = foldlM f b o rev
end signature MonoMonadP = sig
  include Mono val return : elm -> t
val >>= : t * (elm -> t) -> t
 val || : t BinOp.t
val genZero : t Thunk.t
 end

signature MonoMonadPEX = sig
  include MonoMonadP val plus : t -> t -> t
val merger : t List.t -> t
val mergel : t List.t -> t
val mapPartial : (elm -> elm Option.t) -> t -> t
val keep : elm UnPred.t -> t UnOp.t
val reject : elm UnPred.t -> t UnOp.t
 val map : elm UnOp.t -> t UnOp.t
val map2 : (elm -> elm -> elm) ->
           t -> t -> t
val map3 : (elm -> elm -> elm -> elm) ->
           t -> t -> t -> t
val map4 : (elm -> elm -> elm -> elm -> elm) ->
           t -> t -> t -> t -> t
val app : elm Effect.t -> t Effect.t
val $$ : elm UnOp.t * t -> t
val $| : elm * t -> t

val >> : t BinOp.t
val << : t BinOp.t
val mergerBy : elm BinOp.t -> t List.t -> t Option.t
val mergelBy : elm BinOp.t -> t List.t -> t Option.t

val =<< : (elm -> t) * t -> t
val >=> : (elm -> t) * (elm -> t) -> elm -> t
val <=< : (elm -> t) * (elm -> t) -> elm -> t
val forever : t UnOp.t
val foreverWithDelay : int -> t UnOp.t
val foldlM : ('a * elm -> t) -> elm -> 'a List.t -> t
val foldrM : ('a * elm -> t) -> elm -> 'a List.t -> t
 end                                      (**) functor MonoMonadP (MP : MonoMonadP) : MonoMonadPEX = struct local structure PreML__TMP__ZZhXevdhHt = struct 

open MP infix ||

fun plus a b = a || b
fun merger ms = List.foldr op|| (genZero ()) ms
fun mergel ms = List.foldl op|| (genZero ()) ms

fun mapPartial f m = let infix 0 >>= in ( 
            m ) >>= (fn  x => 
       case f x of
         SOME y => return y
       | NONE   => genZero () ) end 
       ;

fun keep p m = let infix 0 >>= in ( 
            m ) >>= (fn  x => 
       if p x then return x else genZero () ) end 


fun reject p = keep (not o p) end local structure PreML__TMP__YnjzBxgxCf = MonoMonad ( open PreML__TMP__ZZhXevdhHt ) in structure PreML__TMP__ZZhXevdhHt = struct open PreML__TMP__YnjzBxgxCf PreML__TMP__ZZhXevdhHt end end in open PreML__TMP__ZZhXevdhHt end end signature MonoFoldable = sig
  include Mono val foldl : (elm * 'a -> 'a) -> 'a -> t -> 'a
val foldr : (elm * 'a -> 'a) -> 'a -> t -> 'a
 end

signature MonoFoldableEX = sig
  include Mono val foldr1 : elm BinOp.t -> t -> elm Option.t
val foldl1 : elm BinOp.t -> t -> elm Option.t
val foldrUntil : (elm * 'a -> 'a * Bool.t) -> 'a -> t -> 'a
val foldlUntil : (elm * 'a -> 'a * Bool.t) -> 'a -> t -> 'a
val appl : elm Effect.t -> t Effect.t
val appr : elm Effect.t -> t Effect.t
val apprUntil : elm UnPred.t -> t Effect.t
val applUntil : elm UnPred.t -> t Effect.t
val concatList : t List.t -> elm List.t
val concatMap : (elm -> 'a List.t) -> t -> 'a List.t
val any : elm UnPred.t -> t UnPred.t
val all : elm UnPred.t -> t UnPred.t
val find : elm UnPred.t -> t -> elm Option.t
val findr : elm UnPred.t -> t -> elm Option.t
val findl : elm UnPred.t -> t -> elm Option.t
val maximumBy : elm Cmp.t -> t -> elm Option.t
val minimumBy : elm Cmp.t -> t -> elm Option.t
val first : t -> elm
val last : t -> elm
 end                                      (**) functor MonoFoldable (F : MonoFoldable) : MonoFoldableEX =
struct
open Fn infixr $
open F

fun foldr f b xs = foldl (fn (x, k) => fn b => k $ f (x, b)) id xs b

local
  fun maybe f (x, yop) =
      SOME
        (case yop of
           SOME y => f (x, y)
         | NONE   => x
        )
in
fun foldr1 f xs =
    foldr (maybe f) NONE xs
fun foldl1 f xs =
    foldl (maybe f) NONE xs
end

local
  fun foldUntil fold f b xs =
      let
        val (b, _) =
            fold
              (fn (_, a as (_, false)) => a
                | (x, (a, _)) => f (x, a)
              )
              (b, true)
              xs
      in
        b
      end
in
fun foldrUntil f b xs = foldUntil foldr f b xs
fun foldlUntil f b xs = foldUntil foldl f b xs
end

fun appr ef xs = foldr (fn (x, _) => ef x) () xs
fun appl ef xs = foldl (fn (x, _) => ef x) () xs

local
  fun appUntil fold p xs =
      (fold (fn (_, false) => false
              | (x, _) => p x
            )
            true
            xs ;
       ())
in
fun apprUntil ef xs = appUntil foldr ef xs
fun applUntil ef xs = appUntil foldl ef xs
end

fun toList xs = foldr op:: nil xs

fun concatList xss =
    List.foldr (fn (x, a) => toList x @ a) nil xss

fun concatMap f xs =
    foldr (fn (x, a) => f x @ a) nil xs

fun all p xs =
    foldr (fn (x, a) => p x andalso a) true xs

fun any p xs =
    foldr (fn (x, a) => p x orelse a) false xs

fun maximumBy cmp xs =
    foldr1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => a
               | EQUAL   => a
               | GREATER => x
           )
           xs

fun minimumBy cmp xs =
    foldr1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => x
               | EQUAL   => x
               | GREATER => a
           )
           xs

local
  fun find fold p xs =
      fold (fn (_, a as SOME _) => a
             | (x, NONE) =>
               if p x then
                 SOME x
               else
                 NONE
           )
           NONE
           xs
in
fun findr p xs = find foldr p xs
fun findl p xs = find foldl p xs
val find = findl
end

local
  fun getIt fold xs =
      let
        exception GotIt of 'a
      in
        fold (fn (x, _) => raise GotIt x) (fn _ => raise Empty) xs ()
        handle GotIt x => x
      end
in
fun first xs = getIt foldl xs
fun last xs = getIt foldr xs
end

end

 signature MonoEnumerable = sig
  include Mono val read : (elm, t) Reader.t
 
end

signature MonoEnumerableEX = sig
  include Mono val toList : t -> elm List.t
val toSeq : t -> elm Seq.t
val toVector : t -> elm Vector.t
val toStream : t -> elm Stream.t
val packer : (elm, t, 'x) Packer.t
val scan : (elm, 'a, t) Scanner.t -> t -> 'a Option.t
 end                                      (**) functor MonoEnumerable (E : MonoEnumerable) : MonoEnumerableEX = struct
open E

fun packer write (s, empty) =
    case read s of
      SOME (x, a') => write (x, packer write (a', empty))
    | NONE         => empty

fun mk write empty s = packer write (s, empty)

fun toList xs = mk op:: nil xs
fun toSeq xs = mk Seq.<| (Seq.genEmpty ()) xs
fun toVector xs = Vector.fromList (toList xs)
fun toStream xs = mk Stream.<| (Stream.genEmpty ()) xs

fun scan scanner = Option.map (fn (a, _) => a) o scanner read
end

 signature MonoUnfoldable = sig
  include Mono val write : (elm, t) Writer.t
val genEmpty : t Thunk.t
 end

signature MonoUnfoldableEX = sig
  include Mono val fromList : elm List.t -> t
val fromSeq : elm Seq.t -> t
val fromVector : elm Vector.t -> t
val fromStream : elm Stream.t -> t
val scanner : (elm, t, 'x) Scanner.t
val pack : (elm, 'a, t) Packer.t -> 'a -> t
 end                                      (**) functor MonoUnfoldable (U : MonoUnfoldable) : MonoUnfoldableEX = struct
open ViewL infix <::
open Fn infixr $
open U

fun scanner' read s =
          case read s of
            SOME (x, s) =>
            let
              val (xs, s) = scanner' read s
            in
              (write (x, xs), s)
            end
          | NONE         => (genEmpty (), s)

fun scanner read s = SOME $ scanner' read s
fun pack packer b = packer write (b, genEmpty ())

fun mk foldr = foldr write $ genEmpty ()
fun fromList xs = mk List.foldr xs
fun fromVector xs = mk Vector.foldr xs
fun fromSeq xs = mk Seq.foldr xs

fun fromStream xs =
    Fn.fix (fn loop =>
            fn (xs, k) =>
               case Stream.viewl xs of
                 x <:: xs => loop (xs, fn b => k (write (x, b)))
               | nill     => k (genEmpty ())
           ) (xs, id)
end

 signature Ordered = sig
  type t val compare : t * t -> Order.t
 
end

signature OrderedEX = sig
  type t val <   : t BinPred.t
val <=  : t BinPred.t
val >   : t BinPred.t
val >=  : t BinPred.t
val ==  : t BinPred.t
val !=  : t BinPred.t
val lt  : t -> t -> bool
val lte : t -> t -> bool
val gt  : t -> t -> bool
val gte : t -> t -> bool
val eq  : t -> t -> bool
val neq : t -> t -> bool
val min : t BinOp.t
val max : t BinOp.t
val comparing : ('a -> t) -> 'a Cmp.t
val inRange : t * t -> t UnPred.t
 end                                      (**) functor Ordered (O : Ordered) : OrderedEX = struct
open O infix < == > <= >= !=
fun a < b = compare (a, b) = LESS
fun a == b = compare (a, b) = EQUAL
fun a > b = compare (a, b) = GREATER
fun a <= b = a < b orelse a == b
fun a >= b = a > b orelse a == b
fun a != b = not (a == b)

fun lt a b = a < b
fun lte a b = a <= b
fun gt a b = a > b
fun gte a b = a >= b
fun eq a b = a == b
fun neq a b = a != b

fun min (a, b) = if a < b then a else b
fun max (a, b) = if a > b then a else b

fun comparing f (a, b) = compare (f a, f b)

fun inRange (a, b) x = x >= a andalso x <= b
end

 signature PolyOrdered = sig
  type 'a t val compare : 'a t * 'b t -> Order.t
 
end

signature PolyOrderedEX = sig
  type 'a t val <   : 'a t * 'b t -> Bool.t
val <=  : 'a t * 'b t -> Bool.t
val >   : 'a t * 'b t -> Bool.t
val >=  : 'a t * 'b t -> Bool.t
val ==  : 'a t * 'b t -> Bool.t
val !=  : 'a t * 'b t -> Bool.t
val lt  : 'a t -> 'b t -> Bool.t
val lte : 'a t -> 'b t -> Bool.t
val gt  : 'a t -> 'b t -> Bool.t
val gte : 'a t -> 'b t -> Bool.t
val eq  : 'a t -> 'b t -> Bool.t
val neq : 'a t -> 'b t -> Bool.t
val min : 'a t BinOp.t
val max : 'a t BinOp.t
val comparing : ('a -> 'b t) -> 'a Cmp.t
val inRange : 'a t * 'b t -> 'c t UnPred.t
 end                                      (**) functor PolyOrdered (O : PolyOrdered) : PolyOrderedEX = struct
open O infix < == > <= >= !=
fun a < b = compare (a, b) = LESS
fun a == b = compare (a, b) = EQUAL
fun a > b = compare (a, b) = GREATER
fun a <= b = a < b orelse a == b
fun a >= b = a > b orelse a == b
fun a != b = not (a == b)

fun lt a b = a < b
fun lte a b = a <= b
fun gt a b = a > b
fun gte a b = a >= b
fun eq a b = a == b
fun neq a b = a != b

fun min (a, b) = if a < b then a else b
fun max (a, b) = if a > b then a else b

fun comparing f (a, b) = compare (f a, f b)

fun inRange (a, b) x = x >= a andalso x <= b
end

 signature Range =
sig
  type t val next : t UnOp.t
val prev : t UnOp.t
 val compare : t * t -> Order.t
 end

signature RangeEX =
sig
include Range val range : t * t -> t List.t
val xrange : t * t * Int.t -> t List.t
 end                                      (**) functor Range (R : Range) : RangeEX =
struct
open R

fun up (a, b, step) =
    case compare (a, b) of
      GREATER => nil
    | _       => a :: up (Fn.repeat step next a, b, step)

fun down (a, b, step) =
    case compare (a, b) of
      LESS => nil
    | _    => a :: down (Fn.repeat step prev a, b, step)

fun range (a, b) = up (a, b, 1)
fun xrange (a, b, step) =
    if step = 0
    then raise Domain
    else
      if step > 0
      then up (a, b, step)
      else down (a, b, ~step)
end signature Pickler = sig
  type t val pickle : (String.t, t, 'x) Packer.t
 
end

signature PicklerEX = sig
  type t val toString : t -> String.t
val toFile : String.t -> t Effect.t
val toStdOut : t Effect.t
val toOutstream : TextIO.outstream -> t Effect.t

val toCharList : t -> Char.t List.t
val toCharSeq : t -> Char.t Seq.t
val toCharStream : t -> Char.t Stream.t
 end                                      (**) functor Pickler (P : Pickler) : PicklerEX =
struct
open Fn infixr $
open P

fun create toString write (x, s) = write (toString x, s)

(* type s0 = string list *)
fun toString x = concat $ rev $ pickle op:: (x, nil)

(* type s3 = unit *)
fun toOutstream os x = pickle (fn (s, _) => TextIO.output (os, s)) (x, ())

(* type s1 = unit *)
fun toFile f x =
    let
      val os = TextIO.openOut f
    in
      toOutstream os x
    ; TextIO.closeOut os
    end

(* type s2 = unit *)
fun toStdOut x = toOutstream TextIO.stdOut x

(* type s4 = string list *)
fun toCharList x =
    List.concat $ rev $ pickle (fn (x, xs) => explode x :: xs) (x, nil)

(* type s5 = char seq *)
fun toCharSeq x =
    pickle (fn (s, cs) => String.foldr Seq.<| cs s) (x, Seq.empty)

(* type s6 = string list *)
fun toCharStream x =
    pickle (fn (s, cs) => String.foldr Stream.<| cs s) (x, Stream.genEmpty ())
end
 signature Unpickler = sig
  type t val unpickle : (char, t, 'x) Scanner.t
 
end

signature UnpicklerEX = sig
  type t val fromString : String.t -> t Option.t
val fromFile : String.t -> t Option.t
val fromStdIn : t Option.t Thunk.t
val fromInstream : TextIO.instream -> t Option.t

val fromCharList : Char.t List.t -> t Option.t
val fromCharSeq : Char.t Seq.t -> t Option.t
val fromCharStream : Char.t Stream.t -> t Option.t

val fromStringList : String.t List.t -> t Option.t
val fromStringSeq : String.t Seq.t -> t Option.t
val fromStringVector : String.t Vector.t -> t Option.t
val fromStringStream : String.t Stream.t -> t Option.t
 end                                      (**) functor Unpickler (U : Unpickler) : UnpicklerEX =
struct
open Fn infixr $
open U

fun dropState read xs =
    case unpickle read xs of
      NONE => NONE
    | SOME (x, _) => SOME x

(* type s0 = substring *)
fun fromString s = dropState Substring.getc $ Substring.full s

(* type s1 = TextIO.StreamIO.instream *)
fun fromInstream is =
    TextIO.scanStream unpickle is

(* type s2 = s1 *)
fun fromFile f =
    let
      val is = TextIO.openIn f
    in
      fromInstream is
      before TextIO.closeIn is
    end

(* type s3 = s1 *)
fun fromStdIn () = fromInstream TextIO.stdIn

(* type s4 = char list *)
fun fromCharList cs = dropState List.getItem cs

(* type s5 = char list *)
(* This is faster than using {Seq.getl} *)
fun fromCharSeq cs = fromCharList $ Seq.foldr op:: nil cs

(* type s6 = char stream *)
fun fromCharStream cs = dropState Stream.getl cs

fun fromStringX getl ss =
    let
      fun read (s, ss) =
          case Substring.getc s of
            SOME (c, s) => SOME (c, (s, ss))
          | NONE =>
            case getl ss of
              SOME (s, ss) => read (Substring.full s, ss)
            | NONE => NONE
    in
      dropState read (Substring.full "", ss)
    end

(* type s7 = substring * string list *)
fun fromStringList ss = fromStringX List.getItem ss

(* type s8 = substring * string seq *)
(* This is faster than using {Seq.getl} *)
fun fromStringSeq ss = fromStringList $ Seq.foldr op:: nil ss

fun fromStringVector ss = fromStringX VectorSlice.getItem $ VectorSlice.full ss

(* type s9 = substring * string stream *)
fun fromStringStream ss = fromStringX Stream.getl ss
end
 signature Option =
sig
  include OPTION where type 'a option = 'a option
  include MonadP where type 'a t = 'a option
val reflect : Exn.t -> 'a t -> 'a
end
                                    (**) structure Option :> Option =
struct
open Option
type 'a t = 'a option

fun reflect e = fn SOME x => x
                 | NONE   => raise e

fun op >>= (SOME x, k) = k x
  | op >>= (NONE, _) = NONE
val return = SOME
fun genZero () = NONE
fun op || (x as SOME _, _) = x
  | op || (_, y) = y
end local structure PreML__TMP__MNeNkKuFyX = 

                  MonadP ( open Option ) in structure Option = struct open PreML__TMP__MNeNkKuFyX Option end end signature Pair =
sig
  type ('a, 'b) t = 'a * 'b

  val swap : 'a * 'b -> 'b * 'a
  val swizzle : ('a * 'b) * ('c * 'd) -> ('a * 'c) * ('b * 'd)
  val fst : 'a * 'b -> 'a
  val snd : 'a * 'b -> 'b
  val app : ('a -> Unit.t) * ('b -> Unit.t) -> 'a * 'b -> Unit.t
  val appFst : ('a -> Unit.t) -> 'a * 'b -> Unit.t
  val appSnd : ('b -> Unit.t) -> 'a * 'b -> Unit.t
  val map : ('a -> 'c) * ('b -> 'd) -> 'a * 'b -> 'c * 'd
  val mapFst : ('a -> 'c) -> 'a * 'b -> 'c * 'b
  val mapSnd : ('b -> 'c) -> 'a * 'b -> 'a * 'c
  val foldl : ('a * 'c -> 'c) * ('b * 'c -> 'c) -> 'c -> 'a * 'b -> 'c
  val foldr : ('a * 'c -> 'c) * ('b * 'c -> 'c) -> 'c -> 'a * 'b -> 'c
  val delay : 'a Lazy.t * 'b Lazy.t -> ('a * 'b) Lazy.t
end
                                    (**) structure Pair :> Pair =
struct
type ('a, 'b) t = 'a * 'b

fun swap (a, b) = (b, a)
fun swizzle ((a, b), (c, d)) = ((a, c), (b, d))
fun fst (a, _) = a
fun snd (_, b) = b
fun app (fa, fb) (a, b) = (fa a ; fb b)
fun appFst f = f o fst
fun appSnd f = f o snd
fun map (fa, fb) (a, b) = (fa a, fb b)
fun mapFst f = map (f, Fn.id)
fun mapSnd f = map (Fn.id, f)
fun foldl (fa, fb) c (a, b) = fb (b, fa (a, c))
fun foldr (fa, fb) c (a, b) = fa (a, fb (b, c))
fun delay (la, lb) = Lazy.lazy (fn _ => (Lazy.force la, Lazy.force lb))
end
                                    (**) structure ViewL = ViewL
                                    (**) structure ViewR = ViewR
 signature Exn =
sig
  type t = exn
  val name : t -> String.t
  val message : t -> String.t
  val throw : t -> 'a
  val finally : 'a Thunk.t * Unit.t Effect.t -> 'a
  val try : 'a Thunk.t * ('a -> 'b) * (t -> 'b) -> 'b

  val apply : ('a -> 'b) -> 'a -> (t, 'b) Either.t
  val eval : 'a Thunk.t -> (t, 'a) Either.t
  val reflect : (t, 'a) Either.t -> 'a
end
                                    (**) structure Exn : Exn =
struct
type t = exn
val name = General.exnName
val message = General.exnMessage
fun throw e = raise e
fun try (th, fv, fe) = fv (th ()) handle e => fe e
fun past ef x = (ef () ; x)
fun finally (th, ef) = try (th, past ef, throw o past ef)

fun apply f x = Either.Right (f x) handle e => Either.Left e
fun eval th = apply th ()
val reflect = fn Either.Left e  => raise e
               | Either.Right x => x
end
 signature Void =
sig
  type t

  val void : t -> 'a
end
                                    (**) structure Void :> Void =
struct
datatype t = T of t
fun void x = void x
end
 signature Unit =
sig
  type t = unit
 (* Ordered *)
end
                                    (**) structure Unit :> Unit = struct local structure PreML__TMP__zNTFRhVUPH = struct 

type t = unit
fun compare ((), ()) = EQUAL end local structure PreML__TMP__QYhyeRzcxT = Ordered ( open PreML__TMP__zNTFRhVUPH ) in structure PreML__TMP__zNTFRhVUPH = struct open PreML__TMP__QYhyeRzcxT PreML__TMP__zNTFRhVUPH end end in open PreML__TMP__zNTFRhVUPH end end signature Bool =
sig
  include BOOL
type t = bool

  val isTrue : t UnPred.t
  val isFalse : t UnPred.t
(* Ordered, Pickler, Unpickler *)
end
                                    (**) structure Bool :> Bool = struct local structure PreML__TMP__VBFbhrqKxd = struct 

open Bool
datatype t = datatype bool

val compare = fn (true, false) => GREATER
               | (false, true) => LESS
               | _             => EQUAL

fun isTrue b = b
val isFalse = not

val unpickle = scan
fun pickle write = write o Fn.first toString end local structure PreML__TMP__dUiRjaGwrm = Ordered ( open PreML__TMP__VBFbhrqKxd ) structure PreML__TMP__vfrnyisoqR = Pickler ( open PreML__TMP__dUiRjaGwrm PreML__TMP__VBFbhrqKxd ) structure PreML__TMP__lkmSVYvZGS = Unpickler ( open PreML__TMP__dUiRjaGwrm PreML__TMP__vfrnyisoqR PreML__TMP__VBFbhrqKxd ) in structure PreML__TMP__VBFbhrqKxd = struct open PreML__TMP__dUiRjaGwrm PreML__TMP__vfrnyisoqR PreML__TMP__lkmSVYvZGS PreML__TMP__VBFbhrqKxd end end in open PreML__TMP__VBFbhrqKxd end end signature Order = sig
  type t = order

  val swap : t UnOp.t

  val isEqual : t UnPred.t
  val isGreater : t UnPred.t
  val isLess : t UnPred.t
(* Ordered, Pickler, Unpickler *)
end
                                    (**) structure Order :> Order = struct local structure PreML__TMP__UeCRoJbRGQ = struct 

type t = order

val compare = fn (LESS, LESS)       => EQUAL
               | (EQUAL, EQUAL)     => EQUAL
               | (GREATER, GREATER) => EQUAL
               | (LESS, _)          => LESS
               | (_, LESS)          => GREATER
               | (GREATER, _)       => GREATER
               | (_, GREATER)       => LESS

val swap = fn EQUAL   => EQUAL
            | LESS    => GREATER
            | GREATER => LESS

fun isGreater x = x = GREATER
fun isLess x = x = LESS
fun isEqual x = x = EQUAL

val toString = fn GREATER => "GREATER"
                | LESS    => "LESS"
                | EQUAL   => "EQUAL"

fun pickle write = write o Fn.first toString

fun op >>= (m, k) s =
    case m s of
      SOME (a, s') => k a s'
    | NONE         => NONE

fun return a s = SOME (a, s)

fun fail _ = NONE

fun op || (p, q) s =
    case p s of
      x as SOME _ => x
    | NONE        => q s

fun unpickle read =
    let
      infix ||
      fun t c = let infix 0 >>= in ( 
                   read ) >>= (fn  c' => 
             if c = c'
             then return c
             else fail ) end 

    in let infix 0 >>= in ( 
         t #"G" ) >>= (fn _ => ( 
         t #"R" ) >>= (fn _ => ( 
         t #"E" ) >>= (fn _ => ( 
         t #"A" ) >>= (fn _ => ( 
         t #"T" ) >>= (fn _ => ( 
         t #"E" ) >>= (fn _ => ( 
         t #"R" ) >>= (fn _ => 
         return GREATER ) ) ) ) ) ) ) end 
          || let infix 0 >>= in ( 
         t #"E" ) >>= (fn _ => ( 
         t #"Q" ) >>= (fn _ => ( 
         t #"U" ) >>= (fn _ => ( 
         t #"A" ) >>= (fn _ => ( 
         t #"L" ) >>= (fn _ => 
         return EQUAL ) ) ) ) ) end 
          || let infix 0 >>= in ( 
         t #"L" ) >>= (fn _ => ( 
         t #"E" ) >>= (fn _ => ( 
         t #"S" ) >>= (fn _ => ( 
         t #"S" ) >>= (fn _ => 
         return LESS ) ) ) ) end 

    end end local structure PreML__TMP__UunrulmIEC = Ordered ( open PreML__TMP__UeCRoJbRGQ ) structure PreML__TMP__IezszKqqgU = Pickler ( open PreML__TMP__UunrulmIEC PreML__TMP__UeCRoJbRGQ ) structure PreML__TMP__bdcYYAIKnd = Unpickler ( open PreML__TMP__UunrulmIEC PreML__TMP__IezszKqqgU PreML__TMP__UeCRoJbRGQ ) in structure PreML__TMP__UeCRoJbRGQ = struct open PreML__TMP__UunrulmIEC PreML__TMP__IezszKqqgU PreML__TMP__bdcYYAIKnd PreML__TMP__UeCRoJbRGQ end end in open PreML__TMP__UeCRoJbRGQ end end signature Either =
sig
  datatype ('a, 'b) t =
           Left of 'a
         | Right of 'b
  exception Either

  val swap : ('a, 'b) t -> ('b, 'a) t
  val ofLeft : ('a, 'b) t -> 'a
  val ofRight : ('a, 'b) t -> 'b
  val ofEither : ('a, 'a) t -> 'a
  val either : ('a -> 'c) * ('b -> 'c) -> ('a, 'b) t -> 'c
  val lefts : ('a, 'b) t List.t -> 'a List.t
  val rights : ('a, 'b) t List.t -> 'b List.t
  val partition : ('a, 'b) t List.t -> 'a List.t * 'b List.t
  val map : ('a -> 'c) * ('b -> 'd) -> ('a, 'b) t -> ('c, 'd) t
  (* Mnemonic: 'Left' is 'LESS' *)
  val collate : 'a Cmp.t * 'b Cmp.t -> ('a, 'b) t Cmp.t
  val iso : ('a, 'c) Iso.t * ('b, 'd) Iso.t -> (('a, 'b) t, ('c, 'd) t) Iso.t
end
                                    (**) structure Either :> Either =
struct
datatype ('a, 'b) t =
         Left of 'a
       | Right of 'b
exception Either

val swap = fn Left x => Right x
            | Right x => Left x

val ofLeft = fn Left x => x
              | _ => raise Either

val ofRight = fn Right x => x
               | _ => raise Either

val ofEither = fn Left x  => x
                | Right x => x

fun map (f, g) = fn Left x  => Left (f x)
                  | Right x => Right (g x)

fun either fs = ofEither o map fs

fun lefts es = List.mapPartial (fn Left x => SOME x | _ => NONE) es
fun rights es = List.mapPartial (fn Right x => SOME x | _ => NONE) es

fun partition es =
    List.foldr (fn (Left x, (xs, ys))  => (x :: xs, ys)
                 | (Right y, (xs, ys)) => (xs, y :: ys)
               ) (nil, nil) es

fun collate (cl, cr) =
 fn (Left x, Left y)   => cl (x, y)
  | (Right x, Right y) => cr (x, y)
  | (Left _, Right _)  => LESS
  | (Right _, Left _)  => GREATER

fun iso ((a2c, c2a), (b2d, d2b)) =
    (map (a2c, b2d), map (c2a, d2b))
end
 (* Memoized lazy evaluation *)
signature Lazy =
sig
  type 'a t

  val lazy : 'a Thunk.t -> 'a t
  val force : 'a t -> 'a
  val eager : 'a -> 'a t
  val delay : 'a t Thunk.t -> 'a t
  val thunk : 'a t -> 'a Thunk.t
  val memoise : 'a Thunk.t UnOp.t
end
                                    (**) structure Lazy :> Lazy = Lazy
 signature Univ = sig
  type t
  exception Univ
  val newIso : ('a, t) Iso.t Thunk.t
  val newEmb : ('a, t) Emb.t Thunk.t
end
                                    (**) structure Univ :> Univ =
struct
type t = Exn.t
exception Univ

fun newIso () : ('a, t) Iso.t =
    let
      exception E of 'a
      fun ofE (E x) = x
        | ofE _ = raise Univ
    in
      (E, ofE)
    end

fun newEmb () : ('a, t) Emb.t =
    let
      exception E of 'a
      fun ofE (E x) = SOME x
        | ofE _ = NONE
    in
      (E, ofE)
    end
end
 signature Set = sig
  include Mono val insert : t -> elm -> t
val adjust : (elm Option.t -> elm) -> t -> elm -> t
val empty : t
val null : t -> Bool.t
val member : t -> elm -> Bool.t
val remove : t -> elm -> t
val compareElm : elm Cmp.t
val card : t -> Int.t
 val foldl : (elm * 'a -> 'a) -> 'a -> t -> 'a
val foldr : (elm * 'a -> 'a) -> 'a -> t -> 'a
 end

signature SetEX = sig
  include Mono val return : elm -> t
val >>= : t * (elm -> t) -> t
 val map : elm UnOp.t -> t UnOp.t
val map2 : (elm -> elm -> elm) ->
           t -> t -> t
val map3 : (elm -> elm -> elm -> elm) ->
           t -> t -> t -> t
val map4 : (elm -> elm -> elm -> elm -> elm) ->
           t -> t -> t -> t -> t
val app : elm Effect.t -> t Effect.t
val $$ : elm UnOp.t * t -> t
val $| : elm * t -> t

val >> : t BinOp.t
val << : t BinOp.t
val mergerBy : elm BinOp.t -> t List.t -> t Option.t
val mergelBy : elm BinOp.t -> t List.t -> t Option.t

val =<< : (elm -> t) * t -> t
val >=> : (elm -> t) * (elm -> t) -> elm -> t
val <=< : (elm -> t) * (elm -> t) -> elm -> t
val forever : t UnOp.t
val foreverWithDelay : int -> t UnOp.t
val foldlM : ('a * elm -> t) -> elm -> 'a List.t -> t
val foldrM : ('a * elm -> t) -> elm -> 'a List.t -> t
 val || : t BinOp.t
val genZero : t Thunk.t
 val plus : t -> t -> t
val merger : t List.t -> t
val mergel : t List.t -> t
val mapPartial : (elm -> elm Option.t) -> t -> t
val keep : elm UnPred.t -> t UnOp.t
val reject : elm UnPred.t -> t UnOp.t
 val read : (elm, t) Reader.t
 val toList : t -> elm List.t
val toSeq : t -> elm Seq.t
val toVector : t -> elm Vector.t
val toStream : t -> elm Stream.t
val packer : (elm, t, 'x) Packer.t
val scan : (elm, 'a, t) Scanner.t -> t -> 'a Option.t
 val write : (elm, t) Writer.t
val genEmpty : t Thunk.t
 val fromList : elm List.t -> t
val fromSeq : elm Seq.t -> t
val fromVector : elm Vector.t -> t
val fromStream : elm Stream.t -> t
val scanner : (elm, t, 'x) Scanner.t
val pack : (elm, 'a, t) Packer.t -> 'a -> t
 val compare : t * t -> Order.t
 val <   : t BinPred.t
val <=  : t BinPred.t
val >   : t BinPred.t
val >=  : t BinPred.t
val ==  : t BinPred.t
val !=  : t BinPred.t
val lt  : t -> t -> bool
val lte : t -> t -> bool
val gt  : t -> t -> bool
val gte : t -> t -> bool
val eq  : t -> t -> bool
val neq : t -> t -> bool
val min : t BinOp.t
val max : t BinOp.t
val comparing : ('a -> t) -> 'a Cmp.t
val inRange : t * t -> t UnPred.t
 end                                      (**) functor Set (S : Set) : SetEX = struct local structure PreML__TMP__ApAHHkLNFe = struct local structure PreML__TMP__oOJjYwhmIJ = 

     MonoFoldable(S) in open PreML__TMP__oOJjYwhmIJ end 
open S

val singleton = insert empty
fun union s = foldl (fn (e, s) => insert s e) s

fun >>= (s, k) = foldl (fn (e, s') => union (k e) s') empty s
val return = singleton
fun genZero ? = empty
val || = Fn.uncurry union

fun split s = let val e = first s in (e, remove s e) end

fun read s = SOME (split s) handle Empty => NONE

fun insert s e = union (singleton e) s

fun write (e, s) = insert s e
val genEmpty = genZero

fun compare (s, t) =
    case (read s, read t) of
      (NONE, NONE)   => EQUAL
    | (SOME _, NONE) => GREATER
    | (NONE, SOME _) => LESS
    | (SOME (se, s'), SOME (te, t')) =>
      case compareElm (se, te) of
        EQUAL => compare (s', t')
      | order => order end local structure PreML__TMP__vTVOeDTXYK = MonoMonadP ( open PreML__TMP__ApAHHkLNFe ) structure PreML__TMP__IxJYEXcqaj = MonoFoldable ( open PreML__TMP__vTVOeDTXYK PreML__TMP__ApAHHkLNFe ) structure PreML__TMP__XteUYRwELG = MonoEnumerable ( open PreML__TMP__vTVOeDTXYK PreML__TMP__IxJYEXcqaj PreML__TMP__ApAHHkLNFe ) structure PreML__TMP__RXEytMNeNk = MonoUnfoldable ( open PreML__TMP__vTVOeDTXYK PreML__TMP__IxJYEXcqaj PreML__TMP__XteUYRwELG PreML__TMP__ApAHHkLNFe ) structure PreML__TMP__KuFyXpPCVD = Ordered ( open PreML__TMP__vTVOeDTXYK PreML__TMP__IxJYEXcqaj PreML__TMP__XteUYRwELG PreML__TMP__RXEytMNeNk PreML__TMP__ApAHHkLNFe ) in structure PreML__TMP__ApAHHkLNFe = struct open PreML__TMP__vTVOeDTXYK PreML__TMP__IxJYEXcqaj PreML__TMP__XteUYRwELG PreML__TMP__RXEytMNeNk PreML__TMP__KuFyXpPCVD PreML__TMP__ApAHHkLNFe end end in open PreML__TMP__ApAHHkLNFe end end signature Map = sig
  type key
  type 'a t val adjust : ('a Option.t -> 'a) -> 'a t -> key -> 'a t
val insert : 'a t -> key * 'a -> 'a t
val empty : 'a t
val null : 'a t UnPred.t
val lookup : 'a t -> key -> 'a Option.t
val remove : 'a t -> key -> 'a t
val compareKey : key Cmp.t
val card : 'a t -> Int.t
val foldli : ((key * 'a) * 'b -> 'b) -> 'b -> 'a t -> 'b
val foldri : ((key * 'a) * 'b -> 'b) -> 'b -> 'a t -> 'b
 val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
 end

signature MapEX = sig
  type key
  type 'a t (* Implemented using continuations:
 *   fun foldr f b xs = foldl (fn (x, k) => fn b => k (f (x, b))) id xs b
 * This is actually faster than the default implementation of List.foldr in
 * MLTon.
 *)

val foldr1 : 'a BinOp.t -> 'a t -> 'a Option.t
val foldl1 : 'a BinOp.t -> 'a t -> 'a Option.t
val foldrWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b
val foldlWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b
val appl : 'a Effect.t -> 'a t Effect.t
val appr : 'a Effect.t -> 'a t Effect.t
val applWhile : ('a -> Bool.t) -> 'a t Effect.t
val apprWhile : ('a -> Bool.t) -> 'a t Effect.t
val concatFoldable : 'a List.t t -> 'a List.t
val concatList : 'a t List.t -> 'a List.t
val conjoin : Bool.t t UnPred.t
val disjoin : Bool.t t UnPred.t
val any : 'a UnPred.t -> 'a t UnPred.t
val all : 'a UnPred.t -> 'a t UnPred.t
val find : 'a UnPred.t -> 'a t -> 'a Option.t
val findr : 'a UnPred.t -> 'a t -> 'a Option.t
val findl : 'a UnPred.t -> 'a t -> 'a Option.t
val member : ''a -> ''a t UnPred.t
val notMember : ''a -> ''a t UnPred.t
val maximumBy : 'a Cmp.t -> 'a t -> 'a Option.t
val minimumBy : 'a Cmp.t -> 'a t -> 'a Option.t
val intSum : Int.t t -> Int.t
val realSum : Real.t t -> Real.t
val intProduct : Int.t t -> Int.t
val realProduct : Real.t t -> Real.t
val leftmost  : 'a Option.t t -> 'a Option.t
val rightmost : 'a Option.t t -> 'a Option.t
val first : 'a t -> 'a
val last : 'a t -> 'a
   val singleton : key * 'a -> 'a t
  val <| : key * 'a * 'a t -> 'a t
  val >< : 'a t BinOp.t
  val !! : 'a t * key -> 'a
  val viewl : 'a t -> (key * 'a, 'a t) ViewL.t
  val viewr : 'a t -> (key * 'a, 'a t) ViewR.t
  val fromList : (key * 'a) List.t -> 'a t
  val toList : 'a t -> (key * 'a) List.t
  val insert : 'a t -> key * 'a -> 'a t
  val insertMaybe : 'a t -> key * 'a -> 'a t Option.t
  val inDomain : 'a t -> key -> Bool.t
  val inRange : ''a t -> ''a -> Bool.t
  val domain : 'a t -> key List.t
  val range : 'a t -> 'a List.t
  val index : 'a t -> key -> 'a
  val lookupWithDefault : 'a t -> key -> 'a -> 'a
  val lookupAdjust : ('a Option.t -> 'a) -> key -> 'a t -> 'a * 'a t
  val split : 'a t -> ((key * 'a) * 'a t) Option.t
  val splitFirst : 'a t -> ((key * 'a) * 'a t) Option.t
  val splitLast : 'a t -> ((key * 'a)* 'a t) Option.t
  val some : 'a t -> 'a
  val collate : 'a Cmp.t -> 'a t Cmp.t
  val splitOn : key -> 'a t -> 'a t * 'a Option.t * 'a t

  (* Return a map whose domain is the union of the domains of the two input
   * maps, always choosing the second map on elements that are in bot domains.
   *)
  val plus : 'a t -> 'a t -> 'a t

  (* returns a map whose domain is the difference of the domains of the two
   * input maps
   *)
  val diff : 'a t -> 'a t -> 'a t
  val \ : 'a t BinOp.t

  val keep : 'a UnPred.t -> 'a t UnOp.t
  val reject : 'a UnPred.t -> 'a t UnOp.t
  val partition : 'a UnPred.t -> 'a t -> 'a t * 'a t
  val partitionWith : ('a -> ('b, 'c) Either.t) -> 'a t -> 'b t * 'c t
  val mapPartial : ('a -> 'a Option.t) -> 'a t UnOp.t

  (* return a map whose domain is the union of the domains of the two input
   * maps, using the supplied function to define the map on elements that
   * are in both domains.
   *)
  val union : 'a BinOp.t -> 'a t BinOp.t
  val unions : 'a BinOp.t -> 'a t List.t -> 'a t

  (* return a map whose domain is the intersection of the domains of the
   * two input maps, using the supplied function to define the range.
   *)
  val inter : ('a * 'b -> 'c) -> 'a t * 'b t -> 'c t
  val inters : 'a BinOp.t -> 'a t List.t -> 'a t

  (* merge two maps using the given function to control the merge. For
   * each key k in the union of the two maps domains, the function
   * is applied to the image of the key under the map.  If the function
   * returns SOME y, then (k, y) is added to the resulting map.
   *)
  val merge : ('a Option.t * 'b Option.t -> 'c Option.t) -> 'a t * 'b t -> 'c t
  val merges : 'a Option.t BinOp.t -> 'a t List.t -> 'a t
 end signature Sequence = sig
  type 'a t val <| : 'a * 'a t -> 'a t
val |> : 'a t * 'a -> 'a t
val getl : ('a, 'a t) Reader.t
val getr : ('a, 'a t) Reader.t
val >< : 'a t BinOp.t
val genEmpty : 'a t Thunk.t
val null : 'a t UnPred.t
val index : int -> 'a t -> 'a
val adjust : 'a UnOp.t -> int -> 'a t UnOp.t
val length : 'a t -> Int.t
 val map : ('a -> 'b) -> 'a t -> 'b t
 val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
 end

signature SequenceEX = sig
  type 'a t val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
 val pure : 'a -> 'a t
val ** : ('a -> 'b) t * 'a t -> 'b t
 val >> : 'a t * 'b t -> 'b t
val << : 'a t * 'b t -> 'a t
val -- : 'a t * 'b t -> ('a * 'b) t
val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
val map3 : ('a -> 'b -> 'c -> 'r) ->
            'a t -> 'b t -> 'c t -> 'r t
val map4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
            'a t -> 'b t -> 'c t -> 'd t -> 'r t
val mergerBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val mergelBy : 'a BinOp.t -> 'a t List.t -> 'a t Option.t
val cartesian : 'a t -> 'b t -> ('a * 'b) t
 val || : 'a t BinOp.t
val genZero : 'a t Thunk.t
 val plus : 'a t -> 'a t -> 'a t
val optional : 'a t -> 'a Option.t t
val merger : 'a t List.t -> 'a t
val mergel : 'a t List.t -> 'a t
val guard : Bool.t -> Unit.t t
 val return : 'a -> 'a t
val >>= : 'a t * ('a -> 'b t) -> 'b t
 val fail : String.t -> 'a t
val join : 'a t t -> 'a t
val mapM : ('a -> 'b t) -> 'a List.t -> 'b List.t t
val mapMPartial : ('a -> 'b Option.t t) -> 'a List.t -> 'b List.t t
val mapM' : ('a -> 'b t) -> 'a List.t -> Unit.t t
val seq : 'a t List.t -> 'a List.t t
val seq' : 'a t List.t -> Unit.t t
val =<< : ('a -> 'b t) * 'a t -> 'b t
val >=> : ('a -> 'b t) * ('b -> 'c t) -> 'a -> 'c t
val <=< : ('b -> 'c t) * ('a -> 'b t) -> 'a -> 'c t
val forever : 'a t -> 'b t
val foreverWithDelay : Int.t -> 'a t -> 'b t
val ignore : 'a t -> Unit.t t
val keepM : ('a -> Bool.t t) -> 'a List.t -> 'a List.t t
val rejectM : ('a -> Bool.t t) -> 'a List.t -> 'a List.t t
val mapAndUnzipM : ('a -> ('b * 'c) t) -> 'a List.t ->
                   ('b List.t * 'c List.t) t
val zipWithM : ('a * 'b -> 'c t) -> 'a List.t * 'b List.t -> 'c List.t t
val zipWithM' : ('a * 'b -> 'c t) -> 'a List.t * 'b List.t -> Unit.t t
val foldlM : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> 'b t
val foldlM' : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> Unit.t t
val foldrM : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> 'b t
val foldrM' : ('a * 'b -> 'b t) -> 'b -> 'a List.t -> Unit.t t
val tabulateM : Int.t -> (Int.t -> 'a t) -> 'a List.t t
val tabulateM' : Int.t -> (Int.t -> 'a t) -> Unit.t t
val when : Bool.t -> Unit.t t -> Unit.t t
val unless : Bool.t -> Unit.t t -> Unit.t t
 val mapPartial : ('a -> 'a Option.t) -> 'a t UnOp.t
val keep : 'a UnPred.t -> 'a t UnOp.t
val reject : 'a UnPred.t -> 'a t UnOp.t
 (* Implemented using continuations:
 *   fun foldr f b xs = foldl (fn (x, k) => fn b => k (f (x, b))) id xs b
 * This is actually faster than the default implementation of List.foldr in
 * MLTon.
 *)

val foldr1 : 'a BinOp.t -> 'a t -> 'a Option.t
val foldl1 : 'a BinOp.t -> 'a t -> 'a Option.t
val foldrWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b
val foldlWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b
val appl : 'a Effect.t -> 'a t Effect.t
val appr : 'a Effect.t -> 'a t Effect.t
val applWhile : ('a -> Bool.t) -> 'a t Effect.t
val apprWhile : ('a -> Bool.t) -> 'a t Effect.t
val concatFoldable : 'a List.t t -> 'a List.t
val concatList : 'a t List.t -> 'a List.t
val conjoin : Bool.t t UnPred.t
val disjoin : Bool.t t UnPred.t
val any : 'a UnPred.t -> 'a t UnPred.t
val all : 'a UnPred.t -> 'a t UnPred.t
val find : 'a UnPred.t -> 'a t -> 'a Option.t
val findr : 'a UnPred.t -> 'a t -> 'a Option.t
val findl : 'a UnPred.t -> 'a t -> 'a Option.t
val member : ''a -> ''a t UnPred.t
val notMember : ''a -> ''a t UnPred.t
val maximumBy : 'a Cmp.t -> 'a t -> 'a Option.t
val minimumBy : 'a Cmp.t -> 'a t -> 'a Option.t
val intSum : Int.t t -> Int.t
val realSum : Real.t t -> Real.t
val intProduct : Int.t t -> Int.t
val realProduct : Real.t t -> Real.t
val leftmost  : 'a Option.t t -> 'a Option.t
val rightmost : 'a Option.t t -> 'a Option.t
val first : 'a t -> 'a
val last : 'a t -> 'a
 val read : ('a, 'a t) Reader.t
 val toList : 'a t -> 'a list
val toSeq : 'a t -> 'a Seq.t
val toVector : 'a t -> 'a vector
val toStream : 'a t -> 'a Stream.t
val packer : ('a, 'a t, 'x) Packer.t
val scan : ('a, 'b, 'a t) Scanner.t -> 'a t -> 'b Option.t
 val write : ('a, 'a t) Writer.t
val genEmpty : 'a t Thunk.t
 val fromList : 'a List.t -> 'a t
val fromSeq : 'a Seq.t -> 'a t
val fromVector : 'a Vector.t -> 'a t
val fromStream : 'a Stream.t -> 'a t
val scanner : ('a, 'a t, 'x) Scanner.t
val pack : ('a, 'b, 'a t) Packer.t -> 'b -> 'a t
 (* See also: Func, Idiom, Alt, Monad, MonadP, Foldable, Enumerable, Unfoldable
 *)

val head : 'a t -> 'a
val tail : 'a t UnOp.t
val init : 'a t UnOp.t
val singleton : 'a -> 'a t
val !! : 'a t * Int.t -> 'a
val append : 'a t -> 'a t -> 'a t

val viewl : 'a t -> ('a, 'a t) ViewL.t
val viewr : 'a t -> ('a, 'a t) ViewR.t

val cons : 'a -> 'a t UnOp.t
val snoc : 'a -> 'a t UnOp.t
val lookup : 'a t -> Int.t -> 'a Option.t
val update : 'a t -> Int.t -> 'a -> 'a t

val rev : 'a t UnOp.t
val take : 'a t * Int.t -> 'a t
val drop : 'a t * Int.t -> 'a t
val splitAt : Int.t -> 'a t -> 'a t * 'a * 'a t
val concat : 'a t t -> 'a t
val revAppend : 'a t BinOp.t
val tabulate : Int.t * (Int.t -> 'a) -> 'a t
val collate : 'a Cmp.t -> 'a t Cmp.t

val sort : 'a Cmp.t -> 'a t UnOp.t
val shuffle : 'a t UnOp.t
val allPairs : 'a t -> ('a * 'a) t
val allSplits : 'a t -> 'a t t
val consAll : 'a -> 'a t t UnOp.t
val concatMap : ('a -> 'b t) -> 'a t -> 'b t
val slice : ('a t * Int.t Option.t * Int.t Option.t) -> 'a t
val groupBy : 'a Cmp.t -> 'a t -> 'a t t
val group : ''a t -> ''a t t
val power : 'a t -> 'a t t
val permutations : 'a t -> 'a t t
val inits : 'a t -> 'a t t
val tails : 'a t -> 'a t t
val subsequences : 'a t -> 'a t t

val intersperse : 'a -> 'a t -> 'a t
val transpose : 'a t t UnOp.t
val scanl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b t
val scanl1 : ('a * 'b -> 'b) -> 'a t -> 'b t
val scanlWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b t
val scanr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b t
val scanr1 : ('a * 'b -> 'b) -> 'a t -> 'b t
val scanrWhile : ('a * 'b -> 'b * Bool.t) -> 'b -> 'a t -> 'b t
val mapAccumL : ('a * 'c -> 'b * 'c) -> 'c -> 'a t -> 'b t * 'c
val mapAccumR : ('a * 'c -> 'b * 'c) -> 'c -> 'a t -> 'b t * 'c
val replicate : Int.t -> 'a -> 'a t
val takeWhile : 'a UnPred.t -> 'a t -> 'a t
val dropWhile : 'a UnPred.t -> 'a t -> 'a t
val partition : 'a UnPred.t -> 'a t -> 'a t * 'a t
val span : 'a UnPred.t -> 'a t -> 'a t * 'a t
val break : 'a UnPred.t -> 'a t -> 'a t * 'a t
val removePrefix : ''a t -> ''a t UnOp.t
val isPrefixOf : ''a t -> ''a t UnPred.t
val isSuffixOf : ''a t -> ''a t UnPred.t
val isInfixOf : ''a t -> ''a t UnPred.t
val memberIndex : ''a -> ''a t -> Int.t Option.t
val memberIndices : ''a -> ''a t -> Int.t t
val findIndex : 'a Cmp.t -> 'a -> 'a t -> Int.t Option.t
val findIndices : 'a Cmp.t -> 'a -> 'a t -> Int.t t
val lines : String.t -> String.t t
val unlines : String.t t -> String.t
val words : String.t -> String.t t
val unwords : String.t t -> String.t
val nub : ''a t UnOp.t
val insert : ''a -> ''a t UnOp.t
val delete : ''a -> ''a t UnOp.t
val diff : ''a t -> ''a t -> ''a t
val inter : ''a t -> ''a t -> ''a t
val union : ''a t -> ''a t -> ''a t
val nubBy : 'a Cmp.t -> 'a t UnOp.t
val insertBy : 'a Cmp.t -> 'a -> 'a t UnOp.t
val deleteBy : 'a Cmp.t -> 'a -> 'a t UnOp.t
val diffBy : 'a Cmp.t -> 'a t -> 'a t -> 'a t
val interBy : 'a Cmp.t -> 'a t -> 'a t -> 'a t
val unionBy : 'a Cmp.t -> 'a t -> 'a t -> 'a t
val zip : 'a t * 'b t -> ('a * 'b) t
val zipWith : ('a * 'b -> 'c) -> 'a t * 'b t -> 'c t
val unzip : ('a * 'b) t -> 'a t * 'b t
val zip3 : 'a t * 'b t * 'c t -> ('a * 'b * 'c) t
val zipWith3 : ('a * 'b * 'c -> 'd) -> 'a t * 'b t * 'c t -> 'd t
val unzip3 : ('a * 'b * 'c) t -> 'a t * 'b t * 'c t

val zip4 : 'a t * 'b t * 'c t * 'd t -> ('a * 'b * 'c * 'd) t
val zipWith4 : ('a * 'b * 'c * 'd -> 'e) -> 'a t * 'b t * 'c t * 'd t -> 'e t
val unzip4 : ('a * 'b * 'c * 'd) t -> 'a t * 'b t * 'c t * 'd t
val zip5 : 'a t * 'b t * 'c t * 'd t * 'e t -> ('a * 'b * 'c * 'd * 'e) t
val zipWith5 : ('a * 'b * 'c * 'd * 'e -> 'f) ->
               'a t * 'b t * 'c t * 'd t * 'e t -> 'f t
val unzip5 : ('a * 'b * 'c * 'd * 'e) t -> 'a t * 'b t * 'c t * 'd t * 'e
 end                                      (**) signature Iso =
sig
  type ('a, 'b) t = ('a -> 'b) * ('b -> 'a)

  val id : ('a, 'a) t
  val swap : ('a, 'b) t -> ('b, 'a) t
  val to : ('a, 'b) t -> 'a -> 'b
  val from : ('a, 'b) t -> 'b -> 'a
  val map : ('c, 'a) t * ('b, 'd) t -> ('a, 'b) t -> ('c, 'd) t
  val <--> : ('b, 'c) t * ('a, 'b) t -> ('a, 'c) t
end
                                    (**) structure Iso :> Iso =
struct
type ('a, 'b) t = ('a -> 'b) * ('b -> 'a)

val id = (Fn.id, Fn.id)
val swap = Pair.swap
val to = Pair.fst
val from  = Pair.snd
fun map ((c2a, a2c), (b2d, d2b)) (a2b, b2a) =
    (b2d o a2b o c2a, a2c o b2a o d2b)

fun op <--> ((b2c, c2b), (a2b, b2a)) = (b2c o a2b, b2a o c2b)
end
 signature Emb =
sig
  type ('a, 'b) t = ('a -> 'b) * ('b -> 'a Option.t)

  val id : ('a, 'a) t
  val to : ('a, 'b) t -> 'a -> 'b
  val from : ('a, 'b) t -> 'b -> 'a Option.t
  val <--> : ('b, 'c) t * ('a, 'b) t -> ('a, 'c) t
end
                                    (**) structure Emb :> Emb =
struct
type ('a, 'b) t = ('a -> 'b) * ('b -> 'a Option.t)

val id = (Fn.id, SOME)
val to = Pair.fst
val from  = Pair.snd

fun op <--> ((b2c, c2bop), (a2b, b2aop)) =
    (b2c o a2b, fn c => Option.>>= (c2bop c, b2aop))
end
                                    (**) structure Identity = struct local structure PreML__TMP__WltkFckuIL = struct 

type 'a t = 'a
fun return x = x
fun op>>= (m, k) = k m end local structure PreML__TMP__JtYjDhPjLX = Monad ( open PreML__TMP__WltkFckuIL ) in structure PreML__TMP__WltkFckuIL = struct open PreML__TMP__JtYjDhPjLX PreML__TMP__WltkFckuIL end end in open PreML__TMP__WltkFckuIL end end signature MonadState =
sig
  type 'a inner
  type ('a, 's) t = 's -> ('a * 's) inner

  val >>= : ('a, 's) t * ('a -> ('b, 's) t) -> ('b, 's) t
  val return : 'a -> ('a, 's) t

  val lift : 'a inner -> ('a, 's) t
  val get : ('s, 's) t
  val put : 's -> (Unit.t, 's) t
  val modify : 's UnOp.t -> (Unit.t, 's) t
  val gets : ('s -> 'a) -> ('a, 's) t
  val run  : ('a, 's) t -> 's -> ('a * 's) inner
  val eval : ('a, 's) t -> 's -> 'a inner
  val exec : ('a, 's) t -> 's -> 's inner

  val mapState : (('a * 's) inner -> ('b * 's) inner) ->
                 ('a, 's) t -> ('b, 's) t
  val withState : 's UnOp.t -> ('a, 's) t -> ('a, 's) t
end

signature MonadStateP =
sig
  include MonadState
val genZero : ('a, 's) t Thunk.t
val || : ('a, 's) t BinOp.t
end
                                    (**) functor StateT (I : Monad) :>
        MonadState
          where type 'a inner = 'a I.t =
struct
type 'a inner = 'a I.t
type ('a, 's) t  = 's -> ('a * 's) inner val $ = Fn.$ 

            infixr $

fun op >>= (m, k) s = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

                  m s ) >>= (fn  (a, s') => 
       k a s' ) end 


fun return a s = I.return (a, s)

fun lift m s = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

            m ) >>= (fn  a => 
       return (a, s) ) end 


fun get s = I.return (s, s)
fun put s _ = I.return ((), s)
fun modify f s = I.return ((), f s)
fun gets f s = I.return (f s, s)

fun run m s = m s
fun eval m s = I.>>= (m s, fn (a, _) => I.return a)
fun exec m s = I.>>= (m s, fn (_, s) => I.return s)

fun mapState f m s = f (m s)
fun withState f m s = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

                  m s ) >>= (fn  (a, s') => 
       return (a, f s') ) end 

end                                 (**) functor StateTP (I : MonadP) :>
        MonadStateP
          where type 'a inner = 'a I.t =
struct local structure PreML__TMP__awwVQApAHH = 
     StateT(I) in open PreML__TMP__awwVQApAHH end 
fun genZero () s = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

            I.genZero () ) >>= (fn  z => 
       return (z, s) ) end 


fun op || (m, n) s = I.|| (m s, n s)
end                                 (**) structure State :> MonadState where type 'a inner = 'a = StateT(Identity)
 signature MonadError =
sig
  type 'a inner
  type ('a, 'e) t = ('e, 'a) Either.t inner

  val >>= : ('a, 'e) t * ('a -> ('b, 'e) t) -> ('b, 'e) t
  val return : 'a -> ('a, 'e) t
  val || : ('a, 'e) t BinOp.t

  val lift : 'a inner -> ('a, 'e) t

  val throw : 'e -> ('a, 'e) t
  val catch : ('a, 'e) t * ('e -> ('a, 'e) t) -> ('a, 'e) t
  val run : ('a, 'e) t -> ('e, 'a) Either.t inner

  val mapError : (('e, 'a) Either.t inner ->
                  ('f, 'a) Either.t inner) -> ('a, 'e) t -> ('a, 'f) t
end
                                    (**) functor ErrorT (I : Monad) :>
        MonadError
          where type 'a inner = 'a I.t =
struct
type 'a inner = 'a I.t
type ('a, 'e) t = ('e, 'a) Either.t inner
datatype either = datatype Either.t val $ = Fn.$ 

            infixr $

fun op >>= (m, k) = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

             m ) >>= (fn  ex => 
       case ex of
         Left e  => return (Left e)
       | Right x => k x ) end 


fun return x = I.return $ Right x

fun op || (a, b) = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

             a ) >>= (fn  ex => 
       case ex of
         Left e  => b
       | Right x => return $ Right x ) end 


fun lift m = I.>>= (m, return)

fun throw e = I.return $ Left e

fun op catch (m, h) = let infix 0 >>= val op>>= = I.>>= val return = I.return in ( 

            m ) >>= (fn  x => 
       case x of
         Left e  => (h e handle Bind => throw e)
       | Right x => return $ Right x ) end 


fun run m = m

fun mapError f m = f m
end                                 (**) structure Error = ErrorT(Identity)
 signature Exit = sig
  type 'a t

  val block : ('a t -> 'a) -> 'a
  val <- : 'a t * 'a -> 'b
end
                                    (**) structure Exit :> Exit =
struct
type 'a t = 'a -> exn

fun block b : 'a =
    let
      exception E of 'a
    in
      b E handle E x => x
    end

fun op <- (e, x) = raise e x
end
 signature Reader =
sig
  include MonadStateP

  val returnO : 'a Option.t -> ('a, 'x) t
end
                                    (**) structure Reader :> Reader =
struct
type ('a, 'x) t = 'x -> ('a * 'x) Option.t local structure PreML__TMP__YGtfXKjxwu = 

     StateTP(Option) in open PreML__TMP__YGtfXKjxwu end 

val returnO = lift
end                                 (**) structure Int = struct local structure PreML__TMP__WYUZTwTuxI = struct 

open Int

fun pickle write (x, stream) = write (Int.toString x, stream)

fun unpickle ? = scan StringCvt.DEC ?

fun next n = n + 1
fun prev n = n - 1 end local structure PreML__TMP__eWigSRxGLm = Ordered ( open PreML__TMP__WYUZTwTuxI ) structure PreML__TMP__AOvrwvSNio = Pickler ( open PreML__TMP__eWigSRxGLm PreML__TMP__WYUZTwTuxI ) structure PreML__TMP__IYOoPMVZxZ = Unpickler ( open PreML__TMP__eWigSRxGLm PreML__TMP__AOvrwvSNio PreML__TMP__WYUZTwTuxI ) structure PreML__TMP__VBFbhrqKxd = Range ( open PreML__TMP__eWigSRxGLm PreML__TMP__AOvrwvSNio PreML__TMP__IYOoPMVZxZ PreML__TMP__WYUZTwTuxI ) in structure PreML__TMP__WYUZTwTuxI = struct open PreML__TMP__eWigSRxGLm PreML__TMP__AOvrwvSNio PreML__TMP__IYOoPMVZxZ PreML__TMP__VBFbhrqKxd PreML__TMP__WYUZTwTuxI end end in open PreML__TMP__WYUZTwTuxI end end end