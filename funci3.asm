;Ingrese un texto e imprímalo con las vocales en mayusculas

.8086
.model small
.stack 100h
.data
	cartel db "Ingrese texto:",0dh,0ah,24h
	texto db 255 dup(24h),0dh,0ah,24h
.code
	extrn cargatexto:proc;llama proceso externo
	main proc

	mov ax,@data
	mov ds,ax
		
	mov ah,9
	mov dx,offset cartel
	int 21h

	mov dx,offset texto
	push dx

	call cargatexto

	fin:
		mov ah,9
		int 21h

		mov ah,4ch
		int 21h	

	main endp
end