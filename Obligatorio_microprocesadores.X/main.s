


# PUERTO G --> PIN 12 --> DC
# PUERTO G --> PIN 13 --> RES
    
.global main
.text
main:
    jal seteo_SPI
    jal seteo_Display
    jal seteo_Teclado
    
   #tenemos que tener un word o algo que nos diga en que elemento del main estamos. Pedimos entrada y procesamos. Si es un enter entramos al elemento que estamos, sino hacemos otra cosa.
   #si queremos entrar llamamos a la funcion de la app y delegamos las cosas.
fin:
    j fin

    
    
    
    
    
    
    
    
    
seteo_SPI:
    # Habilito el protocolo de comunicacion SPI e inicio la comunicacion
    li $t0, 0x8320    # Enable SPI module 0x8320 o 0x8060
    sw $t0, SPI1CON

    # Seteo la velocidad
    li $t0, 0    # Set baud rate to 11
    sw $t0, SPI1BRG

    # Configuro el puerto D como salida para el pin de control DC y RES
    li $t0, 0
    sw $t0, TRISG        
    
    jr $ra

    
seteo_Display:
    # Guardo el JAL
    addiu $sp, $sp, -4
    sw $ra, ($sp)
    
    jal seteo_pin_res
    
    jal esperar_envio
    # set_mux a el default en 63(3F)
    jal DC_comando
    li $t0, 0xA8        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    
    li $t0, 0x3F        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_display_offset a cero
    
    li $t0, 0xD3        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    
    li $t0, 0x00        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_display_start_line
    
    li $t0, 0x40        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_segment_map
    
    li $t0, 0xA0        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_com_output
    
    li $t0, 0xC0        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_com_config
    
    li $t0, 0xDA        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    
    li $t0, 2        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_contrast:
    
    li $t0, 0x81        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    
    li $t0, 0x7F        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # display_off
    
    li $t0, 0xA4        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_normal_display:
    
    li $t0, 0xA6       
    sb $t0, SPI1BUF
    jal esperar_envio
    
    # set_osc_frec:
    
    li $t0, 0xD5        
    sb $t0, SPI1BUF
    jal esperar_envio
    
    
    li $t0, 0xF        
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
    
    # display todo on
    
    li $t0, 0xA5        
    sb $t0, SPI1BUF
    jal esperar_envio
    
lw $ra, ($sp)
addiu $sp, $sp, 4
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
    
    
seteo_Teclado:
    li $t0, 0xF
    sw $t0, TRISE
    # Los primeros 4 pines son fila, los ultimos 4 son la columna
    li $t0, 0b11110000
    sw $t0, PORTE
    jr $ra