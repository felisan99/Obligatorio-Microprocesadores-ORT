.data
input_rot: .space 100
string_rot: .space 100
.align
puntero_string: .space 4
entrada: .asciiz "Entrada: "
salida: .asciiz "\nSalida: "

.text
#	Leo el mensaje que se desea encriptar
main_rot13:
    # Cuido el STACK
    addiu $sp, $sp, -8
    sw $ra, ($sp)
    sw $s0, 4($sp)
    # ---------------
    la $s0, input_rot
    la $t0, string_rot
    sw $t0, puntero_string
    loop_leer_nuevo_caracter:
        # Leo una primera entrada en modo lectura normal
        li $a0, 0
        jal leer_teclado
        beq $v0, 'D', procesar_entrada_rot13
        sb $v0, ($s0)
        addi $s0, $s0, 1

    # Leo otra vez, teniendo en cuenta el tiempo
    loop_repetido:
        li $a0, 1
        jal leer_teclado
        beq $v0, 'D', procesar_entrada_rot13
        lb $t1, -1($s0)
        bne $v0, $t1, guardar_caracter
        beq $v0, '-', loop_leer_mensaje 
        
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
    # Devuelvo el STACK
    lw $ra, ($sp)
    lw $s0, 4($sp)
    addiu $sp, $sp, 8
    # ---------------
    jr $ra

procesar_entrada:
    la $t0, input_rot
    loopPrincipal:
        beq $t0,0, INICIO DE encriptacion #terminó la cadena
        addi $t1,0 #contador
        lb $a0, ($t0)
        loopSecuencia:
            beq $t0,'-',finSecuencia
            addi $t1,$t1,1
            addi $t0,$t0,1
        j loopSecuencia
        finSecuencia:
            addi $t0,$t0,1
            move $a1, $t1
            jal procesar_caracter
            j loopPrincipal
    
    # Le paso en $a0 el numero del caracter y $a1 el contador
    procesar_caracter:
        beq $a0, '2', familia_2
        beq $a0, '3', familia_3
        beq $a0, '4', familia_4
        beq $a0, '5', familia_5
        beq $a0, '6', familia_6
        beq $a0, '7', familia_7
        beq $a0, '8', familia_8
        beq $a0, '9', familia_9

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
            blt $a1, 5, seguir_familia_
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

        familia_1:
            blt $a1, 5, seguir_familia_1
            jal normalizar_a_4
            seguir_familia_1:
            beq $a1, 1, caracter_1
            beq $a1, 2, caracter_coma
            beq $a1, 3, caracter_punto
            beq $a1, 4, caracter_exclamacion

        familia_0:
            blt $a1, 3, seguir_familia_0
            jal normalizar_a_2
            seguir_familia_0:
            beq $a1, 1, caracter_0
            beq $a1, 2, caracter_espacio

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
            


# Funcion normalizar, recibe en $a1 el contador y lo normaliza a 4 o 5 y devuelve en $v0 el valor normalizado
        normalizar_a_4:
            blt $a1, 5, fin_normalizar
            loop_norm_4:
                addi $a1, $a1, -4
                j normalizar_a_4
        
        normalizar_a_5:
            blt $a1, 6, fin_normalizar
            loop_norm_4:
                addi $a1, $a1, -5
                j normalizar_a_5

        normalizar_a_2:
            blt $a1, 3, fin_normalizar
            loop_norm_2:
                addi $a1, $a1, -2
                j normalizar_a_2
        fin_normalizar:
            move $v0, $a1

#	Descarto la encriptacion de caracteres que no son letras
inicio:
lb $t1, ($t0)		# Cargo el caracter en $t1
ble $t1, 64, imprimir	# NO ENCRIPTO SI ES MENOR A 'A'
bge $t1, 123, imprimir	# NO ENCRIPTO SI ES MAYOR A 'z'
bge $t1, 91, entre_A_a  # Verifico los caracteres que estan entre 'A' y 'a'
j encriptar

entre_A_a:
ble $t1, 96, imprimir	# NO ENCRIPTO SI ESTA EN EL MEDIO
j encriptar

#	Comienzo el algoritmo para encriptar el mensaje
encriptar:
#	Clasifico si desborda y si no desborda lo imprimo
ble $t1, 90, mayuscula
bge $t1, 97, minuscula

mayuscula:		# Es mayuscula y sumo 13, si queda por arriba de 91 desborda entonces ajusto en label desborda, si no imprimo
addi, $t1, $t1, 13
bge $t1, 91, desborda	
j imprimir

minuscula:		# Es minuscula y sumo 13, si queda por arriba de 123 desborda entonces ajusto en label desborda, si no imprimo
addi, $t1, $t1, 13
bge $t1, 123, desborda
j imprimir

desborda:
addi $t1, $t1, -26
j imprimir

#	Imprimo el caracter
imprimir:
li $v0, 11
move $a0, $t1
syscall
j siguiente_caracter

#	Paso al siguiente caracter o me voy al final si es el caracter nulo
siguiente_caracter:
addi $t0, $t0, 1
lb $t1, ($t0)
beq $0, $t1, final
j inicio

final:



