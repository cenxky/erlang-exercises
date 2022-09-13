%% Two Fer
%% https://exercism.org/tracks/erlang/exercises/two-fer/edit

-module(two_fer).

-export([two_fer/0, two_fer/1]).


two_fer() -> "One for you, one for me.".

two_fer(Name) -> lists:flatten(io_lib:format("One for ~s, one for me.", [Name])).
