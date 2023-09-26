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
resultMsg: .asciiz "Your result was: "
varA: .word 0
varB: .word 0
resultVar: .word 0

.text

main:
	
	jal sumFunction
	jal printNewLine
	jal subFunction
	jal printNewLine
	jal mtplyFunction
	jal printNewLine
	jal powFunction
	jal printNewLine
	jal factFunction
	j end
	
	
sumFunction:
	
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

subFunction:
	
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
	
mtplyFunction:
	
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
	
	
push:
	
	sw $ra, 0($sp)
	add $sp, $sp, -4
	jr $t1

pop:

	add $sp, $sp, 4
	lw $ra, 0($sp)
	jr $t1
	
printNewLine:
	li $v0, 11  # syscall 11: print a character based on its ASCII value
   	li $a0, 10  # ASCII value of a newline is "10"
    	syscall
	jr $ra

end: 
	li $v0, 10
	syscall
	

	
	
	
	
