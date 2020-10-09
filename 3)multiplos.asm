.data
salto: .asciiz "\n"	#Salto de Linea

.text
.globl main
main:
	li $t0, 1					#Declaro el inicio
	li $s0, 101					#Declaro el final
#-----------------------------------------------------------------------------------------------------------
verificar:					       	   #Codigo para verificar si t0 es mutliplo de 3 o 5
	beq $t0, $s0, exit		    	 #Pregunto si mi variable inicial es igual a mi variable final (si es, finalizo)
	rem $t1, $t0, 5			     	   #Si no se cumple lo anterior, hago t0 % 5 y lo guardo en t1
	beq $t1, $zero, multiplos	   #Si t1 = 0, entonces t0 es multiplo de 5. Ir a multiplos
	rem $t1, $t0, 3			      	 #Si no se cumple lo anterior, hago t0 % 3 y lo guardo en t1
	beq $t1, $zero, multiplos  	 #Si t1 = 0, entonces t0 es multiplo de 3. Ir a multiplos

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
