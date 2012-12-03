#	Calcola fattoriale		LC


# 	$t0 		input utente (n)
# 	$t1 		indice
#	$t2			risultato
#	$t5			costante = 1
#	$t3, $t4	registri di appoggio

.data
	input_message: .asciiz "Inserisci numero per calcolo fattoriale: "
	output_message: .asciiz "Fattoriale: "

.text
.globl main

main:
	
	li $t2, 1
	li $t5, 1

	li $v0, 4							#stampa stringa input numero	
	la $a0, input_message
	syscall
	li $v0, 5							#acquisizione numero
	syscall
	move $t0, $v0

	for:
		beq $t0, $t5, result			#while(n>=1)

		mul $t2, $t2, $t0				#n*=n-1
		sub $t0, $t0, $t5				#n--

		j for


	result:

		li $v0, 4
		la $a0, output_message
		syscall
		li $v0, 1
		move $a0, $t2
		syscall
		
	end:	
								#END
		li $v0, 10
		syscall