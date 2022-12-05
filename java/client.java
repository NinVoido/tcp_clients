// Imports
import java.net.*;
import java.io.*;
import java.util.Scanner;

class Client {
  public static void main(String[] args) throws IOException {
    // Create stdin reader
    Scanner inp = new Scanner(System.in);
    // Create socket and connect
    Socket socket = new Socket("127.0.0.1", 2000);
    // Create reader and writer for the socket
    PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
    BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

    String input;
    String answer;

    while (true) {
      while (true) {
        System.out.println("Input a char: ");
        // Read line from user
        input = inp.nextLine();
        // Check that it's a char
        if (input.length() != 1) {
          System.out.println("Input must be a char");
          continue;
        }
        break;
      }
      // Send it
      out.println(input);
      // Receive the answer
      answer = in.readLine();
      // Print it
      System.out.println("Received message: " + answer);
    
    }
  }
}
