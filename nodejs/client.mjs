import * as net from 'node:net'
import * as readline from 'node:readline/promises'
import { stdin as input, stdout as output } from 'node:process';

const rl = readline.createInterface({ input, output });

const client = net.createConnection({
  port: 2000,
  family: 4,
});

function read() {
  return new Promise((resolve, reject) => {
    client.on('data', (data) => {
      resolve(data.toString());
    });
  });
}

async function main() {
  while (true) {
    while(true) {

      const input = await rl.question('Enter a char: ');

      if (input.length != 1) {
        console.log("Input must be a char");
        continue;
      }
      client.write(input);
      break;
    }
    console.log('Received message: ' + await read());
  }
}

main();
