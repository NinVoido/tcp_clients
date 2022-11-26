namespace System.Net.Sockets
{
  class Program
  {
    public static void Main()
    {
      // Create socket
      TcpClient client = new TcpClient("127.0.0.1", 2000);
      
      NetworkStream stream = client.GetStream();

      while(true) {

      System.Console.WriteLine("Input a char: ");
      // Read char
      char[] input = new char[] {System.Console.ReadKey().KeyChar};
      Byte[] data = System.Text.Encoding.ASCII.GetBytes(input);
  
      // Send it 
      stream.Write(data, 0, data.Length);

      data = new Byte[2];

      String response = String.Empty;
      // Get the response
      Int32 bytes = stream.Read(data, 0, data.Length);
      response = System.Text.Encoding.ASCII.GetString(data, 0, bytes);
      // Print it
      System.Console.WriteLine($"\nReceived message: {response}");
      }
    }
  }
}
