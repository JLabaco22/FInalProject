.data
teamPrompt:     .asciiz "\n Choose your team:\n  1 - Cleveland Cavaliers\n  2 - Golden State Warriors\nYour choice: "
cavsSelec:      .asciiz "\nYou chose the Cleveland Cavaliers!\n"
warriorsSelec:  .asciiz "\nYou chose the Golden State Warriors!\n"
invalidTeam:    .asciiz "Invalid team selection.enter 1 or 2.\n"

prompt:         .asciiz "\n Take your shot! Enter 2 for a 2-pointer or 3 for a 3-pointer: "
invalid:        .asciiz " Invalid Only 2 or 3 is allowed.\n"
scored2:        .asciiz " BOOM You made a 2-pointer!\n"
scored3:        .asciiz " SWISH You made a 3-pointer!\n"
shotMissMsg:    .asciiz " Missed the shot \n"
current:        .asciiz "Current score: "
win:            .asciiz "\n You hit 21! You win :D \n"
lose:           .asciiz "\n Over 21! You lose :(\n"


.text
.globl main
main:
teamSelect:
    li $v0, 4
    la $a0, teamPrompt
    syscall

    li $v0, 5
    syscall
    move $t3, $v0          

    li $t4, 1
    beq $t3, $t4, cavsSelected

    li $t4, 2
    beq $t3, $t4, warriorsSelected

    li $v0, 4
    la $a0, invalidTeam
    syscall
    j teamSelect

cavsSelected:
    li $v0, 4
    la $a0, cavsSelec
    syscall
    j startGame

warriorsSelected:
    li $v0, 4
    la $a0, warriorsSelec
    syscall
    j startGame

startGame:
    li $t0, 0               

gameLoop:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t1, $v0          

    li $t2, 2
    beq $t1, $t2, try2Pointer

    li $t2, 3
    beq $t1, $t2, try3Pointer

    li $v0, 4
    la $a0, invalid
    syscall
    j gameLoop

try2Pointer:
    li $a1, 4               
    li $v0, 42           
    syscall
    move $t5, $a0          

    li $t6, 3               
    beq $t5, $t6, missedShot

    li $v0, 4
    la $a0, scored2
    syscall
    addi $t0, $t0, 2
    j checkScore

try3Pointer:
    li $a1, 4
    li $v0, 42
    syscall
    move $t5, $a0

    li $t6, 2
    beq $t5, $t6, missedShot
    li $t6, 3
    beq $t5, $t6, missedShot

    li $v0, 4
    la $a0, scored3
    syscall
    addi $t0, $t0, 3
    j checkScore

missedShot:
    li $v0, 4
    la $a0, shotMissMsg
    syscall
    j checkScore

checkScore:
    li $v0, 4
    la $a0, current
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $t2, 21
    beq $t0, $t2, winGame
    bgt $t0, $t2, loseGame

    j gameLoop

winGame:
    li $v0, 4
    la $a0, win
    syscall
    j endGame

loseGame:
    li $v0, 4
    la $a0, lose
    syscall

endGame:
    li $v0, 10
    syscall

