# Calcola n-esimo numero primo {LC} 

# 	$t0 			posizione finale numero primo
# 	$t1 			posizione temporanea numero primo
# 	$t2				risultato
# 	$t4				contatore generico (incrementato ad ogni ciclo  di +1)
# 	$t5 			costante incremento
# 	$t6 			divisore
# 	$t7, $t8, $t9	registri di appoggio


.data
	input_message: .asciiz "Inserisci l'indice n-esimo numero primo da stampare: "
	error_message: .asciiz "Numero non valido"
	output_message: .asciiz "Numero primo: "

.text
.globl main								#rende visibile il metodo main al di fuori del file (vedi doc)

main:

	move $t4, $zero						#contatore = 0
	li $t5, 1
	li $t4, 2

	
	li $v0, 4							#stampa stringa input numero	
	la $a0, input_message
	syscall

	li $v0, 5							#acquisisce numero
	syscall
	move $t0, $v0						#memorizza numero

	ble $t0, $zero, error_message			#check numero: se n=0 -> messaggio errore
	
	move $t2, $t4						#numero primo attuale = 2					
	li $t1,1 							#contatore numeri primi = 1

	beq $t0, $t1, print_result			#caso semplice n = 1 -> risultato = 2


	#Caso generico n > 1

	while:								#CICLO: TROVA N-ESIMO NUMERO PRIMO

		beq $t1, $t0, print_result		#controlla se il ciclo è finito

		add $t4, $t4, $t5				#contatore generale ++
		li $t6, 2						#divisore di partenza 2

		sub $t8, $t4, $t5				#divisore massimo = (numero-1)/2
		div $t8, $t8, $t6

		divnum:							#CICLO: CONTROLLA SE IL NUMERO E' PRIMO

			move $t9, $t6				#mette divisore in $t9

			div $t4, $t9				#calcola modulo e mette in $t9
			mfhi $t9

			beq $t9, $zero, while		#se il resto è 0 non è primo
			beq $t8, $t6, primo			#se div == (num+1)/2 -> primo

			add $t6, $t6, $t5	 		#div ++
		
			j divnum

		primo:							#TROVATO NUMERO PRIMO: MEMORIZZA VALORE E INDICE

			add $t1, $t1, $t5			#contatore numero primo ++
			move $t2, $t4				#risultato = numero primo attuale			
		
		j while
	
	print_result:						#STAMPA RISULTATO
		li $v0, 4
		la $a0, output_message
		syscall
		li $v0, 1
		move $a0, $t2
		syscall
		j end

	error:								#STAMPA ERRORE
		li $v0, 4
		la $a0, errore
		syscall

	end:								#END
		li $v0, 10
		syscall