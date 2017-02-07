datatype 
mylist = 
  | mylist_nil of ()
  | mylist_cons of (int, mylist)

#define nil mylist_nil
#define cons mylist_cons
#define :: mylist_cons // An infix

val xs0 = nil()
val xs1 = cons(1, xs0)
val xs2 = cons(2, xs1)
val xs3 = 3 :: xs2
val xs4 = $showtype(4 :: xs3)

extern
fun length: mylist -> int
and append: mylist, mylist -> mylist
and reverse: mylist -> mylist
and is_nil: mylist -> bool
and reverse_append: mylist, mylist -> mylist
and fast_reverse: mylist, mylist -> mylist

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

// O(n)
implement
reverse_append(xs, ys) =
  case xs of 
    | nil() => ys
    | cons(x, xs) => reverse_append(xs, cons(x, ys))

// O(n)
implement
fast_reverse(xs) =
  reverse_append(xs, nil())
