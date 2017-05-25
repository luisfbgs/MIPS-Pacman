.data
	out1: .asciiz "Erro! "
	out2: .asciiz "\n"
	in1: .word 1
	in2: .word 2
.text
j main
error: 
	addi $sp,$sp,-4
	sw $a0,0($sp)
	
	la $a0,out1
	li $v0,4
	syscall #print string
	
	lw $a0,0($sp)
	addi $sp,$sp,4
	li $v0,1
	syscall #print int
	
	la $a0,out2 #\n
	li $v0,4
	syscall 
	
	jr $ra
	
soma: 	
	lw $t0,in1
	lw $t1,in2
	li $t2,3
	li $a0,1
	
	add $t0,$t0,$t1
	bne $t0,$t2,error
	jr $ra
		
multiplicacao:
	lw $t0,in1
	lw $t1,in2
	li $t2,2
	li $a0,2
	
	mult $t0,$t1
	mflo $t0
	
	bne $t0,$t2,error
	jr $ra
	
subtracao:	

	lw $t0,in1
	lw $t1,in2
	li $t2,-1
	li $a0,3
	
	sub $t0,$t0,$t1
	bne $t0,$t2,error
	jr $ra
	
op_and:
	lw $t0,in1
	lw $t1,in2
	li $t2,0
	li $a0,4
	
	and $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra	
	
op_or:	
	
	lw $t0,in1
	lw $t1,in2
	li $t2,3
	li $a0,5
	
	or $t0,$t0,$t1
	
	bne $t0,$t2,error
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
	
	mfhi_mflo_chama_error: jal error
	try:
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	move $t2,$zero
	li $a0,7
	mfhi $t0
	bne $t0,$t2,error
	jr $ra
	
op_sll:
	lw $t0,in1
	lw $t1,in2
	li $t2,4
	li $a0,8
	
	sll $t0,$t0,2
	
	bne $t0,$t2,error
	jr $ra	
	
op_srl:
	lw $t0,in2
	li $t2,1
	li $a0,9
	
	srl $t0,$t0,1
	
	bne $t0,$t2,error
	jr $ra	
	
op_slt:
	lw $t0,in1
	li $t1,-1
	li $t2,0
	li $a0,10
	
	slt $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra
op_sgt:
	lw $t0,in1
	lw $t1,in2
	li $t2,1
	li $a0,11
	
	sgt $t0,$t1,$t0
	
	bne $t0,$t2,error
	jr $ra
	
op_sra:
	li $t0,32
	li $t2,8
	li $a0,12
	
	sra $t0,$t0,2
	
	bne $t0,$t2,error
	jr $ra
	
op_srav:
	li $t0,32
	li $t1,2
	li $t2,8
	li $a0,13
	
	srav $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra	
	
op_sllv:
	li $t0,2
	li $t1,2
	li $t2,8
	li $a0,14
	
	sllv $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra	
	
op_srlv:
	li $t0,32
	li $t1,1
	li $t2,16
	li $a0,15
	
	srlv $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra
	
op_xor:
	li $t0,2
	li $t1,3
	li $t2,1
	li $a0,16
	
	xor $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra	
	
op_nor:
	li $t0,0
	li $t1,0
	li $t2,-1
	li $a0,17
	
	nor $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra	
	
op_sltu:
	lw $t0,in1
	li $t1,-1
	li $t2,1
	li $a0,18
	
	sltu $t0,$t0,$t1
	
	bne $t0,$t2,error
	jr $ra			
	
op_lui:
	lui $t0,0xFFFF
	la $t2,0xFFFF0000
	li $a0,19	
	
	bne $t0,$t2,error
	jr $ra	
	
op_div:
	li $t0,31
	li $t1,2
	li $t2,15
	li $a0,20
		
	div $t0,$t1
	mflo $t0
	
	bne $t0,$t2,error
	
	mfhi $t0
	li $t2,1
	li $a0,21
	bne $t0,$t2,error
	
	jr $ra
																												
main: 
	jal soma 		#1
	jal multiplicacao 	#2
	jal subtracao 		#3
	jal op_and		#4
	jal op_or		#5
	jal mfhi_mflo		#6/7
	jal op_sll		#8
	jal op_srl		#9
	jal op_slt		#10
	jal op_sgt		#11
	jal op_sra		#12
	jal op_srav		#13
	jal op_sllv		#14
	jal op_srlv		#15
	jal op_xor		#16
	jal op_nor		#17	
	jal op_sltu		#18
	jal op_lui		#19
	jal op_div		#20/21
