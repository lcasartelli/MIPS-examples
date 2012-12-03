# Calcola n numeri primi LC

# 	$t0 			numeri di primi da stampare
# 	$t1 			contatore numeri primi stampati
# 	$t4				contatore generico (incrementato ad ogni ciclo  di +1)
# 	$t5 			costante incremento
# 	$t6 			divisore
# 	$t7, $t8, $t9	registri di appoggio


.data
	input_message: .asciiz "Inserisci numero di primi da stampare: "
	error_message: .asciiz "Numero non valido"
	output_message: .asciiz "Numeri primi: "
	space: .asciiz " "

.text
.globl main								#rende visibile il metodo main al di fuori del file (vedi doc)

main:

	move $t4, $zero						
	li $t5, 1
	li $t4, 2
	li $t1, 0

	
	li $v0, 4							#stampa stringa input numero	
	la $a0, input_message
	syscall

	li $v0, 5							#acquisisce numero
	syscall
	move $t0, $v0						#memorizza numero

	ble $t0, $zero, error_message		#check numero: se n=0 -> messaggio errore
	
	
	

	li $v0, 4 							#Stampa label risultato
	la $a0, output_message
	syscall


	while:								#CICLO: TROVA N-ESIMO NUMERO PRIMO

		beq $t1, $t0, end				#controlla se il ciclo è finito

		beq $t1, $zero, primo 			#caso semplice n = 1 -> risultato = 2

		add $t4, $t4, $t5				#contatore generale ++
		li $t6, 2						#divisore di partenza 2

		add $t8, $t4, $t5				#divisore massimo = (numero+1)/2
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
			li $v0, 1
			move $a0, $t4
			syscall

			li $v0, 4					#Stampa spazio
			la $a0, space
			syscall
		
		j while

	error:								#STAMPA ERRORE
		li $v0, 4
		la $a0, errore
		syscall

	end:								#END
		li $v0, 10
		syscall