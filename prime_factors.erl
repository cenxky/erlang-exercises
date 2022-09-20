%% Prime Factors
%% https://exercism.org/tracks/erlang/exercises/prime-factors

-module(prime_factors).

-export([factors/1]).


factors(Number) -> find_prime_factors(Number, []).

find_prime_factors(1, List) -> List;
find_prime_factors(Number, List) ->
    SqrtNumber = ceil(math:sqrt(Number)),
    FoundFactor = find_prime_factors(2, SqrtNumber, Number),

    RestNumber = Number div FoundFactor,
    NewList = [FoundFactor | List],
    find_prime_factors(RestNumber, NewList).

find_prime_factors(From, End, Number) ->
    case Number rem From of
        0 ->
            case is_prime(From) of
                true -> From;
                false -> find_prime_factors(From + 1, End, Number)
            end;
        _ ->
            case From =:= End of
                true -> Number;
                false -> find_prime_factors(From + 1, End, Number)
            end
    end.

is_prime(Number) ->
    Max = round(math:sqrt(Number)),
    is_prime(Number, Max).

is_prime(_Number, Max) when Max < 2 -> true;
is_prime(Number, Max) ->
    case Number rem Max of
        0 -> false;
        _ -> is_prime(Number, Max - 1)
    end.
