import Mathlib
set_option autoImplicit false

structure Graph (Vertex : Type)[DecidableEq Vertex]where 
  Vertices   : List Vertex
  Edges   : List (Vertex × Vertex)

def Loop {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∃ (V : Vertex), V ∈ G.Vertices ∧ (V, V) ∈ G.Edges

def Adjacent {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) (V₁ V₂ : Vertex) : Prop :=
  (V₁,V₂) ∈ G.Edges

def GWalk {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : List Vertex → Prop
| []         => true
| [_]        => true
| (x::y::xs) => Adjacent G x y ∧ GWalk G (y::xs)

def GPath {Vertex : Type} [DecidableEq Vertex] (G : Graph Vertex) : List Vertex → Prop
| []         => true
| [_]        => true
| (x::y::xs) => Adjacent G x y ∧ ¬(x ∈ xs) ∧ GPath G (y::xs)

def Connected {Vertex : Type}  [DecidableEq Vertex] (G : Graph Vertex) : Prop :=
  ∀ (v₁ v₂ : Vertex), v₁ ∈ G.Vertices → v₂ ∈ G.Vertices → v₁ ≠ v₂ → GPath G [v₁, v₂]

