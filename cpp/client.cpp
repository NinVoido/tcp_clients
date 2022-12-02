// Imports
#include <iostream>
#include <boost/asio.hpp>

using namespace boost::asio;
using ip::tcp;


int main() {
  boost::asio::io_service io;
  // Create socket and connect
  tcp::socket socket(io); 

  socket.connect( tcp::endpoint( boost::asio::ip::address::from_string("127.0.0.1"), 2000));
  
  boost::system::error_code error;

  while (true) {
    std::string input;
    while (true) {
      // Read input
      std::cin >> input;
      // Check that input is a char
      if (input.length() != 1) {
        std::cout << "Input must be a char" << std::endl;
        continue;
      }
      break;
    }
    // Send message
    boost::asio::write(socket, boost::asio::buffer(input), error);
    // Handle possible errors
    if (error) {
      std::cout << "Error occured: " << error.message() << std::endl;
      break;
    }
    
    boost::asio::streambuf buf;
    // Receive answer
    boost::asio::read(socket, buf, boost::asio::transfer_exactly(2), error);
   // Check for errors
    if (error && error != boost::asio::error::eof) {
      std::cout << "Error occured: " << error.message() << std::endl;
    } else {
      // Print the answer
      const char* data = boost::asio::buffer_cast<const char*>(buf.data());
      std::cout << "Received data: " << data << std::endl;
    }
    
  }
  
  socket.close();
  return 0;
}
