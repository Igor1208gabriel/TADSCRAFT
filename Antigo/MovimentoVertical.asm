.include "Lado.asm"
#a shadow tem 24576 pixels, composto por 3 telas de 128*64
#quando o personagem olha para baixo ou para baixo, 
# a borda aparenta estar mais perto:
#ou seja, a main "olha" pra uma parte mais abaixo na shadow


# TODO:
# Melhorar baixo e cima para simular movimento
# adicionar imagem do "Lado"
# adicionar camera para "Lado"
# condicionais para parada de cima e baixo
# adicionar meia rotacao para animacao * 



.text
main:
	
	lui $8 0x1001 #ponteiro pro main
	lui $9 0x1001 #ponteiro pras shadows
	addi $9 $9 98304 #incio da primeira shadow 
	addi $11 $0 8192 #1 tela
	addi $12 $0 24576 #tela inteira/3 telas
	

mostrartela: #mostra toda a tela e carrega a shadow
	addi $12 $12 -1
	lw $13 0($8)
	sw $13 0($9)
	sw $13 0($8)
	addi $8 $8 4
	addi $9 $9 4
	bne $12 $0 mostrartela
	
	lui $9 0x1001
	addi $9 $9 98304
	
	j mortadela


set: #configs pros ponteiros e contadores
	lui $8 0x1001 #ponteiro pro main
	lui $14 0xffff
	addi $11 $0 8192 #1 tela
	addi $12 $0 24576 #tela inteira
	j esperar	
	
esperar: #while(true) // if(tecla_apertada) break
	lw $13 0($14)
	bne $13 $0 mudou
	beq $0 $0 esperar

mudou: #if (tecla == s) baixo; elif(tecla == w) cima;
	addi $13 $0 0
	lw $13 0($14)
	lw $25 4($14)
	addi $13 $0 115 #s
	beq $13 $25 baixo
	addi $13 $0 119 #w
	beq $13 $25 cima
	j mudou

baixo: #"subir" os pixels verdes //TODO
	addi $9 $9 2048
	j mortadela

cima: #"Descer" os pixels verdes // TODO
	addi $9 $9 -2048
	j mortadela
	
mortadela: #Reescrever a tela 
	addi $11 $11 -1
	lw $13 0($9)
	sw $13 0($8)
	addi $8 $8 4
	addi $9 $9 4
	bne $11 $0 mortadela
	addi $9 $9 -32768
	j set
