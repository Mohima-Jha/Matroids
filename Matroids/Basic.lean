import Mathlib

structure Matroids (Ground : Finset α) (Independent : Finset Ground → Prop)[DecidableEq α] where
  EmptySet : Independent {} 
  Hereditary : ∀ {A B : Finset Ground}, ((Independent A) ∧ (B ⊆ A)) → Independent B 
  Augmentation : ∀ {A B : Finset Ground}, ((Independent A)∧(Independent B)∧(Finset.card B > Finset.card A)) → ∃ e, (e ∈ (B \ A)) ∧ Independent (insert e A) 

