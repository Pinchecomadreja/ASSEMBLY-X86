.8086
.model small
.stack 100h
.data
	cartel1		db "Ingresar texto:",0dh,0ah,24h
	cartel2		db "Ingresar char a eliminar:",0dh,0ah,24h
	cartel3		db "Cantidad de palabras:",0dh,0ah,24h
	espacio		db "",0dh,0ah,24h
	texto 		db 255 dup (24h),0dh,0ah,24h
	auxtexto 	db 255 dup (24h),0dh,0ah,24h
	largo 		db '000',0dh,0ah,24h
.code
	extrn cargatexto:proc
					;recibe VAR offset en dx
					;devuelve en dx offset cargado
	extrn contarpalabras:proc
					;manda en ss:[bp+6] offset texto
					;manda en ss:[bp+4] offset largo
					;cuenta el largo
					;carga el largo en VAR largo
					;devuelve en cx reg largo
	extrn print:proc
					;recibe VAR offset en dx
					;imprime contenido en dx
	extrn delchar:proc
					;recibe por 2 elementos por stack
					;recibe ss:[bp+6]->offset texto
					;recibe ss:[bp+4]->offset auxtexto
					;pide por int 21h delchar y guarda en dl
					;compara en dl con offset texto
					;carga texto sin delchar en auxtexto

	main proc

	mov ax,@data
	mov ds,ax

	mov ah,9
	mov dx,offset cartel1
	int 21h

	mov dx,offset texto
	push dx
	call cargatexto 

	mov dx,offset texto
	push dx;ss:[bp+6] offset texto
	
	lea bx,largo;ss:[bp+4] offset largo
	push bx

	call contarpalabras
	
	mov ah,9
	mov dx,offset cartel3
	int 21h
	
	mov ah,9
	mov dx,offset largo
	int 21h

	mov dx,offset texto
	push dx

	mov dx,offset auxtexto
	push dx

	call delchar

	mov ah,9
	mov dx,offset espacio
	int 21h

	mov ah,9
	mov dx,offset auxtexto
	int 21h

	mov ah,4ch
	int 21h

	main endp
end

