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
addi sp, sp, -16
sw a0, 12(sp)
sw t0, 8(sp)
sw t1, 4(sp)
sw t2, 0(sp)
la a0, example
jal str_len
lw t2, 0(sp)
lw t1, 4(sp)
lw t0, 8(sp)
lw a0, 12(sp)
addi sp, sp, 16
li a7, 1
ecall
