// Imports
import std.string;
import std.stdio;
import std.socket;

void main()
{
  
  // Create a socket and connect
  ushort port = 2000;
  auto socket = new TcpSocket();
  socket.connect(new InternetAddress(port));
  
  string input;
  
  auto resp = new ubyte[2];
  while(true){
    while(true){
      writef("Input a char: ");
      // Read input
      input = readln();
      input = strip(input);
      // Check that input is a char
      if (input.length != 1) {
        writeln("Input must be a char");
        continue;
      } else {
        break;
      }
    }
    
    // Send it to the server
    socket.send(cast(ubyte[])input);
    // Receive server response
    socket.receive(resp);
    // Print it
    writeln("Server response: ", cast(string)resp);
  }

}
