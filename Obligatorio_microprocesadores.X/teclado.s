.global main_teclado
.text
# En $a0 entra la fila, en $a1 entra la columna
main_teclado:
 
    
    
    
 seteo_Teclado:
    li $t0, 0xF
    sw $t0, TRISE
    # Los primeros 4 pines son fila, los ultimos 4 son la columna
    li $t0, 0b11110000
    sw $t0, PORTE
    jr $ra

tecla_presionada:
    # 
    li $t0, 0b0001
    sb $t0, PORTE
    jal columna_presionada
    bne $v0, 0, preparar_entrada
    
    
    preparar_entrada:
	li $a0, 1
	li $a1, 1
	beq $

columna_presionada:
    lb $t0, PORTE
    andi $t0, $t0, 0xF0
    srl $t0,$t0, 4
    move $v0, $t0
    
    
procesar_teclado:
    li $v0, 0
    # Verifico en que fila esta
    beq $a0, 1, fila1
    beq $a0, 2, fila2
    beq $a0, 3, fila3
    beq $a0, 4, fila4
    
    # Discrimino por columna dada la fila
    fila1:
	beq $a1, 1, char_1
	beq $a1, 2, char_2
	beq $a1, 3, char_3
	beq $a1, 4, char_a
    fila2:
	beq $a1, 1, char_4
	beq $a1, 2, char_5
	beq $a1, 3, char_6
	beq $a1, 4, char_b
    fila3:
	beq $a1, 1, char_7
	beq $a1, 2, char_8
	beq $a1, 3, char_9
	beq $a1, 4, char_c
    fila4:
	beq $a1, 1, char_asterisco
	beq $a1, 2, char_0
	beq $a1, 3, char_numeral
	beq $a1, 4, char_d
    
    # Cargo el char que sale de los casos
    char_0:
	li $v0, '0'
	j final_procesamiento
    char_1:
	li $v0, '1'
	j final_procesamiento
    char_2:
	li $v0, '2'
	j final_procesamiento
    char_3:
	li $v0, '3'
	j final_procesamiento
    char_4:
	li $v0, '4'
	j final_procesamiento
    char_5:
	li $v0, '5'
	j final_procesamiento
    char_6:
	li $v0, '6'
	j final_procesamiento
    char_7:
	li $v0, '7'
	j final_procesamiento
    char_8:
	li $v0, '8'
	j final_procesamiento
    char_9:
	li $v0, '9'
	j final_procesamiento
    char_a:
	li $v0, 'a'    
	j final_procesamiento
    char_b:
	li $v0, 'b'
	j final_procesamiento
    char_c:
	li $v0, 'c'
	j final_procesamiento
    char_d:
	li $v0, 'd'
	j final_procesamiento
    char_asterisco:
	li $v0, '*'
	j final_procesamiento
    char_numeral:
	li $v0, '#'
	j final_procesamiento
jr $ra





