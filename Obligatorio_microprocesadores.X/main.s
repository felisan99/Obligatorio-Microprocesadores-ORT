# PUERTO G --> PIN 12 --> DC
# PUERTO G --> PIN 13 --> RES
# GND --> GND --> CS

.global main
.global stack      
.global operacion

.data
test: .asciiz "test"

.align 2
menu_fila: .space 1
menu_columna: .space 1
operacion: .space 1

.text
main:
    sb $0, menu_fila
    sb $0, menu_columna
    sb $0, operacion
    
    jal seteo_SPI
    jal seteo_Display
    jal seteo_teclado
    jal seteo_calculadora
    loop_menu:    
	jal menu_segun_posicion
	li $a0, 0
	jal leer_teclado
	jal esperar_debounce
	beq $v0, '2', cambio_fila
	beq $v0, '8', cambio_fila
	beq $v0, '4', cambio_columna
	beq $v0, '6', cambio_columna
	beq $v0, 'd', iniciar_aplicacion
	# MOSTRAR ERROR DE NO INGRESO ALGO VALIDO
	j loop_menu
    
    # Caso que ingresan 2 u 8 vas para arriba o para abajo que significa negar el primer bit de lugar_menu
    cambio_fila:
        lb $t0, menu_fila
        xori $t0, $t0, 1 
        sb $t0, menu_fila
        j loop_menu

    # Caso que ingresan 4 o 6 vas para derecha o para izquierda que significa negar el segundo bit de lugar_menu
    cambio_columna:
        lb $t0, menu_columna
        xori $t0, $t0, 1 
        sb $t0, menu_columna
        j loop_menu

    menu_segun_posicion:
        #CUIDO EL STACK
        addiu $sp, $sp, -4
        sw $ra, ($sp)
        #----------------
        lb $t0, menu_fila
        lb $t1, menu_columna
        andi $t0, $t0, 1
        andi $t1, $t1, 1
        beq $t0, 0, fila_1_imagen
        beq $t0, 1, fila_2_imagen

        fila_1_imagen:
            beq $t1, 0, mostrar_calculadora
            beq $t1, 1, mostrar_rot13
        fila_2_imagen:
            beq $t1, 0, mostrar_tono
            beq $t1, 1, mostrar_opcional

        mostrar_calculadora:
            la $a0, imagen_calculadora
            jal cargar_imagen
            #DEVUELVO EL STACK
            lw $ra, ($sp)
            addiu $sp, $sp, 4
            jr $ra
            # ----------------
        mostrar_rot13:
            la $a0, imagen_rot
            jal cargar_imagen
            # DEVUELVO EL STACK
            lw $ra, ($sp)
            addiu $sp, $sp, 4
            jr $ra
            # ----------------
        mostrar_opcional:
            la $a0, imagen_opcional
            jal cargar_imagen
            # DEVUELVO EL STACK
            lw $ra, ($sp)
            addiu $sp, $sp, 4
            jr $ra
            # ----------------
        mostrar_tono:
            la $a0, imagen_tono
            jal cargar_imagen
            # DEVUELVO EL STACK
            lw $ra, ($sp)
            addiu $sp, $sp, 4
            jr $ra
            # ----------------


    # Cuando apretan D (enter) se fija en que lugar fila, columna esta y llama a el main de la aplicacion correspondiente
    iniciar_aplicacion:
        lb $t0, menu_fila
        lb $t1, menu_columna
        andi $t0, $t0, 1
        andi $t1, $t1, 1
        beq $t0, 0, fila_1
        beq $t0, 1, fila_2

        fila_1:
            beq $t1, 0, inicio_calculadora
            beq $t1, 1, inicio_rot13
        fila_2:
            beq $t1, 0, inicio_tono
            beq $t1, 1, inicio_extra
    
    inicio_calculadora:
        jal main_calculadora
        j loop_menu
    inicio_rot13:
        jal main_rot13
        j loop_menu
    inicio_tono:
        jal main_tono
        j loop_menu
    inicio_extra:
        jal main_calculadora
        j loop_menu
fin:
    j fin

