.globl main
.text
.ent main
    
main:
    
    jal	    init_pins
    jal	    init_spi
    jal	    init_ssd1306
    
    main_loop:
    
    li	    $t0, 0
    j	    main_loop
    
    
    
    li	    $v0, 10
    syscall
    