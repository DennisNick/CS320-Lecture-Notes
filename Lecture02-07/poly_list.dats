datatype
mylist2(a:t@ype) =
  | mylist2_nil of ()
  | mylist2_cons of (a, mylist2i(a))

typedef mylist2_int = mylist2(int)
typedef mylist2_string = mylist2(string)
// typedef mylist2_type = mylist2(type)

// This is template based code that cnanot generate object files
extern
fun{a:t@ype} length: mylist2(a) -> int
and{a:t@ype} append: mylist2(a), mylist2(a) -> mylist2(a)
and{a:t@ype} reverse: mylist2(a) -> mylist2(a)
and{a:t@ype} is_nil: mylist2(a) -> bool
and{a:t@ype} reverse_append: mylist2(a), mylist2(a) -> mylist2(a)
and{a:t@ype} fast_reverse: mylist2(a), mylist2(a) -> mylist2(a)

// O(n)
implement{a}
length(xs) =
  case xs of
    | mylist2_nil() => 0
    | mylist2_cons(_,xs) => 1 + length<a>(xs)

// O(n)
implement{a}
append(xs, ys) =
  case xs of
    | mylist2_nil() => nil()
    | mylist2_cons(x, xs) => cons(x, append<a>(xs, ys))

// O(1)
implement{a}
is_nil(xs) =
  case xs of 
    | mylist2_nil() => true
    | mylist2_cons(_,_) => false

// O(n^2)
implement{a}
reverse(xs) =
  case xs of
    | mylist2_nil() => nil()
    | mylist2_cons(x, xs) => append<a>(reverse<a>(xs, cons(x, nil()))) 
    // can replace cons(x, nil()) with sing(x)

// O(n)
implement{a}
reverse_append(xs, ys) =
  case xs of 
    | mylist2_nil() => ys
    | mylist2_cons(x, xs) => reverse_append<a>(xs, cons(x, ys))

// O(n)
implement{a}
fast_reverse(xs) =
  reverse_append<a>(xs, nil())
