main:
    addi $a0, $zero, 10 # n = 10
    addi $a1, $zero, 5  # m = 5
    jal pascal          # call pascal(10, 5)
    j exit

pascal:
    addi $sp, $sp, -16
    sw $ra, 0($sp)    # Save $ra register into stack
    sw $s0, 4($sp)    # Save $a0 variable ( n ) 
    sw $s1, 8($sp)    # Save $a1 variable ( m )
    sw $s2, 12($sp)
    
    add $s0, $a0, $zero
    add $s1, $a1, $zero
    
    beq $s0, $s1, return1
    beq $s1, $zero, return1
      
    addi $a0, $s0, -1   # n - 1
    
    jal pascal          #  pascal( n-1, m )
    
    add  $s2, $zero, $v0  # return form pascal( n-1, m ) 
    
    add  $a0, $s0, -1   # n - 1
    add  $a1, $s1, -1   # m - 1
    
    jal  pascal	        # pascal( n-1, m-1 )
    
    add $v0, $v0, $s2
    
  exitpascal:
      lw   $ra, 0($sp)
      lw   $s0, 4($sp)
      lw   $s1, 8($sp) 
      lw   $s2, 12($sp)
      addi $sp, $sp, 16
      jr   $ra
  
  return1:
      addi $v0, $zero, 1
      j    exitpascal

exit: