-module(text_handler).
-export([init/3]).
-export([handle/2,terminate/3]).

init({tcp,http}, Req, [MyFile]) ->
	{ok,Req,{MyFile}}.

handle(Req, {MyFile} =St) ->
	{ok,Data} = file:read_file(MyFile),
	{ok,Reply} = cowboy_req:reply(200, [], Data, Req),
	{ok,Reply,St}.

terminate(_What, _Req, _St) ->
	ok.

%%EOF

