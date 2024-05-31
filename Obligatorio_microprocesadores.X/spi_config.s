.global seteo_SPI
.text
# Habilito el protocolo de comunicacion SPI e inicio la comunicacion
seteo_SPI:
    # Activo toda la configuracion de el periferico SPI module 0x832
    li $t0, 0x8320    
    sw $t0, SPI1CON

    # Seteo la velocidad
    li $t0, 1
    sw $t0, SPI1BRG

    # Configuro el puerto D como salida para el pin de control DC y RES
    li $t0, 0
    sw $t0, TRISG        
    
    jr $ra

