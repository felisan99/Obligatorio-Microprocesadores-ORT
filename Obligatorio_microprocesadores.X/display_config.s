.global seteo_Display
.global cargar_imagen
.text
seteo_Display:
    # GUARDO EL STACK
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    # ----------------

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

    # set_mux a el default en 63(3F)
   
    
    #li $t0, 0xA8        
    #sb $t0, SPI1BUF
    #jal esperar_envio


    #li $t0, 0x3F        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_display_offset a cero

    #li $t0, 0xD3        
    #sb $t0, SPI1BUF
    #jal esperar_envio


    #li $t0, 0x00        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_display_start_line

    #li $t0, 0x40        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_segment_map

    #li $t0, 0xA0        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_com_output

    #li $t0, 0xC0        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_com_config

    #li $t0, 0xDA        
    #sb $t0, SPI1BUF
    #jal esperar_envio


    #li $t0, 2        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_contrast:

    # display_off

    #li $t0, 0xA4        
    #sb $t0, SPI1BUF
    #jal esperar_envio

    # set_normal_display:

    #li $t0, 0xA6       
    #sb $t0, SPI1BUF
    #jal esperar_envio


# En $a0 le entrego el address a la imagen que quiero cargar    
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
        bne $s0, 1024, loop_imagen
    #DEVUELVO EL STACK
    lw $ra, ($sp)
    lw $s0, 4($sp)
    addiu $sp, $sp, 8
    #----------------
    jr $ra

esperar_envio:
    lw $t0, SPI1STAT
    andi $t0, $t0, 0x8
    beqz $t0, esperar_envio
    jr $ra

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


    


