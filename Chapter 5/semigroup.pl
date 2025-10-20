% Create a solution for Exercise 5.1, page 88. More precisely, you will attempt to prove the equality of left- and right-neutral elements of semigroups with PROLOG and fail. Try to explain why?

Exercise 5.1 — PROLOG Stack Overflow and Semigroup Equality
------------------------------------------------------------

(a) Description
We attempt to prove the theorem from Section 3.7:

"If a semigroup has both a left-neutral element e_l and a right-neutral element e_r,
then e_l = e_r."

This is modeled in PROLOG as follows:

    m(X, Y).

    assoc(X, Y, Z) :- m(m(X,Y),Z) = m(X,m(Y,Z)).

    left_neutral(E_l, X) :- m(E_l, X) = X.
    right_neutral(E_r, X) :- m(X, E_r) = X.

    prove_equal(E_l, E_r) :-
        left_neutral(E_l, X),
        right_neutral(E_r, X),
        E_l = E_r.

Running the query:
    ?- prove_equal(El, Er).
causes PROLOG to signal a **stack overflow**.

------------------------------------------------------------
(b) Explanation

Reason for the stack overflow:

1. PROLOG uses **depth-first search** to resolve predicates.
   It always chooses the first unifiable clause in the input file.
   When recursive definitions such as `m/2` and `assoc/3` refer
   back to each other without a base case, this creates **infinite recursion**.

2. PROLOG’s built-in equality “=” only performs **syntactic matching**.
   It cannot reason about mathematical equality as in predicate calculus.
   Therefore, PROLOG repeatedly tries to expand `m/2` without success.

3. Because no terminating condition or concrete facts exist, the system
   keeps expanding the same clauses, leading to **stack overflow**.

------------------------------------------------------------
(c) Nature of the error

This is not a syntax error but a **semantic failure**.
The depth-first inference mechanism of PROLOG loops indefinitely when
faced with non-terminating recursive clauses.

------------------------------------------------------------
(d) Theoretical cause

PROLOG does not include:
   • Equality axioms (reflexivity, symmetry, transitivity)
   • Paramodulation or substitution inference
   • Full resolution calculus with equality

Therefore, it cannot prove logical theorems involving equality on its own.

------------------------------------------------------------
(e) Conclusion and remedy

PROLOG cannot prove this theorem because its inference system is limited
to Horn clauses and syntactic equality. The correct approach is to use
an **automated theorem prover with equality reasoning**, such as:

   • E Prover
   • Vampire
   • Otter / Prover9

These systems support paramodulation and resolution with equality and
can successfully prove the theorem without infinite recursion.

------------------------------------------------------------
Summary Table:

| Aspect | Observation | Explanation |
|---------|--------------|-------------|
| Phenomenon | Stack overflow in PROLOG | Infinite recursion during DFS |
| Cause | Depth-first search + no termination | Recursive expansion of m/2 |
| Missing feature | Equality reasoning | PROLOG lacks substitution rules |
| Solution | Use E or Vampire prover | They handle equality properly |

------------------------------------------------------------
Short summary for report:

PROLOG signals a stack overflow because its depth-first search
always selects the first unifiable clause recursively. With
recursive predicates like equality and without a termination
condition, this causes a non-terminating recursion.
Hence, the proof of equality between left- and right-neutral
elements of semigroups fails.
------------------------------------------------------------


