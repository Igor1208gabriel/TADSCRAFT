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
#.include "mao.asm"

.text
paocima:
	lui    $8 		0x1001	#Ponteiro "para"
	lui    $9 		0x1001	#Ponteiro "de"
	lui    $10 		0xffff		#Visualizador de inputs 
	lui    $16 		0x1001
	addi $16 $0 	18874368
	addi $17 $0 50
	addi $11 $0 	0		#"Carregador" de $9 para $8
	addi $12 $0 	32768	#Contador do tamanho de uma tela (256*384)
	addi $13 $0 	0		#"Qual tela" 
	addi $14 $0 	10		#"Quantas telas"
	addi $15 $0 	393216 	#$12 * 4
	j mortadela
	
#teste:
#	addi $17 $17 -1
#	lw $11 0($16)
# 	sw $11 0($8)
	
	
picles:					#mostra o meio de "um" quando clicar no espaco
	addi $13 $0 		1
	lui  $9 		0x1001	#reseta 9 pra posicao inicial 
	addi $9 $9 		262144	#ajusta 9 na posicao correta
	j mortadela
	
		
alface:					#funcao "wait"
	lw  $11    0($10)			#checa se houve input
	bne $11 $0 queijo		
	j alface

ketchup:					#sobe a tela
	addi $9 $9 -8192
	j mortadela

mostarda:					#desce a tela
	addi $9 $9  8192
	j mortadela
	
queijo:					#checa qual foi o input e vai para a fun��o correspondente
	lw  $11     4($10)
	beq $11 'w' rucula
	beq $11 'd' hamburguer
	beq $11 's' tomate
	beq $11 'a' ovofrito
	beq $11 ' ' picles
	j alface
	
mortadela:
	addi $12 $12 -1		
	lw   $11      0($9)		#bota "de" no 11
	sw   $11      0($8)		#bota de 11 no "para"
	addi $8  $8   4			#proximo indice do vetor
	addi $9  $9   4		
	bne  $12 $0   mortadela	#condicao do loop
	
	addi $9 $9   -131072		#$8 e $9 para seus valores antes de mortadela
	addi $8 $8   -131072	
	addi $12 $0   32768		#volta $12 para seu valor antes de mortadela
	j alface

hamburguer:			
	addi $13 $13 1
	bgt  $13 $14 alho
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
	addi $9 $9 -3538944
	addi $13 $0 1
	j mortadela

tomate:
	addi $24 $0 268894208
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	j mostarda

rucula:
	addi $24 $0 268632064
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	beq $24 $9 alface
	addi $24 $24 393216
	j ketchup
