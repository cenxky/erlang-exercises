%% Hamming
%% https://exercism.org/tracks/erlang/exercises/hamming

-module(hamming).

-export([distance/2]).


distance(Strand1, Strand2) ->
    case length(Strand1) == length(Strand2) of
        true -> distance(Strand1, Strand2, 0);
        false -> {error, badarg}
    end.

distance([], [], N) -> N;
distance([H1|T1], [H2|T2], N) ->
    case H1 == H2 of
        true -> distance(T1, T2, N);
        false -> distance(T1, T2, N + 1)
    end.
