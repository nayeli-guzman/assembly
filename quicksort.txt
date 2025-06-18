.global _start
_start:

	MOV R0, #0x40000 // BASE ADDRESS
	MOV R1, #8    // arraysize
	// {4, 6, 3, 2, 9}
	MOV R3, #3
	STR R3, [R0]
	MOV R3, #1
	STR R3, [R0, #4]
	MOV R3, #9
	STR R3, [R0, #8]
	MOV R3, #8
	STR R3, [R0, #12]
	MOV R3, #17
	STR R3, [R0, #16]
	MOV R3, #2
	STR R3, [R0, #20]
	MOV R3, #14
	STR R3, [R0, #24]
	MOV R3, #50
	STR R3, [R0, #28]
	
	MOV R0, #0x40000 // BASE ADDRESS
	MOV R1, #0  // P
	MOV R2, #7  // R
	MOV R3, R2  // Q
	// r5 el i que retorna partition
	BL QUICKSORT
	B END

PARTITION:
	LSL R4, R2, #2
	LDR R4, [R0, R4] // x, A[r]
	SUB R5, R1, #1   // i
	MOV R6, R1     // j
FOR:
	CMP R6, R2
	BGE END_FOR_LOOP
	LSL R7, R6, #2  // adress j
	LDR R8, [R0, R7] //A[j]
	CMP R8, R4
	BGT IGNORE_2
	ADD R5, R5, #1
	LSL R9, r5, #2 // address i
	LDR R10, [R0, R9] //A[i]
	STR R10, [R0, R7]
	STR R8, [R0, R9]
IGNORE_2:
	ADD R6, R6, #1
	B FOR
END_FOR_LOOP:
	ADD R5, R5, #1 // i+1
	LSL R7, R5, #2  // address i+1
	LSL R8, R2, #2 // adress r
	LDR R9, [R0, R7] // A[i]
	LDR R10, [R0, R8] // A[r]
	STR R9, [R0, R8] 
	STR R10, [R0, R7]
	
	MOV PC, LR
	
END_PARTITION:
	
	

	
QUICKSORT:

	PUSH {LR}

	CMP R1, R2
	BGE IGNORE_1
	PUSH {R1, R2}
	BL PARTITION
	POP {R1, R2}
	MOV R3, R5
	
	PUSH {R1, R2, R3}
	SUB R2, R3, #1
	BL QUICKSORT
	POP {R1, R2, R3}
	
	PUSH {R1, R2, R3}
	ADD R1, R3, #1
	BL QUICKSORT
	POP {R1, R2, R3}

IGNORE_1:
	POP {LR}
	MOV PC, LR
	
END:
