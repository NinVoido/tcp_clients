clean:
	rm *.o main*
main: client.c client.o
	gcc client.c client.o -o main -no-pie
client.o: client.asm
	nasm -f elf64 -F dwarf -o client.o client.asm
debug: client.c client_dbg.o
	gcc client.c client_dbg.o -o main_dbg -no-pie -g
client_dbg.o: client.asm
	nasm -f elf64 -F dwarf -o client_dbg.o client.asm -g
