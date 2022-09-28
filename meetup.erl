%% Meetup
%% https://exercism.org/tracks/erlang/exercises/meetup

-module(meetup).

-export([meetup/4]).


meetup(Year, Month, DayOfWeek, Week) ->
    DayMap = #{
        monday => 1,
        tuesday => 2,
        wednesday => 3,
        thursday => 4,
        friday => 5,
        saturday => 6,
        sunday => 7
    },

    LastDay = calendar:last_day_of_the_month(Year, Month),
    DatesRange = fun(From, To) ->
        lists:map(fun(Day) -> {Year, Month, Day} end, lists:seq(From, To))
    end,
    WeekRange = fun(WeekNumber) ->
        From = (WeekNumber - 1) * 7 + 1,
        To = lists:min([From + 6, LastDay]),
        DatesRange(From, To)
    end,

    WeekMap = #{
        first => fun() -> WeekRange(1) end,
        second => fun() -> WeekRange(2) end,
        third => fun() -> WeekRange(3) end,
        fourth => fun() -> WeekRange(4) end,
        fifth => fun() -> WeekRange(5) end,
        last => fun() -> DatesRange(LastDay - 6, LastDay) end,
        teenth => fun() -> DatesRange(13, 19) end
    },

    #{Week := Func} = WeekMap,
    #{DayOfWeek := DayofWeekNumber} = DayMap,

    {value, Date} = lists:search(fun(Day) ->
        {Y, M, D} = Day,
        calendar:day_of_the_week(Y, M, D) =:= DayofWeekNumber
    end, Func()),

    Date.
