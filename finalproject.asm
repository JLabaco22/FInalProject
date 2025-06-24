.data
teamPrompt:    .asciiz "Choose your team: 1 for Cavs, 2 for Warriors: "
cavsSelec:       .asciiz "You chose the Cleveland Cavaliers.\n"
warriorsSelec:   .asciiz "You chose the Golden State Warriors.\n"
invalidTeam:   .asciiz "Invalid team selection. Enter 1 or 2.\n"

prompt:         .asciiz "Shoot the ball! Enter 2 for a 2-pointer or 3 for a 3-pointer: "
invalid:        .asciiz "Invalid shot! Only 2 or 3 is allowed.\n"
scored2:        .asciiz "Clean! You made a 2-pointer!\n"
scored3:        .asciiz "NICE! You made a 3-pointer!\n"
current:        .asciiz "Current score: "
win:            .asciiz "You hit 21! You win!\n"
lose:           .asciiz "Over 21! You lose!\n"

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
   

warriorsSelected:
    li $v0, 4
    la $a0, warriorsSelec
    syscall
  
