% Module info
-module(client).
-export([start/0, client/2]).
% Start function with default parameters
start() ->
  client("127.0.0.1", 2000).
% Client setup
client(Host, Port) ->
  % Open TCP socket
  {ok, Socket} = gen_tcp:connect(Host, Port, [binary, {active, true}, {packet, raw}]),
  % Enter the loop
  loop(Socket).
% Read char from user
read_char() ->
  Inp = string:trim(io:get_line("Input a char: ")),
  Len = string:length(Inp),
  if
    Len /= 1 ->
      io:format("Input must be a char~n"),
      read_char();
    true ->
      ok
  end,
  Inp.
% Get response from server and print it
get_response(Socket) ->
  receive
    {tcp, Socket, Msg} ->
      FMsg = string:trim(Msg),
      io:format("Received message: ~p~n", [FMsg]),
      loop(Socket)
  end.
% Main event loop
loop(Socket) ->
  % Get char from user
  Chr = read_char(),
  % Send it via TCP
  gen_tcp:send(Socket, list_to_binary(Chr)),
  % Get the response
  get_response(Socket).
