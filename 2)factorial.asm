.data
ingreso: .asciiz "Ingrese un numero: "

.text
.globl main
main:
	li $t1, 1			#Guardo una variable para el resultado

#Pido al usuario un numero
	li $v0, 4			#Preparo para imprimir texto
	la $a0, ingreso		#Guardo en a0 el texto
	syscall				#Imrpimo
#------------------------

#Guardo el numero que ingreso el usuario en t0
	li $v0, 5			#Preparo para guardar un entero
	syscall				#Guardo el entero en v0
	move $t0, $v0		#Muevo lo de v0 a t0
#------------------------

#Calculo el factorial
loop:
	beq $t0, $zero, finalizar		#while(t0 != 0){
	mul $t1, $t1, $t0				#	t1 *= t0;
	addi $t0, $t0, -1				#	t0--;
	j loop							#}
#-------------------

finalizar:
	#Imprimo t1
	li $v0, 1		#Preparo para imprimir un entero
	move $a0, $t1	#Guardo en a0 lo que vale t1
	syscall			#Imprimo

exit:
#Finalizo el programa
li  $v0, 10				#Preparo para finalizar
syscall					#Finalizo
