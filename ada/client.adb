with Ada.Text_IO;  use Ada.Text_IO;
with GNAT.Sockets;  use GNAT.Sockets;

procedure Client is
  Client        : Socket_Type;
  S             : String (1 .. 3);
  Last          : Integer;
  Channel       : GNAT.Sockets.Stream_Access;
begin
  Initialize;
  Create_Socket  (Socket => Client);
  Connect_Socket (Socket => Client,
                  Server => (Family => Family_Inet,
                             Addr   => Inet_Addr ("127.0.0.1"),
                             Port   => 2000));
  Channel := GNAT.Sockets.Stream (Client);
  loop
    Put("Input a char: ");
    Get_Line(S, Last);
    Character'Output (Channel, S(1));
    
    Put(String'Input (Channel));
  end loop;
end Client;
