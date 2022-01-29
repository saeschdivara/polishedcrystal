NUM_INITIAL_GAMEPLAY_OPTIONS EQU 1

SetInitialOptions2:
	ld a, $10
	ld [wMusicFade], a

	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	ld c, 8
	call DelayFrames

	call ClearBGPalettes
	call LoadFontsExtra

	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	rst ByteFill

	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	rst ByteFill

	ld hl, .BGPalette
	ld de, wBGPals1
	ld bc, 1 palettes
	call FarCopyColorWRAM

	ld de, .BGTiles
	ld hl, vTiles2 tile $00
	lb bc, BANK(.BGTiles), 3
	call Get2bpp

	farcall ApplyPals

	call ApplyAttrAndTilemapInVBlank
	call SetPalettes

	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1

	hlcoord 0, 0
	ld a, " "
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill

	hlcoord 0, 0
	ld a, $01 ; left
	ld bc, SCREEN_WIDTH - 2
	ld d, SCREEN_HEIGHT
.edge_loop
	ld [hli], a
	inc a ; right
	add hl, bc
	ld [hli], a
	dec a ; left
	dec d
	jr nz, .edge_loop

	hlcoord 2, 0
	ld de, .InitialOptionsString
	rst PlaceString

	xor a
	ld [wJumptableIndex], a
	ldh [hJoyPressed], a
	ld c, NUM_INITIAL_GAMEPLAY_OPTIONS
.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ldh [hJoyLast], a
	call GetInitialOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop

	xor a
	ld [wJumptableIndex], a
	inc a
	ldh [hBGMapMode], a
	call ApplyTilemapInVBlank

.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call InitialGameplayOptionsControl
	jr c, .dpad
	call GetInitialGameplayOptionPointer
	jr c, .ExitOptions

.dpad
	call InitialGameplayOptions_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld hl, wInitialOptions2
	res RESET_INIT_OPTS, [hl]
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

.InitialOptionsText:
	text_far _InitialOptionsText
	text_end

.BGPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 09, 30, 31
	RGB 01, 11, 31
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc


.BGTiles:
INCBIN "gfx/new_game/init_bg.2bpp"

.InitialOptionsString:
	db "Starters<LNBRK>"
	db "        :<LNBRK>"
	db "Done@"

GetInitialGameplayOptionPointer:
	call StandardStackJumpTable ; always before union of pointers

.Pointers:
	dw InitialPlayOptions_Starters
	dw InitialOptions_Done

InitialPlayOptions_Starters:
	ld hl, wInitialGameplayOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .ChangeChoice
	bit 1, [hl]
	jr z, .SetJohto
	jr .SetKanto
.ChangeChoice
	bit 1, [hl]
	jr z, .SetKanto
.SetJohto:
	res 1, [hl] ; = 0
	ld de, JohtoStartersString
	jr .Display
.SetKanto:
	set 1, [hl]  ; = 1
	ld de, KantoStartersString
.Display:
	hlcoord 10, 1
	rst PlaceString
	and a
	ret

JohtoStartersString:
	db "Johto   @"
KantoStartersString:
	db "Kanto   @"

InitialGameplayOptionsControl:
	ld hl, wJumptableIndex
	ldh a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl] ; load the cursor position to a
	cp NUM_INITIAL_GAMEPLAY_OPTIONS
	jr nz, .Increase
	ld [hl], -1
.Increase:
	inc [hl]
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a
	jr nz, .Decrease
	ld [hl], NUM_INITIAL_GAMEPLAY_OPTIONS + 1
.Decrease:
	dec [hl]
	scf
	ret

InitialGameplayOptions_UpdateCursorPosition:
	hlcoord 1, 0
	ld de, SCREEN_WIDTH
	ld c, SCREEN_HEIGHT
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	ld hl, .InitialOptions_CursorPositions
	ld a, [wJumptableIndex]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	; hlcoord 1, a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	inc hl
	ld [hl], "▶"
	ret

.InitialOptions_CursorPositions:
	db 0, 2