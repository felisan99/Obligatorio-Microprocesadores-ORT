.global seteo_teclado
.global leer_teclado
    
.text
# PINES DE FILAS : 26, 27, 28, 29 || RE0 a RE3
# PINES DE COLUMNAS: 30, 31, 32, 33 || RE4 a RE7

# Declaramos los pines del puerto TRISE como salida para los primeros 4 pines (en 0 para digitalOut) y entrada
# para los ultimos 4 pines (en 1 para digitalIn)
seteo_teclado:
    li $t0, 0xF0
    sw $t0, TRISE
    # Los primeros 4 pines son FILA, los ultimos 4 son la COLUMNA
    li $t0, 0x0
    sw $t0, PORTE
    
    jr $ra

# Pone en HIGH de a un PIN y se 
# fija para ese pin si hay alguna tecla presionada, si la hay, devuelve el char
# si $a0 = 0 --> MODO NORMAL, si $a0 = 1 --> MODO ROT13

leer_teclado:
    # Cuido el STACK
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ---------------
	li $t1, 0 #========
    leer_teclado_loop:
		beq $t1, 10000, paso_el_tiempo #======
		addi $t1, $t1, 1 #=======

		li $t0, 0x1
		li $a0, 1
		sw $t0, PORTE
		jal columna_presionada
		bne $v0, 0, se_registro_ingreso

		li $t0, 0x2
		li $a0, 2
		sw $t0, PORTE
		jal columna_presionada
		bne $v0, 0, se_registro_ingreso

		li $t0, 0x4
		li $a0, 3
		sw $t0, PORTE
		jal columna_presionada
		bne $v0, 0, se_registro_ingreso

		li $t0, 0x8
		li $a0, 4
		sw $t0, PORTE
		jal columna_presionada
		bne $v0, 0, se_registro_ingreso
		
		j leer_teclado_loop
    
    se_registro_ingreso:
	# Cuido el STACK
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	# ---------------
	jr $ra

# FUNCIONES EXCLUSIVAS PARA MODO ROT13
paso_el_tiempo:
	li $v0, '-'
	j se_registro_ingreso

	
# En $a0 se le pasa la fila que esta en HIGH y lee columna por columna cual esta en HIGH y dado eso entrega en $a1 la columna que lee HIGH
columna_presionada:
     # Cuido el STACK
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ---------------
    lw $t0, PORTE
    andi $t0, $t0, 0xF0
    
    beq $t0, 0x10, columna_1
    beq $t0, 0x20, columna_2
    beq $t0, 0x40, columna_3
    beq $t0, 0x80, columna_4
    li $v0, 0
    j final_columna
    
    columna_1:
	li $a1, 1
	jal procesar_teclado
	j final_columna
    columna_2:
	li $a1, 2
	jal procesar_teclado
	j final_columna
    columna_3:
	li $a1, 3
	jal procesar_teclado
	j final_columna
    columna_4:
	li $a1, 4
	jal procesar_teclado
	j final_columna
    final_columna:
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
    
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
	
    final_procesamiento:
	jr $ra





