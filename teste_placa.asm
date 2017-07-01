.data
	in1: 	.word 1
	in2: 	.word 2
	in3: 	.float 1.5
	in4: 	.float 4.0
	in5: 	.float 2.0
	in6: 	.float -2.0
	cpmuls: .float 6.0
	cpadds: .float 5.5
	cpsubs: .float 2.5
	estate: .word  0
.text
li $s7,0
li $s6,0
li $sp,0x10011ffc

j main

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
	j acertor
	jr $ra
		
multiplicacao:



	lw $t0,in1
	lw $t1,in2
	li $t2,2
	li $a0,2
	
	mult $t0,$t1
	mflo $t0
	
	bne $t0,$t2,error
	j acertor
	jr $ra
	
subtracao:	

	lw $t0,in1
	lw $t1,in2
	li $t2,-1
	li $a0,3
	
	sub $t0,$t0,$t1
	bne $t0,$t2,error
	j acertor
	jr $ra
	
op_and:
	lw $t0,in1
	lw $t1,in2
	li $t2,0
	li $a0,4
	
	and $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_or:	
	
	lw $t0,in1
	lw $t1,in2
	li $t2,3
	li $a0,5
	
	or $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
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
	j try	
	
	mfhi_mflo_chama_error: j error
	try:
	jal acertor
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	#sw $zero,0($zero)
	move $t2,$zero
	li $a0,7
	mfhi $t0
	bne $t0,$t2,error
	j acertor
	jr $ra
	
op_sll:
	lw $t0,in1
	lw $t1,in2
	li $t2,4
	li $a0,8
	
	sll $t0,$t0,2
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_srl:
	lw $t0,in2
	li $t2,1
	li $a0,9
	
	srl $t0,$t0,1
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_slt:
	lw $t0,in1
	li $t1,-1
	li $t2,0
	li $a0,10
	
	slt $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra
op_sgt:
	lw $t0,in1
	lw $t1,in2
	li $t2,1
	li $a0,11
	
	sgt $t0,$t1,$t0
	
	bne $t0,$t2,error
	j acertor
	jr $ra
	
op_sra:
	li $t0,32
	li $t2,8
	li $a0,12
	
	sra $t0,$t0,2
	
	bne $t0,$t2,error
	j acertor
	jr $ra
	
op_srav:
	li $t0,32
	li $t1,2
	li $t2,8
	li $a0,13
	
	srav $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_sllv:
	li $t0,2
	li $t1,2
	li $t2,8
	li $a0,14
	
	sllv $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_srlv:
	li $t0,32
	li $t1,1
	li $t2,16
	li $a0,15
	
	srlv $t0,$t0,$t1
	
	bne $t0,$t2,error
	
	j acertor
	jr $ra
	
op_xor:
	li $t0,2
	li $t1,3
	li $t2,1
	li $a0,16
	
	xor $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_nor:
	li $t0,0
	li $t1,0
	li $t2,-1
	li $a0,17
	
	nor $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra	
	
op_sltu:
	lw $t0,in1
	li $t1,-1
	li $t2,1
	li $a0,18
	
	sltu $t0,$t0,$t1
	
	bne $t0,$t2,error
	j acertor
	jr $ra			
	
op_lui:
	lui $t0,0xFFFF
	la $t2,0xFFFF0000
	li $a0,19	
	
	bne $t0,$t2,error
	j acertor
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
	jal acertor
	
	li $t0,0
	sw $zero,0($zero)
	
	mfhi $t0
	li $t2,1
	li $a0,21
	bne $t0,$t2,error
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	j acertor
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
	jal acertor
	j try2
	chamaerror: j error
	li $t0,0
	try2:
	lw $ra,0($sp)	
	addi $sp,$sp,4
	
	sw $zero,0($zero)
	li $a0,23
	mtlo $t0
	mflo $t1
	
	bne $t1,$t2,error
	j acertor
	jr $ra	
	
		
main: 
	#ULA			#codigo de erro
	jal soma 		#1
	li $t0,0
	sw $zero,0($t0)
	jal multiplicacao 	#2
	li $t0,0
	sw $zero,0($t0)
	jal subtracao 		#3
	li $t0,0
	sw $zero,0($t0)
	jal op_and		#4
	li $t0,0
	sw $zero,0($t0)
	jal op_or		#5
	li $t0,0
	sw $zero,0($t0)
	jal mfhi_mflo		#6/7
	li $t0,0
	sw $zero,0($t0)
	jal op_sll		#8
	li $t0,0
	sw $zero,0($t0)
	jal op_srl		#9
	li $t0,0
	sw $zero,0($t0)
	jal op_slt		#10
	li $t0,0
	sw $zero,0($t0)
	jal op_sgt		#11
	li $t0,0
	sw $zero,0($t0)
	jal op_sra		#12
	li $t0,0
	sw $zero,0($t0)
	jal op_srav		#13
	li $t0,0
	sw $zero,0($t0)
	jal op_sllv		#14
	li $t0,0
	sw $zero,0($t0)
	jal op_srlv		#15
	li $t0,0
	sw $zero,0($t0)
	jal op_xor		#16
	li $t0,0
	sw $zero,0($t0)
	jal op_nor		#17	
	li $t0,0
	sw $zero,0($t0)
	jal op_sltu		#18
	li $t0,0
	sw $zero,0($t0)
	jal op_lui		#19
	li $t0,0
	sw $zero,0($t0)
	jal op_div		#20/21
	li $t0,0
	sw $zero,0($t0)
	jal op_mthi_mtlo	#22/23
	li $t0,0
	sw $zero,0($t0)
	jal op_multu		#24
	li $t0,0
	sw $zero,0($t0)
	jal op_divu		#25
	li $t0,0
	sw $zero,0($t0)	
	jal op_addu		#26
	li $t0,0
	sw $zero,0($t0)
	jal op_subu		#27
	li $t0,0
	sw $zero,0($t0)
	jal op_andi		#28
	li $t0,0
	sw $zero,0($t0)
	jal op_ori		#29
	li $t0,0
	sw $zero,0($t0)
	jal op_xori		#30
	li $t0,0
	sw $zero,0($t0)
	jal op_addi		#31
	li $t0,0
	sw $zero,0($t0)
