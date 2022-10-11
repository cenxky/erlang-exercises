%% Minesweeper
%% https://exercism.org/tracks/erlang/exercises/minesweeper

-module(minesweeper).

-export([annotate/1]).


annotate(Minefield) ->
    lists:map(fun(RowIndex) ->
        transform_row(RowIndex, Minefield)
    end, lists:seq(1, length(Minefield))).

transform_row(RowIndex, Minefield) ->
    Row = lists:nth(RowIndex, Minefield),
    Result = lists:map(fun (ColumnIndex) ->
        transform_item(RowIndex, ColumnIndex, Minefield)
    end, lists:seq(1, length(Row))),
    lists:flatten(Result).

transform_item(RowIndex, ColumnIndex, Minefield) ->
    Row = lists:nth(RowIndex, Minefield),
    Item = lists:nth(ColumnIndex, Row),
    [Space] = " ", %% 32
    case Item of
        Space ->
            Total = count_mines_for_item(RowIndex, ColumnIndex, Minefield),
            case Total of
                0 -> Space;
                _ -> integer_to_list(Total)
            end;
        _ -> Item
    end.

count_mines_for_item(RowIndex, ColumnIndex, Minefield) ->
    Row = lists:nth(RowIndex, Minefield),
    Points = [{R, C} || R <- [RowIndex - 1, RowIndex, RowIndex + 1],
                        C <- [ColumnIndex - 1, ColumnIndex, ColumnIndex + 1],
                        R > 0, R =< length(Minefield),
                        C > 0, C =< length(Row)],
    lists:foldl(fun({R, C}, Count) ->
        PickRow = lists:nth(R, Minefield),
        Item = lists:nth(C, PickRow),
        case Item of
            $* -> Count + 1;
            _ -> Count
        end
    end, 0, Points).
