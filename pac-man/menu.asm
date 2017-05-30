#definicao do mapa de enderecamento
.eqv Buffer0Teclado     0xFFFF0100
.eqv Buffer1Teclado     0xFFFF0104
.eqv TecladoxMouse      0xFFFF0110
.eqv BufferMouse        0xFFFF0114
.eqv RXRS232            0xFFFF0120
.eqv TXRS232            0xFFFF0121
.eqv CTRLRS232          0xFFFF0122
.eqv LINHA1             0xFFFF0130
.eqv LINHA2             0xFFFF0140
.eqv LCDClear           0xFFFF0150
.eqv AudioINL           0xFFFF0000
.eqv AudioINR           0xFFFF0004
.eqv AudioOUTL          0xFFFF0008
.eqv AudioOUTR          0xFFFF000c
.eqv AudioCTRL1         0xFFFF0010
.eqv AudioCTRL2         0xFFFF0014
.eqv SD_BUFFER_INI      0xFFFF0250
.eqv SD_BUFFER_END      0xFFFF044C
.eqv SD_INTERFACE_ADDR  0xFFFF0450
.eqv SD_INTERFACE_CTRL  0xFFFF0454

# Sintetizador - 2015/1

.eqv NoteData           0xFFFF0200
.eqv NoteClock          0xFFFF0204
.eqv NoteMelody         0xFFFF0208
.eqv MusicTempo         0xFFFF020C
.eqv MusicAddress       0xFFFF0210

.eqv VGAADDRESSINI      0xFF000000
.eqv VGAADDRESSFIM      0xFF012C00
.eqv NUMLINHAS          240
.eqv NUMCOLUNAS         320


    .kdata   # endereço 0x9000 0000
kdata:
inicioKdata:
# Tabela de caracteres
# Endereço da Tabela de Caracteres
LabelTabChar:
.word 0x00000000, 0x00000000, 0x10101010, 0x00100010, 0x00002828, 0x00000000, 0x28FE2828, 0x002828FE, 0x38503C10, 0x00107814, 0x10686400, 0x00004C2C, 0x28102818, 0x003A4446, 0x00001010, 0x00000000, 0x20201008, 0x00081020, 0x08081020, 0x00201008, 0x38549210, 0x00109254, 0xFE101010, 0x00101010, 0x00000000, 0x10081818, 0xFE000000, 0x00000000, 0x00000000, 0x18180000, 0x10080402, 0x00804020, 0x54444438, 0x00384444, 0x10103010, 0x00381010, 0x08044438, 0x007C2010, 0x18044438, 0x00384404, 0x7C482818, 0x001C0808, 0x7840407C, 0x00384404, 0x78404438, 0x00384444, 0x1008047C, 0x00202020, 0x38444438, 0x00384444, 0x3C444438, 0x00384404, 0x00181800, 0x00001818, 0x00181800, 0x10081818, 0x20100804, 0x00040810, 0x00FE0000, 0x000000FE, 0x04081020, 0x00201008, 0x08044438, 0x00100010, 0x545C4438, 0x0038405C, 0x7C444438, 0x00444444, 0x78444478, 0x00784444, 0x40404438, 0x00384440, 0x44444478, 0x00784444, 0x7840407C, 0x007C4040, 0x7C40407C, 0x00404040, 0x5C404438, 0x00384444, 0x7C444444, 0x00444444, 0x10101038, 0x00381010, 0x0808081C, 0x00304848, 0x70484444, 0x00444448, 0x20202020, 0x003C2020, 0x92AAC682, 0x00828282, 0x54546444, 0x0044444C, 0x44444438, 0x00384444, 0x38242438, 0x00202020, 0x44444438, 0x0C384444, 0x78444478, 0x00444850, 0x38404438, 0x00384404, 0x1010107C, 0x00101010, 0x44444444, 0x00384444, 0x28444444, 0x00101028, 0x54828282, 0x00282854, 0x10284444, 0x00444428, 0x10284444, 0x00101010, 0x1008047C, 0x007C4020, 0x20202038, 0x00382020, 0x10204080, 0x00020408, 0x08080838, 0x00380808, 0x00442810, 0x00000000, 0x00000000, 0xFE000000, 0x00000810, 0x00000000, 0x3C043800, 0x003A4444, 0x24382020, 0x00582424, 0x201C0000, 0x001C2020, 0x48380808, 0x00344848, 0x44380000, 0x0038407C, 0x70202418, 0x00202020, 0x443A0000, 0x38043C44, 0x64584040, 0x00444444, 0x10001000, 0x00101010, 0x10001000, 0x60101010, 0x28242020, 0x00242830, 0x08080818, 0x00080808, 0x49B60000, 0x00414149, 0x24580000, 0x00242424, 0x44380000, 0x00384444, 0x24580000, 0x20203824, 0x48340000, 0x08083848, 0x302C0000, 0x00202020, 0x201C0000, 0x00380418, 0x10381000, 0x00101010, 0x48480000, 0x00344848, 0x44440000, 0x00102844, 0x82820000, 0x0044AA92, 0x28440000, 0x00442810, 0x24240000, 0x38041C24, 0x043C0000, 0x003C1008, 0x2010100C, 0x000C1010, 0x10101010, 0x00101010, 0x04080830, 0x00300808, 0x92600000, 0x0000000C, 0x243C1818, 0xA55A7E3C, 0x99FF5A81, 0x99663CFF, 0x10280000, 0x00000028, 0x10081020, 0x00081020

# scancode -> ascii
LabelScanCode:
.word 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x71, 0x31, 0x00, 0x00, 0x00, 0x7a, 0x73, 0x61, 0x77, 0x32, 0x00,0x00, 0x63, 0x78, 0x64, 0x65, 0x34, 0x33, 0x00, 0x00, 0x00, 0x76, 0x66, 0x74, 0x72, 0x35, 0x00,0x00, 0x6e, 0x62, 0x68, 0x67, 0x79, 0x36, 0x00, 0x00, 0x00, 0x6d, 0x6a, 0x75, 0x37, 0x38, 0x00,0x00, 0x2c, 0x6b, 0x69, 0x6f, 0x30, 0x39, 0x00, 0x00, 0x2e, 0x2f, 0x6c, 0x3b, 0x70, 0x2d, 0x00,0x00, 0x00, 0x27, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5b, 0x00, 0x5d, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x31, 0x00, 0x34, 0x37, 0x00, 0x00, 0x00,0x30, 0x2e, 0x32, 0x35, 0x36, 0x38, 0x00, 0x00, 0x00, 0x2b, 0x33, 0x2d, 0x2a, 0x39, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00
# scancode -> ascii (com shift)
.word 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x51, 0x21, 0x00, 0x00, 0x00, 0x5a, 0x53, 0x41, 0x57, 0x40, 0x00,0x00, 0x43, 0x58, 0x44, 0x45, 0x24, 0x23, 0x00, 0x00, 0x00, 0x56, 0x46, 0x54, 0x52, 0x25, 0x00,0x00, 0x4e, 0x42, 0x48, 0x47, 0x59, 0x5e, 0x00, 0x00, 0x00, 0x4d, 0x4a, 0x55, 0x26, 0x2a, 0x00,0x00, 0x3c, 0x4b, 0x49, 0x4f, 0x29, 0x28, 0x00, 0x00, 0x3e, 0x3f, 0x4c, 0x3a, 0x50, 0x5f, 0x00,0x00, 0x00, 0x22, 0x00, 0x00, 0x2b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7b, 0x00, 0x7d, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00

instructionMessage:     .ascii  "   Instrucao    "
                        .asciiz "   Invalida!    "
lixobuffer:             .asciiz "  "  # so para alinhar o endereco do FloatBuffer!
#buffer do ReadFloatm 32 caracteres
FloatBuffer:            .asciiz "                                "

# variaveis para implementar a fila de eventos de input
eventQueueBeginAddr:    .word 0x90000E00
eventQueueEndAddr:      .word 0x90001000
eventQueueBeginPtr:     .word 0x90000E00
eventQueueEndPtr:       .word 0x90000E00


#MOUSE
DATA_X:         .word 0
DATA_Y:         .word 0
DATA_CLICKS:    .word 0


##### Preparado para considerar syscall = jal ktext  para o pipeline

    .ktext

exceptionHandling:
    addi    $sp, $sp, -8
    sw      $at, 0($sp)
    sw      $ra, 4($sp)
    addi    $k0, $zero, 32              # default syscall exception=8*4
    mfc0    $k0, $13                    # nao esta implementada no pipe
    nop                                 # nao retirar!
    andi    $k0, $k0, 0x007C
    srl     $k0, $k0, 2

    addi    $k1, $zero, 12              # overflow na ULA
    beq     $k1, $k0, ALUOverflowException

    addi    $k1, $zero, 15              # excecao de ponto flutuante
    beq     $k1, $k0, FPALUException

    addi    $k1, $zero, 0               # interrupcao
    beq     $k1, $k0, interruptException

    addi    $k1, $zero, 10              # instrucao reservada ou invalida
    beq     $k1, $k0, instructionException

    addi    $k1, $zero, 8               # syscall
    beq     $k1, $k0, syscallException

endException:
    lw      $ra, 4($sp)
    lw      $at, 0($sp)
    addi    $sp, $sp, 8

    mfc0    $k0, $14                    # EPC + 4     //NOTE: nao esta implementada no pipe
    addi    $k0, $k0, 4
    mtc0    $k0, $14                    #nao esta implementada no pipe
    eret                                #nao esta implementada no pipe
    jr      $ra                         #para o caso do eret nao estar implementado (pipeline)

ALUOverflowException:   j endException  # escolhi nao fazer nada, ja que ate hoje nunca vi um SO tratar esse tipo de excecao...

FPALUException:         j endException  # escolhi nao fazer nada, ja que ate hoje nunca vi um SO tratar esse tipo de excecao...


interruptException:
    mfc0    $k0, $13
    andi    $k0, $k0, 0xFF00
    srl     $k0, $k0, 8

    andi    $k1, $k0, 0x0001
    bne     $k1, $zero, keyboardInterrupt

    andi    $k1, $k0, 0x0002
    bne     $k1, $zero, audioInterrupt

    andi    $k1, $k0, 0x0004
    bne     $k1, $zero, mouseInterrupt

    andi    $k1, $k0, 0x0008            #verificar se nao  seria 0x0008     NOTE: Mas está 0x0008!
    bne     $k1, $zero, counterInterrupt

    j       endException

counterInterrupt:   j endException      # nenhum tratamento para a interrupcao de contagem eh necessario ate agora

audioInterrupt:     j endException      # TODO: Implementar interrupção de áudio.

###########  Interrupcao do Mouse ################
mouseInterrupt:
    la      $k0, BufferMouse            # endereço do buffer_mouse
    nop
    nop
    lw      $k0, 0($k0)                 # carrega o buffer em k0
    nop
    nop
    andi    $k1, $k0, 0xFF

    addi    $sp, $sp, -8
    sw      $t0, 0($sp)
    sw      $t1, 4($sp)

    #default (supõe-se que seja o movimento do mouse)

    ###atualiza os clicks
    li      $k1, 0x00ff0000
    nop
    nop
    and     $k1, $k0, $k1
    nop
    nop
    srl     $k1, $k1, 16                # k1 tem o byte com info dos clicks e sinais de X/Y
    andi    $t0, $k1, 1                 # $t0=botão esquerdo
    li      $t1, 0
    beq     $t0, $zero, MOUSEPULAESQ
    li      $t1, 0xF

MOUSEPULAESQ:
    andi    $t0, $k1, 2
    nop
    nop
    srl     $t0, $t0, 1                 # $t0=botão direito
    beq     $t0, $zero, MOUSEPULADIR
    ori     $t1, $t1, 0xF0

MOUSEPULADIR:
    andi    $t0, $k1, 4
    srl     $t0, $t0, 2                 #$t0=botão do meio
    beq     $t0, $zero, MOUSEPULAMEIO
    ori     $t1, $t1, 0xF00
    nop
    nop
MOUSEPULAMEIO:
    sw      $t1, DATA_CLICKS($zero)     # FIXME: ENDERECO ERRADO!!!!!!!

    ###atualiza o x
    andi    $t0, $k1, 0x10
    nop
    nop
    srl     $t0, $t0, 4                 #t0=(sinal)
    la      $t1, 0x0000ff00
    nop
    nop
    and     $t1, $t1, $k0
    srl     $t1, $t1, 8
    beq     $t0, $zero, pulasinalmousex
    la      $t0, 0xffffff00
    nop
    nop
    or      $t1, $t1, $t0

pulasinalmousex:
    lw      $t0, DATA_X($zero)          # FIXME: ENDERECO ERRADO
    nop
    nop
    add     $t0, $t0, $t1
    li      $t1, 320
    nop
    nop
    slt     $t1, $t0, $t1
    bne     $t1, $zero, mouseliberax320
    li      $t0, 320

mouseliberax320:
    li      $t1, 0
    slt     $t1, $t0, $t1
    beq     $t1, $zero, mouseliberax0
    li      $t0, 0

mouseliberax0:
    sw      $t0, DATA_X($zero)          # FIXME: ENDEREÇO ERRADO

    ###atualiza o Y
    andi    $t0, $k1, 0x20
    nop
    nop
    srl     $t0, $t0, 5                 #t0=(sinal)
    la      $t1, 0x000000ff
    and     $t1, $t1, $k0
    beq     $t0, $zero, pulasinalmousey
    la      $t0, 0xffffff00
    nop
    nop
    or      $t1, $t1, $t0

    #t1=-delta y
pulasinalmousey:
    nor     $t1, $t1, $t1
    addi    $t1, $t1, 1                 #t1=delta y
    lw      $t0, DATA_Y($zero)          # FIXME: ENDERECO ERRADO
    add     $t0, $t0, $t1
    li      $t1, 240
    nop
    nop
    slt     $t1, $t0, $t1
    bne     $t1, $zero, mouseliberay240
    li      $t0, 240

mouseliberay240:
    li      $t1, 0
    nop
    nop
    slt     $t1, $t0, $t1
    beq     $t1, $zero, mouseliberay0
    li      $t0, 0

mouseliberay0:
    sw      $t0, DATA_Y($zero)          # FIXME: END ERRADO
    nop
    nop
    lw      $t0, 0($sp)
    lw      $t1, 4($sp)
    addi    $sp, $sp, 8

    j endException


############### Interrupcao do teclado ##################
keyboardInterrupt:
    addi    $sp, $sp, -8
    sw      $a0, 0($sp)
    sw      $v0, 4($sp)

    # verifica se ha espaco na fila comparando o incremento do ponteiro do fim da fila com o ponteiro do inicio
    la      $a0, eventQueueEndPtr
    nop
    nop
    lw      $a0, 0($a0)
    jal     eventQueueIncrementPointer
    la      $k0, eventQueueBeginPtr
    nop
    nop
    lw      $k0, 0($k0)
    nop
    nop
    beq     $k0, $v0, keyboardInterruptEnd

    # FIXME: preparar o evento de teclado no registrador $k0
    la      $k0, Buffer0Teclado
    nop
    nop
    lw      $k0, 0($k0)
    nop
    nop
    move    $t9, $k0

    # poe o evento de teclado na fila
    sw      $k0, 0($a0)
    la      $k0, eventQueueEndPtr
    nop
    nop
    sw      $v0, 0($k0)

keyboardInterruptEnd:
    lw      $a0, 0($sp)
    lw      $v0, 4($sp)
    addi    $sp, $sp, 8

    j       endException

    # $a0 = endereco (ou ponteiro) a ser incrementado. $v0 = valor incrementado
eventQueueIncrementPointer:
    addi    $v0, $a0, 4
    la      $t0, eventQueueEndAddr
    nop
    nop
    lw      $t0, 0($t0)
    nop
    nop
    beq     $t0, $v0, eventQueueIncrementPointerIf
    jr      $ra

eventQueueIncrementPointerIf:
    la      $v0, eventQueueBeginAddr
    nop
    nop
    lw      $v0, 0($v0)
    jr      $ra


########  Interrupcao de Instrucao Invalida  ###########
    # mostra mensagem de erro no display LCD
instructionException:
    la      $t0, instructionMessage
    nop
    nop
    la      $t9, LINHA1
    nop
    nop
    sw      $zero, 0x20($t9)
    lb      $t1, 0($t0)                 # primeiro caractere
    nop
    nop
instructionExceptionLoop:
    beq     $t1, $zero, goToExit        # fim da string
    sb      $t1, 0($t9)
    addi    $t0, $t0, 1
    addi    $t9, $t9, 1
    lb      $t1, 0($t0)
    j       instructionExceptionLoop



############# interrupcao de SYSCALL ###################
syscallException:
    addi    $sp, $sp, -264              # Salva todos os registradores na pilha
    sw      $1,     0($sp)
    sw      $2,     4($sp)
    sw      $3,     8($sp)
    sw      $4,    12($sp)
    sw      $5,    16($sp)
    sw      $6,    20($sp)
    sw      $7,    24($sp)
    sw      $8,    28($sp)
    sw      $9,    32($sp)
    sw      $10,   36($sp)
    sw      $11,   40($sp)
    sw      $12,   44($sp)
    sw      $13,   48($sp)
    sw      $14,   52($sp)
    sw      $15,   56($sp)
    sw      $16,   60($sp)
    sw      $17,   64($sp)
    sw      $18,   68($sp)
    sw      $19,   72($sp)
    sw      $20,   76($sp)
    sw      $21,   80($sp)
    sw      $22,   84($sp)
    sw      $23,   88($sp)
    sw      $24,   92($sp)
    sw      $25,   96($sp)
    sw      $26,  100($sp)
    sw      $27,  104($sp)
    sw      $28,  108($sp)
    sw      $29,  112($sp)
    sw      $30,  116($sp)
    sw      $31,  120($sp)
    swc1    $f0,  124($sp)
    swc1    $f1,  128($sp)
    swc1    $f2,  132($sp)
    swc1    $f3,  136($sp)
    swc1    $f4,  140($sp)
    swc1    $f5,  144($sp)
    swc1    $f6,  148($sp)
    swc1    $f7,  152($sp)
    swc1    $f8,  156($sp)
    swc1    $f9,  160($sp)
    swc1    $f10, 164($sp)
    swc1    $f11, 168($sp)
    swc1    $f12, 172($sp)
    swc1    $f13, 176($sp)
    swc1    $f14, 180($sp)
    swc1    $f15, 184($sp)
    swc1    $f16, 188($sp)
    swc1    $f17, 192($sp)
    swc1    $f18, 196($sp)
    swc1    $f19, 200($sp)
    swc1    $f20, 204($sp)
    swc1    $f21, 208($sp)
    swc1    $f22, 212($sp)
    swc1    $f23, 216($sp)
    swc1    $f24, 220($sp)
    swc1    $f25, 224($sp)
    swc1    $f26, 228($sp)
    swc1    $f27, 232($sp)
    swc1    $f28, 236($sp)
    swc1    $f29, 240($sp)
    swc1    $f30, 244($sp)
    swc1    $f31, 248($sp)
    # mthi, mtlo - 2015/1 (Salva os registradores HI e LO)
    mfhi    $t9
    sw      $t9, 252($sp)
    mflo    $t9
    sw      $t9, 256($sp)
    # Zera os valores dos registradores temporarios - 2015/1

    add     $t0, $zero, $zero
    add     $t1, $zero, $zero
    add     $t2, $zero, $zero
    add     $t3, $zero, $zero
    add     $t4, $zero, $zero
    add     $t5, $zero, $zero
    add     $t6, $zero, $zero
    add     $t7, $zero, $zero
    add     $t8, $zero, $zero
    add     $t9, $zero, $zero
    
    addi    $t0, $zero, 1               # sycall 1 = print int
    beq     $t0, $v0, goToPrintInt
    addi    $t0, $zero, 101             # sycall 1 = print int
    beq     $t0, $v0, goToPrintInt

    addi    $t0, $zero, 4               # syscall 4 = print string
    beq     $t0, $v0, goToPrintString
    addi    $t0, $zero, 104             # syscall 4 = print string
    beq     $t0, $v0, goToPrintString

    addi    $t0, $zero, 11              # syscall 11 = print char
    beq     $t0, $v0, goToPrintChar
    addi    $t0, $zero, 111             # syscall 11 = print char
    beq     $t0, $v0, goToPrintChar

endSyscall:                             # recupera todos os registradores na pilha
    lw      $1,     0($sp)
    # lw      $2,     4($sp)      # $v0 retorno de valor do syscall
    lw      $3,     8($sp)
    # lw      $4,    12($sp)      # $a0  as vezes usado como retorno
    # lw      $5,    16($sp)      # $a1
    lw      $6,    20($sp)
    lw      $7,    24($sp)
    lw      $8,    28($sp)
    lw      $9,    32($sp)
    lw      $10,   36($sp)
    lw      $11,   40($sp)
    lw      $12,   44($sp)
    lw      $13,   48($sp)
    lw      $14,   52($sp)
    lw      $15,   56($sp)
    lw      $16,   60($sp)
    lw      $17,   64($sp)
    lw      $18,   68($sp)
    lw      $19,   72($sp)
    lw      $20,   76($sp)
    lw      $21,   80($sp)
    lw      $22,   84($sp)
    lw      $23,   88($sp)
    lw      $24,   92($sp)
    lw      $25,   96($sp)
    lw      $26,  100($sp)
    lw      $27,  104($sp)
    lw      $28,  108($sp)
    lw      $29,  112($sp)
    lw      $30,  116($sp)
    lw      $31,  120($sp)
    # lwc1    $0,   124($sp)      # $f0 retorno de valor de syscall
    lwc1    $f1,  128($sp)
    lwc1    $f2,  132($sp)
    lwc1    $f3,  136($sp)
    lwc1    $f4,  140($sp)
    lwc1    $f5,  144($sp)
    lwc1    $f6,  148($sp)
    lwc1    $f7,  152($sp)
    lwc1    $f8,  156($sp)
    lwc1    $f9,  160($sp)
    lwc1    $f10, 164($sp)
    lwc1    $f11, 168($sp)
    lwc1    $f12, 172($sp)
    lwc1    $f13, 176($sp)
    lwc1    $f14, 180($sp)
    lwc1    $f15, 184($sp)
    lwc1    $f16, 188($sp)
    lwc1    $f17, 192($sp)
    lwc1    $f18, 196($sp)
    lwc1    $f19, 200($sp)
    lwc1    $f20, 204($sp)
    lwc1    $f21, 208($sp)
    lwc1    $f22, 212($sp)
    lwc1    $f23, 216($sp)
    lwc1    $f24, 220($sp)
    lwc1    $f25, 224($sp)
    lwc1    $f26, 228($sp)
    lwc1    $f27, 232($sp)
    lwc1    $f28, 236($sp)
    lwc1    $f29, 240($sp)
    lwc1    $f30, 244($sp)
    lwc1    $f31, 248($sp)
    # mthi, mtlo - 2015/1 (Recupera os registradores HI e LO)
    lw      $t9,  252($sp)
    mthi    $t9
    lw      $t9,  256($sp)
    mtlo    $t9
    lw      $t9,   96($sp)
    addi    $sp, $sp, 264

    j endException


goToExit1:
    la      $t9, LINHA1                 # escreve FIM no LCD  <= RETIREI mudar o goToExit1  NOTE: não entendir
    nop
    nop
    sb      $zero, 0x20($t9)            # limpa
    li      $t0, 0x46
    sb      $t0, 0x07($t9)
    li      $t0, 0x49
    sb      $t0, 0x08($t9)
    li      $t0, 0x4D
    sb      $t0, 0x09($t9)

goToExit:
    j       goToExit                    ########### syscall 10

goToPrintInt:
    jal     printInt                    # chama printInt
    j       endSyscall

goToPrintString:
    jal     printString                 # chama printString
    j       endSyscall

goToPrintChar:
    jal     printChar                   # chama printChar
    j       endSyscall

#############################################
#  PrintInt                                 #
#  $a0    =    valor inteiro                #
#  $a1    =    x                            #
#  $a2    =    y                            #
#############################################

printInt:
    addi    $sp, $sp, -4                # salva $ra
    sw      $ra, 0($sp)

    bne     $a0, $zero, printNotZero    # chama printNotZero

printZero:
    addi    $a0, $zero, 48              # Imprime 0
    jal     printChar

printIntEnd:
    lw      $ra, 0($sp)                 # retorna
    addi    $sp, $sp, 4
    nop
    nop
    jr      $ra

printNotZero:
    add     $t0, $zero, $a0             # $t0 contem o valor do inteiro a ser impresso
    addi    $t1, $zero, 10              # $t1 eh uma constante 10
    slt     $t9, $t0, $zero             # $t0 < 0 ?
    beq     $t9, $zero, PrintIntContinue        # verifica se o valor eh negativo.

    addi    $a0, $zero, 45              # Negativo, imprime um '-' na tela

    addi    $sp, $sp, -12
    sw      $ra, 8($sp)
    sw      $t1, 4($sp)
    sw      $t0, 0($sp)                 # salva regs

    jal     printChar                   # imprime ASCII 45

    lw      $ra, 8($sp)                 # recupera regs
    lw      $t1, 4($sp)
    lw      $t0, 0($sp)
    addi    $sp, $sp, 12

    sub     $t0, $zero, $t0             # Torna $t0 positivo
    addi    $a1, $a1, 8                 # incrementa a coluna
    add     $t3, $zero, $zero           # $t3=0

PrintIntContinue:
    beq     $t0, $zero, PrintIntPop     # se $t0 é zero, nao há mais digitos para imprimir

    div     $t0, $t1                    # divide o valor por 10
    nop
    nop
    mflo    $t0                         # $t0 contem o valor dividido por 10
    mfhi    $t2                         # $t2 contem o ultimo digito a ser impresso
    nop
    nop
    addi    $sp, $sp, -4
    sw      $t2, 0($sp)                 # empilha $t2

    addi    $t3, $t3, 1                 # conta quantos elementos (digitos) estão na pilha
    j       PrintIntContinue            # volta para ser dividido e empilhado de novo

PrintIntPop:
    beq     $t3, $zero, printIntEnd     # ultimo digito endPrintInt

    lw      $a0, 0($sp)                 # le valor da pilha e coloca em $a0
    addi    $sp, $sp, 4
    nop                                 # hazard lw addi
    addi    $a0, $a0, 48                # código ASCII do dígito = numero + 48
    nop
    addi    $sp, $sp, -8                # salva regs
    sw      $t3, 0($sp)
    sw      $ra, 4($sp)

    jal     printChar                   # imprime digito

    lw      $ra, 4($sp)                 # recupera regs
    lw      $t3, 0($sp)
    addi    $sp, $sp, 8

    addi    $a1, $a1, 8                 # incrementa a coluna
    addi    $t3, $t3, -1                # decrementa contador
    j       PrintIntPop                 # volta



#####################################
#  PrintSring                       #
#  $a0    =  endereco da string     #
#  $a1    =  x                      #
#  $a2    =  y                      #
#####################################

printString:
    addi    $sp, $sp, -4                # salva $ra
    sw      $ra, 0($sp)

    move    $t0, $a0                    # $t0=endereco da string

ForPrintString:
    lb      $a0, 0($t0)                 # le em $a0 o caracter a ser impresso

#     move    $k0, $zero                  # contador 4 bytes
# Loop4bytes:
#     slti    $k1, $k0, 4
#     beq     $k1, $zero, Fim4bytes
#
#     andi    $k1, $a0, 0x00FF
    beq     $a0, $zero, EndForPrintString   # string ASCIIZ termina com NULL

    addi    $sp, $sp, -4                # salva $t0
    sw      $t0, 0($sp)
    # sw      $a0, 4($sp)
    # andi    $a0, $a0, 0x00FF

    jal     printChar                   # imprime char

#        lw $a0, 4($sp)
    lw      $t0, 0($sp)                 # recupera $t0
    addi    $sp, $sp, 4


    addi    $a1, $a1, 8                 # incrementa a coluna
    nop
    nop
    slti    $k1, $a1, 313               # 320-8
    nop
    nop
    bne     $k1, $zero, NaoPulaLinha
    addi    $a2, $a2, 8                 # incrementa a linha
    move    $a1, $zero

NaoPulaLinha:
    # srl     $a0, $a0, 8                 # proximo byte
    # addi    $k0, $k0, 1                 #incrementa contador 4 bytes
    # j       Loop4bytes

# Fim4bytes:
#     addi    $t0, $t0, 4                 # Proxima word da memoria
    addi    $t0, $t0, 1
    j       ForPrintString              # loop

EndForPrintString:
    lw      $ra, 0($sp)                 # recupera $ra
    addi    $sp, $sp, 4
    nop
    jr      $ra                         # fim printString


#########################################################
#  PrintChar                                            #
#  $a0 = char(ASCII)                                    #
#  $a1 = x                                              #
#  $a2 = y                                              #
#########################################################
#   $t0 = i                                             #
#   $t1 = j                                             #
#   $t2 = endereco do char na memoria                   #
#   $t3 = metade do char (2a e depois 1a)               #
#   $t4 = endereco para impressao                       #
#   $t5 = background color                              #
#   $t6 = foreground color                              #
#   $t7 = 2                                             #
#########################################################

#printChar:    andi $t5,$a3,0xFF00                # cor fundo
#        andi $t6,$a3,0x00FF                # cor frente
#        srl $t5,$t5,8

         #li $t7, 2                    # iniciando $t7=2
printChar:
    #andi    $t5, $a3, 0xFF00             # cor fundo
    #andi    $t6, $a3, 0x00FF             # cor frente
    li $t5,0
    li $t6,-1
    srl     $t5, $t5, 8

    slti    $t4, $a0, 32
    bne     $t4, $zero, NAOIMPRIMIVEL
    slti    $t4, $a0, 126
    beq     $t4, $zero, NAOIMPRIMIVEL
    j       IMPRIMIVEL
NAOIMPRIMIVEL:
    li      $a0, 32

#        addi $t4, $a2, 0                # t4 = y
#        sll $t4, $t4, 8                    # t4 = 256(y)
IMPRIMIVEL:
    li      $at, NUMCOLUNAS
    mult    $at, $a2
    nop
    nop
    mflo    $t4
    nop
    nop
    add     $t4, $t4, $a1               # t4 = 256(y) + x
    nop
    nop
    addi    $t4, $t4, 7                 # t4 = 256(y) + (x+7)
    la      $t8, VGAADDRESSINI          # Endereco de inicio da memoria VGA
    nop
    nop
    add     $t4, $t4, $t8               # t4 = endereco de impressao do ultimo pixel da primeira linha do char

    addi    $t2, $a0, -32               # indice do char na memoria
    nop
    nop
    sll     $t2, $t2, 3                 # offset em bytes em relacao ao endereco inicial

    la      $t3, kdata
    nop
    nop
    add     $t2, $t2, $t3               # pseudo .kdata
#        addi $t2, $t2, 0x00004b40        # endereco do char na memoria  ###########################################################
    nop
    nop
    lw      $t3, 0($t2)                 # carrega a primeira word do char
    addi    $t0, $zero, 4               # i = 4
    nop
    nop
forChar1I:
    beq     $t0, $zero, endForChar1I    # if(i == 0) end for i
    addi    $t1, $zero, 8               # j = 8
    nop
    nop

    forChar1J:
        beq     $t1, $zero, endForChar1J    # if(j == 0) end for j

#        div $t3, $t7
        andi    $t9, $t3, 0x0001
        srl     $t3, $t3, 1             # t3 = t3/2  ???????????????????
#        mfhi $t9                       # t9 = t3%
        beq     $t9, $zero, printCharPixelbg1
        sb      $t6, 0($t4)             # imprime pixel com cor de frente
        j       endCharPixel1
printCharPixelbg1:
    sb      $t5, 0($t4)                 # imprime pixel com cor de fundo
endCharPixel1:
    addi    $t1, $t1, -1                # j--
    addi    $t4, $t4, -1                # t4 aponta um pixel para a esquerda
    j       forChar1J

endForChar1J:
    addi    $t0, $t0, -1                # i--
    # addi    $t4, $t4, 264               # t4 = t4 + 8 + 256 (t4 aponta para o ultimo pixel da linha de baixo)
    addi    $t4, $t4, 328               # 2**12 + 8
    j       forChar1I

endForChar1I:
    lw      $t3, 4($t2)                 # carrega a segunda word do char

    addi    $t0, $zero, 4               # i = 4
    nop
    nop
forChar2I:
    beq     $t0, $zero, endForChar2I    # if(i == 0) end for i
    addi    $t1, $zero, 8               # j = 8
    nop
    nop
    forChar2J:
        beq     $t1, $zero, endForChar2J    # if(j == 0) end for j

        # div     $t3, $t7
        andi    $t9, $t3, 0x0001
        srl     $t3, $t3, 1                 # t3 = t3/2
        # mfhi    $t9                         # t9 = t3%2
        beq     $t9, $zero, printCharPixelbg2
        sb      $t6, 0($t4)
        j       endCharPixel2

printCharPixelbg2:
    sb      $t5, 0($t4)

endCharPixel2:
    addi    $t1, $t1, -1                # j--
    addi    $t4, $t4, -1                # t4 aponta um pixel para a esquerda
    j       forChar2J

endForChar2J:
    addi    $t0, $t0, -1                # i--
    # addi    $t4, $t4, 264               # t4 = t4 + 8 + 256 (t4 aponta para o ultimo pixel da linha de baixo)
    addi    $t4, $t4, 328
    j       forChar2I

endForChar2I:
    jr $ra



#######################
#  Plot                  #
#  $a0    =  x          #
#  $a1    =  y          #
#  $a2    =  cor        #
#######################
# Obs.: Eh muito mais rapido usar diretamente no codigo!

Plot:
    li      $at, NUMCOLUNAS
    mult    $a1,$at
    nop
    nop
    mflo    $a1
    add     $a0,$a0,$a1
    la      $a1, VGAADDRESSINI          # endereco VGA
    nop
    nop
    or      $a0, $a0, $a1
    sb      $a2, 0($a0)
    jr      $ra


############################
#  GetPlot                 #
#  $a0 = x                 #
#  $a1 = y                 #
#  $a2 = cor               #
############################
# Obs.: Eh muito mais rapido usar diretamente no codigo!

GetPlot:
    li      $at, NUMCOLUNAS
    mult    $a1, $at
    nop
    nop
    mflo    $a1
    add     $a0, $a0, $a1
    la      $a1, VGAADDRESSINI          # endereco VGA
    nop
    nop
    or      $a0, $a0, $a1
    lb      $a2, 0($a0)
    jr      $ra


    
    .data
    s1: .asciiz "Bem vindo ao pac man!"
    s2: .asciiz "Selecione o numero de jogadores: "
    num: .word 1
    .text   
    j main
    
     
      preenchetela:	
	# pinta a tela de preto
 	li $t0,0xff000000
 	li $t1,0xff012c00
 	li $a2,0x00000000
 tela:
 	beq $t0,$t1,saitela
 	sw $a2,0($t0)
 	addi $t0,$t0,4
 	j tela	
saitela: 
 	jr $ra 	 
    main:
    
	jal preenchetela
	la $a0,s1
	li $a1,0
	li $a2,2
	li $v0,104
    	syscall
    	
    	la $a0,s2
	li $a1,0
	li $a2,40
	li $v0,104
    	syscall    	
	
	change_num:
	lw $a0,num
    	li $a1, 270
	li $a2, 40
	li $a3, -1
	li $v0, 101
	syscall #display
		li $v0,12
		syscall 	#read user choice
		move $t0,$v0	#t0= user chiuce		
		if1: 	li $t1,100
			bne $t0,$t1,if2	
										
			lw $t0,num
			li $t1,3
						
			bgt $t0,$t1,bigger_4
			
			addi $t0,$t0,1 #t0++
			sw $t0,num
			j change_num
			bigger_4:
			li $t1,1
			sw $t1,num		
			j change_num			
			
		if2:	move $t0,$v0
			li $t1,97
			bne $t0,$t1,endif
			
			lw $t0,num
			li $t1,2
						
			blt $t0,$t1,smaller_1
			
			addi $t0,$t0,-1 #t0--
			sw $t0,num
			j change_num
			smaller_1:
			li $t1,4
			sw $t1,num		
			j change_num

		endif:	move $t0,$v0
			li $t1,115 	#end choice
			beq $t0,$t1,end_num	
			j change_num
	end_num:
    
