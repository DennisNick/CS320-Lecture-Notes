
%{^
#include <unistd.h>
%}

(* Typical Imperative Approach *)

fun fact(n: int): int =
  if(n > 0) then n*fact(n-1) else 1

(* Tail-Recursive Approach *)

fun fact(n: int, c: int): int =
  if(n > 0) then face(n-1, n*c) else 1

(* CPS-style (continuation-passing style) *)
(* Will need passing of a function for handling of the current *)
(* Callback function is used from an immediate result obtained *)

extern
fun sleep(i: int): void = "ext#sleep" // Calls the native C function in its place

implement
sleep(i) = $extfcall(void, "sleep", i)

fun kfact(n: int, k: int -<cloref1> void): void =
  if(n > 0) then kfact(n-1, lam(res) => (println!("n*res"); sleep(1); k(n*res)) else k(1) 

implement
main0() =
  {
    val () = kfact(10, lam(res) => println!("Fact(10) = ", res))
  }

