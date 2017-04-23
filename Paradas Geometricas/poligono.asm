.data
 baseadd: .word 0xff000000
 #coordinates: .word 3, 10 , 230, 50, 9 ,35,236
 #coordinates: .word 2, 10 , 230, 50, 9 
 coordinates: .word 4, 10 , 23, 10 , 9 , 260, 9 , 260 ,230
 cor: 0x00
 square: .word 100, 100, 50,
 cords: .word 5, 20, 20, 1,200, 120, 200, 120, 20 , 80,140
 nconv:  .word 5, 20, 20, 1,200, 120, 200, 120, 20 , 80,140
.text
j main

funcao_ponto:
	# $a0 = x, $a1 = y
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	#Uso do t0(variaveis) e t1(endereço)
	move $t0,$a1
	mul $t0,$t0,320 # y *= 320
	lw $t1,baseadd #retorno recebe end base
	add $t1,$t1,$t0
	move $t0,$a0 #reg reusado
	add $t1,$t1,$t0
	sb $a2,0($t1)
	
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
endponto:

funcao_reta:
	#a0 = Endereco das coordenadas
	#a2 = cor
	#t6 = x0 t7=y0 t8=x1 t9=y1
	#t0 = dx, t1 = dy, t2 = sx, t3 = sy, t4=err, t5 = e2
	
	lw $t6, 0($a0)
	lw $t7, 4($a0)
	lw $t8, 8($a0)
	lw $t9, 12($a0)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	sub $t0,$t8,$t6
	
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

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
endreta:

func_poligono:
	# a0 = endereço com quantidade de pontos na primeira posicao e coordenadas no resto
	# a2 = cor
	subi $sp, $sp, 20 # guarda na pilha os registradores preservados que serao usados
	sw $s1,0($sp)
	sw $s2,4($sp)
	sw $s3,8($sp)
	sw $s4,12($sp)
	sw $ra,16($sp)
	
	move $s1,$a0
	lw $t0,0($s1) # $t0 = quantidade de pontos
	subi $t0,$t0,1
	addi $s1,$s1,4
	lw $s2,0($s1)	# guarda o primeiro ponto para fechar o poligono
	lw $s3,4($s1)
polfor:	
	beq $t0,$zero,endpolfor
		la $a0,coordinates # coordenadas pra funcao_ponto
		lw $t1,0($s1)
		lw $t2,4($s1)
		sw $t1,0($a0) 	# armazena em $a0 o ponto do inicio da reta
		sw $t2,4($a0)
		addi $s1,$s1,8
		lw $t1,0($s1)	# le o proximo ponto e armazena em $a0
		lw $t2,4($s1)
		sw $t1,8($a0)
		sw $t2,12($a0)
		
		move $s4,$t0
		jal funcao_reta
		move $t0,$s4
		
		subi $t0,$t0,1
	j polfor
	
endpolfor:
	la $a0,coordinates # fecha o poligono conectando o ultimo ponto com o primeiro
	lw $t1,0($s1)
	lw $t2,4($s1)
	sw $t1,0($a0) 
	sw $t2,4($a0)
	sw $s2,8($a0)
	sw $s3,12($a0)
	jal funcao_reta
	
	lw $s1,0($sp) #recupera os registradores preservados
	lw $s2,4($sp)
	lw $s3,8($sp)
	lw $s4,12($sp)
	lw $ra,16($sp)
	addi $sp, $sp, 20
	jr $ra
	
preenche:
 	#$a0 = x, $a1 = y, $a2 = cor
 	addi $sp,$sp,-4
	la $t0,baseadd
	lw $t0,0($t0)
	add $t0,$t0,$a0
	mul $a1,$a1,320
	add $t0,$t0,$a1
	move $t1,$sp
	move $t2,$t1
	lb $t4,0($t0)
	beq $t4,$a2,endpreenche
	sw $t0,0($t1)
	subi $t1,$t1,4
	#$t2 inicio da fila,$t1 fim da fila
bfs:	
	beq $t1,$t2,endpreenche 
		lw $t0,0($t2)
		subi $t2,$t2,4
		blt $t0,0xff000000,bfs
		bgt $t0,0xff012C00,bfs
		lb $t3,0($t0)
		bne $t3,$t4,bfs
		sb $a2,0($t0)
			#atualiza o ponteiro da fila
			subi $t1,$t1,16
			#coloca na fila os enderecos adjacentes a $t0
			addi $t0,$t0,1
			sw $t0,4($t1)
			subi $t0,$t0,2
			sw $t0,8($t1)
			addi $t0,$t0,321
			sw $t0,12($t1)
			subi $t0,$t0,640
			sw $t0,16($t1)

		j bfs

endpreenche:	
	addi $sp,$sp,4
	jr $ra
 
quadrado:
	# a0 = x1, a1 = y1, a2 = lado, a3= cor 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	move $s3,$a3
	
	add $t0,$s0,$s2 	# t0 = tamanho do lado no eixo x
	add $t1,$s1,$s2		# t1 = tamanho do lado no eixo y
	
	addi $sp,$sp,-16
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	
	la $t2,cords		# salvando na memoria cada coordenada dos vertices do quadrado
	li $t3,4
	sw $t3,0($t2)		# quanidade de pontos
	sw $s0,4($t2)		# x1
	sw $s1,8($t2)		# y1
	sw $t0,12($t2)		# x2
	sw $s1,16($t2)		# y2
	sw $s0,28($t2)		# x4
	sw $t1,32($t2)		# y4
	sw $t0,20($t2)		# x3
	sw $t1,24($t2)		# y3
	move $a2,$s3		# cor
	move $a0,$t2
	jal func_poligono
	
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	addi $sp,$sp,16
	
	div $s2,$s2,2
	add $t3,$s0,$s2 
	add $t4,$s1,$s2
	move $a0,$t3
	move $a1,$t4
	move $a2,$s3
	jal preenche
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	li $v0,0
	jr $ra
	
	
main:	
	# pinta a tela de branco
 	li $t0,0xff000000
 	li $t1,0xff012c00
 	li $a2,0xffffffff
 tela:
 	beq $t0,$t1,cMain
 	sw $a2,0($t0)
 	addi $t0,$t0,4
 	j tela
 	# teste quadrado
 cMain:	
 	la $t0,square
 	la $t1,cor
 	lw $a0,0($t0)
 	lw $a1,4($t0)
	lw $a2,8($t0)
	lw $a3,0($t1)
	jal quadrado
	# teste poligono nao convexo
 	la $a0,nconv
 	li $a2,0x88
 	jal func_poligono
 
 sai:
 	li $v0,10
	syscall
