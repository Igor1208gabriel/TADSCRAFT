.text
main:
	lui $8 0x1001 #ponteiro para mostrar a tela
	lui $9 0x1001 #ponteiro para qual tela mostrar
	addi $10 $0 8192 #tamanho de uma tela
	lui $14 0xffff #ponteiro para qual tecla foi apertada
	j telainicial

telainicial:
	.include "TelaInicial.asm"
	.text
	lui $9 0x1001
	lui $8 0x1001
	j mortadela
	
lado:
	.include "Lado.asm"
	.text
	lui $9 0x1001
	lui $8 0x1001
	j mortadela
frente:
	.include "frente.asm"
	.text
	lui $9 0x1001
	addi $9 $9 32768
	addi $10 $0 24576
	lui $8 0x1001
	j mortadela
	
mortadela: #função básica para mostrar a tela
	addi $10 $10 -1
	lw   $11 0($9)
	sw   $11 0($8)
	addi $8  $8 4
	addi $9  $9 4
	bne  $10 $0 mortadela
	j esperar

esperar: #while(true) // if(tecla_apertada) break
	lw  $13 0($14)
	bne $13 $0 mudou
	beq $0  $0 esperar
	
mudou: #um tanto de if pra ver qual tecla foi apertada
	lw   $25 4($14)
	addi $13 $0 32 #valor do esspaço
	beq  $25 $13 frente