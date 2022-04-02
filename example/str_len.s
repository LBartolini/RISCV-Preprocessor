.text

str_len:
#! a0 t0 t1 t2
#! manage_ra
li t1, 0

loop_str_len:
add t2, a0, t1
lb t0, 0(t2)
beq t0, zero, end_str_len
addi t1, t1, 1
j loop_str_len

end_str_len:
addi a0, t1, 0
#! end