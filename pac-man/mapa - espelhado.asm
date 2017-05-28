.data
 baseadd: .word 0xff000000
 coordinates1: .word 159,0 ,  0,0 , 0,80 , 53,80 , 53,160 , 0,160 , 0,239 , 159,239
 coordinates2: .word 159,35, 155,35 , 155,3 , 3,3 , 3,77 , 56,77 , 56,163  
 , 3,163, 3,236 , 159,236 
 coordinates3: .word 18,18 , 56,18 , 56,35 , 18,35 , 18,18
 coordinates4: .word 18,50 , 56,50 ,  56,62 , 18,62 , 18,50
 coordinates5: .word 140,18 , 71,18 , 71,35 , 140,35 , 140,18
 coordinates6: .word 71,50 , 71,120 , 80,120 , 80,90 , 138,90 , 138,80 , 80,80 , 80,50 , 71,50
 coordinates7: .word 159,50 , 95,50 , 95,65 , 153,65 , 153,90 , 159,90
 coordinates8: .word 151,105 , 95,105 , 95,150 , 159,150
 coordinates9: .word 151,105 , 151,107 , 97,107 , 97,148 , 159,148
 coordinates10: .word 71,135 , 71,178 , 18,178 , 18,185 , 80,185, 80,135 , 71,135
 coordinates11: .word 166,165 , 95,165 , 95,185 , 151,185 , 151,221 , 166,221
 coordinates12: .word 18,200 , 56,200 , 56,221 , 18,221 , 18,200
 coordinates13: .word 71,200 , 136,200 , 136,221 , 71,221 , 71,200
 food_coordinate1: .word 10,19 , 10,40 , 63,19 , 147,10 , 63,49
 food_coordinate2: .word 10,10 , 63,10 , 18,40 , 10,69
 
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
	li $s0,0
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
 	
loop_food:
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)	
		
	lw $a1,4($a0)
	lw $a0,0($a0)
	li $s0,0
	
	loop_food_for: beq $s0,$s1,end_loop_food_for
		jal funcao_ponto
		addi $a0,$a0,1
		jal funcao_ponto
		addi $a1,$a1,1
		jal funcao_ponto
		addi $a0,$a0,-1
		jal funcao_ponto
		
		beq $s2,$zero,vertical
		addi $a0,$a0,9
		addi $a1,$a1,-1
		j end
		vertical:addi $a1,$a1,9
		end:
		addi $s0,$s0,1
	j loop_food_for
	end_loop_food_for:
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	addi $sp,$sp,12
	
	jr $ra
	
mapa:
	addi $sp,$sp,-8
	sw $s0,0($sp)
	sw $s1,4($sp)	

	jal preenchetela
	
	la $a0,coordinates1
	li $a2,0xC0
	li $s1,7
	jal loop_mapa	

	la $a0,coordinates2
	li $s1,9
	jal loop_mapa
			
	la $a0,coordinates3
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates4
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates5	
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates6
	li $s1,8
	jal loop_mapa
	
	la $a0,coordinates7
	li $s1,5
	jal loop_mapa
	
	la $a0,coordinates8
	li $s1,3
	jal loop_mapa
	
	la $a0,coordinates9
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates10
	li $s1,6
	jal loop_mapa
	
	la $a0,coordinates11
	li $s1,5
	jal loop_mapa
	
	la $a0,coordinates12
	li $s1,4
	jal loop_mapa
	
	la $a0,coordinates13
	li $s1,4
	jal loop_mapa
	
	#COMIDA DE GORILA
	
	#vertical aqui
	li $s2,0 		#s2 recebe 0 se for vertical e 1,vertical 
	
	la $a0,food_coordinate1
	la $a2,0xFFFFFFFF
	li $s1,2
	jal loop_food
	
	addi $a0,$a0,8
	li $s1,3
	jal loop_food
		
	addi $a0,$a0,8
	li $s1,2
	jal loop_food
	
	addi $a0,$a0,8
	li $s1,4
	jal loop_food
	
	addi $a0,$a0,8
	li $s1,13
	jal loop_food
	
	#horizontal aqui
	la $a0,food_coordinate2
	li $s2,1	
	
	li $s1,6
	jal loop_food
	
	addi $a0,$a0,8
	li $s1,9
	jal loop_food
	
	addi $a0,$a0,8
	li $s1,14
	jal loop_food
	
	addi $a0,$a0,8
	li $s1,6
	jal loop_food
	
	addi $sp,$sp,8
	lw $s0,0($sp)
	lw $s1,4($sp)
