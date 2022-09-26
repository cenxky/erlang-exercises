%% Anagram
%% https://exercism.org/tracks/erlang/exercises/anagram

-module(anagram).

-export([find_anagrams/2]).


find_anagrams(Subject, Candidates) ->
    lists:filter(fun(X) -> isAnagram(Subject, X) end, Candidates).

isAnagram(Subject, Candidate) ->
    length(Subject) =:= length(Candidate) andalso
    string:lowercase(Subject) =/= string:lowercase(Candidate) andalso
    anagram_meta(Subject) =:= anagram_meta(Candidate).

anagram_meta(Word) ->
    anagram_meta(Word, #{}).

anagram_meta([], Map) -> Map;
anagram_meta([H | T] = _Word, Map) ->
    Key = string:lowercase([H]),
    NewMap = case Map of
        #{Key := Value} -> Map#{Key := Value + 1};
        #{} -> Map#{Key => 1}
    end,
    anagram_meta(T, NewMap).
