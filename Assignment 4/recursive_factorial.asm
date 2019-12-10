# $a0 = array base address
# $a1 = n
# $s0 = n!

Main:	
	addi $a0, $0, 0x100	 	# array base address = 0x100
 	addi $a1, $0, 0 		# i = 0
 	addi $t0, $0, 3			# store 3 for use in for loop
 	addi $t1, $0, 50	 	# $t1 = 50
 
CreateArray_Loop:
 	slt $t2, $a1, $t1 		# i < 50?
 	beq $t2, $0, Exit_Loop 		# if not then exit loop
 	sll $t2, $a1, 2 		# $t2 = i * 4 (byte offset)
 	add $t2, $t2, $a0 		# address of array[i]
 	mult $a1, $t0			
 	mflo $t3 			# $t3 = i * 3
 	sw $t3, 0($t2) 			# save array[i]
 	addi $a1, $a1, 1 		# i = i + 1
	j CreateArray_Loop

 Exit_Loop: 	
 	# n = (my_array[25] + my_array[30])/30
 	lw $t0, 100($a0) 		# loading my_array[25]
	lw $t1, 120($a0) 		# loading my_array[30]
	add $a1, $t0, $t1		# add my_array[25] and my_array[30]
	ori $t0, $0, 30			# load imm 30 for division
	div $a1, $t0			# divide n by 30
	mflo $a1			# store result into n = 5
 	
 	# factorial computation
 	jal factorial 			# call procedure
 	add $s0, $v0, $0 		# return value
 	j   end

factorial:
 	addi 	$sp, $sp, -8 		# make room on the stack
 	sw 	$a1, 4($sp) 		# store $a1
 	sw 	$ra, 0($sp) 		# store $ra
 	addi 	$t0, $0, 2		# $t0 = 2
 	slt 	$t0, $a1, $t0 		# n <= 1?
 	beq 	$t0, $0, else		# no: go to else (recursion)
 	addi 	$v0, $0, 1		# yes: return 1
 	addi 	$sp, $sp, 8		# restore $sp
 	jr 	$ra			# return
else: 	addi	$a1, $a1, -1		# n = n -1
 	jal	factorial		# recursive call
 	lw 	$ra, 0($sp)		# restore return address
 	lw	$a1, 4($sp)		# restore input
 	addi	$sp, $sp, 8		# restore $sp
 	mul 	$v0, $a1, $v0		# n * factorial(n-1)
 	jr 	$ra			# return
 	
end: 	sw $a1, 0($0)			# store n in 0x00
	sh $s0, 10($0)			# store n! in 0x10
	# finish
