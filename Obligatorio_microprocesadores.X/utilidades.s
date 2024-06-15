.global esperar_debounce
.text
esperar_debounce:
    # Cuido el registro s
    addi $sp, $sp, -4
    sw $s0, ($sp)
    # -------------
    li $s0, 0
    loop_esperar_debounce:
	addi $s0, $s0, 1
        beq $s0, 40000, final_debounce
  	j loop_esperar_debounce
    final_debounce:
    # Devuelvo el s
    lw $s0, ($sp)
    addi $sp, $sp, 4
    # -------------
    jr $ra


