.8086
.model small
.stack 100h
.data
	vc    db "aeiou"	
.code
;---DECLARO PROCESOS Y SU TIPO DE ACCESO
	public carga
	public vocales

	carga proc
		;1)recibe dos etiquetas
		;2)carga la misma cadena de texto ingresada por el user en ellas

	;---ANCLA CALL
		push bp
		mov bp,sp

	;---PROFI REG EN USO
		push ax	
		push bx
		push si

	;---USO DE STACK
		mov bx,ss:[bp+6];(VAR texto)
		mov si,ss:[bp+4];(VAR textovc)

	;---CARGA
		ingreso:

			mov ah,1
			int 21h

			cmp al,0dh
			je finingreso

			mov [bx],al
			mov [si],al 
			
			inc bx
			inc si

		jmp ingreso
	
	;---PROFI REG EN USADOS
		finingreso:
			
			pop si
			pop bx
			pop ax

			pop bp

		ret 4

	carga endp


	vocales proc

		push bp
		mov bp,sp  

		push bx

		mov bx,ss:[bp+4]

		compara:

			cmp byte ptr[bx],24h
			je finvocales

			cmp byte ptr[bx],'a'
			je mayusc

			cmp byte ptr[bx],'e'
			je mayusc

			cmp byte ptr[bx],'i'
			je mayusc

			cmp byte ptr[bx],'o'
			je mayusc

			cmp byte ptr[bx],'u'
			je mayusc

			inc bx

		jmp compara

		mayusc:

			sub byte ptr[bx],20h;minusc
			inc bx

		jmp compara


		finvocales:
			
			pop bx
			pop bp

		ret 2

	vocales endp
end