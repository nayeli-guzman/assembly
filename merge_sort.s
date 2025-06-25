.global _start
_start:
	
	MOV R0, #0x4000
	MOV R1, #0 // p
	MOV R2, #5 // r
	
	MOV R3, #5
	STR R3, [R0, #0]
	MOV R3, #3
	STR R3, [R0, #4]
	MOV R3, #0
	STR R3, [R0, #8]
	MOV R3, #10
	STR R3, [R0, #12]
	MOV R3, #1
	STR R3, [R0, #16]
	MOV R3, #2
	STR R3, [R0, #20]
	
	// base address de R, L 
	MOV R11, #0x1000 // R
	MOV R12, #0x2000 // L
	// R3 q
	
	BL MERGE_SORT
	
	B EXIT
	
MERGE:
	PUSH {LR}
	
	SUB R4, R3, R1
	ADD R4, R4, #1  // R4 nl
	
	SUB R5, R2, R3 // R5 nr
	
	MOV R6, #0 // i

FOR_LOOP_1:
	CMP R6, R4
	BGE END_FOR_LOOP_1
	
	LSL R7, R6, #2  //address of i
	ADD R8, R6, R1 // p + i
	LSL R8, R8, #2  // address (p+i)
	
	LDR R9, [R0, R8] // load v[p+i]
	STR R9, [R12, R7] // r[i]
	ADD R6, R6, #1
	B FOR_LOOP_1
END_FOR_LOOP_1:

	MOV R6, #0 // j

FOR_LOOP_2:
	CMP R6, R5
	BGE END_FOR_LOOP_2
	
	LSL R7, R6, #2  //address of j
	ADD R8, R6, R3 // q + j
	ADD R8, R8, #1
	LSL R8, R8, #2  // address (q+j+1)
	
	LDR R9, [R0, R8] // load v[q+j+1]
	STR R9, [R11, R7] // l[j]
	ADD R6, R6, #1
	B FOR_LOOP_2
END_FOR_LOOP_2:
	
	MOV R6, #0 // i
	MOV R7, #0 // j
	MOV R8, R1 // k
	
WHILE:
	
	CMP R6, R4
	BGE END_WHILE
	CMP R7, R5
	BGE END_WHILE
	
	PUSH {R4, R5}

IF:
	LSL R9, R6, #2
	LDR R9, [R12, R9] // l r12 l[i]
	LSL R10, R7, #2
	LDR R10, [R11, R10] // R[j]
	CMP R9, R10
	LSL R4, R8, #2
	
	BGT ELSE
	STR R9, [R0, R4]
	ADD R6, R6, #1
	B END_IF
ELSE:
	STR R10, [R0, R4]
	ADD R7, R7, #1
END_IF:
	ADD R8, R8, #1

	POP {R4, R5}
	
	B WHILE

	
END_WHILE:

	//MOV R6, #0 // i
	//MOV R7, #0 // j
	//MOV R8, R1 // k

WHILE_2:
	
	CMP R6, R4
	BGE END_WHILE_2
	
	LSL R9, R6, #2 // address i
	LDR R9, [R12, R9] // L[i]
	LSL R10, R8, #2 // address k
	STR R9, [R0, R10]
	ADD R8, R8, #1 //k++
	ADD R6, R6, #1 //i++
	B WHILE_2
END_WHILE_2:


WHILE_3:
	
	CMP R7, R5
	BGE END_WHILE_3
	
	LSL R9, R7, #2 // address i
	LDR R9, [R11, R9] // R[i]
	LSL R10, R8, #2 // address k
	STR R9, [R0, R10]
	ADD R8, R8, #1 //k++
	ADD R7, R7, #1 //i++
	B WHILE_3
END_WHILE_3:

END_MERGE:
	
	POP {LR}
	MOV R15, LR
	
	
	
MERGE_SORT:
	
	PUSH {LR}
	
	CMP R1, R2
	BGE END_MERGE_SORT
	
	ADD R3, R1, R2
	LSR R3, R3, #1 //#2
	
	PUSH {R1, R2, R3}
	MOV R2, R3
	BL MERGE_SORT
	POP {R1, R2, R3}
	
	PUSH {R1, R2, R3}
	ADD R1, R3, #1
	BL MERGE_SORT
	POP {R1, R2, R3}
	
	PUSH {R1, R2, R3}
	BL MERGE
	POP {R1, R2, R3}

END_MERGE_SORT:
	
	POP {LR}
	MOV R15, LR

EXIT:
	
