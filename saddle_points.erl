%% Saddle Points
%% https://exercism.org/tracks/erlang/exercises/saddle-points

-module(saddle_points).

-export([saddle_points/1]).

saddle_points(Matrix) ->
    get_saddle_points(Matrix, 0, []).

get_saddle_points(Matrix, End, List) when End =:= length(Matrix) -> List;
get_saddle_points(Matrix, From, List) ->
    Row = lists:nth(From + 1, Matrix),
    Next = From + 1,

    case Row of
        [] -> get_saddle_points(Matrix, Next, List);
        _ ->
            Max = lists:max(Row),
            RowWithIndex = lists_enumerate(Row),

            Result = lists:filtermap(fun({Index, Ele}) ->
                case Ele =:= Max of
                    true ->
                        Min = get_min_of_column(Index, Matrix),
                        case Ele =:= Min of
                            true -> { true, {From, Index} };
                            _ -> false
                        end;
                    _ -> false
                end
            end, RowWithIndex),

            get_saddle_points(Matrix, Next, List ++ Result)
    end.

get_min_of_column(Index, Matrix) ->
    List = lists:map(fun(X) -> lists:nth(Index + 1, X) end, Matrix),
    lists:min(List).

lists_enumerate(List) -> lists:reverse(lists_enumerate(List, 0, [])).

lists_enumerate([], _Index, List) -> List;
lists_enumerate([H | T], Index, List) -> lists_enumerate(T, Index + 1, [{Index, H} | List]).
