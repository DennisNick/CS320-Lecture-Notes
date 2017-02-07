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
and append: mylist2(a), mylist2(a) -> mylist2(a)
and reverse: mylist2(a) -> mylist2(a)
and is_nil: mylist2(a) -> bool

// O(n)
implement
length(xs) =
  case xs of
    | nil() => 0
    | cons(_,xs) => 1 + length(xs)

// O(n)
implement
append(xs, ys) =
  case xs of
    | nil() => nil()
    | cons(x, xs) => cons(x, append(xs, ys))

// O(1)
implement
is_nil(xs) =
  case xs of 
    | nil() => true
    | cons(_,_) => false

// O(n^2)
implement 
reverse(xs) =
  case xs of
    | nil() => nil()
    | cons(x, xs) => append(reverse(xs, cons(x, nil()))) // can replace cons(x, nil()) with sing(x)
