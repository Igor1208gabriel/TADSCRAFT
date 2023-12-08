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
	lui $8 	0x1001	#ponteiro "para"
	lui $9 	0x1001	#ponteiro "de"
	lui $10 	0xffff		#visualizador de inputs
	add $11 $0 $0		#"carregador" de $9 para $8
	addi $12 $0 98304	#contador do tamanho da tela
	j mortadela
	
alface:
	lw $11 0($10)
	bne $11 $0 queijo
	j alface
	
queijo:
	lw $11 4($10)
	beq $11 'w' ketchup
	beq $11 's' mostarda

ketchup:
	addi $9 $9 -32768	#sobe a tela
	j mortadela

mostarda:
	addi $9 $9 32768		#desce a tela
	j mortadela

mortadela:
	addi $12 $12 -1		
	lw $11 0($9)		#bota "de" no 11
	sw $11 0($8)		#bota de 11 no "para"
	addi $8 $8 4		#proximo indice do vetor
	addi $9 $9 4		
	bne $12 $0 mortadela 	#condicao do loop
	
	addi $9 $9 	393216	#$12*4 voltar $8 e $9 para o início
	addi $8 $8 	393216		
	addi $12 $0 98304
	j alface
	

	
