import Mathlib
set_option autoImplicit false

--Rank Function
structure RankFun (α : Type _) [DecidableEq α] where
  {Ground : Finset α}
  rank : Finset Ground → ℕ
  prop1 : ∀ {A : Finset Ground}, rank A ≤ Finset.card A
  prop2 : ∀ {A B : Finset Ground}, A ⊆ B → rank A ≤ rank B
  prop3 : ∀ {A B : Finset Ground}, rank (A ∪ B) + rank (A ∩ B) ≤ rank A + rank B

--Matroid
structure Matroid (α : Type _) [DecidableEq α] where
  {Ground : Finset α}
  {Independent : Finset Ground → Prop}
  EmptySet : Independent {} 
  Hereditary : ∀ {A B : Finset Ground}, ((Independent A) ∧ (B ⊆ A)) → Independent B 
  Augmentation' : ∀ {A B : Finset Ground}, ((Independent A)∧(Independent B)∧(Finset.card B > Finset.card A)) → ∃ e, (e ∈ (B \ A)) ∧ Independent (insert e A) 


-- Dependent
def Dependent {α : Type _} [DecidableEq α] (M : Matroid α) (A : Finset (M.Ground)) : Prop :=
  ¬ M.Independent A

--Circuit
def Circuit {α : Type _} [DecidableEq α] (M : Matroid α) (B : Finset (M.Ground)) : Prop :=
  ∀ (A : Finset (M.Ground)), Dependent M B ∧ (A ⊆ B) → M.Independent A 
   

      





