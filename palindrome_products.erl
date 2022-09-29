%% Palindrome Products
%% https://exercism.org/tracks/erlang/exercises/palindrome-products

-module(palindrome_products).

-export([largest/2, smallest/2]).


largest(Min, Max) when Min > Max -> error(badarg);
largest(Min, Max) ->
    Result = get_palindrome(largest, Min, Max, {}),
    case Result of
        {} -> undefined;
        _ -> Result
    end.

smallest(Min, Max) when Min > Max -> error(badarg);
smallest(Min, Max) ->
    Result = get_palindrome(smallest, Min, Max, {}),
    case Result of
        {} -> undefined;
        _ -> Result
    end.

get_palindrome(largest, From, To, Atom) ->
    NewAtom = lists:foldl(
        fun(X, Acc) -> update_palindrome_atom(fun(A, B) -> A < B end, Acc, {To, X}) end,
        Atom,
        lists:reverse(lists:seq(From, To))
    ),
    case From =:= To of
        true -> NewAtom;
        false -> get_palindrome(largest, From, To - 1, NewAtom)
    end;
get_palindrome(smallest, From, To, Atom) ->
    NewAtom = lists:foldl(
        fun(X, Acc) -> update_palindrome_atom(fun(A, B) -> A > B end, Acc, {From, X}) end,
        Atom,
        lists:seq(From, To)
    ),
    case From =:= To of
        true -> NewAtom;
        false -> get_palindrome(smallest, From + 1, To, NewAtom)
    end.

update_palindrome_atom(WhenFun, Acc, {A, B}=Point) ->
    Value = A * B,
    case Acc of
        {} ->
            case is_palindrome(Value) of
                true -> {Value, [Point]};
                false -> Acc
            end;
        {Value, List} -> {Value, [Point | List]};
        {OldValue, _} ->
            case WhenFun(OldValue, Value) andalso is_palindrome(Value) of
                true -> {Value, [Point]};
                false -> Acc
            end
    end.

is_palindrome(Number) when Number < 10 -> true;
is_palindrome(Number) ->
    NumberStr = integer_to_list(Number),
    NumberLength = length(NumberStr),
    HalfLength = (NumberLength + 1) div 2,
    lists:all(fun(Index) ->
        lists:nth(Index, NumberStr) =:= lists:nth((NumberLength + 1 - Index), NumberStr) end,
        lists:seq(1, HalfLength)
    ).
