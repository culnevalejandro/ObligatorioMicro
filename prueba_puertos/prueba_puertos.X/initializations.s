init_oled:
    # Inicialización del display OLED
    li $t0, 0xAE               # Display Off
    jal send_command
    li $t0, 0xD5               # Set Display Clock Divide Ratio/Oscillator Frequency
    jal send_command
    li $t0, 0x80               # Default value for the oscillator frequency and clock divide ratio
    jal send_command
    li $t0, 0xA8               # Set Multiplex Ratio
    jal send_command
    li $t0, 0x3F               # Multiplex ratio for 128x64 display
    jal send_command
    li $t0, 0xD3               # Set Display Offset
    jal send_command
    li $t0, 0x00               # No offset
    jal send_command
    li $t0, 0x40               # Set Display Start Line
    jal send_command
    li $t0, 0x8D               # Charge Pump Setting
    jal send_command
    li $t0, 0x14               # Enable charge pump
    jal send_command
    li $t0, 0x20               # Set Memory Addressing Mode
    jal send_command
    li $t0, 0x00               # Horizontal addressing mode
    jal send_command
    li $t0, 0xA1               # Set Segment Re-map to reverse mode
    jal send_command
    li $t0, 0xC8               # Set COM Output Scan Direction to reverse mode
    jal send_command
    li $t0, 0xDA               # Set COM Pins hardware configuration
    jal send_command
    li $t0, 0x12               # Alternative COM pin configuration, disable COM left/right remap
    jal send_command
    li $t0, 0x81               # Set Contrast Control
    jal send_command
    li $t0, 0xCF               # Set contrast value
    jal send_command
    li $t0, 0xD9               # Set Pre-charge Period
    jal send_command
    li $t0, 0xF1               # Phase 1 and 2 periods
    jal send_command
    li $t0, 0xDB               # Set VCOMH Deselect Level
    jal send_command
    li $t0, 0x40               # VCOMH deselect level
    jal send_command
    li $t0, 0xA4               # Entire Display ON (resume to RAM content display)
    jal send_command
    li $t0, 0xA6               # Set Normal Display
    jal send_command
    li $t0, 0xAF               # Display ON
    jal send_command
    li $t0, 0xA5               # Entire Display ON (All pixels ON)
    jal send_command
    
    jr $ra


# Subrutina para enviar comandos al display
send_command:
    li      $t1, 0x00               # Data mode
    sw      $t1, 0xBF886130         # Set DC pin high
    sw      $t0, 0xBF805830         # Write data to SPI2BUF
    jr      $ra
    
    
    
    