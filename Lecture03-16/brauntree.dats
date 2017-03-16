datatype 
btree(a: t@ype)
| bt_nil of ()
| bt_cons of (btree(a), a, btree(a))

extern
fun{a:t@ype} btree_height(btree(a)): int

extern 
fun{a:t@ype} btree_is_braun(btree(a)): bool

(*
implement{a}
btree_is_braun(t0) =
  case+ xs of
  | bt_nil() => true
  | bt_cons(tl, _, tr) => 
      btree_is_braun(tl) &&
      btree_is_braun(tr) &&
      (let 
        val hl = btree_height(tl)
        val hr = btree_height(tr)
      in
        (0 <= hl-hr) && (hl-hr <= 1) 
      end)
*)

implement{a}
btree_is_braun(t0) =
  let
    exception NotBraunExn of ()
    fun aux(t0: btree(a)): int
      case+ xs of
      | bt_nil() => 0
      | bt_cons(tl, _, tr) => 
          let 
            val hl = btree_height(tl)
            val hr = btree_height(tr)
            val diff = hl - hr
          in
            if (0 <= diff && diff <= 1) then 1 + hl else $raise(NotBraunExn)
          end
  in 
    try (ignoret(aux(t0)); true) with ~NotBraunExn() => false 
  end  

