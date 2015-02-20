%%
%% Licensed to the Apache Software Foundation (ASF) under one
%% or more contributor license agreements. See the NOTICE file
%% distributed with this work for additional information
%% regarding copyright ownership. The ASF licenses this file
%% to you under the Apache License, Version 2.0 (the
%% "License"); you may not use this file except in compliance
%% with the License. You may obtain a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied. See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%

-module(thrift_https_transport).

-behaviour(thrift_transport).

%% API
-export([new/2, new/3]).

%% thrift_transport callbacks
-export([write/2, read/2, flush/1, close/1]).

-record(https_transport, {host, % string()
                         path, % string()
                         read_buffer, % iolist()
                         write_buffer, % iolist()
                         http_options, % see http(3)
                         extra_headers % [{str(), str()}, ...]
                        }).
-type state() :: #https_transport{}.
-include("thrift_transport_behaviour.hrl").

new(Host, Path) ->
    new(Host, Path, _Options = []).

%%--------------------------------------------------------------------
%% Options include:
%%   {http_options, HttpOptions}  = See http(3)
%%   {extra_headers, ExtraHeaders}  = List of extra HTTP headers
%%--------------------------------------------------------------------
new(Host, Path, Options) ->
    State1 = #https_transport{host = Host,
                             path = Path,
                             read_buffer = [],
                             write_buffer = [],
                             http_options = [],
                             extra_headers = []},
    ApplyOption =
        fun
            ({http_options, HttpOpts}, State = #https_transport{}) ->
                State#https_transport{http_options = HttpOpts};
            ({extra_headers, ExtraHeaders}, State = #https_transport{}) ->
                State#https_transport{extra_headers = ExtraHeaders};
            (Other, #https_transport{}) ->
                {invalid_option, Other};
            (_, Error) ->
                Error
        end,
    case lists:foldl(ApplyOption, State1, Options) of
        State2 = #https_transport{} ->
            thrift_transport:new(?MODULE, State2);
        Else ->
            {error, Else}
    end.

%% Writes data into the buffer
write(State = #https_transport{write_buffer = WBuf}, Data) ->
    {State#https_transport{write_buffer = [WBuf, Data]}, ok}.

%% Flushes the buffer, making a request
flush(State = #https_transport{host = Host,
                                 path = Path,
                                 read_buffer = Rbuf,
                                 write_buffer = Wbuf,
                                 http_options = HttpOptions,
                                 extra_headers = ExtraHeaders}) ->
    case iolist_to_binary(Wbuf) of
        <<>> ->
            %% Don't bother flushing empty buffers.
            {State, ok};
        WBinary ->
            {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} =
              httpc:request(post,
                           {"https://" ++ Host ++ Path,
                            [{"User-Agent", "Erlang/thrift_https_transport"} | ExtraHeaders],
                            "application/x-thrift",
                            WBinary},
                           HttpOptions,
                           [{body_format, binary}]),

            State1 = State#https_transport{read_buffer = [Rbuf, Body],
                                          write_buffer = []},
            {State1, ok}
    end.

close(State) ->
    {State, ok}.

read(State = #https_transport{read_buffer = RBuf}, Len) when is_integer(Len) ->
    %% Pull off Give bytes, return them to the user, leave the rest in the buffer.
    Give = min(iolist_size(RBuf), Len),
    case iolist_to_binary(RBuf) of
        <<Data:Give/binary, RBuf1/binary>> ->
            Response = {ok, Data},
            State1 = State#https_transport{read_buffer=RBuf1},
            {State1, Response};
        _ ->
            {State, {error, 'EOF'}}
    end.
