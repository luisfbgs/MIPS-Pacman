.data
   baseadd: .word 0xff000000
 coordinates: .word 4, 10 , 23, 10 , 9 , 260, 9 , 260 ,230
 cor: 0x00
 reta1: .word 30, 120, 160, 20
 reta2: .word 160, 20, 290, 120
 reta3: .word 290, 120, 160, 220
 reta4: .word 160, 220, 30, 120
 reta5: .word 110,120,210,120
 reta6: .word 160,20,160,220
 reta7: .word 110,59,110,182
 reta8: .word 210,59,210,182
 reta9: .word 30,120,290,120
 butaolines: .word 0, 239, 319, 0
 butaolines2: .word 40, 180, 280, 60
 usalines: .word 0,0,319,0
 usalines2: .word 160,0,160,18
 cords: .word 5, 20, 20, 1,200, 120, 200, 120, 20 , 80,140
.text
j main

	
funcao_ponto:
	# $a0 = x, $a1 = y
	
	#Uso do t0(variaveis) e t1(endere?o)
	
	move $s6,$a1
	#mul $t0,$t0,320 # y *= 320
	addi $at, $zero, 320
	mult $s6, $at
	mflo $s6
	lw $t1,baseadd #retorno recebe end base
	add $t1,$t1,$s6
	move $s6,$a0 #reg reusado
	add $t1,$t1,$s6
	sb $a2,0($t1)
	
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

	addi $s7,$ra,0
	sub $t0,$t8,$t6

	move $t2,$a0
	addi $t1,$0, 2
	move $t3,$t2	
	move $a0,$t2
	
	if_fr_1:
		bgt $t0,$zero,else_fr_1
 		#mul $t0,$t0,-1 #Se s0 negativo troque o sinal
 		addi $at, $0, -1
 		mult $t0, $at
 		mflo $t0
 		addi $t2,$0, -1 #sx = negativo
 		j endif_fr_1
	else_fr_1:
	 	addi $t2,$0, 1 #se s0 pos, dx = 1
	endif_fr_1:
	
	sub $t1,$t9,$t7 # dy = y1 - y0
	if_fr_2:
		bgt $t1,$zero,else_fr_2 
 		#mul $t1,$t1,-1 #Se s1 negativo troque o sinal
 		addi $at, $0, -1
 		mult $t1, $at
 		mflo $t1
 		addi $t3,$0, -1 #dy negativo
 		j endif_fr_2
	else_fr_2: 	
		addi $t3,$0, 1 #se s3 positivo, dy = 1
	endif_fr_2:

	if_fr_3:
		bgt $t0,$t1,else_fr_3 #se dx>dy
		#mul $t4,$t1,-1 #err = (-dy)
		addi $at, $0, -1
		mult $t4, $at
		mflo $t4
		j endif_fr_3
 	else_fr_3: 
 		move $t4,$t0 #err = dx
 	endif_fr_3:

	#div $t4,$t4,2 # err = err/2 
	sra $t4,$t4,2

	while_fr_1:
		#sw $zero,0($zero)
		addi $a0, $t6, 0
		addi $a1, $t7, 0
		addi $s5, $t1, 0
		jal funcao_ponto
		addi $t1, $s5, 0
		
		bne $t6, $t8, neq_fr_1 # if (x0 == x1 && y0 == y1) break;
		bne $t7, $t9, neq_fr_1 # if (x0 == x1 && y0 == y1) break;
		j ew_fr_1
		
		neq_fr_1:
		add $t5, $t4, $zero
		
		if_fr_4:
			#mul $t0, $t0, -1
			addi $at, $0, -1
			mult $t0, $at
			mflo $t0
			ble $t5, $t0, endif_fr_4
			sub $t4, $t4, $t1
			add $t6, $t6, $t2	
		endif_fr_4:
		#mul $t0, $t0, -1
		addi $at, $0, -1
		mult $t0, $at
		mflo $t0
		if_fr_5:
			bge $t5, $t1, endif_fr_5
			add $t4, $t4, $t0
			add $t7, $t7, $t3
		endif_fr_5:
		j while_fr_1
	ew_fr_1:
	addi $ra,$s7,0
	jr $ra
endreta:

preenche:
 	# $a0 = x, $a1 = y, $a2 = cor
 	addi $sp,$sp,-4
	addi $s7,$ra,0
	
	la $t0,baseadd
	lw $t0,0($t0)
	add $t0,$t0,$a0
	#mul $a1,$a1,320
	addi $at, $0, 320
	mult $a1, $at
	mflo $a1
	add $t0,$t0,$a1
	
	move $t1,$sp
	move $t2,$t1
	lb $t4,0($t0)
	beq $t4,$a2,endpreenche
	sb $a2,0($t0)
	sw $t0,0($t1)
	subi $t1,$t1,4
	# $t2 inicio da fila,$t1 fim da fila
	# $t5, $t6, $t7 e $s1 limites do bitmap
	li $t5, 0xff000000
	li $t6, 0xff012C00
	addi $t7,$0, 320
	addi $t9,$0, 319
bfs:	
	beq $t1,$sp,endpreenche 
		addi $t1,$t1,4
		lw $t0,0($t1)
		#blt $t1,0x10010000,er
			# atualiza o ponteiro da fila
			divu $t0,$t7
			# coloca na fila os enderecos adjacentes a $t0
			addi $t0,$t0,1
			mfhi $t3
			beq $t3,$t9,left
			lb $t3,0($t0)
			bne $t3,$t4,left
			sb $a2,0($t0)
			sw $t0,0($t1)
			addi $t1,$t1,-4
left:			mfhi $t3
			addi $t0,$t0,-2
			beq $t3,$zero,down
			lb $t3,0($t0)
			bne $t3,$t4,down
			sb $a2,0($t0)
			sw $t0,0($t1)
			addi $t1,$t1,-4
down:			addi $t0,$t0,321
			bgt $t0,$t6,up
			lb $t3,0($t0)
			bne $t3,$t4,up
			sb $a2,0($t0)
			sw $t0,0($t1)
			addi $t1,$t1,-4
up:			addi $t0,$t0,-640
			bltu $t0,$t5,bfs
			lb $t3,0($t0)
			bne $t3,$t4,bfs
			sb $a2,0($t0)
			sw $t0,0($t1)
			addi $t1,$t1,-4

		j bfs
endpreenche:
	addi $ra,$s7,0
	addi $sp,$sp,4
	jr $ra

circulo:
	# a0 = centro x, a1 = centro y, a2 = cor , a3 = raio
	# guarda na pilha registradores preservados que serao utilizados
	addi $sp,$sp,-24
	addi $s7,$ra,0
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $s4,20($sp)
	sw $s5,0($sp)
	
	move $s0,$a0
	move $s1,$a1
	
	addi $v0,$0, 0
	add $a0,$s0,$a3
	add $a1,$s1,$a3
	
	sub $a0, $s0,$a3	
	sub $a1, $s1,$a3
	
	move $a0,$s0
	move $a1,$s1
		
	add $s0,$zero,$zero # y inicial
	add $s1,$zero,$a3 # x inicial
	add $s2,$zero,$zero # erro
	add $s3,$zero,$a1 # y
	add $s4,$zero,$a0 # x
	addi $s5,$0, 320
	#mul $a3,$a3,$a3 # raio = raio ao quadrado
	mult $a3, $a3
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
		
		#mul $t0,$s0,$s0
		mult $s0, $s0
		mflo $t0
		#mul $t1,$s1,$s1
		mult $s1, $s1
		mflo $t1
		add $t1,$t0,$t1
		sub $t2,$t1,$a3 # salva em $t2 o valor y^2 + x^2 - r^2
		
		addi $t1,$s1,-1
		#mul $t1,$t1,$t1
		mult $t1, $t1
		mflo $t1
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
	addi $ra,$s7,0
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s4,20($sp)
	lw $s5,0($sp)
	addi $sp,$sp,24
	jr $ra
	
	
main:	
 	sw $zero,0($zero)
 	# japao
 		# pinta a tela de verde
 		addi $t0,$0, 0xff000000
 		addi $t1,$0, 0xff012c00
 		addi $a2,$0, 0xffffffff
 		tela:
 		beq $t0,$t1,ee
 		sw $a2,0($t0)
 		addi $t0,$t0,4
 		j tela
 		ee:
 		addi $a2,$0, 0x07
 		addi $a0,$0, 160
 		addi $a1,$0, 120
 		addi $a3,$0, 50
 		jal circulo
 		la $a0,reta5
 		addi $a2,$zero,0x07
 		jal funcao_reta
 		addi $a0,$0, 160
 		addi $a1,$0, 119
 		addi $a2,$0, 0x07
 		jal preenche
 		addi $a0,$0, 160
 		addi $a1,$0, 121
 		addi $a2,$0, 0x07
 		jal preenche
 	
	# Sleep so the image lasts for a second
	#addi $a0, $0, 2000
	#addi $v0, $0, 32
	#syscall
 	#############################
 	
 	sw $zero,0($zero)
 	# brasil
 	brasa:
		# pinta a tela de verde
 		addi $t0,$0, 0xff000000
 		addi $t1,$0, 0xff012c00
 		addi $a2,$0, 0x70707070
 		tela2:
 		beq $t0,$t1,eee
 		sw $a2,0($t0)
 		addi $t0,$t0,4
 		j tela2
 		eee:
		# losango br
		
		

		la $a0, reta7
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta8
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta9
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta1
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta2
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta3
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta4
		addi $a2, $0, 0x3f
		jal funcao_reta
		la $a0, reta6
		addi $a2, $0, 0x3f
		jal funcao_reta
		
	 	#la $a0,losangobrasil
	 	#addi $a2,$0, 0x3f
	 	#jal funcao_poligono
	 	addi $a0,$0, 159
	 	addi $a1,$0, 119
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 159
	 	addi $a1,$0, 121
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 161
	 	addi $a1,$0, 119
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 161
	 	addi $a1,$0, 121
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 40
	 	addi $a1,$0, 123
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 32
	 	addi $a1,$0, 119
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 288
	 	addi $a1,$0, 121
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a0,$0, 280
	 	addi $a1,$0, 117
	 	addi $a2,$0, 0x3f
	 	jal preenche
	 	addi $a2,$0, 0x88
 		addi $a0,$0, 160
 		addi $a1,$0, 120
 		addi $a3,$0, 50
 		jal circulo
 		la $a0,reta5
 		addi $a2,$zero,0x88
 		jal funcao_reta
 		addi $a0,$0, 160
 		addi $a1,$0, 119
 		addi $a2,$0, 0x88
 		jal preenche
 		addi $a0,$0, 160
 		addi $a1,$0, 121
 		addi $a2,$0, 0x88
 		jal preenche
 	
	# Sleep so the image lasts for a second
	#addi $a0, $0, 2000
	#addi $v0, $0, 32
	#syscall
	
 	#############################
 	sw $zero,0($zero)
 	# usa
 	
		# pinta a tela de verde
 		addi $t0,$0, 0xff000000
 		addi $t1,$0, 0xff012c00
 		addi $a2,$0, 0x07070707
 		tela3:
 		beq $t0,$t1,eeee
 		sw $a2,0($t0)
 		addi $t0,$t0,4
 		j tela3
 		eeee:
		# lines br
		addi $s0, $0, 12
		addi $s1, $0, 0
		loop32323:
		beq $s1, $s0, endloopppp
			la $a0, usalines
			lw $t2, 4($a0)
			lw $t3, 12($a0)
			addi $t2, $t2, 18
			addi $t3, $t3, 18
			sw $t2, 4($a0)
			sw $t3, 12($a0)
			la $a2, 0xff
			jal funcao_reta
			
			la $a0, usalines2
			lw $t2, 4($a0)
			lw $t3, 12($a0)
			addi $t2, $t2, 18
			addi $t3, $t3, 18
			sw $t2, 4($a0)
			sw $t3, 12($a0)
			andi $a2,$s1,1
			bnez $a2,puli
			la $a2, 0xff
			jal funcao_reta
		puli:
			
			addi $s1, $s1, 1
			j loop32323
		endloopppp:
		addi $s0, $0, 6
		addi $s1, $0, 0
		addi $s3, $0, 0
		addi $s4, $0, 0
		loop789:
		bge $s1, $s0, loope789
			add $a0, $s3, $0
			addi, $a1, $s4, 19
			addi $a2, $0, 0xff
			jal preenche
			addi $a0, $s3, 161
			addi, $a1, $s4, 19
			addi $a2, $0, 0xff
			jal preenche
			
			addi $s1, $s1, 1
			addi $s4, $s4, 36
			j loop789
		loope789:
		
 		addi $t0,$0, 0xff000000
 		addi $t1,$0, 0xff0000a0
 		addi $t3,$0, 0xff009e20
 		addi $a2,$0, 0x88888888
 		tela5:
 		beq $t1, $t3, eeeee
 			tela4:
 			beq $t0,$t1,eeede
 			sw $a2,0($t0)
 			addi $t0,$t0,4
 			j tela4
 			eeede:
 			addi $t0, $t0, 160
 			addi $t1, $t1, 320
 			j tela5
 		eeeee:
		
 	
 	
	# Sleep so the image lasts for a second
	#addi $a0, $0, 2000
	#addi $v0, $0, 32
	#syscall
	
	#######################################

 	# butao
 	
 	sw $zero,0($zero)
		# pinta a tela de verde
 		addi $t0,$0, 0xff000000
 		addi $t1,$0, 0xff012c00
 		addi $a2,$0, 0x07070707
 		tela6:
 		beq $t0,$t1,deeee
 		sw $a2,0($t0)
 		addi $t0,$t0,4
 		j tela6
 		deeee:	

		la $a0, butaolines
		addi $a2, $0, 0x1f
		jal funcao_reta
		
		addi $a0, $0, 0
		addi $a1, $0, 0
		addi $a2, $0, 0x1f
		jal preenche
		
		la $a0, butaolines2
		addi $a2, $0, 0xff
		jal funcao_reta
