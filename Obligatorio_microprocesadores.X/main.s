# PUERTO G --> PIN 12 --> DC
# PUERTO G --> PIN 13 --> RES
# GND --> GND --> CS
.global main
.text
main:
    jal seteo_SPI
    jal seteo_Display
    jal seteo_teclado
    jal leer_teclado
    
fin:
    j fin
