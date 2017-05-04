	
	
	# .gnu_attribute 
	# .file indica que o que se segue é o nome de um arquivo 
	.file	1 "sortc.c"
	# .section indica em que sessão o códico será montado
	.section .mdebug.abi32		# .mdebug contem a tabela de simbolos do MIPS
	# .previous permite alternar entre duas seções ELFs(executable and linking format), possibilitando arquivos mais densos
	.previous
	# .nan legacy indica que o montador deve utilizar a representação original de Not a Number
	.nan	legacy
	.module	fp=32
	.module	oddspreg
	# .globl declara que o endereço é global para ser referenciado
	.globl	v
	# .data informa ao montador que o conteudo sao dados para o programa 
	.data
	# .align informa ao montador que a memoria esta ordenada por words (0=byte, 1=half, 2=word, 3=double)
	.align	2
	.type	v, @object
	# .size informa ao montador que v tem tamanho 40, ou seja 10 words, v[10]
	.size	v, 40
v:	
	# .word indica ao montador que o valor é uma word, 32 bits
	.word	5
	.word	8
	.word	3
	.word	4
	.word	7
	.word	6
	.word	8
	.word	0
	.word	1
	.word	9
	# .rdata é similar a função do .data, porém nao pode ser modificada em tempo de execuçao
	.rdata
	.align	2
.LC0:
	# .ascii informa ao montador que o dado é um char ou um conjunto de chars, que está ordenado por bytes
	.ascii	"%d\011\000"
	# .text informa ao montador que a partir desse endereço está o programa a ser montado
	.text
	.align	2
	.globl	show
	.set	nomips16
	.set	nomicromips
	# .ent show informa ao montador o começo da funçao show
	.ent	show
	# .type informa qual é o tipo do elemento, no caso "show" é uma funcao
	.type	show, @function
show:
	# .frame declara o frame pointer $fp
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	# .mask indica quais regs serao salvos na pilha da funcao a partir de uma mascara de bits em que cada bit indica um reg salvo
	.mask	0xc0000000,-4
	# .fmask é semelhante a mask porem utiliza os registradores em ponto flutuante
	.fmask	0x00000000,0
	# .set ativa ou desativa algumas caracteristicas do montador: noreorder impede de serem eliminados instruçoes nops desnecessarios
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$0,16($fp)
	b	.L2
	nop

.L3:
	lw	$2,16($fp)
	sll	$2,$2,2
	lw	$3,32($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lui	$2,%hi(.LC0)
	addiu	$4,$2,%lo(.LC0)
	jal	printf
	nop

	lw	$2,16($fp)
	addiu	$2,$2,1
	sw	$2,16($fp)
.L2:
	lw	$3,16($fp)
	lw	$2,36($fp)
	slt	$2,$3,$2
	bne	$2,$0,.L3
	nop

	li	$4,10			# 0xa
	jal	putchar
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	show
	.size	show, .-show
	.align	2
	.globl	swap
	.set	nomips16
	.set	nomicromips
	.ent	swap
	.type	swap, @function
swap:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$5,20($fp)
	lw	$2,20($fp)
	sll	$2,$2,2
	lw	$3,16($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,0($fp)
	lw	$2,20($fp)
	sll	$2,$2,2
	lw	$3,16($fp)
	addu	$2,$3,$2
	lw	$3,20($fp)
	addiu	$3,$3,1
	sll	$3,$3,2
	lw	$4,16($fp)
	addu	$3,$4,$3
	lw	$3,0($3)
	sw	$3,0($2)
	lw	$2,20($fp)
	addiu	$2,$2,1
	sll	$2,$2,2
	lw	$3,16($fp)
	addu	$2,$3,$2
	lw	$3,0($fp)
	sw	$3,0($2)
	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	swap
	.size	swap, .-swap
	.align	2
	.globl	sort
	.set	nomips16
	.set	nomicromips
	.ent	sort
	.type	sort, @function
sort:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$0,16($fp)
	b	.L6
	nop

.L10:
	lw	$2,16($fp)
	addiu	$2,$2,-1
	sw	$2,20($fp)
	b	.L7
	nop

.L9:
	lw	$5,20($fp)
	lw	$4,32($fp)
	jal	swap
	nop

	lw	$2,20($fp)
	addiu	$2,$2,-1
	sw	$2,20($fp)
.L7:
	lw	$2,20($fp)
	bltz	$2,.L8
	nop

	lw	$2,20($fp)
	sll	$2,$2,2
	lw	$3,32($fp)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,20($fp)
	addiu	$2,$2,1
	sll	$2,$2,2
	lw	$4,32($fp)
	addu	$2,$4,$2
	lw	$2,0($2)
	slt	$2,$2,$3
	bne	$2,$0,.L9
	nop

.L8:
	lw	$2,16($fp)
	addiu	$2,$2,1
	sw	$2,16($fp)
.L6:
	lw	$3,16($fp)
	lw	$2,36($fp)
	slt	$2,$3,$2
	bne	$2,$0,.L10
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	sort
	.size	sort, .-sort
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	li	$5,10			# 0xa
	lui	$2,%hi(v)
	addiu	$4,$2,%lo(v)
	jal	show
	nop

	li	$5,10			# 0xa
	lui	$2,%hi(v)
	addiu	$4,$2,%lo(v)
	jal	sort
	nop

	li	$5,10			# 0xa
	lui	$2,%hi(v)
	addiu	$4,$2,%lo(v)
	jal	show
	nop

	nop
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2016.05-7) 5.3.0"
