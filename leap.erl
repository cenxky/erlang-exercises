%% Leap
%% https://exercism.org/tracks/erlang/exercises/leap

-module(leap).

-export([leap_year/1]).


leap_year(Year) -> Year rem 400 == 0 orelse (Year rem 4 == 0 andalso Year rem 100 =/= 0).
