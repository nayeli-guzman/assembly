.global _start
_start:

	MOV R0, #31 //dividendo
	MOV R1, #7 // divisor
	
	BL DIVISION_RECURSIVE
	B END
	
DIVISION_RECURSIVE:
	PUSH {LR}
	
	CMP R1, #0
	BEQ CASE_BASE
	CMP R0, R1
	BLT CASE_BASE
	SUB R2, R0, R1
	
	PUSH {R0, R1}
	MOV R0, R2 // NUEVO DIVIDENDO
	
	BL DIVISION_RECURSIVE
	
	MOV R3, R0 // COCIENTE_P
	MOV R4, R1 // RESTO_P
	
	POP {R0, R1}
	
	ADD R3, R3, #1
	
	MOV R0, R3
	MOV R1, R4
	B RETURN
	

CASE_BASE:
	MOV R1, R0
	MOV R0, #0
	
RETURN:
	POP {LR}
	MOV PC, LR
	
END:
	



/*

pii division_recursive(int dividendo, int divisor) {
    if(divisor==0) return {0, dividendo};
    if (dividendo<divisor) return {0, dividendo};
    else {
        int nuevo_dividendo = dividendo - divisor;
        auto [cociente_p, resto_p ]= division_recursive(nuevo_dividendo, divisor);
        return {cociente_p+1, resto_p};
    }
}

*/
	

