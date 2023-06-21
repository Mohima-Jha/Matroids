import Mathlib
set_option autoImplicit false

structure Graph (Vertex : Type)[DecidableEq Vertex]where 
  Vertices   : List Vertex
  Edges   : List (Vertex × Vertex)

def Loop {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∃ (V : Vertex), V ∈ G.Vertices ∧ (V, V) ∈ G.Edges

def Adjacent {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) (V₁ V₂ : Vertex) : Prop :=
  (V₁,V₂) ∈ G.Edges

inductive Walk {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Vertex → Vertex → Prop
| base : ∀ (V : Vertex), Walk G V V
| step : ∀ {V₁ V₂ V₃ : Vertex}, Walk G V₁ V₂ → Adjacent G V₂ V₃ → Walk G V₁ V₃

inductive GPath {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Vertex → Vertex → Prop
| base : ∀ (V : Vertex), GPath G V V
| step : ∀ {V₁ V₂ V₃ : Vertex}, GPath G V₁ V₂ → Adjacent G V₂ V₃ → GPath G V₁ V₃

def Connected {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∀ (V₁ V₂ : Vertex), V₁ ∈ G.Vertices → V₂ ∈ G.Vertices → ∃ (P : GPath G V₁ V₂), true

variable (Vertex : Type)
variable (G : Graph Vertex)

theorem Graphic_Matroid (α : Type _)[DecidableEq α](M : Matroid α): sorry :=
  sorry 

