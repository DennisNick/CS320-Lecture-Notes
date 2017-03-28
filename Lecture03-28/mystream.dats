
extern
fun {a:t@ype} stream_append(xs: stream(a), ys: stream(a)): stream(a)
and {a:t@ype} stream_filter(xs: stream(a), test: (a) -<cloref1> bool): stream(a)
and {a,b:t@ype} stream_filter(xs: stream(a), func: (a) -<cloref1> b): stream(b)

implement{a}
stream_append(xs, ys) =
  $delay(
    aux(xs, ys) where 
    { 
      fun aux(xs: stream(a), ys: stream(a)): stream(a) =
        case+ !xs of
        | stream_nil() => !ys
        | stream_cons(x, xs) => stream_cons(x, aux(xs, ys)) 
    }
  )

implement{a}
stream_filter(xs, test) =
  aux(xs, test) where 
  {
    fun aux(xs: stream(a)): stream(a) =
      $delay(
        case+ !xs of
        | stream_nil() => stream_nil()
        | stream_cons(x, xs) => if(test(x)) then stream_cons(x, aux(xs)) else !aux(xs)
      )
  }

implement{a}{b}
stream_filter(xs, func) =
  aux(xs, test) where 
  {
    fun aux(xs: stream(a)): stream(b) =
      $delay(
        case+ !xs of
        | stream_nil() => stream_nil()
        | stream_cons(x, xs) => stream_cons(func(x), aux(xs))
      )
  }
