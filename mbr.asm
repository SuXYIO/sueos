%include "boot.inc"
StackBase equ 0x7c00
; load os.asm into memory
section MBR vstart=StackBase
	; init
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ss, ax

	; video
	mov ax, 0xb800
	mov gs, ax
	; display clear
	mov ax, 0x0600
	mov bx, 0x0700
	mov cx, 0x0000
	; dl=80, dh=25
	mov dx, 0x184f
	int 0x10
	; print msg
	mov byte [gs:0x00], 'M'
	mov byte [gs:0x01], 0x04
	mov byte [gs:0x02], 'B'
	mov byte [gs:0x03], 0x04
	mov byte [gs:0x04], 'R'
	mov byte [gs:0x05], 0x04

	; load os
	mov eax, OS_START_SEC
	mov bx, OS_BASE_ADDR
	mov cx, OS_SEC_CNT
	call ReadSector
	jmp OS_BASE_ADDR

ReadSector:
	; ax	Section to read from
	; cl	Number of sectors to read
	; bx	Destination

	; 1.44MB = 2 * 80 * 18 * 512
	; (One head for each side)
	; (Side * TracksPerSide * SectorsPerTrack * BytesPerSector)
	; SecToRead / SecPerTrk -> [q]uotient, [r]emainder
	; CyldNum = Q >> 1, HeadNum = Q & 1, StartSec = R + 1
	push bp
	mov bp, sp
	sub esp, 2
	mov byte [bp-2], cl
	push bx
	mov bl, BPB_SecPerTrk
	div bl
	inc ah
	mov cl, ah
	shr al, 1

	mov ch, al
	and dh, 1
	pop bx
	mov dl, BS_DrvNum
	.GoOnReading:
		; int 0x13, ah=2 for reading to buffer
		; al	number of sectors to read
		; ch	cylinder number
		; cl	first section number
		; dh	header number
		; dl	drive number (0 for drive A)
		; es:bx	buffer
		mov ah, 2
		mov al, byte [bp-2]
		int 0x13
		jc .GoOnReading
		add esp, 2
		pop bp
		ret

times 510 - ($ - $$) db 0x0
dw 0xaa55
