.data
 baseadd: .word 0xff000000
 #coordinates: .word 3, 10 , 230, 50, 9 ,35,236
 #coordinates: .word 2, 10 , 230, 50, 9 
 coordinates: .word 4, 10 , 23, 10 , 9 , 260, 9 , 260 ,230
 cor: 0x00
 square: .word 160,140, 50
 coo:	.word 0,0,319,239
 cords: .word 5, 20, 20, 1,200, 120, 200, 120, 20 , 80,140
 nconv:  .word 5, 20, -0, 1,200, 120, 200, 120, 20 , 80,140
 elips: .word 138,10,300,70,100,30
 elips2: .word 204,15,280,80,115
.text
j main

coordsverify:
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
	
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $ra, 8($sp)
	jal coordsverify
	bnez $v0,erroponto
	#Uso do t0(variaveis) e t1(endere?o)
	move $t0,$a1
	mul $t0,$t0,320 # y *= 320
	lw $t1,baseadd #retorno recebe end base
	add $t1,$t1,$t0
	move $t0,$a0 #reg reusado
	add $t1,$t1,$t0
	sb $a2,0($t1)
	
erroponto:
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
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
	
	addi $sp, $sp, -4
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
	addi $sp, $sp, 4
	jr $ra
endreta:

funcao_poligono:
	# a0 = endereco com quantidade de pontos na primeira posicao e coordenadas no resto
	# a2 = cor
	# guarda na pilha registradores preservados que serao usados
	addi $sp, $sp,-20 
	sw $s1,0($sp)
	sw $s2,4($sp)
	sw $s3,8($sp)
	sw $s4,12($sp)
	sw $ra,16($sp)
	
	move $s1,$a0
	li $v0,0
	move $t0,$a0
	lw $t1,0($t0)
	addi $t0,$t0,4
	
verifypol:
	beqz $t1,saiverifypol
		addi $t1,$t1,-1
		lw $a0,0($t0)
		lw $a1,4($t0)
		addi $t0,$t0,8
		jal coordsverify
	beqz $v0,verifypol
	j erropol	
saiverifypol:	

	lw $t0,0($s1) # $t0 = quantidade de pontos
	addi $t0,$t0,-1
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
 	# fecha o poligono conectando o ultimo ponto com o primeiro
	la $a0,coordinates
	lw $t1,0($s1)
	lw $t2,4($s1)
	sw $t1,0($a0) 
	sw $t2,4($a0)
	sw $s2,8($a0)
	sw $s3,12($a0)
	jal funcao_reta
erropol:
	# recupera registradores preservados
	lw $s1,0($sp) 
	lw $s2,4($sp)
	lw $s3,8($sp)
	lw $s4,12($sp)
	lw $ra,16($sp)
	addi $sp, $sp, 20
	jr $ra
	
 preenche:
 	# $a0 = x, $a1 = y, $a2 = cor
 	addi $sp,$sp,-8
	sw $ra,4($sp)
	
	jal coordsverify
	bnez $v0,erropreenche
	
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
	# $t2 inicio da fila,$t1 fim da fila
	# $t5, $t6, $t7 e $s1 limites do bitmap
	li $t5,0xff000000
	li $t6,0xff012C00
	li $t7,320
	li $s1,319
bfs:	
	beq $t1,$t2,endpreenche 
		lw $t0,0($t2)
		addi $t2,$t2,-4
		blt $t0,$t5,bfs
		bgt $t0,$t6,bfs
		lb $t3,0($t0)
		bne $t3,$t4,bfs
		sb $a2,0($t0)
			# atualiza o ponteiro da fila
			divu $t0,$t7
			# coloca na fila os enderecos adjacentes a $t0
			addi $t0,$t0,1
			mfhi $t3
			beq $t3,$s1,left
			sw $t0,0($t1)
			addi $t1,$t1,-4
left:			addi $t0,$t0,-2
			beq $t3,$zero,down
			sw $t0,0($t1)
			addi $t1,$t1,-4
down:			addi $t0,$t0,321
			addi $t1,$t1,-8
			sw $t0,4($t1)
			addi $t0,$t0,-640
			sw $t0,8($t1)

		j bfs
erropreenche:
endpreenche:
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra
 
quadrado:
	# a0 = x1, a1 = y1, a2 = lado, a3= cor 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	move $s3,$a3
	
	li $v0,0
	
	div $t0,$s2,2
	sub $s4,$s0,$t0
	sub $s5,$s1,$t0
	
	move $a0,$s4
	move $a1,$s5
	jal coordsverify
	bnez $v0,erroquad
	
	add $t0,$s4,$s2 	# t0 = tamanho do lado no eixo x
	add $t1,$s5,$s2		# t1 = tamanho do lado no eixo y
	
	move $a0,$t0
	move $a1,$t1
	jal coordsverify
	bnez $v0,erroquad
	
	addi $sp,$sp,-16
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	
	la $t2,cords		# salvando na memoria cada coordenada dos vertices do quadrado
	li $t3,4
	sw $t3,0($t2)		# quanidade de pontos
	sw $s4,4($t2)		# x1
	sw $s5,8($t2)		# y1
	sw $t0,12($t2)		# x2
	sw $s5,16($t2)		# y2
	sw $s4,28($t2)		# x4
	sw $t1,32($t2)		# y4
	sw $t0,20($t2)		# x3
	sw $t1,24($t2)		# y3
	move $a2,$s3		# cor
	move $a0,$t2
	jal funcao_poligono
	
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	addi $sp,$sp,16

erroquad:
	lw $ra,0($sp)
	addi $sp,$sp,4
	li $v0,0
	jr $ra
circulo:
	# a0 = centro x, a1 = centro y, a2 = cor , a3 = raio
	# guarda na pilha registradores preservados que serao utilizados
	subi $sp,$sp,28
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $s4,20($sp)
	sw $s5,24($sp)
	
	move $s0,$a0
	move $s1,$a1
	
	li $v0,0
	add $a0,$s0,$a3
	add $a1,$s1,$a3
	jal coordsverify
	bnez $v0,errocirc
	
	sub $a0, $s0,$a3	
	sub $a1, $s1,$a3
	jal coordsverify
	bnez $v0,errocirc
	
	move $a0,$s0
	move $a1,$s1
		
	add $s0,$zero,$zero # y inicial
	add $s1,$zero,$a3 # x inicial
	add $s2,$zero,$zero # erro
	add $s3,$zero,$a1 # y
	add $s4,$zero,$a0 # x
	li $s5,320
	mul $a3,$a3,$a3 # raio = raio ao quadrado
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
		
		mul $t0,$s0,$s0
		mul $t1,$s1,$s1
		add $t1,$t0,$t1
		sub $t2,$t1,$a3 # salva em $t2 o valor y^2 + x^2 - r^2
		
		addi $t1,$s1,-1
		mul $t1,$t1,$t1
		add $t1,$t0,$t1
		sub $t3,$t1,$a3 # salva em $t3 o valor y^2 + (x-1)^2 - r^2
		
		abs $t2,$t2
		abs $t3,$t3
		
		blt $t2,$t3,circloop # caso o valor de $t3 seja mais proximo de 0, x recebe x - 1, caso contratio x matem seu valor
		addi $s1,$s1,-1
		j circloop
errocirc:
endcirculo:
	# recuperar da pilha registradores preservados utilizados
	lw $ra,0($sp)  
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s4,20($sp)
	lw $s5,24($sp)
	addi $sp,$sp,28
	jr $ra
	
elipse2:
	# a0 endereco dos focos e raios, a2 cor
	subi $sp,$sp,4
	sw $ra,0($sp)
	
	lw $t0,0($a0) # f1x
	lw $t1,4($a0) # f1y
	lw $t2,8($a0) # f2x
	lw $t3,12($a0) # f2y
	lw $t4,16($a0) # distancia focal
	
	mtc1 $t4,$f3
	cvt.s.w $f3,$f3
	li $t7,0
	li $t8,-1
	li $t6,1
	mtc1 $t6,$f5
	cvt.s.w $f5,$f5
	li $t6,0
loope:
	bgt $t7,239,sailoope
loope2:
		bgt $t8,319,sailoope2
			addi $t8,$t8,1
			
			sub $a0,$t8,$t0
			sub $a1,$t7,$t1
			mul $a0,$a0,$a0
			mul $a1,$a1,$a1
			add $t5,$a1,$a0
			mtc1 $t5,$f1
			cvt.s.w $f1,$f1
			sqrt.s $f1,$f1
			
			sub $a0,$t8,$t2
			sub $a1,$t7,$t3
			mul $a0,$a0,$a0
			mul $a1,$a1,$a1
			add $t6,$a1,$a0
			mtc1 $t6,$f2
			cvt.s.w $f2,$f2
			sqrt.s $f2,$f2
			
			add.s $f2,$f1,$f2
			sub.s $f4,$f3,$f2
			abs.s $f4,$f4
			c.lt.s $f4,$f5
			bc1f loope2
				move $a0,$t8
				move $a1,$t7
					jal funcao_ponto
		j loope2
sailoope2:
		addi $t7,$t7,1
		li $t8,-1
	j loope
sailoope:
	lw $ra,0($sp)
	addi $sp,$sp,4
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
cMain:
	la $a0,coo
 	li $a2,0x77
 	jal funcao_reta
 	 # teste circulo
 	li $a2,0x70
 	li $a0,240
 	li $a1,140
 	li $a3,50
 	jal circulo
 	
 	# teste quadrado
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
 	jal funcao_poligono
 
 	li $a0,0
 	li $a1,1
 	li $a2,0x06
 	jal preenche
 	
 	li $a0,20
 	li $a1,20
 	li $a2,0x65
 	jal preenche
 	
 	#teste elipse
 	li $a2,0x54
 	la $a0,elips2
 	jal elipse2
 sai:
 	li $v0,10
	syscall
