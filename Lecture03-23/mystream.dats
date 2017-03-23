#include "share/atspre_staload.hats"
#include "share/Hats/atspre_staload_libats_ML.hats"

//Reminder that loops are bad, K?
(*
fun
from(n: int): list0(int) =
  list0_cons(n, from(n+1))
*)

(* ****** ****** *)

extern
fun {a:t@ype} mystream_filter:(stream, pred: (a) -<cloref1> bool): stream(a)

extern
fun {a:t@ype}{b:t@ype} mystream_map:(stream(a), funp: (a, int) -<cloref1> b): stream(b)

(* ****** ****** *)

implement{a}
mystream_filter(xs, pred) =
  $delay(
          case+ xs of
          | stream_nil() => stream_nil()
          | stream_cons(x, xs) => 
              if(pred(x)) then stream_cons(x, mystream_filter<a>(xs, pred))
              else !(mystream_filter<a>(xs, pred))               
        )

implement{a}{b}
mystream_map(xs, funp) =
  $delay(
          case+ !xs of
          | stream_nil() => stream_nil()
          | stream_cons(x, xs) => stream_cons(funp(x), mystream_map<a><b>(xs, funp))
        )

fun 
from(n: int): stream(int) =
  $delay(stream_cons(n, from(n+1)))

val xs = from(0)
val xs = mystream_map<int><int>(xs, lam(x) => x * x) //Commutative properties.
val xs = mystream_filter<int>(xs, lam(x) => x % 2 = 0)

val-(stream_cons(x,xs)) = !(xs)    //Formation of a stream into a stream_cons
val () = println!(x)
val xs = from(0)
val-(stream_cons(x,xs)) = !(xs)    //Formation of a stream into a stream_cons
val () = println!(x)
val xs = from(0)
val-(stream_cons(x,xs)) = !(xs)    //Formation of a stream into a stream_cons
val () = println!(x)
val xs = from(0)
val-(stream_cons(x,xs)) = !(xs)    //Formation of a stream into a stream_cons
val () = println!(x)

implement main0 () = ()
