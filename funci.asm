;Ingrese un texto de hasta 255 caracteres terminados por el signo $.
;Imprima el texto modificando la letra a por la letra x. 
;Imprima el texto modificado y luego el texto original.


.8086
.model small
.stack 100h
.data
	cartel 	db "Ingresar frase y se intercambiara a por x:",0dh,0ah,24h
	texto 	db 255 dup(24h),0dh,0ah,24h
.code
	main proc

		mov ax,@data
		mov ds,ax

		mov ah,9
		mov dx,offset cartel
		int 21h

		;limio registros
		xor ax,ax
		xor dx,dx

		mov dx,offset texto
		push dx;ss:[bp+4]

		call carga;ss:[bp+2]

		


	resultado:
		
		mov ah,9
		mov dx,offset texto
		int 21h

		mov ah,4ch
		int 21h

	main endp

	carga proc
	;caja de carga de string
	;devuelve la carga en etiqueta texto

		push bp;anclo el base pointer
		mov bp,sp;paso la direccion de retorno

		;profi registros a usar
		push ax
		push bx
		push si

		;traigo texto
		mov si,ss:[bp+4]


	ingreso:
		mov ah,1
		int 21h
		
		cmp al,0dh
		je fincarga

		cmp al,'a'
		je cambio

		;cargo dato
		mov [si],al
	
		inc si

	jmp ingreso

	cambio:
		mov al,'x'
		mov [si],al 
		inc si
	jmp ingreso

	fincarga:

		;retorno registros
		pop si
		pop bx
		pop ax
		
		pop bp

		ret 2

	carga endp

end