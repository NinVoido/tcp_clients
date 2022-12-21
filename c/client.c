// Imports
#include "stdlib.h"
#include "string.h"
#include "stdio.h"

#include "sys/types.h"
#include "sys/socket.h"
#include "netinet/in.h"

int main() {
  // Create the socket
  int nsocket;
  nsocket = socket(AF_INET, SOCK_STREAM, 0);
  // Specify server address
  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
  addr.sin_port = htons(2000);
  addr.sin_addr.s_addr = INADDR_ANY;
  // Connect to the socket
  int status = connect(nsocket, (struct sockaddr*) &addr, sizeof(addr));
  // Check that connection was successful
  if (status == -1) {
    printf("Connection failed");
    return 1;
  }

  char input;
  // Infinite loop
  while (1) {
    printf("Input a char:\n");
    // Read user input
    scanf(" %c", &input);
    // Send it to the server
    send(nsocket, &input, sizeof(input), 0);
    char server_response[256];
    // Read server response
    recv(nsocket, &server_response, sizeof(server_response), 0);
    // Output it
    printf("Received message: %s\n", server_response);
  }
  return 0;
}
