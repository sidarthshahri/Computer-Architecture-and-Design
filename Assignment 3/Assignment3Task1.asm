main:	ori	$4, $0, 0x8000	# a = 0x8000
	ori	$5, $0, 0x00A9	# b = 0x00A9
	ori	$16, $0, 1974	# c = 1974	
	
	mult  	$4, $4		# x = a * a
	mflo	$17		# Move lower 32 bits of mult into x
	sw	$17, 0x20($0)	# Store x into 0x20
	mult 	$17, $5		# y = x * b
	mflo	$18		# Move lower 32 bits of mult into y
	sw	$18, 0x24($0)	# Store y into 0x24
	mfhi 	$19		# Move upper 32 bits of mult (x * b) into temp (s3)
	sw 	$19, 0x28($0)	# Store temp into 0x28 (0x24 is lower 32 bits of y = x * b, 0x28 is upper 32 bits)
	sll 	$19, $19, 16	# Shift upper 32 bits of y left 16 bits
	srl	$18, $18, 16	# Shift lower 32 bits of y right 16 bits
	or	$18, $18, $19	# Goal: y = 0x002a4000
	
loop:	div 	$18, $16	# First, y / c [Performing c = (c + y / c) / 2]
	mflo	$19		# Store quotient from LO to temp [Performing c = (c + y / c) / 2]
	add 	$19, $19, $16   # Second, c + temp [Performing c = (c + y / c) / 2]
	li	$20, 2		# Load 2 for division [Performing c = (c + y / c) / 2]
	div 	$19, $20	# Divide temp by 2 [Performing c = (c + y / c) / 2]
	mflo 	$16		# Store quotient from LOW in c [Performing c = (c + y / c) / 2]
	sw 	$16, 0x2C($0)	# Store c into 0x2C 
	li      $19, 1665	# Load 1665 for comparison
	slt 	$20, $19, $16	# Set s4 to 1 if c >= 1665, else 0
	bne 	$20, $0, loop	# Branch if s4 not equal to 0 [while(c >= 1665)]
e_loop:	sll	$16, $16, 8	# Shift c left by 8 bits 
	sw 	$16, 0x30($0)	# Save c to 0x30