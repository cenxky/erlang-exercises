%% Bob
%% https://exercism.org/tracks/erlang/exercises/bob

-module(bob).

-export([response/1]).


response(String) ->
    Text = string:trim(String),

    case Text of
        [] -> "Fine. Be that way!";
        _ ->
            IsEndWithQuestionMark = lists:suffix("?", Text),
            ValidLetters = case re:run(Text, "[A-Za-z]+", [global, {capture, all, list}]) of
                nomatch -> [];
                {match, Capture} -> lists:flatten(Capture)
            end,

            IsAllCapital = case ValidLetters of
                [] -> false;
                _ -> lists:all(fun(I) -> I =< $Z end, ValidLetters)
            end,

            case {IsEndWithQuestionMark, IsAllCapital} of
                {true, true} -> "Calm down, I know what I'm doing!";
                {true, false} -> "Sure.";
                {false, true} -> "Whoa, chill out!";
                {false, false} -> "Whatever."
            end
    end.
