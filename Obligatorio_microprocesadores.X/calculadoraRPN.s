.global seteo_calculadora
.global loop_main_calculadora
# -------------------------------------------MAIN-------------------------------------------------------

seteo_calculadora:
    la $t0, stack
    sw $t0, puntero
    lb $0, cantidad
    jr $ra
    
    
loop_main_calculadora:
# Imprimo el estado actual del stack
    # jal imprimir_stack ----------> FUNCION PANTALLA <-----------

# Pido que ingresen un dato
    # li $v0, 4
    # la $a0, msj_entrada ----------> FUNCION PANTALLA <-----------
    # syscall

# Espero el dato, lo agrego a input y 
    leer_entrada:
	# Cuido el STACK
	addiu $sp, $sp, -4
	sw $ra, ($sp)
	# ---------------
	li $t1, 0 # Largo actual de la entrada
	la $t2, input
	loop_leer_entrada:
	    jal leer_teclado
	    move $t0, $v0
	    beq $t0, '#', final_lectura
	    # beq $t0, '*', cambiar_operacion
	    # Guarda en input el nuevo numero
	    sb $t0, ($t2)
	    addi $t1, $t1, 1
	    addi $t2, $t2, 1	    
	    beq $t1, 4, final_lectura
	    jal esperar_debounce
	    j loop_leer_entrada
	final_lectura:
	    jal procesar_entrada
	    move $a0, $v0
	    jal guardar
	    # Devuelvo el STACK
	    lw $ra, ($sp)
	    addiu $sp, $sp, 4
	    # ---------------
	    jr $ra
	    
    esperar_debounce:
	li $t0, 0
	loop_esperar_debounce:
	    addi $t0, $t0, 1
	    beq $t0, 60000, final_debounce
	    j loop_esperar_debounce
	final_debounce:
	    jr $ra

# Evaluo que entrada es (suma resta multiplicacion division limpiar stack salir)
    la $t0, input
    lw $t1, ($t0)
    andi $t0, $t1, 0xff
    andi $t2, $t1, 0x0000ff00
    bne $t2, 0x00000a00, no_es_comando

    beq $t0, 99, limpiar_stack
    beq $t0, 120, fin
    beq $t0, 43, sumar
    beq $t0,45, restar
    beq $t0, 42, multiplicar
    beq $t0, 112, potencia
    no_es_comando:
# Si no es un comando entonces proceso la entrada
    jal procesar_entrada

# Si procesar entrada da 1 en $v1 es porque la entrada no es valida
    beq $v1, 1, entrada_invalida
    move $a0, $v0
    jal guardar
    j loop_main_calculadora
# --------------------------------------------------------------------------------------------------------

# ----------------------------------------METODOS TAD STACK-----------------------------------------------

# Imprime en consola todos los numeros del stack
imprimir_stack:
    lb $t0, cantidad		# En $t0 guardo la cantidad de elementos en el stack
    la $t1, stack		    # En $t1 guardo el puntero al comienzo del stack
    # la $a0, msj_stack
    # li $v0, 4
    # syscall
    loop_imprimir:
	    blez $t0, fin_loop_imprimir
	    lw $a0, ($t1)
	    li $v0, 1
	    syscall
	    addi $t0, $t0, -1
	    addi $t1, $t1, 4
	    li $a0, ' '
	    li $v0, 11
	    syscall
	    j loop_imprimir
    fin_loop_imprimir:
	    jr $ra

# Saca dos numeros desde el address $s0 y los guarda en $v0 y $v1
sacar:
    lb $t0, cantidad		# En $t0 guardo la cantidad de elementos en el stack
    la $t1, puntero
    lw $t1, ($t1)			# En $t1 guardo el puntero al primer espacio vacio
    blt $t0, 2, operandos_insuficientes
    addi $t0, $t0, -2
    sb $t0, cantidad
    lw $v0, -4($t1)
    lw $v1, -8($t1)
    addi $t1, $t1, -8
    sw $t1, puntero
    jr $ra	

# Guarda el numero que esta en $a0 en el stack	
guardar:
    lb $t0, cantidad				# En $t0 guardo la cantidad de elementos 
    bge $t0, 10, exceso_operandos
    la $t1, puntero	
    lw $t1, ($t1)					# En t1 es ahora el puntero al primer espacio vacio
    sw $a0, ($t1)
    addi $t0, $t0, 1
    sb $t0, cantidad
    addi $t1, $t1, 4
    sw $t1, puntero
    j fin_guardado
    exceso_operandos:
	# li $v0, 4
	# la $a0, msj_exceso_operandos  ----------> FUNCION PANTALLA <-----------
	# syscall
    fin_guardado:
	li $t0, 0
	lw $t0, input
	jr $ra

# --------------------------------------------------------------------------------------------------------

# Lee la entrada, pasa cada caracter a un valor de entero y devuelve en $v0 este valor y en $v1 0 si la entrada es correcta, 1 si no lo es
procesar_entrada:
    li $t7, 1			# Multiplicador por unidades, decenas, centenas y miles
    la $t6, input		# Puntero al los datos que ingreso el usuario
    addi $t6, $t6, 3		# Comienzo desde las unidades
    li $t0, 0			# Lleva la cuenta total
    li $t2, 4			# Lleva la posicion
    li $v1, 0			# Flag si la entrada es invalida
    li $t9, 10

    loop_procesamiento:
	    beqz $t2, fin_procesamiento

	    lb $t1, ($t6)
	    beq $t1, 0, nulo
	    beq $t1, 0xa, nulo

	    addi $t1, $t1, -48
	    bltz $t1, no_valido
	    bgt $t1, 9, no_valido

	    multu $t1, $t7
	    mflo $t1
	    multu $t7, $t9
	    mflo $t7
	    add $t0, $t0, $t1
	    nulo:
	    addi $t6, $t6, -1
	    addi $t2, $t2, -1
	    j loop_procesamiento

	    no_valido:
		    li $v1, 1 # Activo el flag de entrada invalida
		    j fin_procesamiento

	    fin_procesamiento:
		    move $v0, $t0			# En $v0 guardo el valor procesado
		    la $t0, input
		    sw $0, ($t0) # Limpio la memoria
		    jr $ra

# --------------------------------------------------------------------------------------------------------

# Imprime en consola el error de entrada invalida
entrada_invalida:
    li $v0, 4
    #la $a0, msj_entrada_invalida
    syscall
    j loop_main_calculadora

# Imprime en consola el error de operandos insuficientes
operandos_insuficientes:
    li $v0, 4
    #la $a0, msj_operandos_insuficientes
    syscall
    j loop_main_calculadora

# Saca dos numeros del stack y los resta
restar:
    jal sacar
    sub $a0, $v1, $v0
    jal guardar
    j loop_main_calculadora

# Saca dos numeros del stack y los suma
sumar:
    jal sacar
    add $a0, $v1, $v0
    jal guardar
    j loop_main_calculadora

# Saca dos numeros del stack y los multiplica
multiplicar:
    jal sacar
    mult $v1, $v0
    mfhi $t0
    mflo $a0
    jal guardar
    j loop_main_calculadora

# Saca dos numeros del stack y hace la potencia, el penultimo numero elevado al ultimo numero
potencia:
    jal sacar
    li $a0, 1
    loop_potencia:
	    beqz $v0, fin_potencia
	    mult $a0, $v1
	    mflo $a0
	    addi $v0, $v0, -1
	    j loop_potencia
    fin_potencia:
	    jal guardar
	    j loop_main_calculadora

# Resetea el puntero al stack al origen y el contador de elementos a 0
limpiar_stack:
    sb $0, cantidad
    la $t1, stack
    sw $t1, puntero
    j loop_main_calculadora	

fin:
    li $v0, 10
    syscall




