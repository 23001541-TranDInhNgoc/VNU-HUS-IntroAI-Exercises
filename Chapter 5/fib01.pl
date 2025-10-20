% Create a solution for Exercise 5.8(c)

Optimized version with dynamic predicate and memoization:

    :- dynamic fib/2.
    fib(0,1).
    fib(1,1).
    fib(N,R) :-
        N1 is N - 1, fib(N1, R1),
        N2 is N - 2, fib(N2, R2),
        R is R1 + R2,
        asserta(fib(N,R)).

Explanation:
The declaration ":- dynamic fib/2" allows adding new facts during runtime.
Each computed result (fib(N,R)) is stored with asserta/1.
Next calls can directly use stored facts instead of recalculating.
