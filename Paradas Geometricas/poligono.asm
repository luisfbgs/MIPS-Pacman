.data
 baseadd: .word 0xff000000
 #coordinates: .word 3, 10 , 230, 50, 9 ,35,236
 #coordinates: .word 2, 10 , 230, 50, 9 
 coordinates: .word 4, 10 , 230, 10 , 9 , 260, 9 , 260 ,230
 
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
	sb $a2,0($t1)
	
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
endponto:

funcao_reta:
	#a0 = Endereco das coordenadas
	#a1 = cor
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

 addi $sp,$sp,-32 #salva reg usados na pilha externa
 sw $t0,0($sp)
 sw $t1,4($sp)
 sw $t2,8($sp)
 sw $t3,12($sp)
 sw $t4,16($sp)
 sw $t5,20($sp)
 sw $t6,24($sp)
 sw $t7,28($sp)
 
 la $t3,coordinates
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
 
 for: beq $t4,$t5,endfor
  li $a1,122
  move $a0,$t3
 
  sw $t3,0($sp)
  sw $t4,4($sp)
  sw $t5,8($sp) #salva na pilha interna
 
  jal funcao_reta
 
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
 
main:
 jal poligono
