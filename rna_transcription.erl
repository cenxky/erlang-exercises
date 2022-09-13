%% Rna Transcription
%% https://exercism.org/tracks/erlang/exercises/rna-transcription

-module(rna_transcription).

-export([to_rna/1]).


to_rna([]) -> [];
to_rna(Strand) ->
    lists:map(
        fun(N) ->
            case N of
                $G -> $C;
                $C -> $G;
                $T -> $A;
                $A -> $U
            end
        end
    , Strand).
