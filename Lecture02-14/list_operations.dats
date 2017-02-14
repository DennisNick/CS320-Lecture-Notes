(* 
** Operations on list0-values
*)

#include "share/atspre_staload.hats"
#include "share/HATS/some_other_library.hats"

datatype list0(a:t@ype) = 
  | list0_nil of ()
  | list0_cons of (a, list0(a))

extern 
fun {a:t@ype}{b:t@ype} list0_map_cloref(xs: list0(a), fopr: (a) -<cloref1> b)
and {a:t@ype} list0_filter_cloref(xs: list0(a), text: (a) -<cloref1> bool): list0(a)


// {a:t@ype}{b:t@ype} = list0_map_cloref<int><string>
// {a,b:t@ype} = list0_map_cloref<int, string>
(*
implement{a}{b}
list0_map_cloref(xs, fopr) =
  case xs of
  | list0_nil() => list0_nil()
  | list0_cons(x, xs) => list0_cons(fopr(x), list0_map_cloref<a><b>(xs, fopr))
*)

/* Far better style, makes the compiler not screw itself */
implement{a}{b}
list0_map_cloref(xs, fopr) = 
  fun aux(xs: list0(a)): list0(b)
  (
  case+ xs of
  | list0_nil() => list0_nil()
  | list0_cons(x, xs) => list0_cons(fopr(x), aux(xs))
  )
}

implement{a}
list0_filter_cloref(xs, test) = 
  fun aux(xs: list0(a)): list0(b)
  (
  case+ xs of
  | list0_nil() => list0_nil()
  | list0_cons(x, xs) => if test(x) then list0_cons(x, aux(xs)) else aux(xs)
  )
}

/* g0ofg1 is a form of casting */
val xs = g0ofg1($list(int)(0, 1, 2, 3, 4))

val xs2 = list0_map_cloref<int><int>(xs, lam x => 2 * x)

val ys2 = list0_filter_cloref<int>(xs, lam x => x <= 4)
