.global main_tono
.text
main_tono:
    # Cuido el stack
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ----------------
# Sete el puerto como salida
    li $t0, 0
    sw $t0, TRISD
    la $a0, imagen_partitura
    jal cargar_imagen
    loop_main_tono:
        li $a0, 0
        jal leer_teclado
        beq $v0, 'a', final_tono
        beq $v0, '0', tono_0
        beq $v0, '1', tono_1
        beq $v0, '2', tono_2
        beq $v0, '3', tono_3
        beq $v0, '4', tono_4
        beq $v0, '5', tono_5
        beq $v0, '6', tono_6
        beq $v0, '7', tono_7
        beq $v0, '8', tono_8
        beq $v0, '9', tono_9
        j tono_general
    final_tono:
        # Devuelvo el stack
        lw $ra, ($sp)
        addiu $sp, $sp, 4
        jr $ra

tono_1:
    # Seteo la frecuencia
    li $a0, 10
    # Seteo el numero de periodos que van a sonar
    li $a1, 1600
    jal tocar_tono
tono_2:
    li $a0, 20
    li $a1, 1300
    jal tocar_tono
tono_3:
    li $a0, 30
    li $a1, 800
    jal tocar_tono
tono_4:
    li $a0, 40
    li $a1, 700
    jal tocar_tono
tono_5:
    li $a0, 50
    li $a1, 600
    jal tocar_tono
tono_6:
    li $a0, 60
    li $a1, 500
    jal tocar_tono
tono_7:
    li $a0, 75
    li $a1, 400
    jal tocar_tono
tono_8:
    li $a0, 80
    li $a1, 300
    jal tocar_tono
tono_9:
    li $a0, 90
    li $a1, 200
    jal tocar_tono
tono_0:
    li $a0, 100
    li $a1, 200
    jal tocar_tono
tono_general:
    li $a0, 110
    li $a1, 200
    jal tocar_tono

tocar_tono:
    li $t0, 0
    li $t2, 0
    loop_tono:
        li $t1, 1
        sw $t1, PORTD
        addi $t0, $t0, 1
        beq $t0, $a0, fin_tono_high
        j loop_tono
        fin_tono_high:
            li $t0, 0
            loop_tono_low:
                li $t1, 0
                sw $t1, PORTD
                addi $t0, $t0, 1
                beq $t0, $a0, fin_loop_tono
                j loop_tono_low
    fin_loop_tono:
        addi $t2, $t2, 1
	    li $t0, 0
        bne $t2, $a1, loop_tono
	    j loop_main_tono
