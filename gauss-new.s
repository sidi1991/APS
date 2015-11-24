; for the benefit of gcc.
.text
Start:
	lhi	r29,((_stack + 4092)>>16)&0xffff
	addui	r29,r29,(_stack + 4092)&0xffff
	jal	_main        
	nop

;
; DLX traps and other support functions.
;
; Aaron Sawdey 1994,1995; released to the Public Domain.
;
.text
_trap_exit:		
	trap	#0
	jr	r31
	nop

_trap_open:		
	trap	#1
	jr	r31
	nop

_trap_close:		
	trap	#2
	jr	r31
	nop

_trap_read:		
	trap	#3
	jr	r31
	nop

_trap_write:		
	trap	#4
	jr	r31
	nop

_trap_printf:		
	trap	#5
	jr	r31
	nop

_trap_lseek:		
	trap	#6
	jr	r31
	nop

_trap_random:		
	trap	#7
	jr	r31
	nop

_barrier:		
	trap	#8
	jr	r31
	nop

_trap_tell:		
	trap	#9
	jr	r31
	nop

_trap_isatty:		
	trap	#10
	jr	r31
	nop

_trap_access:		
	trap	#11
	jr	r31
	nop

_fork:		
	trap	#13
	jr	r31
	nop

_join:		
	trap	#14
	jr	r31
	nop

_trap_srandom:		
	trap	#15
	jr	r31
	nop

;
; Math related traps.
;

_trap_cos:
        trap 	#20
	jr	r31
	nop

_trap_acos:
        trap 	#21
	jr	r31
	nop

_trap_sin:
        trap 	#22
	jr	r31
	nop

_trap_asin:
        trap 	#23
	jr	r31
	nop

_trap_tan:
        trap 	#24
	jr	r31
	nop

_trap_atan:
        trap 	#25
	jr	r31
	nop

_trap_log10:
        trap 	#26
	jr	r31
	nop

_trap_log:
        trap 	#27
	jr	r31
	nop

_trap_exp:
        trap 	#28
	jr	r31
	nop

_trap_sqrt:		
	trap	#29
	jr	r31
	nop

_trap_pow:
        trap 	#30
	jr	r31
	nop

; for the benefit of gcc.
___main:
        nop
	jr	r31
	nop

.data
.align 2
_stack:
.space 4096

;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
_exit:		
	trap	#0
	jr	r31
	nop

;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
_printf:		
	trap	#5
	jr	r31
	nop

;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
_srandom:		
	trap	#15
	jr	r31
	nop


;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
_cos:
        trap 	#20
	jr	r31
	nop

_acos:
        trap 	#21
	jr	r31
	nop

_sin:
        trap 	#22
	jr	r31
	nop

_asin:
        trap 	#23
	jr	r31
	nop

_tan:
        trap 	#24
	jr	r31
	nop

_atan:
        trap 	#25
	jr	r31
	nop

_log10:
        trap 	#26
	jr	r31
	nop

_log:
        trap 	#27
	jr	r31
	nop

_exp:
        trap 	#28
	jr	r31
	nop

_sqrt:		
	trap	#29
	jr	r31
	nop

_pow:
        trap 	#30
	jr	r31
	nop


;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
_random:		
	trap	#7
	jr	r31
	nop

;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
_write:		
	trap	#4
	jr	r31
	nop

.text
_lseek:		
	trap	#6
	jr	r31
	nop

.text
_tell:		
	trap	#9
	jr	r31
	nop


.text
_isatty:		
	trap	#10
	jr	r31
	nop


.text
_access:		
	trap	#11
	jr	r31
	nop

.text
	.align 3
LC0:
	.word	0
	.word	4611686018427387904
	.word	0
	.word	4611686018427387904
	.word	0
	.word	4613937818241073152
	.word	0
	.word	4616189618054758400
	.word	0
	.word	4617315517961601024
	.word	0
	.word	4619567317775286272
	.word	0
	.word	4619567317775286272
	.word	0
	.word	4621256167635550208
	.word	0
	.word	4621256167635550208
	.word	0
	.word	4621819117588971520
	.word	0
	.word	4622382067542392832
	.word	0
	.word	4624070917402656768
	.word	0
	.word	4623507967449235456
	.word	0
	.word	4624070917402656768
	.word	0
	.word	4625196817309499392
	.word	0
	.word	4625196817309499392
	.word	0
	.word	4625478292286210048
	.word	0
	.word	4626604192193052672
	.word	0
	.word	4626041242239631360
	.word	0
	.word	4626322717216342016
	.word	0
	.word	4626604192193052672
	.word	0
	.word	4627167142146473984
	.word	0
	.word	4627167142146473984
	.word	0
	.word	4628574517030027264
	.word	0
	.word	4627730092099895296
	.word	0
	.word	4628011567076605952
	.word	0
	.word	4628293042053316608
	.word	0
	.word	4628574517030027264
	.word	0
	.word	4629137466983448576
	.word	0
	.word	4630122629401935872
	.align 2
_main:
;  Function 'main'; 272 bytes of locals, 0 regs to save.
	sw	-4(r29),r30	; push fp
	add	r30,r0,r29	; fp = sp
	sw	-8(r29),r31	; push ret addr
	subui	r29,r29,#280	; alloc local storage
	jal	___main
	lhi	r1,((LC0)>>16)&0xffff
	addui	r1,r1,(LC0)&0xffff
	addi	r3,r30,#-248
	addi	r2,r0,#240
	addi	r29,r29,#-16
	sw	(r29),r1
	sw	4(r29),r3
	sw	8(r29),r2
	jal	_bcopy
	addi	r29,r29,#16
	addi	r1,r0,#5
	sw	-260(r30),r1
	addi	r1,r0,#0
	sw	-264(r30),r1
L2:
	lw	r1,-264(r30)
	lw	r2,-260(r30)
	slt	r1,r1,r2
	bnez	r1,L5
	j	L3
L5:
	addi	r1,r0,#0
	sw	-268(r30),r1
L6:
	lw	r1,-268(r30)
	lw	r2,-260(r30)
	slt	r1,r1,r2
	bnez	r1,L9
	j	L4
L9:
	lw	r1,-268(r30)
	lw	r2,-264(r30)
	sle	r1,r1,r2
	bnez	r1,L8
	lw	r2,-268(r30)
	add	r1,r0,r2
	slli	r1,r1,#0x1
	add	r1,r1,r2
	slli	r2,r1,#0x1
	lw	r1,-264(r30)
	add	r2,r2,r1
	addi	r1,r0,#8
	mult	r2,r2,r1
	addi	r1,r30,#-8
	add	r1,r2,r1
	addi	r3,r1,#-240
	lw	r2,-264(r30)
	add	r1,r0,r2
	slli	r1,r1,#0x3
	sub	r1,r1,r2
	slli	r2,r1,#0x3
	addi	r1,r30,#-8
	add	r1,r2,r1
	addi	r1,r1,#-240
	ld	f2,(r3)
	ld	f0,(r1)
	divd	f0,f2,f0
	sd	-280(r30),f0
	addi	r1,r0,#0
	sw	-272(r30),r1
L11:
	lw	r1,-272(r30)
	lw	r2,-260(r30)
	sle	r1,r1,r2
	bnez	r1,L14
	j	L8
L14:
	lw	r2,-264(r30)
	add	r1,r0,r2
	slli	r1,r1,#0x1
	add	r1,r1,r2
	slli	r2,r1,#0x1
	lw	r1,-272(r30)
	add	r2,r2,r1
	addi	r1,r0,#8
	mult	r2,r2,r1
	addi	r1,r30,#-8
	add	r1,r2,r1
	addi	r1,r1,#-240
	ld	f2,-280(r30)
	ld	f0,(r1)
	multd	f0,f2,f0
	sd	-256(r30),f0
	lw	r2,-268(r30)
	add	r1,r0,r2
	slli	r1,r1,#0x1
	add	r1,r1,r2
	slli	r2,r1,#0x1
	lw	r1,-272(r30)
	add	r2,r2,r1
	addi	r1,r0,#8
	mult	r2,r2,r1
	addi	r1,r30,#-8
	add	r1,r2,r1
	addi	r4,r1,#-240
	lw	r2,-268(r30)
	add	r1,r0,r2
	slli	r1,r1,#0x1
	add	r1,r1,r2
	slli	r2,r1,#0x1
	lw	r1,-272(r30)
	add	r2,r2,r1
	addi	r1,r0,#8
	mult	r2,r2,r1
	addi	r1,r30,#-8
	add	r1,r2,r1
	addi	r3,r1,#-240
	lw	r2,-264(r30)
	add	r1,r0,r2
	slli	r1,r1,#0x1
	add	r1,r1,r2
	slli	r2,r1,#0x1
	lw	r1,-272(r30)
	add	r2,r2,r1
	addi	r1,r0,#8
	mult	r2,r2,r1
	addi	r1,r30,#-8
	add	r1,r2,r1
	addi	r1,r1,#-240
	ld	f2,(r1)
	ld	f0,-280(r30)
	multd	f2,f2,f0
	ld	f0,(r3)
	subd	f0,f0,f2
	sd	(r4),f0
	lw	r1,-272(r30)
	addi	r1,r1,#1
	sw	-272(r30),r1
	j	L11
L8:
	lw	r1,-268(r30)
	addi	r1,r1,#1
	sw	-268(r30),r1
	j	L6
L4:
	lw	r1,-264(r30)
	addi	r1,r1,#1
	sw	-264(r30),r1
	j	L2
L3:
	addi	r1,r0,#0
	jal	_exit
	nop
