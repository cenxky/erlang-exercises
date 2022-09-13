%% Raindrops
%% https://exercism.org/tracks/erlang/exercises/raindrops

-module(raindrops).

-export([convert/1]).


convert(Number) ->
    Result = lists:flatten([convert(Number, I) || I <- [3, 5, 7]]),
    case Result of
        [] -> integer_to_list(Number);
        _ -> Result
    end.

convert(Number, Factor) ->
    case Number rem Factor of
        0 ->
            case Factor of
                3 -> "Pling";
                5 -> "Plang";
                7 -> "Plong"
            end;
        _ -> []
    end.
