-module(curling_accumulator).
-behaviour(gen_event).
-export([init/1, handle_event/2, handle_call/2, handle_info/2, code_change/3, terminate/2]).
-record(state,{teams=orddict:new(), round=0}).

init([])                -> {ok, #state{}}.

handle_event({set_teams, TeamA, TeamB}, State=#state{teams = T}) ->
  Teams = orddict:store(TeamA, 0, orddict:store(TeamB, 0, T)),
  {ok, State#state{teams = Teams}};
handle_event({add_points, Team, N}, State=#state{teams = T}) ->
  Teams = orddict:update_counter(Team, N, T),
  {ok, State#state{teams = Teams}};
handle_event(next_round, State=#state{}) ->
  {ok, State#state{round = State#state.round+1}};
handle_event(_Event, State=#state{}) ->
  {ok, State}.

handle_call(game_data, State=#state{teams = T, round = R})    -> 
  {ok, {orddict:to_list(T), {round, R}}, State};
handle_call(_,State)    -> {ok, ok, State}.
handle_info(_,State)    -> {ok, State}.
code_change(_,State,_)  -> {ok, State}.
terminate(_,_)          -> ok.