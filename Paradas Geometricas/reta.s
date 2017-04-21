.data
	F:.word 0xffffffff
	X: .word 0,320
	Y: .word 0,240
	COR: .word 0x88888888 
.text
	j main
	
	#$a0 = x1, $a1 = x2, $a2 = y1, $a3 = y2, $v0 = cor
reta:	la $t0,F
	lw $t0,0($t0)
	sub $t1,$a0,$a1
	abs $t1,$t1
L:	addi $t1,$t1,1
	sub $t2,$a2,$a3
	abs $t2,$t2
L2:	addi $t2,$t2,1
	blt $t2,$t1,YP
	div $t2,$t1
	j PA
YP:	div $t1,$t2
PA:	mfhi $t5
	mflo $t4
	move $t6,$t5
	addi $t6,$t6,1	
	#$t8 comeco
PO:	li $t8,0xFF000000
	add $t8,$t8,$a0
	mul $t3,$a2,320
	add $t8,$t8,$t3
	#$a0 passo comum, $a2 passo incomum, $t8 endereço que pinta
	blt $a0,$a1,AA
	li $a0,-1
	j AB
AA:	li $a0,1
AB:	blt $a2,$a3,BB
	li $a2,-320
	j BA
BB:	li $a2,320
BA:	blt $t2,$t1,LEPO
	move $v0,$a0
	move $a0,$a2
	move $a2,$a0
	#$t7 erro
LEPO:	div $t7,$t2,$t6
	move $t6,$t7
	sub $t7,$t2,$t6
LOOP:	move $t0,$t4
LOOPP:	sb $v0,0($t8)
	add $t8,$t8,$a0
	subi $t0,$t0,1
	bne $t0,$zero,LOOPP
	beq $t2,$t7,RESTO
VOLTA:	subi $t2,$t2,1
	beq $t2,$zero sai
	add $t8,$t8,$a2
	j LOOP
	#distribui o resto
RESTO:	beq $t5,$zero,VOLTA
	sb $v0,0($t8)
	add $t8,$t8,$a0
	subi $t5,$t5,1
	sub $t7,$t7,$t6
	andi $a1,$t5,1
	beq $a1,$zero,VOLTA
	subi $t7,$t7,1
	j VOLTA

sai:	jr $ra

main:	la $s0,X
	lw $a0,0($s0)
	lw $a1,4($s0)
	la $s0,Y
	lw $a2,0($s0)
	lw $a3,4($s0)
	la $s0,COR
	lw $v0,0($s0)
	jal reta
