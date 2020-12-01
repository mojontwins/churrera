;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Tue Dec 01 13:00:02 2020



	MODULE	churromain.c


	INCLUDE "z80_crt0.hdr"


	LIB SPInvalidate
	LIB SPCompDListAddr
	LIB SPMoveSprAbs
	LIB SPTileArray
;	SECTION	text

._comportamiento_tiles
	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	1

	defm	""
	defb	1

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._keys
	defw	383
	defw	479
	defw	735
	defw	509
	defw	507

;	SECTION	code

;	SECTION	text

._key_1
	defw	503
;	SECTION	code


;	SECTION	text

._key_2
	defw	759
;	SECTION	code


;	SECTION	text

._key_3
	defw	1271
;	SECTION	code



._my_malloc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_BlockAlloc
	pop	bc
	ret


;	SECTION	text

._u_malloc
	defw	_my_malloc

;	SECTION	code

;	SECTION	text

._u_free
	defw	sp_FreeBlock

;	SECTION	code

;	SECTION	text

._spritesClipValues
	defb	2
	defb	0
	defb	20
	defb	30

;	SECTION	code

	.fsClipStruct defb 0, 24, 0, 32
	.vpClipStruct defb 2, 2 + 20, 0, 0 + 30
;	SECTION	text

._en_tocado
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._max_screens
	defm	""
	defb	25

;	SECTION	code


;	SECTION	text

._bitmask
	defm	""
	defb	1

	defm	""
	defb	2

	defm	""
	defb	4

	defm	""
	defb	8

	defm	""
	defb	16

	defm	" @"
	defb	128

;	SECTION	code


	; aPPack decompressor
	; original source by dwedit
	; very slightly adapted by utopian
	; optimized by Metalbrain
	;hl = source
	;de = dest
	.depack
	ld ixl,128
	.apbranch1
	ldi
	.aploop0
	ld ixh,1 ;LWM = 0
	.aploop
	call ap_getbit
	jr nc,apbranch1
	call ap_getbit
	jr nc,apbranch2
	ld b,0
	call ap_getbit
	jr nc,apbranch3
	ld c,16 ;get an offset
	.apget4bits
	call ap_getbit
	rl c
	jr nc,apget4bits
	jr nz,apbranch4
	ld a,b
	.apwritebyte
	ld (de),a ;write a 0
	inc de
	jr aploop0
	.apbranch4
	and a
	ex de,hl ;write a previous byte (1-15 away from dest)
	sbc hl,bc
	ld a,(hl)
	add hl,bc
	ex de,hl
	jr apwritebyte
	.apbranch3
	ld c,(hl) ;use 7 bit offset, length = 2 or 3
	inc hl
	rr c
	ret z ;if a zero is encountered here, it is EOF
	ld a,2
	adc a,b
	push hl
	ld iyh,b
	ld iyl,c
	ld h,d
	ld l,e
	sbc hl,bc
	ld c,a
	jr ap_finishup2
	.apbranch2
	call ap_getgamma ;use a gamma code * 256 for offset, another gamma code for length
	dec c
	ld a,c
	sub ixh
	jr z,ap_r0_gamma ;if gamma code is 2, use old r0 offset,
	dec a
	;do I even need this code?
	;bc=bc*256+(hl), lazy 16bit way
	ld b,a
	ld c,(hl)
	inc hl
	ld iyh,b
	ld iyl,c
	push bc
	call ap_getgamma
	ex (sp),hl ;bc = len, hl=offs
	push de
	ex de,hl
	ld a,4
	cp d
	jr nc,apskip2
	inc bc
	or a
	.apskip2
	ld hl,127
	sbc hl,de
	jr c,apskip3
	inc bc
	inc bc
	.apskip3
	pop hl ;bc = len, de = offs, hl=junk
	push hl
	or a
	.ap_finishup
	sbc hl,de
	pop de ;hl=dest-offs, bc=len, de = dest
	.ap_finishup2
	ldir
	pop hl
	ld ixh,b
	jr aploop
	.ap_r0_gamma
	call ap_getgamma ;and a new gamma code for length
	push hl
	push de
	ex de,hl
	ld d,iyh
	ld e,iyl
	jr ap_finishup
	.ap_getbit ld a,ixl
	add a,a
	ld ixl,a
	ret nz
	ld a,(hl)
	inc hl
	rla
	ld ixl,a
	ret
	.ap_getgamma
	ld bc,1
	.ap_getgammaloop
	call ap_getbit
	rl c
	rl b
	call ap_getbit
	jr c,ap_getgammaloop
	ret
;	SECTION	text

._mapa
	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	233

	defm	""
	defb	233

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	153

	defm	""
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	137

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	152

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	153

	defm	"y"
	defb	152

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	137

	defm	""
	defb	152

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	137

	defm	""
	defb	152

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	153

	defm	"w"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	151

	defm	"y"
	defb	153

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	34

	defm	""
	defb	212

	defm	"-+"
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	178

	defm	"2$3"
	defb	188

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	210

	defm	","
	defb	194

	defm	""
	defb	219

	defm	""
	defb	204

	defm	""
	defb	199

	defm	"wrL"
	defb	204

	defm	""
	defb	195

	defm	""
	defb	188

	defm	""
	defb	204

	defm	"p"
	defb	0

	defm	"2"
	defb	204

	defm	"l"
	defb	200

	defm	""
	defb	140

	defm	""
	defb	7

	defm	""
	defb	0

	defm	""
	defb	2

	defm	"L"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	252

	defm	""
	defb	192

	defm	"p"
	defb	7

	defm	"B"
	defb	192

	defm	""
	defb	0

	defm	""
	defb	136

	defm	""
	defb	192

	defm	""
	defb	7

	defm	""
	defb	0

	defm	"t0"
	defb	12

	defm	""
	defb	0

	defm	""
	defb	188

	defm	""
	defb	0

	defm	"p"
	defb	7

	defm	"2"
	defb	0

	defm	""
	defb	192

	defm	";"
	defb	192

	defm	""
	defb	7

	defm	""
	defb	0

	defm	"r"
	defb	192

	defm	""
	defb	204

	defm	"2"
	defb	176

	defm	""
	defb	0

	defm	"p"
	defb	7

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	188

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	"www"
	defb	192

	defm	"wwwp"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	201

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	199

	defm	"wwwwwww"
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	176

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	27

	defm	""
	defb	192

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	185

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	155

	defm	"wwwwwy"
	defb	153

	defm	""
	defb	185

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	155

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	183

	defm	"www"
	defb	153

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	155

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	"y"
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	177

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	187

	defm	""
	defb	183

	defm	"w"
	defb	153

	defm	""
	defb	155

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	25

	defm	""
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	185

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	155

	defm	"#MB=4"
	defb	210

	defm	"4"
	defb	221

	defm	""
	defb	208

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	211

	defm	"0"
	defb	12

	defm	""
	defb	192

	defm	""
	defb	10

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"$"
	defb	0

	defm	""
	defb	172

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	172

	defm	""
	defb	3

	defm	" "
	defb	0

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	192

	defm	"C"
	defb	10

	defm	""
	defb	204

	defm	""
	defb	10

	defm	""
	defb	12

	defm	""
	defb	10

	defm	""
	defb	0

	defm	""
	defb	173

	defm	"@"
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	"3"
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	2

	defm	"J"
	defb	0

	defm	""
	defb	160

	defm	""
	defb	204

	defm	""
	defb	160

	defm	""
	defb	202

	defm	""
	defb	0

	defm	"C"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	13

	defm	""
	defb	137

	defm	""
	defb	152

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	153

	defm	"w"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	137

	defm	"y"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	136

	defm	"w"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	151

	defm	"x"
	defb	136

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	132

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"D"
	defb	212

	defm	""
	defb	12

	defm	""
	defb	194

	defm	"B2CB<"
	defb	12

	defm	""
	defb	4

	defm	";"
	defb	0

	defm	""
	defb	7

	defm	""
	defb	0

	defm	"t"
	defb	204

	defm	""
	defb	195

	defm	"#"
	defb	176

	defm	""
	defb	0

	defm	"p"
	defb	7

	defm	"2"
	defb	204

	defm	"$;"
	defb	192

	defm	""
	defb	7

	defm	""
	defb	0

	defm	"r@C3"
	defb	188

	defm	""
	defb	0

	defm	"p"
	defb	7

	defm	"2"
	defb	194

	defm	"$+"
	defb	204

	defm	""
	defb	7

	defm	""
	defb	0

	defm	"t<"
	defb	194

	defm	"B"
	defb	188

	defm	""
	defb	192

	defm	"p"
	defb	0

	defm	"4"
	defb	204

	defm	""
	defb	194

	defm	";"
	defb	204

	defm	""
	defb	199

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	194

	defm	""
	defb	188

	defm	""
	defb	204

	defm	"wwC"
	defb	12

	defm	""
	defb	204

	defm	""
	defb	203

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	195

	defm	"B"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	176

	defm	""
	defb	203

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	176

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	193

	defm	""
	defb	27

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	"wwwwwwwp"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	201

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	153

	defm	""
	defb	204

	defm	""
	defb	199

	defm	"wwwwwww"
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	155

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	177

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	187

	defm	""
	defb	185

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	155

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	27

	defm	"y"
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	183

	defm	""
	defb	153

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	155

	defm	"wwwy"
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	185

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	155

	defm	""
	defb	201

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	"y"
	defb	153

	defm	""
	defb	183

	defm	"wwwww"
	defb	153

	defm	""
	defb	155

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	""
	defb	187

	defm	" "
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	192

	defm	"3"
	defb	0

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	160

	defm	""
	defb	192

	defm	""
	defb	2

	defm	"N"
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	211

	defm	""
	defb	12

	defm	""
	defb	160

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	208

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	160

	defm	""
	defb	10

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	210

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	238

	defm	""
	defb	228

	defm	""
	defb	208

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	0

	defm	"-"
	defb	10

	defm	""
	defb	12

	defm	""
	defb	202

	defm	""
	defb	204

	defm	""
	defb	160

	defm	""
	defb	172

	defm	""
	defb	3

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	160

	defm	""
	defb	211

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	195

	defm	"20"
	defb	0

	defm	"C$2"
	defb	212

	defm	"-@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	13

	defm	" "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	"|"
	defb	5

	defm	"BD"
	defb	0

	defm	""
	defb	224

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	2

	defm	"0"
	defb	192

	defm	""
	defb	206

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	206

	defm	""
	defb	3

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	7

	defm	""
	defb	192

	defm	""
	defb	192

	defm	""
	defb	236

	defm	"0"
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	192

	defm	""
	defb	12

	defm	"3"
	defb	0

	defm	""
	defb	192

	defm	"P"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	192

	defm	"$."
	defb	224

	defm	""
	defb	210

	defm	"E"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	204

	defm	"="
	defb	192

	defm	"42"
	defb	210

	defm	"4#"
	defb	210

	defm	"=@"
	defb	0

	defm	""
	defb	4

	defm	"C"
	defb	212

	defm	""
	defb	211

	defm	"DD"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"BB"
	defb	210

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"D@"
	defb	0

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	128

	defm	""
	defb	192

	defm	""
	defb	13

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	192

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	140

	defm	""
	defb	12

	defm	""
	defb	0

	defm	"L"
	defb	12

	defm	""
	defb	8

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	204

	defm	""
	defb	192

	defm	"D"
	defb	220

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	205

	defm	"2@"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	196

	defm	""
	defb	196

	defm	"$C@"
	defb	12

	defm	""
	defb	196

	defm	"4$"
	defb	212

	defm	""
	defb	212

	defm	"=43"
	defb	210

	defm	"3"
	defb	210

	defm	"D,"
	defb	0

	defm	""
	defb	0

	defm	"p"
	defb	192

	defm	""
	defb	204

	defm	"C<"
	defb	0

	defm	"p"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	211

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	7

	defm	""
	defb	12

	defm	""
	defb	196

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	12

	defm	""
	defb	7

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	" "
	defb	204

	defm	""
	defb	199

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	195

	defm	"0"
	defb	192

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"p"
	defb	196

	defm	""
	defb	212

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	0

	defm	"p"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	194

	defm	"$"
	defb	0

	defm	"p"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	195

	defm	"M434"
	defb	211

	defm	"C"
	defb	212

	defm	""
	defb	211

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	129

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	25

	defm	""
	defb	153

	defm	"w"
	defb	153

	defm	""
	defb	136

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	129

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	"w"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	17

	defm	""
	defb	17

	defm	"q"
	defb	17

	defm	""
	defb	24

	defm	""
	defb	137

	defm	"w"
	defb	145

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	24

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	31

	defm	""
	defb	200

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	129

	defm	""
	defb	17

	defm	""
	defb	128

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	204

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	17

	defm	""
	defb	24

	defm	""
	defb	200

	defm	""
	defb	208

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	212

	defm	""
	defb	10

	defm	""
	defb	0

	defm	""
	defb	10

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	5

	defm	"\ "
	defb	0

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	252

	defm	""
	defb	196

	defm	""
	defb	0

	defm	""
	defb	10

	defm	""
	defb	0

	defm	""
	defb	10

	defm	""
	defb	12

	defm	"US<"
	defb	12

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	"D"
	defb	10

	defm	""
	defb	192

	defm	""
	defb	10

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	172

	defm	""
	defb	2

	defm	"<"
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	192

	defm	""
	defb	210

	defm	""
	defb	12

	defm	""
	defb	10

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	195

	defm	""
	defb	220

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	160

	defm	""
	defb	0

	defm	""
	defb	160

	defm	"D"
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	205

	defm	"0"
	defb	195

	defm	"B"
	defb	211

	defm	""
	defb	211

	defm	"#4 "
	defb	192

	defm	","
	defb	192

	defm	"P\"
	defb	192

	defm	"="
	defb	12

	defm	""
	defb	220

	defm	""
	defb	204

	defm	""
	defb	5

	defm	""
	defb	206

	defm	""
	defb	204

	defm	""
	defb	204

	defm	"3,"
	defb	12

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	229

	defm	""
	defb	12

	defm	""
	defb	2

	defm	"L"
	defb	199

	defm	""
	defb	192

	defm	""
	defb	197

	defm	""
	defb	14

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	210

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	192

	defm	"P\"
	defb	0

	defm	""
	defb	3

	defm	","
	defb	204

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	5

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	3

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	12

	defm	"\"
	defb	12

	defm	""
	defb	0

	defm	"C"
	defb	204

	defm	""
	defb	204

	defm	""
	defb	197

	defm	""
	defb	206

	defm	""
	defb	12

	defm	""
	defb	3

	defm	"=B"
	defb	0

	defm	"3C#M2="
	defb	211

	defm	""
	defb	0

	defm	""
	defb	204

	defm	"4"
	defb	211

	defm	"4= "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	"-@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	34

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	208

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	192

	defm	"\"
	defb	195

	defm	""
	defb	224

	defm	"pp"
	defb	192

	defm	"RR,"
	defb	0

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	206

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"0"
	defb	14

	defm	""
	defb	0

	defm	"p"
	defb	192

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	4

	defm	"2"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	210

	defm	"C4"
	defb	210

	defm	"4"
	defb	211

	defm	"4#"
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	8

	defm	""
	defb	153

	defm	""
	defb	151

	defm	"w"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	128

	defm	""
	defb	137

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	"y"
	defb	144

	defm	""
	defb	8

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	12

	defm	""
	defb	137

	defm	""
	defb	151

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	128

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	8

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	152

	defm	""
	defb	199

	defm	""
	defb	12

	defm	""
	defb	128

	defm	""
	defb	137

	defm	""
	defb	153

	defm	"w"
	defb	153

	defm	""
	defb	128

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	8

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	152

	defm	""
	defb	200

	defm	""
	defb	204

	defm	""
	defb	140

	defm	""
	defb	137

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	200

	defm	""
	defb	204

	defm	""
	defb	136

	defm	""
	defb	128

	defm	""
	defb	204

	defm	""
	defb	140

	defm	""
	defb	129

	defm	""
	defb	17

	defm	""
	defb	140

	defm	""
	defb	137

	defm	""
	defb	152

	defm	""
	defb	192

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	200

	defm	""
	defb	153

	defm	""
	defb	140

	defm	""
	defb	192

	defm	""
	defb	176

	defm	""
	defb	188

	defm	""
	defb	204

	defm	""
	defb	140

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	192

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	176

	defm	""
	defb	188

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	128

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	0

	defm	""
	defb	176

	defm	""
	defb	188

	defm	""
	defb	128

	defm	""
	defb	128

	defm	""
	defb	140

	defm	""
	defb	204

	defm	""
	defb	140

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	204

	defm	""
	defb	200

	defm	""
	defb	192

	defm	""
	defb	188

	defm	""
	defb	188

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	200

	defm	"<"
	defb	204

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	192

	defm	"2"
	defb	202

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	192

	defm	""
	defb	194

	defm	"<"
	defb	204

	defm	""
	defb	204

	defm	""
	defb	172

	defm	""
	defb	12

	defm	""
	defb	172

	defm	""
	defb	192

	defm	"42C#"
	defb	34

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	196

	defm	"<"
	defb	202

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	195

	defm	""
	defb	12

	defm	""
	defb	192

	defm	"2"
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	172

	defm	""
	defb	194

	defm	""
	defb	202

	defm	""
	defb	194

	defm	"L"
	defb	10

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	12

	defm	"2"
	defb	192

	defm	"3"
	defb	12

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	196

	defm	"M"
	defb	12

	defm	""
	defb	12

	defm	""
	defb	172

	defm	""
	defb	204

	defm	""
	defb	172

	defm	""
	defb	205

	defm	"3$"
	defb	211

	defm	""
	defb	210

	defm	"C"
	defb	212

	defm	"24=@"
	defb	3

	defm	"M3"
	defb	212

	defm	"4M@"
	defb	0

	defm	""
	defb	5

	defm	",0"
	defb	0

	defm	""
	defb	4

	defm	"@"
	defb	192

	defm	""
	defb	12

	defm	""
	defb	206

	defm	""
	defb	192

	defm	"*"
	defb	0

	defm	""
	defb	13

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	236

	defm	""
	defb	236

	defm	""
	defb	204

	defm	""
	defb	12

	defm	"0"
	defb	204

	defm	""
	defb	0

	defm	"S"
	defb	3

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	13

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	4

	defm	" 0l"
	defb	192

	defm	"@"
	defb	192

	defm	""
	defb	5

	defm	""
	defb	12

	defm	""
	defb	195

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	205

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	2

	defm	""
	defb	12

	defm	"0"
	defb	204

	defm	"lL"
	defb	204

	defm	""
	defb	192

	defm	""
	defb	2

	defm	"C"
	defb	12

	defm	""
	defb	204

	defm	""
	defb	205

	defm	"=D"
	defb	212

	defm	"=D=D4"
	defb	212

	defm	"#D4D44"
	defb	0

	defm	""
	defb	192

	defm	"B@"
	defb	0

	defm	""
	defb	0

	defm	"4"
	defb	0

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	5

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"<"
	defb	204

	defm	"l"
	defb	0

	defm	""
	defb	160

	defm	""
	defb	0

	defm	"`"
	defb	4

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	"<`"
	defb	192

	defm	"l"
	defb	192

	defm	"`"
	defb	12

	defm	"4"
	defb	204

	defm	""
	defb	204

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	12

	defm	""
	defb	2

	defm	"L"
	defb	204

	defm	""
	defb	160

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	204

	defm	""
	defb	160

	defm	"C"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	""
	defb	0

	defm	""
	defb	4

	defm	"4$#CB$4D4"
	defb	140

	defm	""
	defb	140

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	140

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	128

	defm	""
	defb	8

	defm	""
	defb	12

	defm	""
	defb	128

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	128

	defm	""
	defb	8

	defm	""
	defb	204

	defm	""
	defb	128

	defm	""
	defb	8

	defm	""
	defb	136

	defm	""
	defb	128

	defm	""
	defb	200

	defm	""
	defb	0

	defm	""
	defb	136

	defm	""
	defb	200

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	204

	defm	""
	defb	128

	defm	""
	defb	8

	defm	""
	defb	192

	defm	""
	defb	128

	defm	""
	defb	0

	defm	"w"
	defb	204

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	128

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	204

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	7

	defm	""
	defb	140

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	7

	defm	"wp"
	defb	0

	defm	""
	defb	8

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	172

	defm	""
	defb	10

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	200

	defm	""
	defb	204

	defm	""
	defb	204

	defm	""
	defb	0

	defm	""
	defb	140

	defm	""
	defb	140

	defm	""
	defb	128

	defm	""
	defb	140

	defm	""
	defb	128

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	200

	defm	""
	defb	8

	defm	""
	defb	10

	defm	""
	defb	204

	defm	""
	defb	160

	defm	""
	defb	128

	defm	""
	defb	140

	defm	""
	defb	128

	defm	""
	defb	128

	defm	""
	defb	128

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	128

	defm	""
	defb	128

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	135

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	200

	defm	""
	defb	12

	defm	""
	defb	204

	defm	"x"
	defb	0

	defm	""
	defb	0

	defm	"w"
	defb	0

	defm	""
	defb	204

	defm	""
	defb	204

	defm	"w"
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

	defm	""
	defb	136

;	SECTION	code


;	SECTION	text

._cerrojos
	defb	2
	defb	7
	defb	5
	defb	0
	defb	14
	defb	12
	defb	7
	defb	0
	defb	15
	defb	12
	defb	2
	defb	0

;	SECTION	code

	._tileset
	BINARY "tileset.bin"
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_1_a
	defb 0, 255
	defb 7, 248
	defb 8, 240
	defb 16, 224
	defb 16, 224
	defb 96, 128
	defb 144, 0
	defb 144, 0
	defb 160, 0
	defb 129, 0
	defb 97, 128
	defb 26, 224
	defb 3, 248
	defb 7, 224
	defb 23, 192
	defb 30, 192
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_1_b
	defb 0, 255
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 4, 3
	defb 4, 3
	defb 104, 7
	defb 160, 15
	defb 160, 15
	defb 96, 15
	defb 128, 31
	defb 192, 15
	defb 96, 15
	defb 144, 7
	defb 120, 3
	defb 28, 193
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_1_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_2_a
	defb 7, 248
	defb 8, 240
	defb 16, 224
	defb 16, 224
	defb 96, 128
	defb 144, 0
	defb 144, 0
	defb 160, 0
	defb 129, 0
	defb 99, 128
	defb 26, 224
	defb 3, 248
	defb 5, 240
	defb 6, 240
	defb 3, 248
	defb 3, 248
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_2_b
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 4, 3
	defb 4, 3
	defb 104, 7
	defb 160, 15
	defb 160, 15
	defb 96, 15
	defb 128, 31
	defb 224, 15
	defb 96, 15
	defb 64, 31
	defb 128, 63
	defb 128, 63
	defb 192, 31
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_2_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_3_a
	defb 7, 248
	defb 8, 240
	defb 16, 224
	defb 32, 192
	defb 32, 192
	defb 22, 224
	defb 5, 240
	defb 5, 240
	defb 6, 240
	defb 1, 248
	defb 7, 240
	defb 6, 240
	defb 2, 248
	defb 1, 252
	defb 1, 252
	defb 3, 248
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_3_b
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 8, 7
	defb 6, 1
	defb 9, 0
	defb 9, 0
	defb 5, 0
	defb 129, 0
	defb 198, 1
	defb 88, 7
	defb 192, 31
	defb 160, 15
	defb 96, 15
	defb 192, 31
	defb 192, 31
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_3_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_4_a
	defb 0, 255
	defb 7, 248
	defb 8, 240
	defb 16, 224
	defb 32, 192
	defb 32, 192
	defb 22, 224
	defb 5, 240
	defb 5, 240
	defb 6, 240
	defb 1, 248
	defb 3, 240
	defb 6, 240
	defb 9, 224
	defb 30, 192
	defb 56, 131
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_4_b
	defb 0, 255
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 8, 7
	defb 6, 1
	defb 9, 0
	defb 9, 0
	defb 5, 0
	defb 129, 0
	defb 134, 1
	defb 88, 7
	defb 192, 31
	defb 224, 7
	defb 232, 3
	defb 120, 3
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_4_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_5_a
	defb 7, 248
	defb 24, 224
	defb 32, 192
	defb 64, 128
	defb 64, 128
	defb 64, 128
	defb 64, 128
	defb 32, 192
	defb 16, 224
	defb 12, 240
	defb 11, 224
	defb 27, 192
	defb 27, 192
	defb 0, 224
	defb 2, 248
	defb 0, 252
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_5_b
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 4, 3
	defb 4, 3
	defb 14, 1
	defb 17, 0
	defb 1, 0
	defb 2, 1
	defb 24, 3
	defb 236, 1
	defb 228, 1
	defb 112, 3
	defb 96, 15
	defb 128, 31
	defb 224, 15
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_5_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_6_a
	defb 7, 248
	defb 24, 224
	defb 32, 192
	defb 64, 128
	defb 64, 128
	defb 64, 128
	defb 64, 128
	defb 32, 192
	defb 16, 224
	defb 12, 192
	defb 55, 128
	defb 39, 128
	defb 14, 192
	defb 6, 240
	defb 1, 248
	defb 7, 240
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_6_b
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 4, 3
	defb 4, 3
	defb 14, 1
	defb 17, 0
	defb 1, 0
	defb 2, 1
	defb 12, 3
	defb 208, 7
	defb 216, 3
	defb 216, 3
	defb 0, 7
	defb 64, 31
	defb 0, 63
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_6_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_7_a
	defb 7, 248
	defb 24, 224
	defb 32, 192
	defb 80, 128
	defb 64, 128
	defb 71, 128
	defb 69, 128
	defb 37, 192
	defb 19, 224
	defb 12, 240
	defb 3, 224
	defb 27, 192
	defb 24, 192
	defb 2, 224
	defb 2, 248
	defb 0, 252
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_7_b
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 4, 3
	defb 4, 3
	defb 6, 1
	defb 165, 0
	defb 161, 0
	defb 194, 1
	defb 24, 3
	defb 236, 1
	defb 100, 1
	defb 16, 3
	defb 96, 15
	defb 192, 31
	defb 224, 15
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_7_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_8_a
	defb 7, 248
	defb 24, 224
	defb 32, 192
	defb 80, 128
	defb 64, 128
	defb 71, 128
	defb 69, 128
	defb 37, 192
	defb 3, 224
	defb 24, 192
	defb 55, 128
	defb 38, 128
	defb 8, 192
	defb 6, 240
	defb 3, 248
	defb 7, 240
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_8_b
	defb 224, 31
	defb 16, 15
	defb 8, 7
	defb 4, 3
	defb 4, 3
	defb 6, 1
	defb 165, 0
	defb 161, 0
	defb 194, 1
	defb 28, 3
	defb 192, 7
	defb 216, 3
	defb 24, 3
	defb 64, 7
	defb 64, 31
	defb 0, 63
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_8_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_9_a
	defb 0, 254
	defb 0, 248
	defb 3, 240
	defb 7, 224
	defb 6, 224
	defb 6, 224
	defb 6, 224
	defb 3, 240
	defb 0, 192
	defb 31, 128
	defb 49, 128
	defb 35, 128
	defb 49, 128
	defb 2, 128
	defb 4, 192
	defb 28, 193
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_9_b
	defb 0, 63
	defb 128, 15
	defb 224, 7
	defb 240, 3
	defb 176, 3
	defb 176, 3
	defb 176, 3
	defb 224, 7
	defb 0, 1
	defb 252, 0
	defb 198, 0
	defb 194, 16
	defb 70, 0
	defb 160, 0
	defb 32, 7
	defb 48, 131
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_9_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_10_a
	defb 0, 252
	defb 1, 240
	defb 7, 224
	defb 15, 192
	defb 13, 192
	defb 13, 192
	defb 13, 192
	defb 7, 224
	defb 0, 128
	defb 63, 0
	defb 99, 0
	defb 67, 8
	defb 98, 0
	defb 5, 0
	defb 4, 224
	defb 12, 193
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_10_b
	defb 0, 127
	defb 0, 31
	defb 192, 15
	defb 224, 7
	defb 96, 7
	defb 96, 7
	defb 96, 7
	defb 192, 15
	defb 0, 3
	defb 248, 1
	defb 140, 1
	defb 196, 1
	defb 140, 1
	defb 64, 1
	defb 32, 3
	defb 56, 131
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_10_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_11_a
	defb 0, 255
	defb 0, 255
	defb 3, 252
	defb 4, 248
	defb 10, 240
	defb 16, 224
	defb 19, 224
	defb 21, 224
	defb 23, 224
	defb 16, 224
	defb 35, 192
	defb 88, 128
	defb 168, 16
	defb 73, 176
	defb 16, 224
	defb 31, 224
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_11_b
	defb 0, 255
	defb 0, 255
	defb 224, 31
	defb 16, 15
	defb 136, 7
	defb 4, 3
	defb 132, 3
	defb 68, 3
	defb 194, 1
	defb 1, 0
	defb 129, 0
	defb 1, 0
	defb 5, 0
	defb 197, 0
	defb 133, 0
	defb 250, 5
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_11_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_12_a
	defb 0, 255
	defb 0, 255
	defb 7, 248
	defb 8, 240
	defb 17, 224
	defb 32, 192
	defb 33, 192
	defb 34, 192
	defb 67, 128
	defb 128, 0
	defb 129, 0
	defb 128, 0
	defb 160, 0
	defb 163, 0
	defb 161, 0
	defb 95, 160
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_12_b
	defb 0, 255
	defb 0, 255
	defb 192, 63
	defb 32, 31
	defb 80, 15
	defb 8, 7
	defb 200, 7
	defb 168, 7
	defb 232, 7
	defb 8, 7
	defb 196, 3
	defb 26, 1
	defb 21, 8
	defb 146, 13
	defb 8, 7
	defb 248, 7
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_12_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_13_a
	defb 96, 0
	defb 125, 0
	defb 61, 0
	defb 96, 0
	defb 7, 0
	defb 14, 160
	defb 71, 0
	defb 103, 0
	defb 39, 0
	defb 61, 0
	defb 30, 128
	defb 15, 192
	defb 5, 224
	defb 2, 192
	defb 28, 192
	defb 16, 193
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_13_b
	defb 6, 0
	defb 190, 0
	defb 188, 0
	defb 6, 0
	defb 224, 0
	defb 160, 15
	defb 224, 12
	defb 2, 0
	defb 242, 0
	defb 246, 0
	defb 12, 0
	defb 248, 1
	defb 80, 3
	defb 168, 1
	defb 8, 1
	defb 12, 225
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_13_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_14_a
	defb 96, 0
	defb 125, 0
	defb 61, 0
	defb 96, 0
	defb 7, 0
	defb 5, 240
	defb 7, 48
	defb 64, 0
	defb 79, 0
	defb 111, 0
	defb 48, 0
	defb 31, 128
	defb 10, 192
	defb 21, 128
	defb 16, 128
	defb 48, 135
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_14_b
	defb 6, 0
	defb 190, 0
	defb 188, 0
	defb 6, 0
	defb 224, 0
	defb 112, 5
	defb 226, 0
	defb 230, 0
	defb 228, 0
	defb 188, 0
	defb 120, 1
	defb 240, 3
	defb 160, 7
	defb 64, 3
	defb 56, 3
	defb 8, 131
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_14_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_15_a
	defb 0, 255
	defb 0, 255
	defb 0, 254
	defb 0, 224
	defb 7, 192
	defb 14, 128
	defb 28, 128
	defb 28, 128
	defb 15, 192
	defb 7, 128
	defb 48, 0
	defb 96, 7
	defb 112, 1
	defb 60, 0
	defb 31, 128
	defb 7, 192
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_15_b
	defb 0, 131
	defb 56, 1
	defb 84, 1
	defb 120, 1
	defb 224, 1
	defb 124, 1
	defb 0, 1
	defb 0, 63
	defb 128, 3
	defb 240, 1
	defb 124, 0
	defb 30, 0
	defb 14, 192
	defb 30, 0
	defb 248, 0
	defb 192, 1
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_15_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_16_a
	defb 0, 255
	defb 0, 255
	defb 0, 254
	defb 0, 252
	defb 0, 224
	defb 7, 192
	defb 14, 128
	defb 28, 128
	defb 15, 192
	defb 7, 224
	defb 24, 128
	defb 48, 0
	defb 56, 0
	defb 30, 0
	defb 15, 192
	defb 3, 224
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_16_b
	defb 0, 255
	defb 0, 7
	defb 112, 3
	defb 168, 3
	defb 240, 3
	defb 192, 3
	defb 248, 3
	defb 0, 3
	defb 0, 15
	defb 224, 3
	defb 248, 1
	defb 60, 0
	defb 28, 0
	defb 56, 1
	defb 240, 3
	defb 128, 7
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_16_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_18_a
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_b
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_c
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
;	SECTION	text

._malotes
	defb	16
	defb	32
	defb	16
	defb	32
	defb	48
	defb	128
	defb	2
	defb	2
	defb	3
	defb	160
	defb	16
	defb	160
	defb	16
	defb	160
	defb	128
	defb	0
	defb	1
	defb	1
	defb	176
	defb	128
	defb	176
	defb	16
	defb	176
	defb	128
	defb	0
	defb	-1
	defb	2
	defb	128
	defb	128
	defb	16
	defb	128
	defb	128
	defb	128
	defb	-1
	defb	0
	defb	4
	defb	144
	defb	16
	defb	144
	defb	16
	defb	144
	defb	80
	defb	0
	defb	1
	defb	2
	defb	48
	defb	16
	defb	48
	defb	16
	defb	48
	defb	80
	defb	0
	defb	1
	defb	3
	defb	128
	defb	16
	defb	128
	defb	16
	defb	192
	defb	16
	defb	1
	defb	0
	defb	1
	defb	128
	defb	80
	defb	128
	defb	80
	defb	128
	defb	128
	defb	0
	defb	1
	defb	2
	defb	32
	defb	48
	defb	32
	defb	48
	defb	48
	defb	128
	defb	1
	defb	1
	defb	3
	defb	16
	defb	112
	defb	16
	defb	112
	defb	112
	defb	112
	defb	1
	defb	0
	defb	3
	defb	128
	defb	112
	defb	128
	defb	112
	defb	192
	defb	112
	defb	1
	defb	0
	defb	2
	defb	176
	defb	128
	defb	32
	defb	128
	defb	176
	defb	128
	defb	-1
	defb	0
	defb	4
	defb	208
	defb	16
	defb	208
	defb	16
	defb	208
	defb	128
	defb	0
	defb	1
	defb	1
	defb	128
	defb	80
	defb	128
	defb	48
	defb	128
	defb	80
	defb	0
	defb	-1
	defb	2
	defb	16
	defb	112
	defb	16
	defb	112
	defb	64
	defb	112
	defb	1
	defb	0
	defb	4
	defb	96
	defb	64
	defb	96
	defb	16
	defb	96
	defb	64
	defb	0
	defb	-1
	defb	2
	defb	128
	defb	16
	defb	128
	defb	16
	defb	128
	defb	112
	defb	0
	defb	2
	defb	3
	defb	16
	defb	112
	defb	16
	defb	112
	defb	112
	defb	112
	defb	1
	defb	0
	defb	4
	defb	208
	defb	64
	defb	16
	defb	64
	defb	208
	defb	64
	defb	-2
	defb	0
	defb	3
	defb	48
	defb	32
	defb	48
	defb	32
	defb	208
	defb	32
	defb	1
	defb	0
	defb	4
	defb	208
	defb	112
	defb	32
	defb	112
	defb	208
	defb	112
	defb	-1
	defb	0
	defb	2
	defb	128
	defb	128
	defb	128
	defb	16
	defb	128
	defb	128
	defb	0
	defb	-1
	defb	3
	defb	160
	defb	32
	defb	160
	defb	32
	defb	160
	defb	128
	defb	0
	defb	1
	defb	2
	defb	48
	defb	32
	defb	48
	defb	16
	defb	48
	defb	32
	defb	0
	defb	0
	defb	4
	defb	32
	defb	32
	defb	32
	defb	32
	defb	80
	defb	32
	defb	1
	defb	0
	defb	2
	defb	96
	defb	32
	defb	96
	defb	32
	defb	128
	defb	32
	defb	1
	defb	0
	defb	1
	defb	144
	defb	32
	defb	144
	defb	32
	defb	208
	defb	32
	defb	1
	defb	0
	defb	3
	defb	208
	defb	128
	defb	208
	defb	16
	defb	208
	defb	128
	defb	0
	defb	-1
	defb	3
	defb	48
	defb	96
	defb	48
	defb	96
	defb	144
	defb	96
	defb	1
	defb	0
	defb	2
	defb	64
	defb	16
	defb	48
	defb	16
	defb	64
	defb	32
	defb	-1
	defb	1
	defb	2
	defb	208
	defb	48
	defb	64
	defb	48
	defb	208
	defb	48
	defb	-1
	defb	0
	defb	1
	defb	16
	defb	96
	defb	16
	defb	96
	defb	192
	defb	96
	defb	1
	defb	0
	defb	2
	defb	16
	defb	16
	defb	16
	defb	16
	defb	32
	defb	16
	defb	0
	defb	0
	defb	3
	defb	32
	defb	16
	defb	32
	defb	16
	defb	192
	defb	128
	defb	2
	defb	2
	defb	3
	defb	160
	defb	16
	defb	16
	defb	16
	defb	160
	defb	96
	defb	-1
	defb	1
	defb	1
	defb	208
	defb	48
	defb	128
	defb	48
	defb	208
	defb	128
	defb	-1
	defb	1
	defb	3
	defb	32
	defb	32
	defb	32
	defb	32
	defb	64
	defb	96
	defb	1
	defb	1
	defb	1
	defb	64
	defb	16
	defb	64
	defb	16
	defb	160
	defb	32
	defb	1
	defb	1
	defb	2
	defb	192
	defb	48
	defb	160
	defb	48
	defb	192
	defb	112
	defb	-1
	defb	1
	defb	3
	defb	80
	defb	16
	defb	80
	defb	16
	defb	80
	defb	128
	defb	0
	defb	1
	defb	1
	defb	128
	defb	112
	defb	128
	defb	32
	defb	128
	defb	112
	defb	0
	defb	-1
	defb	4
	defb	176
	defb	16
	defb	176
	defb	16
	defb	176
	defb	112
	defb	0
	defb	1
	defb	2
	defb	208
	defb	16
	defb	16
	defb	16
	defb	208
	defb	16
	defb	-2
	defb	0
	defb	3
	defb	16
	defb	112
	defb	16
	defb	112
	defb	176
	defb	112
	defb	2
	defb	0
	defb	3
	defb	96
	defb	48
	defb	16
	defb	48
	defb	96
	defb	48
	defb	-1
	defb	0
	defb	4
	defb	16
	defb	32
	defb	16
	defb	32
	defb	16
	defb	112
	defb	0
	defb	2
	defb	3
	defb	112
	defb	16
	defb	112
	defb	16
	defb	112
	defb	96
	defb	0
	defb	1
	defb	2
	defb	160
	defb	48
	defb	160
	defb	48
	defb	160
	defb	112
	defb	0
	defb	1
	defb	4
	defb	128
	defb	16
	defb	128
	defb	16
	defb	128
	defb	128
	defb	0
	defb	2
	defb	1
	defb	96
	defb	16
	defb	96
	defb	16
	defb	96
	defb	128
	defb	0
	defb	2
	defb	2
	defb	16
	defb	64
	defb	16
	defb	64
	defb	96
	defb	112
	defb	1
	defb	1
	defb	3
	defb	32
	defb	32
	defb	32
	defb	32
	defb	192
	defb	32
	defb	1
	defb	0
	defb	1
	defb	160
	defb	48
	defb	160
	defb	48
	defb	192
	defb	128
	defb	2
	defb	2
	defb	2
	defb	176
	defb	112
	defb	32
	defb	112
	defb	176
	defb	128
	defb	-1
	defb	1
	defb	3
	defb	48
	defb	32
	defb	48
	defb	32
	defb	144
	defb	48
	defb	1
	defb	1
	defb	2
	defb	144
	defb	112
	defb	48
	defb	112
	defb	144
	defb	112
	defb	-1
	defb	0
	defb	4
	defb	16
	defb	16
	defb	16
	defb	16
	defb	16
	defb	128
	defb	0
	defb	1
	defb	1
	defb	48
	defb	16
	defb	48
	defb	16
	defb	80
	defb	80
	defb	1
	defb	1
	defb	1
	defb	32
	defb	80
	defb	32
	defb	80
	defb	48
	defb	80
	defb	1
	defb	0
	defb	2
	defb	32
	defb	112
	defb	32
	defb	112
	defb	32
	defb	112
	defb	0
	defb	0
	defb	4
	defb	64
	defb	64
	defb	64
	defb	64
	defb	64
	defb	128
	defb	0
	defb	1
	defb	2
	defb	96
	defb	112
	defb	96
	defb	64
	defb	96
	defb	112
	defb	0
	defb	-1
	defb	3
	defb	208
	defb	112
	defb	208
	defb	16
	defb	208
	defb	112
	defb	0
	defb	-1
	defb	4
	defb	16
	defb	128
	defb	16
	defb	16
	defb	96
	defb	128
	defb	2
	defb	-2
	defb	2
	defb	192
	defb	16
	defb	192
	defb	16
	defb	192
	defb	128
	defb	0
	defb	1
	defb	1
	defb	160
	defb	128
	defb	160
	defb	48
	defb	160
	defb	128
	defb	0
	defb	-1
	defb	3
	defb	32
	defb	16
	defb	32
	defb	16
	defb	96
	defb	128
	defb	1
	defb	1
	defb	4
	defb	128
	defb	16
	defb	128
	defb	16
	defb	128
	defb	128
	defb	0
	defb	1
	defb	2
	defb	192
	defb	16
	defb	192
	defb	16
	defb	192
	defb	112
	defb	0
	defb	1
	defb	3
	defb	32
	defb	112
	defb	32
	defb	112
	defb	208
	defb	112
	defb	1
	defb	0
	defb	4
	defb	208
	defb	80
	defb	208
	defb	16
	defb	208
	defb	80
	defb	0
	defb	-1
	defb	1
	defb	112
	defb	32
	defb	16
	defb	32
	defb	112
	defb	32
	defb	-1
	defb	0
	defb	2
	defb	112
	defb	112
	defb	16
	defb	112
	defb	112
	defb	112
	defb	-1
	defb	0
	defb	2
	defb	32
	defb	80
	defb	32
	defb	16
	defb	32
	defb	80
	defb	0
	defb	-1
	defb	4
	defb	80
	defb	80
	defb	80
	defb	32
	defb	80
	defb	80
	defb	0
	defb	-1
	defb	2

;	SECTION	code

;	SECTION	text

._hotspots
	defb	17
	defb	2
	defb	0
	defb	85
	defb	1
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	113
	defb	1
	defb	0
	defb	0
	defb	0
	defb	0
	defb	151
	defb	1
	defb	0
	defb	18
	defb	1
	defb	0
	defb	33
	defb	1
	defb	0
	defb	214
	defb	1
	defb	0
	defb	209
	defb	1
	defb	0
	defb	0
	defb	0
	defb	0
	defb	212
	defb	1
	defb	0
	defb	210
	defb	1
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	defb	72
	defb	2
	defb	0
	defb	49
	defb	1
	defb	0
	defb	114
	defb	1
	defb	0
	defb	23
	defb	1
	defb	0
	defb	102
	defb	1
	defb	0
	defb	210
	defb	2
	defb	0
	defb	130
	defb	1
	defb	0
	defb	0
	defb	0
	defb	0

;	SECTION	code

	.sound_play
	ld hl, soundEffectsData ;address of sound effects data
	push iy
	ld b,0
	ld c,a
	add hl,bc
	add hl,bc
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	push hl
	pop ix ;put it into ix
	.readData
	ld a,(ix+0) ;read block type
	or a
	jr nz,readData_sound
	pop iy
	ret
	.readData_sound
	ld c,(ix+1) ;read duration 1
	ld b,(ix+2)
	ld e,(ix+3) ;read duration 2
	ld d,(ix+4)
	push de
	pop iy
	dec a
	jr nz,sfxRoutineNoise
	;this routine generate tone with many parameters
	.sfxRoutineTone
	ld e,(ix+5) ;freq
	ld d,(ix+6)
	ld a,(ix+9) ;duty
	ld (sfxRoutineTone_duty + 1),a
	ld hl,0
	.sfxRoutineTone_l0
	push bc
	push iy
	pop bc
	.sfxRoutineTone_l1
	add hl,de
	ld a,h
	.sfxRoutineTone_duty
	cp 0
	sbc a,a
	and 16
	.sfxRoutineTone_border
	or 0
	out ($fe),a
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineTone_l1
	ld a,(sfxRoutineTone_duty + 1)
	add a,(ix+10) ;duty change
	ld (sfxRoutineTone_duty + 1),a
	ld c,(ix+7) ;slide
	ld b,(ix+8)
	ex de,hl
	add hl,bc
	ex de,hl
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineTone_l0
	ld c,11
	.nextData
	add ix,bc ;skip to the next block
	jr readData
	;this routine generate noise with two parameters
	.sfxRoutineNoise
	ld e,(ix+5) ;pitch
	ld d,1
	ld h,d
	ld l,d
	.sfxRoutineNoise_l0
	push bc
	push iy
	pop bc
	.sfxRoutineNoise_l1
	ld a,(hl)
	and 16
	.sfxRoutineNoise_border
	or 0
	out ($fe),a
	dec d
	jr nz,sfxRoutineNoise_l2
	ld d,e
	inc hl
	ld a,h
	and $1f
	ld h,a
	.sfxRoutineNoise_l2
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineNoise_l1
	ld a,e
	add a,(ix+6) ;slide
	ld e,a
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineNoise_l0
	ld c,7
	jr nextData
	.soundEffectsData
	defw soundEffectsData_sfx0
	defw soundEffectsData_sfx1
	defw soundEffectsData_sfx2
	defw soundEffectsData_sfx3
	defw soundEffectsData_sfx4
	defw soundEffectsData_sfx5
	defw soundEffectsData_sfx6
	defw soundEffectsData_sfx7
	defw soundEffectsData_sfx8
	defw soundEffectsData_sfx9
	defw soundEffectsData_sfx10
	defw soundEffectsData_sfx11
	.soundEffectsData_sfx0
	defb 0x01
	defw 0x000a,0x03e8,0x00c8,0x0016,0x1680
	defb 0x00
	.soundEffectsData_sfx1
	defb 0x01
	defw 0x0064,0x0014,0x01f4,0x0002,0x0010
	defb 0x00
	.soundEffectsData_sfx2
	defb 0x02
	defw 0x0001,0x03e8,0x000a
	defb 0x01
	defw 0x0014,0x0064,0x0190,0xfff0,0x0080
	defb 0x02
	defw 0x0001,0x07d0,0x0001
	defb 0x00
	.soundEffectsData_sfx3
	defb 0x01
	defw 0x0014,0x00c8,0x0d48,0x000a,0x0040
	defb 0x00
	.soundEffectsData_sfx4
	defb 0x01
	defw 0x0050,0x0014,0x03e8,0xffff,0x0080
	defb 0x00
	.soundEffectsData_sfx5
	defb 0x01
	defw 0x0004,0x03e8,0x03e8,0x0190,0x0080
	defb 0x00
	.soundEffectsData_sfx6
	defb 0x01
	defw 0x0002,0x0fa0,0x0190,0x00c8,0x0040
	defb 0x01
	defw 0x0002,0x0fa0,0x00c8,0x00c8,0x0020
	defb 0x00
	.soundEffectsData_sfx7
	defb 0x01
	defw 0x000a,0x03e8,0x00c8,0x0002,0x0010
	defb 0x01
	defw 0x0001,0x0fa0,0x0000,0x0000,0x0000
	defb 0x01
	defw 0x000a,0x03e8,0x00c8,0xfffe,0x0010
	defb 0x01
	defw 0x0001,0x07d0,0x0000,0x0000,0x0000
	defb 0x01
	defw 0x000a,0x03e8,0x00b4,0xfffe,0x0010
	defb 0x01
	defw 0x0001,0x0fa0,0x0000,0x0000,0x0000
	defb 0x00
	.soundEffectsData_sfx8
	defb 0x02
	defw 0x0001,0x03e8,0x0014
	defb 0x01
	defw 0x0001,0x03e8,0x0000,0x0000,0x0000
	defb 0x02
	defw 0x0001,0x03e8,0x0001
	defb 0x00
	.soundEffectsData_sfx9
	defb 0x02
	defw 0x0014,0x0032,0x0101
	defb 0x00
	.soundEffectsData_sfx10
	defb 0x02
	defw 0x0064,0x01f4,0x0264
	defb 0x00
	.soundEffectsData_sfx11
	defb 0x01
	defw 0x0014,0x01f4,0x00c8,0x0005,0x0110
	defb 0x01
	defw 0x0001,0x03e8,0x0000,0x0000,0x0000
	defb 0x01
	defw 0x001e,0x01f4,0x00c8,0x0008,0x0110
	defb 0x01
	defw 0x0001,0x07d0,0x0000,0x0000,0x0000
	defb 0x00

._play_sfx
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	(_asm_int),hl
	push ix
	push iy
	ld a, (_asm_int)
	call sound_play
	pop ix
	pop iy
	ret



._beepet
	push ix
	push iy
	ld a, 6
	call sound_play
	ld a, 3
	call sound_play
	ld a, 6
	call sound_play
	ld a, 3
	call sound_play
	ld a, 6
	call sound_play
	ld a, 3
	call sound_play
	ld a, 6
	call sound_play
	ld a, 3
	call sound_play
	pop iy
	pop ix
	ret



._draw_rectangle
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_pti),a
	jp	i_20
.i_18
	ld	hl,_pti
	ld	a,(hl)
	inc	(hl)
.i_20
	ld	hl,(_pti)
	ld	h,0
	ex	de,hl
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ule
	jp	nc,i_19
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_ptj),a
	jp	i_23
.i_21
	ld	hl,_ptj
	ld	a,(hl)
	inc	(hl)
.i_23
	ld	hl,(_ptj)
	ld	h,0
	ex	de,hl
	ld	hl,8-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ule
	jp	nc,i_22
	ld	hl,(_pti)
	ld	h,0
	push	hl
	ld	hl,(_ptj)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_21
.i_22
	jp	i_18
.i_19
	ret



._attr
	ld hl, 4
	add hl, sp
	ld c, (hl)
	dec hl
	dec hl
	ld a, (hl)
	._attr_2
	cp 10
	jr c, _attr_1
	ld hl, 0
	ret
	._attr_1
	ld b, a
	ld a, c
	cp 15
	jr c, _attr_1b
	ld hl, 0
	ret
	._attr_1b
	ld a, b
	sla a
	sla a
	sla a
	sla a
	sub b
	add c
	ld d, 0
	ld e, a
	ld hl, _map_attr
	add hl, de
	ld l, (hl)
	._attr_end
	ld h, 0
	ret



._qtile
	ld hl, 4
	add hl, sp
	ld c, (hl)
	dec hl
	dec hl
	ld a, (hl)
	.qtile_do
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	add c
	ld d, 0
	ld e, a
	ld hl, _map_buff
	add hl, de
	ld l, (hl)
	ld h, 0
	ret



._draw_coloured_tile
	; Copy params for speed & size
	ld hl, 6
	add hl, sp
	ld a, (hl)
	ld (__x), a
	dec hl
	dec hl
	ld a, (hl)
	ld (__y), a
	dec hl
	dec hl
	ld a, (hl)
	ld (__t), a
	._draw_coloured_tile_do
	ld a, (__x)
	ld c, a
	ld a, (__y)
	call SPCompDListAddr
	ex de, hl
	ld a, (__t)
	sla a
	sla a
	add 64
	ld hl, _tileset + 2048
	ld b, 0
	ld c, a
	add hl, bc
	ld c, a
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc de
	inc a
	ld c, a
	inc de
	inc de
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc a
	ex de, hl
	ld bc, 123
	add hl, bc
	ex de, hl
	ld c, a
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc de
	inc a
	ld c, a
	inc de
	inc de
	ld a, (hl)
	ld (de), a
	inc de
	ld a, c
	ld (de), a
	ld a, (__x)
	ld c, a
	inc a
	ld e, a
	ld a, (__y)
	ld b, a
	inc a
	ld d, a
	ld iy, fsClipStruct
	call SPInvalidate
	ret



._set_map_tile
	; Copy params for speed & size
	ld hl, 8
	add hl, sp
	ld a, (hl)
	ld (__x), a
	ld c, a
	dec hl
	dec hl
	ld a, (hl)
	ld (__y), a
	dec hl
	dec hl
	ld a, (hl)
	ld (__t), a
	dec hl
	dec hl
	ld a, (hl)
	ld (__n), a
	.set_map_tile_do
	ld a, (__y)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	add c
	ld b, 0
	ld c, a
	ld hl, _map_buff
	add hl, bc
	ld a, (__t)
	ld (hl), a
	ld hl, _map_attr
	add hl, bc
	ld a, (__n)
	ld (hl), a
	ld a, (__x)
	sla a
	add 0
	ld (__x), a
	ld a, (__y)
	sla a
	add 2
	ld (__y), a
	jp _draw_coloured_tile_do
	ret



._draw_2_digits
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,71 % 256	;const
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,100	;const
	call	l_div_u
	ld	hl,10	;const
	call	l_div_u
	ld	de,16
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,71 % 256	;const
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	ld	de,16
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ret



._draw_text
.i_24
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_25
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,10	;const
	add	hl,sp
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	dec	l
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	call	l_gint	;
	call	l_gchar
	ld	bc,-32
	add	hl,bc
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	de
	pop	hl
	inc	hl
	push	hl
	push	de
	dec	hl
	jp	i_24
.i_25
	ret



._any_key
	ld hl, 0
	xor a
	in a, (0xfe)
	and 0x1f
	cp 0x1f
	ret z
	ld l, 1
	ret



._espera_activa
.i_26
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	inc	hl
	ld	a,h
	or	l
	jp	z,i_27
	ld	hl,250 % 256	;const
	ld	a,l
	ld	(_rdd),a
.i_30
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_rdi),a
.i_28
	ld	hl,_rdd
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_30
.i_29
	call	_any_key
	ld	a,h
	or	l
	jr	nz,i_27
.i_31
	jp	i_26
.i_27
	ret


	._s_title
	BINARY "title.bin"
	._s_marco
	._s_ending
	BINARY "ending.bin"

._unpack
	call blackout
	ld hl, (_asm_int)
	ld de, 16384
	jp depack
	.blackout
	ld hl, 22528
	ld de, 22529
	ld bc, 767
	xor a
	ld (hl), a
	ldir
	ret
	ret



._title_screen
	call	sp_UpdateNow
	ld	hl,_s_title
	ld	(_asm_int),hl
	call	_unpack
	; Music generated by beepola
	call musicstart
	di
.i_32
	ld	hl,(_key_1)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_34
	ld	hl,sp_JoyKeyboard
	ld	(_joyfunc),hl
	jp	i_33
.i_34
	ld	hl,(_key_2)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_36
	ld	hl,sp_JoyKempston
	ld	(_joyfunc),hl
	jp	i_33
.i_36
	ld	hl,(_key_3)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_38
	ld	hl,sp_JoySinclair1
	ld	(_joyfunc),hl
	jp	i_33
.i_38
.i_37
.i_35
	jp	i_32
.i_33
	ret



._game_ending
	call	sp_UpdateNow
	ld	hl,_s_ending
	ld	(_asm_int),hl
	call	_unpack
	call	_beepet
	ld	hl,11 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	ld	hl,500	;const
	push	hl
	call	_espera_activa
	pop	bc
	ret



._game_over
	ld	hl,10 % 256	;const
	push	hl
	ld	hl,11 % 256	;const
	push	hl
	ld	hl,21 % 256	;const
	push	hl
	ld	hl,13 % 256	;const
	push	hl
	ld	hl,15 % 256	;const
	push	hl
	call	_draw_rectangle
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11 % 256	;const
	push	hl
	ld	hl,12 % 256	;const
	push	hl
	ld	hl,15 % 256	;const
	push	hl
	ld	hl,i_1+0
	push	hl
	call	_draw_text
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	call	sp_UpdateNow
	call	_beepet
	ld	hl,10 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	ld	hl,500	;const
	push	hl
	call	_espera_activa
	pop	bc
	ret



._do_extern_action
	ret


;	SECTION	text

._line_of_text_clear
	defm	"                              "
	defm	"  "
	defb	0

;	SECTION	code



;	SECTION	text

._player_cells
	defw	_sprite_1_a
	defw	_sprite_2_a
	defw	_sprite_3_a
	defw	_sprite_4_a
	defw	_sprite_5_a
	defw	_sprite_6_a
	defw	_sprite_7_a
	defw	_sprite_8_a
	defw	0

;	SECTION	code

;	SECTION	text

._enem_cells
	defw	_sprite_9_a
	defw	_sprite_10_a
	defw	_sprite_11_a
	defw	_sprite_12_a
	defw	_sprite_13_a
	defw	_sprite_14_a
	defw	_sprite_15_a
	defw	_sprite_16_a

;	SECTION	code


._abs_a
	bit 7, a
	ret z
	neg
	ret



._saca_a_todo_el_mundo_de_aqui
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	xor a
	.hide_sprites_enems_loop
	ld (_gpit), a
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_moviles
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	ld a, (_gpit)
	inc a
	cp 3
	jr nz, hide_sprites_enems_loop
	ret



._collide_enem
	ld hl, 0
	ld a, (_gpx)
	ld c, a
	ld a, (_en_ccx)
	add 12
	cp c
	ret c
	ld a, (_en_ccx)
	ld c, a
	ld a, (_gpx)
	add 12
	cp c
	ret c
	ld a, (_gpy)
	ld c, a
	ld a, (_en_ccy)
	add 12
	cp c
	ret c
	ld a, (_en_ccy)
	ld c, a
	ld a, (_gpy)
	add 12
	cp c
	ret c
	ld l, 1
	ret



._rand
	.rand16
	ld hl, _seed
	ld a, (hl)
	ld e, a
	inc hl
	ld a, (hl)
	ld d, a
	;; Ahora DE = [SEED]
	ld a, d
	ld h, e
	ld l, 253
	or a
	sbc hl, de
	sbc a, 0
	sbc hl, de
	ld d, 0
	sbc a, d
	ld e, a
	sbc hl, de
	jr nc, nextrand
	inc hl
	.nextrand
	ld d, h
	ld e, l
	ld hl, _seed
	ld a, e
	ld (hl), a
	inc hl
	ld a, d
	ld (hl), a
	;; Ahora [SEED] = HL
	ld l, e
	ld h, 0
	;; Return 8 bit
	ret



._abs
	bit 7, h
	ret z
	call l_neg
	ret



._step
	ld a, 16
	out (254), a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	xor 16
	out (254), a
	ret



._cortina
	;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
	;; para que no queden artefactos feos
	ld de, 22528 ; Apuntamos con DE a la zona de atributos
	ld b, 3 ; Procesamos 3 tercios
	.clearb1
	push bc
	ld b, 255 ; Procesamos los 256 atributos de cada tercio
	.clearb2
	ld a, (de) ; Nos traemos un atributo
	and 199 ; Le hacemos la m�scara 11000111 y dejamos PAPER a 0
	ld (de), a ; Y lo volvemos a poner
	inc de ; Siguiente atributo
	djnz clearb2
	pop bc
	djnz clearb1
	;; Y ahora el c�digo original que escrib� para UWOL:
	ld a, 8
	.repitatodo
	ld c, a ; Salvamos el contador de "repitatodo" en 'c'
	ld hl, 16384
	ld a, 12
	.bucle
	ld b, a ; Salvamos el contador de "bucle" en 'b'
	ld a, 255
	.bucle1
	sla (hl)
	inc hl
	dec a
	jr nz, bucle1
	ld a, 255
	.bucle2
	srl (hl)
	inc hl
	dec a
	jr nz, bucle2
	ld a, b ; Restituimos el contador de "bucle" a 'a'
	dec a
	jr nz, bucle
	ld a, c ; Restituimos el contador de "repitatodo" a 'a'
	dec a
	jr nz, repitatodo
	ret



._clear_cerrojo
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld b, 3
	ld hl, _cerrojos
	.clear_cerrojo_loop
	ld c, (hl)
	inc hl
	ld d, (hl)
	inc hl
	ld e, (hl)
	inc hl
	ld a, (_n_pant)
	cp c
	jr nz, clear_cerrojo_loop_continue
	ld a, (__x)
	cp d
	jr nz, clear_cerrojo_loop_continue
	ld a, (__y)
	cp e
	jr nz, clear_cerrojo_loop_continue
	xor a
	ld (hl), a
	ret
	.clear_cerrojo_loop_continue
	inc hl
	djnz clear_cerrojo_loop
	ret



._init_cerrojos
	ld b, 3
	ld hl, _cerrojos + 3
	ld de, 4
	ld a, 1
	.init_cerrojos_loop
	ld (hl), a
	add hl, de
	djnz init_cerrojos_loop
	ret



._adjust_to_tile_x
	ld	a,(_gpxx)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	ld	hl,_player
	push	hl
	ld	a,(_gpx)
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	pop	de
	call	l_pint
	ret



._adjust_to_tile_y
	ld	a,(_gpyy)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	hl,_player+1+1
	push	hl
	ld	a,(_gpy)
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	pop	de
	call	l_pint
	ret



._player_flicker
	ld	hl,_player+23
	ld	(hl),#(2 % 256 % 256)
	ld	hl,_player+24
	ld	(hl),#(50 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	ret



._move
	ld	hl,(_player)
	ld	(_gpcx),hl
	ld	hl,(_player+1+1)
	ld	(_gpcy),hl
	ld	hl,(_pad1)
	ld	h,0
	ld	a,l
	ld	(_pad_this_frame),a
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_42
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_42
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_pad0),a
	ld	h,0
	ld	a,l
	ld	(_pad1),a
	ld	hl,(_pad_this_frame)
	ld	h,0
	call	l_com
	ex	de,hl
	ld	hl,(_pad1)
	ld	h,0
	call	l_or
	ld	h,0
	ld	a,l
	ld	(_pad_this_frame),a
	ld	hl,_pad0
	ld	a,(hl)
	and	#(1 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	z,i_44
	inc	hl
	ld	hl,_pad0
	ld	a,(hl)
	and	#(2 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jr	nz,i_45_i_44
.i_44
	jp	i_43
.i_45_i_44
	ld	hl,(_player+8)
	xor	a
	or	h
	jp	m,i_46
	or	l
	jp	z,i_46
	ld	hl,_player+8
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+12
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_pint
	ld	hl,(_player+8)
	xor	a
	or	h
	jp	p,i_47
	ld	hl,0	;const
	ld	(_player+8),hl
.i_47
	jp	i_48
.i_46
	ld	hl,(_player+8)
	xor	a
	or	h
	jp	p,i_49
	ld	hl,_player+8
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+12
	call	l_gchar
	pop	de
	add	hl,de
	pop	de
	call	l_pint
	ld	hl,(_player+8)
	xor	a
	or	h
	jp	m,i_50
	or	l
	jp	z,i_50
	ld	hl,0	;const
	ld	(_player+8),hl
.i_50
.i_49
.i_48
.i_43
	ld	hl,_pad0
	ld	a,(hl)
	rrca
	jp	c,i_51
	ld	hl,(_player+8)
	push	hl
	ld	hl,(_player+39)
	call	l_neg
	pop	de
	call	l_gt
	jp	nc,i_52
	ld	hl,_player+8
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+11
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_pint
.i_52
	ld	hl,_player+22
	ld	(hl),#(2 % 256 % 256)
.i_51
	ld	hl,_pad0
	ld	a,(hl)
	and	#(2 % 256)
	jp	nz,i_53
	ld	de,(_player+8)
	ld	hl,(_player+39)
	call	l_lt
	jp	nc,i_54
	ld	hl,_player+8
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+11
	call	l_gchar
	pop	de
	add	hl,de
	pop	de
	call	l_pint
.i_54
	ld	hl,_player+22
	ld	(hl),#(3 % 256 % 256)
.i_53
	ld	hl,_player+1+1
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_player+8)
	add	hl,de
	pop	de
	call	l_pint
	ld	hl,(_player+1+1)
	xor	a
	or	h
	jp	p,i_55
	ld	hl,0	;const
	ld	(_player+1+1),hl
.i_55
	ld	hl,(_player+1+1)
	ld	de,9216	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_56
	ld	hl,9216	;const
	ld	(_player+1+1),hl
.i_56
	ld	hl,(_player)
	ex	de,hl
	ld	l,#(6 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	ld	hl,(_player+1+1)
	ex	de,hl
	ld	l,#(6 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	a,(_gpx)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpxx),a
	ld	a,(_gpy)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpyy),a
	.vert_collision
	xor a
	ld (_player + 26), a
	ld (_player + 37), a
	ld de, (_player + 8)
	ld hl, (_ptgmy)
	add hl, de
	ld (_rdj), hl
	ld a, h
	or l
	jp z, vert_collision_done
	bit 7, h
	jr z, vert_collision_positive
	.vert_collision_negative
	ld a, (_gpxx)
	ld c, a
	ld a, (_gpyy)
	call _attr_2
	ld a, l
	and 8
	jr nz, vert_collision_up
	ld a, (_gpx)
	and 15
	jp z, vert_collision_done
	ld a, (_gpxx)
	inc a
	ld c, a
	ld a, (_gpyy)
	call _attr_2
	ld a, l
	and 8
	jp z, vert_collision_done
	.vert_collision_up
	ld hl, 0
	ld (_player + 8), hl
	ld hl, _gpyy
	inc (hl)
	call _adjust_to_tile_y
	ld a, 1
	ld (_player + 37), a
	jp vert_collision_done
	.vert_collision_positive
	ld a, (_gpy)
	and 15
	ld c, a
	ld de, (_player + 8)
	ld l, 6
	call l_asr
	ld a, l
	cp c
	jr c, vert_collision_done
	ld a, (_gpxx)
	ld c, a
	ld a, (_gpyy)
	inc a
	call _attr_2
	ld a, l
	and 12
	jr nz, vert_collision_down
	ld a, (_gpx)
	and 15
	jr z, vert_collision_done
	ld a, (_gpxx)
	inc a
	ld c, a
	ld a, (_gpyy)
	inc a
	call _attr_2
	ld a, l
	and 12
	jr z, vert_collision_done
	.vert_collision_down
	ld hl, 0
	ld (_player + 8), hl
	call _adjust_to_tile_y
	ld a, 1
	ld (_player + 26), a
	.vert_collision_done
	ld	hl,_pad0
	ld	a,(hl)
	and	#(4 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	z,i_58
	inc	hl
	ld	hl,_pad0
	ld	a,(hl)
	and	#(8 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jr	nz,i_59_i_58
.i_58
	jp	i_57
.i_59_i_58
	ld	hl,(_player+6)
	xor	a
	or	h
	jp	m,i_60
	or	l
	jp	z,i_60
	ld	hl,_player+6
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+12
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_pint
	ld	hl,(_player+6)
	xor	a
	or	h
	jp	p,i_61
	ld	hl,0	;const
	ld	(_player+6),hl
.i_61
	jp	i_62
.i_60
	ld	hl,(_player+6)
	xor	a
	or	h
	jp	p,i_63
	ld	hl,_player+6
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+12
	call	l_gchar
	pop	de
	add	hl,de
	pop	de
	call	l_pint
	ld	hl,(_player+6)
	xor	a
	or	h
	jp	m,i_64
	or	l
	jp	z,i_64
	ld	hl,0	;const
	ld	(_player+6),hl
.i_64
.i_63
.i_62
.i_57
	ld	hl,_pad0
	ld	a,(hl)
	and	#(4 % 256)
	jp	nz,i_65
	ld	hl,(_player+6)
	push	hl
	ld	hl,(_player+39)
	call	l_neg
	pop	de
	call	l_gt
	jp	nc,i_66
	ld	hl,_player+6
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+11
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_pint
.i_66
	ld	hl,_player+22
	ld	(hl),#(1 % 256 % 256)
.i_65
	ld	hl,_pad0
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_67
	ld	de,(_player+6)
	ld	hl,(_player+39)
	call	l_lt
	jp	nc,i_68
	ld	hl,_player+6
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_player+11
	call	l_gchar
	pop	de
	add	hl,de
	pop	de
	call	l_pint
.i_68
	ld	hl,_player+22
	ld	(hl),#(0 % 256 % 256)
.i_67
	ld	hl,_player
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_player+6)
	add	hl,de
	pop	de
	call	l_pint
	ld	hl,_player
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_ptgmx)
	add	hl,de
	pop	de
	call	l_pint
	ld	hl,(_player)
	xor	a
	or	h
	jp	p,i_69
	ld	hl,0	;const
	ld	(_player),hl
.i_69
	ld	hl,(_player)
	ld	de,14336	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_70
	ld	hl,14336	;const
	ld	(_player),hl
.i_70
	ld	hl,(_player)
	ex	de,hl
	ld	l,#(6 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpxx),a
	xor a
	ld (_wall), a
	ld hl, (_player + 6)
	ld de, (_ptgmx)
	add hl, de
	ld (_rdj), hl
	ld a, h
	or l
	jp z, horz_collision_done
	bit 7, h
	jp z, horz_collision_positive
	.horz_collision_negative
	ld a, (_gpxx)
	ld c, a
	ld a, (_gpyy)
	call _attr_2
	ld a, l
	and 8
	jr nz, horz_collision_left
	ld a, (_gpy)
	and 15
	jr z, horz_collision_done
	ld a, (_gpxx)
	ld c, a
	ld a, (_gpyy)
	inc a
	call _attr_2
	ld a, l
	and 8
	jp z, horz_collision_done
	.horz_collision_left
	ld hl, 0
	ld (_player + 6), hl
	ld hl, _gpxx
	inc (hl)
	call _adjust_to_tile_x
	jr horz_collision_done
	.horz_collision_positive
	ld a, (_gpxx)
	inc a
	ld c, a
	ld a, (_gpyy)
	call _attr_2
	ld a, l
	and 8
	jr nz, horz_collision_right
	ld a, (_gpy)
	and 15
	jr z, horz_collision_done
	ld a, (_gpxx)
	inc a
	ld c, a
	ld a, (_gpyy)
	inc a
	call _attr_2
	ld a, l
	and 8
	jp z, horz_collision_done
	.horz_collision_right
	ld hl, 0
	ld (_player + 6), hl
	call _adjust_to_tile_x
	.horz_collision_done
	ld	hl,_gpx
	ld	a,(hl)
	and	#(15 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_72
	inc	hl
	ld	hl,_gpy
	ld	a,(hl)
	and	#(15 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jr	z,i_73_i_72
.i_72
	jp	i_71
.i_73_i_72
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gpyy)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	de,15	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_75
	ld	hl,_player+28
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_76_i_75
.i_75
	jp	i_74
.i_76_i_75
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gpyy)
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	_set_map_tile
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gpyy)
	ld	h,0
	push	hl
	call	_clear_cerrojo
	pop	bc
	pop	bc
	ld	hl,_player+28
	push	hl
	call	l_gchar
	dec	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,8 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	jp	i_77
.i_74
	ld	hl,(_gpxx)
	ld	h,0
	dec	hl
	push	hl
	ld	hl,(_gpyy)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	de,15	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_79
	ld	hl,_player+28
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_80_i_79
.i_79
	jp	i_78
.i_80_i_79
	ld	hl,(_gpxx)
	ld	h,0
	dec	hl
	push	hl
	ld	hl,(_gpyy)
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	_set_map_tile
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_gpxx)
	ld	h,0
	dec	hl
	push	hl
	ld	hl,(_gpyy)
	ld	h,0
	push	hl
	call	_clear_cerrojo
	pop	bc
	pop	bc
	ld	hl,_player+28
	push	hl
	call	l_gchar
	dec	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,8 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
.i_78
.i_77
.i_71
	ld	hl,_pad0
	ld	a,(hl)
	rlca
	jp	c,i_81
	ld	hl,_gpy
	ld	a,(hl)
	and	#(15 % 256)
	jp	nz,i_82
	ld	hl,(_gpxx)
	ld	h,0
	ld	a,l
	ld	(_x1),a
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,_pad0
	ld	a,(hl)
	and	#(1 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_84
	inc	hl
	ld	a,(_gpyy)
	cp	#(1 % 256)
	jp	z,i_84
	jp	c,i_84
	jr	i_85_i_84
.i_84
	jp	i_83
.i_85_i_84
	ld	hl,(_gpyy)
	ld	h,0
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,(_gpyy)
	ld	h,0
	dec	hl
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_y1),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_86
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_86
	ld	hl,_gpx
	ld	a,(hl)
	and	#(15 % 256)
	jp	z,i_87
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_x1),a
	ld	h,0
	ld	a,l
	ld	(_x0),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_88
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_88
.i_87
	jp	i_89
.i_83
	ld	hl,_pad0
	ld	a,(hl)
	and	#(2 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_91
	inc	hl
	ld	a,(_gpyy)
	cp	#(8 % 256)
	jp	z,i_91
	jr	c,i_92_i_91
.i_91
	jp	i_90
.i_92_i_91
	ld	hl,(_gpyy)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,(_gpyy)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_y1),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_93
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_93
	ld	hl,_gpx
	ld	a,(hl)
	and	#(15 % 256)
	jp	z,i_94
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_x1),a
	ld	h,0
	ld	a,l
	ld	(_x0),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_95
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_95
.i_94
.i_90
.i_89
.i_82
	ld	hl,_gpx
	ld	a,(hl)
	and	#(15 % 256)
	jp	nz,i_96
	ld	hl,(_gpyy)
	ld	h,0
	ld	a,l
	ld	(_y1),a
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,_pad0
	ld	a,(hl)
	and	#(8 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_98
	inc	hl
	ld	a,(_gpxx)
	cp	#(14 % 256)
	jp	z,i_98
	jr	c,i_99_i_98
.i_98
	jp	i_97
.i_99_i_98
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,(_gpxx)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_x1),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_100
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_100
	ld	hl,_gpy
	ld	a,(hl)
	and	#(15 % 256)
	jp	z,i_101
	ld	hl,(_gpyy)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_y1),a
	ld	h,0
	ld	a,l
	ld	(_y0),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_102
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_102
.i_101
	jp	i_103
.i_97
	ld	hl,_pad0
	ld	a,(hl)
	and	#(4 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_105
	inc	hl
	ld	a,(_gpxx)
	cp	#(1 % 256)
	jp	z,i_105
	jp	c,i_105
	jr	i_106_i_105
.i_105
	jp	i_104
.i_106_i_105
	ld	hl,(_gpxx)
	ld	h,0
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,(_gpxx)
	ld	h,0
	dec	hl
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_x1),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_107
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_107
	ld	hl,_gpy
	ld	a,(hl)
	and	#(15 % 256)
	jp	z,i_108
	ld	hl,(_gpyy)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_y1),a
	ld	h,0
	ld	a,l
	ld	(_y0),a
	call	_can_move_box
	ld	a,h
	or	l
	jp	z,i_109
	ld	hl,1 % 256	;const
	push	hl
	call	_move_tile
	pop	bc
.i_109
.i_108
.i_104
.i_103
.i_96
.i_81
	ld a, (_gpx)
	ld b, a
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_ptx1), a
	ld a, b
	add 11
	srl a
	srl a
	srl a
	srl a
	ld (_ptx2), a
	ld a, (_gpy)
	ld b, a
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_pty1), a
	ld a, b
	add 11
	srl a
	srl a
	srl a
	srl a
	ld (_pty2), a
	ld a, (_ptx1)
	ld c, a
	ld a, (_pty1)
	call _attr_2
	ld a, l
	dec a
	jr z, evil_tile_collision
	ld a, (_ptx2)
	ld c, a
	ld a, (_pty1)
	call _attr_2
	ld a, l
	dec a
	jr z, evil_tile_collision
	ld a, (_ptx2)
	ld c, a
	ld a, (_pty1)
	call _attr_2
	ld a, l
	dec a
	jr z, evil_tile_collision
	ld a, (_ptx2)
	ld c, a
	ld a, (_pty2)
	call _attr_2
	ld a, l
	dec a
	jr nz, evil_tile_collision_done
	.evil_tile_collision
	ld	a,(_player+23)
	and	a
	jp	nz,i_110
	ld	hl,2 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	ld	hl,_player+29
	dec	(hl)
	ld	a,(hl)
	inc	hl
	cp  255
	jr	nz,ASMPC+3
	dec	(hl)
	ld	h,(hl)
	ld	l,a
	call	_player_flicker
.i_110
	ld	de,_player
	ld	hl,(_gpcx)
	call	l_pint
	ld	de,_player+1+1
	ld	hl,(_gpcy)
	call	l_pint
	ld	hl,(_player+6)
	call	_abs
	push	hl
	ld	hl,(_player+8)
	call	_abs
	pop	de
	call	l_gt
	jp	nc,i_111
	ld	hl,_player+6
	push	hl
	call	l_gint	;
	call	l_neg
	pop	de
	call	l_pint
	jp	i_112
.i_111
	ld	hl,_player+8
	push	hl
	call	l_gint	;
	call	l_neg
	pop	de
	call	l_pint
.i_112
	.evil_tile_collision_done
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,15	;const
	call	l_xor
	ld	de,15	;const
	ex	de,hl
	call	l_and
	ld	a,h
	or	l
	jp	z,i_113
	ld	hl,_player+21
	inc	(hl)
	ld	a,(hl)
	cp	#(4 % 256)
	jp	nz,i_114
	ld	hl,_player+21
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+20
	push	hl
	ld	l,(hl)
	ld	h,0
	call	l_lneg
	ld	hl,0	;const
	rl	l
	pop	de
	ld	a,l
	ld	(de),a
	call	_step
.i_114
.i_113
	ld	hl,(_player+20)
	ld	h,0
	push	hl
	ld	a,(_player+22)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_rdd),a
	ld	hl,_player+17
	push	hl
	ld	hl,_player_cells
	push	hl
	ld	hl,(_rdd)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ret



._init_player_values
	ld	hl,_player
	ld	(hl),#(8192 % 256)
	inc	hl
	ld	(hl),#(8192 / 256)
	ld	hl,_player+1+1
	ld	(hl),#(5120 % 256)
	inc	hl
	ld	(hl),#(5120 / 256)
	ld	hl,_player+8
	ld	(hl),#(0 % 256)
	inc	hl
	ld	(hl),#(0 / 256)
	ld	hl,_player+10
	push	hl
	pop	de
	ld	a,#(32 % 256)
	ld	(de),a
	ld	hl,_player+6
	ld	(hl),#(0 % 256)
	inc	hl
	ld	(hl),#(0 / 256)
	ld	hl,_player+11
	push	hl
	pop	de
	ld	a,#(32 % 256)
	ld	(de),a
	ld	hl,_player+12
	push	hl
	pop	de
	ld	a,#(24 % 256)
	ld	(de),a
	ld	hl,_player+39
	ld	(hl),#(256 % 256)
	inc	hl
	ld	(hl),#(256 / 256)
	ld	hl,_player+13
	ld	(hl),#(64 % 256 % 256)
	ld	hl,_player+14
	ld	(hl),#(1 % 256 % 256)
	ld	hl,_player+19
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+20
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+21
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+22
	ld	(hl),#(3 % 256 % 256)
	ld	hl,_player+23
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+24
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+33
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+35
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+34
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_player+36
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	ret



._init_player
	call	_init_player_values
	ld	hl,_player+29
	ld	(hl),#(99 % 256)
	inc	hl
	ld	(hl),#(99 / 256)
	ld	hl,_player+27
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	hl,_player+28
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	hl,_player+32
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	ret



._init_hotspots
	ld b, 5 * 5
	ld hl, _hotspots + 2
	ld de, 3
	ld a, 1
	.init_hotspots_loop
	ld (hl), a
	add hl, de
	djnz init_hotspots_loop
	ret



._draw_and_advance
	ld bc, (__n)
	ld b, 0
	ld hl, _comportamiento_tiles
	add hl, bc
	ld a, (hl)
	ld bc, (_rdi)
	ld b, 0
	ld hl, _map_attr
	add hl, bc
	ld (hl), a
	ld hl, _map_buff
	add hl, bc
	ld a, (__n)
	ld (hl), a
	ld a, (_rdx)
	add 0
	ld h, 0
	ld l, a
	push hl
	ld a, (_rdy)
	add 2
	ld h, 0
	ld l, a
	push hl
	ld hl, (__n)
	ld h, 0
	push hl
	call _draw_coloured_tile
	pop bc
	pop bc
	pop bc
	ld a, (_rdx)
	add 2
	cp 30
	jr nz, draw_and_advance_x_set
	ld a, (_rdy)
	add 2
	ld (_rdy), a
	xor a
	.draw_and_advance_x_set
	ld (_rdx), a
	ld hl, _rdi
	inc (hl)
	ret



._draw_scr_background
	ld	a,#(0 % 256 % 256)
	ld	(_rdx),a
	ld	a,#(0 % 256 % 256)
	ld	(_rdy),a
	ld	hl,_mapa
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	de,75
	call	l_mult
	pop	de
	add	hl,de
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_rdi),a
	xor a
	ld (_rdi), a
	ld (_gpit), a
	.draw_scr_bg_loop
	ld hl, (_gp_gen)
	ld a, (hl)
	inc hl
	ld (_gp_gen), hl
	ld b, a
	srl a
	srl a
	srl a
	srl a
	ld (_rdt1), a
	ld a, b
	and 15
	ld (_rdt2), a
	ld a, (_rdt1)
	call no_alt_bg_subst
	ld (__n), a
	call _draw_and_advance
	ld a, (_rdt2)
	call no_alt_bg_subst
	ld (__n), a
	call _draw_and_advance
	ld a, (_gpit)
	inc a
	ld (_gpit), a
	cp 75
	jr nz, draw_scr_bg_loop
	jr draw_scr_bg_loop_end
	.no_alt_bg_subst
	ld c, a
	call _rand
	ld a, l
	and 15
	cp 2
	jr nc, draw_scr_alt_no
	ld a, c
	or a
	ret nz
	ld a, 19
	ret
	.draw_scr_alt_no
	ld a, c
	ret
	.draw_scr_bg_loop_end
	ld	a,#(240 % 256 % 256)
	ld	(_hotspot_y),a
	ld	a,#(0 % 256 % 256)
	ld	(_hotspot_t),a
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	a,(hl)
	cp	#(1 % 256)
	jp	nz,i_115
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	a,(hl)
	and	a
	jp	z,i_116
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_hotspot_t),a
.i_116
	jp	i_117
.i_115
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_118
	call	_rand
	ld	de,3	;const
	ex	de,hl
	call	l_div
	ld	hl,2	;const
	call	l_eq
	jp	nc,i_119
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_hotspot_t),a
.i_119
.i_118
.i_117
	ld	a,(_hotspot_t)
	and	a
	jp	z,i_120
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	a,(hl)
	and	#(15 % 256)
	ld	l,a
	ld	h,0
	ld	h,0
	ld	a,l
	ld	(_rdy),a
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_hotspot_x),a
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_hotspot_y),a
	ld	hl,_map_buff
	push	hl
	ld	hl,(_rdy)
	ld	h,0
	ld	de,15
	call	l_mult
	ex	de,hl
	ld	hl,(_rdx)
	ld	h,0
	add	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_orig_tile),a
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,0
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,2
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_hotspot_t)
	cp	#(3 % 256)
	jp	nz,i_121
	ld	hl,16	;const
	jp	i_122
.i_121
	ld	hl,(_hotspot_t)
	ld	h,0
	ld	de,16
	add	hl,de
.i_122
	ld	h,0
	push	hl
	call	_draw_coloured_tile
	pop	bc
	pop	bc
	pop	bc
.i_120
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_125
.i_123
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_125
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_124
	jp	nc,i_124
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,(_n_pant)
	cp	(hl)
	jp	nz,i_127
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	de,0
	call	l_eq
	jr	c,i_128_i_127
.i_127
	jp	i_126
.i_128_i_127
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	e,(hl)
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,0
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	e,(hl)
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,2
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	call	_draw_coloured_tile
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	de,15
	call	l_mult
	push	hl
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_rdi),a
	ld	de,_map_attr
	ld	hl,(_rdi)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	de,_map_buff
	ld	hl,(_rdi)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
.i_126
	jp	i_123
.i_124
	ret



._draw_scr
	ld	hl,(_n_pant)
	ld	h,0
	inc	hl
	ld	(_seed),hl
	call	_draw_scr_background
	ld	a,#(0 % 256 % 256)
	ld	(_f_zone_ac),a
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_enoffs),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_131
.i_129
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_131
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_130
	jp	nc,i_130
	ld	de,_en_an_frame
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	de,_en_an_state
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	call	l_gchar
.i_134
	ld	a,l
	cp	#(0% 256)
	jp	z,i_135
	cp	#(1% 256)
	jp	z,i_136
	cp	#(2% 256)
	jp	z,i_137
	cp	#(3% 256)
	jp	z,i_138
	cp	#(4% 256)
	jp	z,i_139
	jp	i_133
.i_135
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_18_a
	pop	de
	call	l_pint
	jp	i_133
.i_136
.i_137
.i_138
.i_139
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_9_a
	push	hl
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	call	l_gchar
	dec	hl
	ld	de,288
	call	l_mult
	pop	de
	add	hl,de
	pop	de
	call	l_pint
.i_133
	jp	i_129
.i_130
	ret



._platform_get_player
	ld	hl,_player+25
	ld	(hl),#(1 % 256 % 256)
	ld	hl,(_en_ccy)
	ld	h,0
	ld	bc,-16
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	hl,_player+1+1
	push	hl
	ld	a,(_gpy)
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	pop	de
	call	l_pint
	ld	hl,_player+8
	ld	(hl),#(0 % 256)
	inc	hl
	ld	(hl),#(0 / 256)
	ld	a,(_gpy)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpyy),a
	ld	hl,__en_my
	call	l_gchar
	ex	de,hl
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_ptgmy),hl
	ret



._mueve_bicharracos
	ld	a,#(0 % 256 % 256)
	ld	(_en_tocado),a
	ld	hl,_player+25
	ld	(hl),#(0 % 256 % 256)
	ld	hl,0	;const
	ld	(_ptgmy),hl
	ld	(_ptgmx),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_142
.i_140
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_142
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_141
	jp	nc,i_141
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
	ld hl, (_enoffsmasi)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, _malotes
	add hl, de
	ld (__baddies_pointer), hl
	ld a, (hl)
	ld (__en_x), a
	inc hl
	ld a, (hl)
	ld (__en_y), a
	inc hl
	ld a, (hl)
	ld (__en_x1), a
	inc hl
	ld a, (hl)
	ld (__en_y1), a
	inc hl
	ld a, (hl)
	ld (__en_x2), a
	inc hl
	ld a, (hl)
	ld (__en_y2), a
	inc hl
	ld a, (hl)
	ld (__en_mx), a
	inc hl
	ld a, (hl)
	ld (__en_my), a
	inc hl
	ld a, (hl)
	ld (__en_t), a
	ld	a,(__en_t)
	and	a
	jp	z,i_143
	ld	hl,(__en_x)
	ld	h,0
	ld	a,l
	ld	(_en_cx),a
	ld	hl,(__en_y)
	ld	h,0
	ld	a,l
	ld	(_en_cy),a
	ld	a,(__en_t)
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_ule
	jp	nc,i_144
	ld a, (__en_mx)
	ld c, a
	ld a, (__en_x)
	add c
	ld (__en_x), a
	ld a, (__en_my)
	ld c, a
	ld a, (__en_y)
	add c
	ld (__en_y), a
	.en_linear_horz_bounds
	ld a, (__en_x)
	ld c, a
	ld a, (__en_x1)
	cp c
	jr c, horz_limit_skip_1
	ld a, (__en_mx)
	call _abs_a
	ld (__en_mx), a
	.horz_limit_skip_1
	ld a, (__en_x2)
	ld c, a
	ld a, (__en_x)
	cp c
	jr c, horz_limit_skip_2
	ld a, (__en_mx)
	call _abs_a
	neg
	ld (__en_mx), a
	.horz_limit_skip_2
	.en_linear_vert_bounds
	ld a, (__en_y)
	ld c, a
	ld a, (__en_y1)
	cp c
	jr c, vert_limit_skip_1
	ld a, (__en_my)
	call _abs_a
	ld (__en_my), a
	.vert_limit_skip_1
	ld a, (__en_y2)
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, vert_limit_skip_2
	ld a, (__en_my)
	call _abs_a
	neg
	ld (__en_my), a
	.vert_limit_skip_2
	ld	hl,(__en_t)
	ld	h,0
	dec	hl
	add	hl,hl
	ld	h,0
	ld	a,l
	ld	(_rdd),a
.i_144
	._en_bg_collision
	ld a, (__en_x)
	srl a
	srl a
	srl a
	srl a
	ld (_en_xx), a
	ld a, (__en_y)
	srl a
	srl a
	srl a
	srl a
	ld (_en_yy), a
	ld a, (__en_mx)
	or a
	jr z, _en_bg_collision_horz_done
	._en_bg_collision_horz
	ld a, (__en_mx)
	call __ctileoff
	ld (_rdi), a
	ld c, a
	ld a, (_en_xx)
	add c
	ld (_ptx1), a
	ld (_ptx2), a
	ld a, (_en_yy)
	ld (_pty1), a
	ld a, (__en_y)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_pty2), a
	call _en_bg_collision_check
	or a
	jr z, _en_bg_collision_horz_done
	ld a, (__en_mx)
	ld c, a
	xor a
	sub c
	ld (__en_mx), a
	ld a, (_en_xx)
	ld c, a
	ld a, (_rdi)
	xor 1
	add c
	sla a
	sla a
	sla a
	sla a
	ld (__en_x), a
	._en_bg_collision_horz_done
	ld a, (__en_my)
	or a
	jr z, _en_bg_collision_vert_done
	._en_bg_collision_vert
	ld a, (__en_my)
	call __ctileoff
	ld (_rdi), a
	ld c, a
	ld a, (_en_yy)
	add c
	ld (_pty1), a
	ld (_pty2), a
	ld a, (_en_xx)
	ld (_ptx1), a
	ld a, (__en_x)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_ptx2), a
	call _en_bg_collision_check
	or a
	jr z, _en_bg_collision_vert_done
	ld a, (__en_my)
	ld c, a
	xor a
	sub c
	ld (__en_my), a
	ld a, (_en_yy)
	ld c, a
	ld a, (_rdi)
	xor 1
	add c
	sla a
	sla a
	sla a
	sla a
	ld (__en_y), a
	._en_bg_collision_vert_done
	jr _en_bg_collision_end
	._en_bg_collision_check
	ld a, (_ptx1)
	ld c, a
	ld a, (_pty1)
	call _attr_2
	ld a, l
	and 8
	ret nz
	ld a, (_ptx2)
	ld c, a
	ld a, (_pty2)
	call _attr_2
	ld a, l
	and 8
	ret
	.__ctileoff
	bit 7, a
	jr z, __ctileoff_1
	xor a
	ret
	.__ctileoff_1
	ld a, 1
	ret
	._en_bg_collision_end
	ld bc, (_enit)
	ld b, 0
	ld hl, _en_an_count
	add hl, bc
	ld a, (hl)
	inc a
	cp 4
	jr c, enemy_animate_update_count
	push hl
	ld hl, _en_an_frame
	add hl, bc
	ld a, (hl)
	xor 1
	ld (hl), a
	pop hl
	xor a
	.enemy_animate_update_count
	ld (hl), a
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_enem_cells
	push	hl
	ld	hl,(_rdd)
	ld	h,0
	push	hl
	ld	de,_en_an_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ld	hl,(__en_x)
	ld	h,0
	ld	a,l
	ld	(_en_ccx),a
	ld	hl,(__en_y)
	ld	h,0
	ld	a,l
	ld	(_en_ccy),a
	ld	hl,(_en_tocado)
	ld	h,0
	ld	de,0
	call	l_eq
	jp	nc,i_146
	call	_collide_enem
	ld	a,h
	or	l
	jp	z,i_146
	ld	a,(__en_t)
	cp	#(16 % 256)
	jp	z,i_146
	jr	c,i_147_i_146
.i_146
	jp	i_145
.i_147_i_146
	ld	a,(_player+23)
	and	a
	jp	nz,i_148
	ld	a,#(1 % 256 % 256)
	ld	(_en_tocado),a
	ld	hl,_player+36
	ld	(hl),#(1 % 256 % 256)
	ld	hl,2 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	ld	hl,_player+29
	dec	(hl)
	ld	a,(hl)
	inc	hl
	cp  255
	jr	nz,ASMPC+3
	dec	(hl)
	ld	h,(hl)
	ld	l,a
	ld	hl,__en_mx
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_149
	ld	hl,(_gpx)
	ld	h,0
	ex	de,hl
	ld	hl,(_en_ccx)
	ld	h,0
	call	l_ult
	jp	nc,i_150
	ld	hl,_player+6
	push	hl
	ld	hl,__en_mx
	call	l_gchar
	add	hl,hl
	call	_abs
	ex	de,hl
	ld	l,#(7 % 256)
	call	l_asl
	call	l_neg
	pop	de
	call	l_pint
	jp	i_151
.i_150
	ld	hl,_player+6
	push	hl
	ld	hl,__en_mx
	call	l_gchar
	push	hl
	ld	hl,__en_mx
	call	l_gchar
	pop	de
	add	hl,de
	call	_abs
	ex	de,hl
	ld	l,#(7 % 256)
	call	l_asl
	pop	de
	call	l_pint
.i_151
.i_149
	ld	hl,__en_my
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_152
	ld	hl,(_gpy)
	ld	h,0
	ex	de,hl
	ld	hl,(_en_ccy)
	ld	h,0
	call	l_ult
	jp	nc,i_153
	ld	hl,_player+8
	push	hl
	ld	hl,__en_my
	call	l_gchar
	add	hl,hl
	call	_abs
	ex	de,hl
	ld	l,#(7 % 256)
	call	l_asl
	call	l_neg
	pop	de
	call	l_pint
	jp	i_154
.i_153
	ld	hl,_player+8
	push	hl
	ld	hl,__en_my
	call	l_gchar
	push	hl
	ld	hl,__en_my
	call	l_gchar
	pop	de
	add	hl,de
	call	_abs
	ex	de,hl
	ld	l,#(7 % 256)
	call	l_asl
	pop	de
	call	l_pint
.i_154
.i_152
	call	_player_flicker
.i_148
.i_145
.i_143
.i_155
	ld hl, (__baddies_pointer)
	ld a, (__en_x)
	ld (hl), a
	inc hl
	ld a, (__en_y)
	ld (hl), a
	inc hl
	ld a, (__en_x1)
	ld (hl), a
	inc hl
	ld a, (__en_y1)
	ld (hl), a
	inc hl
	ld a, (__en_x2)
	ld (hl), a
	inc hl
	ld a, (__en_y2)
	ld (hl), a
	inc hl
	ld a, (__en_mx)
	ld (hl), a
	inc hl
	ld a, (__en_my)
	ld (hl), a
	inc hl
	ld a, (__en_t)
	ld (hl), a
	inc hl
	jp	i_140
.i_141
	ret



._move_tile
	ld	hl,(_x0)
	ld	h,0
	push	hl
	ld	hl,(_y0)
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,(_comportamiento_tiles)
	ld	h,0
	push	hl
	call	_set_map_tile
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_x1)
	ld	h,0
	push	hl
	ld	hl,(_y1)
	ld	h,0
	push	hl
	ld	hl,14 % 256	;const
	push	hl
	ld	hl,(_comportamiento_tiles+14)
	ld	h,0
	push	hl
	call	_set_map_tile
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_156
	ld	hl,8 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
.i_156
	ret



._can_move_box
	ld	hl,(_x0)
	ld	h,0
	push	hl
	ld	hl,(_y0)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	de,14	;const
	ex	de,hl
	call	l_ne
	jp	c,i_158
	ld	hl,(_x1)
	ld	h,0
	push	hl
	ld	hl,(_y1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,4	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_157
.i_158
	ld	hl,0 % 256	;const
	ret


.i_157
	ld	hl,1 % 256	;const
	ret



._main
	di
	ld sp, 61952
	ld	hl,7 % 256	;const
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Initialize
	pop	bc
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,40 % 256	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,61288	;const
	push	hl
	call	sp_AddMemory
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,sp_JoyKeyboard
	ld	(_joyfunc),hl
	ld b, 0
	ld hl, SPTileArray
	ld de, _tileset
	.load_tileset_loop
	ld (hl), e
	inc h
	ld (hl), d
	dec h
	inc hl
	inc de
	inc de
	inc de
	inc de
	inc de
	inc de
	inc de
	inc de
	djnz load_tileset_loop
	ld	hl,_spritesClipValues
	ld	(_spritesClip),hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_sprite_2_a
	push	hl
	ld	hl,1 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_player),hl
	push	hl
	ld	hl,_sprite_2_b
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,(_sp_player)
	push	hl
	ld	hl,_sprite_2_c
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_player+15
	push	hl
	ld	hl,_player+17
	push	hl
	ld	hl,_sprite_2_a
	pop	de
	call	l_pint
	pop	de
	call	l_pint
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_rdi),a
	jp	i_162
.i_160
	ld	hl,_rdi
	ld	a,(hl)
	inc	(hl)
.i_162
	ld	a,(_rdi)
	cp	#(3 % 256)
	jp	z,i_161
	jp	nc,i_161
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_sprite_9_a
	push	hl
	ld	hl,2 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	de
	call	l_pint
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_sprite_9_b
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_sprite_9_c
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_en_an_current_frame
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_9_a
	pop	de
	call	l_pint
	jp	i_160
.i_161
.i_163
	call	_title_screen
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_playing),a
	call	_init_player
	call	_init_hotspots
	call	_init_cerrojos
	ld	a,#(12 % 256 % 256)
	ld	(_n_pant),a
	ld	a,#(255 % 256 % 256)
	ld	(_on_pant),a
	ld	a,#(0 % 256 % 256)
	ld	(_maincounter),a
	ld	a,#(0 % 256 % 256)
	ld	(_half_life),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_coins_old),a
	ld	h,0
	ld	a,l
	ld	(_ezg_old),a
	ld	h,0
	ld	a,l
	ld	(_item_old),a
	ld	h,0
	ld	a,l
	ld	(_killed_old),a
	ld	h,0
	ld	a,l
	ld	(_keys_old),a
	ld	h,0
	ld	a,l
	ld	(_life_old),a
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
.i_165
	ld	a,(_playing)
	and	a
	jp	z,i_166
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_on_pant)
	ld	h,0
	call	l_ne
	jp	nc,i_167
	call	_draw_scr
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_on_pant),a
.i_167
	ld	hl,_player+27
	call	l_gchar
	ex	de,hl
	ld	hl,(_objs_old)
	ld	h,0
	call	l_ne
	jp	nc,i_168
	ld	hl,30 % 256	;const
	push	hl
	ld	hl,12 % 256	;const
	push	hl
	ld	hl,_player+27
	call	l_gchar
	ld	h,0
	push	hl
	call	_draw_2_digits
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_player+27
	call	l_gchar
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
.i_168
	ld	de,(_player+29)
	ld	hl,(_life_old)
	ld	h,0
	call	l_ne
	jp	nc,i_169
	ld	hl,(_player+29)
	xor	a
	or	h
	jp	m,i_170
	or	l
	jp	z,i_170
	ld	hl,(_player+29)
	ld	h,0
	ld	a,l
	ld	(_pti),a
	jp	i_171
.i_170
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pti),a
.i_171
	ld	hl,30 % 256	;const
	push	hl
	ld	hl,8 % 256	;const
	push	hl
	ld	hl,(_pti)
	ld	h,0
	push	hl
	call	_draw_2_digits
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_player+29)
	ld	h,0
	ld	a,l
	ld	(_life_old),a
.i_169
	ld	hl,_player+28
	call	l_gchar
	ex	de,hl
	ld	hl,(_keys_old)
	ld	h,0
	call	l_ne
	jp	nc,i_172
	ld	hl,30 % 256	;const
	push	hl
	ld	hl,16 % 256	;const
	push	hl
	ld	hl,_player+28
	call	l_gchar
	ld	h,0
	push	hl
	call	_draw_2_digits
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_player+28
	call	l_gchar
	ld	h,0
	ld	a,l
	ld	(_keys_old),a
.i_172
	ld hl, _maincounter
	inc (hl)
	ld a, (_half_life)
	xor 1
	ld (_half_life), a
	call	_mueve_bicharracos
	call	_move
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_rdi),a
	jp	i_175
.i_173
	ld	hl,_rdi
	ld	a,(hl)
	inc	(hl)
.i_175
	ld	a,(_rdi)
	cp	#(3 % 256)
	jp	z,i_174
	jp	nc,i_174
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,de
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,de
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdy),a
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,(_spritesClip)
	push	hl
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_en_an_current_frame
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,2
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,0
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	hl,7	;const
	call	l_and
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	hl,7	;const
	call	l_and
	push	hl
	call	sp_MoveSprAbs
	ld	hl,14	;const
	add	hl,sp
	ld	sp,hl
	ld	hl,_en_an_current_frame
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_rdi)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	jp	i_173
.i_174
	ld	hl,(_gpy)
	ld	h,0
	ld	a,l
	ld	(_rdy),a
	ld	a,(_player+23)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_and
	ld	de,0
	call	l_eq
	jp	c,i_177
	ld	a,(_half_life)
	and	a
	jp	z,i_176
.i_177
	ld	hl,(_gpx)
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	jp	i_179
.i_176
	ld	hl,240 % 256	;const
	ld	a,l
	ld	(_rdx),a
.i_179
	ld	hl,(_sp_player)
	push	hl
	ld	hl,(_spritesClip)
	push	hl
	ld	de,(_player+17)
	ld	hl,(_player+15)
	ex	de,hl
	and	a
	sbc	hl,de
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,2
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,0
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	hl,7	;const
	call	l_and
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	hl,7	;const
	call	l_and
	push	hl
	call	sp_MoveSprAbs
	ld	hl,14	;const
	add	hl,sp
	ld	sp,hl
	ld	de,_player+15
	ld	hl,(_player+17)
	call	l_pint
	ld a, (_hotspot_x)
	ld c, a
	ld a, (_gpx)
	add 12
	cp c
	jp c, _hotspots_done
	ld a, (_gpx)
	ld c, a
	ld a, (_hotspot_x)
	add 12
	cp c
	jp c, _hotspots_done
	ld a, (_hotspot_y)
	ld c, a
	ld a, (_gpy)
	add 12
	cp c
	jp c, _hotspots_done
	ld a, (_gpy)
	ld c, a
	ld a, (_hotspot_y)
	add 12
	cp c
	jp c, _hotspots_done
	ld	a,#(0 % 256 % 256)
	ld	(_rdi),a
	ld	hl,(_hotspot_t)
	ld	h,0
.i_182
	ld	a,l
	cp	#(1% 256)
	jp	z,i_183
	cp	#(2% 256)
	jp	z,i_184
	cp	#(3% 256)
	jp	z,i_185
	jp	i_181
.i_183
	ld	hl,_player+27
	push	hl
	call	l_gchar
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,6 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	jp	i_181
.i_184
	ld	hl,_player+28
	push	hl
	call	l_gchar
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,6 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
	jp	i_181
.i_185
	ld	hl,_player+29
	push	hl
	call	l_gint	;
	ld	bc,25
	add	hl,bc
	pop	de
	call	l_pint
	ld	hl,(_player+29)
	ld	de,99	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_186
	ld	hl,99	;const
	ld	(_player+29),hl
.i_186
	ld	a,#(2 % 256 % 256)
	ld	(_rdi),a
	ld	hl,6 % 256	;const
	push	hl
	call	_play_sfx
	pop	bc
.i_181
	ld	a,(_rdi)
	cp	#(1 % 256)
	jp	z,i_187
	ld	a,(_hotspot_x)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,0
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_hotspot_y)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,2
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,(_orig_tile)
	ld	h,0
	push	hl
	call	_draw_coloured_tile
	pop	bc
	pop	bc
	pop	bc
	ld	hl,240 % 256	;const
	ld	a,l
	ld	(_hotspot_y),a
	ld	h,0
	ld	a,l
	ld	(_hotspot_x),a
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	push	hl
	ld	hl,_rdi
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
.i_187
	._hotspots_done
	call	sp_UpdateNow
	.player_flicker_done_check
	ld a, (_player + 23)
	and 2
	jr z, player_flicker_check_done
	ld a, (_player + 24)
	dec a
	jr nz, player_flicker_ct_write
	xor a
	ld (_player + 23), a
	.player_flicker_ct_write
	ld (_player + 24), a
	.player_flicker_check_done
	ld	a,(_gpx)
	cp	#(0 % 256)
	jp	nz,i_189
	ld	hl,(_player+6)
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jr	c,i_190_i_189
.i_189
	jp	i_188
.i_190_i_189
	ld	hl,_n_pant
	ld	a,(hl)
	dec	(hl)
	ld	a,#(224 % 256 % 256)
	ld	(_gpx),a
	ld	hl,14336	;const
	ld	(_player),hl
	jp	i_191
.i_188
	ld	a,(_gpx)
	cp	#(224 % 256)
	jp	nz,i_193
	ld	hl,(_player+6)
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_194_i_193
.i_193
	jp	i_192
.i_194_i_193
	ld	hl,_n_pant
	ld	a,(hl)
	inc	(hl)
	ld	hl,0	;const
	ld	(_player),hl
	ld	h,0
	ld	a,l
	ld	(_gpx),a
.i_192
.i_191
	ld	a,(_gpy)
	cp	#(0 % 256)
	jp	nz,i_196
	ld	hl,(_player+8)
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_196
	ld	a,(_n_pant)
	cp	#(5 % 256)
	jr	z,i_196_uge
	jp	c,i_196
.i_196_uge
	jr	i_197_i_196
.i_196
	jp	i_195
.i_197_i_196
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,-5
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	a,#(144 % 256 % 256)
	ld	(_gpy),a
	ld	hl,9216	;const
	ld	(_player+1+1),hl
	jp	i_198
.i_195
	ld	a,(_gpy)
	cp	#(144 % 256)
	jp	nz,i_200
	ld	hl,(_player+8)
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_201_i_200
.i_200
	jp	i_199
.i_201_i_200
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,5
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_player+1+1),hl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
.i_199
.i_198
	ld	hl,_player+27
	call	l_gchar
	ld	de,13	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_202
	call	_saca_a_todo_el_mundo_de_aqui
	call	_cortina
	call	_game_ending
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
	call	_cortina
.i_202
	ld	a,(_player+36)
	and	a
	jp	z,i_203
	ld	hl,_player+36
	ld	(hl),#(0 % 256 % 256)
	ld	hl,(_player+29)
	xor	a
	or	h
	jp	m,i_204
	or	l
	jp	z,i_204
.i_204
.i_203
	ld	hl,(_player+29)
	xor	a
	or	h
	jp	p,i_205
	call	_saca_a_todo_el_mundo_de_aqui
	call	_game_over
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
	call	_cortina
.i_205
	jp	i_165
.i_166
	jp	i_163
.i_164
	ret


	; The Music Box Player Engine
	; Based on code written by Mark Alexander for the utility, The Music
	; Modified by Chris Cowley
	; Produced by Beepola v1.08.01
	; Adapted for MTE MK1 v4 by na_th_an
	.musicstart
	LD HL,MUSICDATA ; <- Pointer to Music Data. Change
	; this to play a different song
	LD A,(HL) ; Get the loop start pointer
	LD (PATTERN_LOOP_BEGIN),A
	INC HL
	LD A,(HL) ; Get the song end pointer
	LD (PATTERN_LOOP_END),A
	INC HL
	LD (PATTERNDATA1),HL
	LD (PATTERNDATA2),HL
	LD A,254
	LD (PATTERN_PTR),A ; Set the pattern pointer to zero
	CALL NEXT_PATTERN
	.NEXTNOTE
	CALL PLAYNOTE
	XOR A
	IN A,($FE)
	AND $1F
	CP $1F
	JR Z,NEXTNOTE ; Play next note if no key pressed
	EI
	RET ; Return from playing tune
	.PATTERN_PTR
	DEFB 0
	.NOTE_PTR
	DEFB 0
	.NEXT_PATTERN
	LD A,(PATTERN_PTR)
	INC A
	INC A
	DEFB $FE ; CP n
	.PATTERN_LOOP_END
	DEFB 0
	JR NZ,NO_PATTERN_LOOP
	DEFB $3E ; LD A,n
	.PATTERN_LOOP_BEGIN
	DEFB 0
	.NO_PATTERN_LOOP
	LD (PATTERN_PTR),A
	DEFB $21 ; LD HL,nn
	.PATTERNDATA1
	DEFW $0000
	LD E,A ; (this is the first byte of the pattern)
	LD D,0 ; and store it at TEMPO
	ADD HL,DE
	LD E,(HL)
	INC HL
	LD D,(HL)
	LD A,(DE) ; Pattern Tempo -> A
	LD (TEMPO),A ; Store it at TEMPO
	LD A,1
	LD (NOTE_PTR),A
	.PLAYNOTE
	DEFB $21 ; LD HL,nn
	.PATTERNDATA2
	DEFW $0000
	LD A,(PATTERN_PTR)
	LD E,A
	LD D,0
	ADD HL,DE
	LD E,(HL)
	INC HL
	LD D,(HL) ; Now DE = Start of Pattern data
	LD A,(NOTE_PTR)
	LD L,A
	LD H,0
	ADD HL,DE ; Now HL = address of note data
	LD D,(HL)
	LD E,1
	; IF D = $0 then we are at the end of the pattern so increment PATTERN_PTR by 2 and set NOTE_PTR=0
	LD A,D
	AND A ; Optimised CP 0
	JR Z,NEXT_PATTERN
	PUSH DE
	INC HL
	LD D,(HL)
	LD E,1
	LD A,(NOTE_PTR)
	INC A
	INC A
	LD (NOTE_PTR),A ; Increment the note pointer by 2 (one note per chan)
	POP HL ; Now CH1 freq is in HL, and CH2 freq is in DE
	LD A,H
	DEC A
	JR NZ,OUTPUT_NOTE
	LD A,D ; executed only if Channel 2 contains a rest
	DEC A ; if DE (CH1 note) is also a rest then..
	JR Z,PLAY_SILENCE ; Play silence
	.OUTPUT_NOTE
	LD A,(TEMPO)
	LD C,A
	LD B,0
	XOR A
	EX AF,AF
	XOR A
	LD IXH,D
	LD D,$10
	.EAE5
	NOP
	NOP
	.EAE7
	EX AF,AF
	DEC E
	OUT ($FE),A
	JR NZ,EB04
	LD E,IXH
	XOR D
	EX AF,AF
	DEC L
	JP NZ,EB0B
	.EAF5
	OUT ($FE),A
	LD L,H
	XOR D
	DJNZ EAE5
	INC C
	JP NZ,EAE7
	RET
	.EB04
	JR Z,EB04
	EX AF,AF
	DEC L
	JP Z,EAF5
	.EB0B
	OUT ($FE),A
	NOP
	NOP
	DJNZ EAE5
	INC C
	JP NZ,EAE7
	RET
	.PLAY_SILENCE
	LD A,(TEMPO)
	CPL
	LD C,A
	.SILENCE_LOOP2
	PUSH BC
	PUSH AF
	LD B,0
	.SILENCE_LOOP
	PUSH HL
	LD HL,0000
	SRA (HL)
	SRA (HL)
	SRA (HL)
	NOP
	POP HL
	DJNZ SILENCE_LOOP
	DEC C
	JP NZ,SILENCE_LOOP
	POP AF
	POP BC
	RET
	; *** DATA ***
	.TEMPO
	DEFB 232
	.MUSICDATA
	DEFB 0 ; Loop start point * 2
	DEFB 4 ; Song Length * 2
	.PATTERNDATA
	DEFW PAT0
	DEFW PAT1
	; *** Pattern data consists of pairs of frequency values CH1,CH2 with a single $0 to
	; *** Mark the end of the pattern, and $01 for a rest
	.PAT0
	DEFB 232 ; Pattern tempo
	DEFB 25,203
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 32,255
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 43,171
	DEFB 1,1
	DEFB 32,255
	DEFB 1,1
	DEFB 25,203
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 28,227
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 34,136
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 43,171
	DEFB 1,1
	DEFB 24,192
	DEFB 1,1
	DEFB 25,203
	DEFB 1,1
	DEFB 28,227
	DEFB 1,1
	DEFB 25,203
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 32,255
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 43,171
	DEFB 1,1
	DEFB 32,255
	DEFB 1,1
	DEFB 25,203
	DEFB 1,1
	DEFB 21,171
	DEFB 1,1
	DEFB 24,192
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 38,151
	DEFB 1,1
	DEFB 1,1
	DEFB 1,1
	DEFB 32,255
	DEFB 1,1
	DEFB 24,192
	DEFB 1,1
	DEFB 25,203
	DEFB 1,1
	DEFB 28,227
	DEFB 1,1
	DEFB $0
	.PAT1
	DEFB 232 ; Pattern tempo
	DEFB 25,255
	DEFB 1,1
	DEFB 1,203
	DEFB 1,1
	DEFB 32,171
	DEFB 1,1
	DEFB 1,203
	DEFB 1,1
	DEFB 43,255
	DEFB 1,203
	DEFB 32,171
	DEFB 1,203
	DEFB 25,171
	DEFB 1,203
	DEFB 1,171
	DEFB 1,203
	DEFB 28,227
	DEFB 1,1
	DEFB 1,171
	DEFB 1,1
	DEFB 34,136
	DEFB 1,1
	DEFB 1,171
	DEFB 1,1
	DEFB 43,227
	DEFB 1,171
	DEFB 24,136
	DEFB 1,171
	DEFB 25,136
	DEFB 1,171
	DEFB 28,136
	DEFB 1,171
	DEFB 25,255
	DEFB 1,1
	DEFB 1,203
	DEFB 1,1
	DEFB 32,171
	DEFB 1,1
	DEFB 1,203
	DEFB 1,1
	DEFB 43,255
	DEFB 1,203
	DEFB 32,171
	DEFB 1,203
	DEFB 25,171
	DEFB 1,203
	DEFB 21,171
	DEFB 1,203
	DEFB 24,255
	DEFB 1,1
	DEFB 1,192
	DEFB 1,1
	DEFB 38,151
	DEFB 1,1
	DEFB 1,192
	DEFB 1,1
	DEFB 32,255
	DEFB 1,192
	DEFB 24,151
	DEFB 1,192
	DEFB 25,151
	DEFB 1,192
	DEFB 28,255
	DEFB 1,192
	DEFB $0
;	SECTION	text

.i_1
	defm	"GAME OVER!"
	defb	0

;	SECTION	code



; --- Start of Static Variables ---

;	SECTION	bss

.__en_t	defs	1
.__en_x	defs	1
.__en_y	defs	1
._sp_moviles	defs	6
.__en_x1	defs	1
.__en_y1	defs	1
.__en_x2	defs	1
.__en_y2	defs	1
._spritesClip	defs	2
._hotspot_t	defs	1
._hotspot_x	defs	1
._hotspot_y	defs	1
.__en_mx	defs	1
.__en_my	defs	1
._half_life	defs	1
._en_cx	defs	1
._en_cy	defs	1
._flags	defs	1
._gp_gen_alt	defs	2
._en_xx	defs	1
._en_yy	defs	1
._gp_gen_org	defs	2
._killed_old	defs	1
._ezg_old	defs	1
._t_alt	defs	1
._x0	defs	1
._y0	defs	1
._x1	defs	1
._y1	defs	1
.__n	defs	1
.__t	defs	1
.__x	defs	1
.__y	defs	1
._life_old	defs	1
._en_ccx	defs	1
._en_ccy	defs	1
._ptgmx	defs	2
._ptgmy	defs	2
._sp_player	defs	2
._gp_gen	defs	2
._on_pant	defs	1
._enoffs	defs	1
._pad_this_frame	defs	1
._pad0	defs	1
._pad1	defs	1
._n_pant	defs	1
._en_j	defs	1
._en_x	defs	1
._en_y	defs	1
._enit	defs	1
._joyfunc	defs	2
._boxx	defs	1
._boyy	defs	1
._gpcx	defs	2
._fzx1	defs	1
._fzx2	defs	1
._fzy1	defs	1
._fzy2	defs	1
._gpcy	defs	2
._playing	defs	1
._gpit	defs	1
._rdt1	defs	1
._rdt2	defs	1
._seed	defs	2
._objs_old	defs	1
._gpxx	defs	1
._gpyy	defs	1
._maincounter	defs	1
._ptx1	defs	1
._ptx2	defs	1
._pty1	defs	1
._pty2	defs	1
._wall	defs	1
._f_zone_ac	defs	1
.__en_life	defs	1
._prxx	defs	1
._pryy	defs	1
._item_old	defs	1
._idx	defs	2
._player	defs	41
._jetpac_frame_counter	defs	1
._gpx	defs	1
._gpy	defs	1
._rdi	defs	1
._rdj	defs	2
._rdd	defs	1
._keys_old	defs	1
._rdx	defs	1
._rdy	defs	1
._pti	defs	1
._ptj	defs	1
._enoffsmasi	defs	1
._asm_int	defs	2
.__baddies_pointer	defs	2
._orig_tile	defs	1
._success	defs	1
._coins_old	defs	1
;	SECTION	code



; --- Start of Scope Defns ---

	LIB	sp_GetKey
	LIB	sp_BlockAlloc
	XDEF	__en_t
	LIB	sp_ScreenStr
	XDEF	__en_x
	XDEF	__en_y
	XDEF	_hotspots
	XDEF	_abs_a
	XDEF	_draw_scr
	LIB	sp_PixelUp
	LIB	sp_JoyFuller
	LIB	sp_MouseAMXInit
	XDEF	_can_move_box
	LIB	sp_MouseAMX
	XDEF	_saca_a_todo_el_mundo_de_aqui
	XDEF	_set_map_tile
	XDEF	_sp_moviles
	XDEF	__en_x1
	LIB	sp_SetMousePosAMX
	XDEF	__en_y1
	XDEF	_u_malloc
	LIB	sp_Validate
	LIB	sp_HashAdd
	XDEF	__en_x2
	XDEF	__en_y2
	XDEF	_cortina
	LIB	sp_Border
	LIB	sp_Inkey
	XDEF	_init_falling_box_buffer
	XDEF	_spritesClip
	XDEF	_hotspot_t
	XDEF	_hotspot_x
	XDEF	_hotspot_y
	LIB	sp_CreateSpr
	LIB	sp_MoveSprAbs
	LIB	sp_BlockCount
	LIB	sp_AddMemory
	XDEF	__en_mx
	XDEF	__en_my
	XDEF	_half_life
	XDEF	_en_cx
	XDEF	_en_cy
	XDEF	_adjust_to_tile_x
	XDEF	_adjust_to_tile_y
	XDEF	_en_an_state
	defc	_en_an_state	=	23648
	XDEF	_flags
	LIB	sp_PrintAt
	LIB	sp_Pause
	XDEF	_gp_gen_alt
	XDEF	_mueve_bicharracos
	LIB	sp_ListFirst
	LIB	sp_HeapSiftUp
	LIB	sp_ListCount
	LIB	sp_Heapify
	XDEF	_en_xx
	XDEF	_malotes
	XDEF	_en_yy
	XDEF	_draw_text
	XDEF	_key_1
	XDEF	_key_2
	XDEF	_key_3
	LIB	sp_MoveSprRel
	XDEF	_beepet
	XDEF	_play_sfx
	XDEF	_en_an_morido
	defc	_en_an_morido	=	23618
	XDEF	_gp_gen_org
	LIB	sp_TileArray
	LIB	sp_MouseSim
	LIB	sp_BlockFit
	XDEF	_map_buff
	defc	_map_buff	=	23450
	LIB	sp_HeapExtract
	LIB	sp_HuffExtract
	XDEF	_killed_old
	LIB	sp_SetMousePosSim
	LIB	sp_ClearRect
	XDEF	_ezg_old
	LIB	sp_HuffGetState
	XDEF	_map_attr
	defc	_map_attr	=	23300
	LIB	sp_ListAppend
	LIB	sp_ListCreate
	LIB	sp_ListConcat
	XDEF	_t_alt
	LIB	sp_JoyKempston
	LIB	sp_UpdateNow
	LIB	sp_MouseKempston
	LIB	sp_PrintString
	LIB	sp_PixelDown
	LIB	sp_MoveSprAbsC
	LIB	sp_PixelLeft
	XDEF	_x0
	LIB	sp_InitAlloc
	XDEF	_y0
	XDEF	_x1
	XDEF	_y1
	XDEF	_espera_activa
	LIB	sp_DeleteSpr
	LIB	sp_JoyTimexEither
	XDEF	__n
	XDEF	_title_screen
	XDEF	_en_an_fanty_activo
	defc	_en_an_fanty_activo	=	23645
	XDEF	__t
	XDEF	__x
	XDEF	__y
	XDEF	_player_hidden
	XDEF	_life_old
	LIB	sp_Invalidate
	XDEF	_en_ccx
	XDEF	_en_ccy
	LIB	sp_CreateGenericISR
	LIB	sp_JoyKeyboard
	LIB	sp_FreeBlock
	LIB	sp_PrintAtDiff
	XDEF	_fall_box
	XDEF	_s_marco
	XDEF	_sprite_10_a
	XDEF	_sprite_10_b
	XDEF	_sprite_10_c
	XDEF	_sprite_11_a
	XDEF	_sprite_11_b
	XDEF	_sprite_11_c
	XDEF	_sprite_12_a
	XDEF	_sprite_12_b
	XDEF	_sprite_12_c
	XDEF	_sprite_13_a
	XDEF	_sprite_13_b
	XDEF	_sprite_13_c
	XDEF	_sprite_14_a
	XDEF	_sprite_14_b
	XDEF	_sprite_14_c
	XDEF	_sprite_15_a
	XDEF	_sprite_15_b
	XDEF	_sprite_15_c
	LIB	sp_RegisterHookLast
	LIB	sp_IntLargeRect
	LIB	sp_IntPtLargeRect
	LIB	sp_HashDelete
	LIB	sp_GetCharAddr
	XDEF	_ptgmx
	XDEF	_ptgmy
	LIB	sp_RemoveHook
	XDEF	_en_an_current_frame
	defc	_en_an_current_frame	=	23606
	XDEF	_sprite_16_a
	XDEF	_sprite_16_b
	XDEF	_sprite_16_c
	XDEF	_sprite_18_a
	XDEF	_qtile
	XDEF	_init_cerrojos
	XDEF	_draw_and_advance
	LIB	sp_MoveSprRelC
	LIB	sp_InitIM2
	XDEF	_sp_player
	XDEF	_init_player
	XDEF	_gp_gen
	LIB	sp_GetTiles
	XDEF	_spritesClipValues
	XDEF	_on_pant
	LIB	sp_Pallette
	LIB	sp_WaitForNoKey
	XDEF	_enoffs
	XDEF	_pad_this_frame
	LIB	sp_JoySinclair1
	LIB	sp_JoySinclair2
	LIB	sp_ListPrepend
	LIB	sp_GetAttrAddr
	XDEF	_enem_cells
	LIB	sp_HashCreate
	XDEF	_pad0
	XDEF	_pad1
	LIB	sp_Random32
	LIB	sp_ListInsert
	XDEF	_n_pant
	LIB	sp_ListFree
	XDEF	_en_j
	XDEF	_en_x
	XDEF	_en_y
	XDEF	_draw_rectangle
	LIB	sp_IntRect
	LIB	sp_ListLast
	LIB	sp_ListCurr
	XDEF	_enit
	XDEF	_collide_enem
	XDEF	_main
	XDEF	_mapa
	LIB	sp_ListSearch
	LIB	sp_WaitForKey
	XDEF	_draw_coloured_tile
	LIB	sp_Wait
	LIB	sp_GetScrnAddr
	XDEF	_joyfunc
	LIB	sp_PutTiles
	XDEF	_boxx
	XDEF	_boyy
	XDEF	_gpcx
	XDEF	_fzx1
	XDEF	_fzx2
	XDEF	_fzy1
	XDEF	_fzy2
	XDEF	_gpcy
	LIB	sp_RemoveDList
	XDEF	_playing
	XDEF	_en_an_vx
	defc	_en_an_vx	=	23633
	XDEF	_en_an_vy
	defc	_en_an_vy	=	23639
	XDEF	_gpit
	XDEF	_rdt1
	XDEF	_rdt2
	XDEF	_attr
	XDEF	_s_title
	LIB	sp_ListNext
	XDEF	_line_of_text_clear
	XDEF	_player_cells
	LIB	sp_HuffDecode
	XDEF	_keys
	XDEF	_rand
	LIB	sp_Swap
	XDEF	_seed
	XDEF	_isrc
	defc	_isrc	=	23700
	XDEF	_objs_old
	XDEF	_gpxx
	XDEF	_gpyy
	LIB	sp_ListPrev
	XDEF	_maincounter
	XDEF	_ptx1
	XDEF	_ptx2
	XDEF	_pty1
	XDEF	_pty2
	XDEF	_move
	XDEF	_wall
	LIB	sp_RegisterHook
	LIB	sp_ListRemove
	LIB	sp_ListTrim
	XDEF	_f_zone_ac
	LIB	sp_MoveSprAbsNC
	XDEF	_clear_cerrojo
	LIB	sp_HuffDelete
	XDEF	_cerrojos
	XDEF	_en_an_next_frame
	defc	_en_an_next_frame	=	23612
	LIB	sp_ListAdd
	LIB	sp_KeyPressed
	XDEF	_step
	XDEF	__en_life
	LIB	sp_PrintAtInv
	XDEF	_prxx
	LIB	sp_CompDListAddr
	XDEF	_pryy
	XDEF	_u_free
	XDEF	_abs
	XDEF	_s_ending
	LIB	sp_CharRight
	XDEF	_game_ending
	LIB	sp_InstallISR
	XDEF	_item_old
	LIB	sp_HuffAccumulate
	LIB	sp_HuffSetState
	XDEF	_idx
	XDEF	_en_an_x
	defc	_en_an_x	=	23621
	XDEF	_en_an_y
	defc	_en_an_y	=	23627
	XDEF	_player
	XDEF	_sprite_1_a
	XDEF	_jetpac_frame_counter
	XDEF	_sprite_1_b
	XDEF	_sprite_1_c
	XDEF	_sprite_2_a
	XDEF	_sprite_2_b
	XDEF	_sprite_2_c
	XDEF	_sprite_3_a
	LIB	sp_SwapEndian
	LIB	sp_CharLeft
	XDEF	_gpx
	XDEF	_gpy
	LIB	sp_CharDown
	LIB	sp_HeapSiftDown
	LIB	sp_HuffCreate
	XDEF	_rdi
	XDEF	_rdj
	XDEF	_rdd
	XDEF	_sprite_3_b
	XDEF	_sprite_3_c
	XDEF	_keys_old
	LIB	sp_HuffEncode
	XDEF	_en_tocado
	XDEF	_init_player_values
	XDEF	_sprite_4_a
	XDEF	_sprite_4_b
	XDEF	_sprite_4_c
	LIB	sp_JoyTimexRight
	LIB	sp_PixelRight
	XDEF	_rdx
	XDEF	_rdy
	XDEF	_sprite_5_a
	LIB	sp_Initialize
	XDEF	_sprite_5_b
	XDEF	_sprite_5_c
	XDEF	_sprite_6_a
	XDEF	_pti
	XDEF	_ptj
	XDEF	_move_tile
	LIB	sp_JoyTimexLeft
	LIB	sp_SetMousePosKempston
	XDEF	_comportamiento_tiles
	XDEF	_tileset
	XDEF	_sprite_6_b
	LIB	sp_ComputePos
	XDEF	_sprite_6_c
	XDEF	_sprite_7_a
	XDEF	_sprite_7_b
	XDEF	_bitmask
	XDEF	_sprite_7_c
	XDEF	_sprite_8_a
	XDEF	_sprite_8_b
	XDEF	_sprite_8_c
	XDEF	_sprite_9_a
	XDEF	_sprite_9_b
	XDEF	_sprite_9_c
	XDEF	_draw_2_digits
	XDEF	_player_flicker
	XDEF	_init_hotspots
	XDEF	_enoffsmasi
	LIB	sp_IntIntervals
	XDEF	_my_malloc
	LIB	sp_inp
	LIB	sp_IterateSprChar
	LIB	sp_AddColSpr
	LIB	sp_outp
	XDEF	_asm_int
	LIB	sp_IntPtInterval
	LIB	sp_RegisterHookFirst
	XDEF	__baddies_pointer
	LIB	sp_HashLookup
	XDEF	_any_key
	LIB	sp_PFill
	LIB	sp_HashRemove
	LIB	sp_CharUp
	XDEF	_orig_tile
	XDEF	_en_an_frame
	defc	_en_an_frame	=	23600
	XDEF	_success
	LIB	sp_MoveSprRelNC
	XDEF	_coins_old
	XDEF	_do_extern_action
	XDEF	_platform_get_player
	XDEF	_en_an_count
	defc	_en_an_count	=	23603
	XDEF	_unpack
	LIB	sp_IterateDList
	XDEF	_max_screens
	XDEF	_draw_scr_background
	XDEF	_game_over
	LIB	sp_LookupKey
	LIB	sp_HeapAdd
	LIB	sp_CompDirtyAddr
	LIB	sp_EmptyISR
	LIB	sp_StackSpace


; --- End of Scope Defns ---


; --- End of Compilation ---
