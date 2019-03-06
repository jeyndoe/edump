code	segment use16
assume cs:code,ds:code
org	000h
data_:	
	org	5ch
arg1:
	org	6ch
arg2:
	org 	100h
start:
	jmp	Begin
sOpenErr:	db	"Can't open file",'$'
sCreatErr:	db	"Can't create file",'$'
sNomem:		db	"Can't allocate memory$"
syntax:		db	"cript in out <C|D>",'$'
sPlease:	db	"please input PassWord->$"
BUFPASS:	db	20 Dup('?')
HandleOpen:	DW	1
HandleCrea:	DW	1
handlemem:	dw	1
hash:		db	?
len:		db	4 DUP('W')
Begin:
	push	cs
	pop	ds
	lea	dx,	arg1+1
	mov	ah,	3dh
	xor	cx,	cx
	int	21h
	jnc	nErr_Open
	jmp	err_open
nerr_open:
	mov	word ptr [HandleOpen],	ax
	lea	dx,	arg2+1
	mov	ah,	3ch
	xor	cx,	cx
	int	21h
	jnc	nErr_Create
	jmp	Err_create
nErr_create:
	mov	word ptr [HandleCrea],	ax
	mov	ah,	09h
	lea	dx,	sPlease
	int	21h
	mov	ah,	0Ah
	lea	dx,	BUFPASS
	mov	al,	9	; 8 символов + возврат каретки
	mov	byte ptr ds:[BUFPASS],	al
	int	21h
	xor	al,	al
	mov	bh,	al
	lea	si,	bufpass+2
	mov	bl,	byte ptr [si-1]
	mov	byte ptr [si+bx],al
	mov	cl,	bl
	xor	ah,	ah
GetHashe:
	mov	al,	byte ptr [si]
	xor	ah,	al
	inc	si
	loop	GetHashe
	mov	byte ptr [hash], ah
	mov	bx,	word ptr [HandleOpen]
	mov	ax,	4202h
	xor	dx,	dx
	xor	cx,	cx
	int	21h
	mov	word ptr cs:[len], dx
	mov	word ptr cs:[len+2],ax
	mov	cx,	4
	rcr	ax,	cl
	inc	ax
	mov	bx,	ax
		
	mov	ah,	48h
	int 	21h
	jc	err_mem
	mov	word ptr cs:[handlemem],ax
	mov	ds,	ax
	mov	es,	ax
	mov	ax,	3f00h
	mov	bx,	word ptr cs:[HandleOpen]
	xor	dx,	dx
	mov	cx,	word ptr cs:[Len+2]
	int	21h

	mov	ah,	byte ptr cs:[HASH]
	mov	cx,	word ptr cs:[len+2]
	xor	si,	si
Hashing:
	mov	al,	byte ptr ds:[si]
	xor	al,	ah
	mov	byte ptr ds:[si],al
	inc	si
	loop	Hashing

	
	xor     dx,	dx
	mov	ah,	40h
	mov	bx,	word ptr cs:[HandleCrea]
	mov	ds,	word ptr cs:[handlemem]
	mov	cx,	Word ptr cs:[Len+2]
	int	21h

	mov	ah,	49h
	mov	es,	word ptr cs:[Handlemem]
	int	21h

	jmp	Exit
cript:
decript:
        ret
err_mem:
	lea	dx,	sNoMem
	jmp	err__
err_open:
	lea	dx,	sOpenErr
	jmp	err__
err_create:
	lea	dx,	sCreatErr
err__:
	push	cs
	pop	ds
	mov	ah,	09
	int	21h
Exit:
	mov	ah,	4ch
	int	21h
FileData:
ends
end	start