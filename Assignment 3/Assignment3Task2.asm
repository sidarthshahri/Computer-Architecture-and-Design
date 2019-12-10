#       Assembly                Description  
main:	ori	$4, $0, 5  	# Initialize n = 5 ($4 = 0 OR 5)
	sw     	$4, ($0)   	# Save n to memory location 0
	ori    	$16,  $0, 1 	# Initialize f = 1 
loop:	li      $19, 1	        # Load 1 for comparison and for decrementing n
	mult    $16, $4   	# Multiply f * n (mflo required for mult b/c possibly greater than 32-bit result)
	mflo    $16		# Move calculated value from LO to f 
	sub     $4, $4, $19     # n - 1
	slt 	$20, $19, $4	# Set s4 to 1 if n >= 1, else store 0 into 20
	bne 	$20, $0, loop   # Branch to loop if s4 != 0 (for while loop)
	sw      $16, 0x10($0) 	# Store final value of f into memory location 10 (f = n!)