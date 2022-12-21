program client;

{Import library}
uses
  sockets;
{Declare variables}
var
  Socket: LongInt;
  Address: TInetSockAddr;
  Sin, Sout: Text;
  Buffer: String;

begin
  {Create socket}
  Socket := fpSocket (AF_INET, SOCK_STREAM, 0);
  Address.sin_family := AF_INET;
  Address.sin_port := htons(2000);
  Address.sin_addr.s_addr := HostToNet((127 shl 24) or 1);
  {Connect to socket and check that connection was successful}
  if not Connect (Socket, Address, Sin, Sout) then
  begin
    WriteLn('Connection refused');
    Halt(100);
  end;
  Reset(Sin);
  ReWrite(Sout);
  {Loop}
  while True do
  begin
    while True do
    begin
      WriteLn('Input a char: ');
      {Read user input}
      ReadLn(Buffer);
      if not Length(Buffer) = 1 then
      begin
        WriteLn('Input must be a char');
        Continue;
      end;
      Break;
    end;
    {Write user input to server}
    WriteLn(Sout, Buffer);
    {Read server response}
    ReadLn(Sin, Buffer);
    {Print it}
    WriteLn('Received char: ', Buffer);
  end;
  Close(Sout);
end.
