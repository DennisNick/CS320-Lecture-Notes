(*
 * Doublets Game
 * May need to pseudo staload a "./Doublets.sats"
 *)
 
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

abstype word
typedef wordlst = list0(word)
assume word = list0(char)

fun word_get_neighbors(word): list0(word)
and eq_word_word : (word, word) -> bool

overload = with eq_word_word

(* ***** ***** *)

typedef node = list0(word)
typedef nodelst = list0(node)

(* ***** ***** *)

fun node_get_neighbors(nx: node): nodelst = 
  let
    val n0 = list0_head_exn(nx)
    val n1 = word_get_neighbors(n0)
    fun listing(ws: wordlst) = nodelst =
      case+ ws of 
      | list0_nil() => list0_nil()
      | list0_cons(w, ws) =>
          let
            val test = list0_exists(nx, lam(w1) => w = w1)
          in 
            if(test) then listing(ws) else list0_cons(w, nx, listing(ws))
          end
  in
    listing(ws)
  end
    
