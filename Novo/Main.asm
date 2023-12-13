.data
.include "00.asm"
.include "01.asm"
.include "02.asm"
.include "03.asm"
.include "04.asm"
.include "05.asm"
.include "06.asm"
.include "07.asm"
.include "08.asm"
.include "09.asm"
.include "10.asm"

.text
paocima:
	lui  $8 	0x1001	#Ponteiro "para"
	lui  $9 	0x1001	#Ponteiro "de"
	lui  $10 	0xffff	#Visualizador de inputs
	addi $11 $0 	0	#"Carregador" de $9 para $8
	addi $12 $0 	32768	#Contador do tamanho de uma tela (256*384)
	addi $13 $0 	0	#"Qual tela" 
	addi $14 $0 	10	#"Quantas telas"
	addi $15 $0 	393216 	#$12 * 4
	j mortadela
	
picles:				#mostra o meio de "um" quando clicar no espa�o
	addi $13 $0 	1
	lui  $9 	0x1001	#reseta 9 pra posi��o inicial 
	addi $9 $9 	262144	#ajusta 9 na posi��o correta
	j mortadela
	
		
alface:				#fun��o "wait"
	lw  $11    0($10)	#checa se houve input
	bne $11 $0 queijo		
	j alface

ketchup:			#sobe a tela
	addi $9 $9 -8192
	j mortadela

mostarda:			#desce a tela
	addi $9 $9  8192
	j mortadela
	
queijo:				#checa qual foi o input e vai para a fun��o correspondente
	lw  $11     4($10)
	beq $11 'w' ketchup
	beq $11 'd' hamburguer
	beq $11 's' mostarda
	beq $11 'a' ovofrito
	beq $11 ' ' picles
	j alface
	
mortadela:
	addi $12 $12 -1		
	lw   $11      0($9)	#bota "de" no 11
	sw   $11      0($8)	#bota de 11 no "para"
	addi $8  $8   4		#proximo indice do vetor
	addi $9  $9   4		
	bne  $12 $0   mortadela #condicao do loop
	
	addi $9 $9   -131072	#$8 e $9 para seus valores antes de mortadela
	addi $8 $8   -131072	
	addi $12 $0   32768	#volta $12 para seu valor antes de mortadela
	j alface

hamburguer:			
	addi $13 $13 1
	bge  $13 $14 alho
	addi $9  $9  393216
	j mortadela

ovofrito:				
	addi $13 $13 -1
	ble  $13 $0   cebola
	addi $9  $9  -393216
	j mortadela

cebola:
	add  $13 $0   $14
	addi $14 $14 -1
	mul  $25 $15  $14 
	addi $14 $14  1
	add  $9  $9   $25
	j mortadela

alho:
	addi $14 $14 -1	
	addi $24 $0   4
	mul  $25 $12 $14	#tamanho de tela * qtd de telas
	mul  $25 $25 $24 	#linha anterior * 4
	sub  $9  $9  $25	
	addi $14 $14  1
	add  $24 $0  $0
	j mortadela
	
