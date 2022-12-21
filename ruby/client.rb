# Import socket
require 'socket'
# Create a socket
socket = TCPSocket.new '127.0.0.1', 2000

input = ''
# Infinite loop
loop do
  
  loop do
    # Read user input and trim trailing whitespaces
    puts 'Input a char: '
    input = gets.chomp
    # Check that input is a char
    if input.length != 1
      puts 'Input must be a char'
      next
    else
      break
    end
  end
  # Write input to a socket
  socket.write input
  # Read server's response and print it
  puts "Received char: " + socket.read(1)
end
