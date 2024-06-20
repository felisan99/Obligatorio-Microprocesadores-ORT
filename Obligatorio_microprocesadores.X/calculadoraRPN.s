.global imagen_actual_calculadora
.global seteo_calculadora
.global main_calculadora
.data
.align 2
stack: .space 44    # Espacio para 10 numeros de 32 bits
.align 2
texto_stack: .space 32   # Espacio para texto de 32 caracteres
.align 2
msg_suma: .asciiz "+"
.align 2
msg_resta: .asciiz "-"
.align 2
msg_multiplicacion: .asciiz "*"
.align 2
puntero_al_espacio_stack: .space 4
.align 2
cantidad_numeros_stack: .space 1
.align 2
input_de_numeros: .space 4	    # Espacio para que usuario ingrese datos
.align 2
msg_stack: .asciiz "stack:"
.align 2
msg_entrada: .asciiz "entrada:"
.align 2
titulo_calculadora: .asciiz "calculadora rpn"
.align 2
imagen_actual_calculadora: .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.align 2
renglon_1_calcu: .word 0
renglon_2_calcu: .word 0
renglon_3_calcu: .word 0
renglon_4_calcu: .word 0
renglon_5_calcu: .word 0
renglon_6_calcu: .word 0
renglon_7_calcu: .word 0
renglon_8_calcu: .word 0


# -------------------------------------------MAIN-------------------------------------------------------

# imprimir stack --> stack: y lo que hay en el stack
# limpiar pantalla --> pone tood en la imagen vacia
# imprimir input --> entrada: todo lo que hay en el input
.text
seteo_calculadora:
    sb $0, cantidad_numeros_stack
    la $t0, stack
    sw $t0, puntero_al_espacio_stack
    sw $0, input_de_numeros
    li $t1, 1
    sb $t1, operacion
    la $t0, texto_stack

    la $t0, imagen_actual_calculadora
    
    sw $t0, renglon_1_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_2_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_3_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_4_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_5_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_6_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_7_calcu
    
    addi $t0, $t0, 128
    sw $t0, renglon_8_calcu
    
    jr $ra
    
    
main_calculadora:
    # Guardo el STACK
    addiu $sp, $sp, -12
    sw $ra, ($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    # ---------------
    # imprimir el titulo en el primer renglon
    la $a0, titulo_calculadora
    la $a1, renglon_1_calcu
    li $a2, 15
    la $a3, imagen_actual_calculadora
    jal imprimir_texto
    
    # imprimir stack: en el renglon 3
    la $a0, msg_stack
    la $a1, renglon_3_calcu
    li $a2, 6
    la $a3, imagen_actual_calculadora
    jal imprimir_texto
    
    # imprimir entrada: en el renglon 6
    la $a0, msg_entrada
    la $a1, renglon_6_calcu
    li $a2, 8
    la $a3, imagen_actual_calculadora
    jal imprimir_texto

    leer_nueva_entrada:
        li $s1, 0 # Largo actual de la entrada en input
        la $s2, input_de_numeros
        sw $0, ($s2) # Limpia el input de numeros
        lw $a0, renglon_8_calcu
        jal limpiar_renglon
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
            addi $s1, $s1, 1 # Lleva la cuenta de la cantidad de numero que hay en el input
            addi $s2, $s2, 1
            la $a0, input_de_numeros
            la $a1, renglon_8_calcu
            move $a2,  $s1 # Paso como parametro la cantidad de numero que hay en el input
            la $a3, imagen_actual_calculadora
            jal imprimir_texto
            beq $s1, 4, final_lectura_numero
            j loop_leer_entrada
        final_lectura_numero:
        # Limpio el renglon donde se ve la entrada del usuario
            lw $a0, renglon_8_calcu
            jal limpiar_renglon
            la $a0, imagen_actual_calculadora
            jal cargar_imagen
        # Cargo lo que esta en el input a el texto_stack
            move $a0, $s1
        # Imprimo lo que esta en el stack
            jal procesar_entrada
            beq $v1, 1 , entrada_invalida # -----> Mostrar en pantalla "entrada invalida" y vuelvo a loop leer entrada<------
            beq $v0, 0, leer_nueva_entrada # Si apreta enter y no puso ningun numero arranca de vuelta
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
        la $t0, input_de_numeros
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
            lw $a0, renglon_8_calcu
            jal limpiar_renglon
            addi $s2, $s2, -1
            addi $s1, $s1, -1
            la $a0, input_de_numeros
            la $a1, renglon_8_calcu
            move $a2,  $s1 # Paso como parametro la cantidad de numero que hay en el input
            la $a3, imagen_actual_calculadora
            jal imprimir_texto
            j loop_leer_entrada
    
# Evaluo si cambia de operacion, 0 -> no hay operacion, 1 -> suma, 2 -> resta, 3 -> multiplicacion
    cambiar_operacion:
        la $a0, input_de_numeros
        jal largo_string
        bne $v0, 0, entrada_invalida
        
        la $t0, operacion
        lb $t1, ($t0)
        jal mostrar_operacion
        
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
            beq $t1, 4, resetear_operacion
            sb $t1, ($t0)
            jal mostrar_operacion
            j cambiar_operacion
        
	    resetear_operacion:
            li $t1, 1
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

mostrar_operacion:
    # CUIDO EL STACK
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ---------------
    lb $t0, operacion
    beq $t0, 1, mostrar_suma
    beq $t0, 2, mostrar_resta
    beq $t0, 3, mostrar_multiplicacion
    j fin_mostrar_operacion
    mostrar_suma:
        la $a0, msg_suma
        la $a1, renglon_8_calcu
        li $a2, 1
        la $a3, imagen_actual_calculadora
        jal imprimir_texto
        j fin_mostrar_operacion
    mostrar_resta:
        la $a0, msg_resta
        la $a1, renglon_8_calcu
        li $a2, 1
        la $a3, imagen_actual_calculadora
        jal imprimir_texto
        j fin_mostrar_operacion
    mostrar_multiplicacion:
        la $a0, msg_multiplicacion
        la $a1, renglon_8_calcu
        li $a2, 1
        la $a3, imagen_actual_calculadora
        jal imprimir_texto
        j fin_mostrar_operacion
    fin_mostrar_operacion:
        # Devuelvo el stack
        lw $ra, ($sp)
        addiu $sp, $sp, 4
        # ---------------
        jr $ra


# Imprime en consola todos los numeros del stack, recibe en $a0 la cantidad de numero que hay
imprimir_input:
    # CUIDO EL STACK
    addiu $sp, $sp, -20
    sw $ra, ($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    # ----------------
    # Limpio el renglon 5 donde voy a escribir los numeros
    move $s3, $a0 # me guardo en $s3 la cantidad de numeros que hay en el input
    la $a0, renglon_5_calcu
    jal limpiar_renglon

    li $s2, 0 # contador de la cantidad de chars que voy cargando
    lw $s0, renglon_5_calcu
    la $s1, input_de_numeros
    loop_imprimir_input:
        lb $a0, ($s1)
        jal de_char_a_imagen
        move $t2, $v0   # Ahora en $t2 tengo el address de memoria a la imagen del char que tengo que cargar
        li $t1, 0
        loop_cargar_numero_a_imagen_actual:
            lb $t0, ($t2)   # Cargo el byte de la imagen
            sb $t0, ($s0)   # La guardo en la imagen actual, el renglon 5
            addi $t2, $t2, 1
            addi $s0, $s0, 1
            addi $t1, $t1, 1 # Llevo la cuenta de la cantidad de bytes que voy guardando, como es un caracter tienen que ser 8
            beq $t1, 8, fin_cargar_numero_a_imagen_actual # Si ya cargue los 8 bytes de la imagen paso a la siguiente
            j loop_cargar_numero_a_imagen_actual
        fin_cargar_numero_a_imagen_actual:
            addi $s1, $s1, 1 # Paso al siguiente char que tengo que cargar
            addi $s2, $s2, 1 # Agrego uno a la cantidad de chars que voy cargando
            beq $s2, $s3, fin_imprimir_input # Si ya cargue todos los numeros que tengo que cargar termino
            j loop_imprimir_input
    
    fin_imprimir_input:
        la $a0, imagen_actual_calculadora
        jal cargar_imagen
        # DEVUELVO EL STACK
        lw $ra, ($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $s2, 12($sp)
        lw $s3, 16($sp)
        addiu $sp, $sp, 20
        # ---------------
        jr $ra

# En $a0 el puntero al renglon que hay que limpiar 
limpiar_renglon:
    # Cuide el stack
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ---------------
    li $t0, 0
    loop_limpiar_renglon:
        sb $0, ($a0)
        addi $a0, $a0, 1
        addi $t0, $t0, 1
        beq $t0, 128, fin_limpiar_renglon
        j loop_limpiar_renglon
    fin_limpiar_renglon:
        la $a0, imagen_actual_calculadora
        jal cargar_imagen
    # Devuelvo el stack
    lw $ra, ($sp)
    addiu $sp, $sp, 4
    # ---------------
    jr $ra

# Convierte a un string lo que esta en el stack
stack_a_texto:
    # Limpio el buffer de texto
    la $t0, texto_stack
    li $t1, 0
    loop_limpiar_texto_stack:
        sw $0, ($t0)
        addi $t0, $t0, 4
        addi $t1, $t1, 1
        beq $t1, 4, fin_limpiar_texto_stack
        j loop_limpiar_texto_stack
    fin_limpiar_texto_stack:

    la $t1, texto_stack           # Carga la dirección del buffer de texto en $t1
    la $t6, stack                 # Carga la dirección del stack en $t6
    lb $t8, cantidad_numeros_stack# Carga la cantidad de números en el stack
    li $t7, 0                     # Inicializa el contador de elementos procesados a 0
    
    #texto_stack 4 3 2 1 _ _ _ _
    # stack -1234 7777 10 --> 4 -> 3 -> 2 -> 1
    loop_por_elemento_del_stack:
        lw $t5, ($t6)                 # Carga el siguiente número del stack
        move $t9, $t1                 # Guarda la posición inicial del buffer de texto actual
        bltz $t5, numero_negativo      # Si el número es negativo, salta a la rutina correspondiente
    loop_stack_a_texto:
        divu $t5, $t5, 10         # Divide el número entre 10 (usar divu para asegurar unsigned)
        mfhi $t2                  # Guarda el residuo en $t2
        addi $t2, $t2, 0x30       # Convierte el residuo a ASCII
        sb $t2, ($t1)             # Almacena el carácter en el buffer
        addi $t1, $t1, 1          # Avanza al siguiente espacio en el buffer
        mflo $t5                  # Obtiene el cociente de la división
        bnez $t5, loop_stack_a_texto  # Si el cociente no es cero, repite

    dar_vuelta_orden:
        # Guarda en $1 la dirección del último carácter agregado
        addi $t0, $t1, -1         # Retrocede uno para apuntar al último carácter agregado
        # En $t9 está el comienzo de la cadena del elemento actual
        loop_dar_vuelta_orden:
            lb $t3, ($t9)         # Carga el char desde el principio del string
            lb $t4, ($t0)         # Carga el char desde el final del string
            sb $t3, ($t0)         # Almacena el char inicial al final
            sb $t4, ($t9)         # Almacena el char final al inicio
            addi $t9, $t9, 1      # Avanza al siguiente char desde el inicio
            addi $t0, $t0, -1     # Retrocede al char anterior desde el final
            bge $t9, $t0, fin_dar_vuelta  # Si los punteros se cruzan, termina
            j loop_dar_vuelta_orden       # De lo contrario, repite

    numero_negativo:
        nor $t5, $t5, $0          # Invierte todos los bits del número
        addi $t5, $t5, 1          # Suma 1 al número invertido
        li $t3, '-'               # Coloca un guión al principio del número
        sb $t3, ($t9)
        addi $t9, $t9, 1          # Avanza al siguiente espacio en el buffer
        addi $t1, $t1, 1            
        j loop_stack_a_texto      # Repite el proceso de conversion 


    fin_dar_vuelta:
        li $t9, '|'               # Coloca '|' al principio de cada cadena de números
        sb $t9, ($t1)           # Almacena '|' en la posición anterior
        addi $t1, $t1, 1          # Avanza al siguiente espacio en el buffer
        addi $t6, $t6, 4          # Adelanta al siguiente elemento en el stack
        addi $t7, $t7, 1          # Incrementa el contador de elementos procesados
        beq $t7, $t8, fin_stack_a_texto  # Si se procesaron todos los elementos, termina
        j loop_por_elemento_del_stack   # De lo contrario, repite

fin_stack_a_texto:
    jr $ra                       # Retorna de la subrutina

        



# --------------------------------------------------------------------------------------------------------

# ----------------------------------------METODOS TAD STACK-----------------------------------------------

# Saca dos numeros desde el address $s0 y los guarda en $v0 y $v1
sacar:
    lb $t0, cantidad_numeros_stack		# En $t0 guardo la cantidad de elementos en el stack
    la $t1, puntero_al_espacio_stack
    lw $t1, ($t1)			# En $t1 guardo el puntero al primer espacio vacio
    blt $t0, 2, entrada_invalida
    addi $t0, $t0, -2
    sb $t0, cantidad_numeros_stack
    lw $v0, -4($t1)
    lw $v1, -8($t1)
    addi $t1, $t1, -8
    sw $t1, puntero_al_espacio_stack
    jr $ra	

# Guarda el numero que esta en $a0 en el stack	
guardar:
    # CUIDO EL STACK
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ---------------
    lb $t0, cantidad_numeros_stack				# En $t0 guardo la cantidad de elementos 
    bge $t0, 10, exceso_operandos
    la $t1, puntero_al_espacio_stack	
    lw $t1, ($t1)					# En t1 es ahora el puntero al primer espacio vacio
    sw $a0, ($t1)
    addi $t0, $t0, 1
    sb $t0, cantidad_numeros_stack
    addi $t1, $t1, 4
    sw $t1, puntero_al_espacio_stack
    j fin_guardado
    exceso_operandos:
        jal entrada_invalida
    fin_guardado:
    jal update_stack_en_pantalla
    # DEVUELVO EL STACK
    lw $ra, ($sp)
    addiu $sp, $sp, 4
    # ---------------
    jr $ra

# --------------------------------------------------------------------------------------------------------

# Lee la entrada, pasa cada caracter a un valor de entero y devuelve en $v0 este valor y en $v1 0 si la entrada es correcta, 1 si no lo es
procesar_entrada:
    li $t7, 1			# Multiplicador por unidades, decenas, centenas y miles
    la $t6, input_de_numeros		# Puntero al los datos que ingreso el usuario
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
		    la $t0, input_de_numeros
		    sw $0, ($t0) # Limpio la memoria
		    jr $ra

# --------------------------------------------------------------------------------------------------------


update_stack_en_pantalla:
    # Cuidar stack
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ---------------
    # Primero limpio el renglon 4
    lw $a0, renglon_4_calcu
    jal limpiar_renglon
    # Ahora vuelvo a imprimir el stack actualizado
    jal stack_a_texto
    la $a0, texto_stack
    jal largo_string
    move $a2, $v0
    la $a1, renglon_4_calcu
    la $a3, imagen_actual_calculadora
    jal imprimir_texto
    # Devuelvo el stack
    lw $ra, ($sp)
    addiu $sp, $sp, 4
    #---------------
    jr $ra

# Imprime en pantalla el error de entrada invalida
entrada_invalida:
    la $a0, imagen_entrada_invalida
    jal cargar_imagen
    li $t0, 0
    loop_delay_entrada_invalida:
        addi $t0, $t0, 1
        beq $t0, 100000, fin_delay_entrada_invalida
        j loop_delay_entrada_invalida
    fin_delay_entrada_invalida:
    la $a0, imagen_actual_calculadora
    jal cargar_imagen
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