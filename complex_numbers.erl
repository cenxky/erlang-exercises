%% Complex Numbers
%% https://exercism.org/tracks/erlang/exercises/complex-numbers

-module(complex_numbers).

-export([abs/1, add/2, conjugate/1, divide/2, equal/2, exp/1, imaginary/1, mul/2, new/2,
	 real/1, sub/2]).

abs({R, I} = _Z) -> math:sqrt(R * R + I * I).

add({R1, I1} = _Z1, {R2, I2} = _Z2) -> new(R1 + R2, I1 + I2).

conjugate({R, I} = _Z) -> new(R, -I).

divide({R1, I1} = _Z1, {R2, I2} = _Z2) -> new(
    (R1 * R2 + I1 * I2)/(R2 * R2 + I2 * I2),
    (I1 * R2 - R1 * I2)/(R2 * R2 + I2 * I2)
).

equal({R1, I1} = _Z1, {R2, I2} = _Z2) -> R1 == R2 andalso erlang:abs(I2 - I1) =< 0.005.

exp({R, I} = _Z) ->
    mul(
        new(math:exp(R), 0),
        new(math:cos(I), math:sin(I))
    ).

imaginary({_R, I} = _Z) -> I.

mul({R1, I1} = _Z1, {R2, I2} = _Z2) -> new(R1 * R2 - I1 * I2, I1 * R2 + R1 * I2).

new(R, I) -> {R, I}.

real({R, _I} = _Z) -> R.

sub({R1, I1} = _Z1, {R2, I2} = _Z2) -> new(R1 - R2, I1 - I2).
