
.globl main
.data
    icono: .space 1024
    dibujo: .byte 0xF, 0xF0
    .text
.ent main
    
main:
    
    jal	    init_pins
    jal	    init_spi
    jal	    init_ssd1306
    
    # lleno el array de la pantalla de ceros
    la $t0,icono
    li $t1,0x0
    li $t2,1023
    llenarArray:
	sb $t1,($t0)
	addi $t0,$t0,1
	beqz $t2,finLlenarArray
	addi $t2,$t2,-1
    j llenarArray
    
    finLlenarArray:
    la $t1, icono
    li $t0, 0xFF
    sb  $t0, icono
    addi $t1, $t1, 1
    li $t0, 0xFF
    sb  $t0, ($t1)
    addi $t1, $t1, 8
    li $t0, 0xFF
    sb  $t0, ($t1)
    la $a2, icono
    jal mandar_bitmap
    
#     la $a2, letra
#     jal mandar_bitmap
    
    
    
    main_loop:
    
    li	    $t0, 0
    j	    main_loop
    
    
    
    li	    $v0, 10
    syscall
    