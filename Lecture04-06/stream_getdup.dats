#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

extern
fun {a:t@ype} stream_getdup(stream(a)): stream(a)

implement{a}
stream_getdup(xs) = 
  let
    fun first(xs: stream(a)): stream(a) = 
      $delay(
        let
          val-stream_cons(x1, xs) = !xs
        in
          !(second(x1, xs))
        end
      )

    and second(x1: a, xs: stream(a)): stream(a) =
      $delay(
        let
          val-stream_cons(x2, xs) = !xs
          val sgn = gcompare_val_val<a>(x1, x2)
        in
          if(sgn != 0) then !(second(x2, xs))
          else !(third(x2, xs))
        end
      )
    
    and third(x2: a, xs: stream(a)): stream(a) =
      $delay(
        let
          val-stream_cons(x3, xs) = !xs
          val sgn = gcompare_val_val<a>(x2, x3)
        in
          if(sgn != 0) then stream_cons(x2, second(x3, xs)) 
          else !(third(x3, xs))
        end
      )
  in
    first(xs)
  end
