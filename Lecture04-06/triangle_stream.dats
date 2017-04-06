#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

extern
fun triangles_gen(): stream(int)
and {a: t@ype}{res: t@ype} stream_scan(stream(a), res, (res, a) -<cloref1> res)

(*
extern
fun triangle(n: int): int

implement
triangle(n) = n * (n+1) / 2

implement
triangles_gen() =
  aux(0) where {
    fun aux(n: int): stream(int) = $delay(stream_cons(triangle(n), aux(n+1)))
  }
*)

implement
triangles_gen() =
  aux(1, 0) where {
    fun aux(n: int, t: int): stream(int) = $delay(stream_cons(t, aux(n+1, n+t)))
  }

implement{a}{res}
stream_scan(xs, res, fopr) = 
  $delay(
          case+ !xs of
          | stream_nil() => stream_cons(res, stream_make_nil())
          | stream(x, xs) => stream_cons(res, stream_scan(xs, fopr(res, x)), fopr)
        )

fun triangles() = 
  let
    fun from(n: int): stream(int) = $delay(stream_cons(n, from(n+1)))
  in
    stream_scan<int><int>(from(1), 0, lam(res, x) => res+x)
  end
