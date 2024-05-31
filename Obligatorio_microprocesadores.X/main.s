# PUERTO G --> PIN 12 --> DC
# PUERTO G --> PIN 13 --> RES  
.global main
.text
main:
    jal seteo_SPI
    jal seteo_Display
    jal seteo_Teclado
fin:
    j fin
