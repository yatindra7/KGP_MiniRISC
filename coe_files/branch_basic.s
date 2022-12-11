addi $1, 3
addi $2, 5
add $2, $1
add $1, $2
add $1, -1
sw $1, 0($2)
lw $3, 0($2)
bncy 1

