-module(mc_erl_app).
-export([setup/0, start/2, stop/1, os_setup/0, os_run/0]).

%% initial server setup, needs to be done only once
setup() ->
	mc_erl_chunk_manager:setup().

start(_StartType, _StartArgs) -> mc_erl_server_sup:start_link().

stop(_State) -> mc_erl_server_sup:shutdown().

%% to be called from OS' command line
os_setup() ->
	io:format("~p~n", [mnesia:create_schema([node()])]),
	mnesia:start(),
	io:format("~p~n", [mc_erl_chunk_manager:setup()]),
	mnesia:stop(),
	halt().

%% to be called from OS' command line
os_run() ->
	mnesia:start(),
	ok = application:start(mc_erl).
