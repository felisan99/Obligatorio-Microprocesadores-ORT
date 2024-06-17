.global esperar_debounce
.global largo_string
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

# Recibe en $a0 una cadena de texto, devuelve en $v0 el largo de la cadena de texto 
largo_string:
    li $t0, 0
    move $t1, $a0
    loop_largo_string:
        lb $t2, ($t1)
        beq $t2, 0, fin_largo_string
        addi $t0, $t0, 1
        addi $t1, $t1, 1
        j loop_largo_string
  fin_largo_string:
  move $v0, $t0
  jr $ra



