%% Beer Song
%% https://exercism.org/tracks/erlang/exercises/beer-song

-module(beer_song).

-export([verse/1, sing/1, sing/2]).

verse(N) ->
    GetBottleOfBear = fun(Number) -> bottle_plural(Number) ++ " of beer" end,
    GetBottleOfBearOnTheWall = fun(Number) -> GetBottleOfBear(Number) ++ " on the wall" end,

    PartOne = capitalize(GetBottleOfBearOnTheWall(N)) ++ ", " ++ GetBottleOfBear(N) ++ ".\n",
    PartTwoA = case N of
        0 -> "Go to the store and buy some more";
        _ ->
            TakeUnit = case N of
                1 -> "it";
                _ -> "one"
            end,
            "Take " ++ TakeUnit ++ " down and pass it around"
    end,
    Rest = case N of
        0 -> 99;
        _ -> N - 1
    end,
    PartTwoB = GetBottleOfBearOnTheWall(Rest),
    PartTwo = PartTwoA ++ ", " ++ PartTwoB ++ ".\n",

    PartOne ++ PartTwo.

sing(N) ->
    sing(N, 0).

sing(To, To) -> verse(To) ++ "\n";
sing(From, To) -> sing(From, From) ++ sing(From - 1, To).

bottle_plural(N) ->
    case N of
        0 -> "no more bottles";
        1 -> "1 bottle";
        _ -> integer_to_list(N) ++ " bottles"
    end.

capitalize([H | T] = _Str) ->
    string:uppercase([H]) ++ T.
