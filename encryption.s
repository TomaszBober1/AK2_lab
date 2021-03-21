SYSREAD= 3
SYSWRITE= 4
STDIN= 0
STDOUT= 1
SYSEXIT32= 1
SYSCALL32= 0x80

BUFFOR_LENGTH= 100

.global _start

.data
input: .space BUFFOR_LENGTH

.text
msg: .ascii "Write text you want to encrypt:\n"

msg_len= . -msg

_start:
#writing instruction, on the screen, for the user
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg, %ecx
mov $msg_len, %edx
int $SYSCALL32

#loading text from the user
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $BUFFOR_LENGTH, %edx
int $SYSCALL32

#copy length of loaded text
mov %eax, %edi
dec %edi

#create loop counter
mov $0, %esi

#loop in which we encrypt the text
encrypt:
cmpb $0x7A, input(%esi) #preventing encryption of polish characters
ja backsmall
cmpb $0x41, input(%esi) #comparing text loaded from user with ascii codes
jae big
backbig:
cmpb $0x61, input(%esi)
jae small
backsmall:
inc %esi
cmp %edi, %esi  #checking if the loop should have ended
jl encrypt

#writing, encrypted text on the screen
mov %eax, %edx
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $input, %ecx
int $SYSCALL32

#exit from program
mov $SYSEXIT32, %eax
mov $0, %ebx
int $SYSCALL32

#uppercase and lowercase encryption instructions
big:
cmpb $0x4F, input(%esi)
jl bigf
jae bigs
jmp backbig

bigf:
addb $0x0D, input(%esi)
jmp backbig

bigs:
cmpb $0x5A, input(%esi)
ja backbig
subb $0x0D, input(%esi)
jmp backbig

small:
cmpb $0x6F, input(%esi)
jl smallf
jae smalls
jmp backsmall

smallf:
addb $0x0D, input(%esi)
jmp backsmall

smalls:
cmpb $0x7A, input(%esi)
ja backsmall
subb $0x0D, input(%esi)
jmp backsmall
