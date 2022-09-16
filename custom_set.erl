%% Custom Set
%% https://exercism.org/tracks/erlang/exercises/custom-set

-module(custom_set).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1, intersection/2, subset/2,
	 union/2]).


add(Elem, Set) ->
    case contains(Elem, Set) of
        true -> Set;
        false -> sort_collection([Elem | Set])
    end.

contains(Elem, Set) -> length([X || X <- Set, Elem == X]) > 0.

difference(Set1, Set2) ->
    Collection = [X || X <- Set1, not contains(X, Set2)],
    sort_collection(Collection).

disjoint(Set1, Set2) ->
    Collection = intersection(Set1, Set2),
    length(Collection) == 0.

empty(Set) -> Set == [].

equal(Set1, Set2) -> sort_collection(Set1) == sort_collection(Set2).

from_list(List) -> sort_collection(List).

intersection(Set1, Set2) ->
    Collection = [X || X <- Set1, contains(X, Set2)],
    sort_collection(Collection).

subset(Set1, Set2) ->
    Collection = intersection(Set1, Set2),
    length(Set1) == length(Collection).

union(Set1, Set2) ->
    Collection = difference(Set1, Set2) ++ Set2,
    sort_collection(Collection).

sort_collection([]) -> [];
sort_collection([H | T]) ->
    sort_collection([X || X <- T, X < H]) ++ [H] ++ sort_collection([X || X <- T, X >= H]).
