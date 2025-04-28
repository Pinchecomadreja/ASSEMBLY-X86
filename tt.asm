;Cree un programa en assembler x86 que lea un texto por teclado,
;lo recorra y cree otra ;variable donde se copie el mismo texto
; pero eliminando los siguientes signos de puntuación ;(".", ",", "?", "!"). 
;Luego en otra variable copiar ;el texto en invertido (conservando los signos de puntuación). 
;Al finalizar el software debe imprimir las 2 variables
;la que no tiene los signos y la que tiene el texto invertido

.8086
.model small
.stack 100h
.data
	cartel db "Ingresar texto a despuntear y invertir:",0dh,0ah,24h
	texto db 255 dup(24h),0dh,0ah,24h
	ptexto db 255 dup(24h),0dh,0ah,24h
	itexto db 255 dup(24h),0dh,0ah,24h
	espacio db'',0dh,0ah,24h
.code
	main proc

	mov ax,@data
	mov ds,ax

	mov ah,9
	mov dx, offset cartel
	int 21h

	mov bx,0
	mov si,0

	carga:
		mov ah,1
		int 21h

		cmp al,0dh
		je reset

		mov texto[bx],al 
		mov itexto[bx],al

		inc bx
		
		cmp al,"."
		je carga

		cmp al,","
		je carga

		cmp al,"?"
		je carga

		cmp al,"!"
		je carga

		mov ptexto[si],al

		inc si

	jmp carga 

	;reset
	reset:
		xor si,si;clear
		mov cx,bx;mov to i loop
		mov si,bx; mov to inverse i
		mov bx,0;clear
		dec si;clear final $ in texto
	jmp inversa

	inversa:
		mov al,texto[bx]
		mov itexto[si],al

		inc bx
		dec si

	loop inversa


	fin:

		mov ah,9
		mov dx, offset ptexto
		int 21h

		mov ah,9
		mov dx, offset espacio
		int 21h


		mov ah,9
		mov dx, offset itexto
		int 21h

		mov ah,4ch
		int 21h

	main endp
end