%% Diamond
%% https://exercism.org/tracks/erlang/exercises/diamond

-module(diamond).

-export([rows/1]).


rows(Letter) ->
    BasicChar = $A,
    [Char | _] = Letter,
    Rows = render_rows(BasicChar, Char, []),
    ReflectedRows = lists:reverse(lists:droplast(Rows)),
    Rows ++ ReflectedRows.

render_rows(Char, TargetChar, List) ->
    if
        Char > TargetChar -> lists:reverse(List);
        true ->
            BasicChar = $A,
            Length = (TargetChar - BasicChar) * 2 + 1, % Row length
            Position = TargetChar - Char + 1,
            Result = render_row(0, Char, Length, Position, []),
            render_rows(Char + 1, TargetChar, [Result | List])
    end.

render_row(Index, Char, Length, Position, List) ->
    if
        Index == Length -> List;
        Index + 1 == Position orelse Length - Index == Position ->
            render_row(Index + 1, Char, Length, Position, [Char | List]);
        true ->
            render_row(Index + 1, Char, Length, Position, [32 | List]) % 32 means empty space
    end.
