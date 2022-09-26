%% Sieve
%% https://exercism.org/tracks/erlang/exercises/sieve

-module(sieve).

-export([primes/1]).


primes(Limit) ->
    Seq = lists:reverse(lists:seq(2, Limit)),
    CompositeNumbersMap = lists:foldl(fun(Number, Map) ->
        get_composites_map(Number, 1, Limit, Map)
    end, #{}, Seq),

    lists:foldl(fun(Number, List) ->
        case CompositeNumbersMap of
            #{Number := true} -> List;
            _ -> [Number | List]
        end
    end, [], Seq).

get_composites_map(Base, Times, End, Map) when Base * Times > End -> Map;
get_composites_map(Base, Times, End, Map) ->
    Number = Base * Times,
    case Map of
        #{Number := true} -> get_composites_map(Base, Times + 1, End, Map);
        _ ->
            case Times =:= 1 of
                true -> get_composites_map(Base, Times + 1, End, Map);
                false -> get_composites_map(Base, Times + 1, End, Map#{Number => true})
            end
    end.
