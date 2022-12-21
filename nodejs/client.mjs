// Import everything
import * as net from 'node:net'
import * as readline from 'node:readline/promises'
import { stdin as input, stdout as output } from 'node:process';
// Create user input reader
const rl = readline.createInterface({ input, output });
// Connect to server
const client = net.createConnection({
  port: 2000,
  family: 4,
});
// Function that waits for data from server and returns it
function read() {
  return new Promise((resolve, reject) => {
    client.on('data', (data) => {
      resolve(data.toString());
    });
  });
}
// Main
async function main() {
  while (true) {
    while(true) {
      // Read user input
      const input = await rl.question('Enter a char: ');

      if (input.length != 1) {
        console.log("Input must be a char");
        continue;
      }
      // Send it
      client.write(input);
      break;
    }
    // Print received message
    console.log('Received message: ' + await read());
  }
}

main();
