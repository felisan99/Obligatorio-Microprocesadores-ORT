
.text
.global seteo_Display
.global cargar_imagen
.global imprimir_char
.global posicion_siguiente_char
.global escribir_texto
.global imprimir_numero  
.global de_char_a_imagen  
   
seteo_Display:
    # GUARDO EL STACK
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ----------------
    #la $t0, posicion_siguiente_char
    #sb $0, ($t0)

    jal seteo_pin_res
    jal DC_comando

    # set_contrast:
    li $t0, 0x81
    sb $t0, SPI1BUF
    jal esperar_envio

    li $t0, 0x7F        
    sb $t0, SPI1BUF
    jal esperar_envio

    # enable_charge_pump:  
    li $t0, 0x8D        
    sb $t0, SPI1BUF
    jal esperar_envio

    li $t0, 0x14        
    sb $t0, SPI1BUF
    jal esperar_envio

    # display_power_on:
    li $t0, 0xAF        
    sb $t0, SPI1BUF
    jal esperar_envio

    # display address mode:
    li $t0, 0x20
    sb $t0, SPI1BUF
    jal esperar_envio
    
    li $t0, 0
    sb $t0, SPI1BUF
    jal esperar_envio

    # DEVUELVO EL STACK
    lw $ra, ($sp)
    addiu $sp, $sp, 4
    jr $ra
    # ----------------

# FUNCIONES DE EL DISPLAY

# Carga una imagen en el display
# En $a0 le entrego la direccion de memoria de la imagen que hay que cargar
cargar_imagen:
    #CUIDAR EL STACK
    addi $sp, $sp, -8
    sw $ra, ($sp)
    sw $s0, 4($sp)
    #----------------
    jal DC_dato   
    li $s0, 0
    loop_imagen:
        lb $t2, ($a0)
        sb $t2, SPI1BUF
        jal esperar_envio
        addi $a0, $a0, 1
        addi $s0, $s0, 1
        beq $s0, 1024, fin_imagen
	    j loop_imagen
    fin_imagen:
    #DEVUELVO EL STACK
    lw $ra, ($sp)
    lw $s0, 4($sp)
    addiu $sp, $sp, 8
    #----------------
    jr $ra


# # En $a0 le entrego el numero que quiero que imprima
#     imprimir_numero:
#         # CUIDO EL STACK
#         addiu $sp, $sp, -24
#         sw $ra, ($sp)
#         sw $s0, 4($sp)
#         sw $s1, 8($sp)
#         sw $s2, 12($sp)
#         sw $s3, 16($sp)
#         sw $s4, 20($sp)
#         # ----------------
# 	    jal DC_dato
#         jal de_numero_a_imagen
#         move $s4, $v0
#         li $s0, 0 # posicion en la imagen actual 0-1024
#         lb $s1, posicion_siguiente_char # posicion a la que quiero llegar para dibujar el char
#         la $s2, imagen_actual # puntero a la imagen que esta cargada en el display
#         li $s3, 0 # contador de cuantos bytes del char voy poniendo
#         loop_ir_a_posicion:
#             beq $s0, $s1, cargar_char
#             addi $s2, $s2, 1
# 	    addi $s0, $s0, 1
#             j loop_ir_a_posicion
#         cargar_char:
#             beq $s3, 8, fin_cargar_char
#             lb $t0, ($s4)
#             sb $t0, ($s2)
#             addi $s3, $s3, 1
#             addi $s4, $s4, 1
#             addi $s2, $s2, 1
#             j cargar_char
#         fin_cargar_char:
#             addi $s1, $s1, 8
#             blt $s1, 1024, guardar_nueva_posicion
#             li $s1, 0
#             guardar_nueva_posicion:
#             sb $s1, (posicion_siguiente_char)
#             la $a0, imagen_actual
#             jal cargar_imagen
#             # DEVUELVO EL STACK
#             lw $ra, ($sp)
#             lw $s0, 4($sp)
#             lw $s1, 8($sp)
#             lw $s2, 12($sp)
#             lw $s3, 16($sp)
#             lw $s4, 20($sp)
#             addiu $sp, $sp, 24
#             # ----------------
#             jr $ra

# # En $a0 le entrego el char que quiero que imprima
#     imprimir_char:
#         # CUIDO EL STACK
#         addiu $sp, $sp, -24
#         sw $ra, ($sp)
#         sw $s0, 4($sp)
#         sw $s1, 8($sp)
#         sw $s2, 12($sp)
#         sw $s3, 16($sp)
#         sw $s4, 20($sp)
#         # ----------------
# 	    jal DC_dato
#         jal de_char_a_imagen
#         move $s4, $v0
#         li $s0, 0 # contador hasta el lugar que tengo que llegar
#         lb $s1, posicion_siguiente_char # posicion a la que quiero llegar para dibujar el char
#         la $s2, imagen_actual # puntero a la imagen que esta cargada en el display
#         li $s3, 0 # contador de cuantos bytes del char voy poniendo
#         loop_ir_a_posicion_num:
#             beq $s0, $s1, cargar_num
#             addi $s2, $s2, 1
#             j loop_ir_a_posicion_num
#         cargar_num:
#             beq $s3, 8, fin_cargar_num
#             lb $t0, ($s4)
#             sb $t0, ($s2)
#             addi $s3, $s3, 1
#             addi $s4, $s4, 1
#             addi $s2, $s2, 1
#             j cargar_num
#         fin_cargar_num:
#             addi $s1, $s1,8
#             blt $s1, 1024, guardar_nueva_posicion
#             li $s1, 0
#             guardar_nueva_posicion_num:
#             sb $s1, (posicion_siguiente_char)
#             la $a0, imagen_actual
#             jal cargar_imagen
#             # DEVUELVO EL STACK
#             lw $ra, ($sp)
#             lw $s0, 4($sp)
#             lw $s1, 8($sp)
#             lw $s2, 12($sp)
#             lw $s3, 16($sp)
#             lw $s4, 20($sp)
#             addiu $sp, $sp, 24
#             # ----------------
#             jr $ra


# Recibe en $a0 el char y devuelve en $v0 el address a la imagen del char
de_char_a_imagen:
    beq $a0, 'a', cargar_a
    beq $a0, 'b', cargar_b
    beq $a0, 'c', cargar_c
    beq $a0, 'd', cargar_d
    beq $a0, 'e', cargar_e
    beq $a0, 'f', cargar_f
    beq $a0, 'g', cargar_g
    beq $a0, 'h', cargar_h
    beq $a0, 'i', cargar_i
    beq $a0, 'j', cargar_j
    beq $a0, 'k', cargar_k
    beq $a0, 'l', cargar_l
    beq $a0, 'm', cargar_m
    beq $a0, 'n', cargar_n
    beq $a0, 'o', cargar_o
    beq $a0, 'p', cargar_p
    beq $a0, 'q', cargar_q
    beq $a0, 'r', cargar_r
    beq $a0, 's', cargar_s
    beq $a0, 't', cargar_t
    beq $a0, 'u', cargar_u
    beq $a0, 'v', cargar_v
    beq $a0, 'w', cargar_w
    beq $a0, 'x', cargar_x
    beq $a0, 'y', cargar_y
    beq $a0, 'z', cargar_z
    beq $a0, '0', cargar_0
    beq $a0, '1', cargar_1
    beq $a0, '2', cargar_2
    beq $a0, '3', cargar_3
    beq $a0, '4', cargar_4
    beq $a0, '5', cargar_5
    beq $a0, '6', cargar_6
    beq $a0, '7', cargar_7
    beq $a0, '8', cargar_8
    beq $a0, '9', cargar_9
    beq $a0, ' ', cargar_esp
    beq $a0, ':', cargar_dos_puntos
    cargar_a:
        la $v0, img_a
        jr $ra
    cargar_b:
        la $v0, img_b
        jr $ra
    cargar_c:
        la $v0, img_c
        jr $ra
    cargar_d:
        la $v0, img_d
        jr $ra
    cargar_e:
        la $v0, img_e
        jr $ra
    cargar_f:
        la $v0, img_f
    cargar_g:
        la $v0, img_g
        jr $ra
    cargar_h:
        la $v0, img_h
        jr $ra
    cargar_i:
        la $v0, img_i
        jr $ra
    cargar_j:
        la $v0, img_j
        jr $ra
    cargar_k:
        la $v0, img_k
        jr $ra
    cargar_l:
        la $v0, img_l
        jr $ra
    cargar_m:
        la $v0, img_m
        jr $ra
    cargar_n:
        la $v0, img_n
        jr $ra
    cargar_o:
        la $v0, img_o
        jr $ra
    cargar_p:
        la $v0, img_p
        jr $ra
    cargar_q:
        la $v0, img_q
        jr $ra
    cargar_r:
        la $v0, img_r
        jr $ra
    cargar_s:
        la $v0, img_s
        jr $ra 
    cargar_t:
        la $v0, img_t
        jr $ra
    cargar_u:
        la $v0, img_u
        jr $ra
    cargar_v:
        la $v0, img_v
        jr $ra
    cargar_w:
        la $v0, img_w
        jr $ra
    cargar_x:
        la $v0, img_x
        jr $ra
    cargar_y:
        la $v0, img_y
        jr $ra
    cargar_z:
        la $v0, img_z
        jr $ra
    cargar_0:
        la $v0, img_0
        jr $ra
    cargar_1:
        la $v0, img_1
        jr $ra
    cargar_2:
        la $v0, img_2
        jr $ra
    cargar_3:
        la $v0, img_3
        jr $ra
    cargar_4:
        la $v0, img_4
        jr $ra
    cargar_5:
        la $v0, img_5
        jr $ra
    cargar_6:
        la $v0, img_6
        jr $ra
    cargar_7:
        la $v0, img_7
        jr $ra
    cargar_8:
        la $v0, img_8
        jr $ra
    cargar_9:
        la $v0, img_9
        jr $ra
    cargar_esp:
        la $v0, img_esp
        jr $ra
    cargar_dos_puntos:
	la $v0, img_dos_puntos
	jr $ra

# Espera a que el display este listo para recibir un nuevo dato
esperar_envio:
    lw $t0, SPI1STAT
    andi $t0, $t0, 0x8
    beqz $t0, esperar_envio
    jr $ra

# Controla el pin de DC entre funcion de comando y dato
DC_comando:
    # Pone a low el pin de DC
    li $t0, 0xFFFFFF7F
    lw $t1, PORTG
    and $t0, $t1, $t0
    sw $t0, PORTG
    jr $ra

DC_dato:
    # Pone a high el pin de DC
    li $t0, 0x00000080
    lw $t1, PORTG
    or $t0, $t1, $t0
    sw $t0, PORTG
    jr $ra

seteo_pin_res:
    # Seteo en low
    li $t0, 0xFFFFFFBF
    lw $t1, PORTG
    and $t0, $t1, $t0
    sw $t0, PORTG

    # Espero
    li $t0, 0
    espera_res:
	addi $t0, $t0, 1
	bne $t0, 10000, espera_res

    # Seteo el pin el high
    li $t0, 0x00000040
    lw $t1, PORTG
    or $t0, $t1, $t0
    sw $t0, PORTG
    jr $ra

# # Recibe en a0 el texto que se quiere escribir, y en a1 la cantidad de caracteres que tiene el texto
# escribir_texto:
#     # CUIDO EL STACK
#     addiu $sp, $sp, -16
#     sw $ra, ($sp)
#     sw $s0, 4($sp)
#     sw $s1, 8($sp)
#     sw $s2, 12($sp)
#     # ----------------
#     li $s0, 0
#     move $s1, $a0
#     move $s2, $a1
#     loop_texto:
#         lb $a0, ($s1)
# 	# ACA TEBGO QUE VER PORQUE YO TENGO UN ASCII Y NECESITO EN REALIDAD MANDARLE LA IMAGEN QUE CORRESPONDE A EL ASCII ESE
#         li $a1, 8
#         jal imprimir_char
#         addi $s1, $s1, 1
#         addi $s0, $s0, 1
#         bne $s0, $s2, loop_texto
#     # DEVUELVO EL STACK
#     lw $ra, ($sp)
#     lw $s0, 4($sp)
#     lw $s1, 8($sp)
#     lw $s2, 12($sp)
#     addiu $sp, $sp, 16
#     # ----------------
#     jr $ra

    


