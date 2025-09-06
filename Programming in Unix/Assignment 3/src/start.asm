.section .data
msg: .asciz "Snake starting Length is greater than 9. Enter a number between 2 and 10\n"
snakelen: .int 0
apple: .int 0

.section .bss

.section .text
.globl start_game

start_game:
    push %rbp
    mov %rsp, %rbp

    movl %edi, snakelen
    movl %esi, apple

    cmpl $10 ,%edi
    jl moveon
    movq $15, %rdi
    movq $15, %rsi
    leaq msg, %rdx
    call board_put_str

    movq $5000000, %rdi
    call usleep

    jmp endgame
moveon: 
    movl snakelen, %edi
    movl apple, %esi
    
    call snake_game
    endgame:
    pop %rbp
    ret
