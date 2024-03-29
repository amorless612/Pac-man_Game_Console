;/**************************************************************************//**
; * @file     startup_CMSDK_CM0.s
; * @brief    CMSIS Cortex-M0 Core Device Startup File for
; *           Device CMSDK_CM0
; * @version  V3.01
; * @date     06. March 2012
; *
; * @note
; * Copyright (C) 2012 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/
;/*
;//-------- <<< Use Configuration Wizard in Context Menu >>> ------------------
;*/


; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00004000

                AREA    STACK, NOINIT, READWRITE, ALIGN=4
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00004000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=4
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     0			              ; NMI Handler
                DCD     0				          ; Hard Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0			              ; SVCall Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0            			  ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler
                DCD     Keyboard_Handler          ; IRQ0 Handler
                DCD     LCDINI_Handler            ; IRQ1 Handler
				DCD     Music_Handler             ; IRQ2 Handler
				DCD     UARTRX_Handler            ; IRQ3 Handler

                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                GLOBAL  Reset_Handler
				ENTRY
                IMPORT  __main
                LDR     R0, =__main
				MOV     R8, R0
                MOV     R9, R8
                BX      R0
                ENDP

SysTick_Handler PROC
                EXPORT SysTick_Handler            [WEAK]
                IMPORT SysTickHandler
                PUSH    {LR}
                BL      SysTickHandler
                POP     {PC}		
                ENDP

UARTRX_Handler  PROC
	            EXPORT UARTRX_Handler            [WEAK]
			    IMPORT UARTRX_ISR
		        PUSH	{R0,R1,R2,LR}
                BL	UARTRX_ISR
			    POP	    {R0,R1,R2,PC}
                ENDP
				  
Music_Handler   PROC
	            EXPORT Music_Handler            [WEAK]
			    IMPORT MUSIC_ISR
		        PUSH	{R0,R1,R2,LR}
                BL	MUSIC_ISR
			    POP	    {R0,R1,R2,PC}
                ENDP
	          
Keyboard_Handler    PROC
                EXPORT Keyboard_Handler            [WEAK]
				IMPORT KEY_ISR
				PUSH	{R0,R1,R2,LR}
                BL		KEY_ISR
				POP		{R0,R1,R2,PC}
                ENDP


LCDINI_Handler    PROC
                EXPORT LCDINI_Handler            [WEAK]
				IMPORT LCD_INI_FINISH
				PUSH	{R0,R1,R2,LR}
                BL		LCD_INI_FINISH
				POP		{R0,R1,R2,PC}
                ENDP

                ALIGN 4

				IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap

__user_initial_stackheap 

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR
     
                ALIGN 

				ENDIF
					
                END
