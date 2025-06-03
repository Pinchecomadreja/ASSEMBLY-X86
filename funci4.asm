;Ingrese un texto e imprímalo con las vocales en mayusculas

.8086
.model small
.stack 100h
.data
	cartel 	db "ingresar texto, el programa convertira vocales en mayusc:",0dh,0ah,24h
	texto	db 255 dup (24h),0dh,0ah,24h
	espacio	db ""			,0dh,0ah,24h
	textovc	db 255 dup (24h),0dh,0ah,24h
.code
	
	extrn carga:proc
	extrn vocales:proc

	main proc

	mov ax,@data
	mov ds,ax

	mov ah,9
	mov dx,offset cartel
	int 21h

	xor dx,dx

;-------------PREP TO CARGA PROC---------------
	mov dx,offset texto;ss:[bp+6]
	push dx

	mov dx,offset textovc;ss[bp+4]
	push dx

	call carga;sp
;-------------FIN CARGA PROC-------------------

;-------------PREP VOCALES PROC----------------

	lea bx,textovc;ss[bp+4]
	push bx

	call vocales;sp
;-------------FIN VOCALES PROC-----------------


fin:
	mov ah,9
	mov dx,offset texto
	int 21h

	mov ah,9
	mov dx,offset espacio
	int 21h

	mov ah,9
	mov dx,offset textovc
	int 21h

	mov ah,4ch
	int 21h

	main endp
end