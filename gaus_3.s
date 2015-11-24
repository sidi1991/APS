; **********************************************************************
; * BI-APS Nasobeni matic
; * Autori: xxxxxx xxxxxx
; **********************************************************************

; **** Vstupy ****
 	.data
	.align 2

N:	.word 5

matA:
 	.float	2,2,3,4,5,7
	.float	7,9,9,10,11,14
	.float	13,14,16,16,17,21
	.float	19,20,21,23,23,28
	.float	25,26,27,28,30,35

; **** Zasobnik, pomocne promenne

stack: .space 4096


; **********************************************************************
; Program
	.text

start:
	;nastaveni zasobniku
	lhi 	r29, (stack+4092) >> 16
	addui 	r29, r29, (stack+4092) & 0xffff
	
	;ulozeni registru, ktere musim zachovat, na zasobnik
	sw -4(r29), r4
	sf -8(r29), f2
	sf -12(r29), f3
	sf -16(r29), f4
	sw -20(r29), r7
	sf -24(r29), f1 
	sf -28(r29), f2 
	sf -32(r29), f3 
	sf -36(r29), f4         
	sf -40(r29), f9 
	sf -44(r29), f10 
	sf -48(r29), f11 
	sf -52(r29), f12 
	sf -56(r29), f13               
	sf -60(r29), f21 
	sf -64(r29), f22 
	sf -68(r29), f23 
	sf -72(r29), f24
	sw -76(r29), r6
	; atd... potrebujete-li vice registru, ulozte je.
	subui r29, r29, #16		;aktualizace SP (na zasobnik byly ulozeny 4 ctyrbajtove hodnoty)

;---------------------------------------------------------------------------------------------
; Used variables:
; r1 - pointer to matrix
; r2 - top line - we will subtract this line from line below
; r6 - matrix size + 1 (CONST)
; r7, r15, r16 - for cyclus control variable
; r8 - r6 * 4 => used for moving to next line
; r17 - counting iterations of second for cycle (is used for computing of value in r18)
; r18 - control variable - diagonal movement across matrix
; f1 - divisor
; f2 - divident
; f3 - result
; f4 - 
;---------------------------------------------------------------------------------------------
; PROGRAM
;---------------------------------------------------------------------------------------------
	lw	r15, N 		; rozmer matice
	lw  r14, N 		; kolikrat probehne cyklus na urovni radku matice
	lw 	r7, N 		; kolikrat probehne cyklus na urovni sloupcu matice - 1
	lw 	r6, N 		; kolikrat probehne cyklus na urovni sloupcu matice - 1
	addi r7, r7, 1  ; kolikrat probehne cyklus na urovni sloupcu matice
	lw r17, 0 		; pomocna promenna, ktera pocita pruchod druhym cyklem a pouzijeme pro vypocet posuvu v matici
	lw r20, 0 		; pomocna promenna, ktera pocita pruchod prvnim cyklem a pouzijeme pro vypocet posuvu v matici
	addi  r6, r6, 1 ;
	slli   r8, r6, 2

	lhi	r1,matA>>16
	add	r1,r1,matA&0xffff ; base adress of matrix A
	lhi	r2,matA>>16
	add	r2,r2,matA&0xffff ; base adress of matrix A

	


;---------------------------------------------------------------------------------------------

	;obnoveni registru
	lw r6,  -76(r29)
	lf f24, -72(r29)
	lf f23, -68(r29) 
	lf f22, -64(r29) 
	lf f21, -60(r29) 
	lf f13, -56(r29)               
	lf f12, -52(r29) 
	lf f11, -48(r29) 
	lf f10, -44(r29) 
	lf f9, -40(r29) 
	lf f4, -36(r29)         
	lf f3, -32(r29) 
	lf f2, -28(r29) 
	lf f1, -24(r29) 
	lw r7, -20(r29)
	lf f4, -16(r29)
	lf f3, -12(r29)
	lf f2, -8(r29)
	lw r4, -4(r29)
	addui r29, r29, #16		;aktualizace SP, ze zasobniku vyzvednuty 4x 4B hodnoty
	
	trap #0					;konec programu