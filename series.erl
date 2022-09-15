%% Series
%% https://exercism.org/tracks/erlang/exercises/series

-module(series).

-export([slices/2]).


slices(SliceLength, Series) ->
    case {SliceLength, SliceLength > length(Series)} of
        {0, _} -> error("slice length cannot be zero");
        {_, true} -> error("slice length is too large");
        _ -> series_slices(SliceLength, Series)
    end.

series_slices(SliceLength, Series) when length(Series) < SliceLength -> [];
series_slices(SliceLength, Series) ->
    [_ | Rest] = Series,
    SlicedStr = string_slice(Series, SliceLength),
    [SlicedStr | series_slices(SliceLength, Rest)].

%% Sample implement like string:slice
string_slice(_Series, 0) -> [];
string_slice([H | T] = _Series, N) ->
    [H | string_slice(T, N - 1)].
