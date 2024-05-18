.global main
.text
.ent main /* entry point, donde iniciar el programa */

main:
# Configurar puertos F y G como salida
li $t0, 0
sw $t0, TRISF
li $t0, 0
sw $t0, TRISG
    
# Vamos a prender un LED y apagar el otro
li $t0, 0
loop:
li $t1, 0
li $t2, 150000
l:
addiu $t1, $t1, 1
bne $t1, $t2, l
    
# Direcciones de los puertos
la $t3, PORTF
la $t4, PORTG
sw $t0, ($t3)
nor $t0, $t0, $0 # negar
sw $t0, ($t4)
j loop
.end main /* Indica el final de main */