.8086
.model small
.stack 100h
.data
.code
	
	public cargatexto
	public contarpalabras

	cargatexto proc
		;recibe etiqueta
		;recibe input del usuario
		;carga los caracteres en la etiqueta y vuelve a main
		
		;registros a usar
		push dx
		push bx
		push ax

		mov bx,dx

		carga:
			mov ah,1
			int 21h

			cmp al,0dh
			je fincarga

			mov [bx],al 
			inc bx
		
		jmp carga


		fincarga:
			
			;registros usados
			pop ax
			pop bx
			pop dx
			
		ret

	cargatexto endp

	contarpalabras proc

		push bp
		mov bp,sp

		mov si,ss:[bp+6];offset texto		
		mov cx,ss:[bp+4];contador

		espacios:
			cmp byte ptr[si],24h
			je fin
			
			cmp byte ptr[si],20h
			je contador

		loop espacios

		contador:
			inc cx

		jmp espacios

		fin:
			inc cx;espacio [1:2] palabras

		ret

	endp

end