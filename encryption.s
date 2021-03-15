SYSREAD= 3
STDIN= 0
STDOUT= 1
SYSEXIT32= 1
SYSCALL32= 0x80

BUFFOR_LENGTH= 100

.global _start

.data
input: .space BUFFOR_LENGTH

.text

_start:
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $BUFFOR_LENGTH, %edx
int $SYSCALL32

mov $SYSEXIT32, %eax
mov $0, %ebx
int $SYSCALL32
