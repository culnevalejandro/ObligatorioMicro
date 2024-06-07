.globl imprimirTexto
	.data
	a: .byte 0x7C,0x7E,0x13,0x13,0x7E,0x7C,0x00,0x00
	b: .byte 0x41, 0x7F, 0x7F, 0x49, 0x49, 0x7F, 0x36, 0x00
	c: .byte 0x1C, 0x3E, 0x63, 0x41, 0x41, 0x63, 0x22, 0x00
	d: .byte 0x41, 0x7F, 0x7F, 0x41, 0x63, 0x3E, 0x1C, 0x00
	e: .byte 0x41, 0x7F, 0x7F, 0x49, 0x5D, 0x41, 0x63, 0x00
	f: .byte 0x41, 0x7F, 0x7F, 0x49, 0x1D, 0x01, 0x03, 0x00
	g: .byte 0x1C, 0x3E, 0x63, 0x41, 0x51, 0x73, 0x72, 0x00
	h: .byte 0x7F, 0x7F, 0x08, 0x08, 0x7F, 0x7F, 0x00, 0x00
	i: .byte 0x00, 0x41, 0x7F, 0x7F, 0x41, 0x00, 0x00, 0x00
	j: .byte 0x30, 0x70, 0x40, 0x41, 0x7F, 0x3F, 0x01, 0x00
	k: .byte 0x41, 0x7F, 0x7F, 0x08, 0x1C, 0x77, 0x63, 0x00
	l: .byte 0x41, 0x7F, 0x7F, 0x41, 0x40, 0x60, 0x70, 0x00
	m: .byte 0x7F, 0x7F, 0x0E, 0x1C, 0x0E, 0x7F, 0x7F, 0x00
	n: .byte 0x7F, 0x7F, 0x06, 0x0C, 0x18, 0x7F, 0x7F, 0x00
	o: .byte 0x1C, 0x3E, 0x63, 0x41, 0x63, 0x3E, 0x1C, 0x00
	p: .byte 0x41, 0x7F, 0x7F, 0x49, 0x09, 0x0F, 0x06, 0x00
	q: .byte 0x1E, 0x3F, 0x21, 0x71, 0x7F, 0x5E, 0x00, 0x00
	r: .byte 0x41, 0x7F, 0x7F, 0x09, 0x19, 0x7F, 0x66, 0x00
	s: .byte 0x26, 0x6F, 0x4D, 0x59, 0x73, 0x32, 0x00, 0x00
	t: .byte 0x03, 0x41, 0x7F, 0x7F, 0x41, 0x03, 0x00, 0x00
	u: .byte 0x7F, 0x7F, 0x40, 0x40, 0x7F, 0x7F, 0x00, 0x00
	v: .byte 0x1F, 0x3F, 0x60, 0x60, 0x3F, 0x1F, 0x00, 0x00
	w: .byte 0x7F, 0x7F, 0x30, 0x18, 0x30, 0x7F, 0x7F, 0x00
	x: .byte 0x43, 0x67, 0x3C, 0x18, 0x3C, 0x67, 0x43, 0x00
	y: .byte 0x07, 0x4F, 0x78, 0x78, 0x4F, 0x07, 0x00, 0x00
	z: .byte 0x47, 0x63, 0x71, 0x59, 0x4D, 0x67, 0x73, 0x00
	
	pos_inicial: .half 0x0000
.text
	
	
	# Recibe en a0 la page y columna inicial, igual que draw bitmap
	# Recibe en a2 la direccion de memoria que tiene el ascii que quiero escribir
imprimirTexto:
	
	addi    $sp, $sp, -12
	sw	    $ra, ($sp)
	sw	    $s1, 4($sp)
	sw	    $s2, 8($sp)
	
	move	$s1, $a2
	move	$s2, $a0
	
	loop:
	andi $t0, $s2, 0x80
	bne $t0, 0x80, imprimir 
	addi $s2, $s2, 0x0100 # Salto de page
	andi $s2, $s2, 0xFF00 # Reset columna
imprimir:
	la		$t1, a
	lb		$t0, ($s1) # Cargo la letra 
	beq		$t0, $0, finTexto
	beq		$t0, 32, espacio
	addi	$t0, $t0, -65
	mul		$t0, $t0, 8
	add		$t1, $t0, $t1
	move	$a0, $s2
	li		$a1, 0x0808
    add	    $a2, $0, $t1
    jal		draw_bitmap
	
espacio:
	
	addi	$s1, $s1, 1
	addi	$s2, $s2, 8
	j loop
	
	
finTexto:
	lw	    $ra, ($sp)
	lw	    $s1, 4($sp)
    lw	    $s2, 8($sp)
 	addi    $sp, $sp, 12
	
	sh $s2, pos_inicial
	
	jr $ra
	
