.include "TelaInicial.asm"
.include "Lado.asm"
.include "frente.asm"

.text
main:
	lui $8 0x1001 #ponteiro para mostrar a tela
	lui $9 0x1001 #ponteiro para o início de qual tela mostrar:
#	0 	= telainicial
#	32768 	= lado
#	131072 	= frente
	addi $10 $0 8192 #tamanho de uma tela
	lui $14 0xffff #ponteiro para qual tecla foi apertada
	j telainicial

telainicial:
	lui $9 0x1001
	lui $8 0x1001
	j mortadela
	
lado:
	addi $9 $9 -98304
	addi $10 $0 8192
	addi $24 $0 1
	lui $8 0x1001
	j mortadela
	
frente:
	
	addi $9 $9 98304
	addi $10 $0 8192
	addi $24 $0 0
	lui $8 0x1001
	j mortadela
	
mortadela: #função básica para mostrar a tela
	addi $10 $10 -1
	lw   $11 0($9)
	sw   $11 0($8)
	addi $8  $8 4
	addi $9  $9 4
	bne  $10 $0 mortadela
	addi $9 $9 -32768
	j esperar

esperar: #while(true) // if(tecla_apertada) break
	lw  $13 0($14)
	bne $13 $0 mudou
	beq $0  $0 esperar
	
mudou: #um tanto de if pra ver qual tecla foi apertada
	lw   $25 4($14)
	addi $13 $0 32 #valor do espaço
	beq  $25 $13 inicio
	
	addi $13 $0 'd'
	beq  $25 $13 ladooufrente
	
	addi $13 $0 'a'
	beq  $25 $13 ladooufrente
	
	addi $13 $0 'w'
	beq  $25 $13 cima
	
	addi $13 $0 's'
	beq  $25 $13 baixo
	j esperar

ladooufrente:
	add $13 $0 $0
	beq $13 $24 lado
	j frente

cima:
	addi $10 $0 8192
	lui $8 0x1001
	addi $9 $9 -1024
	j mortadela

baixo:
	addi $10 $0 8192
	lui $8 0x1001
	addi $9 $9 1024
	j mortadela
	
inicio:
	addi $10 $0 8192
	lui $8 0x1001
	addi $9 $9 161792
	j mortadela
	
