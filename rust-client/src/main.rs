use std::net::*;
use std::io::prelude::*;

fn main() {
    
    let mut input = String::new();
    
    loop {
        std::io::stdin().read_line(&mut input).expect("Failed to read input");
        
        input = input.trim().to_string();

        if input.trim().len() > 1 {
            println!("Input must be a char");
            continue;
        } else {
            break;
        }
    }

    let chr: u8 = input.as_bytes()[0 as usize];

    let mut stream = TcpStream::connect("127.0.0.1:1234")
        .expect("Failed to connect");
    
    stream.write(&[chr])
        .expect("Failed to send a byte");

    let mut get_buf: [u8; 2] = [0; 2];

    stream.read(&mut get_buf)
        .expect("Failed to read from server");
    
    println!("{}", String::from_utf8_lossy(&get_buf));    
}
