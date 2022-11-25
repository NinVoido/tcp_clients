// Imports from std
use std::io::prelude::*;
use std::net::*;

fn main() {
    // Create buffer for user input
    let mut input = String::new();
    
    // Open TCP stream
    let mut stream = TcpStream::connect("127.0.0.1:2000")
            .expect("Failed to connect");

    // Infinite loop syntax in rust
    loop {

        loop {
            println!("Input a char:");
            
            // Remove any content from the string
            input.clear();

            // Reading stdin into buffer
            std::io::stdin()
                .read_line(&mut input)
                // If reading fails, throw this error message and exit
                .expect("Failed to read input");
            // Remove trailing whitespaces
            input = input.trim().to_string();
            // Verify that input is a char
            if input.len() > 1 {
                println!("Input must be a char");
                continue;
            } else {
                break;
            }
        }
        // Transform char to byte for sending 
        let chr: u8 = input.as_bytes()[0 as usize];
        
        // Write bytes to the stream aka send it
        stream.write(&[chr]).expect("Failed to send a byte");

        // Create 2-byte buffer for reading server response
        let mut get_buf: [u8; 2] = [0; 2];
        
        // Read server response
        stream
            .read(&mut get_buf)
            .expect("Failed to read from server");
        
        // Print response as UTF-8 string
        println!("{}", String::from_utf8_lossy(&get_buf));
    }
}
