main:
	addi 	$sp, $0, 48
	addi	$a0, $0, 4	# set arg
	jal 	factorial	# compute the factorial
	add 	$s0, $v0, $0	# move result into $s0  	NOTE: Program should end here but it falls back into the factorial loop
	j end
factorial:
	addi 	$sp, $sp, -8 	# make room on stack
	sw 	$a0, 4($sp) 	# store $a0
	sw 	$ra, 0(	$sp) 	# store $ra
	addi 	$t0, $0, 2 	# $t0 = 2
	slt 	$t0, $a0, $t0	# a <= 1 ?
	beq 	$t0, $0, else 	# no - goto else
	addi 	$v0, $0, 1	# yes - return 1
	addi 	$sp, $sp, 8 	# restore $sp
	jr 	$ra 		# return
else:
	addi 	$a0, $a0, -1 	# n = n - 1
	jal 	factorial 	# recursive call
	lw 	$ra, 0($sp) 	# restore $ra
	lw 	$a0, 4($sp) 	# restore $a0
	addi 	$sp, $sp, 8 	# restore $sp
	multu 	$a0, $v0 	# n * factorial(n-1)
	mflo 	$v0 		# mv result into $v0
	jr 	$ra
end:
