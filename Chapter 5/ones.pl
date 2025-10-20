% Create a solution for Exercise 5.5, page 88

p(1) :- write(1).
p(N) :- N>1, M is N//2, p(M), p(M).

?- p(1024).

