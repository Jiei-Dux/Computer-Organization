; ===== ===== ===== ===== ===== ===== ===== ===== =====
;
; Github: https://github.com/Jiei-Dux
; Credits to: https://github.com/sajdoko
;
; Computer Organization
; Activity - Procedure and Loop
;
; ===== ===== ===== ===== ===== ===== ===== ===== =====

section .data
	INVALID_ARGS: db "The command should be: ./Activity <Operator> <First Number> <Second Number>", 0xA
	INVALID_OPERATOR: db "Invalid Operator", 0xA
	INVALID_OPERAND: db "Invalid Operand", 0xA
	BYTE_BUFFER: times 10 db 0




section .text

	global _start

	_start:
		pop rdx
		cmp rdx, 4
		jne invalid_args

		add rsp, 8
		pop rsi

		; (+) = 0b00101011 in binary
		; (-) = 0b00101101 in binary
		; (*) = 0b00101010 in binary
		; (/) = 0b00101111 in binary
		cmp byte[rsi], 0b00101011
		je addition

		cmp byte[rsi], 0b00101101
		je subtraction

		cmp byte[rsi], 0b00101010
		je multiplication

		cmp byte[rsi], 0b00101111
		je division

		jmp invalid_operator




	addition:
		pop rsi
		call char_to_int
		mov r10, rax
		pop rsi
		call char_to_int
		add rax, r10
		jmp print_result




	subtraction:
		pop rsi
		call char_to_int
		mov r10, rax
		pop rsi
		call char_to_int
		sub r10, rax
		mov rax, r10
		jmp print_result




	multiplication:
		pop rsi
		call char_to_int
		mov r10, rax
		pop rsi
		call char_to_int
		mul r10
		jmp print_result




	division:
		pop rsi
		call char_to_int
		mov r10, rax
		pop rsi
		call char_to_int
		mov r11, rax
		mov rax, r10
		mov rdx, 0
		div r11
		jmp print_result


	

	print_result:
		call int_to_char
		mov rax, 1
		mov rdi, 1
		mov rsi, r9 
		mov rdx, r11
		syscall
		jmp exit




	invalid_args:
		mov rdi, INVALID_ARGS
		call print_the_error

	invalid_operator:
		mov rdi, INVALID_OPERATOR
		call print_the_error

	invalid_operand:
		mov rdi, INVALID_OPERAND
		call print_the_error




	print_the_error:
		push rdi
		call strlen 
		mov rdi, 2
		pop rsi	
		mov rdx, rax
		mov rax, 1 
		syscall 
		call error_exit	
		ret




	strlen:
		xor rax, rax 

		strlen_loop:
			cmp BYTE [rdi + rax], 0xA
			je strlen_break 
			inc rax	
			jmp strlen_loop 

		strlen_break:
			inc rax 
			ret




	char_to_int:
		xor ax, ax 
		xor cx, cx 
		mov bx, 10 

		loop_proc_cti:
			mov cl, [rsi]

			cmp cl, byte 0
			je return_proc_cti

			cmp cl, 0x30
			jl invalid_operand

			cmp cl, 0x39 
			jg invalid_operand

			sub cl, 48
			mul bx
			add ax, cx
			inc rsi
			jmp loop_proc_cti

		return_proc_cti:
			ret




	int_to_char:
		mov rbx, 10
		mov r9, BYTE_BUFFER+10
		mov [r9], byte 0
		dec r9
		mov [r9], byte 0XA
		dec r9
		mov r11, 2

		loop_proc_itc:
			mov rdx, 0
			div rbx 	
			cmp rax, 0 
			je return_proc_itc
			add dl, 48 
			mov [r9], dl 
			dec r9 
			inc r11 
			jmp loop_proc_itc 

		return_proc_itc:
			add dl, 48 
			mov [r9], dl
			dec r9
			inc r11
			ret




	error_exit:
		mov rax, 60 
		mov rdi, 1 
		syscall

	


	exit:
		mov rax, 60 
		mov rdi, 0 
		syscall