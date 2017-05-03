.data

BR: .asciiz "brasil.bin"
USA: .asciiz "usa.bin"
JP: .asciiz "japao.bin"
BT: .asciiz "butao.bin"

.text

	jal BRASIL

	j END

BUTAO:
	la $a0,BT
	li $a1,0
	li $a2,0
	li $v0,13
	syscall
	
	# Transfer all the file to the VGA memory
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall

	# Closes the file
	li $v0,16
	syscall
	j ENDFILE

	ENDFILE:
	li $v0,10
	syscall
	
	jr $ra
JAPAO:
	la $a0,JP
	li $a1,0
	li $a2,0
	li $v0,13
	syscall
	
	# Transfer all the file to the VGA memory
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall

	# Closes the file
	li $v0,16
	syscall
	li $v0,10
	syscall
	
	jr $ra
EUA:
	la $a0,USA
	li $a1,0
	li $a2,0
	li $v0,13
	syscall
	
	# Transfer all the file to the VGA memory
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall

	# Closes the file
	li $v0,16
	syscall
	li $v0,10
	syscall
	
	jr $ra
BRASIL:
	la $a0,BR
	li $a1,0
	li $a2,0
	li $v0,13
	syscall
	
	# Transfer all the file to the VGA memory
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall

	# Closes the file
	li $v0,16
	syscall
	li $v0,10
	syscall
	
	jr $ra
	
	
END:
