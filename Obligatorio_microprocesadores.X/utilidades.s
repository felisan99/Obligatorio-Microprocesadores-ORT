.global esperar_debounce
.text
esperar_debounce:
	li $t0, 0
	loop_esperar_debounce:
	    addi $t0, $t0, 1
	    beq $t0, 60000, final_debounce
	    j loop_esperar_debounce
	final_debounce:
	    jr $ra


