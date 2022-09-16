%% Triangle
%% https://exercism.org/tracks/erlang/exercises/triangle

-module(triangle).

-export([kind/3]).


kind(A, B, C) when A =< 0 orelse B =< 0 orelse C =< 0 ->
    {error, "all side lengths must be positive"};

kind(_A, _A, _A) -> equilateral;

kind(A, B, C) ->
    [TA, TB, TC] = lists:sort([A, B, C]),

    if
        TA + TB == TC -> degenerate;
        TA + TB < TC -> {error, "side lengths violate triangle inequality"};
        true ->
            case TA == TB orelse TB == TC of
                true -> isosceles;
                false -> scalene
            end
    end.
