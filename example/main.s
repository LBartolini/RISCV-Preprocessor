#! main
#!include str_len.s

.data
example: .string "Hello World!"

.text

main:

#! precall(str_len)
la a0, example
jal str_len
#! postcall(str_len)

li a7, 1
ecall
#! end
