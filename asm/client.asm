extern printf
extern scanf

section .data
format: db "Connection failure!", 10, 0
format_input: db "Input a char:", 10, 0
format_char: db " %c", 0 
format_recv: db "Received message: %s", 10, 0

section .bss
nsocket: resd 1
addr: resd 4
status: resd 1
input: resb 1
server_response: resb 255

section .text
global start_client
start_client:
  push rbp
  mov rbp, rsp
  ; Create socket via socket syscall  
  mov eax, 41 ;syscall ID
  mov edi, 2  ;AF_INET
  mov esi, 1  ;SOCK_STREAM
  mov edx, 0
  syscall
  mov dword [nsocket], eax
  ; Create the address to connect to
  mov word [addr], 2
  mov ax, 53255 ; port 2000
  mov word [addr+2], ax
  mov dword [addr+4], 0
  ; Connect to a server via syscall
  mov eax, 42
  mov edi, [nsocket]
  mov esi, addr
  mov edx, 16
  syscall
  ; Check that the connection was successful (-111 in rax means connection failure)
  cmp rax, -111
  jne startasm.success 
  ; If we are here, connection failed, so we print out the warning
  mov edi, format
  call printf
  ; Set return value to -1 and exit
  mov eax, -1
  pop rbp
  ret
startasm.success:
  mov edi, format_input
  call printf
  ; Scan char from input via scanf
  mov edi, format_char
  mov esi, input
  mov eax, 0
  call scanf
  ; Send message via "write" syscall 
  mov rax, 1 ; syscall ID
  mov edi, [nsocket] ; FD of the place we want to write to
  mov esi, input ; Message
  mov edx, 1 ; Size of it (1 byte - char)
  syscall
  ; Read server response via "read" syscall 
  mov rax, 0 ; syscall ID
  mov edi, [nsocket] ; FD of socket
  mov esi, server_response ; Buffer we will read into
  mov edx, 64 ; count
  syscall
  ; Print server response
  mov edi, format_recv
  mov esi, server_response
  call printf
  ; Go to the beggining of event loop
  jmp startasm.success
startasm.end:
  mov eax, 0
  pop rbp
  ret
