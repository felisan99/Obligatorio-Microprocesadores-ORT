# PUERTO G --> PIN 12 --> DC
# PUERTO G --> PIN 13 --> RES
# GND --> GND --> CS

.data
    .asciiz "test"
.align 2
stack: .space 44    # Espacio para 10 numeros de 32 bits
.align 2
input: .space 4	    # Espacio para que usuario ingrese datos
.align 2					
puntero: .space 4
cantidad: .space 1
operacion .space 1

.text
.global main
.global stack
.global input    
.global cantidad
.global puntero    


main:
    jal seteo_SPI
    jal seteo_Display
    jal seteo_teclado
    jal seteo_calculadora
    jal loop_main_calculadora
    
fin:
    j fin
