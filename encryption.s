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
;writing instruction, on the screen, for the user
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg, %ecx
mov $msg_len, %edx
int $SYSCALL32

;loading text from the user
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $BUFFOR_LENGTH, %edx
int $SYSCALL32

encrypt:

;writing, previously loaded, text on the screen
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $input, %ecx
mov $BUFFOR_LENGTH, %edx
int $SYSCALL32

mov $SYSEXIT32, %eax
mov $0, %ebx
int $SYSCALL32
