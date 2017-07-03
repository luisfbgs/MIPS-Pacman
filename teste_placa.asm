.data
	in1: 	.word 1
	in2: 	.word 2
	in7: 	.word 3
	in3: 	.float 1.5
	in4: 	.float 4.0
	in5: 	.float 2.0
	in6: 	.float -2.0
	cpmuls: .float 6.0
	cpadds: .float 5.5
	cpsubs: .float 2.5
	estate: .word  0
	testw: .word 0
	testb: .byte 0
	testh: .half 0
.text
li $s7,0
li $s6,0
li $sp,0x10011ffc

j main
nop
nop

acertor:
	li $v0,1
	jr $ra
error: 	li $v0,-1
	jr $ra
	
soma: 	
	lw $t0,in1
	lw $t1,in2
	li $t2,3
	li $a0,1
	
	add $t0,$t0,$t1
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
		
multiplicacao:



	lw $t0,in1
	lw $t1,in2
	li $t2,2
	li $a0,2
	
	mult $t0,$t1
	mflo $t0
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
subtracao:	

	lw $t0,in1
	lw $t1,in2
	li $t2,-1
	li $a0,3
	
	sub $t0,$t0,$t1
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_and:
	lw $t0,in1
	lw $t1,in2
	li $t2,0
	li $a0,4
	
	and $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_or:	
	
	lw $t0,in1
	lw $t1,in2
	li $t2,3
	li $a0,5
	
	or $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
mfhi_mflo:	
	addi $sp,$sp,-4
	sw $ra,0($sp)

	lw $t0,in1
	lw $t1,in2
	li $t2,2
	li $a0,6
	
	mult $t0,$t1
	
	mflo $t0	
	bne $t0,$t2,mfhi_mflo_chama_error
	nop
	nop
	j try	
	nop
	nop
	
	mfhi_mflo_chama_error: j error
	nop
	nop
	try:
	jal acertor
	nop
	nop
	sw $zero,0($zero)
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	#sw $zero,0($zero)
	move $t2,$zero
	li $a0,7
	mfhi $t0
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_sll:
	lw $t0,in1
	lw $t1,in2
	li $t2,4
	li $a0,8
	
	sll $t0,$t0,2
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_srl:
	lw $t0,in2
	li $t2,1
	li $a0,9
	
	srl $t0,$t0,1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_slt:
	lw $t0,in1
	li $t1,-1
	li $t2,0
	li $a0,10
	
	slt $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
op_sgt:
	lw $t0,in1
	lw $t1,in2
	li $t2,1
	li $a0,11
	
	sgt $t0,$t1,$t0
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_sra:
	li $t0,32
	li $t2,8
	li $a0,12
	
	sra $t0,$t0,2
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_srav:
	li $t0,32
	li $t1,2
	li $t2,8
	li $a0,13
	
	srav $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_sllv:
	li $t0,2
	li $t1,2
	li $t2,8
	li $a0,14
	
	sllv $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_srlv:
	li $t0,32
	li $t1,1
	li $t2,16
	li $a0,15
	
	srlv $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	
	j acertor
	nop
	nop
	jr $ra
	
op_xor:
	li $t0,2
	li $t1,3
	li $t2,1
	li $a0,16
	
	xor $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_nor:
	li $t0,0
	li $t1,0
	li $t2,-1
	li $a0,17
	
	nor $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_sltu:
	lw $t0,in1
	li $t1,-1
	li $t2,1
	li $a0,18
	
	sltu $t0,$t0,$t1
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra			
	
op_lui:
	lui $t0,0xFFFF
	la $t2,0xFFFF0000
	li $a0,19	
	
	bne $t0,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_div:
	addi $sp,$sp,-4
	sw $ra,0($sp)

	li $t0,31
	li $t1,2
	li $t2,15
	li $a0,20
		
	div $t0,$t1
	mflo $t0
	
	bne $t0,$t2,error	
	nop
	nop
	jal acertor
	nop
	nop
	
	li $t0,0
	sw $zero,0($zero)
	
	mfhi $t0
	li $t2,1
	li $a0,21
	bne $t0,$t2,error
	nop
	nop
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	j acertor
	nop
	nop
	jr $ra
	
op_mthi_mtlo:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	li $t0,2
	li $a0,22
	li $t2,2
	
	mthi $t0
	mfhi $t1
	
	bne $t1,$t2,chamaerror
	nop
	nop
	jal acertor
	nop
	nop
	sw $zero,0($zero)
	j try2
	nop
	nop
	chamaerror: j error
	nop
	nop
		sw $zero,0($zero)
	li $t0,0
	try2:
	lw $ra,0($sp)	
	addi $sp,$sp,4
	
	sw $zero,0($zero)
	li $a0,23
	mtlo $t0
	mflo $t1
	
	bne $t1,$t2,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra	
	
op_addi: 	
	lw $t0,in1
	lw $t1,in2
	li $a0,27
	
	addi $t0,$t0,1
	bne $t0,$t1,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_andi: 	
	lw $t0,in1
	li $a0,24
	
	andi $t0,$t0,2
	bnez $t0,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_xori: 	
	lw $t0,in1
	li $a0,26
	
	xori $t0,$t0,1
	bnez $t0,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_ori: 	
	lw $t0,in1
	lw $t1,in7
	li $a0,25
	
	xori $t0,$t0,2
	bne $t0,$t1,error
	nop
	nop
	j acertor
	nop
	nop
	jr $ra
	
op_sw_lw:
	la $t1,testw
	addi $t0,$zero,1
	sw $t0,0($t1)
	lw $t2,0($t1)
	addi $a0,$zero,28
	
	bne $t0,$t2,error
	j acertor
	
op_sb_lb:
	la $t1,testb
	addi $t0,$zero,1
	sb $t0,0($t1)
	lb $t2,0($t1)
	addi $a0,$zero,29
	
	bne $t0,$t2,error
	j acertor
	
op_lbu:
	la $t1,testb
	addi $t0,$zero,1
	sb $t0,0($t1)
	lbu $t2,0($t1)
	addi $a0,$zero,30
	
	bne $t0,$t2,error
	j acertor
op_sh_lh:
	la $t1,testh
	addi $t0,$zero,1
	sh $t0,0($t1)
	lh $t2,0($t1)
	addi $a0,$zero,31
	
	bne $t0,$t2,error
	j acertor
op_lhu:
	la $t1,testh
	addi $t0,$zero,1
	sh $t0,0($t1)
	lhu $t2,0($t1)
	addi $a0,$zero,32
	
	bne $t0,$t2,error
	j acertor
main: 
	#ULA			#codigo de erro
	jal soma 		#1
	nop
	nop
	nop
	sw $zero,0($zero)
	jal multiplicacao 	#2
	nop
	nop
	nop
	sw $zero,0($zero)
	jal subtracao 		#3
	nop
	nop
	sw $zero,0($zero)
	jal op_and		#4
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_or		#5
	nop
	nop
	nop
	sw $zero,0($zero)
	jal mfhi_mflo		#6/7
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_sll		#8
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_srl		#9
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_slt		#10
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_sgt		#11
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_sra		#12
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_srav		#13
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_sllv		#14
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_srlv		#15
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_xor		#16
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_nor		#17	
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_sltu		#18
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_lui		#19
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_div		#20/21
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_mthi_mtlo	#22/23
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_andi		#24
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_ori		#25
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_xori		#26
	nop
	nop
	nop
	sw $zero,0($zero)
	jal op_addi		#27
	nop
	nop
	sw $zero,0($zero)
	jal op_sw_lw		#28
	nop
	nop
	sw $zero,0($zero)
	jal op_sb_lb		#29
	nop
	nop
	sw $zero,0($zero)
	jal op_lbu		#30
	nop
	nop
	sw $zero,0($zero)
	jal op_sh_lh		#31
	nop
	nop
	sw $zero,0($zero)
	jal op_lhu		#32
	nop
	nop
	sw $zero,0($zero)
