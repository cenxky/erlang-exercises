%% Darts
%% https://exercism.org/tracks/erlang/exercises/darts

-module(darts).

-export([score/2]).


score(X, Y) ->
    Dist = math:sqrt(X * X + Y * Y),

    if
        Dist =< 1 -> 10;
        Dist =< 5 -> 5;
        Dist =< 10 -> 1;
        true -> 0
    end.
