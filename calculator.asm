# Assembly code for a calculator
# Functions
# Integer Sum (Gets 2 integers)
# Integer Subtract (Gets 2 integers)
# Integer Multiply (Gets 2 integers)
# Factorial (Gets 1 integer)
# Raise Integer to power of N (2 integers)
# Author Iago Gouveia Gurgel

.data

getValuesMsg: .asciiz "Write a number: " 
resultMsg: .asciiz    "Your result was: "
sumWelcome: .asciiz   "This is Sum Function"
subWelcome: .asciiz   "This is Subtract Function"
mulWelcome: .asciiz   "This is Multiply Function"
powWelcome: .asciiz   "This is Power Function"
factWelcome: .asciiz  "This is Factorial Function"

calcWelcome: .asciiz  "Calculator Menu"
selOptMsg: .asciiz    "Select your option below: "

sumOption: .asciiz    "0 - Sum"
subOption: .asciiz    "1 - Subtract"
mulOption: .asciiz    "2 - Multiply"
powOption: .asciiz    "3 - Power Function"
factOption: .asciiz   "4 - Factorial"
endOption: .asciiz    "5 - End Program"


varA: .word 0
varB: .word 0
resultVar: .word 0

.text
.globl Start
.globl end
.globl mainMenu

Start:
	
	j mainMenu
	
	
mainMenu:

	jal printNewLine
	la $a0, calcWelcome
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, selOptMsg
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, sumOption
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, subOption
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, mulOption
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, powOption
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, factOption
	li $v0, 4
	syscall
	jal printNewLine
	
	la $a0, endOption
	li $v0, 4
	syscall
	jal printNewLine
	
	jal getVariableA
	move $t0, $v0
	beq $t0, 0, sumJmpLink
	beq $t0, 1, subJmpLink
	beq $t0, 2, mulJmpLink
	beq $t0, 3, powJmpLink
	beq $t0, 4, factJmpLink
	beq $t0, 5, end
	
	j end
	
sumJmpLink:
	jal sumFunction
	li $v0, 12
	syscall
	j mainMenu
	
subJmpLink:
	jal subFunction
	li $v0, 12
	syscall
	j mainMenu
	
mulJmpLink:
	jal mulFunction
	li $v0, 12
	syscall
	j mainMenu
	
powJmpLink:
	jal powFunction
	li $v0, 12
	syscall
	j mainMenu
	
factJmpLink:
	jal factFunction
	li $v0, 12
	syscall
	j mainMenu

sumFunction:
	
	la $a0, sumWelcome
	li $v0, 4
	syscall
	
	
	la $t7, push
	jalr $t1, $t7 
	jal printNewLine
	la $t7, pop
	jalr $t1, $t7
	
	la $t7, push
	jalr $t1, $t7 
	jal getVariableA
	jal getVariableB
	lw $t0, varA
	lw $t1, varB
	add $s0, $t0, $t1
	sw $s0, resultVar
	jal printResult
	la $t7, pop
	jalr $t1, $t7
	jr $ra

subFunction:
	
	
	la $a0, subWelcome
	li $v0, 4
	syscall
	
	
	la $t7, push
	jalr $t1, $t7 
	jal printNewLine
	la $t7, pop
	jalr $t1, $t7
	
	
	la $t7, push
	jalr $t1, $t7
	jal getVariableA
	jal getVariableB
	lw $t0, varA
	lw $t1, varB
	sub $s0, $t0, $t1
	sw $s0, resultVar
	jal printResult
	la $t7, pop
	jalr $t1, $t7
	jr $ra
	
mulFunction:
	
	
	la $a0, mulWelcome
	li $v0, 4
	syscall
	
	
	la $t7, push
	jalr $t1, $t7 
	jal printNewLine
	la $t7, pop
	jalr $t1, $t7
	
	
	la $t7, push
	jalr $t1, $t7
	jal getVariableA
	jal getVariableB
	lw $t0, varA
	lw $t1, varB
	mul $s0, $t0, $t1
	sw $s0, resultVar
	jal printResult
	la $t7, pop
	jalr $t1, $t7
	jr $ra
	
powFunction:
	
	
	la $a0, powWelcome
	li $v0, 4
	syscall
	
	
	la $t7, push
	jalr $t1, $t7 
	jal printNewLine
	la $t7, pop
	jalr $t1, $t7
	
	
	la $t7, push
	jalr $t1, $t7
	jal getVariableA
	jal getVariableB
	jal powMath
	sw $s0, resultVar
	jal printResult
	la $t7, pop
	jalr $t1, $t7
	jr $ra

powMath:
	lw $t0, varA
	lw $t1, varB
	li $t2, 1
	move $s0, $t0
	j powLoop

powLoop:
	beq $t1, $t2, endPow
	mul $s0, $s0, $t0
	addi $t1, $t1, -1
	j powLoop
	
endPow:
	jr $ra
	

factFunction:
	
	la $a0, factWelcome
	li $v0, 4
	syscall
	
	
	la $t7, push
	jalr $t1, $t7 
	jal printNewLine
	la $t7, pop
	jalr $t1, $t7
	
	
	la $t7, push
	jalr $t1, $t7
	jal getVariableA
	lw $t0, varA
	jal factMath
	sw $s0, resultVar
	jal printResult
	la $t7, pop
	jalr $t1, $t7
	jr $ra
	
factMath:
	lw $t0, varA
	li $t2, 1
	move $s0, $t0
	j factLoop

factLoop:
	
	beq $t0, $t2, endFact
	addi $t0, $t0, -1
	mul $s0, $s0, $t0
	j factLoop
	
endFact:
	jr $ra
	
			
getVariableA:

	la $a0, getValuesMsg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, varA
	jr $ra
	
getVariableB:
	
	la $a0, getValuesMsg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, varB
	jr $ra
	
printResult:
	
	lw $t0, resultVar
	la $a0, resultMsg
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	jr $ra
	
push:
	
	add $sp, $sp, -4
	sw $ra, 0($sp)
	jr $t1

pop:
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $t1
	
printNewLine:
	li $v0, 11  # syscall 11: print a character based on its ASCII value
   	li $a0, 10  # ASCII value of a newline is "10"
    	syscall
	jr $ra

end: 
	li $v0, 10
	syscall
	

	
	
	
	
