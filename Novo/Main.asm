.data
.include "zero.asm"
.include "um.asm"
.include "dois.asm"
.include "tres.asm"
.include "quatro.asm"
.include "cinco.asm"
.include "seis.asm"

.text
paocima:
	lui $8 	0x1001	#Ponteiro "para"
	lui $9 	0x1001	#Ponteiro "de"
	lui $10 	0xffff	#Visualizador de inputs
	add $11 $0 $0		#"Carregador" de $9 para $8
	addi $12 $0 32768	#Contador do tamanho de uma tela (256*384)
	addi $13 $0 0		#"Qual tela" 
	addi $14 $0 6 
	j mortadela
	
picles:				#mostra o meio de "um" quando clicar no espaço
	lui $9 0x1001		#reseta 9 pra posição inicial 
	addi $9 $9 262144	#ajusta 9 na posição correta
	j mortadela
	
		
alface:				#função "wait"
	lw $11 0($10)		#checa se houve input
	bne $11 $0 queijo		
	j alface

ketchup:
	addi $9 $9 -32768	#sobe a tela
	j mortadela

mostarda:
	addi $9 $9 32768		#desce a tela
	j mortadela
	
queijo:				#checa qual foi o input e vai para a função correspondente
	lw $11 4($10)
	beq $11 'w' ketchup
	beq $11 'd' hamburguer
	beq $11 's' mostarda
	beq $11 'a' ovofrito
	beq $11 ' ' picles
	j alface
	
mortadela:
	addi $12 $12 -1		
	lw $11 0($9)		#bota "de" no 11
	sw $11 0($8)		#bota de 11 no "para"
	addi $8 $8 4		#proximo indice do vetor
	addi $9 $9 4		
	bne $12 $0 mortadela 	#condicao do loop
	
	addi $9 $9   -131072	#$8 e $9 para seus valores antes de mortadela
	addi $8 $8   -131072	
	addi $12 $0 32768	#volta $12 para seu valor antes de mortadela
	j alface

hamburguer:			#TOARRUMAR
	addi $13 $13 1
	bge $13 $14 alface
	addi $9 $9 393216
	j mortadela

ovofrito:				#TOARRUMAR
	addi $13 $13 -1
	ble $13 $0 alface
	addi $9 $9 -393216
	j mortadela


	
