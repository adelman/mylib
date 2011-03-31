functor Monad (M : MonadBase) : Monad =
struct
structure M = struct
open M
type 'a app = 'a monad
fun a ** b = a >>= (fn x => b >>= (fn y => return $ x y))
(* Alternatively {fun a ** b = do x <- a ; y <- b ; return (x y) end} *)
end

structure A = App (M)
open A M

fun m -- n = m >>= (fn x => n >>= (fn y => return (x, y)))
fun join x = x >>= (fn x => x)
fun seq ms =
    List.foldr
      (fn (m, m') =>
          m >>= (fn x => m' >>= (fn xs => return (x :: xs)))
      )
      (return nil)
      ms
fun seq' ms = List.foldr op>> (return ()) ms

fun mapM f xs = seq $ List.map f xs
fun mapMPartial f xs =
    List.foldr
      (fn (x, m') =>
          f x >>= (fn NONE   => m'
                    | SOME x => m' >>= (fn xs => return $ x :: xs)
                  )
      )
      (return nil)
      xs
fun mapM' f xs = seq' $ List.map f xs

fun keepM p xs =
    case xs of
      nil     => return nil
    | x :: xs => p x >>= (fn px =>
                 keepM p xs >>= (fn ys =>
                 return (if px then x :: ys else ys)
                 ))
fun rejectM p xs = keepM (fn x => p x >>= return o not) xs

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

fun ignore m = m >> return ()

fun mapAndUnzipM f xs =
    seq (List.map f xs) >>= (return o ListPair.unzip)

fun zipWithM f ls =
    seq $ List.map f $ ListPair.zip ls

fun zipWithM' f ls =
    seq' $ List.map f $ ListPair.zip ls

fun foldM _ b nil = return b
  | foldM f b (x :: xs) = f (x, b) >>= (fn b' => foldM f b' xs)

fun foldM' f b xs = ignore $ foldM f b xs

fun tabulateM n m =
    seq $ List.tabulate (n, m)

fun tabulateM' n m =
    seq' $ List.tabulate (n, m)

fun when p m = if p then m else return ()
fun unless p m = if p then return () else m
end