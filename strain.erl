%% Strain
%% https://exercism.org/tracks/erlang/exercises/strain

-module(strain).

-export([keep/2, discard/2]).


keep(Fn, List) -> filter(Fn, List).

discard(Fn, List) -> filter(fun(I) -> not Fn(I) end, List).

% Sample implement of list:filter
filter(_Fn, []) -> [];
filter(Fn, [H|T]) ->
    case Fn(H) of
        true -> [H|filter(Fn, T)];
        false -> filter(Fn, T)
    end.
