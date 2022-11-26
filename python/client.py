# Import library
import socket

inp = ""

# Create socket
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    # Connect to adress
    s.connect(("127.0.0.1", 2000))
    
    while True:
        while True:
            # Read input
            inp = input("Input a char: ")
            # Verify that input is a char
            if not len(inp) == 1:
                print("Input must be a char")
                continue
            else:
                break
        # Send it
        s.sendall(inp.encode('utf-8'))
        # Receive answer
        data = s.recv(2)
        # Print it
        print(f"Received message: {data.decode('utf-8')}")

