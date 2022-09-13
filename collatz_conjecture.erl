%% Collatz Conjecture
%% https://exercism.org/tracks/erlang/exercises/collatz-conjecture

-module(collatz_conjecture).

-export([steps/1]).


steps(N) when N =< 0 -> error(badarg);
steps(N) -> steps(N, 0).

steps(1, Times) -> Times;
steps(N, Times) ->
    case N rem 2 of
        0 -> steps(N div 2, Times + 1);
        1 -> steps(3 * N + 1, Times + 1)
    end.
