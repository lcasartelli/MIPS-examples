#	Calcola fattoriale		LC


# 	$t0 		input utente (x)
# 	$t1 		input utente (n)
#	$t2			risultato
#	$t5			costante = 1

.data
	input_message_x: .asciiz "Inserisci base: "
	input_message_n: .asciiz "Inserisci esponente: "
	output_message: .asciiz "Risultato: "


.text
.globl main

main:
	
	li $t2, 1
	li $t5, 1

	li $v0, 4							#stampa stringa input base	
	la $a0, input_message_x
	syscall
	li $v0, 5							#acquisizione base
	syscall
	move $t0, $v0	

	li $v0, 4							#stampa stringa input esponente
	la $a0, input_message_n
	syscall
	li $v0, 5							#acquisizione esponente
	syscall
	move $t1, $v0	

	for:

		beq $t1, $zero, result			#while(n>=1)

		mul $t2, $t2, $t0				#x=*x
		sub $t1, $t1, $t5				#n--

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

