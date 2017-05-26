.data
 baseadd: .word 0xff000000
 coordinates1: .word 159,0 ,  0,0 , 0,80 , 40,80 , 40,160 , 0,160 , 0,239 , 159,239
 coordinates2: .word 159,35, 155,35 , 155,3 , 3,3 , 3,77 , 43,77 , 43,163  , 3,163 , 3,200 , 17,200 , 17,207 , 3,207 , 3,236 , 159,236
  
 coordinates3: .word 18,18 , 56,18 , 56,35 , 18,35 , 18,18
 coordinates4: .word 18,50 , 56,50 ,  56,62 , 18,62 , 18,50
 coordinates5: .word 140,18 , 71,18 , 71,35 , 140,35 , 140,18
 coordinates6: .word 71,50 , 71,120 , 80,120 , 80,90 , 140,90 , 140,80 , 80,80 , 80,50 , 71,50
  
 cor: 0xff

 
.text

j mapa

coordsverify:
	# a0 = x, $a1 = y
	bgt $a0,319,errocoord
	bgt $a1,239,errocoord
	bltz $a0,errocoord
	bltz $a1,errocoord
	li $v0,0
	jr $ra
errocoord:
	li $v0,1
	jr $ra


funcao_ponto:
	# $a0 = x, $a1 = y
	
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $ra, 8($sp)
	sw $t9, 12($sp)
	jal coordsverify
	bnez $v0,erroponto
	#Uso do t0(variaveis) e t1(endere?o)
	move $t0,$a1
	mul $t0,$t0,320 # y *= 320
	lw $t1,baseadd #retorno recebe end base
	add $t1,$t1,$t0
	move $t9,$t1
	move $t0,$a0 #reg reusado
	add $t1,$t1,$t0
	sb $a2,0($t1)
	move $t1,$t9
	addi $t1,$t1,319
	sub $t1,$t1,$t0
	sb $a2,0($t1)
	
erroponto:
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $ra, 8($sp)
	lw $t9,12($sp)
	addi $sp, $sp, 16
	jr $ra

funcao_reta:
	#a0 = Endereco das coordenadas
	#a2 = cor
	#t6 = x0 t7=y0 t8=x1 t9=y1
	#t0 = dx, t1 = dy, t2 = sx, t3 = sy, t4=err, t5 = e2
	
	lw $t6, 0($a0)
	lw $t7, 4($a0)
	lw $t8, 8($a0)
	lw $t9, 12($a0)
	
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	sub $t0,$t8,$t6

	move $t2,$a0
	li $t1,2
	move $t3,$t2	
verifypon:
	beqz $t1,saiverifypon
		addi $t1,$t1,-1
		lw $a0,0($t3)
		lw $a1,4($t3)
		addi $t3,$t3,8
		jal coordsverify
	beqz $v0,verifypon
	j erropon	
saiverifypon:	
	move $a0,$t2
	
	if_fr_1:
		bgt $t0,$zero,else_fr_1
 		mul $t0,$t0,-1 #Se s0 negativo troque o sinal
 		li $t2,-1 #sx = negativo
 		j endif_fr_1
	else_fr_1:
	 	li $t2,1 #se s0 pos, dx = 1
	endif_fr_1:
	
	sub $t1,$t9,$t7 # dy = y1 - y0
	if_fr_2:
		bgt $t1,$zero,else_fr_2 
 		mul $t1,$t1,-1 #Se s1 negativo troque o sinal
 		li $t3,-1 #dy negativo
 		j endif_fr_2
	else_fr_2: 	
		li $t3,1 #se s3 positivo, dy = 1
	endif_fr_2:

	if_fr_3:
		bgt $t0,$t1,else_fr_3 #se dx>dy
		mul $t4,$t1,-1 #err = (-dy)
		j endif_fr_3
 	else_fr_3: 
 		move $t4,$t0 #err = dx
 	endif_fr_3:

	div $t4,$t4,2 # err = err/2 

	while_fr_1:
		addi $a0, $t6, 0
		addi $a1, $t7, 0
		jal funcao_ponto
		
		bne $t6, $t8, neq_fr_1 # if (x0 == x1 && y0 == y1) break;
		bne $t7, $t9, neq_fr_1 # if (x0 == x1 && y0 == y1) break;
		j ew_fr_1
		
		neq_fr_1:
		addu $t5, $t4, $zero
		
		if_fr_4:
			mul $t0, $t0, -1
			ble $t5, $t0, endif_fr_4
			sub $t4, $t4, $t1
			add $t6, $t6, $t2	
		endif_fr_4:
		mul $t0, $t0, -1
		if_fr_5:
			bge $t5, $t1, endif_fr_5
			add $t4, $t4, $t0
			add $t7, $t7, $t3
		endif_fr_5:
		j while_fr_1
	ew_fr_1:
erropon:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
endreta:

loop_mapa:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	for_mapa1: 
		beq $s0,$s1,end_for_mapa1
		jal funcao_reta
		addi $a0,$a0,8
		addi $s0,$s0,1
		j for_mapa1
	end_for_mapa1:
		lw $ra,0($sp)
		addi $sp,$sp,4
		jr $ra
		
 preenchetela:	
	# pinta a tela de branco
 	li $t0,0xff000000
 	li $t1,0xff012c00
 	li $a2,0x00000000
 tela:
 	beq $t0,$t1,cMain
 	sw $a2,0($t0)
 	addi $t0,$t0,4
 	j tela	
 	cMain: jr $ra
	
mapa:
	#salvar dps s0 e s1 na pilha
	#jal preenchetela
	#j debug

	
	la $a0,coordinates1
	li $a2,0xC0
	li $s0,0
	li $s1,7
	jal loop_mapa	
	#5 iterações
	debug:
	la $a0,coordinates2
	li $s0,0
	li $s1,13
	jal loop_mapa
			
	la $a0,coordinates3
	li $s0,0
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates4
	li $s0,0
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates5
	li $s0,0
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates6
	li $s0,0
	li $s1,8
	jal loop_mapa