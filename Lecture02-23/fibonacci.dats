#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
  
#include "$PATSHOMELOCS//effectivats-divideconquer/mylibies.hats"

//$DIVIDECONQUER.DC_solve
// or
#staload DC = $DIVIDECONQUER
// or
//#staload $DIVIDECONQUER

extern
fun Fibonacci:(int) -> int

assume $DC.input_t0ype = int
assume $DC.output_t0ype = int

local

implement
$DC.DC_base_text(n) = (n <= 1)

implement
$DC.DC_base_solve(n) = (n)

implement
$DC.DC_divide<>(n) = 
  xs where {
    val xs = list0_nil()
    val xs = list0_cons(n-1, xs)
    val xs = list0_cons(n-2, xs)
  }

implement
$DC.DC_conquer_combine<>(_, rs) =
  r1 + r2 where { 
    val- list0_cons(r1, rs) = rs
    val- list0_cons(r2, rs) = rs
    val- list0_nil() = rs
  }

in 

implement
Fibonacci(n) = $DC.DC_solve<>(n) 
// This alone is just soo simple, bit of a problem really
// Need to specifialize the problem by concretizing the abstract types.
// And that is achieved by the assume commands

end

implement main0() =
  {
    val () = println! ("Fibonacci(10) = ", Fibonacci(10))
  }
