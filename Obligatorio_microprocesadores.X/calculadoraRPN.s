.global seteo_calculadora
.global main_calculadora
# -------------------------------------------MAIN-------------------------------------------------------
.text
seteo_calculadora:
    la $t0, stack
    sw $t0, puntero
    li $t0, 0
    li $t1,1
    sb $t0, cantidad
    sb $t1, operacion
    jr $ra
    
    
main_calculadora:
    # Guardo el STACK
    addiu $sp, $sp, -12
    sw $ra, ($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    # ---------------
    
    leer_nueva_entrada:
        li $s1, 0 # Largo actual de la entrada
        la $s2, input
        loop_leer_entrada:
            li $a0, 0
            jal leer_teclado
	    jal esperar_debounce
            beq $v0, 'd', final_lectura_numero
            beq $v0, '#', eliminar_ultimo_numero
            beq $v0, '*', cambiar_operacion
	    beq $v0, 'a', fin_calculadora
            # Guarda en input el nuevo numero
            sb $v0, ($s2)
            addi $s1, $s1, 1
            addi $s2, $s2, 1	    
            beq $s1, 4, final_lectura_numero
            j loop_leer_entrada
        final_lectura_numero:
            jal procesar_entrada
            beq $v1, 1 , entrada_invalida # -----> Mostrar en pantalla "entrada invalida" y vuelvo a loop leer entrada<------
            move $a0, $v0
            jal guardar
            j leer_nueva_entrada
    fin_calculadora:
        # Devuelvo el STACK
        lw $ra, ($sp)
        lw $s1, 4($sp)
        lw $s2, 8($sp)
        addiu $sp, $sp, 12
        # ---------------
        jr $ra
            

# Elimina el ultimo digito ingresado en input
    eliminar_ultimo_numero:
        la $t0, input
        lb $t1, ($t0)
        beq $t1, 0, fin_eliminar_ultimo_numero
        loop_eliminar_ultimo_numero:
            addi $t0, $t0, 1
            lb $t1, ($t0)
            beq $t1, 0, eliminar_numero
            j loop_eliminar_ultimo_numero
        eliminar_numero:
            addi $t0, $t0, -1
            sb $0, ($t0)
        fin_eliminar_ultimo_numero:
            j loop_leer_entrada
    
# Evaluo si cambia de operacion, 0 -> no hay operacion, 1 -> suma, 2 -> resta, 3 -> multiplicacion, 4 -> potencia
    cambiar_operacion:    
        li $a0, 0
        jal leer_teclado
	    jal esperar_debounce
        beq $v0, 'd', final_cambio_operacion
        beq $v0, '*', siguiente_operacion
         j entrada_invalida

        siguiente_operacion:
	    la $t0, operacion
	    lb $t1, ($t0)
            addi $t1, $t1, 1
            beq $t1, 5, resetear_operacion
            sb $t1, ($t0)
            j cambiar_operacion
        
	    resetear_operacion:
            li $t1, 0
            sb $t1, ($t0)
            j cambiar_operacion

        final_cambio_operacion:
            la $t0, operacion
            lb $t1, ($t0)
	        # Limpio la operacion
            li $t2, 1
	        sb $t2, ($t0)
	        # ------------
            beq $t1, 0, leer_nueva_entrada
            beq $t1, 1, sumar
            beq $t1, 2, restar
            beq $t1, 3, multiplicar
            beq $t1, 4, potencia

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
    j leer_nueva_entrada

# Imprime en consola el error de operandos insuficientes
operandos_insuficientes:
    li $v0, 4
    #la $a0, msj_operandos_insuficientes
    syscall
    j leer_nueva_entrada

# Saca dos numeros del stack y los resta
restar:
    jal sacar
    sub $a0, $v1, $v0
    jal guardar
    j leer_nueva_entrada

# Saca dos numeros del stack y los suma
sumar:
    jal sacar
    add $a0, $v1, $v0
    jal guardar
    j leer_nueva_entrada

# Saca dos numeros del stack y los multiplica
multiplicar:
    jal sacar
    mult $v1, $v0
    mfhi $t0
    mflo $a0
    jal guardar
    j leer_nueva_entrada

# Saca dos numeros del stack y hace la potencia, el penultimo numero elevado al ultimo numero
potencia:
    jal sacar
    li $t0,1
    beqz $v0,exponente_cero
    bltz $v0,exponente_negativo

    loop_potencia:
    beqz $v0,fin_potencia
    mult $v1,$t0
    mflo $t0
    addi $v0,$v0,-1
    j loop_potencia

    fin_potencia:
    la $a0,($t0)

    volver:
    jal guardar
    j leer_nueva_entrada

    exponente_cero:
    li $a0,1
    j volver
    
    exponente_negativo:
    # Al no realizar la operaci�n debo devolver los elementos que quit� del stack. Estos se encuentran en $v0(�ltimo) y $v1(pen�ltimo).
      la $a0,($v1)
      jal guardar
      la $a0,($v0)
      jal guardar
      
      # MOSTRAR EN PANTALLA QUE NO SE PUEDE REALIZAR LA OPERACION
      j leer_nueva_entrada	

fin:
    li $v0, 10
    syscall



