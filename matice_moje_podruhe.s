; **********************************************************************
; * BI-APS Nasobeni matic
; * Autori: xxxxxx xxxxxx
; **********************************************************************

; **** Vstupy ****
 	.data
	.align 2

N:	.word 10

matA:
 	.float	1,	2,	3,	4,	5,25, 5, 16, 15, 6
	.float	6,	7,	8,	9,	10,25, 5, 16, 15, 6
	.float	11,	12,	13,	14,	15,25, 5, 16, 15, 6
	.float	16,	17,	18,	19,	20,25, 5, 16, 15, 6
	.float	21,	22,	23,	24,	25,25, 5, 16, 15, 6
	.float	21,	1,	20,	11,	10,25, 5, 16, 15, 6
	.float	22,	2,	19,	12,	9,25, 5, 16, 15, 6
	.float	23,	3,	18,	13,	8,25, 5, 16, 15, 6
	.float	24,	4,	17,	14,	7,25, 5, 16, 15, 6
	.float	25,	5,	16,	15,	6,25, 5, 16, 15, 6 
matB:
	.float	21,	1,	20,	11,	10,22, 2, 19, 12, 9
	.float	22,	2,	19,	12,	9,22, 2, 19, 12, 9
	.float	23,	3,	18,	13,	8,22, 2, 19, 12, 9
	.float	24,	4,	17,	14,	7,22, 2, 19, 12, 9
	.float	25,	5,	16,	15,	6,22, 2, 19, 12, 9
 	.float	1,	2,	3,	4,	5,22, 2, 19, 12, 9
	.float	6,	7,	8,	9,	10,22, 2, 19, 12, 9
	.float	11,	12,	13,	14,	15,22, 2, 19, 12, 9
	.float	16,	17,	18,	19,	20,22, 2, 19, 12, 9
	.float	21,	22,	23,	24,	25,22, 2, 19, 12, 9

; **** Vystup ****

	;nezapomente zmenit velikost vysledne matice pri zvetsovani N!
matC:	.space 400

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
	; atd... potrebujete-li vice registru, ulozte je.
	subui r29, r29, #16		;aktualizace SP (na zasobnik byly ulozeny 4 ctyrbajtove hodnoty)
	

	;... tady bude vase reseni ....

	lw	r15, N 		; rozmer matice
	lw  r14, N 		; kolikrat probehne cyklus na urovni radku prvni matice
	lw 	r7, N 		; kolikrat probehne cyklus na urovni sloupcu druhe matice
	;lw 	r24, N 		; a ve finale i pro kazdy radek prvni matice

	slli 		r8, r15, 2 	; o kolik se zvetsuje kazdy radek 
	sub 		r9,r8,4 	; 
	mult 		r10, r8, r15
	sub 		r10, r10, r8

	; v nasledujicich 3 krocich provadim modulo 4

	srli 		r11,r15,2 	; r11 ... tolikrat budu muset projit cyklem
	slli		r3,r11,2
	sub 		r24,r15,r3	; r24 = N % 4 ... bude ridici promennou cyklu pro zbytek

Start:	lhi		r1,matA>>16
		add		r1,r1,matA&0xffff ; base adress of matrix A
		lhi		r2,matB>>16
		add		r2,r2,matB&0xffff ; base adress of matrix B
		lhi		r3,matC>>16	
		add		r3,r3,matC&0xffff ; base adress of result matrix

		slli 	r4, r8, 2 		; vynasobit 4 a pak odecist r8 (jeden cely radek) 
		subu 	r4, r4, r8 		; 
;---------------------------------------------------------------------------------------------
		Final:
		subui 	r11, r11, 1
;---------------------------------------------------------------------------------------------

				VnejsiCyklus:
					subui 	r7, r7, 1
;---------------------------------------------------------------------------------------------
					
							VnitrniCyklus:
								subui 	r14, r14, 1 	; ridici promenna ... N
								lf 		f1, (r1)
								addu 	r1, r1, r8
								lf 		f2, (r1);
								addu 	r1, r1, r8
								lf 		f3, (r1);
								addu 	r1, r1, r8
								lf 		f4, (r1);

								lf 		f9, (r2)

								multf 	f10, f1, f9
								multf 	f11, f2, f9
								multf 	f12, f3, f9
								multf 	f13, f4, f9
								
								addf	f21,f21,f10		; scitani uz vynasobenych clenu
								addf	f22,f22,f11		; scitani uz vynasobenych clenu
								addf	f23,f23,f12		; scitani uz vynasobenych clenu
								addf	f24,f24,f13		; scitani uz vynasobenych clenu
								 

								subu 	r1,r1,r4


								addui 	r1, r1, 4 		; pohyb v poli o 1 vpravo
								addui	r25,r25, 4 		; na konci cyklu odectu od r1 a vratim se tam, kde jsem zacal
								
								addu 	r2, r2, r8		; pohyb v poli o 1 dolu
								addu	r12,r12, r8		; na konci cyklu odectu od r2 a vratim se tam, kde jsem zacal
							bnez 	r14, VnitrniCyklus
;---------------------------------------------------------------------------------------------

					lw 		r14, N 			; "vynuluju promennou"
			
					sf		(r3), f21		; ulozeni do pameti
					addu 	r3, r3, r8
					subf 	f21,f21,f21		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo

					sf		(r3), f22		; ulozeni do pameti
					addu 	r3, r3, r8
					subf 	f22,f22,f22		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo
					
					sf		(r3), f23		; ulozeni do pameti
					addu 	r3, r3, r8
					subf 	f23,f23,f23		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo
					
					sf		(r3), f24		; ulozeni do pameti
					subf 	f24,f24,f24		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo
					
					subu 	r3, r3, r4

					addui	r3, r3, 4 		; posouvame se ve vysledne matici o 1 misto dal
			
					subu 	r2, r2, r12		; posouvam se zpatky
					subu 	r1, r1, r25		; posouvam se zpatky
			
					addui 	r2, r2, 4 		; v druhe matici se posouvame o sloupec dal
			
					;subf 	f10,f10,f10		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo
					
					
					subu 	r25,r25,r25		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo
					subu 	r12,r12,r12		; tyto pomocne promenne se vynulovat, abychom ve finale nesahali mimo
		
				bnez 	r7, VnejsiCyklus
;---------------------------------------------------------------------------------------------
		lw 		r7, N 			; "vynuluju promennou"
		slli 	r13, r8,2
		addu 	r3, r3, r13			; pridano
		addu 	r1, r1, r13 		; v prvni matici se posouvame o 4 radky dal
		sub 	r2, r2, r8
		subu 	r3, r3, r8			; pridano
		bnez 	r11, Final
;---------------------------------------------------------------------------------------------
Zbytek:
	subui 	r24, r24, 1 	; ridici promenna ... N
;------------------------------------------------
	Zbytek_radek:
		subui 	r7, r7, 1
;------------------------------------------------
			Zbytek_sloupec:
				subui 	r14, r14, 1
					lf 		f1, (r1)
					lf 		f9, (r2)
					addui 	r1, r1, 4 		; pohyb v poli o 1 vpravo
					multf 	f10, f1, f9
					addui	r25,r25, 4 		; na konci cyklu odectu od r1 a vratim se tam, kde jsem zacal
		
					addu 	r2, r2, r8		; pohyb v poli o 1 dolu
					addu	r12,r12, r8		; na konci cyklu odectu od r2 a vratim se tam, kde jsem zacal
					
					addf	f21,f21,f10		; scitani uz vynasobenych clenu
					
					
			bnez 	r14, Zbytek_sloupec
;------------------------------------------------
		lw 		r14, N
		subu 	r1, r1, r25

		sf		(r3), f21		; ulozeni do pameti
		addui	r3, r3, 4 		; posouvame se ve vysledne matici o 1 misto dal
		

		subu 	r2, r2, r12

		subf 	f21, f21, f21
		subu 	r12, r12, r12
		subu 	r25, r25, r25
		

		addui 	r2, r2, 4
	bnez 	r7, Zbytek_radek
;------------------------------------------------
	addu 	r1, r1, r8

	subu 	r2, r2, r8

	lw 		r7, N

	bnez 	r24, Zbytek


;---------------------------------------------------------------------------------------------

	
	
	;obnoveni registru
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
