-module(curling_scoreboard_hw).
-export([reset_board/0, add_point/1, next_round/0, set_teams/2]).

set_teams(TeamA, TeamB) ->
  io:format("the game: team ~s vs ~s~n",[TeamA,TeamB]).

next_round() ->
  io:format("the game: end of the game~n").

add_point(TeamA) ->
  io:format("the game: team points ~s are increased by 1~n",[TeamA]).

reset_board() ->
  io:format("the game: all teams are reset~n").
