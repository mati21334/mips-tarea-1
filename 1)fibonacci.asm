.data
	salto: .asciiz "\n"

.text
.globl main
main:
#Inicializo las variables a usar
	li $t0, 0
	li $t1, 1
	li $t3, 18
#----------------------------
#Imprimo el 0
	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, salto
	syscall
#----------------------------
#Imprimo el 1
	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 4
	la $a0, salto
	syscall
#----------------------------
loop:						#
	beq $t3, $zero, exit	#while(t3 != 0){
	add $t2, $t1, $t0		#	t2 = t1 + t0
	li $v0, 1				#
	move $a0, $t2			#
	syscall					#	printf("%d", t2);
							#
	li $v0, 4				#
	la $a0, salto			#
	syscall					#	printf("\n");
							#
	move $t0, $t1			#	t0 = t1;
	move $t1, $t2			#	t1 = t2;
	addi $t3, $t3, -1		#	t3--;
	j loop					#}

#----------------------------
#Finalizo el programa
exit:
	#Termina el programa
	li $v0, 10
	syscall
