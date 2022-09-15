%% Difference Of Squares
%% https://exercism.org/tracks/erlang/exercises/difference-of-squares

-module(difference_of_squares).

-export([difference_of_squares/1, square_of_sum/1, sum_of_squares/1]).


difference_of_squares(Number) ->
    square_of_sum(Number) - sum_of_squares(Number).

square_of_sum(Number) ->
    Total = sum(fun(N) -> N end, Number),
    Total * Total.

sum_of_squares(Number) ->
    sum(fun(N) -> N * N end, Number).

sum(_Fn, 0) -> 0;
sum(Fn, N) -> Fn(N) + sum(Fn, N - 1).
