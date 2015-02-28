-module(fsm_sup).
-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  Flags = {one_for_one, 5, 10},
  FsmWorker = {fsm_worker, {fsm_worker, start_link,[]}, permanent, 2000, supervisor,[fsm_worker]},
  {ok, { Flags , [FsmWorker]} }.

