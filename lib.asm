.8086
.model small
.stack 100h

.data
    texto db 255 dup (24h)
.code
	public impresion
	public carga
    public vocalMayus

;------------------------------------------------------------------------------------------------------------------
	impresion proc
		push ax
        push dx

        mov ah, 9
        lea dx, [bx]
        int 21h

        pop bx
        pop ax
        ret
    impresion endp

;------------------------------------------------------------------------------------------------------------
	carga proc
        push ax
        push bx

        proceso:
            mov ah, 1
            int 21h
            cmp al, 0dh
            je finCarga
            mov [bx], al
            inc bx
            jmp proceso


        finCarga:
            pop bx
            pop ax
            ret
    carga endp
;-----------------------------------------------------------------------------------------------------------------
    vocalMayus proc

        push bx
        mov bx,dx

        compare:
            cmp byte ptr[bx], 0dh
            je finCompare

            cmp byte ptr[bx],'a'
            je mayus

            cmp byte ptr[bx],'e'
            je mayus

            cmp byte ptr[bx],'i'
            je mayus

            cmp byte ptr[bx],'o'
            je mayus

            cmp byte ptr[bx],'u'
            je mayus

            inc bx
        jmp compare

        mayus:
            sub byte ptr[bx], 20h
            inc bx

        jmp compare

        finCompare:
            pop bx
        ret
    vocalMayus endp
end