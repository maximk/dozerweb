-module(webdozer_app).

-behaviour(application).

%% Application callbacks
-export([start/0,start/2,stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() ->
	application:start(crypto),
	application:start(ranch),
	application:start(cowboy),
	application:start(webdozer).

start(_StartType, _StartArgs) ->

	MTypes = [{<<".pdf">>,[<<"application/pdf">>]}],

	Dispatch = cowboy_router:compile([
		{'_',[
			{"/",page_handler,[home_dtl]},
			{"/about",page_handler,[about_dtl]},
			{"/technology",page_handler,[technology_dtl]},
			{"/roadmap",page_handler,[technology_dtl]},
			{"/partners",page_handler,[partners_dtl]},
			{"/licensing",page_handler,[licensing_dtl]},
			{"/consulting",page_handler,[consulting_dtl]},
			{"/team",page_handler,[team_dtl]},
			{"/contact",page_handler,[contact_dtl]},
			{"/resources/[...]",cowboy_static,[{directory,"priv/resources"},
											   {mimetypes,MTypes}]},
			{"/ling/LICENSE",text_handler,["priv/other/LICENSE"]}
		]}
	]),

	{ok,_} = cowboy:start_http(www, 8,
		[{port,8002}],
		[{env,[{dispatch,Dispatch}]}]
	),

    webdozer_sup:start_link().

stop(_State) ->
    ok.

%%EOF
