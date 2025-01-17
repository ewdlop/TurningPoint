(* Define the type for knots and links *)
Inductive Link : Type :=
| Unknot : Link                    (* Base case: the unknot *)
| LPlus : Link -> Link -> Link     (* Positive crossing *)
| LMinus : Link -> Link -> Link    (* Negative crossing *)
| LZero : Link -> Link -> Link.    (* Smoothed crossing *)

(* Define the Alexander–Conway polynomial recursively *)
Fixpoint alexander_conway (L : Link) : nat -> Z :=
  match L with
  | Unknot => fun z => 1                (* Base case: unknot polynomial is 1 *)
  | LPlus L1 L2 => fun z => 
      (alexander_conway L1 z) - (alexander_conway L2 z) + z * (alexander_conway LZero L1 z)
  | LMinus L1 L2 => fun z => 
      (alexander_conway L1 z) - (alexander_conway L2 z) - z * (alexander_conway LZero L1 z)
  | LZero L1 L2 => alexander_conway L1  (* No crossing: just reduce *)
  end.

(* Example: Compute the polynomial for an unknot *)
Compute (alexander_conway Unknot 2).
(* Expected output: 1 *)
