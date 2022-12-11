b 28
xor $4,$4             
xor $5,$5
add $4, $2
add $5, $3
xor $6,$6
add $6,$5
bz $4, 26         
xor $6,$6
add $6,$4
bz $5, 26         
xor $7,$7
add $7,$4
comp $8,$5
add $7,$8        
comp $7,$7
bltz $7, 23        
comp $8,$4
add $5,$8 
b 10
comp $8,$5
add $4,$8
b 10
add $1,$6
br $31
xor $1,$1
xor $2,$2
xor $3,$3
addi $2, 7
addi $3, 9
bl 4

