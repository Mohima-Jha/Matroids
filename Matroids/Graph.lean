import Mathlib
set_option autoImplicit false

--Graph
structure Graph (Vertex : Type)where 
  Vertices   : List Vertex
  Edges   : List (Vertex × Vertex)
deriving Repr, DecidableEq, Inhabited

--Loop
def Loop {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∃ (V : Vertex), V ∈ G.Vertices ∧ (V, V) ∈ G.Edges

--Adjacent
def Adjacent {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) (V₁ V₂ : Vertex) : Prop :=
  (V₁,V₂) ∈ G.Edges

--Walk
inductive IsWalk {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Vertex → Vertex → Prop
| base : ∀ (V : Vertex), IsWalk G V V
| step : ∀ {V₁ V₂ V₃ : Vertex}, IsWalk G V₁ V₂ → Adjacent G V₂ V₃ → IsWalk G V₁ V₃

--Path
inductive IsPath {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Vertex → Vertex → Prop
| base : ∀ (V : Vertex), IsPath G V V
| step : ∀ {V₁ V₂ V₃ : Vertex}, IsPath G V₁ V₂ → Adjacent G V₂ V₃ → IsPath G V₁ V₃

--Cycle(*)
def IsCycle  {Vertex : Type} (V₁ V₂ V₃: Vertex) [DecidableEq Vertex] (G : Graph Vertex) : Prop := 
    IsPath G V₁ V₂ → IsPath G V₂ V₃ → V₁ = V₃ 

--Connected
def Connected {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∀ (V₁ V₂ : Vertex), V₁ ∈ G.Vertices → V₂ ∈ G.Vertices → ∃ (P : IsPath G V₁ V₂), true
