.global main_tono
.text
main_tono:
    li $t0, 0
    sw $t0, TRISD
    jal leer_teclado
    move $t0, $v0
    j tono_do
    #beq $t0, '1', tono_do
    #beq $t0, '2', tono_re
    #beq $t0, '3', tono_mi
    #beq $t0, '4', tono_fa
    #beq $t0, '5', tono_sol
    #beq $t0, '6', tono_la
    #beq $t0, '7', tono_si
    j main_tono


tono_do:
    li $t0, 0
    li $t2, 0
    loop_do:
        li $t1, 1
        sw $t1, PORTD
        addi $t0, $t0, 1
        beq $t0, 5333333, fin_do_high
        j loop_do
        fin_do_high:
            li $t0, 0
            loop_do_low:
                li $t1, 0
                sw $t1, PORTD
                addi $t0, $t0, 1
                beq $t0, 5333333, tono_do
                j loop_do_low
    fin_loop_do:
        addi $t2, $t2, 1
        beq $t2, 100, fin_tono
        j tono_do

    fin_tono:
	j fin_tono