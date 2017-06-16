.data
 baseadd: .word 0xff000000 
 coordinates1: .word 159,0 ,  0,0 , 0,82 , 48,82 , 48,158 , 0,158 , 0,239 , 159,239
 coordinates2: .word 159,41, 148,41 , 148,5 , 3,5 , 3,78 , 51,78 , 51,161  
 , 3,161, 3,234 , 159,234 
 coordinates3: .word 16,18 , 51,18 , 51,41 , 16,41 , 16,18
 coordinates4: .word 16,54 , 51,54 ,  51,65 , 16,65 , 16,54
 coordinates5: .word 135,18 , 64,18 , 64,41 , 135,41 , 135,18
 coordinates6: .word 64,54 , 64,113 , 75,113 , 75,89 , 135,89 , 135,78 , 75,78 , 75,54 , 64,54
 coordinates7: .word 159,54 , 88,54 , 88,65 , 148,65 , 148,89 , 159,89
 coordinates8: .word 151,102 , 88,102 , 88,161 , 159,161
 coordinates9: .word 151,102 , 151,109 , 97,109 , 97,155 , 159,155
 coordinates10: .word 64,126 , 64,174 , 16,174 , 16,185 , 75,185, 75,126 , 64,126
 coordinates11: .word 166,174 , 88,174 , 88,185 , 148,185 , 148,221 , 166,221
 coordinates12: .word 16,198 , 51,198 , 51,221 , 16,221 , 16,198
 coordinates13: .word 64,198 , 135,198 , 135,221 , 64,221 , 64,198
 food_coordinate1: .word 9,22 , 57,22 , 141,22 , 81,46 , 9,166 , 141,190 , 57,202
 food_coordinate2: .word 9,11 , 9,46 , 9,70 , 9,166 , 9,190 , 9,226 , 93,70
 boca_coord: .word 0,0 , 0,0
 velocidade: .word 80
 aberta: .word 1,1,1,1
 espelho: .word 1
 pac_position: .word 0,0,0,0
 mov_ant: .word 0,0,0,0
 mov: .word 0,0,0,0
 atpac: .word 0
 cor: .word 0
 meiaberta: .word 1
 # Define quantos pac-mans vao ter no jogo (1~4)
 players: .word 4 
.text

li $sp,0x10011ffc
la $t0,espelho
addi $t1,$zero,1
sw $t1,0($t0)
j mapa
nop
		nop
		nop
		nop
		nop
		nop
		nop

#Preenche tela de preto -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 preenchetela:	
 nop
 nop
	# pinta a tela de preto
	nop
	nop
 	li $t0,0xff000000
 	nop
 	nop
 	li $t1,0xff012c00
 	nop
 	nop
 	li $a2,0x00000000
 	nop
 	nop
 tela:
 	beq $t0,$t1,saitela
 	nop
 	nop
 	
 	nop
 	nop
 	sw $a2,0($t0)
 	nop
 	nop
 	addi $t0,$t0,4
 	
 	nop
 	j tela	
 	nop
 	nop
 	nop
 	nop

saitela: 
	#sw $zero,0($zero)
	nop
	nop
 	jr $ra 	
 	nop
 	nop
 	
 	nop
 	nop

#Funcao ponto ----------------------------------------------------------------------------------------------------------------------------------------------------
funcao_ponto:
	# $a0 = x, $a1 = y
	nop
	nop
	
	nop
	nop
	addi $sp, $sp, -16
	
	nop
	sw $t0, 4($sp)
	nop
	nop
	sw $t1, 8($sp)
	nop
	nop
	sw $t9, 12($sp)
	nop
	nop
	#Uso do t0(variaveis) e t1(endere?o)
	nop
	nop
	move $t0,$a1
	nop
	nop
	addi $at,$zero,320
	
	nop
	mult $t0,$at # y *= 320
	nop
	nop
	mflo $t0
	nop
	nop
	lw $t1,baseadd #retorno recebe end base
	nop
	nop
	add $t1,$t1,$t0
	nop
	nop
	move $t9,$t1
	nop
	nop
	move $t0,$a0 #reg reusado
	nop
	nop
	add $t1,$t1,$t0
	nop
	nop
	sb $a2,0($t1)
	nop
	nop
	move $t1,$t9
	nop
	nop
	la $t9,espelho
	nop
	nop
	lw $t9,0($t9)
	nop
	nop
	beqz $t9,saiponto
	nop
	nop
	
	nop
	nop
	addi $t1,$t1,319
	
	nop
	sub $t1,$t1,$t0
	nop
	nop
	sb $a2,0($t1)
	nop
	nop
saiponto:	
nop
nop
	lw $t0, 4($sp)
	nop
	nop
	lw $t1, 8($sp)
	nop
	nop
	lw $t9, 12($sp)
	nop
	nop
	addi $sp, $sp, 16
	
	nop
	jr $ra
	nop
	nop
	
	nop
	nop

#Funcao reta -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
funcao_reta:
	#a0 = Endereco das coordenadas
	nop
	nop
	#a2 = cor
	nop
	nop
	#t6 = x0 t7=y0 t8=x1 t9=y1
	nop
	nop
	#t0 = dx, t1 = dy, t2 = sx, t3 = sy, t4=err, t5 = e2
	nop
	nop
	
	nop
	nop
	lw $t6, 0($a0)
	nop
	nop
	lw $t7, 4($a0)
	nop
	nop
	lw $t8, 8($a0)
	nop
	nop
	lw $t9, 12($a0)
	nop
	nop
	
	nop
	nop
	addi $sp, $sp, -12
	
	nop
	sw $ra, 4($sp)
	nop
	nop
	sw $a0, 8($sp)
	nop
	nop
	sub $t0,$t8,$t6
	nop
	nop

	if_fr_1:
	nop
	nop
		bgt $t0,$zero,else_fr_1
		nop
		nop
		nop	
		nop
		nop
		nop 
		nop
		nop
		nop
		nop
		nop
		addi $at,$zero,-1
		
		nop
 		mult $t0,$at #Se s0 negativo troque o sinal
 		nop
 		nop
 		mflo $t0
 		nop
 		nop
 		addi $t2,$zero,-1 #sx = negativo
 		
 		nop
 		j endif_fr_1
 		nop
 		nop
 		nop
 		nop
 		nop
		nop
		nop
		nop
		nop
		nop
		nop
	else_fr_1:
	nop
	nop
	 	addi $t2,$zero,1 #se s0 pos, dx = 1
	 	
	 	nop
	endif_fr_1:
	nop
	nop
	
	nop
	nop
	sub $t1,$t9,$t7 # dy = y1 - y0
	nop
	nop
	if_fr_2:
	nop
	nop
		bgt $t1,$zero,else_fr_2 
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		addi $at,$zero,-1
		
		nop
 		mult $t1,$at #Se s1 negativo troque o sinal
 		nop
 		nop
 		mflo $t1
 		nop
 		nop
 		addi $t3,$zero,-1 #dy negativo
 		
 		nop
 		j endif_fr_2
 		nop
 		nop
 		nop
 		nop
 		nop
		nop
		nop
		nop
		nop
		nop
		nop
	else_fr_2: 	
	nop
	nop
		addi $t3,$zero,1 #se s3 positivo, dy = 1
		
		nop
	endif_fr_2:
	nop
	nop

	if_fr_3:
	nop
	nop
		bgt $t0,$t1,else_fr_3 #se dx>dy
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		addi $at,$zero,-1
		
		nop
		mult $t1,$at #err = (-dy)
		nop
		nop
		mflo $t4
		nop
		nop
		j endif_fr_3
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
 	else_fr_3: 
 	nop
 	nop
 		move $t4,$t0 #err = dx
 		nop
 		nop
 	endif_fr_3:
 	nop
 	nop

	sra $t4,$t4,1 # err = err/2 
	nop
	nop

	while_fr_1:
	nop
	nop
		addi $a0, $t6, 0
		
		nop
		addi $a1, $t7, 0
		
		nop
		jal funcao_ponto
		nop
		nop
		
		nop
		nop
		
		nop
		nop
		bne $t6, $t8, neq_fr_1 # if (x0 == x1 && y0 == y1) break;
		nop
		nop
		
		nop
		nop
		bne $t7, $t9, neq_fr_1 # if (x0 == x1 && y0 == y1) break;
		nop
		nop
		
		nop
		nop
		j ew_fr_1
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		
		nop
		nop
		neq_fr_1:
		nop
		nop
		addu $t5, $t4, $zero
		nop
		nop
		
		nop
		nop
		if_fr_4:
		nop
		nop
			addi $at,$zero,-1
			
			nop
			mult $t0, $at
			nop
			nop
			mflo $t0
			nop
			nop
			ble $t5, $t0, endif_fr_4
			nop
			nop
			sub $t4, $t4, $t1
			nop
			nop
			add $t6, $t6, $t2	
			nop
			nop
		endif_fr_4:
		nop
		nop
		addi $at,$zero,-1
		
		nop
		mult $t0, $at
		nop
		nop
		mflo $t0
		nop
		nop
		if_fr_5:
		nop
		nop
			bge $t5, $t1, endif_fr_5
			nop
			nop
			add $t4, $t4, $t0
			nop
			nop
			add $t7, $t7, $t3
			nop
			nop
		endif_fr_5:
		nop
		nop
		j while_fr_1
		nop
		nop
		nop
		nop
	ew_fr_1:
	nop
	nop
	lw $ra, 4($sp)
	nop
	nop
	lw $a0, 8($sp)
	nop
	nop
	addi $sp, $sp, 12
	
	nop
	jr $ra
	nop
	nop
	
	nop
	nop

#Loop mapa -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_mapa:
	addi $s0,$zero,0
	
	nop
	addi $sp,$sp,-8 
	
	nop
	sw $ra,4($sp)
	nop
	nop
	for_mapa1: 
	nop
	nop
		beq $s0,$s1,end_for_mapa1
		nop
		nop
		
		nop
		nop
		jal funcao_reta
		nop
		nop
		
		nop
		nop
		addi $a0,$a0,8
		
		nop
		addi $s0,$s0,1
		
		nop
		j for_mapa1
		nop
		nop
		nop
		nop

end_for_mapa1:
	lw $ra,4($sp)
	nop
	nop
	addi $sp,$sp,8
	
	nop
	jr $ra
	nop
	nop
	
	nop
	nop
 	
 	nop
 	nop
#Loop food -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_food:
	addi $sp,$sp,-16
	
	nop
	sw $ra,4($sp)
	nop
	nop
	sw $a0,8($sp)
	nop
	nop
	sw $a1,12($sp)	
	nop
	nop
		
		nop
		nop
	lw $a1,4($a0)
	nop
	nop
	lw $a0,0($a0)
	nop
	nop
	addi $s0,$zero,0
	
	nop
	
	nop
	nop
	loop_food_for: beq $s0,$s1,end_loop_food_for
	nop
	nop
	
	nop
	nop
		jal funcao_ponto
		nop
		nop
		
		nop
		nop
		addi $a0,$a0,1
		
		nop
		jal funcao_ponto
		nop
		nop
		
		nop
		nop
		addi $a1,$a1,1
		
		nop
		jal funcao_ponto
		nop
		nop
		
		nop
		nop
		addi $a0,$a0,-1
		
		nop
		jal funcao_ponto
		nop
		nop
		
		nop
		nop
		
		nop
		nop
		beq $s2,$zero,vertical
		nop
		nop
		
		nop
		nop
		addi $a0,$a0,12
		
		nop
		addi $a1,$a1,-1
		
		nop
		j end
		nop
		nop
		nop
		nop

		vertical:addi $a1,$a1,11
		
		nop
		end:
		nop
		nop
		addi $s0,$s0,1
		
		nop
	j loop_food_for
	nop
	nop
	nop
	nop

	end_loop_food_for:
	nop
	nop
	
	nop
	nop
	lw $ra,4($sp)
	nop
	nop
	lw $a0,8($sp)
	nop
	nop
	lw $a1,12($sp)
	nop
	nop
	addi $sp,$sp,16
	
	nop
	
	nop
	nop
	jr $ra
	nop
	nop
	
	nop
	nop

#Funcao mapa ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
mapa:
	jal preenchetela
	nop
	nop
	
	nop
	nop

	la $a0,coordinates1
	nop
	nop
	addi $a2,$zero,0xC0
	
	nop
	addi $s1,$zero,7
	
	nop
	jal loop_mapa	
	nop
	nop
	
	nop
	nop

	la $a0,coordinates2
	nop
	nop
	addi $s1,$zero,9
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates3
	nop
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates4
	nop
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates5	
	nop
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates6
	nop
	nop
	addi $s1,$zero,8
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates7
	nop
	nop
	addi $s1,$zero,5
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates8
	nop
	nop
	addi $s1,$zero,3
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop
	la $a0,coordinates9
	nop
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates10
	nop
	nop
	addi $s1,$zero,6
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates11
	nop
	nop
	addi $s1,$zero,5
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates12
	nop
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

	la $a0,coordinates13
	nop
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_mapa
	nop
	nop
	
	nop
	nop

#Funcao comida ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	#COMIDA DE GORILA
	nop
	nop
	
	nop
	nop
	#vertical aqui
	nop
	nop
	addi $s2,$zero,0 		#s2 recebe 0 se for vertical e 1,vertical 
	
	nop
	la $a0,food_coordinate1
	nop
	nop
	la $a2,0xFFFFFFFF
	nop
	nop
	addi $s1,$zero,5
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,13
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop

	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,2
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,3
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,6
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,2
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	#horizontal aqui
	nop
	nop
	la $a0,food_coordinate2
	nop
	nop
	addi $s2,$zero,1
	
	nop
	
	nop
	nop
	addi $s1,$zero,12
	
	nop
	jal loop_food	
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,14
	
	nop
	jal loop_food	
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_food	
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,4
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,11
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,13
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop

	addi $a0,$a0,8
	
	nop
	addi $s1,$zero,5
	
	nop
	jal loop_food
	nop
	nop
	
	nop
	nop
j loop_jogo
#Pinta Pac ------------------------------------------------------------------------------------------------------------------------------------------------------------	
nop
nop
pintapac:
	# a0 = centro x, a1 = centro y, a2 = cor , a3 = raio
	nop
	nop
	# guarda na pilha registradores preservados que serao utiaddizado,$zeros
	nop
	nop
	addi $sp,$sp,-20
	nop
	nop
	sw $ra,4($sp)
	nop
	nop
	sw $t0,8($sp)
	nop
	nop
	
	nop
	nop
	move $a2,$a0
	nop
	nop
	la $a3,5
	nop
	nop
	la $t0,320
	nop
	nop
	subi $a1,$a1,4278190080
	nop
	nop
	div $a1,$t0
	nop
	nop
	mfhi $a0
	nop
	nop
	mflo $a1
	nop
	nop
	addi $a0,$a0,6
	nop
	nop
	addi $a1,$a1,6
	nop
	nop
	sw $a0,12($sp)
	nop
	nop
	sw $a1,16($sp)
	nop
	nop
	
	nop
	nop
	add $s0,$zero,$zero # y inicial
	nop
	nop
	add $s1,$zero,$a3 # x inicial
	nop
	nop
	add $s2,$zero,$zero # erro
	nop
	nop
	add $s3,$zero,$a1 # y
	nop
	nop
	add $s4,$zero,$a0 # x
	nop
	nop
	addi $s5,$zero,320
	nop
	nop
	mult $a3,$a3 # raio = raio ao quadrado
	nop
	nop
	mflo $a3
	nop
	nop
circloop:
	blt $s1,$s0,endcirculo
	nop
	nop
		# colocar pontos simetricamente nos oito octantes do circulo
		nop
		nop
		add $a0,$s4,$s1 
		nop
		nop
		add $a1,$s3,$s0
		nop
		nop
		jal funcao_ponto
		nop
		nop

	      	add $a0,$s4,$s0
	      	nop
	      	nop
		add $a1,$s3,$s1
		nop
		nop
		jal funcao_ponto
		nop
		nop
     	
     	nop
     	nop
        	sub $a0,$s4,$s0
        	nop
        	nop
		add $a1,$s3,$s1
		nop
		nop
		jal funcao_ponto
		nop
		nop

        	sub $a0,$s4,$s1
        	nop
        	nop
		add $a1,$s3,$s0
		nop
		nop
		jal funcao_ponto
		nop
		nop

        	sub $a0,$s4,$s1
        	nop
        	nop
		sub $a1,$s3,$s0
		nop
		nop
		jal funcao_ponto
		nop
		nop
	
	nop
	nop
        	sub $a0,$s4,$s0
        	nop
        	nop
		sub $a1,$s3,$s1
		nop
		nop
		jal funcao_ponto
		nop
		nop

        	add $a0,$s4,$s0
        	nop
        	nop
		sub $a1,$s3,$s1
		nop
		nop
		jal funcao_ponto
		nop
		nop

        	add $a0,$s4,$s1
        	nop
        	nop
		sub $a1,$s3,$s0
		nop
		nop
		jal funcao_ponto
		nop
		nop
		
		nop
		nop
		addi $s0,$s0,1 # incrementa o y
		nop
		nop
		
		nop
		nop
		mult $s0,$s0
		nop
		nop
		mflo $t0
		nop
		nop
		mult $s1,$s1
		nop
		nop
		mflo $t1
		nop
		nop
		add $t1,$t0,$t1
		nop
		nop
		sub $t2,$t1,$a3 # salva em $t2 o valor y^2 + x^2 - r^2
		nop
		nop
		
		nop
		nop
		addi $t1,$s1,-1
		nop
		nop
		mult $t1,$t1
		nop
		nop
		mflo $t1
		nop
		nop
		add $t1,$t0,$t1
		nop
		nop
		sub $t3,$t1,$a3 # salva em $t3 o valor y^2 + (x-1)^2 - r^2
		nop
		nop
		
		nop
		nop
		abs $t2,$t2
		nop
		nop
		abs $t3,$t3
		nop
		nop
		
		nop
		nop
		blt $t2,$t3,circloop # caso o valor de $t3 seja mais proximo de 0, x recebe x - 1, caso contratio x matem seu valor
		nop
		nop
		addi $s1,$s1,-1
		nop
		nop
		j circloop
		nop
		nop
endcirculo:
	
	nop
	nop
	lw $a0,12($sp)
	nop
	nop
	lw $a1,16($sp)
	nop
	nop
	jal preenche_pac
	nop
	nop
	# recuperar da pilha registradores preservados utilizados
	nop
	nop
	lw $ra,4($sp)  
	nop
	nop
	lw $t0,8($sp)
	nop
	nop
	addi $sp,$sp,20
	nop
	nop
	jr $ra
	nop
	nop

#Preenche Pac --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
preenche_pac:
 	# $a0 = x, $a1 = y, $a2 = cor
 	nop
 	nop
 	addi $sp,$sp,-8
 	nop
 	nop
	
	nop
	nop
	li $t0,0xff000000
	nop
	nop
	add $t0,$t0,$a0
	nop
	nop
	addi $at,$zero,320
	nop
	nop
	mult $a1,$at
	nop
	nop
	mflo $a1
	nop
	nop
	add $t0,$t0,$a1
	nop
	nop
	
	nop
	nop
	move $t1,$sp
	nop
	nop
	move $t2,$t1
	nop
	nop
	sw $t0,0($t1)
	nop
	nop
	addi $t1,$t1,-4
	nop
	nop
	# $t2 inicio da fila,$t1 fim da fila
	nop
	nop
bfs:	
nop
nop
	beq $t1,$t2,endpreenche 
	nop
	nop
		lw $t0,0($t2)
		nop
		nop
		addi $t2,$t2,-4
		nop
		nop
		lb $t3,0($t0)
		nop
		nop
		beq $t3,$a2,bfs
		nop
		nop
		sb $a2,0($t0)
		nop
		nop
			# atualiza o ponteiro da fila
			nop
			nop
			addi $t1,$t1,-16
			nop
			nop
			# coloca na fila os enderecos adjacentes a $t0
			nop
			nop
			addi $t0,$t0,1
			nop
			nop
			sw $t0,16($t1)
			nop
			nop
			addi $t0,$t0,-2
			nop
			nop
			sw $t0,12($t1)
			nop
			nop
			addi $t0,$t0,321
			nop
			nop
			sw $t0,8($t1)
			nop
			nop
			addi $t0,$t0,-640
			nop
			nop
			sw $t0,4($t1)
			nop
			nop

		j bfs
		nop
		nop
endpreenche:
	addi $sp,$sp,8
	nop
	nop
	jr $ra
	nop
	nop

#Loop de jogo --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_jogo:
	la $t0,espelho
	nop
	nop
	sw $zero,0($t0)
	nop
	nop
	la $t0,baseadd
	nop
	nop
	lw $a1,0($t0)
	nop
	nop
	addi $a1,$a1,1924
	nop
	nop
	la $t1,pac_position
	nop
	nop
	sw $a1,0($t1)
	nop
	nop
	addi $a0,$zero,0x77
	nop
	nop
	jal pintapac
	nop
	nop
	
	nop
	nop
	lw $t0,players
	nop
	nop
	blt $t0,2,loop
	nop
	nop
	
	nop
	nop
	la $t0,baseadd
	nop
	nop
	lw $a1,0($t0)
	nop
	nop
	addi $a1,$a1,2224
	nop
	nop
	la $t1,pac_position
	nop
	nop
	sw $a1,4($t1)
	nop
	nop
	addi $a0,$zero,0x07
	nop
	nop
	jal pintapac
	nop
	nop
	
	nop
	nop
	lw $t0,players
	nop
	nop
	blt $t0,3,loop
	nop
	nop
	
	nop
	nop
	la $t0,baseadd
	nop
	nop
	lw $a1,0($t0)
	nop
	nop
	addi $a1,$a1,71044
	nop
	nop
	la $t1,pac_position
	nop
	nop
	sw $a1,8($t1)
	nop
	nop
	addi $a0,$zero,0x70
	nop
	nop
	jal pintapac
	nop
	nop
	
	nop
	nop
	lw $t0,players
	nop
	nop
	blt $t0,4,loop
	nop
	nop
	
	nop
	nop
	la $t0,baseadd
	nop
	nop
	lw $a1,0($t0)
	nop
	nop
	addi $a1,$a1,71344
	nop
	nop
	la $t1,pac_position
	nop
	nop
	sw $a1,12($t1)
	nop
	nop
	addi $a0,$zero,0x04
	nop
	nop
	jal pintapac	
	nop
	nop
loop:
