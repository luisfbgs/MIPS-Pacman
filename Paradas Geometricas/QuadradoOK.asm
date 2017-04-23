.data
 baseadd: .word 0xff000000
 #coordinates: .word 3, 10 , 230, 50, 9 ,35,236
 #coordinates: .word 2, 10 , 230, 50, 9 
 coordinates: .word 4, 10 , 23, 10 , 9 , 260, 9 , 260 ,230
 cor: 0x00
 square: .word 100, 100, 50,
 cords: .word 4, 0, 0, 0, 0, 0, 0, 0, 0 
.text
j main

funcao_ponto:
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
	la $s7,cor
	lw $a2,0($s7)
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

poligono:

#uso de t0,t1,t2 temporarios
# a0 = endereço das coordenadas e da cor utilizada, a cor é jogada no a2 por um lw
# a2 = cor

 addi $sp,$sp,-32 #salva reg usados na pilha externa
 sw $t0,0($sp)
 sw $t1,4($sp)
 sw $t2,8($sp)
 sw $t3,12($sp)
 sw $t4,16($sp)
 sw $t5,20($sp)
 sw $t6,24($sp)
 sw $t7,28($sp)
 
 move $t3,$a0
 lw $t5, 0($t3) #contadorend
 
 move $t0,$t5
 mul $t0,$t0,8
 addi $t0,$t0,4
 lw $t1,4($t3)
 lw $t2,8($t3)
 add $t0,$t0,$t3
 sw $t1,0($t0)
 sw $t2,4($t0)
 
 li $t4,0 #contador
 addi $t3,$t3,4
 
 addi $sp,$sp,-16 #aloca para 4 elementos
 sw $ra,12($sp) #salva ra na pilha
 
 for: 	 beq $t4,$t5,endfor
 	 la $s0,cor
 	 lw $a2,0($s0)
	 move $a0,$t3
 
 	 sw $t3,0($sp)
 	 sw $t4,4($sp)
 	 sw $t5,8($sp)		 #salva na pilha interna
 
 	 addi $sp,$sp,-8
 	 sw $s0,0($sp)
 	 sw $a2,4($sp)		# salva a cor na pilha	
  
 	 jal funcao_reta
  
	 lw $s0,0($sp)  
  	 lw $a2,4($sp)
 	 addi $sp,$sp,8
  
  	 lw $t3,0($sp)
 	 lw $t4,4($sp)
 	 lw $t5,8($sp) #recupera da pilha interna
 	
 	 addi $t3,$t3,8 #próximo par de coordinates
 	 addi $t4,$t4,1 #contador++
 	 j for
 endfor:  
 
 lw $ra,12($sp)
 addi $sp,$sp,16 #desaloca pilha interna
 
 addi $sp,$sp,32 #desaloca pilha externa
 lw $t0,0($sp)
 lw $t1,4($sp)
 lw $t2,8($sp)
 lw $t3,12($sp)
 lw $t4,16($sp)
 lw $t5,20($sp) 
 lw $t6,24($sp)
 lw $t7,28($sp)
 endpoligono: jr $ra
 

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

endpreenche:	addi $sp,$sp,4
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
	sw $s0,4($t2)		# x1
	sw $s1,8($t2)		# y1
	sw $t0,12($t2)		# x2
	sw $s1,16($t2)		# y2
	sw $s0,28($t2)		# x4
	sw $t1,32($t2)		# y4
	sw $t0,20($t2)		# x3
	sw $t1,24($t2)		# y3
	sw $s3,36($t2)		# cor
	move $a0,$t2
	jal poligono
	
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
	#la $a0,coordinates
 	#jal poligono
 	
 	li $t0,0xff000000
 	li $t1,0xff012c00
 	li $a2,0xffffffff
 tela:	beq $t0,$t1,cMain
 	sw $a2,0($t0)
 	addi $t0,$t0,4
 	j tela
 	
 cMain:	la $t0,square
 	la $t1,cor
 	lw $a0,0($t0)
 	lw $a1,4($t0)
	lw $a2,8($t0)
	lw $a3,0($t1)
	jal quadrado
 sai:
 	li $v0,10
	syscall
