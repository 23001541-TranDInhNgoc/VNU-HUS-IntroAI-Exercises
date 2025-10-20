% Create a solution for Exercise 5.9, page 89


(b)  Prolog implementation (SWI-Prolog)

:- use_module(library(clpfd)).

start :-
    % --- Declare finite domains ---
    fd_domain([Briton, Swede, Dane, Norwegian, German], 1, 5),
    fd_all_different([Briton, Swede, Dane, Norwegian, German]),

    fd_domain([Tea, Coffee, Water, Beer, Milk], 1, 5),
    fd_all_different([Tea, Coffee, Water, Beer, Milk]),

    fd_domain([Red, White, Green, Yellow, Blue], 1, 5),
    fd_all_different([Red, White, Green, Yellow, Blue]),

    fd_domain([Dog, Bird, Cat, Horse, Fish], 1, 5),
    fd_all_different([Dog, Bird, Cat, Horse, Fish]),

    fd_domain([Pallmall, Dunhill, Marlboro, Winfield, Rothmanns], 1, 5),
    fd_all_different([Pallmall, Dunhill, Marlboro, Winfield, Rothmanns]),

    % --- Logical constraints ---
    Briton    #= Red,               % The Briton lives in the red house
    Swede     #= Dog,               % The Swede keeps dogs
    Dane      #= Tea,               % The Dane drinks tea
    Green     #= White - 1,         % The green house is to the left of the white
    Green     #= Coffee,            % The owner of the green house drinks coffee
    Pallmall  #= Bird,              % The Pall Mall smoker keeps birds
    Milk      #= 3,                 % The man in the middle house drinks milk
    Yellow    #= Dunhill,           % The owner of the yellow house smokes Dunhill
    Norwegian #= 1,                 % The Norwegian lives in the first house
    dist(Marlboro, Cat) #= 1,       % The Marlboro smoker lives next to the cat owner
    dist(Horse, Dunhill) #= 1,      % The man with the horse lives next to the Dunhill smoker
    Winfield  #= Beer,              % The Winfield smoker drinks beer
    dist(Norwegian, Blue) #= 1,     % The Norwegian lives next to the blue house
    German    #= Rothmanns,         % The German smokes Rothmanns
    dist(Marlboro, Water) #= 1,     % The Marlboro smoker’s neighbor drinks water

    % --- Label variables ---
    fd_labeling([Briton, Swede, Dane, Norwegian, German]),

    % --- Output result ---
    nl, write('Solution found:'), nl,
    write('The German owns the fish.'), nl.

% Distance helper for "next to" relations
dist(A, B, D) :- D #= abs(A - B).


