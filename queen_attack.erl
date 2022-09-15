%% Queen Attack
%% https://exercism.org/tracks/erlang/exercises/queen-attack

-module(queen_attack).

-export([can_attack/2]).


can_attack({Wx, Wy} = _WhiteQueen, {Bx, By} = _BlackQueen) ->
    YDist = By - Wy,
    XDist = Bx - Wx,

    if
        XDist == 0 orelse YDist == 0 -> true;
        abs(YDist) == abs(XDist) -> true;
        true -> false
    end.
