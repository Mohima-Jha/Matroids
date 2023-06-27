import Mathlib
set_option autoImplicit false

--Graph
structure Graph (Vertex : Type _) where 
  Vertices   : List Vertex
  Edges      : List (Vertex × Vertex)
  Adjacent   : Vertex → Vertex → Prop
  Symm       : ∀ (V₁ V₂ : Vertex), (V₁, V₂) ∈ Edges → (V₂, V₁) ∈ Edges


variable {Vertex : Type _}
variable (G : Graph Vertex) 

--Loop
def Loop {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∃ (V : Vertex), V ∈ G.Vertices ∧ (V, V) ∈ G.Edges

--Adjacent
def Adjacent (V₁ V₂ : Vertex): Prop := 
  (V₁, V₂) ∈ G.Edges

--Walk
inductive IsWalk : Vertex → Vertex → Type u
  | Base {V₁ : Vertex} : IsWalk V₁ V₁
  | Step {V₁ V₂ V₃ : Vertex} (h : G.Adjacent V₁ V₂) (p : IsWalk V₂ V₃) : IsWalk V₁ V₃
attribute [refl] IsWalk.Base 

/-
inductive IsPath : Vertex → Vertex → Type _
  |Base {V : Vertex} : IsPath V V
  |Adjacent {V₁ V₂ : Vertex} : G.Adjacent V₁ V₂ → IsWalk V₁ V₂
  |Step {V₁ V₂ V₃ : Vertex}(h : G.Adjacent V₁ V₂) (p : IsWalk V₂ V₃) (Something here to make sure unique Vertices) : IsPath V₁ V₃
-/

--Connected
def Connected (V₁ V₂ : Vertex) : Prop := Nonempty (IsWalk G V₁ V₂)

