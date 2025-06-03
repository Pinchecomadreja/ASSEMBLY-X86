.8086
.model small
.stack 100h
.data
	cartel2		db "Ingresar char a eliminar:",0dh,0ah,24h
.code
	
	public cargatexto
					;recibe VAR offset en dx
					;devuelve en dx offset cargado
	public contarpalabras
					;manda en ss:[bp+6] offset texto
					;manda en ss:[bp+4] offset largo
					;cuenta el largo
					;devuelve en dx offset largo
	public print
					;recibe VAR offset en dx
					;imprime contenido en dx
	public delchar
					;manda en ss:[bp+6] offset texto
					;manda en ss:[bp+4] offset texto aux

	cargatexto proc
		;recibe etiqueta
		;recibe input del usuario
		;carga los caracteres en la etiqueta y vuelve a main
		
		;registros a usar
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
			
		ret

	cargatexto endp

	contarpalabras proc

		push bp
		mov bp,sp

		push ax
		push si 
		push cx
		push dx

		mov si,ss:[bp+6];offset texto		
		mov bx,ss:[bp+4];offset largo
		mov cx,0

		espacios:
			cmp byte ptr[si],0dh
			je reg2ascii
			
			cmp byte ptr[si],20h
			je contador

			inc si

		jmp espacios

		contador:
			inc cx
			inc si
		jmp espacios

		reg2ascii:
			inc cx
			add bx,2

			xor ax,ax
			mov al, cl
			mov dl, 10
			div dl
			add [bx],ah

			xor ah,ah
			dec bx
		        div dl
			add [bx],ah

			xor ah,ah
			dec bx
		        div dl
			add [bx],ah

		finreg2ascii:
		
		pop dx
		pop cx
		pop si
		pop ax

		pop bp

		ret 4

	contarpalabras endp

	print proc

		push ax
		push bx

		mov ah,9
		int 21h

		pop bx
		pop ax
	ret

	print endp

	delchar proc

		push bp
		mov bp,sp 

		push ax 
		push bx
		push dx
		push si 


	selchar:

		mov ah,9
		mov dx,offset cartel2
		int 21h	

		mov ah,1
		int 21h

		mov dl,al

		mov bx,ss:[bp+6]
		mov si,ss:[bp+4]

		pisar:
			cmp byte ptr[bx],0dh
			je fin

			cmp byte ptr[bx],dl
			je sinchar
			mov al,byte ptr[bx]
			mov byte ptr[si],al
			inc bx
			inc si
		jmp pisar

		sinchar:
			inc bx
		jmp pisar

		fin:
			pop si 
			pop dx
			pop bx
			pop ax 

			pop bp
		ret 4

	delchar endp
end