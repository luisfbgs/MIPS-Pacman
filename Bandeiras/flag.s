.data

BRASIL: .asciiz "brasil.bin"
USA: .asciiz "usa.bin"
JAPAO: .asciiz "japao.bin"
BUTAO: .asciiz "butao.bin"
LAMAR: .asciiz "lamar.bin"

.text

	la $a0, LAMAR
	jal FLAG

	j END

FLAG:
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
	
END:
