;Ingrese un texto e imprima la cantidad de palabras.

.8086
.model small
.stack 100h
.data
;---AVISOS
	cartel 		db "Ingrese texto:",0dh,0ah,24h
	cartel2		db "Cantidad de palabras en texto: $"
	espacio		db "",0dh,0ah,24h
;---VAR
	nro		 	db 0
	texto 	 	db 255 dup (24h),0dh,0ah,24h
	contador 	db '000',0dh,0ah,24h

.code
	main proc

	mov ax,@data
	mov ds,ax

	mov ah,9
	mov dx,offset cartel
	int 21h

mov si,0

carga:

	mov ah,1 
	int 21h

	cmp al,0dh
	je r2ascii

	cmp al,20h
	je cant

	mov texto[bx],al
	inc bx

jmp carga

cant:
;Cada vez que al == ' ' agrega 1 al contador
	inc nro
jmp carga

r2ascii:
	;Suma 1 a la cantidad
	inc nro

	;Limpio AX para hacer division 
	xor ax,ax


	;muevo valor de si a al
	mov al, nro
	mov dl, 100 
	div dl 
	add contador[0],al

	mov al, ah 
	xor ah, ah 
	mov dl, 10
	div dl 
	add contador[1],al
	add contador[2],ah

jmp fincarga


fincarga:

	mov ah,9
	mov dx,offset cartel2
	int 21h

	mov ah,9
	mov dx,offset contador
	int 21h

	mov ah,4ch
	int 21h

	main endp
end
