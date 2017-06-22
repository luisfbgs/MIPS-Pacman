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
 espelho: .word 1
 boca_coord: .word 0,0 , 0,0
 velocidade: .word 100
 aberta: .word 1,1,1,1
 pac_position: .word 0,0,0,0
 mov_ant: .word 0,0,0,0
 mov: .word 0,0,0,0
 atpac: .word 0
 cor: .word 0
 meiaberta: .word 1
 # Define quantos pac-mans vao ter no jogo (1~4)
 players: .word 4
 
.text
addi $t0,$zero,1
la $t1,espelho
sw $t0,0($t1)

li $sp,0x10011ffc

j mapa

#Preenche tela de preto -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 preenchetela:	
	# pinta a tela de preto
 	li $t0,0xff000000
 	li $t1,0xff012c00
 	li $a2,0x00000000
 tela:
 	beq $t0,$t1,saitela
 	sw $a2,0($t0)
 	addi $t0,$t0,4
 	j tela	
saitela: 
 	jr $ra 	

#Funcao ponto ----------------------------------------------------------------------------------------------------------------------------------------------------
funcao_ponto:
	# $a0 = x, $a1 = y
	
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t9, 8($sp)
	#Uso do t0(variaveis) e t1(endere?o)
	move $t0,$a1
	addi $at,$zero,320
	mult $t0,$at # y *= 320
	mflo $t0
	lw $t1,baseadd #retorno recebe end base
	add $t1,$t1,$t0
	move $t9,$t1
	move $t0,$a0 #reg reusado
	add $t1,$t1,$t0
	sb $a2,0($t1)
	move $t1,$t9
	la $t9,espelho
	lw $t9,0($t9)
	beqz $t9,saiponto
	addi $t1,$t1,319
	sub $t1,$t1,$t0
	sb $a2,0($t1)
saiponto:	
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t9, 8($sp)
	addi $sp, $sp, 12
	jr $ra

#Funcao reta -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sub $t0,$t8,$t6

	if_fr_1:
		bgt $t0,$zero,else_fr_1
		addi $at,$zero,-1
 		mult $t0,$at #Se s0 negativo troque o sinal
 		mflo $t0
 		addi $t2,$zero,-1 #sx = negativo
 		j endif_fr_1
	else_fr_1:
	 	addi $t2,$zero,1 #se s0 pos, dx = 1
	endif_fr_1:
	
	sub $t1,$t9,$t7 # dy = y1 - y0
	if_fr_2:
		bgt $t1,$zero,else_fr_2 
		addi $at,$zero,-1
 		mult $t1,$at #Se s1 negativo troque o sinal
 		mflo $t1
 		addi $t3,$zero,-1 #dy negativo
 		j endif_fr_2
	else_fr_2: 	
		addi $t3,$zero,1 #se s3 positivo, dy = 1
	endif_fr_2:

	if_fr_3:
		bgt $t0,$t1,else_fr_3 #se dx>dy
		addi $at,$zero,-1
		mult $t1,$at #err = (-dy)
		mflo $t4
		j endif_fr_3
 	else_fr_3: 
 		move $t4,$t0 #err = dx
 	endif_fr_3:

	sra $t4,$t4,1 # err = err/2 

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
			addi $at,$zero,-1
			mult $t0, $at
			mflo $t0
			ble $t5, $t0, endif_fr_4
			sub $t4, $t4, $t1
			add $t6, $t6, $t2	
		endif_fr_4:
		addi $at,$zero,-1
		mult $t0, $at
		mflo $t0
		if_fr_5:
			bge $t5, $t1, endif_fr_5
			add $t4, $t4, $t0
			add $t7, $t7, $t3
		endif_fr_5:
		j while_fr_1
	ew_fr_1:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra

#Loop mapa -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_mapa:
	addi $s0,$zero,0
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
 	
#Loop food -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_food:
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)	
		
	lw $a1,4($a0)
	lw $a0,0($a0)
	addi $s0,$zero,0
	
	loop_food_for: beq $s0,$s1,end_loop_food_for
		jal funcao_ponto
		addi $a0,$a0,1
		jal funcao_ponto
		addi $a1,$a1,1
		jal funcao_ponto
		addi $a0,$a0,-1
		jal funcao_ponto
		
		beq $s2,$zero,vertical
		addi $a0,$a0,12
		addi $a1,$a1,-1
		j end
		vertical:addi $a1,$a1,11
		end:
		addi $s0,$s0,1
	j loop_food_for
	end_loop_food_for:
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	addi $sp,$sp,12
	
	jr $ra

#Funcao mapa ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
mapa:
	jal preenchetela
	
	la $a0,coordinates1
	addi $a2,$zero,0xC0
	addi $s1,$zero,7
	jal loop_mapa	

	la $a0,coordinates2
	addi $s1,$zero,9
	jal loop_mapa
			
	la $a0,coordinates3
	addi $s1,$zero,4
	jal loop_mapa
	
	la $a0,coordinates4
	addi $s1,$zero,4
	jal loop_mapa
	
	la $a0,coordinates5	
	addi $s1,$zero,4
	jal loop_mapa
	
	la $a0,coordinates6
	addi $s1,$zero,8
	jal loop_mapa
	
	la $a0,coordinates7
	addi $s1,$zero,5
	jal loop_mapa
	
	la $a0,coordinates8
	addi $s1,$zero,3
	jal loop_mapa
	
	la $a0,coordinates9
	addi $s1,$zero,4
	jal loop_mapa
	
	la $a0,coordinates10
	addi $s1,$zero,6
	jal loop_mapa
	
	la $a0,coordinates11
	addi $s1,$zero,5
	jal loop_mapa
	
	la $a0,coordinates12
	addi $s1,$zero,4
	jal loop_mapa
	
	la $a0,coordinates13
	addi $s1,$zero,4
	jal loop_mapa
	
#Funcao comida ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	#COMIDA DE GORILA
	
	#vertical aqui
	addi $s2,$zero,0 		#s2 recebe 0 se for vertical e 1,vertical 
	la $a0,food_coordinate1
	la $a2,0xFFFFFFFF
	addi $s1,$zero,5
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,13
	jal loop_food

	addi $a0,$a0,8
	addi $s1,$zero,2
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,3
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,6
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,4
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,2
	jal loop_food
	
	#horizontal aqui
	la $a0,food_coordinate2
	addi $s2,$zero,1
	
	addi $s1,$zero,12
	jal loop_food	
	
	addi $a0,$a0,8
	addi $s1,$zero,14
	jal loop_food	
	
	addi $a0,$a0,8
	addi $s1,$zero,4
	jal loop_food	
	
	addi $a0,$a0,8
	addi $s1,$zero,4
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,11
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,13
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,5
	jal loop_food
	j loop_jogo

#Colide ------------------------------------------------------------------------------------------------------------------------------------------------------------	
colide:
	sb $a2,0($a1)
	sb $a2,5($a1)
	sb $a2,6($a1)
	sb $a2,11($a1)
	sb $a2,3520($a1)
	sb $a2,1600($a1)
	sb $a2,1611($a1)
	sb $a2,1920($a1)
	sb $a2,1931($a1)
	sb $a2,3525($a1)
	sb $a2,3526($a1)
	sb $a2,3531($a1)
	jr $ra
	
#Pinta Pac ------------------------------------------------------------------------------------------------------------------------------------------------------------	
pintapac:
	# a0 = centro x, a1 = centro y, a2 = cor , a3 = raio
	# guarda na pilha registradores preservados que serao utiaddizado,$zeros
	subi $sp,$sp,20
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $a1,16($sp)
	
	move $a2,$a0
	la $a3,5
	la $t0,320
	subi $a1,$a1,4278190080
	div $a1,$t0
	mfhi $a0
	mflo $a1
	addi $a0,$a0,6
	addi $a1,$a1,6
	sw $a0,8($sp)
	sw $a1,12($sp)
	
	add $s0,$zero,$zero # y inicial
	add $s1,$zero,$a3 # x inicial
	add $s2,$zero,$zero # erro
	add $s3,$zero,$a1 # y
	add $s4,$zero,$a0 # x
	addi $s5,$zero,320
	mult $a3,$a3 # raio = raio ao quadrado
	mflo $a3
circloop:
	blt $s1,$s0,endcirculo
		# colocar pontos simetricamente nos oito octantes do circulo
		add $a0,$s4,$s1 
		add $a1,$s3,$s0
		jal funcao_ponto

	      	add $a0,$s4,$s0
		add $a1,$s3,$s1
		jal funcao_ponto
     	
        	sub $a0,$s4,$s0
		add $a1,$s3,$s1
		jal funcao_ponto

        	sub $a0,$s4,$s1
		add $a1,$s3,$s0
		jal funcao_ponto

        	sub $a0,$s4,$s1
		sub $a1,$s3,$s0
		jal funcao_ponto
	
        	sub $a0,$s4,$s0
		sub $a1,$s3,$s1
		jal funcao_ponto

        	add $a0,$s4,$s0
		sub $a1,$s3,$s1
		jal funcao_ponto

        	add $a0,$s4,$s1
		sub $a1,$s3,$s0
		jal funcao_ponto
		
		addi $s0,$s0,1 # incrementa o y
		
		mult $s0,$s0
		mflo $t0
		mult $s1,$s1
		mflo $t1
		add $t1,$t0,$t1
		sub $t2,$t1,$a3 # salva em $t2 o valor y^2 + x^2 - r^2
		
		addi $t1,$s1,-1
		mult $t1,$t1
		mflo $t1
		add $t1,$t0,$t1
		sub $t3,$t1,$a3 # salva em $t3 o valor y^2 + (x-1)^2 - r^2
		
		abs $t2,$t2
		abs $t3,$t3
		
		blt $t2,$t3,circloop # caso o valor de $t3 seja mais proximo de 0, x recebe x - 1, caso contratio x matem seu valor
		addi $s1,$s1,-1
		j circloop
endcirculo:
	
	lw $a0,8($sp)
	lw $a1,12($sp)
	jal preenche_pac
	
	lw $a1,16($sp)
	addi $a2,$zero,0xC8
	jal colide
	
	# recuperar da pilha registradores preservados utilizados
	lw $ra,0($sp)  
	lw $t0,4($sp)
	addi $sp,$sp,20
	jr $ra

#Pinta boca ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

boca: 
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $a1,8($sp)
	
	add $a2,$zero,$zero
	addi $t0,$zero,320
	subi $a1,$a1,4278190080
	div $a1,$t0
	mfhi $a0
	mflo $a1
	add $a0,$a0,$s0
	add $a1,$a1,$s1
	
	la $s1,boca_coord
	sw $a0,0($s1)
	sw $a1,4,($s1)
	add $a0,$a0,$s2
	add $a1,$a1,$s3
	sw $a0,8($s1)
	sw $a1,12,($s1)
	move $a0,$s1
	jal funcao_reta
	lw $a0,8($s1)
	lw $a1,12($s1)	

	la $s1,boca_coord
	sw $a0,0($s1)
	sw $a1,4,($s1)
	add $a0,$a0,$s4
	add $a1,$a1,$s5
	sw $a0,8($s1)
	sw $a1,12,($s1)
	move $a0,$s1
	jal funcao_reta
	lw $a0,8($s1)
	lw $a1,12($s1)
				
	la $s1,boca_coord
	sw $a0,0($s1)
	sw $a1,4,($s1)
	add $a0,$a0,$s6
	add $a1,$a1,$s7
	sw $a0,8($s1)
	sw $a1,12,($s1)
	move $a0,$s1
	jal funcao_reta
	
	lw $a0,8($s1)
	lw $a1,12($s1)
	add $a0,$a0,$v0
	add $a1,$a1,$v1
	jal preenche_pac
	
	lw $a1,8($sp)
	addi $a2,$zero,0xC8
	jal colide
	sb $a2,0($a1)
	
	lw $ra,0($sp)
	lw $t0,4($sp)
	addi $sp,$sp,12
	jr $ra

#Preenche Pac --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
preenche_pac: jr $ra
 	# $a0 = x, $a1 = y, $a2 = cor
 	addi $sp,$sp,-4
	
	li $t0,0xff000000
	add $t0,$t0,$a0
	addi $at,$zero,320
	mult $a1,$at
	mflo $a1
	add $t0,$t0,$a1
	
	move $t1,$sp
	move $t2,$t1
	sw $t0,0($t1)
	addi $t1,$t1,-4
	# $t2 inicio da fila,$t1 fim da fila
dfs:	
	beq $t1,$t2,endpreenche 
		addi $t1,$t1,4
		lw $t0,0($t1)
		lb $t3,0($t0)
		beq $t3,$a2,dfs
		sb $a2,0($t0)
			# atualiza o ponteiro da fila
			addi $t1,$t1,-16
			# coloca na fila os enderecos adjacentes a $t0
			addi $t0,$t0,1
			sw $t0,16($t1)
			addi $t0,$t0,-2
			sw $t0,12($t1)
			addi $t0,$t0,321
			sw $t0,8($t1)
			addi $t0,$t0,-640
			sw $t0,4($t1)

		j dfs
endpreenche:
	addi $sp,$sp,4
	jr $ra

#Limpa pac --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
limpa:
	addi $t6,$zero,12
	addi $t3,$a1,0
	addi $a0,$zero,0x0000
limpaloop:
	addi $t6,$t6,-1
	addi $t7,$t3,12
limpaloop2:    
	beq $t3,$t7,sailimpaloop
	sb $a0,0($t3)
	addi $t3,$t3,1
	j limpaloop2
sailimpaloop:
	addi $t3,$t3,308
	bne $t6,$zero,limpaloop
	jr $ra


# Proximo pac --------------------------------------------------------------
prox_pac:
	lw $t1,atpac
	lw $t0,players
	blt $t0,2,loop
	beq $t1,0,dir2
	blt $t0,3,loop
	beq $t1,4,dir3
	blt $t0,4,loop
	beq $t1,8,dir4
	beq $t1,12,loop

# Mesmo pac --------------------------------------------------------------
msm_pac:
	lw $t1,atpac
	beq $t1,0,ddir
	beq $t1,4,ddir2
	beq $t1,8,ddir3
	beq $t1,12,ddir4


#Erro movimentacao pac -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
erro_dir:
	la $t1,atpac
	lw $t1,0($t1)
	la $t0,mov_ant
	add $t0,$t0,$t1
	lw $t1,0($t0)
	beq $t1,$t2,prox_pac
	la $t2,mov_ant
	j msm_pac
#Evita colisao -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ve_se_bate:
	addi $v1,$zero,0
	lb $a0,0($a2)
	andi $a0,$a0,0xFF
	bnez $a0,bate
	jr $ra
bate:
	addi $v1,$zero,1
	jr $ra

#Pac pra cima -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cima:
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	
	addi $a2,$a1,-320
	jal ve_se_bate
	bnez $v1,erro_dir
	addi $a2,$a1,-309
	jal ve_se_bate
	bnez $v1,erro_dir
	
	lw $t4,meiaberta	
	bnez $t4,cima2
	
	la $t1,mov_ant
	add $t1,$t1,$t3
	sw $t2,0($t1)
	jal limpa
	
	lw $a1,0($t0)
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,-1920
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	addi $s0,$zero,6
	addi $s1,$zero,5
	addi $s2,$zero,-3
	addi $s3,$zero,-4
	addi $s4,$zero,6
	addi $s5,$zero,0
	addi $s6,$zero,-3
	addi $s7,$zero,4
	addi $v0,$zero,0
	addi $v1,$zero,-2

	jal boca
	j saicima
cima2:
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)
	
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	jal limpa
	
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,-1920
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,saicima2
	
	addi $s0,$zero,6
	addi $s1,$zero,5
	addi $s2,$zero,-6
	addi $s3,$zero,-4
	addi $s4,$zero,11
	addi $s5,$zero,0
	addi $s6,$zero,-6
	addi $s7,$zero,4
	addi $v0,$zero,0
	addi $v1,$zero,-2
	
	jal boca
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	sw $zero,0($t0)
	j saicima
saicima2:
	addi $t1,$zero,1
	sw $t1,0($t0)
saicima:
	j prox_pac

#Pac pra baixo -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
baixo:
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	
	addi $a2,$a1,3840
	jal ve_se_bate
	bnez $v1,erro_dir
	addi $a2,$a1,3851
	jal ve_se_bate
	bnez $v1,erro_dir
	
	lw $t4,meiaberta
	bnez $t4,baixo2
	
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)
	jal limpa
	
	lw $a1,0($t0)
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,1920
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	addi $s0,$zero,6
	addi $s1,$zero,7
	addi $s2,$zero,-3
	addi $s3,$zero,4
	addi $s4,$zero,6
	addi $s5,$zero,0
	addi $s6,$zero,-3
	addi $s7,$zero,-4
	addi $v0,$zero,0
	addi $v1,$zero,2

	jal boca
	j saibaixo
baixo2:
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)
	
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	jal limpa
	
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,1920
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,saibaixo2
	
	addi $s0,$zero,6
	addi $s1,$zero,7
	addi $s2,$zero,-6
	addi $s3,$zero,4
	addi $s4,$zero,11
	addi $s5,$zero,0
	addi $s6,$zero,-6
	addi $s7,$zero,-4
	addi $v0,$zero,0
	addi $v1,$zero,2
	
	jal boca
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	sw $zero,0($t0)
	j saibaixo
saibaixo2:
	addi $t1,$zero,1
	sw $t1,0($t0)
saibaixo:
	j prox_pac
	
#Pac pra esquerda -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
esquerda:
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	
	addi $a2,$a1,-1
	jal ve_se_bate
	bnez $v1,erro_dir
	addi $a2,$a1,3519
	jal ve_se_bate
	bnez $v1,erro_dir

	lw $t4,meiaberta
	bnez $t4,esquerda2
	
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)
	jal limpa
	
	lw $a1,0($t0)
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,-6
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	addi $s0,$zero,5
	addi $s1,$zero,6
	addi $s2,$zero,-4
	addi $s3,$zero,-3
	addi $s4,$zero,0
	addi $s5,$zero,6
	addi $s6,$zero,4
	addi $s7,$zero,-3
	addi $v0,$zero,-2
	addi $v1,$zero,0

	jal boca
	
	j saiesquerda
esquerda2:
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)
	
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	jal limpa
	
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,-6
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,saiesquerda2
	
	addi $s0,$zero,5
	addi $s1,$zero,6
	addi $s2,$zero,-4
	addi $s3,$zero,-6
	addi $s4,$zero,0
	addi $s5,$zero,11
	addi $s6,$zero,4
	addi $s7,$zero,-6
	addi $v0,$zero,-2
	addi $v1,$zero,0
	
	jal boca
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	sw $zero,0($t0)
	j saiesquerda
saiesquerda2:
	addi $t1,$zero,1
	sw $t1,0($t0)
saiesquerda:	
	j prox_pac

#Pac pra direita -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
direita:
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	
	addi $a2,$a1,12
	jal ve_se_bate
	bnez $v1,erro_dir
	addi $a2,$a1,3532
	jal ve_se_bate
	bnez $v1,erro_dir
	
	lw $t4,meiaberta
	bnez $t4,direita2
	
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)
	jal limpa
	
	lw $a1,0($t0)
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,6
	sw $a1,0($t0)
	jal pintapac
	
	lw $a1,0($t0)
	addi $s0,$zero,7
	addi $s1,$zero,6
	addi $s2,$zero,4
	addi $s3,$zero,-3
	addi $s4,$zero,0
	addi $s5,$zero,6
	addi $s6,$zero,-4
	addi $s7,$zero,-3
	addi $v0,$zero,2
	addi $v1,$zero,0

	jal boca
	j saidireita
	
direita2:
	la $t1,mov_ant
	lw $t3,atpac
	add $t1,$t1,$t3
	sw $t2,0($t1)

	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	jal limpa
	
	la $a0,cor
	lw $a0,0($a0)
	addi $a1,$a1,6
	sw $a1,0($t0)
	jal pintapac

	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,saidireita2

	addi $s0,$zero,7
	addi $s1,$zero,6
	addi $s2,$zero,4
	addi $s3,$zero,-6
	addi $s4,$zero,0
	addi $s5,$zero,11
	addi $s6,$zero,-4
	addi $s7,$zero,-6
	addi $v0,$zero,2
	addi $v1,$zero,0

	jal boca
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	sw $zero,0($t0)
	j saidireita
saidireita2:
	addi $t1,$zero,1
	sw $t1,0($t0)
saidireita:	
	j prox_pac

teclap1:
	la $t3,mov
	sw $t2,0($t3)
	j sai_tecla
	
teclap2:
	la $t3,mov
	sw $t2,4($t3)
	j sai_tecla
teclap3:
	la $t3,mov
	sw $t2,8($t3)
	j sai_tecla
teclap4:
	la $t3,mov
	sw $t2,12($t3)
	j sai_tecla

#Armazena tecla lida ------------------------------------------------------------------------------------------------------------------
tecla:	
	# Pac-man 1
	beq $t2,0x1D,teclap1	# cima - w
	beq $t2,0x1B,teclap1	# baixo - s
	beq $t2,0x23,teclap1	# direita - d
	beq $t2,0x1C,teclap1	# esquerda - a
	
	beq $t2,0x43,teclap2	# cima - i
	beq $t2,0x42,teclap2	# baixo - k
	beq $t2,0x4b,teclap2	# direita - l
	beq $t2,0x3b,teclap2	# esquerda - j
	
	beq $t2,0x75,teclap3	# cima - 8
	beq $t2,0x72,teclap3	# baixo - 5
	beq $t2,0x74,teclap3	# direita - 6
	beq $t2,0x6B,teclap3	# esquerda - 4

	beq $t2,0x2B,teclap4	# cima - f
	beq $t2,0x2A,teclap4	# baixo - v
	beq $t2,0x32,teclap4	# direita - b
	beq $t2,0x21,teclap4	# esquerda - c
sai_tecla: 
	jr $ra
	
#Loop de jogo --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_jogo:
	la $t0,espelho
	sw $zero,0($t0)
	la $t0,baseadd
	lw $a1,0($t0)
	addi $a1,$a1,1924
	la $t1,pac_position
	sw $a1,0($t1)
	addi $a0,$zero,0x77
	jal pintapac
	
	lw $t0,players
	blt $t0,2,loop
	
	la $t0,baseadd
	lw $a1,0($t0)
	addi $a1,$a1,2224
	la $t1,pac_position
	sw $a1,4($t1)
	addi $a0,$zero,0x07
	jal pintapac
	
	lw $t0,players
	blt $t0,3,loop
	
	la $t0,baseadd
	lw $a1,0($t0)
	addi $a1,$a1,71044
	la $t1,pac_position
	sw $a1,8($t1)
	addi $a0,$zero,0x70
	jal pintapac
	
	lw $t0,players
	blt $t0,4,loop
	
	la $t0,baseadd
	lw $a1,0($t0)
	addi $a1,$a1,71344
	la $t1,pac_position
	sw $a1,12($t1)
	addi $a0,$zero,0x1C
	jal pintapac	
loop:
	la $t0,meiaberta
	lw $t1,0($t0)
	xori $t1,$t1,1
	sw $t1,0($t0)
	la $t1,0xFFFF0100
	lb $t2,0($t1)       # Tecla lida
	jal tecla
	
	la $t0,velocidade
	lw $a0,0($t0)
	
	li $t5,0xFFFF050C
	lw $t0,0($t5)
	add $t0,$t0,$a0
	lw $t4,0($t5)
ler:	
	blt $t4,$zero,dir
		lw $t4,0($t5)
		sub $t4,$t0,$t4
		#syscall
	j ler
dir:
	la $t2,atpac
	addi $t1,$zero,0
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x77
	sw $t1,0($t2)
	la $t2,mov
ddir:	
	lw $t2,0($t2)

	beq $t2,0x1D,cima	# cima - w
	beq $t2,0x1B,baixo	# baixo - s
	beq $t2,0x23,direita	# direita - d
	beq $t2,0x1C,esquerda	# esquerda - a
	
	lw $t1,players
	blt $t1,2,loop
	
dir2:	
	la $t2,atpac
	addi $t1,$zero,4
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x07
	sw $t1,0($t2)
	la $t2,mov
ddir2:	
	lw $t2,4($t2)
	
	beq $t2,0x43,cima	# cima - i
	beq $t2,0x42,baixo	# baixo - k
	beq $t2,0x4b,direita	# direita - l
	beq $t2,0x3b,esquerda	# esquerda - j
	
	lw $t0,players
	blt $t0,3,loop
	
dir3:	
	la $t2,atpac
	addi $t1,$zero,8
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x70
	sw $t1,0($t2)
	la $t2,mov
ddir3:	
	lw $t2,8($t2)
	
	beq $t2,0x75,cima	# cima - 8
	beq $t2,0x72,baixo	# baixo - 5
	beq $t2,0x74,direita	# direita - 6
	beq $t2,0x6B,esquerda	# esquerda - 4
	
	lw $t0,players
	blt $t0,4,loop
	
dir4:	
	la $t2,atpac
	addi $t1,$zero,12
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x1C
	sw $t1,0($t2)
	la $t2,mov
ddir4:	
	lw $t2,12($t2)
	
	beq $t2,0x2B,cima	# cima - f
	beq $t2,0x2A,baixo	# baixo - v
	beq $t2,0x32,direita	# direita - b
	beq $t2,0x21,esquerda	# esquerda - c
	
	j loop
