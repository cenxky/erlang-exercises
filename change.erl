%% Change
%% https://exercism.org/tracks/erlang/exercises/change

-module(change).

-export([find_fewest_coins/2]).


%% It's not a perfect solution, need some optimizations.
%% TODO: redo by using dp(dynamic programming).
find_fewest_coins(Target, _Coins) when Target < 0 -> error(badarg);
find_fewest_coins(Target, _Coins) when Target =:= 0 -> [];
find_fewest_coins(Target, Coins) ->
    AvaiableCoins = lists:filter(fun(X) -> Target >= X end, Coins),
    Map = find_fewest_coins(Target, AvaiableCoins, #{}),
    case Map of
        #{Target := Value} -> Value;
        #{} -> undefined
    end.

find_fewest_coins(_Target, [], Map) -> Map;
find_fewest_coins(Target, Coins, Map) ->
    [H | T] = Coins,
    find_fewest_coins_for_digit(H, H, Target, T, Map).

find_fewest_coins_for_digit(_Base, CurrentTarget, Target, Coins, Map) when CurrentTarget > Target ->
    find_fewest_coins(Target, Coins, Map);
find_fewest_coins_for_digit(Base, CurrentTarget, Target, Coins, Map) ->
    MaxTimes = CurrentTarget div Base,
    NewMap = lists:foldl(fun(Times, Acc) ->
        Rest = CurrentTarget - Base * Times,
        Result = case Rest of
            0 ->
                lists:duplicate(Times, Base);
            _ ->
                case Acc of
                    #{Rest := Value} -> Value ++ lists:duplicate(Times, Base);
                    #{} -> []
                end
        end,

        case length(Result) > 0 of
            true ->
                case Acc of
                    #{CurrentTarget := List} ->
                        NewList = get_shorter_list(Result, List),
                        Acc#{CurrentTarget := NewList};
                    #{} ->
                        Acc#{CurrentTarget => Result}
                end;
            false -> Acc
        end
    end, Map, lists:seq(1, MaxTimes)),
    find_fewest_coins_for_digit(Base, CurrentTarget + 1, Target, Coins, NewMap).

get_shorter_list(List1, List2) ->
    List1Length = length(List1),
    List2Length = length(List2),

    case {List1Length, List2Length} of
        {_, 0} -> List1;
        {0, _} -> List2;
        {_, _} ->
            case List1Length >= List2Length of
                true -> List2;
                false -> List1
            end
    end.
