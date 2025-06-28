%include "boot.inc"
section MBR vstart=OS_BASE_ADDR
	mov ax, 0xb800
	mov gs, ax

	; print msg
	mov byte [gs:0x00], 'O'
	mov byte [gs:0x01], 0x02
	mov byte [gs:0x02], 'S'
	mov byte [gs:0x03], 0x02

	jmp $
