# Label	Assembly		Description
main:   addi 	$t0, $0, 0x0F	# $t0 = 0x0F
	addi 	$t1, $0, 1	# $t1 = 1
	sll  	$t4, $t1, 4	# $t4 = $t1 << 4	
	
fact:   lw   	$t2, 0x0900($0)	# read switches
	and  	$t3, $t2, $t0	# get input data n
	sw   	$t3, 0x0800($0)	# write input data n
	sw   	$t1, 0x0804($0)	# write control Go bit
	
	
poll:   lw   	$t5, 0x0808($0)	# read status Done bit
        beq  	$t5, $0, poll	# wait until Done == 1
        
        srl  	$t5, $t5, 1	# $t5 = $t5 >> 1
        and  	$t5, $t5, $t1	# get status Error bit
        and  	$t3, $t2, $t4	# get display Select
        or  	$t3, $t3, $t5	# combine Sel and Err
        lw  	$t5, 0x080C($0)	# read result data nf
        sw  	$t3, 0x0908($0)	# display Sel and Err
        sw  	$t5, 0x090C($0)	# display result nf
        
 done:  j  	fact		# repeat fact loop
