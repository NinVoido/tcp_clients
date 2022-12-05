program client;

uses
  sockets;

var
  Socket: LongInt;
  Address: TInetSockAddr;
  Sin, Sout: Text;
  Buffer: String;

begin
  Socket := fpSocket (AF_INET, SOCK_STREAM, 0);
  Address.sin_family := AF_INET;
  Address.sin_port := htons(2000);
  Address.sin_addr.s_addr := HostToNet((127 shl 24) or 1);
  if not Connect (Socket, Address, Sin, Sout) then
  begin
    WriteLn('Connection refused');
    Halt(100);
  end;
  Reset(Sin);
  ReWrite(Sout);

  while True do
  begin
    while True do
    begin
      WriteLn('Input a char: ');
      ReadLn(Buffer);
      if not Length(Buffer) = 1 then
      begin
        WriteLn('Input must be a char');
        Continue;
      end;
      Break;
    end;
    WriteLn(Sout, Buffer);
    ReadLn(Sin, Buffer);
    WriteLn(Buffer);
  end;
  Close(Sout);
end.
