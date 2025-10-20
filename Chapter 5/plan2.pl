% Create a solution for Exercises 5.2 and 5.3, page 88 using plan.pl

% Exercise 5.2
% ==========================

% (a) write_move(+State1, +State2)
write_move(state(F1,W1,G1,C1), state(F2,W2,G2,C2)) :-
    % xác định hướng di chuyển
    (F1 = left, F2 = right -> Dir = 'from left to right'
    ; F1 = right, F2 = left -> Dir = 'from right to left'),
    % xác định Farmer đi với ai
    (W1 \= W2 -> Thing = 'wolf'
    ; G1 \= G2 -> Thing = 'goat'
    ; C1 \= C2 -> Thing = 'cabbage'
    ; Thing = 'alone'),
    % in ra thông điệp
    (Thing = 'alone' ->
        format('Farmer crosses ~w.~n', [Dir])
    ;
        format('Farmer and ~w cross ~w.~n', [Thing, Dir])).

% (b) write_path(+Path)
write_path([_]).
write_path([S1, S2 | Rest]) :-
    write_move(S1, S2),
    write_path([S2 | Rest]).



% Exercise 5.3
% ==========================

(a)
At first glance, the variable 'Path' in the predicate plan/4 seems unnecessary
because it appears not to change. However, it is needed to output the solutions found.

In the clause:
    plan(Goal, Goal, Path, Path).
the unification of the two 'Path' variables ensures that the sequence of visited
states is passed back when the goal is reached. This allows the program to print
the entire solution path using 'write_path(Path)'.

Therefore, 'Path' is essential to:
  • Keep track of all visited states (the path of the solution).
  • Output the final sequence of moves once the goal is reached.

Without 'Path', the program could find a valid goal state but could not display
the steps that lead to it.

------------------------------------------------------------
(b)
If we add a 'fail' at the end of 'action/2', as in:

    action(Start,Goal) :-
        plan(Start,Goal,[Start],Path),
        nl, write('Solution:'), nl,
        write_path(Path), fail.

then Prolog will backtrack after printing a solution to search for others.
Because the conditions in the predicate 'safe/1' overlap, Prolog can re-enter
alternative clauses of 'safe', finding the same solution again.

This causes every valid solution to be printed twice.

------------------------------------------------------------
Reason:
The clauses of 'safe/1' are overlapping:

    safe(state(B,W,Z,K)) :- across(W,Z), across(Z,K).
    safe(state(B,B,B,K)).
    safe(state(B,W,B,B)).

During backtracking, Prolog reuses these multiple matching rules for the same
safe state, producing duplicate outputs.

------------------------------------------------------------
How to prevent duplicates:

1. Add a cut '!' at the end of the first two 'safe/1' clauses:
    safe(state(B,W,Z,K)) :- across(W,Z), across(Z,K), !.
    safe(state(B,B,B,K)) :- !.
    safe(state(B,W,B,B)).

   This prevents Prolog from backtracking into overlapping rules.

2. Alternatively, define all safe states explicitly, for example:
    safe(state(left,left,left,right)).

Both methods ensure that each solution is printed only once.

------------------------------------------------------------
Summary Table:

| Part | Observation | Explanation |
|------|--------------|-------------|
| (a)  | 'Path' variable is required | Tracks and outputs full solution path |
| (b)  | 'fail' causes double printing | Overlapping 'safe/1' clauses trigger repeated backtracking |
| Fix  | Add cuts '!' or define safe states explicitly | Eliminates duplicate solutions |

------------------------------------------------------------



