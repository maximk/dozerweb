-module(page_handler).
-export([init/3]).
-export([handle/2,terminate/3]).

init({tcp,http}, Req, [Template]) ->
	{ok,Req,{Template}}.

handle(Req, {Template} =St) ->
	{ok,Body} = Template:render([]),
	{ok,Reply} = cowboy_req:reply(200, [], Body, Req),
	{ok,Reply,St}.

terminate(_What, _Req, _St) ->
	ok.

%%EOF

