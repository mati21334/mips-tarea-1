# Tarea de MIPS \#1

Ejercicios de lenguaje ensamblador. Más información en [el blog](https://la35.net/orga/mips-branchs.html). Para probar los programas pueden usar el SPIM.

## Ejercicios

Forkear este repo e implementar los siguientes programas en _assembler_ de MIPS. Recuerden comentar el código.

1. Un programa que imprima en consola los primeros 20 números de Fibonacci.
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

2. Un programa que calcule el factorial de un número ingresado por el usuario.
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

3. Un programa que muestre los múltiplos de 3 y de 5 (o de ambos) para los primeros 100 números naturales.
.data
salto: .asciiz "\n"	#Salto de Linea

.text
.globl main
main:
	li $t0, 1					#Declaro el inicio
	li $s0, 101					#Declaro el final
#-----------------------------------------------------------------------------------------------------------
verificar:						#Codigo para verificar si t0 es mutliplo de 3 o 5
	beq $t0, $s0, exit			#Pregunto si mi variable inicial es igual a mi variable final (si es, finalizo)
	rem $t1, $t0, 5				#Si no se cumple lo anterior, hago t0 % 5 y lo guardo en t1
	beq $t1, $zero, multiplos	#Si t1 = 0, entonces t0 es multiplo de 5. Ir a multiplos
	rem $t1, $t0, 3				#Si no se cumple lo anterior, hago t0 % 3 y lo guardo en t1
	beq $t1, $zero, multiplos	#Si t1 = 0, entonces t0 es multiplo de 3. Ir a multiplos

	#Si no se cumple nada de lo anterior, entonces t0 no es multiplo de 3 o 5. Pasar al siguiente numero
	addi $t0, $t0, 1			#t0++

	j verificar					#Volver a verificar
#-----------------------------------------------------------------------------------------------------------
multiplos:						#Codigo para imprimir t0
	li $v0, 1					#Preparo para imprimir entero
	add $a0, $t0, $zero			#a0 = t0
	syscall						#Imrpimo t0

	li $v0, 4					#Preparo para imprimir string
	la $a0, salto 				#Guardo en a0 la direcion del string
	syscall						#Imprimo string

	addi $t0, $t0, 1			#t0++

	j verificar					#Volver a verificar
#-----------------------------------------------------------------------------------------------------------
#Finalizo el programa
exit:
	li $v0, 10
	syscall
