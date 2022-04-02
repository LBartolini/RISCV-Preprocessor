.data
example: .string "Hello World!"
.text
j main
str_len:
addi sp, sp, -4
sw ra, 0(sp)
li t1, 0
loop_str_len:
add t2, a0, t1
lb t0, 0(t2)
beq t0, zero, end_str_len
addi t1, t1, 1
j loop_str_len
end_str_len:
addi a0, t1, 0
lw ra, 0(sp)
addi sp, sp, 4
jr ra
main:
la a0, example
jal str_len
li a7, 1
ecall
