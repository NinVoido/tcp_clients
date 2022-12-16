x86_64 GNU/Linux NASM\
I recommend using make to build - run `make main` or `make debug`\
if you wish to compile manually, run
```
nasm -f elf64 -F dwarf -o client.o client.asm
gcc main.c client.o -o main -no-pie
```
