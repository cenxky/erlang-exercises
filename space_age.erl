%% Space Age
%% https://exercism.org/tracks/erlang/exercises/space-age

-module(space_age).

-export([age/2]).


age(Planet, Seconds) ->
    Mapping = #{
        mercury => 0.2408467,
        venus => 0.61519726,
        earth => 1.0,
        mars => 1.8808158,
        jupiter => 11.862615,
        saturn => 29.447498,
        uranus => 84.016846,
        neptune => 164.79132
    },

    Unit = maps:get(Planet, Mapping),
    SecondsOfYear = 31557600,
    Seconds / SecondsOfYear / Unit.
