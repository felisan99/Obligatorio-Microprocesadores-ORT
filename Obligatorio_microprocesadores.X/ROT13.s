.data
input_rot: .space 100
string_rot: .space 100
.align 2
puntero_string: .space 4
.align 2
puntero_input: .space 4

.text
.global main_rot13    
   
#	Leo el mensaje que se desea encriptar
main_rot13:
    # Cuido el STACK
    addiu $sp, $sp, -8
    sw $ra, ($sp)
    sw $s0, 4($sp)
    # ---------------
    loop_main_rot13:
        la $s0, input_rot
        la $t0, string_rot
        sw $t0, puntero_string
        loop_leer_nuevo_caracter:
            # Leo una primera entrada en modo lectura normal
            li $a0, 0
            jal leer_teclado
            jal esperar_debounce
            beq $v0, 'd', procesar_entrada_rot13
            beq $v0, 'a', fin_rot13
            sb $v0, ($s0)
            addi $s0, $s0, 1

        # Leo otra vez, teniendo en cuenta el tiempo
        # Si me ingresan un caracter igual al anterior lo guardo
        # Si pasa el tiempo guardo un guion
        # Si me ingresan un caracter distinto guardo un guion y el caracter nuevo
        loop_repetido:
            li $a0, 1
            jal leer_teclado
            beq $v0, 'd', procesar_entrada_rot13
            beq $v0, 'a', fin_rot13
            lb $t1, -1($s0)
            bne $v0, $t1, guardar_caracter
            beq $v0, '-', loop_leer_nuevo_caracter 

            sb $v0, ($s0)
            addi $s0, $s0, 1
            j loop_repetido

    guardar_caracter:
        li $t1, '-'
        sb $t1, ($s0)
        addi $s0, $s0, 1
        sb $v0, ($s0)
        addi $s0, $s0, 1
        j loop_repetido
fin_rot13:
    # Limpiar el input y el string

    # Devuelvo el STACK
    lw $ra, ($sp)
    lw $s0, 4($sp)
    addiu $sp, $sp, 8
    # ---------------
    jr $ra

# Pasa de una serie de caracteres separado por guiones (-) a un solo string que lo guarda en string_rot
# Cuando termina llama a encriptar_rot13
# Si se encuentra con un # elimina el último caracter que se ingreso en string_rot
# Usa $t0 (puntero a donde se guarda la secuencia), $t1 (contador largo de la secuencia), $t2 (caracter actual)

procesar_entrada_rot13:
    loop_procesar_entrada_rot13:
        lb $t2, ($s0)
        beq $t2, 0, fin_procesar_entrada_rot13 #terminó la cadena
        beq $t2, '#', eliminar_ultimo_caracter
        li $t1, 0
        lb $a0, ($s0)
        loop_secuencia_interna:
            beq $t2,'-',fin_secuencia
            addi $t1, $t1, 1
            addi $s0, $s0, 1
        j loop_secuencia_interna
        fin_secuencia:
            addi $s0,$s0,1
            move $a1, $t1
            jal procesar_caracter
            j loop_procesar_entrada_rot13
    fin_procesar_entrada_rot13:
        j encriptar_rot13

# Elimina el último caracter ingresado en string_rot
# Usa $t3 (puntero a string_rot)
    eliminar_ultimo_caracter:
	la $t4, string_rot
        la $t3, puntero_string
        addi $t3, $t3, -1
        blt $t3, $t4, fin_eliminar_ultimo_caracter
        sb $0, ($t3)
        sw $t3, puntero_string
        fin_eliminar_ultimo_caracter:
            addi $t0, $t0, 1
            j loop_procesar_entrada_rot13
    
# Le paso en $a0 el numero del caracter y en $a1 el numero de veces que se repite ese numero.
# Guarda en string_rot el caracter correspondiente a la secuencia leida de input_rot
    procesar_caracter:
        beq $a0, '0', familia_0
        beq $a0, '1', familia_1
        beq $a0, '2', familia_2
        beq $a0, '3', familia_3
        beq $a0, '4', familia_4
        beq $a0, '5', familia_5
        beq $a0, '6', familia_6
        beq $a0, '7', familia_7
        beq $a0, '8', familia_8
        beq $a0, '9', familia_9

        familia_0:
            blt $a1, 3, seguir_familia_0
            jal normalizar_a_2
            seguir_familia_0:
            beq $a1, 1, caracter_0
            beq $a1, 2, caracter_espacio

        familia_1:
            blt $a1, 5, seguir_familia_1
            jal normalizar_a_4
            seguir_familia_1:
            beq $a1, 1, caracter_1
            beq $a1, 2, caracter_coma
            beq $a1, 3, caracter_punto
            beq $a1, 4, caracter_exclamacion

        familia_2:
            blt $a1, 5, seguir_familia_2
            jal normalizar_a_4
            move $a1, $v0
            seguir_familia_2:
            beq $a1, 1, caracter_a
            beq $a1, 2, caracter_b
            beq $a1, 3, caracter_c
            beq $a1, 4, caracter_2

        familia_3:
            blt $a1, 5, seguir_familia_3
            jal normalizar_a_4
            seguir_familia_3:
            beq $a1, 1, caracter_d
            beq $a1, 2, caracter_e
            beq $a1, 3, caracter_f
            beq $a1, 4, caracter_3
        
        familia_4:
            blt $a1, 5, seguir_familia_4
            jal normalizar_a_4
            seguir_familia_4:
            beq $a1, 1, caracter_g
            beq $a1, 2, caracter_h
            beq $a1, 3, caracter_i
            beq $a1, 4, caracter_4
        
        familia_5:
            blt $a1, 5, seguir_familia_5
            jal normalizar_a_4
            seguir_familia_5:
            beq $a1, 1, caracter_j
            beq $a1, 2, caracter_k
            beq $a1, 3, caracter_l
            beq $a1, 4, caracter_5
        
        familia_6:
            blt $a1, 5, seguir_familia_6
            jal normalizar_a_4
            seguir_familia_6:
            beq $a1, 1, caracter_m
            beq $a1, 2, caracter_n
            beq $a1, 3, caracter_o
            beq $a1, 4, caracter_6

        familia_7:
            blt $a1, 6, seguir_familia_7
            jal normalizar_a_5
            seguir_familia_7:
            beq $a1, 1, caracter_p
            beq $a1, 2, caracter_q
            beq $a1, 3, caracter_r
            beq $a1, 4, caracter_s
            beq $a1, 5, caracter_7
        
        familia_8:
            blt $a1, 5, seguir_familia_8
            jal normalizar_a_4
            seguir_familia_8:
            beq $a1, 1, caracter_t
            beq $a1, 2, caracter_u
            beq $a1, 3, caracter_v
            beq $a1, 4, caracter_8
        
        familia_9:
            blt $a1, 6, seguir_familia_9
            jal normalizar_a_5
            seguir_familia_9:
            beq $a1, 1, caracter_w
            beq $a1, 2, caracter_x
            beq $a1, 3, caracter_y
            beq $a1, 4, caracter_z
            beq $a1, 5, caracter_9

        caracter_a:
            lw $t0, puntero_string
            li $t1, 'a'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_b:
            lw $t0, puntero_string
            li $t1, 'b'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_c:
            lw $t0, puntero_string
            li $t1, 'c'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_d:
            lw $t0, puntero_string
            li $t1, 'd'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_e:
            lw $t0, puntero_string
            li $t1, 'e'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_f:
            lw $t0, puntero_string
            li $t1, 'f'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_g:
            lw $t0, puntero_string
            li $t1, 'g'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_h:
            lw $t0, puntero_string
            li $t1, 'h'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_i:
            lw $t0, puntero_string
            li $t1, 'i'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_j:
            lw $t0, puntero_string
            li $t1, 'j'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_k:
            lw $t0, puntero_string
            li $t1, 'k'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_l:
            lw $t0, puntero_string
            li $t1, 'l'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_m:
            lw $t0, puntero_string
            li $t1, 'm'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_n:
            lw $t0, puntero_string
            li $t1, 'n'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_o:
            lw $t0, puntero_string
            li $t1, 'o'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_p:
            lw $t0, puntero_string
            li $t1, 'p'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_q:
            lw $t0, puntero_string
            li $t1, 'q'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_r:
            lw $t0, puntero_string
            li $t1, 'r'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_s:
            lw $t0, puntero_string
            li $t1, 's'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_t:
            lw $t0, puntero_string
            li $t1, 't'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_u:
            lw $t0, puntero_string
            li $t1, 'u'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_v:
            lw $t0, puntero_string
            li $t1, 'v'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_w:
            lw $t0, puntero_string
            li $t1, 'w'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_x:
            lw $t0, puntero_string
            li $t1, 'x'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_y:
            lw $t0, puntero_string
            li $t1, 'y'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_z:
            lw $t0, puntero_string
            li $t1, 'z'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_0:
            lw $t0, puntero_string
            li $t1, '0'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_1:
            lw $t0, puntero_string
            li $t1, '1'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_2:
            lw $t0, puntero_string
            li $t1, '2'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_3:
            lw $t0, puntero_string
            li $t1, '3'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_4:
            lw $t0, puntero_string
            li $t1, '4'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_5:
            lw $t0, puntero_string
            li $t1, '5'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_6:
            lw $t0, puntero_string
            li $t1, '6'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_7:
            lw $t0, puntero_string
            li $t1, '7'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_8:
            lw $t0, puntero_string
            li $t1, '8'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

        caracter_9:
            lw $t0, puntero_string
            li $t1, '9'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_espacio:
            lw $t0, puntero_string
            li $t1, ' '
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_coma:
            lw $t0, puntero_string
            li $t1, ','
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_punto: 
            lw $t0, puntero_string
            li $t1, '.'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra
        
        caracter_exclamacion:
            lw $t0, puntero_string
            li $t1, '!'
            sb $t1, 0($t0)
            addi $t0, $t0, 1
            sw $t0, puntero_string
            jr $ra

# Funcion normalizar, recibe en $a1 el contador y lo normaliza a 4 o 5 y devuelve en $v0 el valor normalizado
        normalizar_a_4:
            blt $a1, 5, fin_normalizar           
            addi $a1, $a1, -4
            j normalizar_a_4
        
        normalizar_a_5:
            blt $a1, 6, fin_normalizar
            addi $a1, $a1, -5
            j normalizar_a_5

        normalizar_a_2:
            blt $a1, 3, fin_normalizar
            addi $a1, $a1, -2
            j normalizar_a_2
        
	fin_normalizar:
            move $v0, $a1

# FUNCION ENCRIPTACION ROT13

encriptar_rot13:
    la $t0, string_rot  # Cargar la dirección del String en $t0
    loop_encriptar:
        lb $t1, ($t0)       # Cargar un byte del String en $t1
    
        # Verificar si el byte es una letra y convertirla según corresponda
        beq $t1, 0, fin	# Si el byte es 0 quiere decir que llegamos al final, terminamos el bucle y mostramos mensaje de salida.
        bgt $t1, 122, proximo #Si el byte es mayor a 122 quiere decir que no es ninguna letra, lo mismo pasa si es menor a 65.
        blt $t1, 65, proximo
        bge $t1, 97, minusculas

    proximo:
        addi $t0, $t0, 1     # Avanzo al siguiente byte
        j loop_encriptar

    minusculas:
        addi $t1, $t1, 13    # Avanzo 13 posiciones en el alfabeto
        bgt $t1, 122, ajustar #Si el valor obtenido luego de avanzar es mayor al límite debo ajustarlo
        sb $t1, ($t0)        # Almaceno el byte resultante
        j proximo

    ajustar:
        addi $t1, $t1, -26   # Ajusto hacia atrás en caso de exceso, con módulo 26
        sb $t1, 0($t0)       # Almaceno el byte resultante
        j proximo

fin:
    # 1 cargar el mensaje en el buffer para mostrar en pantalla
    
    # 2 limpiar input y string
    la $t0, input_rot
    li $t1, 0
    loop_limpiar_input:
        sb $0, ($t0)
        addi $t0, $t0, 1
        bne $t1, 99, loop_limpiar_input
    
    la $t0, string_rot
    li $t1, 0
    loop_limpiar_string:
        sb $0, ($t0)
        addi $t0, $t0, 1
        bne $t1, 99, loop_limpiar_string
    # 3 volver al loop_main_rot13
    j loop_main_rot13




