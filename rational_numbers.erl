%% Rational Numbers
%% https://exercism.org/tracks/erlang/exercises/rational-numbers

-module(rational_numbers).

-export([absolute/1, add/2, divide/2, exp/2, mul/2, reduce/1, sub/2]).


absolute({A, B} = _R) -> reduce({abs(A), abs(B)}).

add({A1, B1} = _R1, {A2, B2} = _R2) -> reduce({A1 * B2 + A2 * B1, B1 * B2}).

divide({A1, B1} = _R1, {A2, B2} = _R2) -> reduce({A1 * B2, B1 * A2}).

exp({A, B} = _Base, Exponent) ->
    case Exponent >= 0 of
        true -> reduce({trunc(math:pow(A, Exponent)), trunc(math:pow(B, Exponent))});
        false -> reduce({trunc(math:pow(B, abs(Exponent))), trunc(math:pow(A, abs(Exponent)))})
    end;
exp(Base, {A, B} = _Exponent) ->
    case A / B >= 0 of
        true -> math:pow(math:pow(Base, A), 1 / B);
        false ->
            {RA, RB} = absolute({A, B}),
            math:pow(math:pow(1 / Base, RA), 1 / RB)
    end.

mul({A1, B1} = _R1, {A2, B2} = _R2) -> reduce({A1 * A2, B1 * B2}).

reduce({A, B} = _R) ->
    GCD = gcd(A, B),
    FinalA = A div GCD,
    FinalB = B div GCD,
    case A / B > 0 of
        true -> {abs(FinalA), abs(FinalB)};
        false -> {-abs(FinalA), abs(FinalB)}
    end.

sub({A1, B1} = _R1, {A2, B2} = _R2) -> reduce({A1 * B2 - A2 * B1, B1 * B2}).

gcd(N, M) ->
    [Min, Max] = lists:sort([abs(N), abs(M)]),
    case Min of
        0 -> Max;
        _ ->
            RemResult = Max rem Min,
            case RemResult of
                0 -> Min;
                _ -> gcd(Min, RemResult)
            end
    end.
