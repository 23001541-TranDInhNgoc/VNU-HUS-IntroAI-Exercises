% Create a solution for Exercise 5.8(a)

The naive definition of the Fibonacci function in Prolog:

    fib(0,1).
    fib(1,1).
    fib(N,R) :-
        N1 is N - 1, fib(N1, R1),
        N2 is N - 2, fib(N2, R2),
        R is R1 + R2.

Explanation:
Each call to fib/2 generates two recursive subcalls.
The recursion tree grows exponentially because many subresults are recomputed.
