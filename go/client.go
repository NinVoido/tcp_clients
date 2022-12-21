package main

// Imports

import "fmt"
import "strings"
import "net"
import "os"
import "bufio"

func main() {
	// Open TCP stream
	conn, _ := net.Dial("tcp", "127.0.0.1:2000")

	// Infinite loop
	for {
                var text string

		for {
			// Open stdin reader
			reader := bufio.NewReader(os.Stdin)
			fmt.Print("Input a char: ")
			// Read user input
			text, _ = reader.ReadString('\n')
			// Trim trailing whitespaces
			text = strings.TrimSpace(text)
			// Check that input is a char
			if len(text) != 1 {
				fmt.Println("Input must be a char")
				continue
			} else {
				break
			}
		}
		// Write user input to TCP stream
		fmt.Fprintf(conn, text)
		// Receive server's response
		msg, _ := bufio.NewReader(conn).ReadByte()
		// Print it
		fmt.Print("Received message: " + string(msg) + "\n")
	}
}
