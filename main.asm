; For testing if bootup is successful and printing
; Yeah basically a modified Hello World

org 0x7c00

start:
	; init
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov sp,0x7c00

	; clear
	;mov ax,0x600
	;int 0x10

	mov ax,0x200
	mov bx,0
	mov cx,0

	; print
	mov ah,0x13
	mov al,0x01
	mov bh,0x0
	mov bl,0xf
	mov cx,0xe	;str length
	mov es,dx
	mov dx,0x0
	mov bp,BootMsg
	int 0x10

	; reset
	xor ah,ah
	xor dl,dl
	int 0x13
	hlt

BootMsg:
	db "bootup success"
	times 510-($-$$) db 0x0
	db 0x55
	db 0xaa
