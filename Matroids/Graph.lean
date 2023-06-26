import Mathlib
set_option autoImplicit false

--Graph
structure Graph (Vertex : Type _) where 
  Vertices   : List Vertex
  Edges      : List (Vertex × Vertex)
  Adjacent   : Vertex → Vertex → Prop
  deriving Inhabited

variable {Vertex : Type _}
variable (G : Graph Vertex) 

--Loop
def Loop {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∃ (V : Vertex), V ∈ G.Vertices ∧ (V, V) ∈ G.Edges

--Adjacent
def Adjacent (V₁ V₂ : Vertex): Prop := 
  (V₁, V₂) ∈ G.Edges ∨ (V₁, V₂) ∈ G.Edges

--Walk
inductive IsWalk : Vertex → Vertex → Type u
  | Base {V₁ : Vertex} : IsWalk V₁ V₁
  | Step {V₁ V₂ V₃ : Vertex} (h : G.Adjacent V₁ V₂) (p : IsWalk V₂ V₃) : IsWalk V₁ V₃
attribute [refl] IsWalk.Base 

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
