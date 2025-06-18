.global _start
_start:

	MOV R0, #0x40000 // BASE ADDRESS
	MOV R1, #8    // arraysize
	// {4, 6, 3, 2, 9}
	MOV R3, #4
	STR R3, [R0]
	MOV R3, #10
	STR R3, [R0, #4]
	MOV R3, #3
	STR R3, [R0, #8]
	MOV R3, #2
	STR R3, [R0, #12]
	MOV R3, #11
	STR R3, [R0, #16]
	MOV R3, #19
	STR R3, [R0, #20]
	MOV R3, #8
	STR R3, [R0, #24]
	MOV R3, #1
	STR R3, [R0, #28]

HEAPSORT:
	BL BUILD_MAX_HEAP
	SUB R3, R1, #1
FOR_LOOP:
	CMP R3, #0
	BLT END_FOR_LOOP
	
	LSL R4, R3, #2
	LDR R5, [R0, R4] //R4 = v[i]
	LDR R6, [R0] // R5 = v[0]
	
	STR R5, [R0]
	STR R6, [R0, R4] // V[I]=V[0]
	
	SUB R1, R1, #1
	
	MOV R2, #0
	PUSH {R3}
	BL MAX_HEAPIFY
	POP {R3}
	SUB R3, R3, #1
	B FOR_LOOP
	
	
	// R2 = i // head
MAX_HEAPIFY:
	PUSH {LR}
	MOV R3, R2 // LARGEST
	LSL R8, R2, #1 // i*2
	ADD R8, R8, #1 // 2*i+1
	MOV R4, R8 // R4 = left
	ADD R8, R8, #1
	MOV R5, R8 // R5 = right
	
	LSL R8, R2, #2 // i*4
	LDR R6, [R0, R8] // R6 = V[i]
	LSL R8, R4, #2 // left*4
	LDR R7, [R0, R8] // R7 = V[left]
	LSL R8, R5, #2 // right*4
	LDR R8, [R0, R8] // R8 = V[right]
	
	CMP R4, R1 // SI LEFT >= N
	BGE IGNORE_1
	CMP R6, R7 // V[i] >= v[left]
	BGE IGNORE_1
	MOV R3, R4 // largest = left
	
IGNORE_1:
	
	LSL R12, R3, #2 // largest*4
	LDR R9, [R0, R12] // R9 = V[largest]

	CMP R5, R1 // SI RIGHT >= N
	BGE IGNORE_2
	CMP R9, R8 // V[LARGEST] >= v[r]
	BGE IGNORE_2
	MOV R3, R5 // largest = right
	
IGNORE_2:
	
	CMP R3, R2
	BEQ IGNORE_3
	
	LSL R12, R3, #2 // largest*4
	LDR R9, [R0, R12] // R9 = V[largest]
	LSL R11, R2, #2 // i*4
	
	STR R6, [R0, R12]
	STR R9, [R0, R11]
	
	MOV R2, R3 // i = largest
	
	BL MAX_HEAPIFY
	POP {LR}
	MOV PC, LR
	
IGNORE_3:
	POP {LR}
	MOV PC, LR
	


BUILD_MAX_HEAP:
	PUSH {LR}
	LSR R2, R1, #1 // i

FOR_LOOP_1:
	CMP R2, #0; // I<0
	BLT END_FOR_LOOP_1
	PUSH {R2}
	BL MAX_HEAPIFY
	POP {R2}
	SUB R2, R2, #1
	B FOR_LOOP_1
END_FOR_LOOP_1:
	POP {LR}
	MOV PC, LR

END_FOR_LOOP:
