#inlcude "share/atspre_staload.hats"

/* Basic Expression syntax */
(*
EXP ::= 1|2|3...
      | 1+2|3-4|...
      | true|false
      | ....
      | aint|bint|x|y|z|...
      | if EXP then EXP
      | if EXP then EXP else EXP
      | let BINDING* in EXP end
      | EXP where { BINDING* }
      | lam (PARAM,PARAM...) => EXP
      | fix NAME (PARAM,PARAM...) => EXP
      | (EXP;EXP;EXP....)
      | NAME := EXP
      ....

BINDING ::= val NAME = EXP
          | var NAME = EXP
          | fun NAME ( PARAM:TYPE, PARAM:TYPE ...): TYPE = EXP

val issues a binding between the left and right statements
var assigns actually values to a variable

let
  val a = 1
  val b = 2
in 
  if a > b      // cannot do more than 1 expression, that's illegal
  then a - b
  else b - a
end
*)

/* Basic function syntax */
(*

fun thename (*param1:*type1, *param2:*type2, ...): rettype

dats file uses an extern in front of it
hats file you just use it as is, no extern

implement thename (param1:*type1*, param2:*type2*, ...): EXP

implement main0 () = () where {
 
  /* Closure function */ 
  fun thename (param1:type1, param2:type2, ...): rettype = EXP

  /* Anonymous function, no recursion */
  fun add (a:int, b:int): int = a + b
  val add = lam (a:int, b:int):int => a + b

  /* Another anonymous function, with recursion */
  val fact = fix f(n:int):int => if n = 0 then 1 else n * f(n-1)
 
  val sum_list = list_fold(alist, lam(a,b) => a + b, 0) 
  val mul_list = list_fold(alist, lam(a,b) => a * b, 1)

  val x = 3
  val addx = lam (a:int):int =<cloref1> a + x 

  val x = 4
  val _ = println! (addx 10) // Because the outside x is now 4, it will give 14 not 13

  fun add_k_times (k:int, n:int): int = 
    if k = 0 then n else add_k_times(k-1, addx(n))

  val y = add_k_times(10, x)
*)

/* Basic primitive assignment syntax */
implement main0 () = () where {

    val aint = 1 
    val bint = ~1
    val cint = aint + bint // -, ~, *, /, modi
    val afloat = 1.0

    val abool = true // false
    val bbool = ~abool
    val cbool = abool && bbool // or, andalso, orelse
    val dbool = abool * bbool // abool + bbool
    
  (* andalso and orelse dont have short-ciruiting, both are evaluated regardless *)
  (* Python uses == for equality, ATS only uses = for the same such operation *)

    val astr = "iasjodijasdoi"
    val achar = 'a'
    // val bstr = astr + "wew" --> this doesn't work, can't concatenate with a '+'

    // Can't define lists such as [1,2,3,4]
    val alist = 1::2::3::nil  //How to actually define a list
  
    var a:int = 1
    val () = a := 2 //Semi-colon equal is a void re-assigning of 2 to the variable a

    val x = (1,2,3,"hello") //(int, int, int, string)
    val (a,b,c,d) = x  // a = 1, b = 2, c = 3, d = "hello"
  
    val y = @{label1=1:int, label2="hello":string}
    val @{label1=a, label2=b} = y
    val _ println! (x.label1)
  
    val _ = $showtype x 
  }

/* Underscore is a wildcard pendant that matches anything 
 * on the other side of the equal sign.
 * Closed parenthese is just a constant of void stat
 */

