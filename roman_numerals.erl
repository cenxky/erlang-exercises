%% Roman Numerals
%% https://exercism.org/tracks/erlang/exercises/roman-numerals

-module(roman_numerals).

-export([roman/1]).

roman(Number) when Number >= 5000 -> error(badarg);
roman(Number) ->
    Size = length(integer_to_list(Number)),
    Base = floor(math:pow(10, Size - 1)),
    Digit = Number div Base,
    Rest = Number - Digit * Base,

    case Rest of
        0 -> roman(Digit, Base);
        _ -> roman(Digit, Base) ++ roman(Rest)
    end.

roman(Digit, Base) ->
    {One, Five} = match_base(Base),

    if
        Digit =:= 9 ->
            {Ten, _} = match_base(Base * 10),
            One ++ Ten;
        Digit > 5 -> Five ++ repeat(One, Digit - 5);
        Digit =:= 5 -> Five;
        Digit =:= 4 -> One ++ Five;
        Digit < 4 -> repeat(One, Digit)
    end.

match_base(Base) ->
    case Base of
        1 -> {"I", "V"};
        10 -> {"X", "L"};
        100 -> {"C", "D"};
        1000 -> {"M", undefined}
    end.

repeat(_Char, 0) -> "";
repeat(Char, 1) -> Char;
repeat(Char, Times) -> Char ++ repeat(Char, Times - 1).
