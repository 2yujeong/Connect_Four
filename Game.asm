INCLUDE irvine32.inc

position STRUCT
	x BYTE 0
	y BYTE 0
	check BYTE 0
position ENDS

.data
	block BYTE "��", 0
	whites BYTE "��", 0
	blacks BYTE "��", 0
	title1 BYTE "  *====================* ", 0
	title2 BYTE "      ��ü ��� ����       ", 0
	title3 BYTE "  *====================*   ", 0
	line BYTE "������������������������������", 0
	prompt BYTE "��ġ�� �Է��ϼ��� : ", 0
	prompt2 BYTE " 0 1 2 3 4 5 6", 0
	prompt3 BYTE "���� : ��", 0
	prompt4 BYTE "���� : ��", 0
	prompt5 BYTE "���̻� ���� �� �����ϴ�. ��ġ�� �ٽ� �Է����ּ���.", 0
	prompt6 BYTE "                                                    ", 0
	prompt7 BYTE " ", 0
	winblack BYTE "   �浹�� �̰���ϴ�!", 0
	winwhite BYTE "   �鵹�� �̰���ϴ�!", 0
	full BYTE "   GAME OVER (�ٽ��ϱ� - 1, ���� ���� - 0)", 0
	error BYTE "0 ~ 6 ������ ���� �Է����ּ���", 0
	pan position 42 DUP(<,,0>)

.code
main PROC
	call Init
	mov ebx, 1
L1:	
	mov edx, 0
	mov dl, 0
	mov dh, 12
	call gotoxy
	mov edx, OFFSET prompt7
	call writestring
	mov edx, 0
	mov dl, 23
	mov dh, 13
	call gotoxy
	mov edx, OFFSET prompt6
	call writestring

	; title ���
	mov edx, 0
	mov dl, 4
	mov dh, 1
	call gotoxy
	mov edx, OFFSET title1
	call writestring
	mov edx, 0
	mov dl, 4
	mov dh, 2
	call gotoxy
	mov edx, OFFSET title2
	call writestring
	mov edx, 0
	mov dl, 4
	mov dh, 3
	call gotoxy
	mov edx, OFFSET title3
	call writestring

	; ���� �˷��ֱ�
	mov edx, 0
	mov dl, 22
	mov dh, 5
	call gotoxy
	.IF ebx == 1
		mov edx, OFFSET prompt3
	.ELSE
		mov edx, OFFSET prompt4
	.ENDIF
	call writestring

	; ����� ���
	mov edx, 0
	mov dl, 5
	mov dh, 5
	call gotoxy
	mov edx, OFFSET prompt2
	call writestring
	call print
	mov edx, 0
	mov dl, 4
	mov dh, 12
	call gotoxy
	mov edx, OFFSET line
	call writestring

	; ��ġ �Է� �ȳ�â ���
	mov edx, 0
	mov dl, 3
	mov dh, 13
	call gotoxy
	mov edx, OFFSET prompt
	call writestring

	; ���� ��ġ �Է� �ޱ�
	mov eax, 0
	call readint
	call inputStone
	push edx
	mov dl, 3
	mov dh, 14
	call gotoxy
	pop edx
	call writestring

	; ��ġ �Ǻ�
	call checkStone
	cmp eax, 10007
	je L2
	cmp eax, -10007
	je L3

	neg ebx
	jmp L1
L2: ; ���� / ���� / �밢�� ���� ���� ���� 4���� �Ǿ �¸��� ���
	.IF ebx == 1
		call print
		mov edx, OFFSET winblack
	.ELSE
		call print
		mov edx, OFFSET winwhite
	.ENDIF
	call writestring
	call crlf
	jmp L4
L3: ; ������� �� ä������ ������ ���� ���
	call print
	mov edx, OFFSET full
	call writestring
	call crlf
	mov eax, 0
	call readint
	.IF eax == 1
		mov edx, 0
		mov dl, 22
		mov dh, 11
		call gotoxy
		mov edx, OFFSET prompt6
		call writestring
		call Init
		jmp L1
	.ELSE
		jmp L4
	.ENDIF
L4:
	exit
main ENDP

checkStone PROC ; ���� ������ ������ ������ ������ �� ���θ� �Ǻ��ϴ� procedure
	.IF ebx == 1 ; �浹 �Ǻ�
		; ���η� ���� 4���� ���� �ִ� ���
		mov ecx, 0
		push ebx
		mov bl, pan[eax].x
		push eax
		B1:
		sub eax, 3
		.IF eax >= 0
		.IF pan[eax].x < bl
			.IF pan[eax].check == 1
				inc ecx
				jmp B1
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		push ebx
		mov bl, pan[eax].x
		push eax
		B2:
		add eax, 3
		.IF eax <= 123
		.IF pan[eax].x > bl
			.IF pan[eax].check == 1
				inc ecx
				jmp B2
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		.IF ecx >= 3
			mov pan[eax].check, 1
			mov eax, 10007
			ret
		.ENDIF

		; ���η� ���� 4���� ���� �ִ� ���
		mov ecx, 0
		push eax
		B3:
		add eax, 21
		.IF eax <= 123
			.IF pan[eax].check == 1
				inc ecx
				jmp B3
			.ENDIF
		.ENDIF
		pop eax

		.IF ecx >= 3
			mov pan[eax].check, 1
			mov eax, 10007
			ret
		.ENDIF

		; ������ - �����ʾƷ� ���� �밢������ ���� 4���� ���� �ִ� ���
		mov ecx, 0
		push ebx
		mov bl, pan[eax].x
		push eax
		B4:
		sub eax, 24
		.IF eax >= 0
		.IF pan[eax].x < bl
			.IF pan[eax].check == 1
				inc ecx
				jmp B4
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		push ebx
		mov bl, pan[eax].x
		push eax
		B5:
		add eax, 24
		.IF eax <= 123
		.IF pan[eax].x > bl
			.IF pan[eax].check == 1
				inc ecx
				jmp B5
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		.IF ecx >= 3
			mov pan[eax].check, 1
			mov eax, 10007
			ret
		.ENDIF

		; �������� - ���ʾƷ� ���� �밢������ ���� 4���� ���� �ִ� ���
		mov ecx, 0
		push eax
		B6:
		sub eax, 18
		.IF eax >= 0
		.IF pan[eax].x != 5
			.IF pan[eax].check == 1
				inc ecx
				jmp B6
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax

		push eax
		B7:
		add eax, 18
		.IF eax <= 123
		.IF pan[eax].x != 17
			.IF pan[eax].check == 1
				inc ecx
				jmp B7
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax

		.IF ecx >= 3
			mov pan[eax].check, 1
			mov eax, 10007
			ret
		.ENDIF
	.ELSE ; �鵹 �Ǻ�
		mov ecx, 0
		push ebx
		mov bl, pan[eax].x
		push eax
		W1:
		sub eax, 3
		.IF eax >= 0
		.IF pan[eax].x < bl
			.IF pan[eax].check == 2
				inc ecx
				jmp W1
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		push ebx
		mov bl, pan[eax].x
		push eax
		W2:
		add eax, 3
		.IF eax <= 123
		.IF pan[eax].x > bl
			.IF pan[eax].check == 2
				inc ecx
				jmp W2
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		.IF ecx >= 3
			mov pan[eax].check, 2
			mov eax, 10007
			ret
		.ENDIF

		mov ecx, 0
		push eax
		W3:
		add eax, 21
		.IF eax <= 123
			.IF pan[eax].check == 2
				inc ecx
				jmp W3
			.ENDIF
		.ENDIF
		pop eax

		.IF ecx >= 3
			mov pan[eax].check, 2
			mov eax, 10007
			ret
		.ENDIF

		mov ecx, 0
		push ebx
		mov bl, pan[eax].x
		push eax
		W4:
		sub eax, 24
		.IF eax >= 0
		.IF pan[eax].x < bl
			.IF pan[eax].check == 2
				inc ecx
				jmp W4
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		push ebx
		mov bl, pan[eax].x
		push eax
		W5:
		add eax, 24
		.IF eax <= 123
		.IF pan[eax].x > bl
			.IF pan[eax].check == 2
				inc ecx
				jmp W5
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax
		pop ebx

		.IF ecx >= 3
			mov pan[eax].check, 2
			mov eax, 10007
			ret
		.ENDIF

		mov ecx, 0
		push eax
		W6:
		sub eax, 18
		.IF eax >= 0
		.IF pan[eax].x != 5
			.IF pan[eax].check == 2
				inc ecx
				jmp W6
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax

		push eax
		W7:
		add eax, 18
		.IF eax <= 123
		.IF pan[eax].x != 17
			.IF pan[eax].check == 2
				inc ecx
				jmp W7
			.ENDIF
		.ENDIF
		.ENDIF
		pop eax

		.IF ecx >= 3
			mov pan[eax].check, 2
			mov eax, 10007
			ret
		.ENDIF
	.ENDIF

	; ������� ��� ä���� ��� �Ǻ�
	mov edi, 0
	.IF pan[edi].check != 0
		add edi, 3
	.IF pan[edi].check != 0
		add edi, 3
	.IF pan[edi].check != 0
		add edi, 3
	.IF pan[edi].check != 0
		add edi, 3
	.IF pan[edi].check != 0
		add edi, 3
	.IF pan[edi].check != 0
		add edi, 3
	.IF pan[edi].check != 0
	.IF ebx == 1
		mov pan[eax].check, 1
	.ELSE
		mov pan[eax].check, 2
	.ENDIF
	mov eax, -10007
	.ENDIF
	.ENDIF
	.ENDIF
	.ENDIF
	.ENDIF
	.ENDIF
	.ENDIF

	ret
checkStone ENDP

inputStone PROC ; �˸��� ��ġ�� ���� ����ִ� procedure
	.IF eax < 0
		mov edx, OFFSET error
		neg ebx
	.ELSEIF eax > 6
		mov edx, OFFSET error
		neg ebx
	.ELSE
		add eax, 35
		L1:
		mov dl, 3
		mul dl
		.IF pan[eax].check != 0
			div dl
			sub eax, 7
			cmp eax, 0
			jl L2
			jmp L1
		.ELSEIF ebx == 1 ;�浹�� ��
			mov pan[eax].check, 1
			mov edx, OFFSET prompt6
		.ELSE ; �鵹�� ��
			mov pan[eax].check, 2
			mov edx, OFFSET prompt6
		.ENDIF
	.ENDIF
	jmp NEXT
	L2:
		mov edx, OFFSET prompt5
		neg ebx
	NEXT:

	ret
inputStone ENDP

Init PROC ; ������� �� ĭ���� ������ ����ü���� �ʱ�ȭ�ϴ� procedure
	pushad
	mov ecx, 6
	mov edi, 0
	mov eax, 6
L1:
	push ecx
	mov ecx, 7
	mov ebx, 5
L2:
	mov pan[edi].check, 0
	mov pan[edi].x, bl
	mov pan[edi].y, al
	add ebx, 2
	add edi, 3
	loop L2

	pop ecx
	inc eax
	loop L1
	popad

	ret
init ENDP

print PROC ; ����� ���¸� ȭ�鿡 ������ִ� procedure
	mov ecx, 42
	mov edi, 0
L1:
	mov edx, 0
	mov dl, pan[edi].x
	mov dh, pan[edi].y
	call gotoxy
	.IF pan[edi].check == 1
		mov edx, OFFSET blacks
	.ELSEIF pan[edi].check == 2
		mov edx, OFFSET whites
	.ELSE
		mov edx, OFFSET block
	.ENDIF
	call writestring
	add edi, 3
	loop L1

	ret
print ENDP

END main