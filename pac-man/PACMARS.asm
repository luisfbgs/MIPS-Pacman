#################################################################
#	Jogo Pac-man                                           	#
#	Organizacao e arquitetura de computadores  1/2017    	#
#	Gabriel Nunes - 16/0006597 - nunesgrf@gmail.com 	#
#	Gabriel Lobão - 16/0046424 - lobao5670@gmail.com	#
#	Mikael Mello - 16/0015537 - mikaelmello@hotmail.com	#
#	Luis Braga - 16/0071569 - arueluis@gmail.com		#
#	Gabriel Levi - 16/0006490 - gabrielevigomes@gmail.com	#
#	Léo Moraes - 16/0011795 - leo.ms097@gmail.com		#
#################################################################
.data
 coordinates1: .word 159,0 ,  0,0 , 0,82 , 48,82 , 48,158 , 0,158 , 0,239 , 159,239
 coordinates2: .word 159,41, 148,41 , 148,5 , 3,5 , 3,78 , 51,78 , 51,161  
 , 3,161, 3,234 , 159,234  
 coordinates3: .word 16,18 , 51,18 , 51,41 , 16,41 , 16,18   
 coordinates4: .word 16,54 , 51,54 ,  51,65 , 16,65 , 16,54
 coordinates5: .word 135,18 , 64,18 , 64,41 , 135,41 , 135,18 
 coordinates6: .word 64,54 , 64,113 , 75,113 , 75,89 , 135,89 , 135,78 , 75,78 , 75,54 , 64,54
 coordinates7: .word 159,54 , 88,54 , 88,65 , 148,65 , 148,89 , 159,89
 coordinates8: .word 159,102 , 88,102 , 88,161 , 159,161
 coordinates9: .word 151,102 , 151,109 , 97,109 , 97,155 , 159,155 
 coordinates10: .word 64,126 , 64,174 , 16,174 , 16,185 , 75,185, 75,126 , 64,126
 coordinates11: .word 166,174 , 88,174 , 88,185 , 148,185 , 148,221 , 166,221
 coordinates12: .word 16,198 , 51,198 , 51,221 , 16,221 , 16,198
 coordinates13: .word 64,198 , 135,198 , 135,221 , 64,221 , 64,198
 menu_triangle_1: .word 139,103, 128,117, 139,132, 139,103
 menu_triangle_2: .word 180,103, 192,117, 180,132, 180,103
 food_coordinate1: .word 9,23 , 57,23 , 141,23 , 81,47 , 9,167 , 141,191 , 57,203
 food_coordinate2: .word 9,11 , 9,47 , 9,71 , 9,167 , 9,191 , 9,227 , 93,71
 food3: .word 57,119 , 129,47 , 141,191
 espelho: .word 1
 game_over_text_screen_1: .asciiz "Game Over"
 NOTASNO: .word 12
 NOTASINFO: .word 65, 500, 60, 500, 57, 500, 62, 300, 64, 300, 62, 300, 61, 300, 63, 300, 61, 300, 60, 200, 58, 200, 60, 600
 
 # Define quantos pac-mans vao ter no jogo (1~4)
 players: .word 4
 velocidade: .word 125
 boca_coord: .word 0,0 , 0,0
 aberta: .word 1,1,1,1
 meiaberta: .word 1
 mov_ant: .word 0,0,0,0
 mov: .word 0,0,0,0
 atpac: .word 0
 pac_position: .word 0,0,0,0
 pac_comedor: .word 0,0,0,0
 pac_score: .word 0,0,0,0
 cor: .word 0
 morto: .word -1,-1,-1,-1
 pontos: .word 0,0,0,0
 bixao: .word 0,0,0,0
 
 g_position: .word 0,0,0,0
 mov_antg: .word 0,0,0,0
 preso: .word 50
 comida: .word 0,0,0,0
.text
inicio:
# Menu : 'a' direita, 's' esquerda, 'enter' confirmar numero de jogadores
# Jogo : Pacman amarelo: 'w' cima, 's' baixo, 'a' direita, 'd' esquerda
# Pacman vermelho: 'i' cima, 'j' esquerda, 'k' baixo, 'l' direita
# Pacman verde: '8' cima, '5' baixo, '4' esquerda, '6' direita
# Pacman marrom: 'f' cima, 'v' baixo, 'c' equerda, 'b' direita


li $sp,0x10011ffc

la $t0,mov
sw $0,0($t0)
sw $0,4($t0)
sw $0,8($t0)
sw $0,12($t0)

la $t0,comida
sw $0,12($t0)
sw $0,0($t0)
nop
sw $0,4($t0)
sw $0,8($t0)


la $t0,bixao
sw $0,0($t0)
sw $0,4($t0)
sw $0,8($t0)
sw $0,12($t0)

jal main_menu

addi $t0,$zero,1
la $t1,espelho
sw $t0,0($t1)

addi $t0,$zero,-1
la $t1,morto
sw $t0,0($t1)
sw $t0,4($t1)
sw $t0,8($t1)
sw $t0,12($t1)

addi $t0,$zero,50
la $t1,preso
sw $t0,0($t1)

la $t1,pontos
sw $0,0($t1)
sw $0,4($t1)
sw $0,8($t1)
sw $0,12($t1)

j mapa

# Menu inicial

main_menu:

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	jal preenchetela
	#a0 = Endereco das coordenadas
	#a2 = cor
	
	la $a0, menu_triangle_1
	addi $a2, $0, 0x3F
	jal funcao_reta
	addi $a0, $a0, 8
	jal funcao_reta
	addi $a0, $a0, 8
	jal funcao_reta
	
	la $a0, menu_triangle_2
	addi $a2, $0, 0x3F
	jal funcao_reta
	addi $a0, $a0, 8
	jal funcao_reta
	addi $a0, $a0, 8
	jal funcao_reta
	
	la $t1,0xFF100004
	la $t3, players
	lw $a0, 0($t3)
	addi $s0, $a0, 0
	jal print_number_players
	polling:
		sw $a0,0($t3)
		beq $s0, $a0, n_mudou
		jal print_number_players
		addi $s0, $a0, 0
		n_mudou:
		la $t1,0xFF100004
		addi $t5,$0,1000
loop_pra_nao_bugar:
			addi $t5,$t5,-1
			bnez $t5,loop_pra_nao_bugar
		addi $v0,$0,32
		addi $s0,$a0,0
		addi $a0,$0,1000
		syscall
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		lb $t2,0($t1)       # Tecla lida
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		sb $0, 0($t1)
		addi $a0,$s0,0 
		beq $t2, 0x0A, endpolling
		bne $t2, 0x61, notA
		
		addi $a0, $a0, -1
		bne $a0, $0, polling
		addi $a0, $0, 4
		sw $a0, 0($t3)	
		
		notA: bne $t2, 0x64, notD
		
		addi $a0, $a0, 1
		bne $a0, 5, polling
		addi $a0, $0, 1
		sw $a0, 0($t3)
	
		notD: j polling
	endpolling:
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
# Tela de game over

game_over:

	la $t0, morto
	lw $t1, 0($t0)
	lw $t2, players
	beq $t1, -1, not_game_over
	beq $t2,  1, real_game_over
	lw $t1, 4($t0)
	beq $t1, -1, not_game_over
	beq $t2,  2, real_game_over
	lw $t1, 8($t0)
	beq $t1, -1, not_game_over
	beq $t2,  3, real_game_over
	lw $t1, 12($t0)
	beq $t1, -1, not_game_over
	
	real_game_over:
	
	la $a0, game_over_text_screen_1
	addi $a1, $0, 125
	addi $a2, $0, 120
	addi $v0, $0, 104
	addi $a3,$0,0x00FF
	syscall
	
	la $t1,NOTASNO
	lw $t2,0($t1)
	la $t1,NOTASINFO
	addi $t0,$0,0
	addi $a2,$0,58	
	addi $a3,$0,100	
	LOOP23:
		beq $t0,$t2, FIM23
		lw $a0,0($t1)		
		lw $a1,4($t1)		
		addi $v0,$0,31		
		syscall
		add $a0,$0,$a1		
		addi $v0,$0,32
		syscall
		addi $t1,$t1,8
		addi $t0,$t0,1
		j LOOP23
	FIM23:
	
	
	j inicio
	
	not_game_over:
	jr $ra


# imprime numero de players

print_number_players: 

	li $t0, 0xFF000000
	li $t2, 0xFFFFFFFF
	
	addi $t8, $0, 0
	addi $t9, $0, 30
	addi $t4, $0, 102
	addi $t1, $0, 320
	mult $t1, $t4
	mflo $t1
	addi $t1, $t1, 140
	add $t1, $t1, $t0
	addi $t4, $0, 0
	addi $t5, $0, 30

	loop_black:
	beq $t8, $t9, emb
		sw $0, 0($t1)
		sw $0, 4($t1)
		sw $0, 8($t1)
		sw $0, 12($t1)
		sw $0, 16($t1)
		sw $0, 20($t1)
		sw $0, 24($t1)
		sw $0, 28($t1)
		sw $0, 32($t1)
		sw $0, 36($t1)
		addi $t1, $t1, 320
		addi $t8, $t8, 1
		j loop_black
	emb:
	
	addi $t4, $0, 102

	addi $t1, $0, 320
	mult $t1, $t4
	mflo $t1
	
	bne $a0, 1, notOne
		addi $t1, $t1, 156
		add $t1, $t1, $t0
		addi $t4, $0, 0
		addi $t5, $0, 30
		loopnotone:
		beq $t4, $t5, endloopnotone
			sw $t2, 0($t1)
			sw $t2, 4($t1)
			addi $t1, $t1, 320
			addi $t4, $t4, 1
			j loopnotone		
		endloopnotone:
		jr $ra
	notOne:
	bne $a0, 2, notTwo
		addi $t1, $t1, 148
		add $t1, $t1, $t0
		addi $t4, $0, 0
		addi $t5, $0, 30
		loopnottwo:
		beq $t4, $t5, endloopnottwo
			sw $t2, 0($t1)
			sw $t2, 4($t1)
			sw $t2, 16($t1)
			sw $t2, 20($t1)
			addi $t1, $t1, 320
			addi $t4, $t4, 1
			j loopnottwo		
		endloopnottwo:
		jr $ra
	
	notTwo:
	bne $a0, 3, notThree
		addi $t1, $t1, 144
		add $t1, $t1, $t0
		addi $t4, $0, 0
		addi $t5, $0, 30
		loopnot3:
		beq $t4, $t5, endloopnot3
			sw $t2, 0($t1)
			sw $t2, 4($t1)
			sw $t2, 12($t1)
			sw $t2, 16($t1)
			sw $t2, 24($t1)
			sw $t2, 28($t1)
			addi $t1, $t1, 320
			addi $t4, $t4, 1
			j loopnot3		
		endloopnot3:
		jr $ra
	
	notThree: 
	bne $a0, 4, fudeu
	addi $t6, $0, 0xFF
		addi $t1, $t1, 144
		add $t1, $t1, $t0
		addi $t7, $t1, 0
		addi $t4, $0, 0
		addi $t5, $0, 30
		loopnot4:
		beq $t4, $t5, endloopnot4
			sw $t2, 0($t1)
			sw $t2, 4($t1)
			addi $t1, $t1, 320
			addi $t4, $t4, 1
			j loopnot4		
		endloopnot4:
	
	addi $t8, $0, 5
	addi $t9, $0, 0
	loop_menu_1:
		beq $t8, $t9, em1
		sb $t6, 10($t7)
		sb $t6, 11($t7)
		sw $t2, 12($t7)
		sb $t6, 16($t7)
		sb $t6, 23($t7)
		sw $t2, 24($t7)
		sb $t6, 28($t7)
		sb $t6, 29($t7)
		addi $t9, $t9, 1
		addi $t7, $t7, 320
		j loop_menu_1
	em1:
	addi $t8, $0, 7
	addi $t9, $0, 0
	loop_menu_2:
		beq $t8, $t9, em2
		sb $t6, 11($t7)
		sw $t2, 12($t7)
		sb $t6, 16($t7)
		sb $t6, 17($t7)
		sb $t6, 22($t7)
		sb $t6, 23($t7)
		sw $t2, 24($t7)
		sb $t6, 28($t7)
		addi $t9, $t9, 1
		addi $t7, $t7, 320
		j loop_menu_2
	em2:
	addi $t8, $0, 6
	addi $t9, $0, 0
	loop_menu_3:
		beq $t8, $t9, em3
		sw $t2, 12($t7)
		sb $t6, 16($t7)
		sb $t6, 17($t7)
		sb $t6, 18($t7)
		sb $t6, 21($t7)
		sb $t6, 22($t7)
		sb $t6, 23($t7)
		sw $t2, 24($t7)
		addi $t9, $t9, 1
		addi $t7, $t7, 320
		j loop_menu_3
	em3:
	addi $t8, $0, 5
	addi $t9, $0, 0
	loop_menu_4:
		beq $t8, $t9, em4
		sb $t6, 13($t7)
		sb $t6, 14($t7)
		sb $t6, 15($t7)
		sw $t2, 16($t7)
		sw $t2, 20($t7)
		sb $t6, 24($t7)
		sb $t6, 25($t7)
		sb $t6, 26($t7)
		addi $t9, $t9, 1
		addi $t7, $t7, 320
		j loop_menu_4
	em4:
	addi $t8, $0, 5
	addi $t9, $0, 0
	loop_menu_5:
		beq $t8, $t9, em5
		sb $t6, 15($t7)
		sw $t2, 16($t7)
		sw $t2, 20($t7)
		sb $t6, 24($t7)
		addi $t9, $t9, 1
		addi $t7, $t7, 320
		j loop_menu_5
	em5:
		sw $t2, 16($t7)
		sw $t2, 20($t7)
		addi $t7, $t7, 320
		sw $t2, 16($t7)
		sw $t2, 20($t7)
	
	fudeu:

	jr $ra

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
	addi $t0,$a1, 0
	addi $at,$zero,320
	mult $t0,$at # y *= 320
	mflo $t0
	addi $t1,$0,0xFF000000 #retorno recebe end base
	add $t1,$t1,$t0
	addi $t9,$t1, 0
	addi $t0,$a0, 0 #reg reusado
	add $t1,$t1,$t0
	sb $a2,0($t1)
	addi $t1,$t9, 0
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
 		addi $t4,$t0, 0 #err = dx
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
	addi $a2, $0, -1
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
	
	la $a0,food3
	addi $a2,$0,0x5F
	addi $s1,$zero,1
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,1
	jal loop_food
	
	addi $a0,$a0,8
	addi $s1,$zero,1
	jal loop_food
	
	j loop_jogo

#Colide ------------------------------------------------------------------------------------------------------------------------------------------------------------	
# Marca pontos ao redor do pac-man para verificar colisao
# $a2 = cor
# $a1 = endereco do pacman
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
# Desenha um circulo
# $a1 = endereco
# $a0 = cor
pintapac:
	addi $t6,$zero,6
	addi $t3,$a1,0
	addi $t8,$t3,3210
	addi $t3,$t3,321
	addi $t5,$zero,3
pinta_pacloop:
	addi $t6,$t6,-1
	addi $t7,$t3,10
	sub $t7,$t7,$t5
	add $t3,$t3,$t5
	sub $t8,$t8,$t5
pinta_pacloop2:    
	beq $t3,$t7,saipinta_pacloop
	sb $a0,0($t3)
	sb $a0,0($t8)
	addi $t3,$t3,1
	addi $t8,$t8,-1
	j pinta_pacloop2
saipinta_pacloop:
	addi $t3,$t3,310
	add $t3,$t3,$t5
	addi $t8,$t8,-310
	sub $t8,$t8,$t5
	beqz $t5,aaaa
	addi $t5,$t5,-1
aaaa:
	bne $t6,$zero,pinta_pacloop
	
	sw $ra,-4($sp)
	addi $a2,$zero,0x01
	jal colide
	lw $ra,-4($sp)	
	
	jr $ra

#Pinta boca ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# $a1 = endereco do pacman
# $a2 = 0 pra direita e 2 pra esquerda
# s0 = 0 para boca pequena 1 para boca grande

boca: 
	addi $t2,$zero,0
	addi $t1,$zero,1600
	beqz $s0,boca_cheia
	addi $t1,$zero,960
boca_cheia:
	addi $t3,$a1,325
	sra $a3,$a2,1
	sub $t3,$t3,$a3
	addi $t6,$zero,6
pinta_boca:
	addi $t7,$t3,3200
	srlv $t8,$t1,$t2
	add $t3,$t3,$t8
	sub $t7,$t7,$t8
loop_boca:
	beq $t3,$t7,sai_loop_boca
	sb $zero,0($t3)
	addi $t3,$t3,320
	j loop_boca
sai_loop_boca:	
	addi $t3,$t3,-3199
	add $t3,$t3,$a2
	add $t3,$t3,$t8
	addi $t6,$t6,-1
	beqz $t1, j_loop_boca
	addi $t1,$t1,-320
j_loop_boca:
	bnez $t6,pinta_boca

	addi $a2,$zero,0x01
	j colide
#Pinta boca 2 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# $a1 = endereco do pacman
# $a2 = 0 pra cima e 2 pra baixo
# s0 = 0 para boca pequena 1 para boca grande
boca2: 
	addi $t2,$zero,0
	addi $t1,$zero,5
	beqz $s0,boca_cheia2
	addi $t1,$zero,3
boca_cheia2:
	addi $t3,$a1,1921
	sra $a3,$a2,1
	sub $t3,$t3,$a3
	addi $t6,$zero,6
pinta_boca2:
	addi $t7,$t3,10
	srl $t8,$t1,0
	add $t3,$t3,$t8
	sub $t7,$t7,$t8
loop_boca2:
	beq $t3,$t7,sai_loop_boca2
	sb $zero,0($t3)
	addi $t3,$t3,1
	j loop_boca2
sai_loop_boca2:	
	addi $t3,$t3,-330
	add $t3,$t3,$a2
	add $t3,$t3,$t8
	addi $t6,$t6,-1
	beqz $t1, j_loop_boca2
	addi $t1,$t1,-1
j_loop_boca2:
	bnez $t6,pinta_boca2

	addi $a2,$zero,0x01
	j colide
# Altera o estado da boca do ultimo Pac-man movimentado --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# $t0 = endereco (aberta + (nro no pacman)) contendo 1
muda_boca:
	sw $zero,0($t0)
	j prox_pac

#Limpa --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Pinta um quadrado preto 12x12
# $a1 = endereco
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
	
	addi $t4,$zero,0x08
	addi $t3,$zero,0xFFFFFFc0
	lb $t7,-314($a1)
	beq $t7,$t3,prox1
	beq $t7,$t4,prox1
	beq $t7,0x01,prox1
	sb $t7,6($a1)
	sb $t7,5($a1)
prox1:	lb $t7,3846($a1)
	beq $t7,$t3,prox2
	beq $t7,$t4,prox2
	beq $t7,0x01,prox2
	sb $t7,3526($a1)
	sb $t7,3525($a1)
prox2:	lb $t7,1599($a1)	
	beq $t7,$t3,prox3
	beq $t7,$t4,prox3
	beq $t7,0x01,prox3
	sb $t7,1600($a1)
	sb $t7,1920($a1)
prox3:	lb $t7,1932($a1)	
	beq $t7,$t3,prox4
	beq $t7,$t4,prox4
	beq $t7,0x01,prox4
	sb $t7,1611($a1)
	sb $t7,1931($a1)
prox4:
	jr $ra


# Proximo pac --------------------------------------------------------------
# Verifica o proximo pacman e segue para movimentar o proximo
jrra:
	jal se_mata2
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
# Verifica o proximo pacman e tenta movimenta-lo novamente ( ocorreu erro no movimentacao )
msm_pac:
	lw $t1,atpac
	beq $t1,0,movimenta
	beq $t1,4,movimenta2
	beq $t1,8,movimenta3
	beq $t1,12,movimenta4

# Repinta -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
repinta:
	lw $a0,cor
	jal pintapac
	j prox_pac


#Erro movimentacao pac -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Movimento atual faria o pac-man colidir, tenta realizar o movimento anterior
erro_dir:
	la $t1,atpac
	lw $t1,0($t1)
	la $t0,mov_ant
	add $t0,$t0,$t1
	lw $t1,0($t0)
	beq $t1,$t2,repinta
	la $t2,mov_ant
	j msm_pac
# Verifica colisao -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# $a2 = endereco
# retora $v1 = 0 se nao colidir e outro valor caso contrario 
ve_se_bate:
	addi $v1,$zero,0
	lb $a0,0($a2)
	add $v1,$zero,$a0
	jr $ra

# Pacman se mata -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
se_mata:
	j jrra
se_mata2:
	lw $t3,atpac
	addi $sp,$sp,4
	beq $t3,0,mata_p1
	beq $t3,4,mata_p2
	beq $t3,8,mata_p3
	beq $t3,12,mata_p4

# Bixao mata  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
bixao_mata:
	add $t3,$a1,$a3
	addi $t3,$t3,321
	addi $t6,$0,10
	addi $s4,$0,0
	lw $ra,-4($sp)
loop_bixao_mata2:
	addi $t7,$t3,10
loop_bixao_mata:
	beq $t3,$t7,sai_loop_bixao
		lb $v0,0($t3)
		bne $v0,0x77,nmata_p1
		lw $t3,atpac
		la $t6,pontos
		add $t6,$t6,$t3
		lw $t7,0($t6)
		add $t7,$t7,10
		sw $t7,0($t6)
		j mata_p1
nmata_p1:
		bne $v0,0x07,nmata_p2
		lw $t3,atpac
		la $t6,pontos
		add $t6,$t6,$t3
		lw $t7,0($t6)
		add $t7,$t7,10
		sw $t7,0($t6)
		j mata_p2
nmata_p2:
		bne $v0,0x70,nmata_p3
		lw $t3,atpac
		la $t6,pontos
		add $t6,$t6,$t3
		lw $t7,0($t6)
		add $t7,$t7,10
		sw $t7,0($t6)
		j mata_p3
nmata_p3:
		bne $v0,0x1C,nmata_p4
		lw $t3,atpac
		la $t6,pontos
		add $t6,$t6,$t3
		lw $t7,0($t6)
		add $t7,$t7,10
		sw $t7,0($t6)
		j mata_p4
nmata_p4:
		addi $t3,$t3,1
	j loop_bixao_mata
sai_loop_bixao:
	addi $t6,$t6,-1
	addi $t3,$t3,310
	bnez $t6,loop_bixao_mata2
	
	jr $ra
# Colidi no movimento -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# $s6 e $s7 = descolamento apartir do endereco do pacman que se deseja verificar colisao
mov_colide:
	sw $ra,-4($sp)
	
	bnez $k0,mov_colide2
	
	add $a2,$a1,$s6
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,erro_dir
	beq $v1,0x01,erro_dir
	
	add $a2,$a1,$s7
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,erro_dir
	beq $v1,0x01,erro_dir
	beq $v1,0x08,se_mata
		
	lw $ra,-4($sp)
	jr $ra
	
mov_colide2:

	add $a2,$a1,$s6
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,erro_dir

	add $a2,$a1,$s7
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,erro_dir
	beq $v1,0x01,bixao_mata
			
	lw $ra,-4($sp)
	jr $ra
	
# Verifica se come comida-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ponto_verif:
	lb $t8,1926($a1)
	
	beq $t8,0x5F,ficar_bixao
	
	add $v0,$zero,$t8
	
	beqz $v0,naoponto
	
	sw $a0,-4($sp)
	sw $a1,-8($sp)
	sw $a2,-12($sp)
	sw $a3,-16($sp)
	sw $v0,-20($sp)
	addi $sp,$sp,-20
	
	addi $a0,$0,73		
	addi $a1,$0,10
	addi $a2,$0,0
	addi $a3,$0,127		
	addi $v0,$0,31		
	syscall
	
	addi $sp,$sp,20
	lw $a0,-4($sp)
	lw $a1,-8($sp)
	lw $a2,-12($sp)
	lw $a3,-16($sp)
	lw $v0,-20($sp)
naoponto:	
	andi $v0,$v0,1
	lw $v1,0($s5)
	add $v0,$v0,$v1
	sw $v0,0($s5)
	
	jr $ra
	
ficar_bixao:

	sw $a0,-4($sp)
	sw $a1,-8($sp)
	sw $a2,-12($sp)
	sw $a3,-16($sp)
	sw $v0,-20($sp)
	addi $sp,$sp,-20
	
	addi $a0,$0,90		
	addi $a1,$0,20
	addi $a2,$0,0
	addi $a3,$0,127		
	addi $v0,$0,31		
	syscall
	
	addi $sp,$sp,20
	lw $a0,-4($sp)
	lw $a1,-8($sp)
	lw $a2,-12($sp)
	lw $a3,-16($sp)
	lw $v0,-20($sp)
	
	lw $t7,atpac
	la $t6,bixao
	add $t6,$t6,$t7
	addi $t5,$0,50
	sw $t5,0($t6)
	
	jr $ra 	
# Movimenta o Pacman  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# $s6 e $s7 = descolamento apartir do endereco do pacman que se deseja verificar colisao
# $a3 = deslocamento que se deseja fazer no pacman
mexe_pac:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t0,pac_position
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $a1,0($t0)
	la $s5,pontos
	add $s5,$s5,$t3
	la $k0,bixao
	add $k0,$k0,$t3
	lw $k0,0($k0)
	
	jal mov_colide
			
	la $t1,mov_ant
	add $t1,$t1,$t3
	sw $t2,0($t1)
	jal limpa
	
	la $a0,cor
	lw $a0,0($a0)
	add $a1,$a1,$a3
	
	jal ponto_verif
	
	sw $a1,0($t0)
	jal pintapac
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	lw $t4,meiaberta
	jr $ra	
sai_mexe_pac:
	addi $t1,$zero,1
	sw $t1,0($t0)
	j prox_pac
	
################################################################################################################################################################################################################################################################################################################################
# As funcoes cima, baixo, esquerda e direita preparam os valores para chamar a funcao mexe_pac
# para a direcao especifica, os enderecos atpac e cor devem conter os valores correspondentes ao pac que se deseja mover
		
#Pac pra cima -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cima:
	addi $s6,$zero,-320
	addi $s7,$zero,-309
	addi $a3,$zero,-1920
	
	jal mexe_pac
	
	bnez $t4,cima2
	
	lw $a1,0($t0)
	addi $s0,$zero,0
	addi $a2,$zero,0
	
	jal boca2
	
	j prox_pac
cima2:
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,sai_mexe_pac
	
	addi $s0,$zero,1
	addi $a2,$zero,0
	
	jal boca2
	j muda_boca

#Pac pra baixo -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
baixo:
	addi $s6,$zero,3840
	addi $s7,$zero,3851
	addi $a3,$zero,1920
	
	jal mexe_pac

	bnez $t4,baixo2
	
	lw $a1,0($t0)
	addi $s0,$zero,0
	addi $a2,$zero,640
	
	jal boca2
	
	j prox_pac
baixo2:
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,sai_mexe_pac
	
	addi $s0,$zero,1
	addi $a2,$zero,640
	
	jal boca2
	
	j muda_boca

#Pac pra esquerda -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
esquerda:
	addi $s6,$zero,-1
	addi $s7,$zero,3519
	addi $a3,$zero,-6
	
	jal mexe_pac
	
	bnez $t4,esquerda2
	
	lw $a1,0($t0)
	addi $s0,$zero,0
	addi $a2,$zero,-2		
	
	jal boca
	
	j prox_pac
esquerda2:
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,sai_mexe_pac
	
	addi $s0,$zero,1
	addi $a2,$zero,-2
	
	jal boca
	j muda_boca

#Pac pra direita -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
direita:
	addi $s6,$zero,12
	addi $s7,$zero,3532
	addi $a3,$zero,6
	
	jal mexe_pac
	
	bnez $t4,direita2
	
	lw $a1,0($t0)
	addi $s0,$zero,0
	addi $a2,$zero,0
		
	jal boca
	
	j prox_pac
direita2:
	
	lw $a1,0($t0)
	la $t0,aberta
	lw $t3,atpac
	add $t0,$t0,$t3
	lw $t1,0($t0)
	beq $t1,$zero,sai_mexe_pac
	
	addi $s0,$zero,1
	addi $a2,$zero,0
		
	jal boca
	j muda_boca	
################################################################################################################################################################################################################################################################################################################################
# Ve a direcao que o pac vai andar  ------------------------------------------------------------------------------------------------------------------------------------------------------------	
ve_direcao_pac:
	beq $t2,1,cima
	beq $t2,2,baixo
	beq $t2,3,direita
	beq $t2,4,esquerda
	
	jr $ra

# Mata pac ------------------------------------------------------------------------------------------------------------------------------------------------------------	
mata_p1:
	la $t3,morto
	addi $t5,$zero,0
	sw $t5,0($t3)
	
	addi $t3,$a1,965
	jr $ra
	
mata_p2:
	la $t3,morto
	addi $t5,$zero,4
	sw $t5,4($t3)
	
	addi $t3,$a1,965
	jr $ra	

mata_p3:
	la $t3,morto
	addi $t5,$zero,8
	sw $t5,8($t3)
	
	addi $t3,$a1,965
	jr $ra
	
mata_p4:
	la $t3,morto
	addi $t5,$zero,12
	sw $t5,12($t3)
	
	addi $t3,$a1,965
	jr $ra	
#$a1 = endereco, $a0 = cor
#Pinta fantasma ------------------------------------------------------------------------------------------------------------------------------------------------------------	
pintag:
	addi $t6,$zero,10
	addi $t3,$a1,321
	addi $t5,$zero,6
	addi $s4,$zero,0
pinta_gloop:
	addi $t6,$t6,-1
	addi $t7,$t3,10
	srl $t8,$t5,1
	add $t3,$t3,$t8
	sub $t7,$t7,$t8
pinta_gloop2:    
	beq $t3,$t7,saipinta_gloop
	lb $a2,0($t3)
	or $s4,$a2,$s4
	sb $a0,0($t3)
	addi $t3,$t3,1
	j pinta_gloop2
saipinta_gloop:
	addi $t3,$t3,310
	add $t3,$t3,$t8
	beqz $t5,j_pinta_gloop
	addi $t5,$t5,-1
j_pinta_gloop:
	bne $t6,$zero,pinta_gloop
	
	sw $ra,-4($sp)
	addi $a2,$zero,0x08
	jal colide
	lw $ra,-4($sp)
	
	addi $t3,$a1,965
	addi $t4,$zero,0xFE
	sb $t4,-1($t3)
	sb $t4,-321($t3)
	sb $t4,-320($t3)
	sb $t4,320($t3)
	sb $t4,319($t3)
	
	sb $t4,2($t3)
	sb $t4,-318($t3)
	sb $t4,-317($t3)
	sb $t4,323($t3)
	sb $t4,322($t3)
	sb $t4,0($t3)
	sb $t4,3($t3)
	
	sb $0,2238($t3)
	sb $0,2239($t3)
	sb $0,2242($t3)
	sb $0,2243($t3)	
	
	beq $s4,0x77,mata_p1
	beq $s4,0x07,mata_p2
	beq $s4,0x70,mata_p3
	beq $s4,0x1C,mata_p4
	
	jr $ra

# Movimento do fantasma ------------------------------------------------------------------------------------------------------------------
# $t0 = endereco onde fica a posicao do fantasma
# $t2 = endereco onde fica o ultimo movimento do fantasma
# $a0 = posicao do pac a perseguir
# $a3 = cor do fantasma
# $v0 = endereco que indica se tinha comida onde o fantasma esta
# $s3 = -1 se o fantasma que ele persegue esta vivo o numero do fantasma caso contrario
busca_fantasma:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t0,g_position
	add $t0,$t0,$t3
	la $t2,mov_antg
	add $t2,$t2,$t3
	la $a0, pac_position
	add $a0,$a0,$t3
	lw $a0,0($a0)
	la $v0,comida
	add $v0,$v0,$t3
	la $s3,morto
	add $s3,$s3,$t3
	lw $s3,0($s3)
	
	# $s0 = quantidade de direcoes tentadas
	addi $s0,$zero,0

	addi $t3, $a0, 0
	subi $t3, $t3, 0xff000000
	addi $t6, $0, 320
	div $t4, $t3, $t6
	mult $t4, $t6
	mflo $t6
	sub $t3, $t3, $t6
	# $t3 = x, $t4 = y do pacman
	
	lw $t8, 0($t0)
	subi $t8, $t8, 0xff000000
	addi $t6, $0, 320
	div $t5, $t8, $t6
	mult $t5, $t6
	mflo $t6
	sub $t7, $t8, $t6
	# $t7 = x, $t5 = y do fantasma
	
	# $t8 = x_ghost - x_pac
	# $t9 = y_ghost - y_pac
	sub $t8, $t7, $t3
	sub $t9, $t5, $t4
	abs $t6, $t8
	abs $t7 ,$t9
	

	lw $a1, 0($t0)
	
	# Verifica se o fantasma a ser perseguido ja esta morto
	beq $s3,-1,nao_ta_morto
	
	# Se o fantasma estiver morto realiza o movimento que o jogador realizaria
	la $t1,mov
	add $t1,$s3,$t1
	lw $s3,0($t1)
	
	beq $s3,1,cimag
	beq $s3,2,baixog
	beq $s3,3,direitag
	beq $s3,4,esquerdag
	
nao_ta_morto:
	
	# if abs($t8) > abs($t9) movimento horizontal
	ble $t6, $t7, vertical_mov
	horizontal_mov:	
		# $t8 > 0 significa que o fantasma esta a direita do pac
		bgtz $t8, esquerdag
		j direitag
	# else movimento vertical
	vertical_mov:
		# $t9 > 0 significa que o fantasma esta a baixo do pac
		bgtz $t9, cimag
		j baixog
	
direitag:
	addi $t8,$zero,1
	addi $s0,$s0,1
	beq $s0,10,saig
	# Evita fazer o movimento contrario ao anterior 
	lw $t3, 0($t2)
	beq $t3, 1, vertical_mov
	# Caso ja tenham sido tentadas as 4 direcoes permite o movimento contrario
	srl $s1,$s0,2
	sll $s1,$s1,3
	sub $t3,$t3,$s1
	sw $t3,0($t2)
	
	addi $a2,$a1,12
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,vertical_mov
	beq $v1,0x08,vertical_mov
	addi $a2,$a1,3532
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,vertical_mov
	beq $v1,0x08,vertical_mov
	
	addi $a2,$a1,24
	jal ve_se_bate
	beq $v1,0x08,vertical_mov
	addi $a2,$a1,7064
	jal ve_se_bate
	beq $v1,0x08,vertical_mov
	
	jal limpa	
	
	# Verifica se o fantasma esta em cima de uma comida e a pinta se for necessario
	lw $t1,0($v0)
	beq $t1,0xFFFFFFFF,direitag2
	beq $t1,0x5F,direitag2
	j direitagg2
direitag2:
	sb $t1,1605($a1)
	sb $t1,1925($a1)
	sw $zero,0($v0)
	# Verifica se o fantasma vai pra cima de uma comida
direitagg2:
	lb $t1,1932($a1)
	sw $t1,0($v0)

	addi $a1,$a1,6
	sw $a1,0($t0)
	add $a0,$zero,$a3
	addi $t3,$zero,4
	sw $t3,0($t2)
	jal pintag
	
	sb $zero,0($t3)
	sb $zero,3($t3)
	
	j saig
	
cimag:	
	addi $t9,$zero,0
	addi $s0,$s0,1
	beq $s0,10,saig
	# Evita fazer o movimento contrario ao anterior
	lw $t3, 0($t2)
	beq $t3, 2, horizontal_mov
	# Caso ja tenham sido tentadas as 4 direcoes permite o movimento contrario
	srl $s1,$s0,2
	sll $s1,$s1,3
	sub $t3,$t3,$s1
	sw $t3,0($t2)
	
	addi $a2,$a1,-320
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,horizontal_mov
	beq $v1,0x08,horizontal_mov
	addi $a2,$a1,-309
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,horizontal_mov
	beq $v1,0x08,horizontal_mov
	
	addi $a2,$a1,-640
	jal ve_se_bate
	beq $v1,0x08,horizontal_mov
	addi $a2,$a1,-618
	jal ve_se_bate
	beq $v1,0x08,horizontal_mov	
				
	jal limpa	
	
	# Verifica se o fantasma esta em cima de uma comida e a pinta se for necessario
	lw $t1,0($v0)
	beq $t1,0xFFFFFFFF,cimag2
	beq $t1,0x5F,cimag2
	j cimagg2
cimag2:
	sb $t1,1926($a1)
	sb $t1,1925($a1)
	sw $zero,0($v0)
	# Verifica se o fantasma vai pra cima de uma comida
cimagg2:
	lb $t1,-314($a1)
	sw $t1,0($v0)
	
	addi $a1,$a1,-1920
	sw $a1,0($t0)
	add $a0,$zero,$a3
	addi $t3,$zero,3
	sw $t3,0($t2)
	jal pintag
	
	sb $zero,-321($t3)
	sb $zero,-318($t3)
	
	j saig
	
baixog:	
	addi $t9,$zero,1
	addi $s0,$s0,1
	beq $s0,10,saig
	# Evita fazer o movimento contrario ao anterior
	lw $t3, 0($t2)
	beq $t3, 3, horizontal_mov
	# Caso ja tenham sido tentadas as 4 direcoes permite o movimento contrario
	srl $s1,$s0,2
	sll $s1,$s1,3
	sub $t3,$t3,$s1
	sw $t3,0($t2)
	
	addi $a2,$a1,3840
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,horizontal_mov
	beq $v1,0x08,horizontal_mov
	addi $a2,$a1,3851
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,horizontal_mov
	beq $v1,0x08,horizontal_mov
	
	addi $a2,$a1,7680
	jal ve_se_bate
	beq $v1,0x08,horizontal_mov
	addi $a2,$a1,7702
	jal ve_se_bate
	beq $v1,0x08,horizontal_mov
	
	jal limpa	

	# Verifica se o fantasma esta em cima de uma comida e a pinta se for necessario
	lw $t1,0($v0)
	beq $t1,0xFFFFFFFF,baixog2
	beq $t1,0x5F,baixog2
	j baixogg2
baixog2:
	sb $t1,1606($a1)
	sb $t1,1605($a1)
	sw $zero,0($v0)
	# Verifica se o fantasma vai pra cima de uma comida
baixogg2:
	lb $t1,3846($a1)
	sw $t1,0($v0)
	
	addi $a1,$a1,1920
	sw $a1,0($t0)
	add $a0,$zero,$a3
	addi $t3,$zero,2
	sw $t3,0($t2)
	jal pintag
	
	sb $zero,320($t3)
	sb $zero,323($t3)
	j saig
	
esquerdag:
	addi $t8,$zero,0
	addi $s0,$s0,1
	beq $s0,10,saig
	# Evita fazer o movimento contrario ao anterior
	lw $t3, 0($t2)
	beq $t3, 4, vertical_mov
	# Caso ja tenham sido tentadas as 4 direcoes permite o movimento contrario
	srl $s1,$s0,2
	sll $s1,$s1,3
	sub $t3,$t3,$s1
	sw $t3,0($t2)
	
	addi $a2,$a1,-1
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,vertical_mov
	beq $v1,0x08,vertical_mov
	addi $a2,$a1,3519
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,vertical_mov
	beq $v1,0x08,vertical_mov
	
	addi $a2,$a1,-2
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,vertical_mov
	beq $v1,0x08,vertical_mov
	addi $a2,$a1,7038
	jal ve_se_bate
	beq $v1,0xFFFFFFC0,vertical_mov
	beq $v1,0x08,vertical_mov
	
	jal limpa
	# Verifica se o fantasma esta em cima de uma comida e a pinta se for necessario
	lw $t1,0($v0)
	beq $t1,0xFFFFFFFF,esquerdag2
	beq $t1,0x5F,esquerdag2
	j esquerdagg2
esquerdag2:
	sb $t1,1606($a1)
	sb $t1,1926($a1)
	sw $zero,0($v0)
	# Verifica se o fantasma vai pra cima de uma comida
esquerdagg2:
	lb $t1,1599($a1)
	sw $t1,0($v0)

	addi $a1,$a1,-6
	sw $a1,0($t0)
	add $a0,$zero,$a3
	addi $t3,$zero,1
	sw $t3,0($t2)
	jal pintag
	
	sb $a3,0($t3)
	sb $a3,3($t3)
	sb $a3,-320($t3)
	sb $a3,-317($t3)
	sb $a3,320($t3)
	sb $a3,323($t3)
	sb $t4,-2($t3)
	sb $t4,1($t3)
	sb $t4,-322($t3)
	sb $t4,-319($t3)
	sb $t4,318($t3)
	sb $t4,321($t3)
	sb $zero,-2($t3)
	sb $zero,1($t3)
	
	j saig
		
saig:
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

#Armazena tecla lida ------------------------------------------------------------------------------------------------------------------
teclap1: 
	la $t3,mov
	sw $t0,0($t3)
	j sai_tecla
	
teclap2:
	la $t3,mov
	sw $t0,4($t3)
	j sai_tecla
teclap3:
	la $t3,mov
	sw $t0,8($t3)
	j sai_tecla
teclap4:
	la $t3,mov
	sw $t0,12($t3)
	j sai_tecla

tecla:	
	
	addi $t0,$zero,1
	beq $t2,0x77,teclap1	# cima - w
	beq $t2,0x69,teclap2	# cima - i
	beq $t2,0x38,teclap3	# cima - 8
	beq $t2,0x66,teclap4	# cima - f
	
	addi $t0,$zero,2
	beq $t2,0x73,teclap1	# baixo - s
	beq $t2,0x6B,teclap2	# baixo - k
	beq $t2,0x35,teclap3	# baixo - 5
	beq $t2,0x76,teclap4	# baixo - v
	
	addi $t0,$zero,3
	beq $t2,0x64,teclap1	# direita - d
	beq $t2,0x6C,teclap2	# direita - l
	beq $t2,0x36,teclap3	# direita - 6
	beq $t2,0x62,teclap4	# direita - b
	
	addi $t0,$zero,4
	beq $t2,0x61,teclap1	# esquerda - a
	beq $t2,0x6A,teclap2	# esquerda - j
	beq $t2,0x34,teclap3	# esquerda - 4
	beq $t2,0x63,teclap4	# esquerda - c
	
sai_tecla: 
	jr $ra
	
#Loop de jogo --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
loop_jogo:
	la $t0,espelho
	sw $zero,0($t0)
	
	# Pinta o fantasma vermelho dentro da prisao
	addi $a1,$0,4278226708 
	la $t1,g_position
	sw $a1,0($t1)
	addi $a0,$zero,0x17
	jal pintag
	
	# Pinta o fantasma roxo dentro da prisao
	addi $a1,$0,4278226720 
	la $t1,g_position
	sw $a1,4($t1)
	addi $a0,$zero,0x8a
	jal pintag	
	
	# Pinta o fantasma rosa dentro da prisao
	addi $a1,$0,4278230560 
	la $t1,g_position
	sw $a1,8($t1)
	addi $a0,$zero,0x8f
	jal pintag
	
	# Pinta o fantasma azul dentro da prisao
	addi $a1,$0,4278230548 
	la $t1,g_position
	sw $a1,12($t1)
	addi $a0,$zero,0x99
	jal pintag
	
	# Pinta o pac amarelo em sua posicao inicial, $a1 = endereco, $a0 = cor
	addi $a1,$0,4278192004
	la $t1,pac_position
	sw $a1,0($t1)
	addi $a0,$zero,0x77
	jal pintapac
		
	# Inicia o jogo caso exista somente um jogador
	lw $t0,players
	blt $t0,2,loop
	
	# Pinta o pac vermelho em sua posicao inicial, $a1 = endereco, $a0 = cor
	addi $a1,$0,4278192304
	la $t1,pac_position
	sw $a1,4($t1)
	addi $a0,$zero,0x07
	jal pintapac
	
	lw $t0,players
	blt $t0,3,loop
	
	# Pinta o pac verde em sua posicao inicial, $a1 = endereco, $a0 = cor
	addi $a1,$0,4278261124
	la $t1,pac_position
	sw $a1,8($t1)
	addi $a0,$zero,0x70
	jal pintapac
	
	lw $t0,players
	blt $t0,4,loop
	
	# Pinta o pac marrom em sua posicao inicial, $a1 = endereco, $a0 = cor
	addi $a1,$0,4278261424
	la $t1,pac_position
	sw $a1,12($t1)
	addi $a0,$zero,0x1C
	jal pintapac
	
loop:	
	
	lw $a0,pontos
	addi $a3,$0,0x0077
	addi $a1,$0,20
	addi $a2,$0,85
	addi $v0,$0,101
	syscall 
	
	la $a0,pontos
	lw $a0,4($a0)
	addi $a3,$0,0x0007
	addi $a1,$0,290
	addi $a2,$0,85
	addi $v0,$0,101
	syscall 
	
	la $a0,pontos
	lw $a0,8($a0)
	addi $a3,$0,0x0070
	addi $a1,$0,20
	addi $a2,$0,150
	addi $v0,$0,101
	syscall 
	
	la $a0,pontos
	lw $a0,12($a0)
	addi $a3,$0,0x001C
	addi $a1,$0,290
	addi $a2,$0,150
	addi $v0,$0,101
	syscall 
	
	
	jal game_over
	
	# Verifica se o fantasma vermelho esta preso, subtrai em 1 o tempo caso esteja, valor em preso > 0
	# e o movimenta caso contrario.
	lw $t1,preso
	bgtz $t1,solta1
	
	#movimento fantasma vermelho
	addi $a3, $zero, 0x17
	addi $t3,$zero,0
	jal busca_fantasma
	
	#movimento fantasma roxo
	addi $a3, $zero, 0x8a
	addi $t3,$zero,4
	jal busca_fantasma
	
	#movimento fantasma rosa
	addi $a3, $zero, 0x8f
	addi $t3,$zero,8
	jal busca_fantasma
	
	#movimento fantasma azul
	addi $a3, $zero, 0x99
	addi $t3,$zero,12
	jal busca_fantasma

	j fica_preso1
solta1:	
	addi $t1,$t1,-1
	sw $t1,preso
	bnez $t1,fica_preso1
	
	# movimento fantasma vermelho
	la $t0,g_position
	lw $a1,0($t0)
	jal limpa
	addi $a1,$0,4278219028
	sw $a1,0($t0)
	addi $a3, $zero, 0x17
	addi $t3,$zero,0
	jal busca_fantasma
	
	# movimento fantasma roxo
	la $t0,g_position
	lw $a1,4($t0)
	jal limpa
	addi $a1,$0,4278219034
	sw $a1,4($t0)
	addi $a3, $zero, 0x8a
	addi $t3,$zero,4
	jal busca_fantasma
	
	# movimento fantasma rosa
	la $t0,g_position
	lw $a1,8($t0)
	jal limpa
	addi $a1,$0,4278242062
	sw $a1,8($t0)
	addi $a3, $zero, 0x8f
	addi $t3,$zero,8
	jal busca_fantasma
	
	# movimento fantasma azul
	la $t0,g_position
	lw $a1,12($t0)
	jal limpa
	addi $a1,$0,4278242074
	sw $a1,12($t0)
	addi $a3, $zero, 0x99
	addi $t3,$zero,12
	jal busca_fantasma
	
fica_preso1:
	
	# Altera o valor de meiaberta
	la $t0,meiaberta
	lw $t1,0($t0)
	xori $t1,$t1,1
	sw $t1,0($t0)

	# Le a tecla do buffer e atualiza o movimento que sera feito pelos pacs
	lw $t7,velocidade
ler:	beqz $t7,para_de_ler
		la $t1,0xFF100004
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		lb $t2,0($t1)       # Tecla lida
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		jal tecla
		add $a0,$0,$t7
		addi $v0,$zero,32
		syscall
		addi $t7,$t7,-1
para_de_ler:
	
	lw $t0,players
	la $t1,pac_position
	addi $a1,$0,76800
	addi $v0,$zero,42
	syscall
	bgt $t0,1,rand_p3
	addi $a0,$a0,0xff000000
	sw $a0,4($t1)
rand_p3: 
	bgt $t0,2,rand_p4
	syscall
	addi $a0,$a0,0xff000000
	sw $a0,8($t1)
rand_p4: 
	bgt $t0,3,dir
	syscall
	addi $a0,$a0,0xff000000
	sw $a0,12($t1)		
	
	
	# Prepara os valores para movimentar o pac amarelo
	# $t2 = endereco da tecla que indica a direcao
	# atualiza atpac para 0
dir:
	lw $t2,morto
	bne $t2,-1,ta_morto1
	
	la $t2,atpac
	addi $t1,$zero,0
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x77
	la $t6,bixao
	lw $t7,0($t6)
	beq $t7,$0,dirr
	add $t1,$zero,0xF5
	addi $t7,$t7,-1
	sw $t7,0($t6)
dirr:
	sw $t1,0($t2)
	la $t2,mov
	
	# Verifica a direcao indicada por $t2 e realiza o movimento para o pacman amarelo
movimenta:	
	lw $t2,0($t2)
	jal ve_direcao_pac
	
ta_morto1:
	lw $t1,players
	blt $t1,2,loop
	
dir2:	
	la $t2,morto
	lw $t2,4($t2)
	bne $t2,-1,ta_morto2
	
	la $t2,atpac
	addi $t1,$zero,4
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x07
	la $t6,bixao
	lw $t7,4($t6)
	beqz $t7,dirr2
	add  $t1,$zero,0xF5
	addi $t7,$t7,-1
	sw $t7,4($t6)
dirr2:
	sw $t1,0($t2)
	la $t2,mov
movimenta2:	
	lw $t2,4($t2)
	jal ve_direcao_pac
	
ta_morto2:	
	lw $t0,players
	blt $t0,3,loop
	
dir3:	
	la $t2,morto
	lw $t2,8($t2)
	bne $t2,-1,ta_morto3
	
	la $t2,atpac
	addi $t1,$zero,8
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x70
	la $t6,bixao
	lw $t7,8($t6)
	beqz $t7,dirr3
	add  $t1,$t1,2
	add  $t1,$zero,0xF5
	addi $t7,$t7,-1
	sw $t7,8($t6)
dirr3:
	sw $t1,0($t2)
	la $t2,mov
movimenta3:	
	lw $t2,8($t2)
	jal ve_direcao_pac
	
ta_morto3:	
	lw $t0,players
	blt $t0,4,loop
	
dir4:	
	la $t2,morto
	lw $t2,12($t2)
	bne $t2,-1,loop
		
	la $t2,atpac
	addi $t1,$zero,12
	sw $t1,0($t2)
	la $t2,cor
	addi $t1,$zero,0x1C
	la $t6,bixao
	lw $t7,12($t6)
	beqz $t7,dirr4
	addi $t7,$t7,-1
	sw $t7,12($t6)
	add  $t1,$zero,0xF5
dirr4:
	sw $t1,0($t2)
	la $t2,mov
movimenta4:	
	lw $t2,12($t2)
	jal ve_direcao_pac
	
	j loop

END:
