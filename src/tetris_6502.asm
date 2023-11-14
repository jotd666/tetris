;    ========================================================================
;    CPU #1
;    ========================================================================
;    0000-0FFF   R/W   xxxxxxxx    Program RAM
;    1000-1FFF   R/W   xxxxxxxx    Playfield RAM
;                      xxxxxxxx       (byte 0: LSB of character code)
;                      -----xxx       (byte 1: MSB of character code)
;                      xxxx----       (byte 1: palette index)
;    2000-20FF   R/W   xxxxxxxx    Palette RAM
;                      xxx----        (red component)
;                      ---xxx--       (green component)
;                      ------xx       (blue component)
;    2400-25FF   R/W   xxxxxxxx    EEPROM
;    2800-280F   R/W   xxxxxxxx    POKEY #1
;    2810-281F   R/W   xxxxxxxx    POKEY #2
;    3000          W   --------    Watchdog
;    3400          W   --------    EEPROM write enable
;    3800          W   --------    IRQ acknowledge
;    3C00          W   --xx----    Coin counters
;                  W   --x-----       (right coin counter)
;                  W   ---x----       (left coin counter)
;    4000-7FFF   R     xxxxxxxx    Banked program ROM
;    8000-FFFF   R     xxxxxxxx    Program ROM
;
; jotd: slapstic inner workings are complex but the MAME team
; has already reversed so debugging with MAME gives the proper bank numbers
; bank 1 contains code
; bank 0 (starts with 00 00 00) contains only data
; this is bank 1
4000: 20 2D 40 jsr	$402d
4003: 58       cli
4004: E6 CA    inc	$00ca
4006: AE 10 0C ldx	$0c10
4009: EC 11 0C cpx	$0c11
400C: F0 10    beq	$401e
400E: E8       inx
400F: E0 10    cpx #$10
4011: 90 02    bcc	$4015
4013: A2 00    ldx #$00
4015: 8E 10 0C stx	$0c10
4018: BC 00 0C ldy	$0c00, x
401B: 20 60 41 jsr	$4160
401E: A5 CA    lda	$00ca
4020: 4A       lsr a
4021: 90 05    bcc	$4028
4023: A2 00    ldx #$00
4025: 4C 4D 4B jmp	$4b4d
4028: A2 01    ldx #$01
402A: 4C 4D 4B jmp	$4b4d
402D: 08       php
402E: 78       sei
402F: 20 A8 40 jsr	$40a8
4032: A9 00    lda #$00
4034: 8D 22 0C sta	$0c22
4037: 8D 23 0C sta	$0c23
403A: 8D 24 0C sta	$0c24
403D: 8D 10 0C sta	$0c10
4040: 8D 11 0C sta	$0c11
4043: A2 11    ldx #$11
4045: 9D 2D 0E sta	$0e2d, x
4048: CA       dex
4049: 10 FA    bpl	$4045
404B: A2 09    ldx #$09
404D: 9D B1 0C sta	$0cb1, x
4050: 9D 43 0C sta	$0c43, x
4053: 9D 4D 0C sta	$0c4d, x
4056: 9D D9 0C sta	$0cd9, x
4059: 9D A1 0D sta	$0da1, x
405C: CA       dex
405D: 10 EE    bpl	$404d
405F: A2 01    ldx #$01
4061: BD 08 50 lda	$5008, x
4064: 85 CE    sta	$00ce
4066: BD 0A 50 lda	$500a, x
4069: 85 CF    sta	$00cf
406B: A9 00    lda #$00
406D: A0 08    ldy #$08
406F: 91 CE    sta ($ce), y
4071: 86 D9    stx	$00d9
4073: 18       clc
4074: A5 CE    lda	$00ce
4076: 85 DA    sta	$00da
4078: A9 0F    lda #$0f
407A: 65 CE    adc	$00ce
407C: 85 CE    sta	$00ce
407E: A2 00    ldx #$00
4080: 8A       txa
4081: 81 CE    sta ($ce, x)
4083: 69 01    adc #$01
4085: C9 07    cmp #$07
4087: D0 FA    bne	$4083
4089: 81 CE    sta ($ce, x)
408B: A6 D9    ldx	$00d9
408D: A5 DA    lda	$00da
408F: 85 CE    sta	$00ce
4091: A0 08    ldy #$08
4093: A9 00    lda #$00
4095: 91 CE    sta ($ce), y
4097: A9 00    lda #$00
4099: A0 08    ldy #$08
409B: 88       dey
409C: 91 CE    sta ($ce), y
409E: D0 FB    bne	$409b
40A0: CA       dex
40A1: 30 03    bmi	$40a6
40A3: 4C 61 40 jmp	$4061
40A6: 28       plp
40A7: 60       rts
40A8: A9 01    lda #$01
40AA: 85 DC    sta	$00dc
40AC: 20 EA 40 jsr	$40ea
40AF: A9 02    lda #$02
40B1: 91 DD    sta ($dd), y
40B3: AA       tax
40B4: E8       inx
40B5: A5 DD    lda	$00dd
40B7: 18       clc
40B8: 69 04    adc #$04
40BA: 85 DD    sta	$00dd
40BC: 90 08    bcc	$40c6
40BE: E6 DE    inc	$00de
40C0: A9 0F    lda #$0f
40C2: C5 DE    cmp	$00de
40C4: F0 05    beq	$40cb
40C6: 8A       txa
40C7: C9 C8    cmp #$c8
40C9: 90 E6    bcc	$40b1
40CB: C6 DE    dec	$00de
40CD: A5 DD    lda	$00dd
40CF: 38       sec
40D0: E9 04    sbc #$04
40D2: 85 DD    sta	$00dd
40D4: A9 00    lda #$00
40D6: 91 DD    sta ($dd), y
40D8: 60       rts
40D9: A5 DC    lda	$00dc
40DB: 20 EA 40 jsr	$40ea
40DE: 48       pha
40DF: B1 DD    lda ($dd), y
40E1: F0 04    beq	$40e7
40E3: 85 DC    sta	$00dc
40E5: 68       pla
40E6: 60       rts
40E7: A9 00    lda #$00
40E9: 60       rts
40EA: 48       pha
40EB: A8       tay
40EC: 88       dey
40ED: 84 DD    sty	$00dd
40EF: 84 D6    sty	$00d6
40F1: A0 00    ldy #$00
40F3: 84 DE    sty	$00de
40F5: 06 DD    asl	$00dd
40F7: 26 DE    rol	$00de
40F9: 06 DD    asl	$00dd
40FB: 26 DE    rol	$00de
40FD: A9 57    lda #$57
40FF: 18       clc
4100: 65 DD    adc	$00dd
4102: 85 DD    sta	$00dd
4104: A9 0E    lda #$0e
4106: 65 DE    adc	$00de
4108: 85 DE    sta	$00de
410A: 68       pla
410B: 60       rts
410C: 98       tya
410D: 48       pha
410E: BD D3 0D lda	$0dd3, x
4111: F0 13    beq	$4126
4113: 20 EA 40 jsr	$40ea
4116: 48       pha
4117: B1 DD    lda ($dd), y
4119: 9D D3 0D sta	$0dd3, x
411C: A5 DC    lda	$00dc
411E: 91 DD    sta ($dd), y
4120: 68       pla
4121: 85 DC    sta	$00dc
4123: 4C 0E 41 jmp	$410e
4126: BD C9 0D lda	$0dc9, x
4129: F0 13    beq	$413e
412B: 20 EA 40 jsr	$40ea
412E: 48       pha
412F: B1 DD    lda ($dd), y
4131: 9D C9 0D sta	$0dc9, x
4134: A5 DC    lda	$00dc
4136: 91 DD    sta ($dd), y
4138: 68       pla
4139: 85 DC    sta	$00dc
413B: 4C 26 41 jmp	$4126
413E: 68       pla
413F: A8       tay
4140: 60       rts
4141: 08       php
4142: 78       sei
4143: AC 11 0C ldy	$0c11
4146: C8       iny
4147: C0 10    cpy #$10
4149: 90 02    bcc	$414d
414B: A0 00    ldy #$00
414D: 8C 11 0C sty	$0c11
4150: CC 10 0C cpy	$0c10
4153: D0 04    bne	$4159
4155: A9 FF    lda #$ff
4157: 28       plp
4158: 60       rts
4159: 99 00 0C sta	$0c00, y
415C: A9 00    lda #$00
415E: 28       plp
415F: 60       rts
4160: C0 1D    cpy #$1d
4162: B0 14    bcs	$4178
4164: B9 52 52 lda	$5252, y
4167: C9 15    cmp #$15
4169: B0 0D    bcs	$4178
416B: 0A       asl a
416C: AA       tax
416D: BD AD 44 lda	$44ad, x
4170: 48       pha
4171: BD AC 44 lda	$44ac, x
4174: 48       pha
4175: B9 6F 52 lda	$526f, y
4178: 60       rts
4179: 0A       asl a
417A: 0A       asl a
417B: 85 DB    sta	$00db
417D: 60       rts
417E: A8       tay
417F: B9 59 54 lda	$5459, y
4182: 29 1F    and #$1f
4184: AA       tax
4185: B9 5A 54 lda	$545a, y
4188: 95 E0    sta	$00e0, x
418A: 60       rts
418B: A8       tay
418C: B9 59 54 lda	$5459, y
418F: 29 1F    and #$1f
4191: AA       tax
4192: B9 5A 54 lda	$545a, y
4195: 18       clc
4196: 75 E0    adc	$00e0, x
4198: 95 E0    sta	$00e0, x
419A: 60       rts
* jump table (not reached? plus table data looks bogus)
419B: 0A       asl a
419C: A8       tay
419D: B9 8D 52 lda	$528d, y
41A0: 48       pha
41A1: B9 8C 52 lda	$528c, y
41A4: 48       pha
41A5: 60       rts


41A6: 08       php
41A7: 78       sei
41A8: 85 D9    sta	$00d9
41AA: A0 09    ldy #$09
41AC: B9 B1 0C lda	$0cb1, y
41AF: 4A       lsr a
41B0: 4A       lsr a
41B1: 45 D9    eor	$00d9
41B3: D0 05    bne	$41ba
41B5: A9 FF    lda #$ff
41B7: 99 25 0C sta	$0c25, y
41BA: 88       dey
41BB: 10 EF    bpl	$41ac
41BD: 28       plp
41BE: 60       rts
41BF: 08       php
41C0: 78       sei
41C1: A8       tay
41C2: B9 52 52 lda	$5252, y
41C5: C9 08    cmp #$08
41C7: D0 16    bne	$41df
41C9: B9 6F 52 lda	$526f, y
41CC: 85 D9    sta	$00d9
41CE: A0 09    ldy #$09
41D0: D9 25 0C cmp	$0c25, y
41D3: D0 07    bne	$41dc
41D5: A9 FF    lda #$ff
41D7: 99 25 0C sta	$0c25, y
41DA: A5 D9    lda	$00d9
41DC: 88       dey
41DD: 10 F1    bpl	$41d0
41DF: 28       plp
41E0: 60       rts
41E1: 85 D9    sta	$00d9
41E3: 4A       lsr a
41E4: 4A       lsr a
41E5: 4A       lsr a
41E6: 4A       lsr a
41E7: A8       tay
41E8: A5 D9    lda	$00d9
41EA: 29 0F    and #$0f
41EC: 18       clc
41ED: 79 0E 50 adc	$500e, y
41F0: A8       tay
41F1: 08       php
41F2: 78       sei
41F3: B9 2D 0E lda	$0e2d, y
41F6: F0 0C    beq	$4204
41F8: A8       tay
41F9: 88       dey
41FA: A9 FF    lda #$ff
41FC: 99 25 0C sta	$0c25, y
41FF: B9 2D 0E lda	$0e2d, y
4202: D0 F4    bne	$41f8
4204: 28       plp
4205: 60       rts
4206: 08       php
4207: 78       sei
4208: 85 D9    sta	$00d9
420A: A5 D9    lda	$00d9
420C: D0 06    bne	$4214
420E: A9 80    lda #$80
4210: 85 D9    sta	$00d9
4212: D0 04    bne	$4218
4214: A9 40    lda #$40
4216: 85 D9    sta	$00d9
4218: A0 09    ldy #$09
421A: B9 B1 0C lda	$0cb1, y
421D: F0 00    beq	$421f
421F: 88       dey
4220: 10 F8    bpl	$421a
4222: 28       plp
4223: 60       rts
4224: 08       php
4225: 78       sei
4226: A8       tay
4227: B9 52 52 lda	$5252, y
422A: C9 08    cmp #$08
422C: D0 2B    bne	$4259
422E: B9 6F 52 lda	$526f, y
4231: 85 D9    sta	$00d9
4233: A0 09    ldy #$09
4235: D9 25 0C cmp	$0c25, y
4238: D0 1C    bne	$4256
423A: A9 00    lda #$00
423C: 99 E7 0D sta	$0de7, y
423F: 99 0F 0E sta	$0e0f, y
4242: 99 FB 0D sta	$0dfb, y
4245: A9 D0    lda #$d0
4247: 99 05 0E sta	$0e05, y
424A: A9 02    lda #$02
424C: 99 F1 0D sta	$0df1, y
424F: A9 FE    lda #$fe
4251: 99 25 0C sta	$0c25, y
4254: A5 D9    lda	$00d9
4256: 88       dey
4257: 10 DC    bpl	$4235
4259: 28       plp
425A: 60       rts
425B: 08       php
425C: 78       sei
425D: 85 D9    sta	$00d9
425F: A0 09    ldy #$09
4261: B9 B1 0C lda	$0cb1, y
4264: 4A       lsr a
4265: 4A       lsr a
4266: 45 D9    eor	$00d9
4268: D0 1A    bne	$4284
426A: A9 00    lda #$00
426C: 99 E7 0D sta	$0de7, y
426F: 99 0F 0E sta	$0e0f, y
4272: 99 FB 0D sta	$0dfb, y
4275: A9 D0    lda #$d0
4277: 99 05 0E sta	$0e05, y
427A: A9 02    lda #$02
427C: 99 F1 0D sta	$0df1, y
427F: A9 FE    lda #$fe
4281: 99 25 0C sta	$0c25, y
4284: 88       dey
4285: 10 DA    bpl	$4261
4287: 28       plp
4288: 60       rts
4289: AC 23 0C ldy	$0c23
428C: 99 12 0C sta	$0c12, y
428F: C8       iny
4290: C0 10    cpy #$10
4292: 90 02    bcc	$4296
4294: A0 00    ldy #$00
4296: CC 22 0C cpy	$0c22
4299: F0 04    beq	$429f
429B: 8C 23 0C sty	$0c23
429E: 60       rts
429F: A9 80    lda #$80
42A1: 8D 24 0C sta	$0c24
42A4: 60       rts
42A5: AA       tax
42A6: BD 5B 54 lda	$545b, x
42A9: C9 3B    cmp #$3b
42AB: B0 3E    bcs	$42eb
42AD: C9 08    cmp #$08
42AF: 90 14    bcc	$42c5
42B1: C9 0A    cmp #$0a
42B3: 90 36    bcc	$42eb
42B5: C9 0D    cmp #$0d
42B7: 90 0C    bcc	$42c5
42B9: C9 12    cmp #$12
42BB: 90 2E    bcc	$42eb
42BD: C9 16    cmp #$16
42BF: 90 04    bcc	$42c5
42C1: C9 19    cmp #$19
42C3: 90 26    bcc	$42eb
42C5: 0A       asl a
42C6: A8       tay
42C7: BD 5E 54 lda	$545e, x
42CA: 18       clc
42CB: 69 0A    adc #$0a
42CD: 48       pha
42CE: BD 5C 54 lda	$545c, x
42D1: 8D 56 0E sta	$0e56
42D4: BD 5D 54 lda	$545d, x
42D7: AA       tax
42D8: BD 52 52 lda	$5252, x
42DB: C9 08    cmp #$08
42DD: D0 0B    bne	$42ea
42DF: BD 6F 52 lda	$526f, x
42E2: 8D 55 0E sta	$0e55
42E5: 68       pla
42E6: AA       tax
42E7: 4C 90 4B jmp	$4b90
42EA: 68       pla
42EB: 60       rts
42EC: 85 CB    sta	$00cb
42EE: A8       tay
42EF: 0A       asl a
42F0: AA       tax
42F1: B0 05    bcs	$42f8
42F3: BD 8E 52 lda	$528e, x
42F6: 90 03    bcc	$42fb
42F8: BD 8E 53 lda	$538e, x
42FB: 85 D0    sta	$00d0
42FD: B0 05    bcs	$4304
42FF: BD 8F 52 lda	$528f, x
4302: 90 03    bcc	$4307
4304: BD 8F 53 lda	$538f, x
4307: 85 D1    sta	$00d1
4309: B9 C0 52 lda	$52c0, y
430C: D0 14    bne	$4322
430E: A5 CB    lda	$00cb
4310: A0 09    ldy #$09
4312: D9 25 0C cmp	$0c25, y
4315: D0 08    bne	$431f
4317: B9 B1 0C lda	$0cb1, y
431A: F0 01    beq	$431d
431C: 60       rts
431D: A5 CB    lda	$00cb
431F: 88       dey
4320: 10 F0    bpl	$4312
4322: A0 09    ldy #$09
4324: B9 B1 0C lda	$0cb1, y
4327: F0 45    beq	$436e
4329: 88       dey
432A: 10 F8    bpl	$4324
432C: A0 00    ldy #$00
432E: A9 D9    lda #$d9
4330: 18       clc
4331: 65 D0    adc	$00d0
4333: 85 D2    sta	$00d2
4335: A9 52    lda #$52
4337: 65 D1    adc	$00d1
4339: 85 D3    sta	$00d3
433B: B1 D2    lda ($d2), y
433D: 85 D4    sta	$00d4
433F: A9 19    lda #$19
4341: 18       clc
4342: 65 D0    adc	$00d0
4344: 85 D2    sta	$00d2
4346: A9 53    lda #$53
4348: 65 D1    adc	$00d1
434A: 85 D3    sta	$00d3
434C: B1 D2    lda ($d2), y
434E: 18       clc
434F: 69 0A    adc #$0a
4351: AA       tax
4352: 08       php
4353: 78       sei
4354: BC 2D 0E ldy	$0e2d, x
4357: F0 0B    beq	$4364
4359: 88       dey
435A: A5 D4    lda	$00d4
435C: 0A       asl a
435D: 38       sec
435E: 2A       rol a
435F: D9 B1 0C cmp	$0cb1, y
4362: B0 03    bcs	$4367
4364: 28       plp
4365: 38       sec
4366: 60       rts
4367: B9 2D 0E lda	$0e2d, y
436A: 9D 2D 0E sta	$0e2d, x
436D: 28       plp
436E: 98       tya
436F: AA       tax
4370: 20 28 44 jsr	$4428
4373: A0 00    ldy #$00
4375: A9 D9    lda #$d9
4377: 18       clc
4378: 65 D0    adc	$00d0
437A: 85 D2    sta	$00d2
437C: A9 52    lda #$52
437E: 65 D1    adc	$00d1
4380: 85 D3    sta	$00d3
4382: B1 D2    lda ($d2), y
4384: 0A       asl a
4385: 38       sec
4386: 2A       rol a
4387: 9D B1 0C sta	$0cb1, x
438A: A9 19    lda #$19
438C: 18       clc
438D: 65 D0    adc	$00d0
438F: 85 D2    sta	$00d2
4391: A9 53    lda #$53
4393: 65 D1    adc	$00d1
4395: 85 D3    sta	$00d3
4397: B1 D2    lda ($d2), y
4399: 18       clc
439A: 69 0A    adc #$0a
439C: 85 D4    sta	$00d4
439E: A5 D0    lda	$00d0
43A0: 0A       asl a
43A1: 85 D2    sta	$00d2
43A3: A5 D1    lda	$00d1
43A5: 2A       rol a
43A6: 85 D3    sta	$00d3
43A8: A9 59    lda #$59
43AA: 18       clc
43AB: 65 D2    adc	$00d2
43AD: 85 D2    sta	$00d2
43AF: A9 53    lda #$53
43B1: 65 D3    adc	$00d3
43B3: 85 D3    sta	$00d3
43B5: B1 D2    lda ($d2), y
43B7: 9D 2F 0C sta	$0c2f, x
43BA: C8       iny
43BB: B1 D2    lda ($d2), y
43BD: 9D 39 0C sta	$0c39, x
43C0: A4 D4    ldy	$00d4
43C2: 08       php
43C3: 78       sei
43C4: 84 D4    sty	$00d4
43C6: B9 2D 0E lda	$0e2d, y
43C9: F0 28    beq	$43f3
43CB: A8       tay
43CC: 88       dey
43CD: B9 B1 0C lda	$0cb1, y
43D0: 09 01    ora #$01
43D2: DD B1 0C cmp	$0cb1, x
43D5: 90 ED    bcc	$43c4
43D7: F0 04    beq	$43dd
43D9: C8       iny
43DA: 98       tya
43DB: B0 11    bcs	$43ee
43DD: 8A       txa
43DE: 48       pha
43DF: 98       tya
43E0: AA       tax
43E1: 20 0C 41 jsr	$410c
43E4: 68       pla
43E5: AA       tax
43E6: A9 00    lda #$00
43E8: 99 B1 0C sta	$0cb1, y
43EB: B9 2D 0E lda	$0e2d, y
43EE: 9D 2D 0E sta	$0e2d, x
43F1: A4 D4    ldy	$00d4
43F3: A5 CB    lda	$00cb
43F5: 9D 25 0C sta	$0c25, x
43F8: E8       inx
43F9: 8A       txa
43FA: 99 2D 0E sta	$0e2d, y
43FD: 28       plp
43FE: A0 00    ldy #$00
4400: A5 D0    lda	$00d0
4402: 0A       asl a
4403: 85 D2    sta	$00d2
4405: A5 D1    lda	$00d1
4407: 2A       rol a
4408: 85 D3    sta	$00d3
440A: A9 D9    lda #$d9
440C: 18       clc
440D: 65 D2    adc	$00d2
440F: 85 D2    sta	$00d2
4411: A9 53    lda #$53
4413: 65 D3    adc	$00d3
4415: 85 D3    sta	$00d3
4417: B1 D2    lda ($d2), y
4419: 85 D0    sta	$00d0
441B: C8       iny
441C: 11 D2    ora ($d2), y
441E: F0 07    beq	$4427
4420: B1 D2    lda ($d2), y
4422: 85 D1    sta	$00d1
4424: 4C 22 43 jmp	$4322
4427: 60       rts
4428: A9 07    lda #$07
442A: 9D D9 0C sta	$0cd9, x
442D: A9 10    lda #$10
442F: 9D 79 0D sta	$0d79, x
4432: A9 A0    lda #$a0
4434: 9D A1 0D sta	$0da1, x
4437: A9 FF    lda #$ff
4439: 9D C5 0C sta	$0cc5, x
443C: A9 00    lda #$00
443E: 9D 6F 0D sta	$0d6f, x
4441: 9D CF 0C sta	$0ccf, x
4444: 9D 2D 0E sta	$0e2d, x
4447: 9D 83 0D sta	$0d83, x
444A: 9D 57 0C sta	$0c57, x
444D: 9D 61 0C sta	$0c61, x
4450: 9D 6B 0C sta	$0c6b, x
4453: 9D AB 0D sta	$0dab, x
4456: 9D DD 0D sta	$0ddd, x
4459: 9D B5 0D sta	$0db5, x
445C: 9D BF 0D sta	$0dbf, x
445F: 9D C9 0D sta	$0dc9, x
4462: 9D D3 0D sta	$0dd3, x
4465: 9D 75 0C sta	$0c75, x
4468: 9D 7F 0C sta	$0c7f, x
446B: 9D 89 0C sta	$0c89, x
446E: 9D 93 0C sta	$0c93, x
4471: 9D E7 0D sta	$0de7, x
4474: 9D F1 0D sta	$0df1, x
4477: 9D 47 0D sta	$0d47, x
447A: 9D 51 0D sta	$0d51, x
447D: 9D 5B 0D sta	$0d5b, x
4480: 9D 19 0E sta	$0e19, x
4483: 9D 23 0E sta	$0e23, x
4486: 9D 97 0D sta	$0d97, x
4489: 9D 8D 0D sta	$0d8d, x
448C: 9D 33 0D sta	$0d33, x
448F: 9D 65 0D sta	$0d65, x
4492: 9D 0B 0D sta	$0d0b, x
4495: 9D 29 0D sta	$0d29, x
4498: 9D BB 0C sta	$0cbb, x
449B: A9 10    lda #$10
449D: 9D E3 0C sta	$0ce3, x
44A0: 9D F7 0C sta	$0cf7, x
44A3: A9 50    lda #$50
44A5: 9D ED 0C sta	$0ced, x
44A8: 9D 01 0D sta	$0d01, x
44AB: 60       rts

44D6: BD 2D 0E lda	$0e2d, x
44D9: F0 02    beq	$44dd
44DB: A9 FF    lda #$ff
44DD: 85 DF    sta	$00df
44DF: BD B1 0C lda	$0cb1, x
44E2: F0 07    beq	$44eb
44E4: BC 25 0C ldy	$0c25, x
44E7: C8       iny
44E8: D0 04    bne	$44ee
44EA: 98       tya
44EB: 4C 0A 46 jmp	$460a
44EE: 29 03    and #$03
44F0: 8D 42 0E sta	$0e42
44F3: 29 01    and #$01
44F5: A8       tay
44F6: BD B1 0C lda	$0cb1, x
44F9: 99 40 0E sta	$0e40, y
44FC: BD 2F 0C lda	$0c2f, x
44FF: 85 CC    sta	$00cc
4501: BD 39 0C lda	$0c39, x
4504: 85 CD    sta	$00cd
4506: BD 57 0C lda	$0c57, x
4509: 38       sec
450A: FD 6F 0D sbc	$0d6f, x
450D: 9D 57 0C sta	$0c57, x
4510: BD 61 0C lda	$0c61, x
4513: FD 79 0D sbc	$0d79, x
4516: 9D 61 0C sta	$0c61, x
4519: B0 08    bcs	$4523
451B: DE 6B 0C dec	$0c6b, x
451E: 10 03    bpl	$4523
4520: 4C 4D 45 jmp	$454d
4523: BD 89 0C lda	$0c89, x
4526: 30 1A    bmi	$4542
4528: BD 75 0C lda	$0c75, x
452B: 38       sec
452C: FD 6F 0D sbc	$0d6f, x
452F: 9D 75 0C sta	$0c75, x
4532: BD 7F 0C lda	$0c7f, x
4535: FD 79 0D sbc	$0d79, x
4538: 9D 7F 0C sta	$0c7f, x
453B: B0 0D    bcs	$454a
453D: DE 89 0C dec	$0c89, x
4540: 10 08    bpl	$454a
4542: AD 42 0E lda	$0e42
4545: F0 03    beq	$454a
4547: 4C 24 49 jmp	$4924
454A: 4C 78 47 jmp	$4778
454D: BD 2F 0C lda	$0c2f, x
4550: 18       clc
4551: 69 02    adc #$02
4553: 9D 2F 0C sta	$0c2f, x
4556: 90 03    bcc	$455b
4558: FE 39 0C inc	$0c39, x
455B: A0 00    ldy #$00
455D: B1 CC    lda ($cc), y
455F: 10 1F    bpl	$4580
4561: 20 60 4B jsr	$4b60
4564: 90 0C    bcc	$4572
4566: BD 39 0C lda	$0c39, x
4569: 85 CD    sta	$00cd
456B: BD 2F 0C lda	$0c2f, x
456E: 85 CC    sta	$00cc
4570: B0 DB    bcs	$454d
4572: AD 42 0E lda	$0e42
4575: 29 01    and #$01
4577: A8       tay
4578: A9 00    lda #$00
457A: 99 40 0E sta	$0e40, y
457D: 4C 41 49 jmp	$4941
4580: AC 42 0E ldy	$0e42
4583: F0 04    beq	$4589
4585: C9 00    cmp #$00
4587: F0 04    beq	$458d
4589: 18       clc
458A: 7D 83 0D adc	$0d83, x
458D: AC 42 0E ldy	$0e42
4590: F0 04    beq	$4596
4592: C0 01    cpy #$01
4594: F0 1E    beq	$45b4
4596: 48       pha
4597: 38       sec
4598: FD 43 0C sbc	$0c43, x
459B: 9D B5 0D sta	$0db5, x
459E: 0A       asl a
459F: A9 FF    lda #$ff
45A1: B0 02    bcs	$45a5
45A3: A9 00    lda #$00
45A5: 9D BF 0D sta	$0dbf, x
45A8: 68       pla
45A9: 9D 43 0C sta	$0c43, x
45AC: A9 00    lda #$00
45AE: 9D 4D 0C sta	$0c4d, x
45B1: 4C D5 45 jmp	$45d5
45B4: 0A       asl a
45B5: A8       tay
45B6: 38       sec
45B7: BD 43 0C lda	$0c43, x
45BA: F9 DE 50 sbc	$50de, y
45BD: 9D B5 0D sta	$0db5, x
45C0: BD 4D 0C lda	$0c4d, x
45C3: F9 DF 50 sbc	$50df, y
45C6: 9D BF 0D sta	$0dbf, x
45C9: B9 DE 50 lda	$50de, y
45CC: 9D 43 0C sta	$0c43, x
45CF: B9 DF 50 lda	$50df, y
45D2: 9D 4D 0C sta	$0c4d, x
45D5: A0 01    ldy #$01
45D7: A9 00    lda #$00
45D9: 85 D9    sta	$00d9
45DB: B1 CC    lda ($cc), y
45DD: F0 03    beq	$45e2
45DF: 4C 2B 46 jmp	$462b
45E2: BD C9 0D lda	$0dc9, x
45E5: F0 23    beq	$460a
45E7: 48       pha
45E8: 20 EA 40 jsr	$40ea
45EB: B1 DD    lda ($dd), y
45ED: 9D C9 0D sta	$0dc9, x
45F0: A5 DC    lda	$00dc
45F2: 91 DD    sta ($dd), y
45F4: 68       pla
45F5: 85 DC    sta	$00dc
45F7: C8       iny
45F8: B1 DD    lda ($dd), y
45FA: 9D 2F 0C sta	$0c2f, x
45FD: 85 CC    sta	$00cc
45FF: C8       iny
4600: B1 DD    lda ($dd), y
4602: 9D 39 0C sta	$0c39, x
4605: 85 CD    sta	$00cd
4607: 4C 4D 45 jmp	$454d
460A: 9D B1 0C sta	$0cb1, x
460D: 9D D9 0C sta	$0cd9, x
4610: 9D 93 0C sta	$0c93, x
4613: 9D E7 0D sta	$0de7, x
4616: 9D F1 0D sta	$0df1, x
4619: 8D 48 0E sta	$0e48
461C: 20 0C 41 jsr	$410c
461F: BD 2D 0E lda	$0e2d, x
4622: AE 4B 0E ldx	$0e4b
4625: 9D 2D 0E sta	$0e2d, x
4628: 4C 24 49 jmp	$4924
462B: 48       pha
462C: AD 42 0E lda	$0e42
462F: D0 03    bne	$4634
4631: 4C D6 46 jmp	$46d6
4634: 68       pla
4635: 85 D9    sta	$00d9
4637: 29 0F    and #$0f
4639: 0A       asl a
463A: A8       tay
463B: B9 A2 51 lda	$51a2, y
463E: 18       clc
463F: 7D 61 0C adc	$0c61, x
4642: 9D 61 0C sta	$0c61, x
4645: B9 A3 51 lda	$51a3, y
4648: 7D 6B 0C adc	$0c6b, x
464B: 9D 6B 0C sta	$0c6b, x
464E: A5 D9    lda	$00d9
4650: 29 40    and #$40
4652: F0 17    beq	$466b
4654: B9 A3 51 lda	$51a3, y
4657: 4A       lsr a
4658: 48       pha
4659: B9 A2 51 lda	$51a2, y
465C: 6A       ror a
465D: 18       clc
465E: 7D 61 0C adc	$0c61, x
4661: 9D 61 0C sta	$0c61, x
4664: 68       pla
4665: 7D 6B 0C adc	$0c6b, x
4668: 9D 6B 0C sta	$0c6b, x
466B: A9 7F    lda #$7f
466D: 9D 89 0C sta	$0c89, x
4670: A5 D9    lda	$00d9
4672: 30 3D    bmi	$46b1
4674: A9 00    lda #$00
4676: 85 D8    sta	$00d8
4678: BD 79 0D lda	$0d79, x
467B: 85 D7    sta	$00d7
467D: BD 6F 0D lda	$0d6f, x
4680: 0A       asl a
4681: 26 D7    rol	$00d7
4683: 26 D8    rol	$00d8
4685: 85 D6    sta	$00d6
4687: BD 57 0C lda	$0c57, x
468A: 38       sec
468B: E5 D6    sbc	$00d6
468D: 9D 75 0C sta	$0c75, x
4690: BD 61 0C lda	$0c61, x
4693: E5 D7    sbc	$00d7
4695: 9D 7F 0C sta	$0c7f, x
4698: BD 6B 0C lda	$0c6b, x
469B: E5 D8    sbc	$00d8
469D: 9D 89 0C sta	$0c89, x
46A0: A5 D9    lda	$00d9
46A2: 29 30    and #$30
46A4: C9 10    cmp #$10
46A6: D0 09    bne	$46b1
46A8: 5E 89 0C lsr	$0c89, x
46AB: 7E 7F 0C ror	$0c7f, x
46AE: 7E 75 0C ror	$0c75, x
46B1: BD 93 0C lda	$0c93, x
46B4: 10 0D    bpl	$46c3
46B6: BD AB 0D lda	$0dab, x
46B9: D0 48    bne	$4703
46BB: 9D B5 0D sta	$0db5, x
46BE: 9D BF 0D sta	$0dbf, x
46C1: F0 40    beq	$4703
46C3: A9 00    lda #$00
46C5: 9D B5 0D sta	$0db5, x
46C8: 9D BF 0D sta	$0dbf, x
46CB: A5 D9    lda	$00d9
46CD: 29 38    and #$38
46CF: 0A       asl a
46D0: 9D BB 0C sta	$0cbb, x
46D3: 4C 03 47 jmp	$4703
46D6: 9D BB 0C sta	$0cbb, x
46D9: 9D B5 0D sta	$0db5, x
46DC: 9D BF 0D sta	$0dbf, x
46DF: 68       pla
46E0: 29 7F    and #$7f
46E2: 4A       lsr a
46E3: 66 D9    ror	$00d9
46E5: 4A       lsr a
46E6: 66 D9    ror	$00d9
46E8: 4A       lsr a
46E9: 66 D9    ror	$00d9
46EB: 48       pha
46EC: 18       clc
46ED: A5 D9    lda	$00d9
46EF: 7D 61 0C adc	$0c61, x
46F2: 9D 61 0C sta	$0c61, x
46F5: 68       pla
46F6: 7D 6B 0C adc	$0c6b, x
46F9: 9D 6B 0C sta	$0c6b, x
46FC: B1 CC    lda ($cc), y
46FE: 85 D9    sta	$00d9
4700: 9D 93 0C sta	$0c93, x
4703: BD E7 0D lda	$0de7, x
4706: 1D F1 0D ora	$0df1, x
4709: D0 0D    bne	$4718
470B: BC 25 0C ldy	$0c25, x
470E: C0 FE    cpy #$fe
4710: D0 09    bne	$471b
4712: FE 25 0C inc	$0c25, x
4715: 4C 0A 46 jmp	$460a
4718: 20 4F 49 jsr	$494f
471B: BD 93 0C lda	$0c93, x
471E: 48       pha
471F: A5 D9    lda	$00d9
4721: 9D 93 0C sta	$0c93, x
4724: 68       pla
4725: 30 51    bmi	$4778
4727: A9 00    lda #$00
4729: A8       tay
472A: 9D 47 0D sta	$0d47, x
472D: 9D 51 0D sta	$0d51, x
4730: 9D 5B 0D sta	$0d5b, x
4733: 9D 65 0D sta	$0d65, x
4736: BD F7 0C lda	$0cf7, x
4739: 85 CC    sta	$00cc
473B: BD 01 0D lda	$0d01, x
473E: 85 CD    sta	$00cd
4740: B1 CC    lda ($cc), y
4742: 9D 3D 0D sta	$0d3d, x
4745: C8       iny
4746: 11 CC    ora ($cc), y
4748: C8       iny
4749: 11 CC    ora ($cc), y
474B: F0 04    beq	$4751
474D: FE 3D 0D inc	$0d3d, x
4750: 98       tya
4751: 9D 33 0D sta	$0d33, x
4754: A9 00    lda #$00
4756: A8       tay
4757: 9D 1F 0D sta	$0d1f, x
475A: 9D 29 0D sta	$0d29, x
475D: BD E3 0C lda	$0ce3, x
4760: 85 CC    sta	$00cc
4762: BD ED 0C lda	$0ced, x
4765: 85 CD    sta	$00cd
4767: B1 CC    lda ($cc), y
4769: 9D 15 0D sta	$0d15, x
476C: C8       iny
476D: 11 CC    ora ($cc), y
476F: F0 04    beq	$4775
4771: FE 15 0D inc	$0d15, x
4774: 98       tya
4775: 9D 0B 0D sta	$0d0b, x
4778: AC 42 0E ldy	$0e42
477B: F0 0B    beq	$4788
477D: BD 43 0C lda	$0c43, x
4780: 1D 4D 0C ora	$0c4d, x
4783: D0 03    bne	$4788
4785: 4C 24 49 jmp	$4924
4788: A5 CA    lda	$00ca
478A: 29 06    and #$06
478C: D0 0A    bne	$4798
478E: BD BF 0D lda	$0dbf, x
4791: 0A       asl a
4792: 7E BF 0D ror	$0dbf, x
4795: 7E B5 0D ror	$0db5, x
4798: BD F7 0C lda	$0cf7, x
479B: 85 CC    sta	$00cc
479D: BD 01 0D lda	$0d01, x
47A0: 85 CD    sta	$00cd
47A2: BC 33 0D ldy	$0d33, x
47A5: D0 05    bne	$47ac
47A7: 98       tya
47A8: 18       clc
47A9: 4C 4B 48 jmp	$484b
47AC: DE 3D 0D dec	$0d3d, x
47AF: D0 56    bne	$4807
47B1: C8       iny
47B2: B1 CC    lda ($cc), y
47B4: 9D 3D 0D sta	$0d3d, x
47B7: C8       iny
47B8: C9 FF    cmp #$ff
47BA: D0 26    bne	$47e2
47BC: BD 65 0D lda	$0d65, x
47BF: F0 08    beq	$47c9
47C1: DE 65 0D dec	$0d65, x
47C4: D0 08    bne	$47ce
47C6: C8       iny
47C7: D0 E8    bne	$47b1
47C9: B1 CC    lda ($cc), y
47CB: 9D 65 0D sta	$0d65, x
47CE: C8       iny
47CF: 38       sec
47D0: A5 CC    lda	$00cc
47D2: F1 CC    sbc ($cc), y
47D4: 85 CC    sta	$00cc
47D6: 9D F7 0C sta	$0cf7, x
47D9: B0 D6    bcs	$47b1
47DB: C6 CD    dec	$00cd
47DD: DE 01 0D dec	$0d01, x
47E0: 90 CF    bcc	$47b1
47E2: 11 CC    ora ($cc), y
47E4: C8       iny
47E5: C0 F9    cpy #$f9
47E7: 11 CC    ora ($cc), y
47E9: D0 07    bne	$47f2
47EB: 9D 33 0D sta	$0d33, x
47EE: A8       tay
47EF: 18       clc
47F0: F0 59    beq	$484b
47F2: 98       tya
47F3: 90 0F    bcc	$4804
47F5: E9 02    sbc #$02
47F7: 7D F7 0C adc	$0cf7, x
47FA: 9D F7 0C sta	$0cf7, x
47FD: A9 01    lda #$01
47FF: 90 03    bcc	$4804
4801: FE 01 0D inc	$0d01, x
4804: 9D 33 0D sta	$0d33, x
4807: A9 00    lda #$00
4809: 85 DA    sta	$00da
480B: B1 CC    lda ($cc), y
480D: 10 02    bpl	$4811
480F: C6 DA    dec	$00da
4811: 85 D9    sta	$00d9
4813: 88       dey
4814: B1 CC    lda ($cc), y
4816: 0A       asl a
4817: 26 D9    rol	$00d9
4819: 26 DA    rol	$00da
481B: 0A       asl a
481C: 26 D9    rol	$00d9
481E: 26 DA    rol	$00da
4820: 0A       asl a
4821: 26 D9    rol	$00d9
4823: 26 DA    rol	$00da
4825: 18       clc
4826: 7D 47 0D adc	$0d47, x
4829: 9D 47 0D sta	$0d47, x
482C: A5 D9    lda	$00d9
482E: 7D 51 0D adc	$0d51, x
4831: 9D 51 0D sta	$0d51, x
4834: 85 D9    sta	$00d9
4836: A5 DA    lda	$00da
4838: 7D 5B 0D adc	$0d5b, x
483B: 9D 5B 0D sta	$0d5b, x
483E: A8       tay
483F: AD 42 0E lda	$0e42
4842: C9 02    cmp #$02
4844: D0 02    bne	$4848
4846: C6 D9    dec	$00d9
4848: A5 D9    lda	$00d9
484A: 18       clc
484B: 7D 43 0C adc	$0c43, x
484E: 85 D9    sta	$00d9
4850: 98       tya
4851: 7D 4D 0C adc	$0c4d, x
4854: A8       tay
4855: 18       clc
4856: A5 D9    lda	$00d9
4858: 7D B5 0D adc	$0db5, x
485B: 85 D9    sta	$00d9
485D: 98       tya
485E: 7D BF 0D adc	$0dbf, x
4861: 8D 4A 0E sta	$0e4a
4864: AD 42 0E lda	$0e42
4867: 29 01    and #$01
4869: A8       tay
486A: A5 D9    lda	$00d9
486C: 99 48 0E sta	$0e48, y
486F: BD E3 0C lda	$0ce3, x
4872: 85 CC    sta	$00cc
4874: BD ED 0C lda	$0ced, x
4877: 85 CD    sta	$00cd
4879: BC 0B 0D ldy	$0d0b, x
487C: D0 06    bne	$4884
487E: BD D9 0C lda	$0cd9, x
4881: 4C 1E 49 jmp	$491e
4884: DE 15 0D dec	$0d15, x
4887: D0 52    bne	$48db
4889: C8       iny
488A: B1 CC    lda ($cc), y
488C: 9D 15 0D sta	$0d15, x
488F: C8       iny
4890: C9 FF    cmp #$ff
4892: D0 26    bne	$48ba
4894: BD 29 0D lda	$0d29, x
4897: F0 08    beq	$48a1
4899: DE 29 0D dec	$0d29, x
489C: D0 08    bne	$48a6
489E: C8       iny
489F: D0 E8    bne	$4889
48A1: B1 CC    lda ($cc), y
48A3: 9D 29 0D sta	$0d29, x
48A6: C8       iny
48A7: 38       sec
48A8: A5 CC    lda	$00cc
48AA: F1 CC    sbc ($cc), y
48AC: 85 CC    sta	$00cc
48AE: 9D E3 0C sta	$0ce3, x
48B1: B0 D6    bcs	$4889
48B3: C6 CD    dec	$00cd
48B5: DE ED 0C dec	$0ced, x
48B8: 90 CF    bcc	$4889
48BA: C0 F9    cpy #$f9
48BC: 11 CC    ora ($cc), y
48BE: D0 06    bne	$48c6
48C0: 9D 0B 0D sta	$0d0b, x
48C3: 4C 7E 48 jmp	$487e
48C6: 98       tya
48C7: 90 0F    bcc	$48d8
48C9: E9 02    sbc #$02
48CB: 7D E3 0C adc	$0ce3, x
48CE: 9D E3 0C sta	$0ce3, x
48D1: A9 01    lda #$01
48D3: 90 03    bcc	$48d8
48D5: FE ED 0C inc	$0ced, x
48D8: 9D 0B 0D sta	$0d0b, x
48DB: B1 CC    lda ($cc), y
48DD: 18       clc
48DE: 7D 1F 0D adc	$0d1f, x
48E1: 50 06    bvc	$48e9
48E3: A9 80    lda #$80
48E5: B0 02    bcs	$48e9
48E7: A9 7F    lda #$7f
48E9: 9D 1F 0D sta	$0d1f, x
48EC: BC BB 0C ldy	$0cbb, x
48EF: 18       clc
48F0: 79 D2 51 adc	$51d2, y
48F3: 50 06    bvc	$48fb
48F5: A9 80    lda #$80
48F7: B0 02    bcs	$48fb
48F9: A9 7F    lda #$7f
48FB: 48       pha
48FC: 98       tya
48FD: 29 0F    and #$0f
48FF: C9 0F    cmp #$0f
4901: F0 03    beq	$4906
4903: FE BB 0C inc	$0cbb, x
4906: 68       pla
4907: 4A       lsr a
4908: 4A       lsr a
4909: 4A       lsr a
490A: C9 10    cmp #$10
490C: 90 02    bcc	$4910
490E: 09 F0    ora #$f0
4910: 18       clc
4911: 7D D9 0C adc	$0cd9, x
4914: 10 02    bpl	$4918
4916: A9 00    lda #$00
4918: C9 10    cmp #$10
491A: 90 02    bcc	$491e
491C: A9 0F    lda #$0f
491E: 1D A1 0D ora	$0da1, x
4921: 4C 26 49 jmp	$4926
4924: A9 00    lda #$00
4926: 48       pha
4927: AD 42 0E lda	$0e42
492A: 29 01    and #$01
492C: A8       tay
492D: 68       pla
492E: 99 46 0E sta	$0e46, y
4931: E0 0A    cpx #$0a
4933: B0 0C    bcs	$4941
4935: BD CF 0C lda	$0ccf, x
4938: 99 4D 0E sta	$0e4d, y
493B: BD C5 0C lda	$0cc5, x
493E: 99 51 0E sta	$0e51, y
4941: BD 2D 0E lda	$0e2d, x
4944: F0 08    beq	$494e
4946: 8E 4B 0E stx	$0e4b
4949: AA       tax
494A: CA       dex
494B: 4C D6 44 jmp	$44d6
494E: 60       rts
494F: BD FB 0D lda	$0dfb, x
4952: 85 D6    sta	$00d6
4954: BD 05 0E lda	$0e05, x
4957: 85 D7    sta	$00d7
4959: A5 D9    lda	$00d9
495B: 48       pha
495C: 29 0F    and #$0f
495E: A8       tay
495F: B9 C2 51 lda	$51c2, y
4962: 85 D9    sta	$00d9
4964: C9 FF    cmp #$ff
4966: D0 12    bne	$497a
4968: BD F1 0D lda	$0df1, x
496B: D0 05    bne	$4972
496D: 9D E7 0D sta	$0de7, x
4970: F0 03    beq	$4975
4972: DE F1 0D dec	$0df1, x
4975: A5 D7    lda	$00d7
4977: 4C DA 49 jmp	$49da
497A: BD E7 0D lda	$0de7, x
497D: 38       sec
497E: E5 D9    sbc	$00d9
4980: 9D E7 0D sta	$0de7, x
4983: B0 0D    bcs	$4992
4985: DE F1 0D dec	$0df1, x
4988: 10 08    bpl	$4992
498A: A9 00    lda #$00
498C: 9D E7 0D sta	$0de7, x
498F: 9D F1 0D sta	$0df1, x
4992: A0 07    ldy #$07
4994: A5 D7    lda	$00d7
4996: C9 80    cmp #$80
4998: 6A       ror a
4999: 66 D6    ror	$00d6
499B: 88       dey
499C: 30 04    bmi	$49a2
499E: 06 D9    asl	$00d9
49A0: 90 F4    bcc	$4996
49A2: A0 00    ldy #$00
49A4: 84 D9    sty	$00d9
49A6: 85 D7    sta	$00d7
49A8: C9 80    cmp #$80
49AA: 90 13    bcc	$49bf
49AC: 85 D9    sta	$00d9
49AE: 49 FF    eor #$ff
49B0: 85 D7    sta	$00d7
49B2: A5 D6    lda	$00d6
49B4: 49 FF    eor #$ff
49B6: 18       clc
49B7: 69 01    adc #$01
49B9: 85 D6    sta	$00d6
49BB: 90 02    bcc	$49bf
49BD: E6 D7    inc	$00d7
49BF: BD 0F 0E lda	$0e0f, x
49C2: 18       clc
49C3: 65 D6    adc	$00d6
49C5: 9D 0F 0E sta	$0e0f, x
49C8: 90 02    bcc	$49cc
49CA: E6 D7    inc	$00d7
49CC: A5 D7    lda	$00d7
49CE: A8       tay
49CF: F0 0E    beq	$49df
49D1: A4 D9    ldy	$00d9
49D3: 10 05    bpl	$49da
49D5: 49 FF    eor #$ff
49D7: 18       clc
49D8: 69 01    adc #$01
49DA: 20 CA 4C jsr	$4cca
49DD: A0 FF    ldy #$ff
49DF: 68       pla
49E0: 85 D9    sta	$00d9
49E2: 60       rts
49E3: 98       tya
49E4: 48       pha
49E5: C8       iny
49E6: A9 00    lda #$00
49E8: 8D 43 0E sta	$0e43
49EB: 8D 44 0E sta	$0e44
49EE: 8D 40 0E sta	$0e40
49F1: 8D 41 0E sta	$0e41
49F4: 8D 47 0E sta	$0e47
49F7: 8D 46 0E sta	$0e46
49FA: 8D 4D 0E sta	$0e4d
49FD: 8D 4E 0E sta	$0e4e
4A00: 8D 4F 0E sta	$0e4f
4A03: A9 FF    lda #$ff
4A05: 8D 51 0E sta	$0e51
4A08: 8D 52 0E sta	$0e52
4A0B: 8D 53 0E sta	$0e53
4A0E: BE 2D 0E ldx	$0e2d, y
4A11: F0 49    beq	$4a5c
4A13: CA       dex
4A14: 8C 4B 0E sty	$0e4b
4A17: A9 00    lda #$00
4A19: 20 D6 44 jsr	$44d6
4A1C: AD 40 0E lda	$0e40
4A1F: 8D 43 0E sta	$0e43
4A22: C5 DB    cmp	$00db
4A24: A9 00    lda #$00
4A26: 90 0F    bcc	$4a37
4A28: AD 4D 0E lda	$0e4d
4A2B: 8D 4F 0E sta	$0e4f
4A2E: AD 51 0E lda	$0e51
4A31: 8D 53 0E sta	$0e53
4A34: AD 46 0E lda	$0e46
4A37: 8D 44 0E sta	$0e44
4A3A: AD 48 0E lda	$0e48
4A3D: 8D 45 0E sta	$0e45
4A40: A9 00    lda #$00
4A42: 8D 40 0E sta	$0e40
4A45: 8D 41 0E sta	$0e41
4A48: 8D 47 0E sta	$0e47
4A4B: 8D 46 0E sta	$0e46
4A4E: 8D 4D 0E sta	$0e4d
4A51: 8D 4E 0E sta	$0e4e
4A54: A9 FF    lda #$ff
4A56: 8D 51 0E sta	$0e51
4A59: 8D 52 0E sta	$0e52
4A5C: 68       pla
4A5D: A8       tay
4A5E: BE 2D 0E ldx	$0e2d, y
4A61: F0 09    beq	$4a6c
4A63: CA       dex
4A64: 8C 4B 0E sty	$0e4b
4A67: A9 00    lda #$00
4A69: 20 D6 44 jsr	$44d6
4A6C: AD 40 0E lda	$0e40
4A6F: CD 41 0E cmp	$0e41
4A72: B0 03    bcs	$4a77
4A74: AD 41 0E lda	$0e41
4A77: C5 DB    cmp	$00db
4A79: B0 16    bcs	$4a91
4A7B: A9 00    lda #$00
4A7D: 8D 46 0E sta	$0e46
4A80: 8D 47 0E sta	$0e47
4A83: 8D 4D 0E sta	$0e4d
4A86: 8D 4E 0E sta	$0e4e
4A89: A9 FF    lda #$ff
4A8B: 8D 51 0E sta	$0e51
4A8E: 8D 52 0E sta	$0e52
4A91: AD 40 0E lda	$0e40
4A94: CD 43 0E cmp	$0e43
4A97: 90 03    bcc	$4a9c
4A99: 8D 43 0E sta	$0e43
4A9C: AD 41 0E lda	$0e41
4A9F: CD 43 0E cmp	$0e43
4AA2: 90 15    bcc	$4ab9
4AA4: A9 00    lda #$00
4AA6: 8D 46 0E sta	$0e46
4AA9: AD 52 0E lda	$0e52
4AAC: 2D 54 0E and	$0e54
4AAF: 8D 54 0E sta	$0e54
4AB2: AD 4E 0E lda	$0e4e
4AB5: 0D 50 0E ora	$0e50
4AB8: 60       rts
4AB9: AD 45 0E lda	$0e45
4ABC: 8D 4A 0E sta	$0e4a
4ABF: AD 48 0E lda	$0e48
4AC2: 8D 49 0E sta	$0e49
4AC5: AD 44 0E lda	$0e44
4AC8: 8D 47 0E sta	$0e47
4ACB: AD 51 0E lda	$0e51
4ACE: 2D 53 0E and	$0e53
4AD1: 2D 54 0E and	$0e54
4AD4: 8D 54 0E sta	$0e54
4AD7: AD 4D 0E lda	$0e4d
4ADA: 0D 4F 0E ora	$0e4f
4ADD: 0D 50 0E ora	$0e50
4AE0: 60       rts
4AE1: A9 00    lda #$00
4AE3: 8D 50 0E sta	$0e50
4AE6: A9 FF    lda #$ff
4AE8: 8D 54 0E sta	$0e54
4AEB: 8A       txa
4AEC: 48       pha
4AED: BD 0E 50 lda	$500e, x
4AF0: 48       pha
4AF1: A8       tay
4AF2: C8       iny
4AF3: C8       iny
4AF4: 20 E3 49 jsr	$49e3
4AF7: 90 02    bcc	$4afb
4AF9: 09 28    ora #$28
4AFB: 8D 50 0E sta	$0e50
4AFE: A0 04    ldy #$04
4B00: AD 49 0E lda	$0e49
4B03: 91 CE    sta ($ce), y
4B05: C8       iny
4B06: C8       iny
4B07: AD 4A 0E lda	$0e4a
4B0A: 91 CE    sta ($ce), y
4B0C: 88       dey
4B0D: AD 46 0E lda	$0e46
4B10: 91 CE    sta ($ce), y
4B12: C8       iny
4B13: C8       iny
4B14: AD 47 0E lda	$0e47
4B17: 91 CE    sta ($ce), y
4B19: 68       pla
4B1A: A8       tay
4B1B: 20 E3 49 jsr	$49e3
4B1E: 90 02    bcc	$4b22
4B20: 09 50    ora #$50
4B22: 8D 50 0E sta	$0e50
4B25: 68       pla
4B26: AA       tax
4B27: AD 50 0E lda	$0e50
4B2A: 2D 54 0E and	$0e54
4B2D: A0 08    ldy #$08
4B2F: 91 CE    sta ($ce), y
4B31: A0 00    ldy #$00
4B33: AD 49 0E lda	$0e49
4B36: 91 CE    sta ($ce), y
4B38: C8       iny
4B39: C8       iny
4B3A: AD 4A 0E lda	$0e4a
4B3D: 91 CE    sta ($ce), y
4B3F: 88       dey
4B40: AD 46 0E lda	$0e46
4B43: 91 CE    sta ($ce), y
4B45: C8       iny
4B46: C8       iny
4B47: AD 47 0E lda	$0e47
4B4A: 91 CE    sta ($ce), y
4B4C: 60       rts
4B4D: BD 08 50 lda	$5008, x
4B50: 85 CE    sta	$00ce
4B52: BD 0A 50 lda	$500a, x
4B55: 85 CF    sta	$00cf
4B57: BD 0C 50 lda	$500c, x
4B5A: 8D 4C 0E sta	$0e4c
4B5D: 4C E1 4A jmp	$4ae1
4B60: C9 BB    cmp #$bb
4B62: 90 07    bcc	$4b6b
4B64: A9 FF    lda #$ff
4B66: 9D 25 0C sta	$0c25, x
4B69: 18       clc
4B6A: 60       rts
4B6B: C8       iny
4B6C: 86 D9    stx	$00d9
4B6E: 0A       asl a
4B6F: AA       tax
4B70: BD B3 4B lda	$4bb3, x
4B73: 48       pha
4B74: BD B2 4B lda	$4bb2, x
4B77: 48       pha
4B78: A6 D9    ldx	$00d9
4B7A: B1 CC    lda ($cc), y
4B7C: 38       sec
4B7D: 60       rts
4B7E: BD 2F 0C lda	$0c2f, x
4B81: 18       clc
4B82: 69 01    adc #$01
4B84: 9D 2F 0C sta	$0c2f, x
4B87: 90 03    bcc	$4b8c
4B89: FE 39 0C inc	$0c39, x
4B8C: C8       iny
4B8D: B1 CC    lda ($cc), y
4B8F: 60       rts
4B90: 08       php
4B91: 78       sei
4B92: BD 2D 0E lda	$0e2d, x
4B95: F0 0D    beq	$4ba4
4B97: AA       tax
4B98: CA       dex
4B99: BD 25 0C lda	$0c25, x
4B9C: CD 55 0E cmp	$0e55
4B9F: D0 F1    bne	$4b92
4BA1: 20 A6 4B jsr	$4ba6
4BA4: 28       plp
4BA5: 60       rts
4BA6: B9 B3 4B lda	$4bb3, y
4BA9: 48       pha
4BAA: B9 B2 4B lda	$4bb2, y
4BAD: 48       pha
4BAE: AD 56 0E lda	$0e56
4BB1: 60       rts

* seems unreached, but who knows?
4C28: A9 00    lda #$00
4C2A: 9D 57 0C sta	$0c57, x
4C2D: 9D 61 0C sta	$0c61, x
4C30: 9D 6B 0C sta	$0c6b, x
4C33: BC 8D 0D ldy	$0d8d, x
4C36: F0 08    beq	$4c40
4C38: C8       iny
4C39: D0 38    bne	$4c73
4C3B: 9D 8D 0D sta	$0d8d, x
4C3E: 38       sec
4C3F: 60       rts
4C40: BD 97 0D lda	$0d97, x
4C43: 9D 8D 0D sta	$0d8d, x
4C46: A0 09    ldy #$09
4C48: D9 97 0D cmp	$0d97, y
4C4B: D0 0D    bne	$4c5a
4C4D: D9 8D 0D cmp	$0d8d, y
4C50: F0 08    beq	$4c5a
4C52: B9 B1 0C lda	$0cb1, y
4C55: D0 1C    bne	$4c73
4C57: BD 97 0D lda	$0d97, x
4C5A: 88       dey
4C5B: 10 EB    bpl	$4c48
4C5D: A0 09    ldy #$09
4C5F: D9 97 0D cmp	$0d97, y
4C62: D0 08    bne	$4c6c
4C64: A9 FF    lda #$ff
4C66: 99 8D 0D sta	$0d8d, y
4C69: BD 97 0D lda	$0d97, x
4C6C: 88       dey
4C6D: 10 F0    bpl	$4c5f
4C6F: A9 00    lda #$00
4C71: F0 C8    beq	$4c3b
4C73: BD 2F 0C lda	$0c2f, x
4C76: C9 02    cmp #$02
4C78: B0 03    bcs	$4c7d
4C7A: DE 39 0C dec	$0c39, x
4C7D: DE 2F 0C dec	$0c2f, x
4C80: DE 2F 0C dec	$0c2f, x
4C83: 18       clc
4C84: 60       rts
4C85: 9D 97 0D sta	$0d97, x
4C88: A9 00    lda #$00
4C8A: 9D 8D 0D sta	$0d8d, x
4C8D: 60       rts
4C8E: 9D E3 0C sta	$0ce3, x
4C91: 20 7E 4B jsr	$4b7e
4C94: 9D ED 0C sta	$0ced, x
4C97: 38       sec
4C98: 60       rts
4C99: 9D F7 0C sta	$0cf7, x
4C9C: 20 7E 4B jsr	$4b7e
4C9F: 9D 01 0D sta	$0d01, x
4CA2: 38       sec
4CA3: 60       rts
4CA4: 18       clc
4CA5: 7D 6F 0D adc	$0d6f, x
4CA8: 9D 6F 0D sta	$0d6f, x
4CAB: 08       php
4CAC: 20 7E 4B jsr	$4b7e
4CAF: 28       plp
4CB0: 7D 79 0D adc	$0d79, x
4CB3: 9D 79 0D sta	$0d79, x
4CB6: 38       sec
4CB7: 60       rts
4CB8: 9D 6F 0D sta	$0d6f, x
4CBB: 20 7E 4B jsr	$4b7e
4CBE: 9D 79 0D sta	$0d79, x
4CC1: 38       sec
4CC2: 60       rts
4CC3: BC 25 0C ldy	$0c25, x
4CC6: C0 FE    cpy #$fe
4CC8: F0 1C    beq	$4ce6
4CCA: 18       clc
4CCB: 7D D9 0C adc	$0cd9, x
4CCE: 10 02    bpl	$4cd2
4CD0: A9 00    lda #$00
4CD2: C9 10    cmp #$10
4CD4: 90 0B    bcc	$4ce1
4CD6: A9 0F    lda #$0f
4CD8: D0 07    bne	$4ce1
4CDA: BC 25 0C ldy	$0c25, x
4CDD: C0 FE    cpy #$fe
4CDF: F0 05    beq	$4ce6
4CE1: 9D D9 0C sta	$0cd9, x
4CE4: 38       sec
4CE5: 60       rts
4CE6: 18       clc
4CE7: 60       rts
4CE8: 18       clc
4CE9: 7D 83 0D adc	$0d83, x
4CEC: 9D 83 0D sta	$0d83, x
4CEF: 38       sec
4CF0: 60       rts
4CF1: 9D A1 0D sta	$0da1, x
4CF4: 60       rts
4CF5: AC 4C 0E ldy	$0e4c
4CF8: F0 08    beq	$4d02
4CFA: 4D 4D 0E eor	$0e4d
4CFD: 29 09    and #$09
4CFF: 4D 4D 0E eor	$0e4d
4D02: 1D CF 0C ora	$0ccf, x
4D05: 9D CF 0C sta	$0ccf, x
4D08: 60       rts
4D09: 49 FF    eor #$ff
4D0B: AC 4C 0E ldy	$0e4c
4D0E: D0 07    bne	$4d17
4D10: 3D C5 0C and	$0cc5, x
4D13: 9D C5 0C sta	$0cc5, x
4D16: 60       rts
4D17: 09 F6    ora #$f6
4D19: 3D CF 0C and	$0ccf, x
4D1C: 9D CF 0C sta	$0ccf, x
4D1F: 60       rts
4D20: 9D AB 0D sta	$0dab, x
4D23: 60       rts
4D24: 85 D9    sta	$00d9
4D26: 20 7E 4B jsr	$4b7e
4D29: 85 DA    sta	$00da
4D2B: 20 D9 40 jsr	$40d9
4D2E: F0 20    beq	$4d50
4D30: 48       pha
4D31: BD C9 0D lda	$0dc9, x
4D34: 91 DD    sta ($dd), y
4D36: 68       pla
4D37: 9D C9 0D sta	$0dc9, x
4D3A: C8       iny
4D3B: BD 2F 0C lda	$0c2f, x
4D3E: 91 DD    sta ($dd), y
4D40: C8       iny
4D41: BD 39 0C lda	$0c39, x
4D44: 91 DD    sta ($dd), y
4D46: A5 D9    lda	$00d9
4D48: 9D 2F 0C sta	$0c2f, x
4D4B: A5 DA    lda	$00da
4D4D: 9D 39 0C sta	$0c39, x
4D50: 38       sec
4D51: 60       rts
4D52: 48       pha
4D53: 20 D9 40 jsr	$40d9
4D56: F0 22    beq	$4d7a
4D58: 48       pha
4D59: BD D3 0D lda	$0dd3, x
4D5C: 91 DD    sta ($dd), y
4D5E: 68       pla
4D5F: 9D D3 0D sta	$0dd3, x
4D62: C8       iny
4D63: BD 2F 0C lda	$0c2f, x
4D66: 91 DD    sta ($dd), y
4D68: C8       iny
4D69: BD 39 0C lda	$0c39, x
4D6C: 91 DD    sta ($dd), y
4D6E: C8       iny
4D6F: BD DD 0D lda	$0ddd, x
4D72: 91 DD    sta ($dd), y
4D74: 68       pla
4D75: 9D DD 0D sta	$0ddd, x
4D78: 38       sec
4D79: 60       rts
4D7A: 68       pla
4D7B: 38       sec
4D7C: 60       rts
4D7D: BD D3 0D lda	$0dd3, x
4D80: F0 14    beq	$4d96
4D82: 20 EA 40 jsr	$40ea
4D85: DE DD 0D dec	$0ddd, x
4D88: F0 0E    beq	$4d98
4D8A: C8       iny
4D8B: B1 DD    lda ($dd), y
4D8D: 9D 2F 0C sta	$0c2f, x
4D90: C8       iny
4D91: B1 DD    lda ($dd), y
4D93: 9D 39 0C sta	$0c39, x
4D96: 38       sec
4D97: 60       rts
4D98: 48       pha
4D99: B1 DD    lda ($dd), y
4D9B: 9D D3 0D sta	$0dd3, x
4D9E: A5 DC    lda	$00dc
4DA0: 91 DD    sta ($dd), y
4DA2: 68       pla
4DA3: 85 DC    sta	$00dc
4DA5: C8       iny
4DA6: C8       iny
4DA7: C8       iny
4DA8: B1 DD    lda ($dd), y
4DAA: 9D DD 0D sta	$0ddd, x
4DAD: 38       sec
4DAE: 60       rts
4DAF: 85 D9    sta	$00d9
4DB1: 20 7E 4B jsr	$4b7e
4DB4: BC 25 0C ldy	$0c25, x
4DB7: C0 FE    cpy #$fe
4DB9: F0 1F    beq	$4dda
4DBB: 9D 05 0E sta	$0e05, x
4DBE: A5 D9    lda	$00d9
4DC0: 4A       lsr a
4DC1: 4A       lsr a
4DC2: 4A       lsr a
4DC3: 9D F1 0D sta	$0df1, x
4DC6: A9 00    lda #$00
4DC8: 9D E7 0D sta	$0de7, x
4DCB: 9D 0F 0E sta	$0e0f, x
4DCE: A5 D9    lda	$00d9
4DD0: 0A       asl a
4DD1: 0A       asl a
4DD2: 0A       asl a
4DD3: 0A       asl a
4DD4: 0A       asl a
4DD5: 9D FB 0D sta	$0dfb, x
4DD8: 38       sec
4DD9: 60       rts
4DDA: 18       clc
4DDB: 60       rts
4DDC: 18       clc
4DDD: 7D 19 0E adc	$0e19, x
4DE0: 9D 19 0E sta	$0e19, x
4DE3: 9D 23 0E sta	$0e23, x
4DE6: 38       sec
4DE7: 60       rts
4DE8: 85 D9    sta	$00d9
4DEA: BD 19 0E lda	$0e19, x
4DED: E5 D9    sbc	$00d9
4DEF: 4C E0 4D jmp	$4de0
4DF2: 3D 19 0E and	$0e19, x
4DF5: 4C E0 4D jmp	$4de0
4DF8: 1D 19 0E ora	$0e19, x
4DFB: 4C E0 4D jmp	$4de0
4DFE: 5D 19 0E eor	$0e19, x
4E01: 4C E0 4D jmp	$4de0
4E04: 18       clc
4E05: A8       tay
4E06: BD 19 0E lda	$0e19, x
4E09: C0 04    cpy #$04
4E0B: F0 1D    beq	$4e2a
4E0D: C0 02    cpy #$02
4E0F: F0 1B    beq	$4e2c
4E11: C0 06    cpy #$06
4E13: F0 13    beq	$4e28
4E15: C0 07    cpy #$07
4E17: F0 0E    beq	$4e27
4E19: C0 05    cpy #$05
4E1B: F0 0C    beq	$4e29
4E1D: C0 03    cpy #$03
4E1F: F0 0A    beq	$4e2b
4E21: C0 01    cpy #$01
4E23: F0 08    beq	$4e2d
4E25: 38       sec
4E26: 60       rts
4E27: 4A       lsr a
4E28: 4A       lsr a
4E29: 4A       lsr a
4E2A: 4A       lsr a
4E2B: 4A       lsr a
4E2C: 4A       lsr a
4E2D: 4A       lsr a
4E2E: 4C E0 4D jmp	$4de0
4E31: 18       clc
4E32: A8       tay
4E33: BD 19 0E lda	$0e19, x
4E36: C0 04    cpy #$04
4E38: F0 1D    beq	$4e57
4E3A: C0 02    cpy #$02
4E3C: F0 1B    beq	$4e59
4E3E: C0 06    cpy #$06
4E40: F0 13    beq	$4e55
4E42: C0 07    cpy #$07
4E44: F0 0E    beq	$4e54
4E46: C0 05    cpy #$05
4E48: F0 0C    beq	$4e56
4E4A: C0 03    cpy #$03
4E4C: F0 0A    beq	$4e58
4E4E: C0 01    cpy #$01
4E50: F0 08    beq	$4e5a
4E52: 38       sec
4E53: 60       rts
4E54: 0A       asl a
4E55: 0A       asl a
4E56: 0A       asl a
4E57: 0A       asl a
4E58: 0A       asl a
4E59: 0A       asl a
4E5A: 0A       asl a
4E5B: 4C E0 4D jmp	$4de0
4E5E: 85 D9    sta	$00d9
4E60: BD 19 0E lda	$0e19, x
4E63: D0 05    bne	$4e6a
4E65: A5 D9    lda	$00d9
4E67: 4C 78 4E jmp	$4e78
4E6A: 85 D8    sta	$00d8
4E6C: 20 7E 4B jsr	$4b7e
4E6F: 20 7E 4B jsr	$4b7e
4E72: 85 D9    sta	$00d9
4E74: C6 D8    dec	$00d8
4E76: D0 F4    bne	$4e6c
4E78: 20 7E 4B jsr	$4b7e
4E7B: 9D 39 0C sta	$0c39, x
4E7E: A5 D9    lda	$00d9
4E80: 9D 2F 0C sta	$0c2f, x
4E83: 38       sec
4E84: 60       rts
4E85: 85 D9    sta	$00d9
4E87: BD 19 0E lda	$0e19, x
4E8A: D0 05    bne	$4e91
4E8C: A5 D9    lda	$00d9
4E8E: 4C 9F 4E jmp	$4e9f
4E91: 85 D8    sta	$00d8
4E93: 20 7E 4B jsr	$4b7e
4E96: 20 7E 4B jsr	$4b7e
4E99: 85 D9    sta	$00d9
4E9B: C6 D8    dec	$00d8
4E9D: D0 F4    bne	$4e93
4E9F: 20 7E 4B jsr	$4b7e
4EA2: 9D 39 0C sta	$0c39, x
4EA5: A5 D9    lda	$00d9
4EA7: 9D 2F 0C sta	$0c2f, x
4EAA: FE 19 0E inc	$0e19, x
4EAD: BD 19 0E lda	$0e19, x
4EB0: 4C E0 4D jmp	$4de0
4EB3: C9 26    cmp #$26
4EB5: B0 2E    bcs	$4ee5
4EB7: C9 06    cmp #$06
4EB9: 90 0C    bcc	$4ec7
4EBB: E9 06    sbc #$06
4EBD: A8       tay
4EBE: BD 19 0E lda	$0e19, x
4EC1: 99 E0 00 sta	$00e0, y
4EC4: 4C E5 4E jmp	$4ee5
4EC7: C9 05    cmp #$05
4EC9: F0 1A    beq	$4ee5
4ECB: C9 03    cmp #$03
4ECD: B0 16    bcs	$4ee5
4ECF: A8       tay
4ED0: BD 19 0E lda	$0e19, x
4ED3: C0 02    cpy #$02
4ED5: 90 03    bcc	$4eda
4ED7: 4C EC 4C jmp	$4cec
4EDA: C0 01    cpy #$01
4EDC: 90 03    bcc	$4ee1
4EDE: 4C BE 4C jmp	$4cbe
4EE1: 38       sec
4EE2: 4C DA 4C jmp	$4cda
4EE5: 38       sec
4EE6: 60       rts
4EE7: C9 03    cmp #$03
4EE9: B0 17    bcs	$4f02
4EEB: A8       tay
4EEC: BD 19 0E lda	$0e19, x
4EEF: C0 02    cpy #$02
4EF1: 90 03    bcc	$4ef6
4EF3: 4C E8 4C jmp	$4ce8
4EF6: C0 01    cpy #$01
4EF8: 90 04    bcc	$4efe
4EFA: 18       clc
4EFB: 4C B0 4C jmp	$4cb0
4EFE: 38       sec
4EFF: 4C C3 4C jmp	$4cc3
4F02: 38       sec
4F03: 60       rts
4F04: 20 4D 4F jsr	$4f4d
4F07: 4C E0 4D jmp	$4de0
4F0A: 20 4D 4F jsr	$4f4d
4F0D: 85 D9    sta	$00d9
4F0F: BD 19 0E lda	$0e19, x
4F12: E5 D9    sbc	$00d9
4F14: 9D 23 0E sta	$0e23, x
4F17: 38       sec
4F18: 60       rts
4F19: 20 4D 4F jsr	$4f4d
4F1C: F0 1D    beq	$4f3b
4F1E: D0 13    bne	$4f33
4F20: 20 4D 4F jsr	$4f4d
4F23: D0 16    bne	$4f3b
4F25: F0 0C    beq	$4f33
4F27: 20 4D 4F jsr	$4f4d
4F2A: 10 0F    bpl	$4f3b
4F2C: 30 05    bmi	$4f33
4F2E: 20 4D 4F jsr	$4f4d
4F31: 30 08    bmi	$4f3b
4F33: 20 7E 4B jsr	$4b7e
4F36: 20 7E 4B jsr	$4b7e
4F39: 38       sec
4F3A: 60       rts
4F3B: 20 7E 4B jsr	$4b7e
4F3E: 85 D9    sta	$00d9
4F40: 20 7E 4B jsr	$4b7e
4F43: 9D 39 0C sta	$0c39, x
4F46: A5 D9    lda	$00d9
4F48: 9D 2F 0C sta	$0c2f, x
4F4B: 38       sec
4F4C: 60       rts
4F4D: 84 D9    sty	$00d9
4F4F: C9 26    cmp #$26
4F51: B0 3B    bcs	$4f8e
4F53: C9 06    cmp #$06
4F55: B0 22    bcs	$4f79
4F57: C9 05    cmp #$05
4F59: F0 29    beq	$4f84
4F5B: C9 03    cmp #$03
4F5D: B0 2F    bcs	$4f8e
4F5F: C9 02    cmp #$02
4F61: 90 06    bcc	$4f69
4F63: A4 D9    ldy	$00d9
4F65: BD 83 0D lda	$0d83, x
4F68: 60       rts
4F69: C9 01    cmp #$01
4F6B: 90 06    bcc	$4f73
4F6D: A4 D9    ldy	$00d9
4F6F: BD 79 0D lda	$0d79, x
4F72: 60       rts
4F73: A4 D9    ldy	$00d9
4F75: BD D9 0C lda	$0cd9, x
4F78: 60       rts
4F79: E9 06    sbc #$06
4F7B: A8       tay
4F7C: B9 E0 00 lda	$00e0, y
4F7F: 48       pha
4F80: A4 D9    ldy	$00d9
4F82: 68       pla
4F83: 60       rts
4F84: A0 0A    ldy #$0a
4F86: B9 00 28 lda	$2800, y
4F89: 48       pha
4F8A: A4 D9    ldy	$00d9
4F8C: 68       pla
4F8D: 60       rts
4F8E: A4 D9    ldy	$00d9
4F90: BD 23 0E lda	$0e23, x
4F93: 60       rts
4F94: AD 42 0E lda	$0e42
4F97: 29 01    and #$01
4F99: A8       tay
4F9A: A9 00    lda #$00
4F9C: 99 40 0E sta	$0e40, y
4F9F: BD B1 0C lda	$0cb1, x
4FA2: 29 FC    and #$fc
4FA4: 09 02    ora #$02
4FA6: 9D B1 0C sta	$0cb1, x
4FA9: 8D 40 0E sta	$0e40
4FAC: A0 02    ldy #$02
4FAE: 8C 42 0E sty	$0e42
4FB1: 60       rts
4FB2: AD 42 0E lda	$0e42
4FB5: 29 01    and #$01
4FB7: A8       tay
4FB8: A9 00    lda #$00
4FBA: 99 40 0E sta	$0e40, y
4FBD: BD B1 0C lda	$0cb1, x
4FC0: 29 FC    and #$fc
4FC2: 9D B1 0C sta	$0cb1, x
4FC5: A0 00    ldy #$00
4FC7: 8C 42 0E sty	$0e42
4FCA: 8D 40 0E sta	$0e40
4FCD: 60       rts
4FCE: A0 01    ldy #$01
4FD0: 8C 42 0E sty	$0e42
4FD3: 1D B1 0C ora	$0cb1, x
4FD6: 9D B1 0C sta	$0cb1, x
4FD9: 99 40 0E sta	$0e40, y
4FDC: 60       rts
4FDD: A9 00    lda #$00
4FDF: 9D E7 0D sta	$0de7, x
4FE2: 9D 0F 0E sta	$0e0f, x
4FE5: 9D FB 0D sta	$0dfb, x
4FE8: A9 D0    lda #$d0
4FEA: 9D 05 0E sta	$0e05, x
4FED: A9 02    lda #$02
4FEF: 9D F1 0D sta	$0df1, x
4FF2: A9 FE    lda #$fe
4FF4: 9D 25 0C sta	$0c25, x
4FF7: 38       sec
4FF8: 60       rts
4FF9: 85 D9    sta	$00d9
4FFB: 20 7E 4B jsr	$4b7e
4FFE: 9D 39 0C sta	$0c39, x
5001: A5 D9    lda	$00d9
5003: 9D 2F 0C sta	$0c2f, x
5006: 38       sec
5007: 60       rts


startup_8000:
8000: 78       sei				; block interrupts
8001: 4C 08 80 jmp	$8008

8008: D8       cld              ; clear decimal flag                                   
8009: A2 FF    ldx #$ff
800B: 9A       txs		        ; set stack to	$01ff
; write into pokey 
800C: A9 00    lda #$00
800E: 8D 0F 28 sta	$280f
8011: 8D 1F 28 sta	$281f
; small cpu dependent loop
8014: 18       clc              ; clear carry
8015: 69 01    adc #$01
8017: C9 07    cmp #$07
8019: D0 F9    bne	$8014
; write into pokey (reinit?)
801B: 8D 0F 28 sta	$280f
801E: 8D 1F 28 sta	$281f
8021: A9 00    lda #$00
8023: A0 07    ldy #$07
8025: 99 00 28 sta	$2800, y
8028: 99 10 28 sta	$2810, y
802B: 88       dey
802C: 10 F7    bpl	$8025
802E: A9 00    lda #$00
8030: A2 00    ldx #$00
; clear RAM 0-2FFF
8032: 95 00    sta	$0000, x
8034: 9D 00 01 sta	$0100, x
8037: 9D 00 02 sta	$0200, x
803A: 9D 00 03 sta	$0300, x
803D: 9D 00 04 sta	$0400, x
8040: 9D 00 05 sta	$0500, x
8043: 9D 00 06 sta	$0600, x
8046: 9D 00 07 sta	$0700, x
8049: 9D 00 08 sta	$0800, x
804C: 9D 00 09 sta	$0900, x
804F: 9D 00 0A sta	$0a00, x
8052: 9D 00 0B sta	$0b00, x
8055: 9D 00 0C sta	$0c00, x
8058: 9D 00 0D sta	$0d00, x
805B: 9D 00 0E sta	$0e00, x
805E: 9D 00 0F sta	$0f00, x
8061: 9D 00 10 sta	$1000, x
8064: 9D 00 11 sta	$1100, x
8067: 9D 00 12 sta	$1200, x
806A: 9D 00 13 sta	$1300, x
806D: 9D 00 14 sta	$1400, x
8070: 9D 00 15 sta	$1500, x
8073: 9D 00 16 sta	$1600, x
8076: 9D 00 17 sta	$1700, x
8079: 9D 00 18 sta	$1800, x
807C: 9D 00 19 sta	$1900, x
807F: 9D 00 1A sta	$1a00, x
8082: 9D 00 1B sta	$1b00, x
8085: 9D 00 1C sta	$1c00, x
8088: 9D 00 1D sta	$1d00, x
808B: 9D 00 1E sta	$1e00, x
808E: 9D 00 1F sta	$1f00, x
8091: 9D 00 20 sta	$2000, x
8094: 8D 00 30 sta watchdog_3000		; kick watchdog
8097: E8       inx
8098: D0 98    bne	$8032
; pokey again
809A: 8D 0B 28 sta	$280b
809D: 2C 08 28 bit	$2808
80A0: 30 06    bmi	$80a8
80A2: 20 49 E6 jsr	$e649
80A5: 4C 61 E6 jmp continue_startup_e661
; not reached?
80A8: A2 00    ldx #$00
80AA: B5 00    lda	$0000, x
80AC: F0 03    beq	$80b1
80AE: 20 E4 8B jsr	$8be4
80B1: A0 00    ldy #$00
80B3: 38       sec
80B4: 98       tya
80B5: 2A       rol a
80B6: A8       tay
80B7: 95 00    sta	$0000, x
80B9: 55 00    eor	$0000, x
80BB: F0 03    beq	$80c0
80BD: 4C EC 8B jmp	$8bec
80C0: 90 F2    bcc	$80b4
80C2: A0 FF    ldy #$ff
80C4: 18       clc
80C5: 98       tya
80C6: 2A       rol a
80C7: A8       tay
80C8: 95 00    sta	$0000, x
80CA: 55 00    eor	$0000, x
80CC: F0 03    beq	$80d1
80CE: 4C F4 8B jmp	$8bf4
80D1: B0 F2    bcs	$80c5
80D3: 8D 00 30 sta watchdog_3000
80D6: E8       inx
80D7: D0 D1    bne	$80aa
80D9: F6 00    inc	$0000, x
80DB: F0 05    beq	$80e2
80DD: B5 00    lda	$0000, x
80DF: 4C FC 8B jmp	$8bfc
80E2: E8       inx
80E3: D0 F4    bne	$80d9
80E5: 8D 00 30 sta watchdog_3000
80E8: A2 FF    ldx #$ff
80EA: 9A       txs
80EB: A9 00    lda #$00
80ED: 85 AF    sta	$00af
80EF: 85 AD    sta	$00ad
80F1: 85 AE    sta	$00ae
80F3: E6 AE    inc	$00ae
80F5: A0 00    ldy #$00
80F7: B1 AD    lda ($ad), y
80F9: F0 03    beq	$80fe
80FB: 20 CE 8B jsr	$8bce
80FE: A2 00    ldx #$00
8100: 38       sec
8101: 8A       txa
8102: 2A       rol a
8103: AA       tax
8104: 91 AD    sta ($ad), y
8106: 51 AD    eor ($ad), y
8108: F0 04    beq	$810e
810A: 20 CE 8B jsr	$8bce
810D: 38       sec
810E: 90 F1    bcc	$8101
8110: A2 FF    ldx #$ff
8112: 18       clc
8113: 8A       txa
8114: 2A       rol a
8115: AA       tax
8116: 91 AD    sta ($ad), y
8118: 51 AD    eor ($ad), y
811A: F0 04    beq	$8120
811C: 20 CE 8B jsr	$8bce
811F: 18       clc
8120: B0 F1    bcs	$8113
8122: 8D 00 30 sta watchdog_3000
8125: C8       iny
8126: D0 CF    bne	$80f7
8128: B1 AD    lda ($ad), y
812A: 18       clc
812B: 69 01    adc #$01
812D: 91 AD    sta ($ad), y
812F: F0 03    beq	$8134
8131: 20 CE 8B jsr	$8bce
8134: C8       iny
8135: D0 F1    bne	$8128
8137: 8D 00 30 sta watchdog_3000
813A: A5 AE    lda	$00ae
813C: C9 20    cmp #$20
813E: 90 B3    bcc	$80f3
8140: 20 90 92 jsr	$9290
8143: A9 00    lda #$00
8145: 85 B0    sta	$00b0
8147: 85 5E    sta	$005e
8149: A5 AF    lda	$00af
814B: 29 03    and #$03
814D: F0 2D    beq	$817c
814F: 29 02    and #$02
8151: F0 09    beq	$815c
8153: A9 2F    lda #$2f
8155: 85 5E    sta	$005e
8157: A9 03    lda #$03
8159: B8       clv
815A: 50 02    bvc	$815e
815C: A9 02    lda #$02
815E: A0 00    ldy #$00
8160: 20 BC 8C jsr	$8cbc
8163: A5 AF    lda	$00af
8165: 29 01    and #$01
8167: F0 09    beq	$8172
8169: A9 0F    lda #$0f
816B: 85 5E    sta	$005e
816D: A9 01    lda #$01
816F: B8       clv
8170: 50 02    bvc	$8174
8172: A9 00    lda #$00
8174: A0 00    ldy #$00
8176: 20 BC 8C jsr	$8cbc
8179: B8       clv
817A: 50 02    bvc	$817e
817C: E6 B0    inc	$00b0
817E: A9 17    lda #$17
8180: A0 00    ldy #$00
8182: 20 BC 8C jsr	$8cbc
8185: A9 24    lda #$24
8187: A0 00    ldy #$00
8189: 20 BC 8C jsr	$8cbc
818C: A2 0F    ldx #$0f
818E: A9 FF    lda #$ff
8190: 9D 00 20 sta	$2000, x
8193: CA       dex
8194: 10 FA    bpl	$8190
8196: A9 00    lda #$00
8198: 8D 00 20 sta	$2000
819B: E6 B0    inc	$00b0
819D: 4C 2E 82 jmp	$822e

81A0: A5 5E    lda	$005e
81A2: F0 21    beq	$81c5
81A4: 29 10    and #$10
81A6: D0 05    bne	$81ad
81A8: A9 A8    lda #$a8
81AA: B8       clv
81AB: 50 02    bvc	$81af
81AD: A9 00    lda #$00
81AF: C6 5E    dec	$005e
81B1: D0 02    bne	$81b5
81B3: A9 00    lda #$00
81B5: 8D 00 28 sta	$2800
81B8: 8D 01 28 sta	$2801
81BB: A5 5E    lda	$005e
81BD: C9 1F    cmp #$1f
81BF: D0 04    bne	$81c5
81C1: A9 13    lda #$13
81C3: 85 5E    sta	$005e
81C5: A5 B5    lda	$00b5
81C7: 29 08    and #$08
81C9: F0 0A    beq	$81d5
81CB: A9 00    lda #$00
81CD: 8D 00 28 sta	$2800
81D0: 8D 01 28 sta	$2801
81D3: C6 B0    dec	$00b0
81D5: 4C 2E 82 jmp	$822e
81D8: A9 00    lda #$00
81DA: 8D 00 28 sta	$2800
81DD: 8D 01 28 sta	$2801
81E0: A9 25    lda #$25
81E2: A0 00    ldy #$00
81E4: 20 BC 8C jsr	$8cbc
81E7: 20 B8 D5 jsr switch_to_bank_0_D5B8
81EA: A9 00    lda #$00
81EC: A2 40    ldx #$40
81EE: A0 40    ldy #$40
81F0: 20 A0 8C jsr	$8ca0
81F3: 18       clc
81F4: 6D 00 60 adc	$6000
81F7: 48       pha
81F8: 20 C2 D5 jsr switch_to_bank_0_d5c2
81FB: 68       pla
81FC: A2 40    ldx #$40
81FE: A0 C0    ldy #$c0
8200: 20 A0 8C jsr	$8ca0
8203: 18       clc
8204: 6D 00 60 adc	$6000
8207: C9 FF    cmp #$ff
8209: F0 18    beq	$8223
820B: A0 24    ldy #$24
820D: 84 02    sty	$0002
820F: A0 12    ldy #$12
8211: 84 03    sty	$0003
8213: 20 64 92 jsr	$9264
8216: A5 AF    lda	$00af
8218: 09 04    ora #$04
821A: 85 AF    sta	$00af
821C: A9 04    lda #$04
821E: A0 00    ldy #$00
8220: 20 BC 8C jsr	$8cbc
8223: 20 C2 D5 jsr switch_to_bank_0_d5c2
8226: A5 AF    lda	$00af
8228: 29 0C    and #$0c
822A: D0 02    bne	$822e
822C: E6 B0    inc	$00b0
822E: A5 B2    lda	$00b2
8230: 85 B6    sta	$00b6
8232: 8D 0B 28 sta	$280b
8235: AE 08 28 ldx	$2808
8238: 86 B2    stx	$00b2
823A: 49 FF    eor #$ff
823C: 25 B2    and	$00b2
823E: 85 B4    sta	$00b4
8240: A5 B3    lda	$00b3
8242: 85 B7    sta	$00b7
8244: 8D 1B 28 sta	$281b
8247: AE 18 28 ldx	$2818
824A: 86 B3    stx	$00b3
824C: 49 FF    eor #$ff
824E: 25 B3    and	$00b3
8250: 85 B5    sta	$00b5
8252: A2 07    ldx #$07
8254: A5 B3    lda	$00b3
8256: 3D F2 82 and	$82f2, x
8259: D0 06    bne	$8261
825B: A9 00    lda #$00
825D: 95 B8    sta	$00b8, x
825F: F0 1B    beq	$827c
8261: F6 B8    inc	$00b8, x
8263: B5 B8    lda	$00b8, x
8265: DD FA 82 cmp	$82fa, x
8268: 90 07    bcc	$8271
826A: A5 B5    lda	$00b5
826C: 1D F2 82 ora	$82f2, x
826F: 85 B5    sta	$00b5
8271: A5 B5    lda	$00b5
8273: 3D F2 82 and	$82f2, x
8276: F0 04    beq	$827c
8278: A9 00    lda #$00
827A: 95 B8    sta	$00b8, x
827C: CA       dex
827D: 10 D5    bpl	$8254
827F: 8D 0B 28 sta	$280b
8282: 2C 08 28 bit	$2808
8285: 50 F8    bvc	$827f
8287: A5 AC    lda	$00ac
8289: D0 08    bne	$8293
828B: 8D 0B 28 sta	$280b
828E: 2C 08 28 bit	$2808
8291: 70 F4    bvs	$8287
8293: A9 00    lda #$00
8295: 85 AC    sta	$00ac
8297: A5 B2    lda	$00b2
8299: 30 04    bmi	$829f
829B: 78       sei
829C: 4C 9C 82 jmp	$829c

829F: 8D 00 30 sta watchdog_3000
82A2: A5 B5    lda	$00b5
82A4: 29 01    and #$01
82A6: F0 0D    beq	$82b5
82A8: A5 B0    lda	$00b0
82AA: 18       clc
82AB: 69 01    adc #$01
82AD: C9 17    cmp #$17
82AF: 90 02    bcc	$82b3
82B1: A9 03    lda #$03
82B3: 85 B0    sta	$00b0
82B5: A5 B0    lda	$00b0
82B7: 0A       asl a
82B8: A8       tay
; jump from table
82B9: B9 C3 82 lda	$82c3, y
82BC: 48       pha
82BD: B9 C2 82 lda	$82c2, y
82C0: 48       pha
82C1: 60       rts

jump_table_82c2:
	.word	$8008
	.word	$81a0
	.word	$81d8
	.word	$8302
	.word	$8322
	.word	$835d
	.word	$838b
	.word	$83b2
	.word	$8427
	.word	$843e
	.word	$8461
	.word	$84bf
	.word	$84dd
	.word	$8510
	.word	$8556
	.word	$8568
	.word	$8594
	.word	$85a8
	.word	$8637
	.word	$8657
	.word	$86ea
	.word	$8657

8302: 78       sei                                                 
8303: 20 90 92 jsr $9290                                           
8306: 20 49 E6 jsr	$e649
8309: A9 00    lda #$00
830B: 85 5E    sta	$005e
830D: 85 5F    sta	$005f
830F: 20 18 86 jsr	$8618
8312: A9 16    lda #$16
8314: A0 00    ldy #$00
8316: 20 BC 8C jsr	$8cbc
8319: A9 17    lda #$17
831B: A0 00    ldy #$00
831D: 20 BC 8C jsr	$8cbc
8320: E6 B0    inc	$00b0
8322: A5 B2    lda	$00b2
8324: A2 06    ldx #$06
8326: 0A       asl a
8327: B0 05    bcs	$832e
8329: A0 00    ldy #$00
832B: B8       clv
832C: 50 02    bvc	$8330
832E: A0 10    ldy #$10
8330: 48       pha
8331: 8A       txa
8332: 48       pha
8333: 20 BC 8C jsr	$8cbc
8336: 68       pla
8337: AA       tax
8338: 68       pla
8339: E8       inx
833A: E0 0E    cpx #$0e
833C: 90 E8    bcc	$8326
833E: A5 B3    lda	$00b3
8340: A2 0E    ldx #$0e
8342: 0A       asl a
8343: B0 05    bcs	$834a
8345: A0 00    ldy #$00
8347: B8       clv
8348: 50 02    bvc	$834c
834A: A0 10    ldy #$10
834C: 48       pha
834D: 8A       txa
834E: 48       pha
834F: 20 BC 8C jsr	$8cbc
8352: 68       pla
8353: AA       tax
8354: 68       pla
8355: E8       inx
8356: E0 16    cpx #$16
8358: 90 E8    bcc	$8342
835A: 4C 2E 82 jmp	$822e
835D: A9 00    lda #$00
835F: 85 5E    sta	$005e
8361: 85 5F    sta	$005f
8363: 20 18 86 jsr	$8618
8366: 20 CE EE jsr	$eece
8369: A9 17    lda #$17
836B: A0 00    ldy #$00
836D: 20 BC 8C jsr	$8cbc
8370: A9 27    lda #$27
8372: A0 00    ldy #$00
8374: 20 BC 8C jsr	$8cbc
8377: A9 28    lda #$28
8379: A0 00    ldy #$00
837B: 20 BC 8C jsr	$8cbc
837E: 20 8F C6 jsr	$c68f
8381: A9 03    lda #$03
8383: 8D B1 20 sta	$20b1
8386: E6 B0    inc	$00b0
8388: 4C 2E 82 jmp	$822e
838B: A5 B3    lda	$00b3
838D: 29 84    and #$84
838F: C9 84    cmp #$84
8391: D0 1C    bne	$83af
8393: A5 B5    lda	$00b5
8395: 29 10    and #$10
8397: F0 16    beq	$83af
8399: A9 29    lda #$29
839B: A0 00    ldy #$00
839D: 20 BC 8C jsr	$8cbc
83A0: A9 02    lda #$02
83A2: 20 D4 F1 jsr	$f1d4
83A5: A9 2A    lda #$2a
83A7: A0 00    ldy #$00
83A9: 20 BC 8C jsr	$8cbc
83AC: 20 8F C6 jsr	$c68f
83AF: 4C 2E 82 jmp	$822e
83B2: A9 00    lda #$00
83B4: 85 B1    sta	$00b1
83B6: 85 5E    sta	$005e
83B8: 85 5F    sta	$005f
83BA: 20 18 86 jsr	$8618
83BD: A9 00    lda #$00
83BF: 8D 10 20 sta	$2010
83C2: A9 10    lda #$10
83C4: 8D 11 20 sta	$2011
83C7: A9 C0    lda #$c0
83C9: 8D 20 20 sta	$2020
83CC: A9 DB    lda #$db
83CE: 8D 21 20 sta	$2021
83D1: A9 C0    lda #$c0
83D3: 8D 30 20 sta	$2030
83D6: A9 18    lda #$18
83D8: 8D 31 20 sta	$2031
83DB: A9 36    lda #$36
83DD: A0 B0    ldy #$b0
83DF: 20 BC 8C jsr	$8cbc
83E2: A9 3A    lda #$3a
83E4: A0 00    ldy #$00
83E6: 20 BC 8C jsr	$8cbc
83E9: A9 3B    lda #$3b
83EB: A0 00    ldy #$00
83ED: 20 BC 8C jsr	$8cbc
83F0: A9 40    lda #$40
83F2: A0 00    ldy #$00
83F4: 20 BC 8C jsr	$8cbc
83F7: A9 41    lda #$41
83F9: A0 00    ldy #$00
83FB: 20 BC 8C jsr	$8cbc
83FE: AD BC 08 lda	$08bc
8401: 8D C1 05 sta	$05c1
8404: 8D E5 06 sta	$06e5
8407: AD 25 EB lda	$eb25
840A: 8D E7 06 sta	$06e7
840D: A9 00    lda #$00
840F: 8D E4 06 sta	$06e4
8412: 8D E6 06 sta	$06e6
8415: A9 9A    lda #$9a
8417: 8D E8 06 sta	$06e8
841A: A9 97    lda #$97
841C: 8D E9 06 sta	$06e9
841F: 20 FD 94 jsr	$94fd
8422: E6 B0    inc	$00b0
8424: 4C 2E 82 jmp	$822e
8427: AD BC 08 lda	$08bc
842A: 8D E5 06 sta	$06e5
842D: A9 00    lda #$00
842F: 8D E4 06 sta	$06e4
8432: 20 2B 95 jsr	$952b
8435: AD E5 06 lda	$06e5
8438: 8D BC 08 sta	$08bc
843B: 4C 2E 82 jmp	$822e

843E: AD BC 08 lda	$08bc
8441: CD C1 05 cmp	$05c1
8444: F0 16    beq	$845c
8446: A9 01    lda #$01
8448: 20 7C EE jsr	$ee7c
844B: 58       cli
844C: 8D 00 30 sta watchdog_3000
844F: A5 6C    lda	$006c
8451: C5 6D    cmp	$006d
8453: D0 04    bne	$8459
8455: A5 6E    lda	$006e
8457: C9 FF    cmp #$ff
8459: D0 F1    bne	$844c
845B: 78       sei
845C: E6 B0    inc	$00b0
845E: 4C 2E 82 jmp	$822e
8461: A9 00    lda #$00
8463: 85 B1    sta	$00b1
8465: 85 5E    sta	$005e
8467: 85 5F    sta	$005f
8469: 20 18 86 jsr	$8618
846C: A9 37    lda #$37
846E: A0 B0    ldy #$b0
8470: 20 BC 8C jsr	$8cbc
8473: A9 3A    lda #$3a
8475: A0 00    ldy #$00
8477: 20 BC 8C jsr	$8cbc
847A: A9 3B    lda #$3b
847C: A0 00    ldy #$00
847E: 20 BC 8C jsr	$8cbc
8481: A9 40    lda #$40
8483: A0 00    ldy #$00
8485: 20 BC 8C jsr	$8cbc
8488: A9 41    lda #$41
848A: A0 00    ldy #$00
848C: 20 BC 8C jsr	$8cbc
848F: AD BA 08 lda	$08ba
8492: 8D C0 05 sta	$05c0
8495: 8D E4 06 sta	$06e4
8498: AD BB 08 lda	$08bb
849B: 8D C1 05 sta	$05c1
849E: 8D E5 06 sta	$06e5
84A1: AD 26 EB lda	$eb26
84A4: 8D E6 06 sta	$06e6
84A7: AD 27 EB lda	$eb27
84AA: 8D E7 06 sta	$06e7
84AD: A9 5A    lda #$5a
84AF: 8D E8 06 sta	$06e8
84B2: A9 99    lda #$99
84B4: 8D E9 06 sta	$06e9
84B7: 20 FD 94 jsr	$94fd
84BA: E6 B0    inc	$00b0
84BC: 4C 2E 82 jmp	$822e
84BF: AD BA 08 lda	$08ba
84C2: 8D E4 06 sta	$06e4
84C5: AD BB 08 lda	$08bb
84C8: 8D E5 06 sta	$06e5
84CB: 20 2B 95 jsr	$952b
84CE: AD E5 06 lda	$06e5
84D1: 8D BB 08 sta	$08bb
84D4: AD E4 06 lda	$06e4
84D7: 8D BA 08 sta	$08ba
84DA: 4C 2E 82 jmp	$822e

84DD: AD BA 08 lda	$08ba
84E0: CD C0 05 cmp	$05c0
84E3: D0 08    bne	$84ed
84E5: AD BB 08 lda	$08bb
84E8: CD C1 05 cmp	$05c1
84EB: F0 16    beq	$8503
84ED: A9 01    lda #$01
84EF: 20 7C EE jsr	$ee7c
84F2: 58       cli
84F3: 8D 00 30 sta watchdog_3000
84F6: A5 6C    lda	$006c
84F8: C5 6D    cmp	$006d
84FA: D0 04    bne	$8500
84FC: A5 6E    lda	$006e
84FE: C9 FF    cmp #$ff
8500: D0 F1    bne	$84f3
8502: 78       sei
8503: E6 B0    inc	$00b0
8505: 4C 2E 82 jmp	$822e

8510: A9 00    lda #$00                                            
8512: 85 B1    sta	$00b1
8514: 85 5E    sta	$005e
8516: 85 5F    sta	$005f
8518: 20 18 86 jsr	$8618
851B: A9 38    lda #$38
851D: A0 B0    ldy #$b0
851F: 20 BC 8C jsr	$8cbc
8522: A9 42    lda #$42
8524: A0 00    ldy #$00
8526: 20 BC 8C jsr	$8cbc
8529: A9 43    lda #$43
852B: A0 00    ldy #$00
852D: 20 BC 8C jsr	$8cbc
8530: A9 00    lda #$00
8532: 8D C1 05 sta	$05c1
8535: 8D FA 08 sta	$08fa
8538: 8D E4 06 sta	$06e4
853B: 8D E5 06 sta	$06e5
853E: 8D E6 06 sta	$06e6
8541: 8D E7 06 sta	$06e7
8544: A9 BA    lda #$ba
8546: 8D E8 06 sta	$06e8
8549: A9 99    lda #$99
854B: 8D E9 06 sta	$06e9
854E: 20 FD 94 jsr	$94fd
8551: E6 B0    inc	$00b0
8553: 4C 2E 82 jmp	$822e
8556: AD FA 08 lda	$08fa
8559: 8D E5 06 sta	$06e5
855C: 20 2B 95 jsr	$952b
855F: AD E5 06 lda	$06e5
8562: 8D FA 08 sta	$08fa
8565: 4C 2E 82 jmp	$822e
8568: AD FA 08 lda	$08fa
856B: 29 07    and #$07
856D: F0 20    beq	$858f
856F: A9 39    lda #$39
8571: A0 B0    ldy #$b0
8573: 20 BC 8C jsr	$8cbc
8576: AD FA 08 lda	$08fa
8579: 29 07    and #$07
857B: 20 D4 F1 jsr	$f1d4
857E: 58       cli
857F: 8D 00 30 sta watchdog_3000
8582: A5 6C    lda	$006c
8584: C5 6D    cmp	$006d
8586: D0 04    bne	$858c
8588: A5 6E    lda	$006e
858A: C9 FF    cmp #$ff
858C: D0 F1    bne	$857f
858E: 78       sei
858F: E6 B0    inc	$00b0
8591: 4C 2E 82 jmp	$822e
8594: A9 FF    lda #$ff
8596: 8D 89 06 sta	$0689
8599: 20 9C 93 jsr	$939c
859C: A5 B5    lda	$00b5
859E: 09 04    ora #$04
85A0: 85 B5    sta	$00b5
85A2: A9 FF    lda #$ff
85A4: 85 9B    sta	$009b
85A6: E6 B0    inc	$00b0
85A8: A5 B5    lda	$00b5
85AA: 29 08    and #$08
85AC: F0 08    beq	$85b6
85AE: C6 9B    dec	$009b
85B0: 10 04    bpl	$85b6
85B2: A9 08    lda #$08
85B4: 85 9B    sta	$009b
85B6: A5 B5    lda	$00b5
85B8: 29 04    and #$04
85BA: F0 0C    beq	$85c8
85BC: E6 9B    inc	$009b
85BE: A5 9B    lda	$009b
85C0: C9 09    cmp #$09
85C2: 90 04    bcc	$85c8
85C4: A9 00    lda #$00
85C6: 85 9B    sta	$009b
85C8: A5 B5    lda	$00b5
85CA: 29 10    and #$10
85CC: F0 03    beq	$85d1
85CE: 20 9C 93 jsr	$939c
85D1: A5 B5    lda	$00b5
85D3: 29 0C    and #$0c
85D5: F0 35    beq	$860c
85D7: A4 9B    ldy	$009b
85D9: B9 0F 86 lda	$860f, y
85DC: 85 5E    sta	$005e
85DE: A9 00    lda #$00
85E0: 85 5F    sta	$005f
85E2: 20 18 86 jsr	$8618
85E5: A9 17    lda #$17
85E7: A0 00    ldy #$00
85E9: 20 BC 8C jsr	$8cbc
85EC: A9 18    lda #$18
85EE: A0 00    ldy #$00
85F0: 20 BC 8C jsr	$8cbc
85F3: A9 19    lda #$19
85F5: A0 00    ldy #$00
85F7: 20 BC 8C jsr	$8cbc
85FA: A9 1A    lda #$1a
85FC: A0 00    ldy #$00
85FE: 20 BC 8C jsr	$8cbc
8601: AD 89 06 lda	$0689
8604: 18       clc
8605: 69 1C    adc #$1c
8607: A0 60    ldy #$60
8609: 20 BC 8C jsr	$8cbc
860C: 4C 2E 82 jmp	$822e

8618: A9 00    lda #$00
861A: 85 AA    sta	$00aa
861C: A9 10    lda #$10
861E: 85 AB    sta	$00ab
8620: A0 00    ldy #$00
8622: A5 5E    lda	$005e
8624: 91 AA    sta ($aa), y
8626: C8       iny
8627: A5 5F    lda	$005f
8629: 91 AA    sta ($aa), y
862B: C8       iny
862C: D0 F4    bne	$8622
862E: E6 AB    inc	$00ab
8630: A5 AB    lda	$00ab
8632: C9 20    cmp #$20
8634: 90 EA    bcc	$8620
8636: 60       rts
8637: 20 90 92 jsr	$9290
863A: A9 00    lda #$00
863C: 85 5E    sta	$005e
863E: 85 5F    sta	$005f
8640: 20 18 86 jsr	$8618
8643: A9 5A    lda #$5a
8645: 85 AD    sta	$00ad
8647: A9 86    lda #$86
8649: 85 AE    sta	$00ae
864B: 20 0A 87 jsr	$870a
864E: A9 1B    lda #$1b
8650: A0 00    ldy #$00
8652: 20 BC 8C jsr	$8cbc
8655: E6 B0    inc	$00b0

8657: 4C 2E 82 jmp	$822e


86EA: A2 00    ldx #$00
86EC: 8A       txa
86ED: 9D 00 20 sta	$2000, x
86F0: E8       inx
86F1: D0 F9    bne	$86ec
86F3: A9 97    lda #$97
86F5: 85 AD    sta	$00ad
86F7: A9 87    lda #$87
86F9: 85 AE    sta	$00ae
86FB: 20 0A 87 jsr	$870a
86FE: A9 22    lda #$22
8700: A0 00    ldy #$00
8702: 20 BC 8C jsr	$8cbc
8705: E6 B0    inc	$00b0
8707: 4C 2E 82 jmp	$822e
870A: A9 00    lda #$00
870C: 85 5E    sta	$005e
870E: 85 5F    sta	$005f
8710: 20 18 86 jsr	$8618
8713: A9 88    lda #$88
8715: 85 AA    sta	$00aa
8717: A9 11    lda #$11
8719: 85 AB    sta	$00ab
871B: A2 00    ldx #$00
871D: A9 01    lda #$01
871F: 8D 8B 06 sta	$068b
8722: A0 00    ldy #$00
8724: CE 8B 06 dec	$068b
8727: D0 26    bne	$874f
8729: A1 AD    lda ($ad, x)
872B: 85 5E    sta	$005e
872D: 20 8B 87 jsr	$878b
8730: A1 AD    lda ($ad, x)
8732: 8D 8A 06 sta	$068a
8735: 20 8B 87 jsr	$878b
8738: A1 AD    lda ($ad, x)
873A: 8D 8B 06 sta	$068b
873D: 20 8B 87 jsr	$878b
8740: A5 5E    lda	$005e
8742: 29 F0    and #$f0
8744: 85 5F    sta	$005f
8746: A5 5E    lda	$005e
8748: 29 0F    and #$0f
874A: 85 5E    sta	$005e
874C: B8       clv
874D: 50 15    bvc	$8764
874F: A5 5E    lda	$005e
8751: 18       clc
8752: 6D 8A 06 adc	$068a
8755: 85 5E    sta	$005e
8757: 29 F0    and #$f0
8759: 18       clc
875A: 65 5F    adc	$005f
875C: 85 5F    sta	$005f
875E: A5 5E    lda	$005e
8760: 29 0F    and #$0f
8762: 85 5E    sta	$005e
8764: A5 5E    lda	$005e
8766: 91 AA    sta ($aa), y
8768: C8       iny
8769: A5 5F    lda	$005f
876B: 91 AA    sta ($aa), y
876D: C8       iny
876E: C0 40    cpy #$40
8770: 90 B2    bcc	$8724
8772: A5 AA    lda	$00aa
8774: 18       clc
8775: 69 80    adc #$80
8777: 85 AA    sta	$00aa
8779: A5 AB    lda	$00ab
877B: 69 00    adc #$00
877D: 85 AB    sta	$00ab
877F: C9 1E    cmp #$1e
8781: 90 9F    bcc	$8722
8783: A9 17    lda #$17
8785: A0 00    ldy #$00
8787: 20 BC 8C jsr	$8cbc
878A: 60       rts
878B: A5 AD    lda	$00ad
878D: 18       clc
878E: 69 01    adc #$01
8790: 85 AD    sta	$00ad
8792: 90 02    bcc	$8796
8794: E6 AE    inc	$00ae
8796: 60       rts


; < A: screen/context index?
; 8: title
; 0: demo/game
; 6: difficulty select
display_screen_and_other_stuff_8818:
8818: 8D A1 06 sta context_name_06a1
881B: A9 01    lda #$01
881D: 8D A2 06 sta	$06a2
8820: A9 00    lda #$00
8822: 8D A3 06 sta sync_variable_06a3
8825: AD A3 06 lda sync_variable_06a3
8828: F0 FB    beq	$8825
882A: AD A1 06 lda context_name_06a1
882D: 20 3B 88 jsr display_screen_883b
8830: A9 03    lda #$03
8832: 8D A2 06 sta	$06a2
8835: AD A3 06 lda sync_variable_06a3
8838: D0 FB    bne	$8835
883A: 60       rts

; < A: screen index?
display_screen_883b:
883B: 8D 51 06 sta	$0651
883E: A8       tay
883F: C9 08    cmp #$08
8841: D0 06    bne	$8849
8843: 20 C2 D5 jsr switch_to_bank_0_d5c2
8846: B8       clv
8847: 50 03    bvc	$884c
8849: 20 B8 D5 jsr switch_to_bank_0_D5B8
884C: B9 9C 88 lda	$889c, y
884F: 85 5C    sta	$005c
8851: B9 9D 88 lda	$889d, y
8854: 85 5D    sta	$005d
8856: A9 02    lda #$02
8858: 8D 82 06 sta	$0682
885B: A9 00    lda #$00
885D: 8D 83 06 sta	$0683
8860: 8D 84 06 sta	$0684
8863: 85 AA    sta	$00aa
8865: A9 10    lda #$10
8867: 85 AB    sta	$00ab
8869: A0 00    ldy #$00
886B: 20 AA 88 jsr	$88aa
886E: AD 85 06 lda	$0685
8871: 91 AA    sta ($aa), y
8873: C8       iny
8874: AD 86 06 lda	$0686
8877: 91 AA    sta ($aa), y
8879: C8       iny
887A: C0 54    cpy #$54
887C: 90 ED    bcc	$886b
887E: A5 AA    lda	$00aa
8880: 18       clc
8881: 69 80    adc #$80
8883: 85 AA    sta	$00aa
8885: A5 AB    lda	$00ab
8887: 69 00    adc #$00
8889: 85 AB    sta	$00ab
888B: C9 1F    cmp #$1f
888D: 90 DA    bcc	$8869
888F: AD 51 06 lda	$0651
8892: C9 05    cmp #$05
8894: B0 05    bcs	$889b
8896: A9 36    lda #$36
8898: 20 70 D6 jsr	$d670
889B: 60       rts

88AA: A2 00    ldx #$00
88AC: AD 82 06 lda	$0682
88AF: D0 0B    bne	$88bc
88B1: CE 84 06 dec	$0684
88B4: D0 05    bne	$88bb
88B6: A9 02    lda #$02
88B8: 8D 82 06 sta	$0682
88BB: 60       rts
88BC: C9 01    cmp #$01
88BE: D0 1A    bne	$88da
88C0: 18       clc
88C1: AD 85 06 lda	$0685
88C4: 69 01    adc #$01
88C6: 8D 85 06 sta	$0685
88C9: 90 03    bcc	$88ce
88CB: EE 86 06 inc	$0686
88CE: CE 83 06 dec	$0683
88D1: D0 05    bne	$88d8
88D3: A9 02    lda #$02
88D5: 8D 82 06 sta	$0682
88D8: D0 6B    bne	$8945
88DA: A1 5C    lda ($5c, x)
88DC: 8D 87 06 sta	$0687
88DF: 10 04    bpl	$88e5
88E1: A9 FF    lda #$ff
88E3: D0 02    bne	$88e7
88E5: A9 00    lda #$00
88E7: 8D 88 06 sta	$0688
88EA: 20 46 89 jsr	$8946
88ED: AD 87 06 lda	$0687
88F0: C9 80    cmp #$80
88F2: D0 13    bne	$8907
88F4: A1 5C    lda ($5c, x)
88F6: 8D 85 06 sta	$0685
88F9: 20 46 89 jsr	$8946
88FC: A1 5C    lda ($5c, x)
88FE: 8D 86 06 sta	$0686
8901: 20 46 89 jsr	$8946
8904: B8       clv
8905: 50 3E    bvc	$8945
8907: C9 81    cmp #$81
8909: D0 13    bne	$891e
890B: A9 01    lda #$01
890D: 8D 82 06 sta	$0682
8910: A1 5C    lda ($5c, x)
8912: 8D 83 06 sta	$0683
8915: 20 46 89 jsr	$8946
8918: 4C C0 88 jmp	$88c0
891B: B8       clv
891C: 50 27    bvc	$8945
891E: C9 7F    cmp #$7f
8920: D0 13    bne	$8935
8922: A9 00    lda #$00
8924: 8D 82 06 sta	$0682
8927: A1 5C    lda ($5c, x)
8929: 38       sec
892A: E9 01    sbc #$01
892C: 8D 84 06 sta	$0684
892F: 20 46 89 jsr	$8946
8932: B8       clv
8933: 50 10    bvc	$8945
8935: 18       clc
8936: 6D 85 06 adc	$0685
8939: 8D 85 06 sta	$0685
893C: AD 88 06 lda	$0688
893F: 6D 86 06 adc	$0686
8942: 8D 86 06 sta	$0686
8945: 60       rts

8946: A5 5C    lda	$005c
8948: 18       clc
8949: 69 01    adc #$01
894B: 85 5C    sta	$005c
894D: 90 02    bcc	$8951
894F: E6 5D    inc	$005d
8951: 60       rts
8952: A9 02    lda #$02
8954: 8D 82 06 sta	$0682
8957: A9 00    lda #$00
8959: 8D 83 06 sta	$0683
895C: 8D 84 06 sta	$0684
895F: 8D 8B 06 sta	$068b
8962: A9 20    lda #$20
8964: 85 AA    sta	$00aa
8966: A9 16    lda #$16
8968: 85 AB    sta	$00ab
896A: 98       tya
896B: 0A       asl a
896C: A8       tay
896D: 20 B8 D5 jsr switch_to_bank_0_D5B8
8970: B9 AB 89 lda	$89ab, y
8973: 85 5C    sta	$005c
8975: B9 AC 89 lda	$89ac, y
8978: 85 5D    sta	$005d
897A: A0 00    ldy #$00
897C: 20 AA 88 jsr	$88aa
897F: AD 85 06 lda	$0685
8982: 91 AA    sta ($aa), y
8984: C8       iny
8985: AD 86 06 lda	$0686
8988: 29 0F    and #$0f
898A: 09 80    ora #$80
898C: 91 AA    sta ($aa), y
898E: C8       iny
898F: C0 14    cpy #$14
8991: 90 E9    bcc	$897c
8993: A5 AA    lda	$00aa
8995: 18       clc
8996: 69 80    adc #$80
8998: 85 AA    sta	$00aa
899A: A5 AB    lda	$00ab
899C: 69 00    adc #$00
899E: 85 AB    sta	$00ab
89A0: EE 8B 06 inc	$068b
89A3: AD 8B 06 lda	$068b
89A6: C9 08    cmp #$08
89A8: 90 D0    bcc	$897a
89AA: 60       rts

89B7: A9 00    lda #$00                                            
89B9: 8D 8B 06 sta	$068b
89BC: AD A4 06 lda	$06a4
89BF: D0 0B    bne	$89cc
89C1: A9 22    lda #$22
89C3: 85 AA    sta	$00aa
89C5: A9 13    lda #$13
89C7: 85 AB    sta	$00ab
89C9: B8       clv
89CA: 50 08    bvc	$89d4
89CC: A9 2A    lda #$2a
89CE: 85 AA    sta	$00aa
89D0: A9 13    lda #$13
89D2: 85 AB    sta	$00ab
89D4: 20 B8 D5 jsr switch_to_bank_0_D5B8
89D7: 98       tya
89D8: 0A       asl a
89D9: A8       tay
89DA: B9 1D 8A lda	$8a1d, y
89DD: 85 5A    sta	$005a
89DF: B9 1E 8A lda	$8a1e, y
89E2: 85 5B    sta	$005b
89E4: A0 00    ldy #$00
89E6: B1 5A    lda ($5a), y
89E8: 91 AA    sta ($aa), y
89EA: C8       iny
89EB: B1 5A    lda ($5a), y
89ED: 29 0F    and #$0f
89EF: 09 50    ora #$50
89F1: 91 AA    sta ($aa), y
89F3: C8       iny
89F4: C0 08    cpy #$08
89F6: 90 EE    bcc	$89e6
89F8: A5 AA    lda	$00aa
89FA: 18       clc
89FB: 69 80    adc #$80
89FD: 85 AA    sta	$00aa
89FF: A5 AB    lda	$00ab
8A01: 69 00    adc #$00
8A03: 85 AB    sta	$00ab
8A05: A5 5A    lda	$005a
8A07: 18       clc
8A08: 69 08    adc #$08
8A0A: 85 5A    sta	$005a
8A0C: A5 5B    lda	$005b
8A0E: 69 00    adc #$00
8A10: 85 5B    sta	$005b
8A12: EE 8B 06 inc	$068b
8A15: AD 8B 06 lda	$068b
8A18: C9 06    cmp #$06
8A1A: 90 C8    bcc	$89e4
8A1C: 60       rts



8B0F: 20 49 E6 jsr	$e649
8B12: 58       cli
8B13: 20 90 92 jsr	$9290
8B16: A9 00    lda #$00
8B18: 85 5E    sta	$005e
8B1A: 85 5F    sta	$005f
8B1C: 20 18 86 jsr	$8618
8B1F: A9 2B    lda #$2b
8B21: A0 00    ldy #$00
8B23: 20 BC 8C jsr	$8cbc
8B26: A9 2C    lda #$2c
8B28: A0 00    ldy #$00
8B2A: 20 BC 8C jsr	$8cbc
8B2D: A9 32    lda #$32
8B2F: A0 00    ldy #$00
8B31: 20 BC 8C jsr	$8cbc
8B34: A9 33    lda #$33
8B36: A0 00    ldy #$00
8B38: 20 BC 8C jsr	$8cbc
8B3B: A9 34    lda #$34
8B3D: A0 00    ldy #$00
8B3F: 20 BC 8C jsr	$8cbc
8B42: A9 35    lda #$35
8B44: A0 00    ldy #$00
8B46: 20 BC 8C jsr	$8cbc
8B49: A9 17    lda #$17
8B4B: A0 00    ldy #$00
8B4D: 20 BC 8C jsr	$8cbc
8B50: A9 02    lda #$02
8B52: 85 9B    sta	$009b
8B54: A5 B5    lda	$00b5
8B56: 09 40    ora #$40
8B58: 85 B5    sta	$00b5
8B5A: E6 B0    inc	$00b0
8B5C: A9 00    lda #$00
8B5E: 85 05    sta	$0005
8B60: A9 13    lda #$13
8B62: 85 1C    sta	$001c
8B64: A9 24    lda #$24
8B66: 85 1B    sta	$001b
8B68: A5 B5    lda	$00b5
8B6A: 29 80    and #$80
8B6C: F0 17    beq	$8b85
8B6E: A5 9B    lda	$009b
8B70: 38       sec
8B71: E9 01    sbc #$01
8B73: D0 02    bne	$8b77
8B75: A9 1C    lda #$1c
8B77: 85 9B    sta	$009b
8B79: 85 1F    sta	$001f
8B7B: A0 01    ldy #$01
8B7D: 20 58 C8 jsr	$c858
8B80: A9 03    lda #$03
8B82: 20 A1 C8 jsr	$c8a1
8B85: A5 B5    lda	$00b5
8B87: 29 40    and #$40
8B89: F0 19    beq	$8ba4
8B8B: A5 9B    lda	$009b
8B8D: 18       clc
8B8E: 69 01    adc #$01
8B90: C9 1D    cmp #$1d
8B92: 90 02    bcc	$8b96
8B94: A9 01    lda #$01
8B96: 85 9B    sta	$009b
8B98: 85 1F    sta	$001f
8B9A: A0 01    ldy #$01
8B9C: 20 58 C8 jsr	$c858
8B9F: A9 03    lda #$03
8BA1: 20 A1 C8 jsr	$c8a1
8BA4: A5 B5    lda	$00b5
8BA6: 29 10    and #$10
8BA8: F0 05    beq	$8baf
8BAA: A5 9B    lda	$009b
8BAC: 20 59 E6 jsr	$e659
8BAF: A5 B5    lda	$00b5
8BB1: 29 22    and #$22
8BB3: F0 05    beq	$8bba
8BB5: A9 00    lda #$00
8BB7: 20 59 E6 jsr	$e659
8BBA: A5 9B    lda	$009b
8BBC: C9 05    cmp #$05
8BBE: B0 04    bcs	$8bc4
8BC0: 69 2C    adc #$2c
8BC2: D0 02    bne	$8bc6
8BC4: A9 31    lda #$31
8BC6: A0 00    ldy #$00
8BC8: 20 BC 8C jsr	$8cbc
8BCB: 4C 2E 82 jmp	$822e
8BCE: A5 AE    lda	$00ae
8BD0: C9 01    cmp #$01
8BD2: F0 7E    beq	$8c52
8BD4: C9 20    cmp #$20
8BD6: B0 05    bcs	$8bdd
8BD8: A9 01    lda #$01
8BDA: B8       clv
8BDB: 50 02    bvc	$8bdf
8BDD: A9 02    lda #$02
8BDF: 05 AF    ora	$00af
8BE1: 85 AF    sta	$00af
8BE3: 60       rts

8BE4: 8D 00 30 sta watchdog_3000
8BE7: A8       tay
8BE8: A9 5A    lda #$5a
8BEA: D0 16    bne	$8c02
8BEC: 8D 00 30 sta watchdog_3000
8BEF: A8       tay
8BF0: A9 31    lda #$31
8BF2: D0 0E    bne	$8c02
8BF4: 8D 00 30 sta watchdog_3000
8BF7: A8       tay
8BF8: A9 30    lda #$30
8BFA: D0 06    bne	$8c02
8BFC: 8D 00 30 sta watchdog_3000
8BFF: A8       tay
8C00: A9 49    lda #$49
8C02: 8D AC 11 sta	$11ac
8C05: 8A       txa
8C06: 4A       lsr a
8C07: 4A       lsr a
8C08: 4A       lsr a
8C09: 4A       lsr a
8C0A: 09 30    ora #$30
8C0C: C9 3A    cmp #$3a
8C0E: 90 02    bcc	$8c12
8C10: 69 07    adc #$07
8C12: 8D A0 11 sta	$11a0
8C15: 8A       txa
8C16: 29 0F    and #$0f
8C18: 09 30    ora #$30
8C1A: C9 3A    cmp #$3a
8C1C: 90 02    bcc	$8c20
8C1E: 69 07    adc #$07
8C20: 8D A2 11 sta	$11a2
8C23: 98       tya
8C24: 4A       lsr a
8C25: 4A       lsr a
8C26: 4A       lsr a
8C27: 4A       lsr a
8C28: 09 30    ora #$30
8C2A: C9 3A    cmp #$3a
8C2C: 90 02    bcc	$8c30
8C2E: 69 07    adc #$07
8C30: 8D A6 11 sta	$11a6
8C33: 98       tya
8C34: 29 0F    and #$0f
8C36: 09 30    ora #$30
8C38: C9 3A    cmp #$3a
8C3A: 90 02    bcc	$8c3e
8C3C: 69 07    adc #$07
8C3E: 8D A8 11 sta	$11a8
8C41: A9 00    lda #$00
8C43: 8D A1 11 sta	$11a1
8C46: 8D A3 11 sta	$11a3
8C49: 8D A7 11 sta	$11a7
8C4C: 8D A9 11 sta	$11a9
8C4F: 8D AD 11 sta	$11ad
8C52: A2 00    ldx #$00
8C54: BD 8C 8C lda	$8c8c, x
8C57: 9D 8A 11 sta	$118a, x
8C5A: E8       inx
8C5B: E0 14    cpx #$14
8C5D: 90 F5    bcc	$8c54
8C5F: A2 0F    ldx #$0f
8C61: A9 FF    lda #$ff
8C63: 9D 00 20 sta	$2000, x
8C66: CA       dex
8C67: 10 FA    bpl	$8c63
8C69: A9 00    lda #$00
8C6B: AA       tax
8C6C: A8       tay
8C6D: 8D 00 20 sta	$2000
8C70: A9 A8    lda #$a8
8C72: 8D 00 28 sta	$2800
8C75: 8D 01 28 sta	$2801
8C78: 8D 00 30 sta watchdog_3000
8C7B: C8       iny
8C7C: D0 FD    bne	$8c7b
8C7E: E8       inx
8C7F: D0 F7    bne	$8c78
8C81: A9 00    lda #$00
8C83: 8D 00 28 sta	$2800
8C86: 8D 01 28 sta	$2801
8C89: 4C 89 8C jmp	$8c89

8CA0: 84 67    sty	$0067
8CA2: A0 00    ldy #$00
8CA4: 84 AD    sty	$00ad
8CA6: 86 AE    stx	$00ae
8CA8: E0 60    cpx #$60
8CAA: D0 01    bne	$8cad
8CAC: C8       iny
8CAD: 18       clc
8CAE: 71 AD    adc ($ad), y
8CB0: C8       iny
8CB1: D0 FA    bne	$8cad
8CB3: 8D 00 30 sta watchdog_3000
8CB6: E8       inx
8CB7: C6 67    dec	$0067
8CB9: D0 E7    bne	$8ca2
8CBB: 60       rts
8CBC: 84 21    sty	$0021
8CBE: 0A       asl a
8CBF: A8       tay
8CC0: B9 EC 8C lda	$8cec, y
8CC3: 85 A8    sta	$00a8
8CC5: B9 ED 8C lda	$8ced, y
8CC8: 85 A9    sta	$00a9
8CCA: A0 00    ldy #$00
8CCC: A2 00    ldx #$00
8CCE: B1 A8    lda ($a8), y
8CD0: 85 AA    sta	$00aa
8CD2: C8       iny
8CD3: B1 A8    lda ($a8), y
8CD5: 85 AB    sta	$00ab
8CD7: C8       iny
8CD8: B1 A8    lda ($a8), y
8CDA: 81 AA    sta ($aa, x)
8CDC: E6 AA    inc	$00aa
8CDE: A5 21    lda	$0021
8CE0: 81 AA    sta ($aa, x)
8CE2: E6 AA    inc	$00aa
8CE4: C8       iny
8CE5: B1 A8    lda ($a8), y
8CE7: C9 FF    cmp #$ff
8CE9: D0 EF    bne	$8cda
8CEB: 60       rts

9264: 48       pha                                                 
9265: 4A       lsr a                                               
9266: 4A       lsr a
9267: 4A       lsr a
9268: 4A       lsr a
9269: C9 0A    cmp #$0a
926B: 90 03    bcc	$9270
926D: 18       clc
926E: 69 07    adc #$07
9270: 69 30    adc #$30
9272: A0 00    ldy #$00
9274: 91 02    sta ($02), y
9276: C8       iny
9277: A9 00    lda #$00
9279: 91 02    sta ($02), y
927B: C8       iny
927C: 68       pla
927D: 29 0F    and #$0f
927F: C9 0A    cmp #$0a
9281: 90 03    bcc	$9286
9283: 18       clc
9284: 69 07    adc #$07
9286: 69 30    adc #$30
9288: 91 02    sta ($02), y
928A: C8       iny
928B: A9 00    lda #$00
928D: 91 02    sta ($02), y
928F: 60       rts
9290: A0 00    ldy #$00
9292: B9 9C 92 lda	$929c, y
9295: 99 00 20 sta	$2000, y
9298: C8       iny
9299: D0 F7    bne	$9292
929B: 60       rts

939C: AC 89 06 ldy	$0689
939F: C8       iny
93A0: C0 06    cpy #$06
93A2: 90 02    bcc	$93a6
93A4: A0 00    ldy #$00
93A6: 8C 89 06 sty	$0689
93A9: B9 C2 93 lda	$93c2, y
93AC: 8D 0F 20 sta	$200f
93AF: 8D 61 20 sta	$2061
93B2: 8D 62 20 sta	$2062
93B5: 8D 63 20 sta	$2063
93B8: 98       tya
93B9: 18       clc
93BA: 69 1C    adc #$1c
93BC: A0 60    ldy #$60
93BE: 20 BC 8C jsr	$8cbc
93C1: 60       rts

93C8: 48       pha
93C9: A5 AD    lda	$00ad
93CB: 18       clc
93CC: 69 01    adc #$01
93CE: 85 AD    sta	$00ad
93D0: A5 AE    lda	$00ae
93D2: 69 00    adc #$00
93D4: 85 AE    sta	$00ae
93D6: 68       pla
93D7: 60       rts
93D8: AD E8 06 lda	$06e8
93DB: 85 AD    sta	$00ad
93DD: AD E9 06 lda	$06e9
93E0: 85 AE    sta	$00ae
93E2: A9 00    lda #$00
93E4: 8D EE 06 sta	$06ee
93E7: A8       tay
93E8: B1 AD    lda ($ad), y
93EA: 20 C8 93 jsr	$93c8
93ED: 29 07    and #$07
93EF: F0 19    beq	$940a
93F1: A8       tay
93F2: B9 43 94 lda	$9443, y
93F5: 85 1E    sta	$001e
93F7: A0 00    ldy #$00
93F9: B1 AD    lda ($ad), y
93FB: 20 C8 93 jsr	$93c8
93FE: D0 F9    bne	$93f9
9400: C6 1E    dec	$001e
9402: 10 F5    bpl	$93f9
9404: EE EE 06 inc	$06ee
9407: 4C E8 93 jmp	$93e8
940A: CE EE 06 dec	$06ee
940D: 60       rts
940E: 85 1D    sta	$001d
9410: AD E8 06 lda	$06e8
9413: 85 AD    sta	$00ad
9415: AD E9 06 lda	$06e9
9418: 85 AE    sta	$00ae
941A: A5 1D    lda	$001d
941C: F0 22    beq	$9440
941E: A0 00    ldy #$00
9420: B1 AD    lda ($ad), y
9422: 20 C8 93 jsr	$93c8
9425: 29 07    and #$07
9427: F0 19    beq	$9442
9429: A8       tay
942A: B9 43 94 lda	$9443, y
942D: 85 1E    sta	$001e
942F: A0 00    ldy #$00
9431: B1 AD    lda ($ad), y
9433: 20 C8 93 jsr	$93c8
9436: D0 F9    bne	$9431
9438: C6 1E    dec	$001e
943A: 10 F5    bpl	$9431
943C: C6 1D    dec	$001d
943E: D0 E0    bne	$9420
9440: A9 01    lda #$01
9442: 60       rts

944B: A0 00    ldy #$00                                            
944D: B1 AD    lda ($ad), y
944F: 85 1F    sta	$001f
9451: 4A       lsr a
9452: 4A       lsr a
9453: 4A       lsr a
9454: 85 21    sta	$0021
9456: A5 1F    lda	$001f
9458: 29 07    and #$07
945A: F0 7A    beq	$94d6
945C: A8       tay
945D: B9 43 94 lda	$9443, y
9460: 38       sec
9461: E9 01    sbc #$01
9463: 85 22    sta	$0022
9465: AD E4 06 lda	$06e4
9468: 85 1B    sta	$001b
946A: AD E5 06 lda	$06e5
946D: 85 1C    sta	$001c
946F: AD E6 06 lda	$06e6
9472: 85 1D    sta	$001d
9474: AD E7 06 lda	$06e7
9477: 85 1E    sta	$001e
9479: A0 00    ldy #$00
947B: C6 21    dec	$0021
947D: 30 0B    bmi	$948a
947F: 46 1B    lsr	$001b
9481: 66 1C    ror	$001c
9483: 46 1D    lsr	$001d
9485: 66 1E    ror	$001e
9487: 4C 7B 94 jmp	$947b
948A: A5 22    lda	$0022
948C: 25 1C    and	$001c
948E: 85 1C    sta	$001c
9490: A5 22    lda	$0022
9492: 25 1E    and	$001e
9494: 85 1E    sta	$001e
9496: 20 C8 93 jsr	$93c8
9499: 20 32 97 jsr	$9732
949C: A5 1C    lda	$001c
949E: 85 20    sta	$0020
94A0: A0 00    ldy #$00
94A2: B1 AD    lda ($ad), y
94A4: 20 C8 93 jsr	$93c8
94A7: D0 F9    bne	$94a2
94A9: C6 20    dec	$0020
94AB: 10 F5    bpl	$94a2
94AD: A5 1C    lda	$001c
94AF: C5 1E    cmp	$001e
94B1: D0 06    bne	$94b9
94B3: A5 05    lda	$0005
94B5: 09 10    ora #$10
94B7: 85 05    sta	$0005
94B9: 20 42 97 jsr	$9742
94BC: A5 05    lda	$0005
94BE: 29 EF    and #$ef
94C0: 85 05    sta	$0005
94C2: A5 22    lda	$0022
94C4: 38       sec
94C5: E5 1C    sbc	$001c
94C7: 85 20    sta	$0020
94C9: A0 00    ldy #$00
94CB: B1 AD    lda ($ad), y
94CD: 20 C8 93 jsr	$93c8
94D0: D0 F9    bne	$94cb
94D2: C6 20    dec	$0020
94D4: 10 F5    bpl	$94cb
94D6: A0 00    ldy #$00
94D8: B1 AD    lda ($ad), y
94DA: 60       rts
94DB: 20 0E 94 jsr	$940e
94DE: F0 17    beq	$94f7
94E0: A9 03    lda #$03
94E2: 8D 8B 06 sta	$068b
94E5: 20 4B 94 jsr	$944b
94E8: F0 0D    beq	$94f7
94EA: AD 8B 06 lda	$068b
94ED: 18       clc
94EE: 69 03    adc #$03
94F0: 8D 8B 06 sta	$068b
94F3: C9 18    cmp #$18
94F5: 90 EE    bcc	$94e5
94F7: A9 03    lda #$03
94F9: 8D 8B 06 sta	$068b
94FC: 60       rts
94FD: 20 D8 93 jsr	$93d8
9500: A9 00    lda #$00
9502: 8D EF 06 sta	$06ef
9505: 85 B1    sta	$00b1
9507: 85 05    sta	$0005
9509: 20 DB 94 jsr	$94db
950C: A5 B1    lda	$00b1
950E: 20 0E 94 jsr	$940e
9511: F0 17    beq	$952a
9513: A9 20    lda #$20
9515: 85 05    sta	$0005
9517: 20 4B 94 jsr	$944b
951A: A9 00    lda #$00
951C: 85 05    sta	$0005
951E: AD E8 06 lda	$06e8
9521: 8D EA 06 sta	$06ea
9524: AD E9 06 lda	$06e9
9527: 8D EB 06 sta	$06eb
952A: 60       rts
952B: AD E4 06 lda	$06e4
952E: 8D E2 06 sta	$06e2
9531: AD E5 06 lda	$06e5
9534: 8D E3 06 sta	$06e3
9537: A5 B5    lda	$00b5
9539: 29 08    and #$08
953B: F0 0B    beq	$9548
953D: C6 B1    dec	$00b1
953F: 10 04    bpl	$9545
9541: A9 00    lda #$00
9543: 85 B1    sta	$00b1
9545: B8       clv
9546: 50 0F    bvc	$9557
9548: A5 B5    lda	$00b5
954A: 29 06    and #$06
954C: F0 09    beq	$9557
954E: A5 B1    lda	$00b1
9550: CD EE 06 cmp	$06ee
9553: B0 02    bcs	$9557
9555: E6 B1    inc	$00b1
9557: A5 B5    lda	$00b5
9559: 29 1E    and #$1e
955B: F0 49    beq	$95a6
955D: A9 01    lda #$01
955F: 85 05    sta	$0005
9561: AD EF 06 lda	$06ef
9564: 20 DB 94 jsr	$94db
9567: A9 00    lda #$00
9569: 85 05    sta	$0005
956B: A5 B5    lda	$00b5
956D: 29 10    and #$10
956F: F0 10    beq	$9581
9571: AD C0 05 lda	$05c0
9574: 8D E4 06 sta	$06e4
9577: AD C1 05 lda	$05c1
957A: 8D E5 06 sta	$06e5
957D: A9 00    lda #$00
957F: 85 B1    sta	$00b1
9581: A5 B1    lda	$00b1
9583: CD EF 06 cmp	$06ef
9586: B0 06    bcs	$958e
9588: 8D EF 06 sta	$06ef
958B: B8       clv
958C: 50 12    bvc	$95a0
958E: AD EF 06 lda	$06ef
9591: 18       clc
9592: 69 06    adc #$06
9594: C5 B1    cmp	$00b1
9596: B0 08    bcs	$95a0
9598: A5 B1    lda	$00b1
959A: 38       sec
959B: E9 06    sbc #$06
959D: 8D EF 06 sta	$06ef
95A0: AD EF 06 lda	$06ef
95A3: 20 DB 94 jsr	$94db
95A6: AD EF 06 lda	$06ef
95A9: D0 04    bne	$95af
95AB: A9 3D    lda #$3d
95AD: D0 02    bne	$95b1
95AF: A9 3C    lda #$3c
95B1: A0 00    ldy #$00
95B3: 20 BC 8C jsr	$8cbc
95B6: AD EE 06 lda	$06ee
95B9: 38       sec
95BA: ED EF 06 sbc	$06ef
95BD: C9 07    cmp #$07
95BF: 90 04    bcc	$95c5
95C1: A9 3E    lda #$3e
95C3: D0 02    bne	$95c7
95C5: A9 3F    lda #$3f
95C7: A0 00    ldy #$00
95C9: 20 BC 8C jsr	$8cbc
95CC: A5 B1    lda	$00b1
95CE: 20 0E 94 jsr	$940e
95D1: A5 AD    lda	$00ad
95D3: 8D EA 06 sta	$06ea
95D6: A5 AE    lda	$00ae
95D8: 8D EB 06 sta	$06eb
95DB: A0 00    ldy #$00
95DD: B1 AD    lda ($ad), y
95DF: 85 1F    sta	$001f
95E1: 4A       lsr a
95E2: 4A       lsr a
95E3: 4A       lsr a
95E4: 85 21    sta	$0021
95E6: A5 1F    lda	$001f
95E8: 29 07    and #$07
95EA: D0 03    bne	$95ef
95EC: 4C B7 96 jmp	$96b7
95EF: A8       tay
95F0: B9 43 94 lda	$9443, y
95F3: 85 1F    sta	$001f
95F5: 38       sec
95F6: E9 01    sbc #$01
95F8: 8D ED 06 sta	$06ed
95FB: A9 00    lda #$00
95FD: 8D EC 06 sta	$06ec
9600: A4 21    ldy	$0021
9602: 88       dey
9603: 30 09    bmi	$960e
9605: 0E ED 06 asl	$06ed
9608: 2E EC 06 rol	$06ec
960B: 4C 02 96 jmp	$9602
960E: A5 21    lda	$0021
9610: 29 0F    and #$0f
9612: 0A       asl a
9613: A8       tay
9614: B9 7A 97 lda	$977a, y
9617: 85 1E    sta	$001e
9619: B9 7B 97 lda	$977b, y
961C: 85 1D    sta	$001d
961E: A5 B5    lda	$00b5
9620: 29 C0    and #$c0
9622: F0 30    beq	$9654
9624: 20 B8 96 jsr	$96b8
9627: AD EC 06 lda	$06ec
962A: 2D E4 06 and	$06e4
962D: 85 1D    sta	$001d
962F: AD ED 06 lda	$06ed
9632: 2D E5 06 and	$06e5
9635: 85 1E    sta	$001e
9637: A4 21    ldy	$0021
9639: 88       dey
963A: 30 07    bmi	$9643
963C: 46 1D    lsr	$001d
963E: 66 1E    ror	$001e
9640: 4C 39 96 jmp	$9639
9643: A0 00    ldy #$00
9645: B1 AD    lda ($ad), y
9647: 20 C8 93 jsr	$93c8
964A: D0 F9    bne	$9645
964C: C6 1E    dec	$001e
964E: 10 F5    bpl	$9645
9650: B1 AD    lda ($ad), y
9652: F0 BA    beq	$960e
9654: A5 B5    lda	$00b5
9656: 29 DE    and #$de
9658: F0 5D    beq	$96b7
965A: A5 B1    lda	$00b1
965C: 38       sec
965D: ED EF 06 sbc	$06ef
9660: 18       clc
9661: 69 01    adc #$01
9663: 8D 8B 06 sta	$068b
9666: 0A       asl a
9667: 6D 8B 06 adc	$068b
966A: 8D 8B 06 sta	$068b
966D: AD E4 06 lda	$06e4
9670: 8D C2 05 sta	$05c2
9673: AD E5 06 lda	$06e5
9676: 8D C3 05 sta	$05c3
9679: AD E2 06 lda	$06e2
967C: 8D E4 06 sta	$06e4
967F: AD E3 06 lda	$06e3
9682: 8D E5 06 sta	$06e5
9685: AD EA 06 lda	$06ea
9688: 85 AD    sta	$00ad
968A: AD EB 06 lda	$06eb
968D: 85 AE    sta	$00ae
968F: A9 01    lda #$01
9691: 85 05    sta	$0005
9693: 20 4B 94 jsr	$944b
9696: AD C2 05 lda	$05c2
9699: 8D E4 06 sta	$06e4
969C: AD C3 05 lda	$05c3
969F: 8D E5 06 sta	$06e5
96A2: AD EA 06 lda	$06ea
96A5: 85 AD    sta	$00ad
96A7: AD EB 06 lda	$06eb
96AA: 85 AE    sta	$00ae
96AC: A9 20    lda #$20
96AE: 85 05    sta	$0005
96B0: 20 4B 94 jsr	$944b
96B3: A9 00    lda #$00
96B5: 85 05    sta	$0005
96B7: 60       rts
96B8: 29 80    and #$80
96BA: F0 39    beq	$96f5
96BC: AD EC 06 lda	$06ec
96BF: 2D E4 06 and	$06e4
96C2: D0 1D    bne	$96e1
96C4: AD ED 06 lda	$06ed
96C7: 2D E5 06 and	$06e5
96CA: D0 15    bne	$96e1
96CC: AD E4 06 lda	$06e4
96CF: 0D EC 06 ora	$06ec
96D2: 8D E4 06 sta	$06e4
96D5: AD E5 06 lda	$06e5
96D8: 0D ED 06 ora	$06ed
96DB: 8D E5 06 sta	$06e5
96DE: B8       clv
96DF: 50 11    bvc	$96f2
96E1: AD E5 06 lda	$06e5
96E4: 38       sec
96E5: E5 1E    sbc	$001e
96E7: 8D E5 06 sta	$06e5
96EA: AD E4 06 lda	$06e4
96ED: E5 1D    sbc	$001d
96EF: 8D E4 06 sta	$06e4
96F2: B8       clv
96F3: 50 3C    bvc	$9731
96F5: AD E4 06 lda	$06e4
96F8: 2D EC 06 and	$06ec
96FB: CD EC 06 cmp	$06ec
96FE: D0 20    bne	$9720
9700: AD E5 06 lda	$06e5
9703: 2D ED 06 and	$06ed
9706: CD ED 06 cmp	$06ed
9709: D0 15    bne	$9720
970B: AD E5 06 lda	$06e5
970E: 4D ED 06 eor	$06ed
9711: 8D E5 06 sta	$06e5
9714: AD E4 06 lda	$06e4
9717: 4D EC 06 eor	$06ec
971A: 8D E4 06 sta	$06e4
971D: B8       clv
971E: 50 11    bvc	$9731
9720: AD E5 06 lda	$06e5
9723: 18       clc
9724: 65 1E    adc	$001e
9726: 8D E5 06 sta	$06e5
9729: AD E4 06 lda	$06e4
972C: 65 1D    adc	$001d
972E: 8D E4 06 sta	$06e4
9731: 60       rts
9732: AD 8B 06 lda	$068b
9735: 4A       lsr a
9736: 09 10    ora #$10
9738: 85 AB    sta	$00ab
973A: A9 08    lda #$08
973C: 6A       ror a
973D: 85 AA    sta	$00aa
973F: 4C 52 97 jmp	$9752
9742: AD 8B 06 lda	$068b
9745: 18       clc
9746: 69 01    adc #$01
9748: 4A       lsr a
9749: 09 10    ora #$10
974B: 85 AB    sta	$00ab
974D: A9 0C    lda #$0c
974F: 6A       ror a
9750: 85 AA    sta	$00aa
9752: A0 00    ldy #$00
9754: A2 00    ldx #$00
9756: B1 AD    lda ($ad), y
9758: F0 1F    beq	$9779
975A: A5 05    lda	$0005
975C: 29 01    and #$01
975E: F0 09    beq	$9769
9760: A9 00    lda #$00
9762: 81 AA    sta ($aa, x)
9764: E6 AA    inc	$00aa
9766: B8       clv
9767: 50 08    bvc	$9771
9769: B1 AD    lda ($ad), y
976B: 81 AA    sta ($aa, x)
976D: E6 AA    inc	$00aa
976F: A5 05    lda	$0005
9771: 81 AA    sta ($aa, x)
9773: E6 AA    inc	$00aa
9775: C8       iny
9776: 4C 56 97 jmp	$9756
9779: 60       rts

9A42: 4C 00 80 jmp	$8000

continue_startup_9a45:
9A45: 20 8C CA jsr	$ca8c
; title image with Kremlin & TETRIS is now displayed
; title loop
game_mainloop_9A48:
9A48: A2 17    ldx #$17
9A4A: 20 B2 B4 jsr	$b4b2
; sync?
9A4D: A5 09    lda	$0009
9A4F: F0 F7    beq game_mainloop_9A48
9A51: A9 00    lda #$00
9A53: 85 09    sta	$0009
9A55: AD BC 08 lda	$08bc
9A58: 29 E0    and #$e0
9A5A: C9 E0    cmp #$e0
9A5C: D0 05    bne	$9a63
; free play ?
9A5E: A9 02    lda #$02
9A60: 8D C1 00 sta number_of_credits_00c1
9A63: A5 08    lda	$0008
9A65: F0 19    beq	$9a80
9A67: A5 55    lda	$0055
9A69: C5 54    cmp	$0054
9A6B: D0 13    bne	$9a80
9A6D: A5 6E    lda	$006e
9A6F: C9 FF    cmp #$ff
9A71: D0 0D    bne	$9a80
9A73: A5 6D    lda	$006d
9A75: C5 6C    cmp	$006c
9A77: D0 07    bne	$9a80
9A79: A5 58    lda	$0058
9A7B: 10 03    bpl	$9a80
9A7D: 4C 9B 82 jmp	$829b
9A80: A5 58    lda	$0058
9A82: 29 0C    and #$0c
9A84: C9 0C    cmp #$0c
9A86: F0 08    beq	$9a90
9A88: A9 01    lda #$01
9A8A: 85 15    sta	$0015
9A8C: A9 10    lda #$10
9A8E: 85 16    sta	$0016
9A90: A5 58    lda	$0058
9A92: 29 04    and #$04
9A94: F0 14    beq	$9aaa
9A96: C6 15    dec	$0015
9A98: 10 AE    bpl game_mainloop_9A48
9A9A: A5 16    lda	$0016
9A9C: 85 15    sta	$0015
9A9E: C9 03    cmp #$03
9AA0: 90 04    bcc	$9aa6
9AA2: E9 02    sbc #$02
9AA4: D0 02    bne	$9aa8
9AA6: A9 01    lda #$01
9AA8: 85 16    sta	$0016
9AAA: 20 DB D6 jsr	$d6db
9AAD: 20 47 C2 jsr	$c247
9AB0: AD A2 06 lda	$06a2
9AB3: D0 75    bne	$9b2a
9AB5: A5 43    lda	$0043
9AB7: D0 6B    bne	$9b24
9AB9: AD A5 06 lda	$06a5
9ABC: D0 60    bne	$9b1e
9ABE: 20 42 CB jsr	$cb42
9AC1: 20 9B A4 jsr	$a49b
9AC4: 20 5C C1 jsr	$c15c
9AC7: 20 64 C5 jsr	$c564
9ACA: A5 08    lda	$0008
9ACC: C9 FE    cmp #$fe
9ACE: F0 4B    beq	$9b1b
9AD0: A2 00    ldx #$00
9AD2: 20 41 BF jsr	$bf41
9AD5: A2 01    ldx #$01
9AD7: 20 41 BF jsr	$bf41
9ADA: A2 00    ldx #$00
9ADC: 20 88 BF jsr	$bf88
9ADF: A2 01    ldx #$01
9AE1: 20 88 BF jsr	$bf88
9AE4: 20 CE B6 jsr	$b6ce
9AE7: A2 00    ldx #$00
9AE9: 20 9E BC jsr	$bc9e
9AEC: 20 BC B8 jsr	$b8bc
9AEF: A2 01    ldx #$01
9AF1: 20 9E BC jsr	$bc9e
9AF4: 20 BC B8 jsr	$b8bc
9AF7: A5 35    lda	$0035
9AF9: D0 05    bne	$9b00
9AFB: A2 00    ldx #$00
9AFD: 20 2E A0 jsr	$a02e
9B00: A5 36    lda	$0036
9B02: D0 05    bne	$9b09
9B04: A2 01    ldx #$01
9B06: 20 2E A0 jsr	$a02e
9B09: A5 35    lda	$0035
9B0B: D0 05    bne	$9b12
9B0D: A2 00    ldx #$00
9B0F: 20 D0 9B jsr	$9bd0
9B12: A5 36    lda	$0036
9B14: D0 05    bne	$9b1b
9B16: A2 01    ldx #$01
9B18: 20 D0 9B jsr	$9bd0
9B1B: B8       clv
9B1C: 50 03    bvc	$9b21
9B1E: 20 38 BD jsr	$bd38
9B21: B8       clv
9B22: 50 03    bvc	$9b27
9B24: 20 F2 BB jsr	$bbf2
9B27: 20 05 B6 jsr	$b605
9B2A: 4C 48 9A jmp game_mainloop_9A48

9B2D: B5 29    lda	$0029, x
9B2F: 29 FD    and #$fd
9B31: E0 00    cpx #$00
9B33: F0 07    beq	$9b3c
9B35: AC 19 06 ldy	$0619
9B38: C0 03    cpy #$03
9B3A: B0 04    bcs	$9b40
9B3C: A4 08    ldy	$0008
9B3E: F0 01    beq	$9b41
9B40: 60       rts
9B41: A8       tay
9B42: B5 27    lda	$0027, x
9B44: 85 1B    sta	$001b
9B46: 29 08    and #$08
9B48: F0 11    beq	$9b5b
9B4A: BD 22 06 lda	$0622, x
9B4D: 18       clc
9B4E: 69 01    adc #$01
9B50: 9D 22 06 sta	$0622, x
9B53: C9 0B    cmp #$0b
9B55: 90 09    bcc	$9b60
9B57: 98       tya
9B58: 09 08    ora #$08
9B5A: A8       tay
9B5B: A9 00    lda #$00
9B5D: 9D 22 06 sta	$0622, x
9B60: A5 1B    lda	$001b
9B62: 29 04    and #$04
9B64: F0 11    beq	$9b77
9B66: BD 24 06 lda	$0624, x
9B69: 18       clc
9B6A: 69 01    adc #$01
9B6C: 9D 24 06 sta	$0624, x
9B6F: C9 0B    cmp #$0b
9B71: 90 09    bcc	$9b7c
9B73: 98       tya
9B74: 09 04    ora #$04
9B76: A8       tay
9B77: A9 00    lda #$00
9B79: 9D 24 06 sta	$0624, x
9B7C: A5 1B    lda	$001b
9B7E: 29 01    and #$01
9B80: F0 11    beq	$9b93
9B82: BD 26 06 lda	$0626, x
9B85: 18       clc
9B86: 69 01    adc #$01
9B88: 9D 26 06 sta	$0626, x
9B8B: C9 1D    cmp #$1d
9B8D: 90 09    bcc	$9b98
9B8F: 98       tya
9B90: 09 01    ora #$01
9B92: A8       tay
9B93: A9 00    lda #$00
9B95: 9D 26 06 sta	$0626, x
9B98: A5 1B    lda	$001b
9B9A: 29 0E    and #$0e
9B9C: C9 02    cmp #$02
9B9E: D0 29    bne	$9bc9
9BA0: BD 2A 06 lda	$062a, x
9BA3: 18       clc
9BA4: 69 01    adc #$01
9BA6: 9D 2A 06 sta	$062a, x
9BA9: DD 2C 06 cmp	$062c, x
9BAC: 90 19    bcc	$9bc7
9BAE: 98       tya
9BAF: 09 02    ora #$02
9BB1: 85 1B    sta	$001b
9BB3: BD 2C 06 lda	$062c, x
9BB6: C9 02    cmp #$02
9BB8: 90 03    bcc	$9bbd
9BBA: DE 2C 06 dec	$062c, x
9BBD: 20 A4 B5 jsr	$b5a4
9BC0: A4 1B    ldy	$001b
9BC2: A9 00    lda #$00
9BC4: 9D 2A 06 sta	$062a, x
9BC7: 98       tya
9BC8: 60       rts
9BC9: A9 06    lda #$06
9BCB: 9D 2C 06 sta	$062c, x
9BCE: D0 F2    bne	$9bc2
9BD0: A4 08    ldy	$0008
9BD2: F0 05    beq	$9bd9
9BD4: C0 FC    cpy #$fc
9BD6: F0 01    beq	$9bd9
9BD8: 60       rts
9BD9: B5 95    lda	$0095, x
9BDB: D0 FB    bne	$9bd8
9BDD: B5 77    lda	$0077, x
9BDF: F0 07    beq	$9be8
9BE1: B5 8B    lda	$008b, x
9BE3: D0 04    bne	$9be9
9BE5: 4C D2 B2 jmp	$b2d2
9BE8: 60       rts
9BE9: 20 2D 9B jsr	$9b2d
9BEC: 85 20    sta	$0020
9BEE: D6 91    dec	$0091, x
9BF0: D0 07    bne	$9bf9
9BF2: 09 02    ora #$02
9BF4: 85 20    sta	$0020
9BF6: 20 A4 B5 jsr	$b5a4
9BF9: A5 20    lda	$0020
9BFB: 29 0F    and #$0f
9BFD: F0 D9    beq	$9bd8
9BFF: 20 FA 9D jsr	$9dfa
9C02: 20 C0 9E jsr	$9ec0
9C05: A5 20    lda	$0020
9C07: 29 08    and #$08
9C09: F0 0E    beq	$9c19
9C0B: D6 89    dec	$0089, x
9C0D: 20 2A 9F jsr	$9f2a
9C10: B0 07    bcs	$9c19
9C12: A9 09    lda #$09
9C14: 9D 22 06 sta	$0622, x
9C17: F6 89    inc	$0089, x
9C19: A5 20    lda	$0020
9C1B: 29 04    and #$04
9C1D: F0 0E    beq	$9c2d
9C1F: F6 89    inc	$0089, x
9C21: 20 2A 9F jsr	$9f2a
9C24: B0 07    bcs	$9c2d
9C26: A9 09    lda #$09
9C28: 9D 24 06 sta	$0624, x
9C2B: D6 89    dec	$0089, x
9C2D: A5 20    lda	$0020
9C2F: 29 01    and #$01
9C31: F0 1D    beq	$9c50
9C33: B5 8F    lda	$008f, x
9C35: 85 1F    sta	$001f
9C37: 18       clc
9C38: 69 01    adc #$01
9C3A: 29 03    and #$03
9C3C: 95 8F    sta	$008f, x
9C3E: 20 2A 9F jsr	$9f2a
9C41: B0 0D    bcs	$9c50
9C43: D6 89    dec	$0089, x
9C45: 20 2A 9F jsr	$9f2a
9C48: B0 06    bcs	$9c50
9C4A: F6 89    inc	$0089, x
9C4C: A5 1F    lda	$001f
9C4E: 95 8F    sta	$008f, x
9C50: A5 20    lda	$0020
9C52: 29 02    and #$02
9C54: F0 36    beq	$9c8c
9C56: F6 87    inc	$0087, x
9C58: 20 2A 9F jsr	$9f2a
9C5B: B0 2F    bcs	$9c8c
9C5D: D6 87    dec	$0087, x
9C5F: 20 E8 9E jsr	$9ee8
9C62: 20 F1 B4 jsr	$b4f1
9C65: A9 00    lda #$00
9C67: 95 8B    sta	$008b, x
9C69: B5 87    lda	$0087, x
9C6B: C9 06    cmp #$06
9C6D: B0 09    bcs	$9c78
9C6F: 8E 4D 06 stx	$064d
9C72: 20 F3 9C jsr	$9cf3
9C75: 4C 8F 9C jmp	$9c8f
9C78: A9 12    lda #$12
9C7A: 20 59 E6 jsr	$e659
9C7D: A5 99    lda	$0099
9C7F: 18       clc
9C80: 69 01    adc #$01
9C82: 95 93    sta	$0093, x
9C84: 4C 8F 9C jmp	$9c8f
9C87: A9 07    lda #$07
9C89: 9D 2C 06 sta	$062c, x
9C8C: 20 E8 9E jsr	$9ee8
9C8F: 20 8F 9E jsr	clear_player_grid_9E8F
9C92: A0 00    ldy #$00
9C94: 84 05    sty	$0005
9C96: A9 07    lda #$07
9C98: 85 1B    sta	$001b
9C9A: A2 08    ldx #$08
9C9C: B9 10 01 lda	$0110, y
9C9F: D9 48 01 cmp	$0148, y
9CA2: D0 14    bne	$9cb8
9CA4: C8       iny
9CA5: CA       dex
9CA6: D0 F4    bne	$9c9c
9CA8: A5 9D    lda	$009d
9CAA: 18       clc
9CAB: 69 80    adc #$80
9CAD: 85 9D    sta	$009d
9CAF: 90 02    bcc	$9cb3
9CB1: E6 9E    inc	$009e
9CB3: C6 1B    dec	$001b
9CB5: D0 E3    bne	$9c9a
9CB7: 60       rts
9CB8: 84 1D    sty	$001d
9CBA: 86 1C    stx	$001c
9CBC: 84 1E    sty	$001e
9CBE: C8       iny
9CBF: CA       dex
9CC0: F0 0A    beq	$9ccc
9CC2: B9 10 01 lda	$0110, y
9CC5: D9 48 01 cmp	$0148, y
9CC8: F0 F4    beq	$9cbe
9CCA: D0 F0    bne	$9cbc
9CCC: A9 48    lda #$48
9CCE: 18       clc
9CCF: 65 1D    adc	$001d
9CD1: 85 00    sta	$0000
9CD3: A9 01    lda #$01
9CD5: 85 01    sta	$0001
9CD7: A5 1D    lda	$001d
9CD9: 29 07    and #$07
9CDB: 0A       asl a
9CDC: 65 9D    adc	$009d
9CDE: 85 02    sta	$0002
9CE0: A5 9E    lda	$009e
9CE2: 69 00    adc #$00
9CE4: 85 03    sta	$0003
9CE6: A5 1E    lda	$001e
9CE8: 38       sec
9CE9: E5 1D    sbc	$001d
9CEB: 69 00    adc #$00
9CED: 20 E4 D5 jsr	$d5e4
9CF0: 4C A8 9C jmp	$9ca8
9CF3: 8E 4D 06 stx	$064d
9CF6: BD 9B 06 lda	$069b, x
9CF9: F0 0F    beq	$9d0a
9CFB: A9 18    lda #$18
9CFD: 9D 9F 06 sta	$069f, x
9D00: A9 00    lda #$00
9D02: 9D 9B 06 sta	$069b, x
9D05: A9 04    lda #$04
9D07: 95 35    sta	$0035, x
9D09: 60       rts
9D0A: A9 00    lda #$00
9D0C: 24 0B    bit	$000b
9D0E: 10 0A    bpl	$9d1a
9D10: 85 77    sta	$0077
9D12: 85 78    sta	$0078
9D14: A9 0C    lda #$0c
9D16: 85 4E    sta	$004e
9D18: 85 4F    sta	$004f
9D1A: A9 00    lda #$00
9D1C: 95 77    sta	$0077, x
9D1E: A9 0C    lda #$0c
9D20: 95 4E    sta	$004e, x
9D22: E0 01    cpx #$01
9D24: D0 10    bne	$9d36
9D26: A9 00    lda #$00
9D28: 85 A1    sta	$00a1
9D2A: 85 A2    sta	$00a2
9D2C: 85 A3    sta	$00a3
9D2E: 85 A4    sta	$00a4
9D30: 85 A5    sta	$00a5
9D32: 85 A6    sta	$00a6
9D34: 85 A7    sta	$00a7
9D36: A9 07    lda #$07
9D38: E0 00    cpx #$00
9D3A: D0 06    bne	$9d42
9D3C: 8D 70 06 sta	$0670
9D3F: B8       clv
9D40: 50 03    bvc	$9d45
9D42: 8D 72 06 sta	$0672
9D45: AD 18 06 lda	$0618
9D48: 85 50    sta	$0050
9D4A: A5 08    lda	$0008
9D4C: D0 03    bne	$9d51
9D4E: 20 05 F1 jsr	$f105
9D51: A5 77    lda	$0077
9D53: 05 78    ora	$0078
9D55: D0 08    bne	$9d5f
9D57: A9 09    lda #$09
9D59: 20 59 E6 jsr	$e659
9D5C: B8       clv
9D5D: 50 07    bvc	$9d66
9D5F: A9 00    lda #$00
9D61: 8D 19 06 sta	$0619
9D64: 85 0B    sta	$000b
9D66: A9 01    lda #$01
9D68: 8D C6 06 sta	$06c6
9D6B: AE 4D 06 ldx	$064d
9D6E: 8A       txa
9D6F: 0A       asl a
9D70: A8       tay
9D71: A9 00    lda #$00
9D73: 99 30 00 sta	$0030, y
9D76: 99 31 00 sta	$0031, y
9D79: AE 4D 06 ldx	$064d
9D7C: 20 D3 BC jsr	$bcd3
9D7F: A9 46    lda #$46
9D81: 18       clc
9D82: 6D 4D 06 adc	$064d
9D85: 20 70 D6 jsr	$d670
9D88: A9 0B    lda #$0b
9D8A: 20 59 E6 jsr	$e659
9D8D: 60       rts
9D8E: A2 00    ldx #$00
9D90: C8       iny
9D91: C8       iny
9D92: A9 0C    lda #$0c
9D94: 85 1B    sta	$001b
9D96: 08       php
9D97: 78       sei
; switch to bank 1
9D98: AD 00 60 lda bank_switch_start_6000
9D9B: AD 46 75 lda	$7546
9D9E: AD 90 60 lda	$6090
9DA1: AD 42 75 lda	$7542
9DA4: AD 43 75 lda	$7543
9DA7: AD 54 75 lda	$7554
9DAA: AD B0 60 lda	$60b0
9DAD: 28       plp
9DAE: B1 1F    lda ($1f), y
9DB0: C9 80    cmp #$80
9DB2: B0 3D    bcs	$9df1
9DB4: 85 1C    sta	$001c
9DB6: 29 F0    and #$f0
9DB8: D0 1E    bne	$9dd8
9DBA: A5 1C    lda	$001c
9DBC: D0 06    bne	$9dc4
9DBE: 9D 00 01 sta	$0100, x
9DC1: B8       clv
9DC2: 50 11    bvc	$9dd5
9DC4: C9 08    cmp #$08
9DC6: D0 05    bne	$9dcd
9DC8: AD 23 65 lda	$6523
9DCB: D0 03    bne	$9dd0
9DCD: AD 21 65 lda	$6521
9DD0: 9D 00 01 sta	$0100, x
9DD3: A9 F0    lda #$f0
9DD5: B8       clv
9DD6: 50 14    bvc	$9dec
9DD8: A5 1C    lda	$001c
9DDA: 29 0F    and #$0f
9DDC: 18       clc
9DDD: 6D 05 65 adc	$6505
9DE0: 9D 00 01 sta	$0100, x
9DE3: A5 1C    lda	$001c
9DE5: F0 05    beq	$9dec
9DE7: 29 70    and #$70
9DE9: 18       clc
9DEA: 69 70    adc #$70
9DEC: E8       inx
9DED: 9D 00 01 sta	$0100, x
9DF0: E8       inx
9DF1: C8       iny
9DF2: C6 1B    dec	$001b
9DF4: D0 A0    bne	$9d96
9DF6: 8A       txa
9DF7: 4A       lsr a
9DF8: AA       tax
9DF9: 60       rts
9DFA: 86 1E    stx	$001e
9DFC: 24 0B    bit	$000b
9DFE: 10 02    bpl	$9e02
9E00: A2 02    ldx #$02
9E02: BD 8C 9E lda	$9e8c, x
9E05: 85 1C    sta	$001c
9E07: BD 83 9E lda	$9e83, x
9E0A: 85 9E    sta	$009e
9E0C: A6 1E    ldx	$001e
9E0E: B5 87    lda	$0087, x
9E10: 38       sec
9E11: E9 01    sbc #$01
9E13: 85 99    sta	$0099
9E15: 0A       asl a
9E16: 0A       asl a
9E17: 0A       asl a
9E18: 0A       asl a
9E19: 85 1B    sta	$001b
9E1B: 90 02    bcc	$9e1f
9E1D: E6 1C    inc	$001c
9E1F: B5 89    lda	$0089, x
9E21: 38       sec
9E22: E9 02    sbc #$02
9E24: 10 02    bpl	$9e28
9E26: A9 00    lda #$00
9E28: 85 9A    sta	$009a
9E2A: 0A       asl a
9E2B: 85 1F    sta	$001f
9E2D: 4A       lsr a
9E2E: 05 1B    ora	$001b
9E30: 85 1B    sta	$001b
9E32: 85 9B    sta	$009b
9E34: A5 1C    lda	$001c
9E36: 85 9C    sta	$009c
9E38: A5 99    lda	$0099
9E3A: 4A       lsr a
9E3B: 18       clc
9E3C: 65 9E    adc	$009e
9E3E: 85 9E    sta	$009e
9E40: A5 99    lda	$0099
9E42: 4A       lsr a
9E43: A9 00    lda #$00
9E45: 6A       ror a
9E46: 7D 80 9E adc	$9e80, x
9E49: 90 02    bcc	$9e4d
9E4B: E6 9E    inc	$009e
9E4D: 18       clc
9E4E: 65 1F    adc	$001f
9E50: 85 9D    sta	$009d
9E52: 90 02    bcc	$9e56
9E54: E6 9E    inc	$009e
9E56: A2 00    ldx #$00
9E58: A0 00    ldy #$00
9E5A: B1 1B    lda ($1b), y
9E5C: 9D 10 01 sta	$0110, x
9E5F: 9D 48 01 sta	$0148, x
9E62: E6 1B    inc	$001b
9E64: D0 02    bne	$9e68
9E66: E6 1C    inc	$001c
9E68: E8       inx
9E69: 8A       txa
9E6A: 29 07    and #$07
9E6C: D0 0B    bne	$9e79
9E6E: A5 1B    lda	$001b
9E70: 18       clc
9E71: 69 08    adc #$08
9E73: 85 1B    sta	$001b
9E75: 90 02    bcc	$9e79
9E77: E6 1C    inc	$001c
9E79: E0 38    cpx #$38
9E7B: 90 DD    bcc	$9e5a
9E7D: A6 1E    ldx	$001e
9E7F: 60       rts

; player 1 grid $200-$3C0
; player 2 grid $400-$5C0
clear_player_grid_9E8F:
9E8F: A5 9B    lda	$009b
9E91: 85 1B    sta	$001b
9E93: A5 9C    lda	$009c
9E95: 85 1C    sta	$001c
9E97: 86 1E    stx	$001e
9E99: A2 00    ldx #$00
9E9B: A0 00    ldy #$00
; source of line
9E9D: BD 48 01 lda	$0148, x
; write to logical grid address $2xx or $4xx
9EA0: 91 1B    sta ($1b), y
9EA2: E6 1B    inc	$001b
9EA4: D0 02    bne	$9ea8
9EA6: E6 1C    inc	$001c
9EA8: E8       inx
9EA9: 8A       txa
9EAA: 29 07    and #$07
9EAC: D0 0B    bne	$9eb9
9EAE: A5 1B    lda	$001b
9EB0: 18       clc
9EB1: 69 08    adc #$08
9EB3: 85 1B    sta	$001b
9EB5: 90 02    bcc	$9eb9
9EB7: E6 1C    inc	$001c
9EB9: E0 38    cpx #$38
9EBB: 90 E0    bcc	$9e9d
9EBD: A6 1E    ldx	$001e
9EBF: 60       rts
9EC0: 20 6C 9F jsr	$9f6c
9EC3: 06 1B    asl	$001b
9EC5: 90 05    bcc	$9ecc
9EC7: A9 00    lda #$00
9EC9: 9D 48 01 sta	$0148, x
9ECC: E8       inx
9ECD: 88       dey
9ECE: F0 15    beq	$9ee5
9ED0: 98       tya
9ED1: 29 03    and #$03
9ED3: D0 EE    bne	$9ec3
9ED5: 8A       txa
9ED6: 18       clc
9ED7: 69 04    adc #$04
9ED9: AA       tax
9EDA: C0 08    cpy #$08
9EDC: D0 04    bne	$9ee2
9EDE: A5 1C    lda	$001c
9EE0: 85 1B    sta	$001b
9EE2: 4C C3 9E jmp	$9ec3
9EE5: A6 1D    ldx	$001d
9EE7: 60       rts
9EE8: 20 6C 9F jsr	$9f6c
9EEB: A5 1E    lda	$001e
9EED: 86 1E    stx	$001e
9EEF: A6 1D    ldx	$001d
9EF1: 0A       asl a
9EF2: 0A       asl a
9EF3: 15 8F    ora	$008f, x
9EF5: 0A       asl a
9EF6: 0A       asl a
9EF7: A6 1E    ldx	$001e
9EF9: 85 1E    sta	$001e
9EFB: 06 1B    asl	$001b
9EFD: 90 0F    bcc	$9f0e
9EFF: 84 59    sty	$0059
9F01: A4 1E    ldy	$001e
9F03: B9 AE 9F lda	$9fae, y
9F06: 9D 48 01 sta	$0148, x
9F09: C8       iny
9F0A: 84 1E    sty	$001e
9F0C: A4 59    ldy	$0059
9F0E: E8       inx
9F0F: 88       dey
9F10: F0 15    beq	$9f27
9F12: 98       tya
9F13: 29 03    and #$03
9F15: D0 E4    bne	$9efb
9F17: 8A       txa
9F18: 18       clc
9F19: 69 04    adc #$04
9F1B: AA       tax
9F1C: C0 08    cpy #$08
9F1E: D0 04    bne	$9f24
9F20: A5 1C    lda	$001c
9F22: 85 1B    sta	$001b
9F24: 4C FB 9E jmp	$9efb
9F27: A6 1D    ldx	$001d
9F29: 60       rts
9F2A: 20 6C 9F jsr	$9f6c
9F2D: A9 FF    lda #$ff
9F2F: 85 0A    sta	$000a
9F31: 06 1B    asl	$001b
9F33: 90 07    bcc	$9f3c
9F35: BD 48 01 lda	$0148, x
9F38: F0 02    beq	$9f3c
9F3A: 86 0A    stx	$000a
9F3C: E8       inx
9F3D: 88       dey
9F3E: F0 15    beq	$9f55
9F40: 98       tya
9F41: 29 03    and #$03
9F43: D0 EC    bne	$9f31
9F45: 8A       txa
9F46: 18       clc
9F47: 69 04    adc #$04
9F49: AA       tax
9F4A: C0 08    cpy #$08
9F4C: D0 04    bne	$9f52
9F4E: A5 1C    lda	$001c
9F50: 85 1B    sta	$001b
9F52: 4C 31 9F jmp	$9f31
9F55: A6 1D    ldx	$001d
9F57: A5 0A    lda	$000a
9F59: 10 03    bpl	$9f5e
9F5B: 38       sec
9F5C: B0 0D    bcs	$9f6b
9F5E: 4A       lsr a
9F5F: 4A       lsr a
9F60: 4A       lsr a
9F61: 18       clc
9F62: 65 99    adc	$0099
9F64: E9 1A    sbc #$1a
9F66: 49 FF    eor #$ff
9F68: 85 0A    sta	$000a
9F6A: 18       clc
9F6B: 60       rts
9F6C: B5 8B    lda	$008b, x
9F6E: 85 1E    sta	$001e
9F70: 0A       asl a
9F71: 0A       asl a
9F72: 15 8F    ora	$008f, x
9F74: 0A       asl a
9F75: A8       tay
9F76: 08       php
9F77: 78       sei
; switch to bank 1
9F78: AD 00 60 lda bank_switch_start_6000
9F7B: AD 49 75 lda	$7549
9F7E: AD A0 60 lda	$60a0
9F81: AD 43 75 lda	$7543
9F84: AD 43 75 lda	$7543
9F87: AD 42 75 lda	$7542
9F8A: AD 54 75 lda	$7554
9F8D: AD B0 60 lda	$60b0
9F90: 28       plp
9F91: B9 00 40 lda	$4000, y
9F94: 85 1B    sta	$001b
9F96: B9 01 40 lda	$4001, y
9F99: 85 1C    sta	$001c
9F9B: B5 87    lda	$0087, x
9F9D: 38       sec
9F9E: E5 99    sbc	$0099
9FA0: 0A       asl a
9FA1: 0A       asl a
9FA2: 0A       asl a
9FA3: 75 89    adc	$0089, x
9FA5: 38       sec
9FA6: E5 9A    sbc	$009a
9FA8: 86 1D    stx	$001d
9FAA: AA       tax
9FAB: A0 10    ldy #$10
9FAD: 60       rts

A02E: BD 77 06 lda $0677, x                                        
A031: F0 0A    beq $a03d                                           
A033: DE 77 06 dec	$0677, x
A036: D0 05    bne	$a03d
A038: A9 00    lda #$00
A03A: 20 6F A2 jsr	$a26f
A03D: BD 79 06 lda	$0679, x
A040: F0 0A    beq	$a04c
A042: DE 79 06 dec	$0679, x
A045: D0 05    bne	$a04c
A047: A9 00    lda #$00
A049: 20 6F A2 jsr	$a26f
A04C: B5 93    lda	$0093, x
A04E: D0 01    bne	$a051
A050: 60       rts
A051: B5 95    lda	$0095, x
A053: F0 0A    beq	$a05f
A055: 38       sec
A056: E9 01    sbc #$01
A058: 95 95    sta	$0095, x
A05A: C9 01    cmp #$01
A05C: F0 01    beq	$a05f
A05E: 60       rts
A05F: 86 20    stx	$0020
A061: 24 0B    bit	$000b
A063: 10 16    bpl	$a07b
A065: 8A       txa
A066: 49 01    eor #$01
A068: AA       tax
A069: B5 8B    lda	$008b, x
A06B: F0 0C    beq	$a079
A06D: 20 FA 9D jsr	$9dfa
A070: 20 C0 9E jsr	$9ec0
A073: 20 8F 9E jsr	clear_player_grid_9E8F
A076: 20 92 9C jsr	$9c92
A079: A6 20    ldx	$0020
A07B: B5 93    lda	$0093, x
A07D: 0A       asl a
A07E: 0A       asl a
A07F: 0A       asl a
A080: 0A       asl a
A081: 85 1F    sta	$001f
A083: 24 0B    bit	$000b
A085: 10 02    bpl	$a089
A087: A2 00    ldx #$00
A089: BD 8C 9E lda	$9e8c, x
A08C: 69 00    adc #$00
A08E: A6 20    ldx	$0020
A090: 85 20    sta	$0020
A092: A9 00    lda #$00
A094: 85 21    sta	$0021
A096: A9 1A    lda #$1a
A098: 38       sec
A099: F5 93    sbc	$0093, x
A09B: C9 08    cmp #$08
A09D: 90 02    bcc	$a0a1
A09F: A9 08    lda #$08
A0A1: 85 22    sta	$0022
A0A3: A0 0C    ldy #$0c
A0A5: B1 1F    lda ($1f), y
A0A7: F0 4E    beq	$a0f7
A0A9: 88       dey
A0AA: D0 F9    bne	$a0a5
A0AC: 98       tya
A0AD: 29 F0    and #$f0
A0AF: A8       tay
A0B0: A9 F1    lda #$f1
A0B2: 91 1F    sta ($1f), y
A0B4: C8       iny
A0B5: C8       iny
A0B6: B5 95    lda	$0095, x
A0B8: D0 24    bne	$a0de
A0BA: A9 0C    lda #$0c
A0BC: 95 95    sta	$0095, x
A0BE: 20 7D A3 jsr	$a37d
A0C1: 20 B3 A3 jsr	$a3b3
A0C4: BD 77 06 lda	$0677, x
A0C7: D0 0D    bne	$a0d6
A0C9: A9 00    lda #$00
A0CB: 9D 79 06 sta	$0679, x
A0CE: A9 2D    lda #$2d
A0D0: 9D 77 06 sta	$0677, x
A0D3: 20 13 A2 jsr	$a213
A0D6: 86 21    stx	$0021
A0D8: 20 3A A4 jsr	$a43a
A0DB: A6 21    ldx	$0021
A0DD: 60       rts
A0DE: 20 47 A3 jsr	$a347
A0E1: A5 08    lda	$0008
A0E3: D0 07    bne	$a0ec
A0E5: 84 21    sty	$0021
A0E7: 20 D0 A6 jsr	$a6d0
A0EA: A4 21    ldy	$0021
A0EC: A5 20    lda	$0020
A0EE: 4A       lsr a
A0EF: A5 1F    lda	$001f
A0F1: 6A       ror a
A0F2: 85 21    sta	$0021
A0F4: 4C 31 A1 jmp	$a131
A0F7: A5 1F    lda	$001f
A0F9: 18       clc
A0FA: 69 10    adc #$10
A0FC: 85 1F    sta	$001f
A0FE: 90 02    bcc	$a102
A100: E6 20    inc	$0020
A102: C6 22    dec	$0022
A104: D0 9D    bne	$a0a3
A106: 8A       txa
A107: 0A       asl a
A108: A8       tay
A109: B9 31 00 lda	$0031, y
A10C: 19 30 00 ora	$0030, y
A10F: C9 30    cmp #$30
A111: D0 0C    bne	$a11f
A113: 8A       txa
A114: D0 06    bne	$a11c
A116: 20 3F B8 jsr	$b83f
A119: B8       clv
A11A: 50 03    bvc	$a11f
A11C: 20 6F B8 jsr	$b86f
A11F: A9 00    lda #$00
A121: 95 93    sta	$0093, x
A123: 95 97    sta	$0097, x
A125: A5 08    lda	$0008
A127: C9 FC    cmp #$fc
A129: D0 03    bne	$a12e
A12B: 20 16 C9 jsr	$c916
A12E: 4C 62 A1 jmp	$a162
A131: A9 00    lda #$00
A133: 95 95    sta	$0095, x
A135: A5 21    lda	$0021
A137: F0 29    beq	$a162
A139: 0A       asl a
A13A: 29 F0    and #$f0
A13C: 85 21    sta	$0021
A13E: 85 1F    sta	$001f
A140: A5 20    lda	$0020
A142: 29 FE    and #$fe
A144: 69 00    adc #$00
A146: 85 20    sta	$0020
A148: 85 22    sta	$0022
A14A: 20 7B A1 jsr	$a17b
A14D: A5 20    lda	$0020
A14F: 4A       lsr a
A150: A5 1F    lda	$001f
A152: 6A       ror a
A153: C9 38    cmp #$38
A155: B0 F3    bcs	$a14a
A157: 86 21    stx	$0021
A159: 20 3A A4 jsr	$a43a
A15C: A6 21    ldx	$0021
A15E: A9 01    lda #$01
A160: 95 97    sta	$0097, x
A162: 24 0B    bit	$000b
A164: 10 14    bpl	$a17a
A166: 8A       txa
A167: 49 01    eor #$01
A169: AA       tax
A16A: B5 8B    lda	$008b, x
A16C: F0 0C    beq	$a17a
A16E: 20 FA 9D jsr	$9dfa
A171: 20 E8 9E jsr	$9ee8
A174: 20 8F 9E jsr	clear_player_grid_9E8F
A177: 20 92 9C jsr	$9c92
A17A: 60       rts
A17B: A5 1F    lda	$001f
A17D: 38       sec
A17E: E9 10    sbc #$10
A180: 85 1F    sta	$001f
A182: B0 02    bcs	$a186
A184: C6 20    dec	$0020
A186: A0 02    ldy #$02
A188: B1 1F    lda ($1f), y
A18A: C8       iny
A18B: 11 1F    ora ($1f), y
A18D: C8       iny
A18E: 11 1F    ora ($1f), y
A190: C8       iny
A191: 11 1F    ora ($1f), y
A193: C8       iny
A194: 11 1F    ora ($1f), y
A196: C8       iny
A197: 11 1F    ora ($1f), y
A199: C8       iny
A19A: 11 1F    ora ($1f), y
A19C: C8       iny
A19D: 11 1F    ora ($1f), y
A19F: C8       iny
A1A0: 11 1F    ora ($1f), y
A1A2: C8       iny
A1A3: 11 1F    ora ($1f), y
A1A5: C8       iny
A1A6: 11 1F    ora ($1f), y
A1A8: C8       iny
A1A9: 11 1F    ora ($1f), y
A1AB: F0 65    beq	$a212
A1AD: C9 F0    cmp #$f0
A1AF: F0 61    beq	$a212
A1B1: A0 00    ldy #$00
A1B3: A9 F1    lda #$f1
A1B5: 91 1F    sta ($1f), y
A1B7: C8       iny
A1B8: B1 1F    lda ($1f), y
A1BA: 91 21    sta ($21), y
A1BC: C8       iny
A1BD: B1 1F    lda ($1f), y
A1BF: 91 21    sta ($21), y
A1C1: C8       iny
A1C2: B1 1F    lda ($1f), y
A1C4: 91 21    sta ($21), y
A1C6: C8       iny
A1C7: B1 1F    lda ($1f), y
A1C9: 91 21    sta ($21), y
A1CB: C8       iny
A1CC: B1 1F    lda ($1f), y
A1CE: 91 21    sta ($21), y
A1D0: C8       iny
A1D1: B1 1F    lda ($1f), y
A1D3: 91 21    sta ($21), y
A1D5: C8       iny
A1D6: B1 1F    lda ($1f), y
A1D8: 91 21    sta ($21), y
A1DA: C8       iny
A1DB: B1 1F    lda ($1f), y
A1DD: 91 21    sta ($21), y
A1DF: C8       iny
A1E0: B1 1F    lda ($1f), y
A1E2: 91 21    sta ($21), y
A1E4: C8       iny
A1E5: B1 1F    lda ($1f), y
A1E7: 91 21    sta ($21), y
A1E9: C8       iny
A1EA: B1 1F    lda ($1f), y
A1EC: 91 21    sta ($21), y
A1EE: C8       iny
A1EF: B1 1F    lda ($1f), y
A1F1: 91 21    sta ($21), y
A1F3: C8       iny
A1F4: B1 1F    lda ($1f), y
A1F6: 91 21    sta ($21), y
A1F8: C8       iny
A1F9: B1 1F    lda ($1f), y
A1FB: 91 21    sta ($21), y
A1FD: C8       iny
A1FE: B1 1F    lda ($1f), y
A200: 91 21    sta ($21), y
A202: A0 02    ldy #$02
A204: 20 47 A3 jsr	$a347
A207: A5 21    lda	$0021
A209: 38       sec
A20A: E9 10    sbc #$10
A20C: 85 21    sta	$0021
A20E: B0 02    bcs	$a212
A210: C6 22    dec	$0022
A212: 60       rts
A213: A9 01    lda #$01
A215: 85 1E    sta	$001e
A217: C6 22    dec	$0022
A219: F0 19    beq	$a234
A21B: A5 1F    lda	$001f
A21D: 18       clc
A21E: 69 10    adc #$10
A220: 85 1F    sta	$001f
A222: 90 02    bcc	$a226
A224: E6 20    inc	$0020
A226: A0 0C    ldy #$0c
A228: B1 1F    lda ($1f), y
A22A: F0 EB    beq	$a217
A22C: 88       dey
A22D: D0 F9    bne	$a228
A22F: E6 1E    inc	$001e
A231: 4C 17 A2 jmp	$a217
A234: A4 1E    ldy	$001e
A236: B9 6B A2 lda	$a26b, y
A239: 9D 77 06 sta	$0677, x
A23C: A5 1E    lda	$001e
A23E: 20 6F A2 jsr	$a26f
A241: A5 1E    lda	$001e
A243: C9 04    cmp #$04
A245: D0 05    bne	$a24c
A247: A9 0F    lda #$0f
A249: 9D 7B 06 sta	$067b, x
A24C: A5 08    lda	$0008
A24E: D0 1A    bne	$a26a
A250: A5 1E    lda	$001e
A252: 38       sec
A253: E9 01    sbc #$01
A255: 29 03    and #$03
A257: 0A       asl a
A258: A8       tay
A259: B9 C0 A2 lda	$a2c0, y
A25C: 85 1B    sta	$001b
A25E: B9 C1 A2 lda	$a2c1, y
A261: 85 1C    sta	$001c
A263: A9 00    lda #$00
A265: 85 1D    sta	$001d
A267: 4C 3F B5 jmp	$b53f
A26A: 60       rts

A26F: 86 1D    stx $1d                                             
A271: 85 1E    sta $1e                                             
A273: 0A       asl a
A274: 0A       asl a
A275: 65 1E    adc	$001e
A277: 0A       asl a
A278: 0A       asl a
A279: 0A       asl a
A27A: AA       tax
A27B: 08       php
A27C: 78       sei
; switch to bank 1
A27D: AD 00 60 lda bank_switch_start_6000
A280: AD 4E 75 lda	$754e
A283: AD B0 60 lda	$60b0
A286: AD 42 75 lda	$7542
A289: AD 43 75 lda	$7543
A28C: AD 56 75 lda	$7556
A28F: AD B0 60 lda	$60b0
A292: 28       plp
A293: A5 1D    lda	$001d
A295: 0A       asl a
A296: A8       tay
A297: B9 C8 A2 lda	$a2c8, y
A29A: 85 02    sta	$0002
A29C: B9 C9 A2 lda	$a2c9, y
A29F: 85 03    sta	$0003
A2A1: A0 00    ldy #$00
A2A3: BD 7D 65 lda	$657d, x
A2A6: 91 02    sta ($02), y
A2A8: E8       inx
A2A9: C8       iny
A2AA: C0 14    cpy #$14
A2AC: D0 0B    bne	$a2b9
A2AE: A5 02    lda	$0002
A2B0: 18       clc
A2B1: 69 6C    adc #$6c
A2B3: 85 02    sta	$0002
A2B5: 90 02    bcc	$a2b9
A2B7: E6 03    inc	$0003
A2B9: C0 28    cpy #$28
A2BB: 90 E6    bcc	$a2a3
A2BD: A6 1D    ldx	$001d
A2BF: 60       rts

; entrypoint?

A2CC: 94 1C    sty	$001c, x
A2CE: C4 1C    cpy	$001c
A2D0: 86 1D    stx	$001d
A2D2: A5 1D    lda	$001d
A2D4: 0A       asl a
A2D5: A8       tay
A2D6: B9 CC A2 lda	$a2cc, y
A2D9: 85 02    sta	$0002
A2DB: B9 CD A2 lda	$a2cd, y
A2DE: 85 03    sta	$0003
A2E0: 08       php
A2E1: 78       sei
; switch to bank 1
A2E2: AD 00 60 lda bank_switch_start_6000
A2E5: AD 42 75 lda	$7542
A2E8: AD 80 60 lda	$6080
A2EB: AD 40 75 lda	$7540
A2EE: AD 56 75 lda	$7556
A2F1: AD B0 60 lda	$60b0
A2F4: 28       plp
A2F5: A9 00    lda #$00
A2F7: 85 1E    sta	$001e
A2F9: A9 03    lda #$03
A2FB: 85 1F    sta	$001f
A2FD: BD 8D 06 lda	$068d, x
A300: 29 0F    and #$0f
A302: 85 20    sta	$0020
A304: F0 04    beq	$a30a
A306: A9 01    lda #$01
A308: 85 1E    sta	$001e
A30A: A5 1E    lda	$001e
A30C: F0 29    beq	$a337
A30E: A5 20    lda	$0020
A310: 0A       asl a
A311: 0A       asl a
A312: 85 20    sta	$0020
A314: A8       tay
A315: B9 3D 65 lda	$653d, y
A318: A0 00    ldy #$00
A31A: 91 02    sta ($02), y
A31C: A4 20    ldy	$0020
A31E: B9 3E 65 lda	$653e, y
A321: A0 01    ldy #$01
A323: 91 02    sta ($02), y
A325: A4 20    ldy	$0020
A327: B9 3F 65 lda	$653f, y
A32A: A0 80    ldy #$80
A32C: 91 02    sta ($02), y
A32E: A4 20    ldy	$0020
A330: B9 40 65 lda	$6540, y
A333: A0 81    ldy #$81
A335: 91 02    sta ($02), y
A337: A5 02    lda	$0002
A339: 18       clc
A33A: 69 02    adc #$02
A33C: 85 02    sta	$0002
A33E: E8       inx
A33F: E8       inx
A340: C6 1F    dec	$001f
A342: 10 B9    bpl	$a2fd
A344: A6 1D    ldx	$001d
A346: 60       rts
A347: A9 F0    lda #$f0
A349: 24 0B    bit	$000b
A34B: 10 02    bpl	$a34f
A34D: A9 00    lda #$00
A34F: 91 1F    sta ($1f), y
A351: C8       iny
A352: A9 00    lda #$00
A354: 91 1F    sta ($1f), y
A356: C8       iny
A357: 91 1F    sta ($1f), y
A359: C8       iny
A35A: 91 1F    sta ($1f), y
A35C: C8       iny
A35D: 91 1F    sta ($1f), y
A35F: C8       iny
A360: 91 1F    sta ($1f), y
A362: C8       iny
A363: 91 1F    sta ($1f), y
A365: C8       iny
A366: 91 1F    sta ($1f), y
A368: C8       iny
A369: 91 1F    sta ($1f), y
A36B: C8       iny
A36C: 91 1F    sta ($1f), y
A36E: C8       iny
A36F: 91 1F    sta ($1f), y
A371: A9 F0    lda #$f0
A373: 24 0B    bit	$000b
A375: 10 02    bpl	$a379
A377: A9 00    lda #$00
A379: C8       iny
A37A: 91 1F    sta ($1f), y
A37C: 60       rts
A37D: A9 F0    lda #$f0
A37F: 24 0B    bit	$000b
A381: 10 02    bpl	$a385
A383: A9 08    lda #$08
A385: 91 1F    sta ($1f), y
A387: C8       iny
A388: A9 08    lda #$08
A38A: 91 1F    sta ($1f), y
A38C: C8       iny
A38D: 91 1F    sta ($1f), y
A38F: C8       iny
A390: 91 1F    sta ($1f), y
A392: C8       iny
A393: 91 1F    sta ($1f), y
A395: C8       iny
A396: 91 1F    sta ($1f), y
A398: C8       iny
A399: 91 1F    sta ($1f), y
A39B: C8       iny
A39C: 91 1F    sta ($1f), y
A39E: C8       iny
A39F: 91 1F    sta ($1f), y
A3A1: C8       iny
A3A2: 91 1F    sta ($1f), y
A3A4: C8       iny
A3A5: 91 1F    sta ($1f), y
A3A7: A9 F0    lda #$f0
A3A9: 24 0B    bit	$000b
A3AB: 10 02    bpl	$a3af
A3AD: A9 08    lda #$08
A3AF: C8       iny
A3B0: 91 1F    sta ($1f), y
A3B2: 60       rts
A3B3: 8A       txa
A3B4: 48       pha
A3B5: A5 1F    lda	$001f
A3B7: 18       clc
A3B8: 69 10    adc #$10
A3BA: 85 1D    sta	$001d
A3BC: A5 20    lda	$0020
A3BE: 69 00    adc #$00
A3C0: 85 1E    sta	$001e
A3C2: A0 00    ldy #$00
A3C4: A9 F1    lda #$f1
A3C6: 91 1D    sta ($1d), y
A3C8: C8       iny
A3C9: B1 1D    lda ($1d), y
A3CB: AA       tax
A3CC: 29 F0    and #$f0
A3CE: 85 1B    sta	$001b
A3D0: F0 0F    beq	$a3e1
A3D2: 8A       txa
A3D3: C9 80    cmp #$80
A3D5: B0 0A    bcs	$a3e1
A3D7: 29 0F    and #$0f
A3D9: AA       tax
A3DA: BD 1A A4 lda	$a41a, x
A3DD: 05 1B    ora	$001b
A3DF: 91 1D    sta ($1d), y
A3E1: C8       iny
A3E2: C0 10    cpy #$10
A3E4: 90 E3    bcc	$a3c9
A3E6: A5 1F    lda	$001f
A3E8: 38       sec
A3E9: E9 10    sbc #$10
A3EB: 85 1D    sta	$001d
A3ED: A5 20    lda	$0020
A3EF: E9 00    sbc #$00
A3F1: 85 1E    sta	$001e
A3F3: A0 00    ldy #$00
A3F5: A9 F1    lda #$f1
A3F7: 91 1D    sta ($1d), y
A3F9: C8       iny
A3FA: B1 1D    lda ($1d), y
A3FC: AA       tax
A3FD: 29 F0    and #$f0
A3FF: 85 1B    sta	$001b
A401: F0 0F    beq	$a412
A403: 8A       txa
A404: C9 80    cmp #$80
A406: B0 0A    bcs	$a412
A408: 29 0F    and #$0f
A40A: AA       tax
A40B: BD 2A A4 lda	$a42a, x
A40E: 05 1B    ora	$001b
A410: 91 1D    sta ($1d), y
A412: C8       iny
A413: C0 10    cpy #$10
A415: 90 E3    bcc	$a3fa
A417: 68       pla
A418: AA       tax
A419: 60       rts

A43A: A9 00    lda #$00
A43C: 85 1F    sta	$001f
A43E: A5 20    lda	$0020
A440: 29 FE    and #$fe
A442: 85 20    sta	$0020
A444: 24 0B    bit	$000b
A446: 10 02    bpl	$a44a
A448: A2 02    ldx #$02
A44A: BD 86 9E lda	$9e86, x
A44D: 85 9D    sta	$009d
A44F: BD 89 9E lda	$9e89, x
A452: 85 9E    sta	$009e
A454: A0 60    ldy #$60
A456: B1 1F    lda ($1f), y
A458: C9 F1    cmp #$f1
A45A: D0 1F    bne	$a47b
A45C: A9 F0    lda #$f0
A45E: 91 1F    sta ($1f), y
A460: 84 1E    sty	$001e
A462: 20 8E 9D jsr	$9d8e
A465: A4 1E    ldy	$001e
A467: A9 00    lda #$00
A469: 85 00    sta	$0000
A46B: A9 01    lda #$01
A46D: 85 01    sta	$0001
A46F: A5 9D    lda	$009d
A471: 85 02    sta	$0002
A473: A5 9E    lda	$009e
A475: 85 03    sta	$0003
A477: 8A       txa
A478: 20 33 D6 jsr	$d633
A47B: A5 9D    lda	$009d
A47D: 18       clc
A47E: 69 80    adc #$80
A480: 85 9D    sta	$009d
A482: A5 9E    lda	$009e
A484: 69 00    adc #$00
A486: 85 9E    sta	$009e
A488: 98       tya
A489: 18       clc
A48A: 69 10    adc #$10
A48C: A8       tay
A48D: 90 02    bcc	$a491
A48F: E6 20    inc	$0020
A491: A5 20    lda	$0020
A493: 4A       lsr a
A494: 98       tya
A495: 6A       ror a
A496: C9 D0    cmp #$d0
A498: 90 BC    bcc	$a456
A49A: 60       rts
A49B: A4 08    ldy	$0008
A49D: C0 F8    cpy #$f8
A49F: D0 1E    bne	$a4bf
A4A1: 20 52 D5 jsr	$d552
A4A4: 20 28 C2 jsr	$c228
A4A7: C9 00    cmp #$00
A4A9: F0 03    beq	$a4ae
A4AB: 4C C0 A4 jmp	$a4c0
A4AE: A5 0F    lda	$000f
A4B0: 29 01    and #$01
A4B2: D0 0B    bne	$a4bf
A4B4: CE 6E 06 dec	$066e
A4B7: AD 6E 06 lda	$066e
A4BA: D0 03    bne	$a4bf
A4BC: 4C C0 A4 jmp	$a4c0
A4BF: 60       rts
A4C0: 4C 62 CA jmp	$ca62
A4C3: 20 D3 BC jsr	$bcd3
A4C6: 8A       txa
A4C7: 18       clc
A4C8: 69 4A    adc #$4a
A4CA: 20 70 D6 jsr	$d670
A4CD: 20 F4 AF jsr	$aff4
A4D0: A9 3B    lda #$3b
A4D2: 86 1B    stx	$001b
A4D4: 18       clc
A4D5: 65 1B    adc	$001b
A4D7: 20 70 D6 jsr	$d670
A4DA: AD 18 06 lda	$0618
A4DD: 85 50    sta	$0050
A4DF: 60       rts
A4E0: A2 00    ldx #$00
A4E2: 8E 50 06 stx	$0650
A4E5: A5 0F    lda	$000f
A4E7: 29 3F    and #$3f
A4E9: D0 03    bne	$a4ee
A4EB: 20 2D A5 jsr	$a52d
A4EE: AE 50 06 ldx	$0650
A4F1: B5 4E    lda	$004e, x
A4F3: F0 32    beq	$a527
A4F5: AD 18 06 lda	$0618
A4F8: C5 50    cmp	$0050
A4FA: F0 19    beq	$a515
A4FC: 85 50    sta	$0050
A4FE: B5 4E    lda	$004e, x
A500: C9 09    cmp #$09
A502: 90 03    bcc	$a507
A504: 20 C3 A4 jsr	$a4c3
A507: A0 09    ldy #$09
A509: A5 4E    lda	$004e
A50B: F0 02    beq	$a50f
A50D: 84 4E    sty	$004e
A50F: A5 4F    lda	$004f
A511: F0 02    beq	$a515
A513: 84 4F    sty	$004f
A515: AD C1 00 lda number_of_credits_00c1
A518: F0 0D    beq	$a527
A51A: B5 4E    lda	$004e, x
A51C: C9 0A    cmp #$0a
A51E: B0 07    bcs	$a527
A520: 8A       txa
A521: 18       clc
A522: 69 3D    adc #$3d
A524: 20 70 D6 jsr	$d670
A527: E8       inx
A528: E0 02    cpx #$02
A52A: 90 B6    bcc	$a4e2
A52C: 60       rts
A52D: B4 4E    ldy	$004e, x
A52F: C0 01    cpy #$01
A531: 90 79    bcc	$a5ac
A533: 88       dey
A534: 94 4E    sty	$004e, x
A536: 8E 4D 06 stx	$064d
A539: C0 09    cpy #$09
A53B: D0 03    bne	$a540
A53D: 20 C3 A4 jsr	$a4c3
A540: AE 4D 06 ldx	$064d
A543: B5 4E    lda	$004e, x
A545: C9 0A    cmp #$0a
A547: B0 63    bcs	$a5ac
A549: E0 00    cpx #$00
A54B: D0 04    bne	$a551
A54D: A9 92    lda #$92
A54F: D0 02    bne	$a553
A551: A9 C2    lda #$c2
A553: 85 02    sta	$0002
A555: A9 1B    lda #$1b
A557: 85 03    sta	$0003
A559: A0 00    ldy #$00
A55B: 18       clc
A55C: B5 4E    lda	$004e, x
A55E: 69 30    adc #$30
A560: 91 02    sta ($02), y
A562: C8       iny
A563: A9 90    lda #$90
A565: 91 02    sta ($02), y
A567: 8A       txa
A568: 18       clc
A569: 69 3B    adc #$3b
A56B: 20 70 D6 jsr	$d670
A56E: B5 4E    lda	$004e, x
A570: D0 3A    bne	$a5ac
A572: 18       clc
A573: 8A       txa
A574: 69 4A    adc #$4a
A576: 20 70 D6 jsr	$d670
A579: 20 D3 BC jsr	$bcd3
A57C: 20 F4 AF jsr	$aff4
A57F: 20 15 EA jsr	$ea15
A582: BD 63 06 lda	$0663, x
A585: 30 03    bmi	$a58a
A587: 20 7E E7 jsr	$e77e
A58A: A5 77    lda	$0077
A58C: 05 78    ora	$0078
A58E: D0 1C    bne	$a5ac
A590: A5 4E    lda	$004e
A592: 05 4F    ora	$004f
A594: D0 16    bne	$a5ac
A596: AD 63 06 lda	$0663
A599: 2D 64 06 and	$0664
A59C: 10 0E    bpl	$a5ac
A59E: A9 00    lda #$00
A5A0: 8D 6D 06 sta	$066d
A5A3: 8D C2 00 sta number_of_coins_inserted_00c2
A5A6: 8D C3 00 sta	$00c3
A5A9: 4C AD A5 jmp	$a5ad
A5AC: 60       rts
A5AD: AD 6D 06 lda	$066d
A5B0: D0 06    bne	$a5b8
A5B2: 20 1B F1 jsr	$f11b
A5B5: B8       clv
A5B6: 50 22    bvc	$a5da
A5B8: A9 20    lda #$20
A5BA: 8D 5B 06 sta	$065b
A5BD: 8D 5C 06 sta	$065c
A5C0: 8D 5D 06 sta	$065d
A5C3: 8D 5E 06 sta	$065e
A5C6: 8D 5F 06 sta	$065f
A5C9: 8D 60 06 sta	$0660
A5CC: 8D 61 06 sta	$0661
A5CF: 8D 62 06 sta	$0662
A5D2: A9 80    lda #$80
A5D4: 8D 63 06 sta	$0663
A5D7: 8D 64 06 sta	$0664
A5DA: AD 6D 06 lda	$066d
A5DD: 18       clc
A5DE: 69 01    adc #$01
A5E0: 29 03    and #$03
A5E2: 8D 6D 06 sta	$066d
A5E5: A9 07    lda #$07
A5E7: 85 07    sta	$0007
A5E9: A9 0A    lda #$0a
A5EB: 20 18 88 jsr display_screen_and_other_stuff_8818
A5EE: A9 F8    lda #$f8
A5F0: 85 08    sta	$0008
A5F2: A9 9C    lda #$9c
A5F4: 85 02    sta	$0002
A5F6: A9 15    lda #$15
A5F8: 85 03    sta	$0003
A5FA: A9 96    lda #$96
A5FC: 8D 6E 06 sta	$066e
A5FF: A9 31    lda #$31
A601: 85 1F    sta	$001f
A603: A9 30    lda #$30
A605: 85 20    sta	$0020
A607: A2 00    ldx #$00
A609: A9 B0    lda #$b0
A60B: 85 05    sta	$0005
A60D: 8A       txa
A60E: 4A       lsr a
A60F: 85 1D    sta	$001d
A611: AD 63 06 lda	$0663
A614: 10 0E    bpl	$a624
A616: C9 80    cmp #$80
A618: F0 0A    beq	$a624
A61A: 49 FF    eor #$ff
A61C: C5 1D    cmp	$001d
A61E: D0 04    bne	$a624
A620: A9 E0    lda #$e0
A622: 85 05    sta	$0005
A624: AD 64 06 lda	$0664
A627: 10 0E    bpl	$a637
A629: C9 80    cmp #$80
A62B: F0 0A    beq	$a637
A62D: 49 FF    eor #$ff
A62F: C5 1D    cmp	$001d
A631: D0 04    bne	$a637
A633: A9 F0    lda #$f0
A635: 85 05    sta	$0005
A637: 20 A7 A6 jsr	$a6a7
A63A: A9 00    lda #$00
A63C: 85 1D    sta	$001d
A63E: A9 05    lda #$05
A640: 85 1E    sta	$001e
A642: BD 79 09 lda	$0979, x
A645: C9 30    cmp #$30
A647: F0 04    beq	$a64d
A649: C6 1D    dec	$001d
A64B: 30 0A    bmi	$a657
A64D: 24 1D    bit	$001d
A64F: 30 06    bmi	$a657
A651: C0 12    cpy #$12
A653: B0 02    bcs	$a657
A655: A9 00    lda #$00
A657: 91 02    sta ($02), y
A659: C8       iny
A65A: A5 05    lda	$0005
A65C: 91 02    sta ($02), y
A65E: C8       iny
A65F: E8       inx
A660: C6 1E    dec	$001e
A662: 10 DE    bpl	$a642
A664: C8       iny
A665: C8       iny
A666: 8A       txa
A667: 4A       lsr a
A668: 38       sec
A669: E9 03    sbc #$03
A66B: AA       tax
A66C: A9 02    lda #$02
A66E: 85 1E    sta	$001e
A670: BD D9 09 lda	$09d9, x
A673: 91 02    sta ($02), y
A675: C8       iny
A676: A5 05    lda	$0005
A678: 91 02    sta ($02), y
A67A: C8       iny
A67B: E8       inx
A67C: C6 1E    dec	$001e
A67E: 10 F0    bpl	$a670
A680: 8A       txa
A681: 0A       asl a
A682: AA       tax
A683: A5 02    lda	$0002
A685: 18       clc
A686: 69 80    adc #$80
A688: 85 02    sta	$0002
A68A: A5 03    lda	$0003
A68C: 69 00    adc #$00
A68E: 85 03    sta	$0003
A690: A5 1F    lda	$001f
A692: 18       clc
A693: 69 01    adc #$01
A695: C9 3A    cmp #$3a
A697: 90 04    bcc	$a69d
A699: E6 20    inc	$0020
A69B: A9 30    lda #$30
A69D: 85 1F    sta	$001f
A69F: E0 60    cpx #$60
A6A1: B0 03    bcs	$a6a6
A6A3: 4C 09 A6 jmp	$a609
A6A6: 60       rts
A6A7: A0 00    ldy #$00
A6A9: A5 20    lda	$0020
A6AB: C9 30    cmp #$30
A6AD: D0 02    bne	$a6b1
A6AF: A9 00    lda #$00
A6B1: 91 02    sta ($02), y
A6B3: C8       iny
A6B4: A5 05    lda	$0005
A6B6: 91 02    sta ($02), y
A6B8: C8       iny
A6B9: A5 1F    lda	$001f
A6BB: 91 02    sta ($02), y
A6BD: C8       iny
A6BE: A5 05    lda	$0005
A6C0: 91 02    sta ($02), y
A6C2: C8       iny
A6C3: A9 2E    lda #$2e
A6C5: 91 02    sta ($02), y
A6C7: C8       iny
A6C8: A5 05    lda	$0005
A6CA: 91 02    sta ($02), y
A6CC: C8       iny
A6CD: C8       iny
A6CE: C8       iny
A6CF: 60       rts
A6D0: 20 C9 A7 jsr	$a7c9
A6D3: A9 30    lda #$30
A6D5: 85 1B    sta	$001b
A6D7: A9 01    lda #$01
A6D9: 95 7B    sta	$007b, x
A6DB: 8A       txa
A6DC: 0A       asl a
A6DD: 0A       asl a
A6DE: A8       tay
A6DF: B9 0F 06 lda	$060f, y
A6E2: 18       clc
A6E3: 69 01    adc #$01
A6E5: C9 3A    cmp #$3a
A6E7: 90 03    bcc	$a6ec
A6E9: E9 0A    sbc #$0a
A6EB: 38       sec
A6EC: 99 0F 06 sta	$060f, y
A6EF: B9 0E 06 lda	$060e, y
A6F2: 69 00    adc #$00
A6F4: C9 3A    cmp #$3a
A6F6: 90 03    bcc	$a6fb
A6F8: E9 0A    sbc #$0a
A6FA: 38       sec
A6FB: 99 0E 06 sta	$060e, y
A6FE: B9 0D 06 lda	$060d, y
A701: 69 00    adc #$00
A703: C9 3A    cmp #$3a
A705: 90 03    bcc	$a70a
A707: E9 0A    sbc #$0a
A709: 38       sec
A70A: 99 0D 06 sta	$060d, y
A70D: B9 0C 06 lda	$060c, y
A710: 69 00    adc #$00
A712: C9 3A    cmp #$3a
A714: 90 02    bcc	$a718
A716: A9 39    lda #$39
A718: 99 0C 06 sta	$060c, y
A71B: 98       tya
A71C: 4A       lsr a
A71D: A8       tay
A71E: 84 1B    sty	$001b
A720: A9 0F    lda #$0f
A722: 20 AD A7 jsr	$a7ad
A725: BD 49 06 lda	$0649, x
A728: CD AF 06 cmp	$06af
A72B: 90 05    bcc	$a732
A72D: A9 0F    lda #$0f
A72F: 99 15 06 sta	$0615, y
A732: B9 15 06 lda	$0615, y
A735: 8D B0 06 sta	$06b0
A738: C9 0F    cmp #$0f
A73A: B0 2C    bcs	$a768
A73C: BD 49 06 lda	$0649, x
A73F: 18       clc
A740: 69 01    adc #$01
A742: C9 78    cmp #$78
A744: 90 02    bcc	$a748
A746: A9 78    lda #$78
A748: 9D 49 06 sta	$0649, x
A74B: A0 00    ldy #$00
A74D: 98       tya
A74E: 20 AD A7 jsr	$a7ad
A751: BD 49 06 lda	$0649, x
A754: CD AF 06 cmp	$06af
A757: D0 0A    bne	$a763
A759: 84 1E    sty	$001e
A75B: 98       tya
A75C: A4 1B    ldy	$001b
A75E: 99 15 06 sta	$0615, y
A761: A4 1E    ldy	$001e
A763: C8       iny
A764: C0 10    cpy #$10
A766: 90 E5    bcc	$a74d
A768: A9 16    lda #$16
A76A: 4C 59 E6 jmp	$e659

A7AD: 8D 4D 06 sta $064d                                           
A7B0: 98       tya                                                 
A7B1: 48       pha
A7B2: AD BB 08 lda	$08bb
A7B5: 29 03    and #$03
A7B7: 0A       asl a
A7B8: 0A       asl a
A7B9: 0A       asl a
A7BA: 0A       asl a
A7BB: 18       clc
A7BC: 6D 4D 06 adc	$064d
A7BF: A8       tay
A7C0: B9 6D A7 lda	$a76d, y
A7C3: 8D AF 06 sta	$06af
A7C6: 68       pla
A7C7: A8       tay
A7C8: 60       rts
A7C9: BD 9B 06 lda	$069b, x
A7CC: F0 01    beq	$a7cf
A7CE: 60       rts
A7CF: 8A       txa
A7D0: 4A       lsr a
A7D1: B0 04    bcs	$a7d7
A7D3: A9 C0    lda #$c0
A7D5: D0 02    bne	$a7d9
A7D7: A9 D0    lda #$d0
A7D9: 85 05    sta	$0005
A7DB: 8A       txa
A7DC: 0A       asl a
A7DD: A8       tay
A7DE: B9 31 00 lda	$0031, y
A7E1: C9 30    cmp #$30
A7E3: D0 15    bne	$a7fa
A7E5: B9 30 00 lda	$0030, y
A7E8: C9 30    cmp #$30
A7EA: F0 0B    beq	$a7f7
A7EC: 38       sec
A7ED: E9 01    sbc #$01
A7EF: 99 30 00 sta	$0030, y
A7F2: A9 39    lda #$39
A7F4: 99 31 00 sta	$0031, y
A7F7: B8       clv
A7F8: 50 06    bvc	$a800
A7FA: 38       sec
A7FB: E9 01    sbc #$01
A7FD: 99 31 00 sta	$0031, y
A800: B5 77    lda	$0077, x
A802: D0 01    bne	$a805
A804: 60       rts
A805: E0 00    cpx #$00
A807: D0 05    bne	$a80e
A809: A9 E0    lda #$e0
A80B: B8       clv
A80C: 50 02    bvc	$a810
A80E: A9 F0    lda #$f0
A810: 85 05    sta	$0005
A812: 8A       txa
A813: 0A       asl a
A814: A8       tay
A815: 85 34    sta	$0034
A817: 0A       asl a
A818: 65 34    adc	$0034
A81A: 85 34    sta	$0034
A81C: 06 34    asl	$0034
A81E: 18       clc
A81F: A9 22    lda #$22
A821: 65 34    adc	$0034
A823: 85 02    sta	$0002
A825: A9 17    lda #$17
A827: 85 03    sta	$0003
A829: B9 30 00 lda	$0030, y
A82C: 20 4A D6 jsr	$d64a
A82F: A9 24    lda #$24
A831: 65 34    adc	$0034
A833: 85 02    sta	$0002
A835: B9 31 00 lda	$0031, y
A838: 20 4A D6 jsr	$d64a
A83B: B9 30 00 lda	$0030, y
A83E: C9 30    cmp #$30
A840: D0 21    bne	$a863
A842: B9 31 00 lda	$0031, y
A845: C9 36    cmp #$36
A847: B0 1A    bcs	$a863
A849: 38       sec
A84A: E9 30    sbc #$30
A84C: E0 00    cpx #$00
A84E: D0 0B    bne	$a85b
A850: 8D 70 06 sta	$0670
A853: A9 1E    lda #$1e
A855: 8D 71 06 sta	$0671
A858: B8       clv
A859: 50 08    bvc	$a863
A85B: 8D 72 06 sta	$0672
A85E: A9 1E    lda #$1e
A860: 8D 73 06 sta	$0673
A863: 60       rts
A864: A9 FC    lda #$fc
A866: 85 08    sta	$0008
A868: A9 00    lda #$00
A86A: 85 0B    sta	$000b
A86C: 85 45    sta	$0045
A86E: A9 0F    lda #$0f
A870: 85 2F    sta	$002f
A872: A9 30    lda #$30
A874: 8D 57 06 sta	$0657
A877: A9 31    lda #$31
A879: 8D 58 06 sta	$0658
A87C: A9 01    lda #$01
A87E: 20 59 E6 jsr	$e659
A881: 20 4B AA jsr	$aa4b
A884: A9 09    lda #$09
A886: 8D 15 06 sta	$0615
A889: A9 0A    lda #$0a
A88B: 8D 81 06 sta	$0681
A88E: 60       rts
A88F: A9 F0    lda #$f0
A891: 85 08    sta	$0008
A893: A9 00    lda #$00
A895: 85 0B    sta	$000b
A897: A9 01    lda #$01
A899: 20 59 E6 jsr	$e659
A89C: A9 03    lda #$03
A89E: 85 07    sta	$0007
A8A0: A5 45    lda	$0045
A8A2: 0A       asl a
A8A3: 20 18 88 jsr display_screen_and_other_stuff_8818
A8A6: A9 00    lda #$00
A8A8: AA       tax
A8A9: A9 01    lda #$01
A8AB: 85 77    sta	$0077
A8AD: A9 1E    lda #$1e
A8AF: 85 2F    sta	$002f
A8B1: 20 AD AD jsr	$adad
A8B4: A9 03    lda #$03
A8B6: 85 8F    sta	$008f
A8B8: A9 00    lda #$00
A8BA: 85 77    sta	$0077
A8BC: 8D 7F 06 sta	$067f
A8BF: A9 08    lda #$08
A8C1: 85 87    sta	$0087
A8C3: A9 07    lda #$07
A8C5: 85 89    sta	$0089
A8C7: A9 02    lda #$02
A8C9: 85 8B    sta	$008b
A8CB: 8D 7E 06 sta	$067e
A8CE: A9 37    lda #$37
A8D0: 20 70 D6 jsr	$d670
A8D3: A9 09    lda #$09
A8D5: 20 70 D6 jsr	$d670
A8D8: A9 01    lda #$01
A8DA: 85 79    sta	$0079
A8DC: 85 7B    sta	$007b
A8DE: 85 80    sta	$0080
A8E0: 85 78    sta	$0078
A8E2: 20 05 B6 jsr	$b605
A8E5: 20 16 BC jsr	$bc16
A8E8: 60       rts
A8E9: A4 46    ldy	$0046
A8EB: F0 03    beq	$a8f0
A8ED: 4C 45 A9 jmp	$a945
A8F0: A5 0B    lda	$000b
A8F2: 8D 4F 06 sta	$064f
A8F5: A9 EC    lda #$ec
A8F7: 85 08    sta	$0008
A8F9: A9 00    lda #$00
A8FB: 8D 50 06 sta	$0650
A8FE: 8D 55 06 sta	$0655
A901: 8D 56 06 sta	$0656
A904: 85 0B    sta	$000b
A906: A9 03    lda #$03
A908: 85 07    sta	$0007
A90A: A5 45    lda	$0045
A90C: 0A       asl a
A90D: 20 18 88 jsr display_screen_and_other_stuff_8818
A910: A9 00    lda #$00
A912: AA       tax
A913: A9 01    lda #$01
A915: 85 77    sta	$0077
A917: A9 1E    lda #$1e
A919: 85 2F    sta	$002f
A91B: 20 AD AD jsr	$adad
A91E: A9 00    lda #$00
A920: 85 77    sta	$0077
A922: A9 02    lda #$02
A924: 85 8F    sta	$008f
A926: 8D 7F 06 sta	$067f
A929: A9 11    lda #$11
A92B: 85 87    sta	$0087
A92D: A9 08    lda #$08
A92F: 85 89    sta	$0089
A931: A9 02    lda #$02
A933: 85 8B    sta	$008b
A935: 8D 7E 06 sta	$067e
A938: A9 37    lda #$37
A93A: 20 70 D6 jsr	$d670
A93D: A9 01    lda #$01
A93F: 85 78    sta	$0078
A941: 20 16 BC jsr	$bc16
A944: 60       rts
A945: A9 00    lda #$00
A947: 85 08    sta	$0008
A949: 85 44    sta	$0044
A94B: 8D 4B 06 sta	$064b
A94E: A4 46    ldy	$0046
A950: 8C A7 06 sty	$06a7
A953: B9 31 AB lda	$ab31, y
A956: 85 2F    sta	$002f
A958: 18       clc
A959: 69 31    adc #$31
A95B: 8D 58 06 sta	$0658
A95E: A9 30    lda #$30
A960: 8D 57 06 sta	$0657
A963: A5 46    lda	$0046
A965: 85 45    sta	$0045
A967: A2 05    ldx #$05
A969: A9 30    lda #$30
A96B: 9D 00 06 sta	$0600, x
A96E: 9D 06 06 sta	$0606, x
A971: 9D 0C 06 sta	$060c, x
A974: 9D 12 06 sta	$0612, x
A977: CA       dex
A978: 10 F1    bpl	$a96b
A97A: A9 00    lda #$00
A97C: 8D 14 06 sta	$0614
A97F: 8D 16 06 sta	$0616
A982: 8D 15 06 sta	$0615
A985: 8D 17 06 sta	$0617
A988: 8D 49 06 sta	$0649
A98B: 8D 4A 06 sta	$064a
A98E: 20 4B AA jsr	$aa4b
A991: 20 9C B6 jsr	$b69c
A994: A5 77    lda	$0077
A996: F0 05    beq	$a99d
A998: A2 00    ldx #$00
A99A: 20 AB A9 jsr	$a9ab
A99D: A5 78    lda	$0078
A99F: F0 05    beq	$a9a6
A9A1: A2 01    ldx #$01
A9A3: 20 AB A9 jsr	$a9ab
A9A6: A9 F7    lda #$f7
A9A8: 85 08    sta	$0008
A9AA: 60       rts
A9AB: A5 2F    lda	$002f
A9AD: C9 03    cmp #$03
A9AF: 90 20    bcc	$a9d1
A9B1: A0 32    ldy #$32
A9B3: A9 0A    lda #$0a
A9B5: 9D 49 06 sta	$0649, x
A9B8: 95 79    sta	$0079, x
A9BA: E0 00    cpx #$00
A9BC: D0 0B    bne	$a9c9
A9BE: 8C 01 06 sty	$0601
A9C1: A9 02    lda #$02
A9C3: 8D 15 06 sta	$0615
A9C6: B8       clv
A9C7: 50 08    bvc	$a9d1
A9C9: 8C 07 06 sty	$0607
A9CC: A9 02    lda #$02
A9CE: 8D 17 06 sta	$0617
A9D1: A5 2F    lda	$002f
A9D3: C9 06    cmp #$06
A9D5: 90 20    bcc	$a9f7
A9D7: A0 34    ldy #$34
A9D9: A9 14    lda #$14
A9DB: 9D 49 06 sta	$0649, x
A9DE: 95 79    sta	$0079, x
A9E0: E0 00    cpx #$00
A9E2: D0 0B    bne	$a9ef
A9E4: 8C 01 06 sty	$0601
A9E7: A9 04    lda #$04
A9E9: 8D 15 06 sta	$0615
A9EC: B8       clv
A9ED: 50 08    bvc	$a9f7
A9EF: 8C 07 06 sty	$0607
A9F2: A9 04    lda #$04
A9F4: 8D 17 06 sta	$0617
A9F7: 8E 4E 06 stx	$064e
A9FA: 20 05 B6 jsr	$b605
A9FD: AE 4E 06 ldx	$064e
AA00: 60       rts
AA01: E0 00    cpx #$00
AA03: D0 24    bne	$aa29
AA05: AD 15 06 lda	$0615
AA08: C9 03    cmp #$03
AA0A: 90 0C    bcc	$aa18
AA0C: 38       sec
AA0D: E9 02    sbc #$02
AA0F: C9 08    cmp #$08
AA11: 90 02    bcc	$aa15
AA13: A9 08    lda #$08
AA15: B8       clv
AA16: 50 02    bvc	$aa1a
AA18: A9 00    lda #$00
AA1A: 8D 15 06 sta	$0615
AA1D: 20 AD A7 jsr	$a7ad
AA20: AD AF 06 lda	$06af
AA23: 8D 49 06 sta	$0649
AA26: B8       clv
AA27: 50 21    bvc	$aa4a
AA29: AD 17 06 lda	$0617
AA2C: C9 03    cmp #$03
AA2E: 90 0C    bcc	$aa3c
AA30: 38       sec
AA31: E9 02    sbc #$02
AA33: C9 08    cmp #$08
AA35: 90 02    bcc	$aa39
AA37: A9 08    lda #$08
AA39: B8       clv
AA3A: 50 02    bvc	$aa3e
AA3C: A9 00    lda #$00
AA3E: 8D 17 06 sta	$0617
AA41: 20 AD A7 jsr	$a7ad
AA44: AD AF 06 lda	$06af
AA47: 8D 4A 06 sta	$064a
AA4A: 60       rts
AA4B: A5 45    lda	$0045
AA4D: 18       clc
AA4E: 69 03    adc #$03
AA50: 85 07    sta	$0007
AA52: 20 C0 AB jsr	$abc0
AA55: 78       sei
AA56: A9 00    lda #$00
AA58: 8D C7 06 sta	$06c7
AA5B: 8D C8 06 sta	$06c8
AA5E: 8D C9 06 sta	$06c9
AA61: 8D CA 06 sta	$06ca
AA64: 58       cli
AA65: A2 78    ldx #$78
AA67: 95 00    sta	$0000, x
AA69: E8       inx
AA6A: E0 AC    cpx #$ac
AA6C: D0 F9    bne	$aa67
AA6E: A9 01    lda #$01
AA70: 85 77    sta	$0077
AA72: 85 79    sta	$0079
AA74: 85 7B    sta	$007b
AA76: A6 0B    ldx	$000b
AA78: F0 06    beq	$aa80
AA7A: 85 78    sta	$0078
AA7C: 85 7A    sta	$007a
AA7E: 85 7C    sta	$007c
AA80: A9 01    lda #$01
AA82: 85 7F    sta	$007f
AA84: AD 19 06 lda	$0619
AA87: C9 02    cmp #$02
AA89: 90 00    bcc	$aa8b
AA8B: 20 05 B6 jsr	$b605
AA8E: A5 17    lda	$0017
AA90: 85 83    sta	$0083
AA92: 85 85    sta	$0085
AA94: 85 81    sta	$0081
AA96: A5 18    lda	$0018
AA98: 85 84    sta	$0084
AA9A: 85 86    sta	$0086
AA9C: 85 82    sta	$0082
AA9E: 20 C6 AD jsr	$adc6
AAA1: A9 00    lda #$00
AAA3: 85 35    sta	$0035
AAA5: 85 95    sta	$0095
AAA7: 85 96    sta	$0096
AAA9: 85 93    sta	$0093
AAAB: 85 94    sta	$0094
AAAD: 8D 3C 06 sta	$063c
AAB0: 8D 3D 06 sta	$063d
AAB3: 8D 3F 06 sta	$063f
AAB6: 8D 40 06 sta	$0640
AAB9: A5 08    lda	$0008
AABB: D0 0D    bne	$aaca
AABD: A5 0B    lda	$000b
AABF: C9 01    cmp #$01
AAC1: D0 07    bne	$aaca
AAC3: 20 06 AE jsr	$ae06
AAC6: A9 00    lda #$00
AAC8: 85 36    sta	$0036
AACA: A2 00    ldx #$00
AACC: 86 29    stx	$0029
AACE: 86 2A    stx	$002a
AAD0: A5 08    lda	$0008
AAD2: D0 04    bne	$aad8
AAD4: A9 F7    lda #$f7
AAD6: 85 08    sta	$0008
AAD8: A2 00    ldx #$00
AADA: 20 AD AD jsr	$adad
AADD: A2 01    ldx #$01
AADF: 20 AD AD jsr	$adad
AAE2: A5 0B    lda	$000b
AAE4: F0 1A    beq	$ab00
AAE6: A5 77    lda	$0077
AAE8: D0 09    bne	$aaf3
AAEA: A5 4E    lda	$004e
AAEC: D0 05    bne	$aaf3
AAEE: A2 00    ldx #$00
AAF0: 20 F4 AF jsr	$aff4
AAF3: A5 78    lda	$0078
AAF5: D0 09    bne	$ab00
AAF7: A5 4F    lda	$004f
AAF9: D0 05    bne	$ab00
AAFB: A2 01    ldx #$01
AAFD: 20 F4 AF jsr	$aff4
AB00: A9 2C    lda #$2c
AB02: 85 02    sta	$0002
AB04: A9 1D    lda #$1d
AB06: 85 03    sta	$0003
AB08: A0 00    ldy #$00
AB0A: AD 57 06 lda	$0657
AB0D: C9 30    cmp #$30
AB0F: F0 08    beq	$ab19
AB11: 91 02    sta ($02), y
AB13: C8       iny
AB14: A9 A0    lda #$a0
AB16: 91 02    sta ($02), y
AB18: C8       iny
AB19: AD 58 06 lda	$0658
AB1C: 91 02    sta ($02), y
AB1E: C8       iny
AB1F: A9 A0    lda #$a0
AB21: 91 02    sta ($02), y
AB23: A5 78    lda	$0078
AB25: D0 09    bne	$ab30
AB27: A5 4F    lda	$004f
AB29: D0 05    bne	$ab30
AB2B: A9 28    lda #$28
AB2D: 20 70 D6 jsr	$d670
AB30: 60       rts

AB34: A5 2F    lda	$002f
AB36: 18       clc
AB37: 69 01    adc #$01
AB39: C9 1B    cmp #$1b
AB3B: 90 02    bcc	$ab3f
AB3D: A9 0F    lda #$0f
AB3F: 85 2F    sta	$002f
AB41: A9 07    lda #$07
AB43: 8D 70 06 sta	$0670
AB46: 8D 72 06 sta	$0672
AB49: EE 58 06 inc	$0658
AB4C: AD 58 06 lda	$0658
AB4F: C9 3A    cmp #$3a
AB51: D0 17    bne	$ab6a
AB53: A9 30    lda #$30
AB55: 8D 58 06 sta	$0658
AB58: EE 57 06 inc	$0657
AB5B: AD 57 06 lda	$0657
AB5E: C9 3A    cmp #$3a
AB60: D0 08    bne	$ab6a
AB62: A9 39    lda #$39
AB64: 8D 57 06 sta	$0657
AB67: 8D 58 06 sta	$0658
AB6A: E6 44    inc	$0044
AB6C: A5 44    lda	$0044
AB6E: C9 03    cmp #$03
AB70: 90 1F    bcc	$ab91
AB72: A9 00    lda #$00
AB74: 85 44    sta	$0044
AB76: E6 45    inc	$0045
AB78: A5 45    lda	$0045
AB7A: C9 03    cmp #$03
AB7C: 90 04    bcc	$ab82
AB7E: A9 00    lda #$00
AB80: 85 45    sta	$0045
AB82: A9 0E    lda #$0e
AB84: 20 59 E6 jsr	$e659
AB87: A5 45    lda	$0045
AB89: 18       clc
AB8A: 69 03    adc #$03
AB8C: 85 07    sta	$0007
AB8E: 20 C0 AB jsr	$abc0
AB91: A2 00    ldx #$00
AB93: B5 4E    lda	$004e, x
AB95: D0 03    bne	$ab9a
AB97: 20 D3 BC jsr	$bcd3
AB9A: A2 01    ldx #$01
AB9C: B5 4E    lda	$004e, x
AB9E: D0 03    bne	$aba3
ABA0: 20 D3 BC jsr	$bcd3
ABA3: A5 77    lda	$0077
ABA5: F0 05    beq	$abac
ABA7: A9 09    lda #$09
ABA9: 20 70 D6 jsr	$d670
ABAC: A5 78    lda	$0078
ABAE: F0 05    beq	$abb5
ABB0: A9 0A    lda #$0a
ABB2: B8       clv
ABB3: 50 02    bvc	$abb7
ABB5: A9 28    lda #$28
ABB7: 20 70 D6 jsr	$d670
ABBA: 20 8E AA jsr	$aa8e
ABBD: 4C 9C B6 jmp	$b69c
ABC0: A5 45    lda	$0045
ABC2: 0A       asl a
ABC3: 20 18 88 jsr display_screen_and_other_stuff_8818
ABC6: A0 00    ldy #$00
ABC8: 20 52 89 jsr	$8952
ABCB: A9 01    lda #$01
ABCD: 85 80    sta	$0080
ABCF: A5 77    lda	$0077
ABD1: F0 0B    beq	$abde
ABD3: A9 09    lda #$09
ABD5: 85 79    sta	$0079
ABD7: 85 7B    sta	$007b
ABD9: 85 7F    sta	$007f
ABDB: 20 70 D6 jsr	$d670
ABDE: A5 78    lda	$0078
ABE0: F0 09    beq	$abeb
ABE2: A9 0A    lda #$0a
ABE4: 85 7A    sta	$007a
ABE6: 85 7C    sta	$007c
ABE8: B8       clv
ABE9: 50 02    bvc	$abed
ABEB: A9 28    lda #$28
ABED: 20 70 D6 jsr	$d670
ABF0: A9 00    lda #$00
ABF2: 85 A1    sta	$00a1
ABF4: 85 A2    sta	$00a2
ABF6: 85 A3    sta	$00a3
ABF8: 85 A4    sta	$00a4
ABFA: 85 A5    sta	$00a5
ABFC: 85 A6    sta	$00a6
ABFE: 85 A7    sta	$00a7
AC00: AD 63 06 lda	$0663
AC03: 30 05    bmi	$ac0a
AC05: A9 52    lda #$52
AC07: 20 70 D6 jsr	$d670
AC0A: AD 64 06 lda	$0664
AC0D: 30 05    bmi	$ac14
AC0F: A9 53    lda #$53
AC11: 20 70 D6 jsr	$d670
AC14: 20 05 B6 jsr	$b605
AC17: 20 16 BC jsr	$bc16
AC1A: 60       rts
AC1B: 86 1B    stx	$001b
AC1D: 20 8A AC jsr	$ac8a
AC20: A9 07    lda #$07
AC22: E0 00    cpx #$00
AC24: D0 06    bne	$ac2c
AC26: 8D 70 06 sta	$0670
AC29: B8       clv
AC2A: 50 03    bvc	$ac2f
AC2C: 8D 72 06 sta	$0672
AC2F: A0 05    ldy #$05
AC31: E0 00    cpx #$00
AC33: D0 17    bne	$ac4c
AC35: A9 30    lda #$30
AC37: 99 00 06 sta	$0600, y
AC3A: C0 04    cpy #$04
AC3C: B0 03    bcs	$ac41
AC3E: 99 0C 06 sta	$060c, y
AC41: A9 00    lda #$00
AC43: 8D 14 06 sta	$0614
AC46: 8D 15 06 sta	$0615
AC49: B8       clv
AC4A: 50 14    bvc	$ac60
AC4C: A9 30    lda #$30
AC4E: 99 06 06 sta	$0606, y
AC51: C0 04    cpy #$04
AC53: B0 03    bcs	$ac58
AC55: 99 10 06 sta	$0610, y
AC58: A9 00    lda #$00
AC5A: 8D 16 06 sta	$0616
AC5D: 8D 17 06 sta	$0617
AC60: 88       dey
AC61: 10 CE    bpl	$ac31
AC63: A9 00    lda #$00
AC65: 9D 49 06 sta	$0649, x
AC68: E0 00    cpx #$00
AC6A: D0 05    bne	$ac71
AC6C: A5 78    lda	$0078
AC6E: B8       clv
AC6F: 50 02    bvc	$ac73
AC71: A5 77    lda	$0077
AC73: F0 05    beq	$ac7a
AC75: A9 01    lda #$01
AC77: B8       clv
AC78: 50 02    bvc	$ac7c
AC7A: A9 00    lda #$00
AC7C: 85 0B    sta	$000b
AC7E: 8D 19 06 sta	$0619
AC81: 20 AB A9 jsr	$a9ab
AC84: 20 AD AD jsr	$adad
AC87: 60       rts
AC88: 09 0A    ora #$0a
AC8A: A9 30    lda #$30
AC8C: 95 77    sta	$0077, x
AC8E: 95 79    sta	$0079, x
AC90: 95 7B    sta	$007b, x
AC92: 78       sei
AC93: A9 00    lda #$00
AC95: 9D C7 06 sta	$06c7, x
AC98: 9D C9 06 sta	$06c9, x
AC9B: 58       cli
AC9C: A9 00    lda #$00
AC9E: 8D 4D 06 sta	$064d
ACA1: BD 9B 06 lda	$069b, x
ACA4: D0 40    bne	$ace6
ACA6: BD 76 BA lda	$ba76, x
ACA9: A8       tay
ACAA: B9 77 00 lda	$0077, y
ACAD: D0 06    bne	$acb5
ACAF: 20 1C B8 jsr	$b81c
ACB2: B8       clv
ACB3: 50 31    bvc	$ace6
ACB5: 98       tya
ACB6: 0A       asl a
ACB7: A8       tay
ACB8: B9 30 00 lda	$0030, y
ACBB: C9 30    cmp #$30
ACBD: D0 13    bne	$acd2
ACBF: B9 31 00 lda	$0031, y
ACC2: C9 35    cmp #$35
ACC4: B0 0C    bcs	$acd2
ACC6: A9 04    lda #$04
ACC8: 95 35    sta	$0035, x
ACCA: A9 4C    lda #$4c
ACCC: 9D 9F 06 sta	$069f, x
ACCF: 8D 4D 06 sta	$064d
ACD2: 98       tya
ACD3: 4A       lsr a
ACD4: A8       tay
ACD5: B9 35 00 lda	$0035, y
ACD8: F0 0C    beq	$ace6
ACDA: A9 04    lda #$04
ACDC: 95 35    sta	$0035, x
ACDE: A9 4C    lda #$4c
ACE0: 9D 9F 06 sta	$069f, x
ACE3: 8D 4D 06 sta	$064d
ACE6: AD 4D 06 lda	$064d
ACE9: D0 5C    bne	$ad47
ACEB: A9 00    lda #$00
ACED: 95 35    sta	$0035, x
ACEF: 8A       txa
ACF0: 0A       asl a
ACF1: AA       tax
ACF2: A4 2F    ldy	$002f
ACF4: B9 AA B7 lda	$b7aa, y
ACF7: 95 30    sta	$0030, x
ACF9: B9 C5 B7 lda	$b7c5, y
ACFC: 95 31    sta	$0031, x
ACFE: B9 E0 B7 lda	$b7e0, y
AD01: E0 00    cpx #$00
AD03: D0 17    bne	$ad1c
AD05: 8D BB 06 sta	$06bb
AD08: AD 15 06 lda	$0615
AD0B: 0A       asl a
AD0C: 0A       asl a
AD0D: 0A       asl a
AD0E: 18       clc
AD0F: 6D BB 06 adc	$06bb
AD12: A8       tay
AD13: B9 28 C0 lda	$c028, y
AD16: 8D BB 06 sta	$06bb
AD19: B8       clv
AD1A: 50 14    bvc	$ad30
AD1C: 8D BC 06 sta	$06bc
AD1F: AD 17 06 lda	$0617
AD22: 0A       asl a
AD23: 0A       asl a
AD24: 0A       asl a
AD25: 18       clc
AD26: 6D BC 06 adc	$06bc
AD29: A8       tay
AD2A: B9 28 C0 lda	$c028, y
AD2D: 8D BC 06 sta	$06bc
AD30: A6 1B    ldx	$001b
AD32: BD 9B 06 lda	$069b, x
AD35: D0 10    bne	$ad47
AD37: 8A       txa
AD38: A8       tay
AD39: BE 76 BA ldx	$ba76, y
AD3C: 20 00 A8 jsr	$a800
AD3F: 8A       txa
AD40: A8       tay
AD41: BE 76 BA ldx	$ba76, y
AD44: 20 C9 A7 jsr	$a7c9
AD47: BD 88 AC lda	$ac88, x
AD4A: 20 70 D6 jsr	$d670
AD4D: 60       rts
AD4E: 86 1B    stx	$001b
AD50: A9 01    lda #$01
AD52: 9D 9B 06 sta	$069b, x
AD55: 18       clc
AD56: 8A       txa
AD57: 69 4A    adc #$4a
AD59: 20 70 D6 jsr	$d670
AD5C: 20 8A AC jsr	$ac8a
AD5F: 4C AD AD jmp	$adad
AD62: 86 1B    stx	$001b
AD64: 18       clc
AD65: 8A       txa
AD66: 69 4A    adc #$4a
AD68: 20 70 D6 jsr	$d670
AD6B: A9 00    lda #$00
AD6D: 9D B5 06 sta	$06b5, x
AD70: 9D B7 06 sta	$06b7, x
AD73: 8E A4 06 stx	$06a4
AD76: A0 00    ldy #$00
AD78: 20 B7 89 jsr	$89b7
AD7B: 20 8A AC jsr	$ac8a
AD7E: 20 01 AA jsr	$aa01
AD81: A9 00    lda #$00
AD83: 8D 4E 06 sta	$064e
AD86: 8A       txa
AD87: A8       tay
AD88: BE 76 BA ldx	$ba76, y
AD8B: B5 77    lda	$0077, x
AD8D: F0 05    beq	$ad94
AD8F: A9 01    lda #$01
AD91: 8D 4E 06 sta	$064e
AD94: AD 4E 06 lda	$064e
AD97: 8D 19 06 sta	$0619
AD9A: 85 0B    sta	$000b
AD9C: A6 1B    ldx	$001b
AD9E: A9 07    lda #$07
ADA0: E0 00    cpx #$00
ADA2: D0 06    bne	$adaa
ADA4: 8D 70 06 sta	$0670
ADA7: B8       clv
ADA8: 50 03    bvc	$adad
ADAA: 8D 72 06 sta	$0672
ADAD: 20 E8 AF jsr	$afe8
ADB0: A9 00    lda #$00
ADB2: 95 8D    sta	$008d, x
ADB4: 95 8B    sta	$008b, x
ADB6: 95 29    sta	$0029, x
ADB8: B5 77    lda	$0077, x
ADBA: F0 06    beq	$adc2
ADBC: BD 88 AC lda	$ac88, x
ADBF: 20 70 D6 jsr	$d670
ADC2: E0 00    cpx #$00
ADC4: D0 40    bne	$ae06
ADC6: A9 00    lda #$00
ADC8: 85 1F    sta	$001f
ADCA: A9 02    lda #$02
ADCC: 85 20    sta	$0020
ADCE: A9 1C    lda #$1c
ADD0: 85 1D    sta	$001d
ADD2: A5 1D    lda	$001d
ADD4: C9 03    cmp #$03
ADD6: B0 04    bcs	$addc
ADD8: A2 20    ldx #$20
ADDA: D0 0A    bne	$ade6
ADDC: A6 0B    ldx	$000b
ADDE: 30 04    bmi	$ade4
ADE0: A2 00    ldx #$00
ADE2: F0 02    beq	$ade6
ADE4: A2 10    ldx #$10
ADE6: A0 00    ldy #$00
ADE8: BD C3 AE lda	$aec3, x
ADEB: 91 1F    sta ($1f), y
ADED: E8       inx
ADEE: C8       iny
ADEF: C0 10    cpy #$10
ADF1: 90 F5    bcc	$ade8
ADF3: A5 1F    lda	$001f
ADF5: 18       clc
ADF6: 69 10    adc #$10
ADF8: 85 1F    sta	$001f
ADFA: 90 02    bcc	$adfe
ADFC: E6 20    inc	$0020
ADFE: C6 1D    dec	$001d
AE00: D0 D0    bne	$add2
AE02: A2 00    ldx #$00
AE04: F0 3E    beq	$ae44
AE06: A9 00    lda #$00
AE08: 85 1F    sta	$001f
AE0A: A9 04    lda #$04
AE0C: 85 20    sta	$0020
AE0E: A9 1C    lda #$1c
AE10: 85 1D    sta	$001d
AE12: A5 1D    lda	$001d
AE14: C9 03    cmp #$03
AE16: B0 04    bcs	$ae1c
AE18: A2 20    ldx #$20
AE1A: D0 0A    bne	$ae26
AE1C: A6 0B    ldx	$000b
AE1E: 30 04    bmi	$ae24
AE20: A2 00    ldx #$00
AE22: F0 02    beq	$ae26
AE24: A2 10    ldx #$10
AE26: A0 00    ldy #$00
AE28: BD C3 AE lda	$aec3, x
AE2B: 91 1F    sta ($1f), y
AE2D: E8       inx
AE2E: C8       iny
AE2F: C0 10    cpy #$10
AE31: 90 F5    bcc	$ae28
AE33: A5 1F    lda	$001f
AE35: 18       clc
AE36: 69 10    adc #$10
AE38: 85 1F    sta	$001f
AE3A: 90 02    bcc	$ae3e
AE3C: E6 20    inc	$0020
AE3E: C6 1D    dec	$001d
AE40: D0 D0    bne	$ae12
AE42: A2 01    ldx #$01
AE44: B5 77    lda	$0077, x
AE46: D0 01    bne	$ae49
AE48: 60       rts
AE49: BD 9B 06 lda	$069b, x
AE4C: F0 01    beq	$ae4f
AE4E: 60       rts
AE4F: A4 2F    ldy	$002f
AE51: B9 DB B0 lda	$b0db, y
AE54: 8D 3B 06 sta	$063b
AE57: F0 02    beq	$ae5b
AE59: A9 01    lda #$01
AE5B: 9D 3C 06 sta	$063c, x
AE5E: B9 00 B1 lda	$b100, y
AE61: 8D 3E 06 sta	$063e
AE64: F0 02    beq	$ae68
AE66: A9 01    lda #$01
AE68: 9D 3F 06 sta	$063f, x
AE6B: B9 BC B0 lda	$b0bc, y
AE6E: 8D 1C 06 sta	$061c
AE71: D0 01    bne	$ae74
AE73: 60       rts
AE74: C9 08    cmp #$08
AE76: 90 03    bcc	$ae7b
AE78: 4C F3 AE jmp	$aef3
AE7B: 38       sec
AE7C: E9 01    sbc #$01
AE7E: 4A       lsr a
AE7F: 85 22    sta	$0022
AE81: A9 00    lda #$00
AE83: 6A       ror a
AE84: 69 9C    adc #$9c
AE86: 85 21    sta	$0021
AE88: A5 22    lda	$0022
AE8A: 69 76    adc #$76
AE8C: 85 22    sta	$0022
AE8E: 08       php
AE8F: 78       sei
; switch to bank 1
AE90: AD 00 60 lda bank_switch_start_6000
AE93: AD 4C 75 lda	$754c
AE96: AD 90 60 lda	$6090
AE99: AD 41 75 lda	$7541
AE9C: AD 51 75 lda	$7551
AE9F: AD 90 60 lda	$6090
AEA2: 28       plp
AEA3: F6 79    inc	$0079, x
AEA5: A9 12    lda #$12
AEA7: 95 93    sta	$0093, x
AEA9: A9 20    lda #$20
AEAB: 85 1F    sta	$001f
AEAD: BD 8C 9E lda	$9e8c, x
AEB0: 18       clc
AEB1: 69 01    adc #$01
AEB3: 85 20    sta	$0020
AEB5: A0 00    ldy #$00
AEB7: B1 21    lda ($21), y
AEB9: 91 1F    sta ($1f), y
AEBB: C8       iny
AEBC: C0 80    cpy #$80
AEBE: 90 F7    bcc	$aeb7
AEC0: 4C 3A A4 jmp	$a43a

AEF3: 38       sec
AEF4: E9 08    sbc #$08
AEF6: 18       clc
AEF7: 69 D9    adc #$d9
AEF9: 85 1D    sta	$001d
AEFB: A9 09    lda #$09
AEFD: 85 1E    sta	$001e
AEFF: A9 40    lda #$40
AF01: 85 1F    sta	$001f
AF03: BD 8C 9E lda	$9e8c, x
AF06: 18       clc
AF07: 69 01    adc #$01
AF09: 85 20    sta	$0020
AF0B: A0 00    ldy #$00
AF0D: A9 F1    lda #$f1
AF0F: 91 1F    sta ($1f), y
AF11: A5 1F    lda	$001f
AF13: 69 10    adc #$10
AF15: 85 1F    sta	$001f
AF17: C9 A0    cmp #$a0
AF19: 90 F2    bcc	$af0d
AF1B: F6 79    inc	$0079, x
AF1D: A9 14    lda #$14
AF1F: 95 93    sta	$0093, x
AF21: A9 43    lda #$43
AF23: 85 1F    sta	$001f
AF25: BD 8C 9E lda	$9e8c, x
AF28: 18       clc
AF29: 69 01    adc #$01
AF2B: 85 20    sta	$0020
AF2D: 8A       txa
AF2E: 48       pha
AF2F: A2 00    ldx #$00
AF31: A9 1E    lda #$1e
AF33: 85 5E    sta	$005e
AF35: A0 00    ldy #$00
AF37: B1 1D    lda ($1d), y
AF39: 29 1F    and #$1f
AF3B: 85 21    sta	$0021
AF3D: 0A       asl a
AF3E: 65 21    adc	$0021
AF40: 69 97    adc #$97
AF42: 85 21    sta	$0021
AF44: A9 AF    lda #$af
AF46: 69 00    adc #$00
AF48: 85 22    sta	$0022
AF4A: B1 21    lda ($21), y
AF4C: 48       pha
AF4D: 68       pla
AF4E: 0A       asl a
AF4F: 48       pha
AF50: 90 04    bcc	$af56
AF52: A5 5E    lda	$005e
AF54: 91 1F    sta ($1f), y
AF56: C8       iny
AF57: 98       tya
AF58: 29 03    and #$03
AF5A: D0 07    bne	$af63
AF5C: A5 1F    lda	$001f
AF5E: 18       clc
AF5F: 69 0C    adc #$0c
AF61: 85 1F    sta	$001f
AF63: 98       tya
AF64: 29 07    and #$07
AF66: D0 11    bne	$af79
AF68: A5 21    lda	$0021
AF6A: 18       clc
AF6B: 69 01    adc #$01
AF6D: 85 21    sta	$0021
AF6F: A5 22    lda	$0022
AF71: 69 00    adc #$00
AF73: 85 22    sta	$0022
AF75: 68       pla
AF76: A1 21    lda ($21, x)
AF78: 48       pha
AF79: C0 18    cpy #$18
AF7B: 90 D0    bcc	$af4d
AF7D: 68       pla
AF7E: E6 1D    inc	$001d
AF80: A5 5E    lda	$005e
AF82: 18       clc
AF83: 69 10    adc #$10
AF85: 85 5E    sta	$005e
AF87: A5 1F    lda	$001f
AF89: 38       sec
AF8A: E9 45    sbc #$45
AF8C: 85 1F    sta	$001f
AF8E: C9 4A    cmp #$4a
AF90: 90 A3    bcc	$af35
AF92: 68       pla
AF93: AA       tax
AF94: 4C 3A A4 jmp	$a43a

AFE8: A9 00    lda #$00
AFEA: 85 05    sta	$0005
AFEC: B5 77    lda	$0077, x
AFEE: F0 03    beq	$aff3
AFF0: 20 F4 AF jsr	$aff4
AFF3: 60       rts
AFF4: A9 00    lda #$00
AFF6: 85 05    sta	$0005
AFF8: 8A       txa
AFF9: 0A       asl a
AFFA: A8       tay
AFFB: B9 56 E7 lda	$e756, y
AFFE: F0 39    beq	$b039
B000: 85 1D    sta	$001d
B002: B9 57 E7 lda	$e757, y
B005: 85 1E    sta	$001e
B007: B9 4E E7 lda	$e74e, y
B00A: 85 1F    sta	$001f
B00C: B9 4F E7 lda	$e74f, y
B00F: 85 20    sta	$0020
B011: A9 62    lda #$62
B013: 85 00    sta	$0000
B015: A9 E7    lda #$e7
B017: 85 01    sta	$0001
B019: A5 1F    lda	$001f
B01B: 85 02    sta	$0002
B01D: 18       clc
B01E: 69 80    adc #$80
B020: 85 1F    sta	$001f
B022: A5 20    lda	$0020
B024: 85 03    sta	$0003
B026: 69 00    adc #$00
B028: 85 20    sta	$0020
B02A: A5 1E    lda	$001e
B02C: 20 CC D5 jsr	$d5cc
B02F: C6 1D    dec	$001d
B031: D0 DE    bne	$b011
B033: C8       iny
B034: C8       iny
B035: C8       iny
B036: C8       iny
B037: D0 C2    bne	$affb
B039: 60       rts
B03A: A8       tay
B03B: 86 1D    stx	$001d
B03D: A6 1D    ldx	$001d
B03F: F6 79    inc	$0079, x
B041: B9 B5 B0 lda	$b0b5, y
B044: 95 93    sta	$0093, x
B046: 86 1D    stx	$001d
B048: 0A       asl a
B049: 0A       asl a
B04A: 0A       asl a
B04B: 0A       asl a
B04C: 85 1F    sta	$001f
B04E: BD 8C 9E lda	$9e8c, x
B051: 69 00    adc #$00
B053: 85 20    sta	$0020
B055: A5 81    lda	$0081
B057: 85 17    sta	$0017
B059: A5 82    lda	$0082
B05B: 85 18    sta	$0018
B05D: A9 00    lda #$00
B05F: A8       tay
B060: 85 1C    sta	$001c
B062: A9 F1    lda #$f1
B064: 91 1F    sta ($1f), y
B066: C8       iny
B067: C8       iny
B068: A2 17    ldx #$17
B06A: B1 1F    lda ($1f), y
B06C: D0 0D    bne	$b07b
B06E: AD 1A 28 lda	$281a
B071: 29 70    and #$70
B073: F0 04    beq	$b079
B075: E6 1C    inc	$001c
B077: 09 0E    ora #$0e
B079: 91 1F    sta ($1f), y
B07B: C8       iny
B07C: 98       tya
B07D: 29 0F    and #$0f
B07F: D0 E9    bne	$b06a
B081: A5 1C    lda	$001c
B083: C9 07    cmp #$07
B085: 90 0D    bcc	$b094
B087: AD 1A 28 lda	$281a
B08A: 29 07    and #$07
B08C: 18       clc
B08D: 69 04    adc #$04
B08F: A8       tay
B090: A9 00    lda #$00
B092: 91 1F    sta ($1f), y
B094: A5 1F    lda	$001f
B096: 18       clc
B097: 69 10    adc #$10
B099: 85 1F    sta	$001f
B09B: 90 02    bcc	$b09f
B09D: E6 20    inc	$0020
B09F: A5 20    lda	$0020
B0A1: 4A       lsr a
B0A2: A5 1F    lda	$001f
B0A4: 6A       ror a
B0A5: C9 D0    cmp #$d0
B0A7: 90 B4    bcc	$b05d
B0A9: A6 1D    ldx	$001d
B0AB: 4C 3A A4 jmp	$a43a

B125: AD 1A 28 lda	$281a
B128: 29 07    and #$07
B12A: F0 02    beq	$b12e
B12C: E6 1C    inc	$001c
B12E: 60       rts
B12F: 8A       txa
B130: A8       tay
B131: 24 0B    bit	$000b
B133: 10 02    bpl	$b137
B135: A0 02    ldy #$02
B137: B9 8C 9E lda	$9e8c, y
B13A: 85 03    sta	$0003
B13C: B9 86 9E lda	$9e86, y
B13F: 85 9D    sta	$009d
B141: B9 89 9E lda	$9e89, y
B144: 85 9E    sta	$009e
B146: 20 1A CA jsr	$ca1a
B149: A9 D0    lda #$d0
B14B: 85 1B    sta	$001b
B14D: A2 03    ldx #$03
B14F: BD C0 05 lda	$05c0, x
B152: C5 1B    cmp	$001b
B154: B0 02    bcs	$b158
B156: 85 1B    sta	$001b
B158: E8       inx
B159: E0 0D    cpx #$0d
B15B: 90 F2    bcc	$b14f
B15D: A5 1B    lda	$001b
B15F: C9 80    cmp #$80
B161: B0 01    bcs	$b164
B163: 60       rts
B164: AD 0A 28 lda	$280a
B167: 29 0F    and #$0f
B169: 18       clc
B16A: 69 03    adc #$03
B16C: C9 0D    cmp #$0d
B16E: 90 02    bcc	$b172
B170: E9 08    sbc #$08
B172: AA       tax
B173: 85 1B    sta	$001b
B175: BD C0 05 lda	$05c0, x
B178: 85 1C    sta	$001c
B17A: A0 03    ldy #$03
B17C: C4 1B    cpy	$001b
B17E: F0 07    beq	$b187
B180: B9 C0 05 lda	$05c0, y
B183: C5 1C    cmp	$001c
B185: B0 0D    bcs	$b194
B187: C8       iny
B188: C0 0D    cpy #$0d
B18A: 90 F0    bcc	$b17c
B18C: E0 0C    cpx #$0c
B18E: D0 03    bne	$b193
B190: CA       dex
B191: D0 01    bne	$b194
B193: E8       inx
B194: BD C0 05 lda	$05c0, x
B197: 38       sec
B198: E9 08    sbc #$08
B19A: 85 1C    sta	$001c
B19C: 0A       asl a
B19D: 85 02    sta	$0002
B19F: 90 02    bcc	$b1a3
B1A1: E6 03    inc	$0003
B1A3: 8A       txa
B1A4: 18       clc
B1A5: 65 02    adc	$0002
B1A7: 85 02    sta	$0002
B1A9: A9 09    lda #$09
B1AB: A0 00    ldy #$00
B1AD: 91 02    sta ($02), y
B1AF: 08       php
B1B0: 78       sei
; switch to bank 1
B1B1: AD 00 60 lda bank_switch_start_6000
B1B4: AD 4B 75 lda	$754b
B1B7: AD 90 60 lda	$6090
B1BA: AD 42 75 lda	$7542
B1BD: AD 43 75 lda	$7543
B1C0: AD 54 75 lda	$7554
B1C3: AD A0 60 lda	$60a0
B1C6: 28       plp
B1C7: AD 21 65 lda	$6521
B1CA: 8D 00 01 sta	$0100
B1CD: A9 00    lda #$00
B1CF: 85 1E    sta	$001e
B1D1: A5 1C    lda	$001c
B1D3: 38       sec
B1D4: E9 30    sbc #$30
B1D6: 0A       asl a
B1D7: 26 1E    rol	$001e
B1D9: 0A       asl a
B1DA: 26 1E    rol	$001e
B1DC: 0A       asl a
B1DD: 26 1E    rol	$001e
B1DF: 0A       asl a
B1E0: 26 1E    rol	$001e
B1E2: 65 9D    adc	$009d
B1E4: 85 02    sta	$0002
B1E6: A5 1E    lda	$001e
B1E8: 65 9E    adc	$009e
B1EA: 85 03    sta	$0003
B1EC: 8A       txa
B1ED: 0A       asl a
B1EE: 65 02    adc	$0002
B1F0: 38       sec
B1F1: E9 06    sbc #$06
B1F3: 85 02    sta	$0002
B1F5: A9 01    lda #$01
B1F7: 85 01    sta	$0001
B1F9: A9 00    lda #$00
B1FB: 85 00    sta	$0000
B1FD: A9 F0    lda #$f0
B1FF: 8D 01 01 sta	$0101
B202: A9 01    lda #$01
B204: 20 33 D6 jsr	$d633
B207: A9 17    lda #$17
B209: 20 59 E6 jsr	$e659
B20C: 60       rts
B20D: BD 8C 9E lda	$9e8c, x
B210: 85 20    sta	$0020
B212: A9 60    lda #$60
B214: 85 1F    sta	$001f
B216: A5 1F    lda	$001f
B218: 18       clc
B219: 69 10    adc #$10
B21B: 85 1F    sta	$001f
B21D: 90 02    bcc	$b221
B21F: E6 20    inc	$0020
B221: A0 03    ldy #$03
B223: B1 1F    lda ($1f), y
B225: C8       iny
B226: 11 1F    ora ($1f), y
B228: C8       iny
B229: 11 1F    ora ($1f), y
B22B: C8       iny
B22C: 11 1F    ora ($1f), y
B22E: C8       iny
B22F: 11 1F    ora ($1f), y
B231: C8       iny
B232: 11 1F    ora ($1f), y
B234: C8       iny
B235: 11 1F    ora ($1f), y
B237: C8       iny
B238: 11 1F    ora ($1f), y
B23A: C8       iny
B23B: 11 1F    ora ($1f), y
B23D: C8       iny
B23E: 11 1F    ora ($1f), y
B240: F0 D4    beq	$b216
B242: A5 20    lda	$0020
B244: 4A       lsr a
B245: A5 1F    lda	$001f
B247: 6A       ror a
B248: C9 80    cmp #$80
B24A: 90 48    bcc	$b294
B24C: C9 D0    cmp #$d0
B24E: B0 3A    bcs	$b28a
B250: A5 1F    lda	$001f
B252: 38       sec
B253: E9 10    sbc #$10
B255: 85 21    sta	$0021
B257: A5 20    lda	$0020
B259: E9 00    sbc #$00
B25B: 85 22    sta	$0022
B25D: A0 00    ldy #$00
B25F: A9 F1    lda #$f1
B261: 91 21    sta ($21), y
B263: C8       iny
B264: B1 1F    lda ($1f), y
B266: 91 21    sta ($21), y
B268: C8       iny
B269: C0 10    cpy #$10
B26B: 90 F7    bcc	$b264
B26D: A5 20    lda	$0020
B26F: 4A       lsr a
B270: A5 1F    lda	$001f
B272: 6A       ror a
B273: C9 C8    cmp #$c8
B275: B0 0E    bcs	$b285
B277: A5 1F    lda	$001f
B279: 69 10    adc #$10
B27B: 85 1F    sta	$001f
B27D: A5 20    lda	$0020
B27F: 69 00    adc #$00
B281: 85 20    sta	$0020
B283: D0 CB    bne	$b250
B285: A0 02    ldy #$02
B287: 20 47 A3 jsr	$a347
B28A: A9 18    lda #$18
B28C: 20 59 E6 jsr	$e659
B28F: A9 19    lda #$19
B291: 4C 46 B0 jmp	$b046
B294: 60       rts
B295: 85 1C    sta	$001c
B297: A0 00    ldy #$00
B299: 46 1C    lsr	$001c
B29B: 90 07    bcc	$b2a4
B29D: 98       tya
B29E: 18       clc
B29F: 65 1B    adc	$001b
B2A1: B0 0F    bcs	$b2b2
B2A3: A8       tay
B2A4: A5 1C    lda	$001c
B2A6: F0 06    beq	$b2ae
B2A8: 06 1B    asl	$001b
B2AA: 90 ED    bcc	$b299
B2AC: B0 04    bcs	$b2b2
B2AE: C0 FA    cpy #$fa
B2B0: 90 02    bcc	$b2b4
B2B2: A0 FA    ldy #$fa
B2B4: A9 00    lda #$00
B2B6: 85 1B    sta	$001b
B2B8: 85 1C    sta	$001c
B2BA: 98       tya
B2BB: C9 64    cmp #$64
B2BD: 90 06    bcc	$b2c5
B2BF: E9 64    sbc #$64
B2C1: E6 1B    inc	$001b
B2C3: D0 F6    bne	$b2bb
B2C5: C9 0A    cmp #$0a
B2C7: 90 06    bcc	$b2cf
B2C9: E9 0A    sbc #$0a
B2CB: E6 1C    inc	$001c
B2CD: D0 F6    bne	$b2c5
B2CF: 85 1D    sta	$001d
B2D1: 60       rts
B2D2: B5 97    lda	$0097, x
B2D4: D0 38    bne	$b30e
B2D6: BD 3C 06 lda	$063c, x
B2D9: F0 17    beq	$b2f2
B2DB: 18       clc
B2DC: 69 01    adc #$01
B2DE: 9D 3C 06 sta	$063c, x
B2E1: CD 3B 06 cmp	$063b
B2E4: 90 0C    bcc	$b2f2
B2E6: A9 01    lda #$01
B2E8: 9D 3C 06 sta	$063c, x
B2EB: 8A       txa
B2EC: 48       pha
B2ED: 20 2F B1 jsr	$b12f
B2F0: 68       pla
B2F1: AA       tax
B2F2: BD 3F 06 lda	$063f, x
B2F5: F0 17    beq	$b30e
B2F7: 18       clc
B2F8: 69 01    adc #$01
B2FA: 9D 3F 06 sta	$063f, x
B2FD: CD 3E 06 cmp	$063e
B300: 90 0C    bcc	$b30e
B302: A9 01    lda #$01
B304: 9D 3F 06 sta	$063f, x
B307: 8A       txa
B308: 48       pha
B309: 20 0D B2 jsr	$b20d
B30C: 68       pla
B30D: AA       tax
B30E: A9 14    lda #$14
B310: 95 91    sta	$0091, x
B312: 9D 2C 06 sta	$062c, x
B315: A5 0B    lda	$000b
B317: 10 07    bpl	$b320
B319: BD 58 B4 lda	$b458, x
B31C: A0 01    ldy #$01
B31E: D0 05    bne	$b325
B320: BD 5A B4 lda	$b45a, x
B323: A0 04    ldy #$04
B325: 94 87    sty	$0087, x
B327: 95 89    sta	$0089, x
B329: A9 00    lda #$00
B32B: 95 8F    sta	$008f, x
B32D: B5 8D    lda	$008d, x
B32F: 48       pha
B330: 95 8B    sta	$008b, x
B332: 20 FA 9D jsr	$9dfa
B335: A5 0B    lda	$000b
B337: 10 08    bpl	$b341
B339: A5 9D    lda	$009d
B33B: 18       clc
B33C: 7D 5C B4 adc	$b45c, x
B33F: 85 9D    sta	$009d
B341: 20 C0 9E jsr	$9ec0
B344: 86 1B    stx	$001b
B346: 8A       txa
B347: 0A       asl a
B348: 69 83    adc #$83
B34A: AA       tax
B34B: 20 AC B4 jsr	$b4ac
B34E: 29 07    and #$07
B350: F0 F9    beq	$b34b
B352: A6 1B    ldx	$001b
B354: 95 8B    sta	$008b, x
B356: 95 8D    sta	$008d, x
B358: 20 E8 9E jsr	$9ee8
B35B: 20 8F 9E jsr	clear_player_grid_9E8F
B35E: 86 20    stx	$0020
B360: 20 92 9C jsr	$9c92
B363: A6 20    ldx	$0020
B365: BD 8C 9E lda	$9e8c, x
B368: 85 03    sta	$0003
B36A: BD 5A B4 lda	$b45a, x
B36D: 18       clc
B36E: 69 40    adc #$40
B370: 85 02    sta	$0002
B372: A0 00    ldy #$00
B374: B1 02    lda ($02), y
B376: D0 04    bne	$b37c
B378: A9 F0    lda #$f0
B37A: 91 02    sta ($02), y
B37C: C8       iny
B37D: C0 03    cpy #$03
B37F: 90 F3    bcc	$b374
B381: A0 10    ldy #$10
B383: B1 02    lda ($02), y
B385: D0 04    bne	$b38b
B387: A9 F0    lda #$f0
B389: 91 02    sta ($02), y
B38B: C8       iny
B38C: C0 13    cpy #$13
B38E: 90 F3    bcc	$b383
B390: A9 04    lda #$04
B392: 95 87    sta	$0087, x
B394: A4 0B    ldy	$000b
B396: 10 05    bpl	$b39d
B398: BD 58 B4 lda	$b458, x
B39B: D0 02    bne	$b39f
B39D: A9 07    lda #$07
B39F: 95 89    sta	$0089, x
B3A1: 68       pla
B3A2: 95 8B    sta	$008b, x
B3A4: 20 FA 9D jsr	$9dfa
B3A7: 20 E8 9E jsr	$9ee8
B3AA: 20 8F 9E jsr	clear_player_grid_9E8F
B3AD: 86 20    stx	$0020
B3AF: 20 92 9C jsr	$9c92
B3B2: A6 20    ldx	$0020
B3B4: B5 8B    lda	$008b, x
B3B6: F0 11    beq	$b3c9
B3B8: A5 08    lda	$0008
B3BA: C9 FC    cmp #$fc
B3BC: D0 06    bne	$b3c4
B3BE: 20 16 C9 jsr	$c916
B3C1: 4C CA B3 jmp	$b3ca
B3C4: AD 19 06 lda	$0619
B3C7: F0 01    beq	$b3ca
B3C9: 60       rts
B3CA: A5 77    lda	$0077
B3CC: F0 FB    beq	$b3c9
B3CE: A5 4F    lda	$004f
B3D0: D0 F7    bne	$b3c9
B3D2: AD 64 06 lda	$0664
B3D5: 10 F2    bpl	$b3c9
B3D7: A6 8B    ldx	$008b
B3D9: B5 A0    lda	$00a0, x
B3DB: C9 7F    cmp #$7f
B3DD: B0 EA    bcs	$b3c9
B3DF: 29 07    and #$07
B3E1: A8       tay
B3E2: B9 25 65 lda	$6525, y
B3E5: 8D 00 01 sta	$0100
B3E8: A5 8B    lda	$008b
B3EA: 0A       asl a
B3EB: 0A       asl a
B3EC: 0A       asl a
B3ED: 0A       asl a
B3EE: 69 70    adc #$70
B3F0: 8D 01 01 sta	$0101
B3F3: A9 1C    lda #$1c
B3F5: 85 03    sta	$0003
B3F7: A4 8B    ldy	$008b
B3F9: B9 A0 00 lda	$00a0, y
B3FC: 4A       lsr a
B3FD: 4A       lsr a
B3FE: 4A       lsr a
B3FF: 4A       lsr a
B400: 49 FF    eor #$ff
B402: 38       sec
B403: 65 03    adc	$0003
B405: 85 03    sta	$0003
B407: B9 A0 00 lda	$00a0, y
B40A: 29 08    and #$08
B40C: F0 02    beq	$b410
B40E: A9 80    lda #$80
B410: 85 1B    sta	$001b
B412: A5 8B    lda	$008b
B414: 0A       asl a
B415: 69 38    adc #$38
B417: 38       sec
B418: E5 1B    sbc	$001b
B41A: 85 02    sta	$0002
B41C: A5 03    lda	$0003
B41E: E9 00    sbc #$00
B420: 85 03    sta	$0003
B422: A0 00    ldy #$00
B424: AD 00 01 lda	$0100
B427: 91 02    sta ($02), y
B429: C8       iny
B42A: AD 01 01 lda	$0101
B42D: 91 02    sta ($02), y
B42F: A6 8B    ldx	$008b
B431: B5 A0    lda	$00a0, x
B433: C9 07    cmp #$07
B435: 90 1C    bcc	$b453
B437: 29 07    and #$07
B439: D0 18    bne	$b453
B43B: A5 02    lda	$0002
B43D: 18       clc
B43E: 69 80    adc #$80
B440: 85 02    sta	$0002
B442: 90 02    bcc	$b446
B444: E6 03    inc	$0003
B446: A0 00    ldy #$00
B448: AD 2D 65 lda	$652d
B44B: 91 02    sta ($02), y
B44D: C8       iny
B44E: AD 01 01 lda	$0101
B451: 91 02    sta ($02), y
B453: F6 A0    inc	$00a0, x
B455: F6 A0    inc	$00a0, x
B457: 60       rts

B45E: A5 0B    lda $0b
B460: 10 07    bpl $b469                                  
B462: BD 58 B4 lda $b458, x                               
B465: A0 01    ldy #$01                                   
B467: D0 05    bne $b46e                                  
B469: BD 5A B4 lda	$b45a, x
B46C: A0 04    ldy #$04
B46E: 94 87    sty	$0087, x
B470: 95 89    sta	$0089, x
B472: A9 00    lda #$00
B474: 95 8F    sta	$008f, x
B476: 86 1B    stx	$001b
B478: 8A       txa
B479: 0A       asl a
B47A: 69 83    adc #$83
B47C: AA       tax
B47D: 20 AC B4 jsr	$b4ac
B480: 29 07    and #$07
B482: F0 F9    beq	$b47d
B484: A6 1B    ldx	$001b
B486: 95 8B    sta	$008b, x
B488: 95 8D    sta	$008d, x
B48A: 20 FA 9D jsr	$9dfa
B48D: A5 0B    lda	$000b
B48F: 10 08    bpl	$b499
B491: A5 9D    lda	$009d
B493: 18       clc
B494: 7D 5C B4 adc	$b45c, x
B497: 85 9D    sta	$009d
B499: 20 E8 9E jsr	$9ee8
B49C: 20 8F 9E jsr	clear_player_grid_9E8F
B49F: 86 20    stx	$0020
B4A1: 20 92 9C jsr	$9c92
B4A4: A6 20    ldx	$0020
B4A6: A9 00    lda #$00
B4A8: 95 8B    sta	$008b, x
B4AA: 60       rts
B4AB: 60       rts
B4AC: 20 B2 B4 jsr	$b4b2
B4AF: 20 B2 B4 jsr	$b4b2
B4B2: B5 00    lda	$0000, x
B4B4: 55 01    eor	$0001, x
B4B6: D0 04    bne	$b4bc
B4B8: D5 01    cmp	$0001, x
B4BA: F0 02    beq	$b4be
B4BC: 0A       asl a
B4BD: 0A       asl a
B4BE: 36 00    rol	$0000, x
B4C0: 36 01    rol	$0001, x
B4C2: B5 00    lda	$0000, x
B4C4: 60       rts
B4C5: BD 2C 06 lda	$062c, x
B4C8: C9 02    cmp #$02
B4CA: B0 24    bcs	$b4f0
B4CC: A5 1D    lda	$001d
B4CE: 65 1D    adc	$001d
B4D0: C9 0A    cmp #$0a
B4D2: 90 02    bcc	$b4d6
B4D4: E9 0A    sbc #$0a
B4D6: 85 1D    sta	$001d
B4D8: A5 1C    lda	$001c
B4DA: 65 1C    adc	$001c
B4DC: C9 0A    cmp #$0a
B4DE: 90 02    bcc	$b4e2
B4E0: E9 0A    sbc #$0a
B4E2: 85 1C    sta	$001c
B4E4: A5 1B    lda	$001b
B4E6: 65 1B    adc	$001b
B4E8: C9 0A    cmp #$0a
B4EA: 90 02    bcc	$b4ee
B4EC: E9 0A    sbc #$0a
B4EE: 85 1B    sta	$001b
B4F0: 60       rts
B4F1: 8A       txa
B4F2: 0A       asl a
B4F3: A8       tay
B4F4: B9 15 06 lda	$0615, y
B4F7: 18       clc
B4F8: 69 01    adc #$01
B4FA: 24 0B    bit	$000b
B4FC: 10 03    bpl	$b501
B4FE: 18       clc
B4FF: 69 03    adc #$03
B501: 85 1B    sta	$001b
B503: B9 14 06 lda	$0614, y
B506: C9 01    cmp #$01
B508: 90 06    bcc	$b510
B50A: A5 1B    lda	$001b
B50C: 69 09    adc #$09
B50E: 85 1B    sta	$001b
B510: A5 1B    lda	$001b
B512: 18       clc
B513: 65 0A    adc	$000a
B515: 20 95 B2 jsr	$b295
B518: 20 C5 B4 jsr	$b4c5
B51B: A9 00    lda #$00
B51D: 9D 8D 06 sta	$068d, x
B520: A5 1B    lda	$001b
B522: 9D 8F 06 sta	$068f, x
B525: A5 1C    lda	$001c
B527: 9D 91 06 sta	$0691, x
B52A: A5 1D    lda	$001d
B52C: 9D 93 06 sta	$0693, x
B52F: A5 08    lda	$0008
B531: D0 03    bne	$b536
B533: 20 3F B5 jsr	$b53f
B536: 20 D0 A2 jsr	$a2d0
B539: A9 1E    lda #$1e
B53B: 9D 79 06 sta	$0679, x
B53E: 60       rts
B53F: 8A       txa
B540: 85 1E    sta	$001e
B542: 0A       asl a
B543: 65 1E    adc	$001e
B545: 0A       asl a
B546: A8       tay
B547: A5 1D    lda	$001d
B549: 18       clc
B54A: 79 05 06 adc	$0605, y
B54D: C9 3A    cmp #$3a
B54F: 90 03    bcc	$b554
B551: E9 0A    sbc #$0a
B553: 38       sec
B554: 99 05 06 sta	$0605, y
B557: B9 04 06 lda	$0604, y
B55A: 65 1C    adc	$001c
B55C: C9 3A    cmp #$3a
B55E: 90 03    bcc	$b563
B560: E9 0A    sbc #$0a
B562: 38       sec
B563: 99 04 06 sta	$0604, y
B566: B9 03 06 lda	$0603, y
B569: 65 1B    adc	$001b
B56B: C9 3A    cmp #$3a
B56D: 90 03    bcc	$b572
B56F: E9 0A    sbc #$0a
B571: 38       sec
B572: 99 03 06 sta	$0603, y
B575: B9 02 06 lda	$0602, y
B578: 69 00    adc #$00
B57A: C9 3A    cmp #$3a
B57C: 90 03    bcc	$b581
B57E: E9 0A    sbc #$0a
B580: 38       sec
B581: 99 02 06 sta	$0602, y
B584: B9 01 06 lda	$0601, y
B587: 69 00    adc #$00
B589: C9 3A    cmp #$3a
B58B: 90 03    bcc	$b590
B58D: E9 0A    sbc #$0a
B58F: 38       sec
B590: 99 01 06 sta	$0601, y
B593: B9 00 06 lda	$0600, y
B596: 69 00    adc #$00
B598: C9 3A    cmp #$3a
B59A: 90 02    bcc	$b59e
B59C: E9 0A    sbc #$0a
B59E: 99 00 06 sta	$0600, y
B5A1: F6 79    inc	$0079, x
B5A3: 60       rts
B5A4: 8A       txa
B5A5: 0A       asl a
B5A6: A8       tay
B5A7: B9 15 06 lda	$0615, y
B5AA: 95 91    sta	$0091, x
B5AC: A8       tay
B5AD: AD BB 08 lda	$08bb
B5B0: 29 03    and #$03
B5B2: 0A       asl a
B5B3: 0A       asl a
B5B4: 0A       asl a
B5B5: 0A       asl a
B5B6: 8D 4D 06 sta	$064d
B5B9: 98       tya
B5BA: 18       clc
B5BB: 6D 4D 06 adc	$064d
B5BE: A8       tay
B5BF: B9 C5 B5 lda	$b5c5, y
B5C2: 95 91    sta	$0091, x
B5C4: 60       rts

B605: A2 07    ldx #$07                                            
B607: B5 79    lda $79, x                                          
B609: F0 5B    beq $b666                                           
B60B: A9 00    lda #$00
B60D: 95 79    sta	$0079, x
B60F: 86 1D    stx	$001d
B611: 8A       txa
B612: 0A       asl a
B613: A8       tay
B614: B9 72 B6 lda	$b672, y
B617: 85 00    sta	$0000
B619: 85 1B    sta	$001b
B61B: B9 73 B6 lda	$b673, y
B61E: 85 01    sta	$0001
B620: 85 1C    sta	$001c
B622: 24 0B    bit	$000b
B624: 10 0E    bpl	$b634
B626: A5 08    lda	$0008
B628: 30 0A    bmi	$b634
B62A: C0 08    cpy #$08
B62C: 90 06    bcc	$b634
B62E: C0 0C    cpy #$0c
B630: B0 02    bcs	$b634
B632: A0 10    ldy #$10
B634: B9 82 B6 lda	$b682, y
B637: 85 02    sta	$0002
B639: B9 83 B6 lda	$b683, y
B63C: 85 03    sta	$0003
B63E: 84 1F    sty	$001f
B640: A4 1D    ldy	$001d
B642: B9 6A B6 lda	$b66a, y
B645: 85 1E    sta	$001e
B647: A0 00    ldy #$00
B649: B1 1B    lda ($1b), y
B64B: C9 30    cmp #$30
B64D: D0 0B    bne	$b65a
B64F: E6 00    inc	$0000
B651: C6 1E    dec	$001e
B653: C8       iny
B654: A5 1E    lda	$001e
B656: C9 02    cmp #$02
B658: B0 EF    bcs	$b649
B65A: BD 94 B6 lda	$b694, x
B65D: 85 05    sta	$0005
B65F: A5 1E    lda	$001e
B661: 20 CC D5 jsr	$d5cc
B664: A6 1D    ldx	$001d
B666: CA       dex
B667: 10 9E    bpl	$b607
B669: 60       rts

B69C: A9 03    lda #$03                                            
B69E: 85 2B    sta $2b                                             
B6A0: A9 00    lda #$00                                            
B6A2: 85 2E    sta	$002e
B6A4: A9 16    lda #$16
B6A6: 85 2D    sta	$002d
B6A8: A6 2F    ldx	$002f
B6AA: BD B0 B6 lda	$b6b0, x
B6AD: 85 2C    sta	$002c
B6AF: 60       rts

B6CE: A5 2B    lda $2b                                             
B6D0: C9 03    cmp #$03                                            
B6D2: D0 55    bne $b729                                           
B6D4: A4 2E    ldy $2e                                             
B6D6: 20 52 89 jsr $8952                                           
B6D9: A5 11    lda $11                                             
B6DB: D0 4C    bne $b729                                           
B6DD: A5 2E    lda $2e                                             
B6DF: D0 12    bne $b6f3                                           
B6E1: A5 77    lda	$0077
B6E3: F0 05    beq	$b6ea
B6E5: A2 00    ldx #$00
B6E7: 20 5E B4 jsr	$b45e
B6EA: A5 78    lda	$0078
B6EC: F0 05    beq	$b6f3
B6EE: A2 01    ldx #$01
B6F0: 20 5E B4 jsr	$b45e
B6F3: E6 2E    inc	$002e
B6F5: A5 2E    lda	$002e
B6F7: C9 06    cmp #$06
B6F9: D0 2E    bne	$b729
B6FB: A9 05    lda #$05
B6FD: 85 2E    sta	$002e
B6FF: A9 01    lda #$01
B701: 85 2B    sta	$002b
B703: A5 2C    lda	$002c
B705: 20 70 D6 jsr	$d670
B708: A5 2C    lda	$002c
B70A: C9 0C    cmp #$0c
B70C: D0 1B    bne	$b729
B70E: A6 2F    ldx	$002f
B710: BD AA B7 lda	$b7aa, x
B713: 8D A2 17 sta	$17a2
B716: A9 B0    lda #$b0
B718: 8D A3 17 sta	$17a3
B71B: BD C5 B7 lda	$b7c5, x
B71E: 38       sec
B71F: E9 01    sbc #$01
B721: 8D A4 17 sta	$17a4
B724: A9 B0    lda #$b0
B726: 8D A5 17 sta	$17a5
B729: A5 2B    lda	$002b
B72B: C9 01    cmp #$01
B72D: F0 01    beq	$b730
B72F: 60       rts
B730: A5 29    lda	$0029
B732: 05 2A    ora	$002a
B734: 29 01    and #$01
B736: F0 04    beq	$b73c
B738: A9 01    lda #$01
B73A: 85 2D    sta	$002d
B73C: A5 12    lda	$0012
B73E: D0 69    bne	$b7a9
B740: C6 2D    dec	$002d
B742: A5 2D    lda	$002d
B744: D0 63    bne	$b7a9
B746: A9 0B    lda #$0b
B748: 20 70 D6 jsr	$d670
B74B: A9 0E    lda #$0e
B74D: 20 70 D6 jsr	$d670
B750: A9 00    lda #$00
B752: 85 08    sta	$0008
B754: 85 2B    sta	$002b
B756: A6 2F    ldx	$002f
B758: BD AA B7 lda	$b7aa, x
B75B: 85 30    sta	$0030
B75D: 85 32    sta	$0032
B75F: BD C5 B7 lda	$b7c5, x
B762: 85 31    sta	$0031
B764: 85 33    sta	$0033
B766: BD E0 B7 lda	$b7e0, x
B769: 8D BB 06 sta	$06bb
B76C: 8D BC 06 sta	$06bc
B76F: AD 15 06 lda	$0615
B772: 0A       asl a
B773: 0A       asl a
B774: 0A       asl a
B775: 18       clc
B776: 6D BB 06 adc	$06bb
B779: A8       tay
B77A: B9 28 C0 lda	$c028, y
B77D: 8D BB 06 sta	$06bb
B780: AD 17 06 lda	$0617
B783: 0A       asl a
B784: 0A       asl a
B785: 0A       asl a
B786: 18       clc
B787: 6D BC 06 adc	$06bc
B78A: A8       tay
B78B: B9 28 C0 lda	$c028, y
B78E: 8D BC 06 sta	$06bc
B791: 20 FB B7 jsr	$b7fb
B794: A2 00    ldx #$00
B796: B5 77    lda	$0077, x
B798: F0 03    beq	$b79d
B79A: 20 C9 A7 jsr	$a7c9
B79D: A2 01    ldx #$01
B79F: B5 77    lda	$0077, x
B7A1: F0 03    beq	$b7a6
B7A3: 20 C9 A7 jsr	$a7c9
B7A6: 20 1C B8 jsr	$b81c
B7A9: 60       rts

B7FB: A9 00    lda #$00
B7FD: 8D B5 06 sta	$06b5
B800: 8D B6 06 sta	$06b6
B803: 8D B7 06 sta	$06b7
B806: 8D B8 06 sta	$06b8
B809: A0 00    ldy #$00
B80B: 8C A4 06 sty	$06a4
B80E: 20 B7 89 jsr	$89b7
B811: A0 01    ldy #$01
B813: 8C A4 06 sty	$06a4
B816: A0 00    ldy #$00
B818: 20 B7 89 jsr	$89b7
B81B: 60       rts
B81C: A5 2F    lda	$002f
B81E: 29 03    and #$03
B820: D0 05    bne	$b827
B822: A9 05    lda #$05
B824: B8       clv
B825: 50 14    bvc	$b83b
B827: C9 01    cmp #$01
B829: D0 05    bne	$b830
B82B: A9 06    lda #$06
B82D: B8       clv
B82E: 50 0B    bvc	$b83b
B830: C9 02    cmp #$02
B832: D0 05    bne	$b839
B834: A9 07    lda #$07
B836: B8       clv
B837: 50 02    bvc	$b83b
B839: A9 08    lda #$08
B83B: 20 59 E6 jsr	$e659
B83E: 60       rts
B83F: A9 02    lda #$02
B841: 85 3A    sta	$003a
B843: A9 63    lda #$63
B845: 85 39    sta	$0039
B847: A9 88    lda #$88
B849: 85 3D    sta	$003d
B84B: A9 12    lda #$12
B84D: 85 3E    sta	$003e
B84F: A4 2F    ldy	$002f
B851: B9 AA B7 lda	$b7aa, y
B854: 85 30    sta	$0030
B856: B9 C5 B7 lda	$b7c5, y
B859: 85 31    sta	$0031
B85B: A9 1A    lda #$1a
B85D: 20 59 E6 jsr	$e659
B860: A9 01    lda #$01
B862: 85 35    sta	$0035
B864: 85 37    sta	$0037
B866: A9 78    lda #$78
B868: 85 41    sta	$0041
B86A: 8D 70 06 sta	$0670
B86D: D0 2E    bne	$b89d
B86F: A9 04    lda #$04
B871: 85 3C    sta	$003c
B873: A9 63    lda #$63
B875: 85 3B    sta	$003b
B877: A9 B8    lda #$b8
B879: 85 3F    sta	$003f
B87B: A9 12    lda #$12
B87D: 85 40    sta	$0040
B87F: A4 2F    ldy	$002f
B881: B9 AA B7 lda	$b7aa, y
B884: 85 32    sta	$0032
B886: B9 C5 B7 lda	$b7c5, y
B889: 85 33    sta	$0033
B88B: A9 1A    lda #$1a
B88D: 20 59 E6 jsr	$e659
B890: A9 01    lda #$01
B892: 85 36    sta	$0036
B894: 85 37    sta	$0037
B896: A9 78    lda #$78
B898: 8D 72 06 sta	$0672
B89B: 85 42    sta	$0042
B89D: BC 76 BA ldy	$ba76, x
B8A0: B9 77 00 lda	$0077, y
B8A3: D0 08    bne	$b8ad
B8A5: A9 09    lda #$09
B8A7: 20 59 E6 jsr	$e659
B8AA: B8       clv
B8AB: 50 0A    bvc	$b8b7
B8AD: B9 35 00 lda	$0035, y
B8B0: F0 05    beq	$b8b7
B8B2: A9 09    lda #$09
B8B4: 20 59 E6 jsr	$e659
B8B7: A9 0C    lda #$0c
B8B9: 4C 59 E6 jmp	$e659
B8BC: B5 35    lda	$0035, x
B8BE: D0 01    bne	$b8c1
B8C0: 60       rts
B8C1: B5 35    lda	$0035, x
B8C3: C9 01    cmp #$01
B8C5: D0 75    bne	$b93c
B8C7: B5 41    lda	$0041, x
B8C9: C9 78    cmp #$78
B8CB: D0 20    bne	$b8ed
B8CD: BC 76 BA ldy	$ba76, x
B8D0: B9 77 00 lda	$0077, y
B8D3: D0 0F    bne	$b8e4
B8D5: A9 09    lda #$09
B8D7: 20 59 E6 jsr	$e659
B8DA: A9 0B    lda #$0b
B8DC: 20 70 D6 jsr	$d670
B8DF: A9 21    lda #$21
B8E1: B8       clv
B8E2: 50 06    bvc	$b8ea
B8E4: 20 D3 BC jsr	$bcd3
B8E7: BD 78 BA lda	$ba78, x
B8EA: 20 70 D6 jsr	$d670
B8ED: D6 41    dec	$0041, x
B8EF: D0 4B    bne	$b93c
B8F1: BC 76 BA ldy	$ba76, x
B8F4: B9 77 00 lda	$0077, y
B8F7: D0 09    bne	$b902
B8F9: A9 03    lda #$03
B8FB: 95 35    sta	$0035, x
B8FD: A9 1E    lda #$1e
B8FF: B8       clv
B900: 50 1F    bvc	$b921
B902: B5 35    lda	$0035, x
B904: D9 35 00 cmp	$0035, y
B907: 90 12    bcc	$b91b
B909: 20 D3 BC jsr	$bcd3
B90C: BD 7A BA lda	$ba7a, x
B90F: 20 70 D6 jsr	$d670
B912: A9 02    lda #$02
B914: 95 35    sta	$0035, x
B916: A9 C8    lda #$c8
B918: B8       clv
B919: 50 06    bvc	$b921
B91B: A9 03    lda #$03
B91D: 95 35    sta	$0035, x
B91F: A9 1E    lda #$1e
B921: 95 41    sta	$0041, x
B923: A9 00    lda #$00
B925: 9D 8D 06 sta	$068d, x
B928: 9D 8F 06 sta	$068f, x
B92B: 9D 91 06 sta	$0691, x
B92E: 9D 93 06 sta	$0693, x
B931: 9D 95 06 sta	$0695, x
B934: 9D 97 06 sta	$0697, x
B937: A9 05    lda #$05
B939: 20 6F A2 jsr	$a26f
B93C: B5 35    lda	$0035, x
B93E: C9 02    cmp #$02
B940: D0 61    bne	$b9a3
B942: A9 00    lda #$00
B944: 85 1B    sta	$001b
B946: 85 1D    sta	$001d
B948: A9 01    lda #$01
B94A: 85 1C    sta	$001c
B94C: 20 3F B5 jsr	$b53f
B94F: BD 91 06 lda	$0691, x
B952: 18       clc
B953: 69 01    adc #$01
B955: C9 0A    cmp #$0a
B957: 90 02    bcc	$b95b
B959: A9 00    lda #$00
B95B: 9D 91 06 sta	$0691, x
B95E: BD 8F 06 lda	$068f, x
B961: 69 00    adc #$00
B963: C9 0A    cmp #$0a
B965: 90 02    bcc	$b969
B967: A9 00    lda #$00
B969: 9D 8F 06 sta	$068f, x
B96C: BD 8D 06 lda	$068d, x
B96F: 69 00    adc #$00
B971: C9 0A    cmp #$0a
B973: 90 02    bcc	$b977
B975: A9 00    lda #$00
B977: 9D 8D 06 sta	$068d, x
B97A: 20 D0 A2 jsr	$a2d0
B97D: D6 41    dec	$0041, x
B97F: D0 22    bne	$b9a3
B981: BD 7E BA lda	$ba7e, x
B984: 20 70 D6 jsr	$d670
B987: A9 03    lda #$03
B989: 95 35    sta	$0035, x
B98B: A9 1E    lda #$1e
B98D: 95 41    sta	$0041, x
B98F: A9 00    lda #$00
B991: 9D 8D 06 sta	$068d, x
B994: 9D 8F 06 sta	$068f, x
B997: 9D 91 06 sta	$0691, x
B99A: 9D 93 06 sta	$0693, x
B99D: 9D 95 06 sta	$0695, x
B9A0: 9D 97 06 sta	$0697, x
B9A3: B5 35    lda	$0035, x
B9A5: C9 03    cmp #$03
B9A7: D0 3E    bne	$b9e7
B9A9: B5 41    lda	$0041, x
B9AB: C9 1E    cmp #$1e
B9AD: D0 1E    bne	$b9cd
B9AF: BC 76 BA ldy	$ba76, x
B9B2: B9 77 00 lda	$0077, y
B9B5: D0 0A    bne	$b9c1
B9B7: A9 0B    lda #$0b
B9B9: 20 70 D6 jsr	$d670
B9BC: A9 0D    lda #$0d
B9BE: B8       clv
B9BF: 50 06    bvc	$b9c7
B9C1: 20 D3 BC jsr	$bcd3
B9C4: BD 7C BA lda	$ba7c, x
B9C7: 20 70 D6 jsr	$d670
B9CA: B8       clv
B9CB: 50 0D    bvc	$b9da
B9CD: B5 41    lda	$0041, x
B9CF: D0 09    bne	$b9da
B9D1: A5 0F    lda	$000f
B9D3: 29 03    and #$03
B9D5: D0 03    bne	$b9da
B9D7: 20 A9 BA jsr	$baa9
B9DA: B5 41    lda	$0041, x
B9DC: F0 09    beq	$b9e7
B9DE: D6 41    dec	$0041, x
B9E0: D0 05    bne	$b9e7
B9E2: A9 05    lda #$05
B9E4: 20 6F A2 jsr	$a26f
B9E7: B5 35    lda	$0035, x
B9E9: C9 04    cmp #$04
B9EB: D0 53    bne	$ba40
B9ED: BC 76 BA ldy	$ba76, x
B9F0: B9 77 00 lda	$0077, y
B9F3: D0 1E    bne	$ba13
B9F5: A5 44    lda	$0044
B9F7: C9 02    cmp #$02
B9F9: D0 06    bne	$ba01
B9FB: 20 80 BA jsr	$ba80
B9FE: B8       clv
B9FF: 50 0F    bvc	$ba10
BA01: A9 1E    lda #$1e
BA03: 85 43    sta	$0043
BA05: A9 09    lda #$09
BA07: 20 59 E6 jsr	$e659
BA0A: A9 00    lda #$00
BA0C: 85 35    sta	$0035
BA0E: 85 36    sta	$0036
BA10: B8       clv
BA11: 50 2D    bvc	$ba40
BA13: B9 35 00 lda	$0035, y
BA16: C9 04    cmp #$04
BA18: D0 1E    bne	$ba38
BA1A: A5 44    lda	$0044
BA1C: C9 02    cmp #$02
BA1E: D0 06    bne	$ba26
BA20: 20 80 BA jsr	$ba80
BA23: B8       clv
BA24: 50 0F    bvc	$ba35
BA26: A9 1E    lda #$1e
BA28: 85 43    sta	$0043
BA2A: A9 09    lda #$09
BA2C: 20 59 E6 jsr	$e659
BA2F: A9 00    lda #$00
BA31: 85 35    sta	$0035
BA33: 85 36    sta	$0036
BA35: B8       clv
BA36: 50 08    bvc	$ba40
BA38: 8A       txa
BA39: 18       clc
BA3A: 7D 9F 06 adc	$069f, x
BA3D: 20 70 D6 jsr	$d670
BA40: B5 35    lda	$0035, x
BA42: C9 05    cmp #$05
BA44: D0 2F    bne	$ba75
BA46: DE 9D 06 dec	$069d, x
BA49: BD 9D 06 lda	$069d, x
BA4C: 4A       lsr a
BA4D: 4A       lsr a
BA4E: 4A       lsr a
BA4F: 29 01    and #$01
BA51: D0 0A    bne	$ba5d
BA53: 8A       txa
BA54: 18       clc
BA55: 69 11    adc #$11
BA57: 20 70 D6 jsr	$d670
BA5A: B8       clv
BA5B: 50 07    bvc	$ba64
BA5D: 8A       txa
BA5E: 18       clc
BA5F: 69 14    adc #$14
BA61: 20 70 D6 jsr	$d670
BA64: BD 9D 06 lda	$069d, x
BA67: D0 0C    bne	$ba75
BA69: A9 00    lda #$00
BA6B: 95 35    sta	$0035, x
BA6D: A9 01    lda #$01
BA6F: 9D 9B 06 sta	$069b, x
BA72: 4C 4E AD jmp	$ad4e
BA75: 60       rts

BA80: A9 01    lda #$01                                            
BA82: 8D A5 06 sta $06a5                                           
BA85: A9 00    lda #$00
BA87: 8D B1 06 sta	$06b1
BA8A: 8D B2 06 sta	$06b2
BA8D: 8D B3 06 sta	$06b3
BA90: AD A7 06 lda	$06a7
BA93: D0 05    bne	$ba9a
BA95: A9 10    lda #$10
BA97: B8       clv
BA98: 50 0B    bvc	$baa5
BA9A: C9 01    cmp #$01
BA9C: D0 05    bne	$baa3
BA9E: A9 11    lda #$11
BAA0: B8       clv
BAA1: 50 02    bvc	$baa5
BAA3: A9 0F    lda #$0f
BAA5: 20 59 E6 jsr	$e659
BAA8: 60       rts
BAA9: 8A       txa
BAAA: 0A       asl a
BAAB: A8       tay
BAAC: B9 39 00 lda	$0039, y
BAAF: 85 1D    sta	$001d
BAB1: B9 3A 00 lda	$003a, y
BAB4: 85 1E    sta	$001e
BAB6: A0 00    ldy #$00
BAB8: 98       tya
BAB9: 11 1D    ora ($1d), y
BABB: C8       iny
BABC: C0 0A    cpy #$0a
BABE: 90 F9    bcc	$bab9
BAC0: C9 00    cmp #$00
BAC2: D0 76    bne	$bb3a
BAC4: 08       php
BAC5: 78       sei
; switch to bank 1
BAC6: AD 00 60 lda bank_switch_start_6000
BAC9: AD 47 75 lda	$7547
BACC: AD B0 60 lda	$60b0
BACF: AD 41 75 lda	$7541
BAD2: AD 43 75 lda	$7543
BAD5: AD 55 75 lda	$7555
BAD8: AD 90 60 lda	$6090
BADB: 28       plp
BADC: AD 05 65 lda	$6505
BADF: 8D 00 01 sta	$0100
BAE2: A9 F0    lda #$f0
BAE4: 8D 01 01 sta	$0101
BAE7: 8D 13 01 sta	$0113
BAEA: AD 09 65 lda	$6509
BAED: 8D 12 01 sta	$0112
BAF0: A0 00    ldy #$00
BAF2: AD 07 65 lda	$6507
BAF5: 99 02 01 sta	$0102, y
BAF8: C8       iny
BAF9: A9 F0    lda #$f0
BAFB: 99 02 01 sta	$0102, y
BAFE: C8       iny
BAFF: C0 10    cpy #$10
BB01: 90 EF    bcc	$baf2
BB03: 8A       txa
BB04: 0A       asl a
BB05: AA       tax
BB06: A9 00    lda #$00
BB08: 85 00    sta	$0000
BB0A: A9 01    lda #$01
BB0C: 85 01    sta	$0001
BB0E: B5 3D    lda	$003d, x
BB10: 85 02    sta	$0002
BB12: B5 3E    lda	$003e, x
BB14: 85 03    sta	$0003
BB16: A9 0A    lda #$0a
BB18: 20 33 D6 jsr	$d633
BB1B: B5 39    lda	$0039, x
BB1D: 18       clc
BB1E: 69 10    adc #$10
BB20: 95 39    sta	$0039, x
BB22: 90 02    bcc	$bb26
BB24: F6 3A    inc	$003a, x
BB26: B5 3D    lda	$003d, x
BB28: 18       clc
BB29: 69 80    adc #$80
BB2B: 95 3D    sta	$003d, x
BB2D: 90 02    bcc	$bb31
BB2F: F6 3E    inc	$003e, x
BB31: 8A       txa
BB32: 4A       lsr a
BB33: AA       tax
BB34: 20 90 BB jsr	$bb90
BB37: B8       clv
BB38: 50 50    bvc	$bb8a
BB3A: A9 04    lda #$04
BB3C: 95 35    sta	$0035, x
BB3E: A9 2D    lda #$2d
BB40: 9D 77 06 sta	$0677, x
BB43: A9 00    lda #$00
BB45: 9D 79 06 sta	$0679, x
BB48: BD 76 BA lda	$ba76, x
BB4B: A8       tay
BB4C: B9 77 00 lda	$0077, y
BB4F: F0 2E    beq	$bb7f
BB51: B9 35 00 lda	$0035, y
BB54: D0 29    bne	$bb7f
BB56: 98       tya
BB57: 0A       asl a
BB58: A8       tay
BB59: B9 30 00 lda	$0030, y
BB5C: C9 30    cmp #$30
BB5E: D0 13    bne	$bb73
BB60: B9 31 00 lda	$0031, y
BB63: C9 35    cmp #$35
BB65: B0 0C    bcs	$bb73
BB67: A9 04    lda #$04
BB69: 95 35    sta	$0035, x
BB6B: A9 4C    lda #$4c
BB6D: 9D 9F 06 sta	$069f, x
BB70: 4C 8A BB jmp	$bb8a
BB73: 20 D3 BC jsr	$bcd3
BB76: A9 05    lda #$05
BB78: 95 35    sta	$0035, x
BB7A: A9 7D    lda #$7d
BB7C: 9D 9D 06 sta	$069d, x
BB7F: B5 35    lda	$0035, x
BB81: C9 04    cmp #$04
BB83: D0 05    bne	$bb8a
BB85: A9 4C    lda #$4c
BB87: 9D 9F 06 sta	$069f, x
BB8A: A9 1B    lda #$1b
BB8C: 20 59 E6 jsr	$e659
BB8F: 60       rts
BB90: BD 97 06 lda	$0697, x
BB93: 18       clc
BB94: 69 01    adc #$01
BB96: C9 0A    cmp #$0a
BB98: 90 02    bcc	$bb9c
BB9A: A9 00    lda #$00
BB9C: 9D 97 06 sta	$0697, x
BB9F: 85 1C    sta	$001c
BBA1: BD 95 06 lda	$0695, x
BBA4: 69 00    adc #$00
BBA6: C9 0A    cmp #$0a
BBA8: 90 02    bcc	$bbac
BBAA: A9 00    lda #$00
BBAC: 9D 95 06 sta	$0695, x
BBAF: 85 1B    sta	$001b
BBB1: A9 00    lda #$00
BBB3: 85 1D    sta	$001d
BBB5: 20 3F B5 jsr	$b53f
BBB8: A9 19    lda #$19
BBBA: 20 59 E6 jsr	$e659
BBBD: F8       sed
BBBE: BD 91 06 lda	$0691, x
BBC1: 18       clc
BBC2: 7D 97 06 adc	$0697, x
BBC5: C9 0A    cmp #$0a
BBC7: 90 03    bcc	$bbcc
BBC9: 29 0F    and #$0f
BBCB: 38       sec
BBCC: 9D 91 06 sta	$0691, x
BBCF: BD 8F 06 lda	$068f, x
BBD2: 7D 95 06 adc	$0695, x
BBD5: C9 0A    cmp #$0a
BBD7: 90 03    bcc	$bbdc
BBD9: 29 0F    and #$0f
BBDB: 38       sec
BBDC: 9D 8F 06 sta	$068f, x
BBDF: BD 8D 06 lda	$068d, x
BBE2: 69 00    adc #$00
BBE4: C9 0A    cmp #$0a
BBE6: 90 03    bcc	$bbeb
BBE8: 29 0F    and #$0f
BBEA: 38       sec
BBEB: 9D 8D 06 sta	$068d, x
BBEE: D8       cld
BBEF: 4C D0 A2 jmp	$a2d0
BBF2: A5 43    lda	$0043
BBF4: C9 0A    cmp #$0a
BBF6: 90 05    bcc	$bbfd
BBF8: C6 43    dec	$0043
BBFA: B8       clv
BBFB: 50 18    bvc	$bc15
BBFD: A4 2E    ldy	$002e
BBFF: 20 52 89 jsr	$8952
BC02: A5 11    lda	$0011
BC04: D0 0F    bne	$bc15
BC06: C6 2E    dec	$002e
BC08: A5 2E    lda	$002e
BC0A: C9 00    cmp #$00
BC0C: D0 07    bne	$bc15
BC0E: A9 00    lda #$00
BC10: 85 43    sta	$0043
BC12: 20 34 AB jsr	$ab34
BC15: 60       rts
BC16: A9 20    lda #$20
BC18: 85 AD    sta	$00ad
BC1A: A9 1E    lda #$1e
BC1C: 85 AE    sta	$00ae
BC1E: A0 00    ldy #$00
BC20: AD BC 08 lda	$08bc
BC23: 29 E0    and #$e0
BC25: C9 E0    cmp #$e0
BC27: D0 0D    bne	$bc36
BC29: B9 7A BC lda	$bc7a, y
BC2C: 91 AD    sta ($ad), y
BC2E: C8       iny
BC2F: C0 14    cpy #$14
BC31: 90 F6    bcc	$bc29
BC33: B8       clv
BC34: 50 35    bvc	$bc6b
BC36: B9 6C BC lda	$bc6c, y
BC39: 91 AD    sta ($ad), y
BC3B: C8       iny
BC3C: C0 0E    cpy #$0e
BC3E: 90 F6    bcc	$bc36
BC40: C8       iny
BC41: C8       iny
BC42: AD 18 06 lda	$0618
BC45: 91 AD    sta ($ad), y
BC47: C8       iny
BC48: A9 A0    lda #$a0
BC4A: 91 AD    sta ($ad), y
BC4C: C8       iny
BC4D: 8A       txa
BC4E: 48       pha
BC4F: AD C0 00 lda	$00c0
BC52: 29 03    and #$03
BC54: F0 13    beq	$bc69
BC56: 0A       asl a
BC57: 0A       asl a
BC58: 6D C3 00 adc	$00c3
BC5B: 6D C4 00 adc	$00c4
BC5E: AA       tax
BC5F: BD 8E BC lda	$bc8e, x
BC62: 91 AD    sta ($ad), y
BC64: C8       iny
BC65: A9 A0    lda #$a0
BC67: 91 AD    sta ($ad), y
BC69: 68       pla
BC6A: AA       tax
BC6B: 60       rts

BC9E: BD 9B 06 lda $069b, x                                        
BCA1: D0 01    bne $bca4                                           
BCA3: 60       rts                                                 
BCA4: BD 76 BA lda	$ba76, x
BCA7: A8       tay
BCA8: B9 35 00 lda	$0035, y
BCAB: F0 03    beq	$bcb0
BCAD: 4C C0 BC jmp	$bcc0
BCB0: B9 77 00 lda	$0077, y
BCB3: D0 0A    bne	$bcbf
BCB5: 8A       txa
BCB6: 18       clc
BCB7: 69 18    adc #$18
BCB9: 20 70 D6 jsr	$d670
BCBC: 4C C0 BC jmp	$bcc0
BCBF: 60       rts
BCC0: A9 00    lda #$00
BCC2: 9D 9B 06 sta	$069b, x
BCC5: 95 95    sta	$0095, x
BCC7: 95 93    sta	$0093, x
BCC9: A9 04    lda #$04
BCCB: 95 35    sta	$0035, x
BCCD: A9 18    lda #$18
BCCF: 9D 9F 06 sta	$069f, x
BCD2: 60       rts
BCD3: 8E C0 05 stx	$05c0
BCD6: 8A       txa
BCD7: 0A       asl a
BCD8: 0A       asl a
BCD9: 0A       asl a
BCDA: 6D C0 05 adc	$05c0
BCDD: 6D C0 05 adc	$05c0
BCE0: AA       tax
BCE1: A0 00    ldy #$00
BCE3: BD 24 BD lda	$bd24, x
BCE6: 85 02    sta	$0002
BCE8: E8       inx
BCE9: BD 24 BD lda	$bd24, x
BCEC: 85 03    sta	$0003
BCEE: E8       inx
BCEF: A9 0A    lda #$0a
BCF1: 85 00    sta	$0000
BCF3: A9 BD    lda #$bd
BCF5: 85 01    sta	$0001
BCF7: A9 50    lda #$50
BCF9: 85 05    sta	$0005
BCFB: A9 0F    lda #$0f
BCFD: 20 CC D5 jsr	$d5cc
BD00: C8       iny
BD01: 98       tya
BD02: C9 05    cmp #$05
BD04: D0 DD    bne	$bce3
BD06: AE C0 05 ldx	$05c0
BD09: 60       rts

BD2E: 36 10    rol	$0010, x
BD30: B6 10    ldx	$0010, y
BD32: 36 11    rol	$0011, x
BD34: B6 11    ldx	$0011, y
BD36: 36 12    rol	$0012, x
BD38: AD B1 06 lda	$06b1
BD3B: D0 30    bne	$bd6d
BD3D: A5 29    lda	$0029
BD3F: 05 2A    ora	$002a
BD41: 29 01    and #$01
BD43: F0 28    beq	$bd6d
BD45: EE B3 06 inc	$06b3
BD48: AD B3 06 lda	$06b3
BD4B: C9 02    cmp #$02
BD4D: 90 1E    bcc	$bd6d
BD4F: A9 01    lda #$01
BD51: 8D B1 06 sta	$06b1
BD54: 8D B2 06 sta	$06b2
BD57: A9 00    lda #$00
BD59: 8D C0 06 sta	$06c0
BD5C: 8D C1 06 sta	$06c1
BD5F: A5 0F    lda	$000f
BD61: 29 03    and #$03
BD63: D0 08    bne	$bd6d
BD65: A9 01    lda #$01
BD67: 8D C0 06 sta	$06c0
BD6A: 8D C1 06 sta	$06c1
BD6D: EE A6 06 inc	$06a6
BD70: AD A6 06 lda	$06a6
BD73: C9 05    cmp #$05
BD75: B0 01    bcs	$bd78
BD77: 60       rts
BD78: A9 00    lda #$00
BD7A: 8D A6 06 sta	$06a6
BD7D: AD A5 06 lda	$06a5
BD80: D0 01    bne	$bd83
BD82: 60       rts
BD83: A9 00    lda #$00
BD85: 8D BF 06 sta	$06bf
BD88: A9 00    lda #$00
BD8A: 8D A4 06 sta	$06a4
BD8D: A5 77    lda	$0077
BD8F: D0 03    bne	$bd94
BD91: 4C 3B BE jmp	$be3b
BD94: 08       php
BD95: 78       sei
; switch to bank 1
BD96: AD 00 60 lda bank_switch_start_6000
BD99: AD 45 75 lda	$7545
BD9C: AD B0 60 lda	$60b0
BD9F: AD 43 75 lda	$7543
BDA2: AD 43 75 lda	$7543
BDA5: AD 43 75 lda	$7543
BDA8: AD 41 75 lda	$7541
BDAB: AD 40 75 lda	$7540
BDAE: AD 52 75 lda	$7552
BDB1: AD B0 60 lda	$60b0
BDB4: 28       plp
BDB5: AC A5 06 ldy	$06a5
BDB8: AD A7 06 lda	$06a7
BDBB: D0 06    bne	$bdc3
BDBD: B9 E0 7D lda	$7de0, y
BDC0: B8       clv
BDC1: 50 0D    bvc	$bdd0
BDC3: C9 01    cmp #$01
BDC5: D0 06    bne	$bdcd
BDC7: B9 5C 7E lda	$7e5c, y
BDCA: B8       clv
BDCB: 50 03    bvc	$bdd0
BDCD: B9 1D 7D lda	$7d1d, y
BDD0: 8D 4D 06 sta	$064d
BDD3: AD B1 06 lda	$06b1
BDD6: C9 01    cmp #$01
BDD8: D0 24    bne	$bdfe
BDDA: AD 4D 06 lda	$064d
BDDD: C9 0B    cmp #$0b
BDDF: D0 08    bne	$bde9
BDE1: A9 02    lda #$02
BDE3: 8D B1 06 sta	$06b1
BDE6: B8       clv
BDE7: 50 15    bvc	$bdfe
BDE9: C9 1D    cmp #$1d
BDEB: D0 08    bne	$bdf5
BDED: A9 02    lda #$02
BDEF: 8D B1 06 sta	$06b1
BDF2: B8       clv
BDF3: 50 09    bvc	$bdfe
BDF5: C9 29    cmp #$29
BDF7: D0 05    bne	$bdfe
BDF9: A9 02    lda #$02
BDFB: 8D B1 06 sta	$06b1
BDFE: AD B1 06 lda	$06b1
BE01: C9 02    cmp #$02
BE03: 90 2F    bcc	$be34
BE05: AD C0 06 lda	$06c0
BE08: D0 15    bne	$be1f
BE0A: AC B1 06 ldy	$06b1
BE0D: C0 0E    cpy #$0e
BE0F: D0 05    bne	$be16
BE11: A9 01    lda #$01
BE13: 8D BF 06 sta	$06bf
BE16: B9 6C 7F lda	$7f6c, y
BE19: EE B1 06 inc	$06b1
BE1C: B8       clv
BE1D: 50 12    bvc	$be31
BE1F: AC B1 06 ldy	$06b1
BE22: C0 17    cpy #$17
BE24: D0 05    bne	$be2b
BE26: A9 01    lda #$01
BE28: 8D BF 06 sta	$06bf
BE2B: B9 54 7F lda	$7f54, y
BE2E: EE B1 06 inc	$06b1
BE31: B8       clv
BE32: 50 03    bvc	$be37
BE34: AD 4D 06 lda	$064d
BE37: A8       tay
BE38: 20 B7 89 jsr	$89b7
BE3B: A9 01    lda #$01
BE3D: 8D A4 06 sta	$06a4
BE40: A5 78    lda	$0078
BE42: D0 03    bne	$be47
BE44: 4C EB BE jmp	$beeb
BE47: 08       php
BE48: 78       sei
; switch to bank 1
BE49: AD 00 60 lda bank_switch_start_6000
BE4C: AD 49 75 lda	$7549
BE4F: AD 80 60 lda	$6080
BE52: AD 40 75 lda	$7540
BE55: AD 5E 75 lda	$755e
BE58: AD 90 60 lda	$6090
BE5B: 28       plp
BE5C: AC A5 06 ldy	$06a5
BE5F: AD A7 06 lda	$06a7
BE62: D0 06    bne	$be6a
BE64: B9 E0 7D lda	$7de0, y
BE67: B8       clv
BE68: 50 16    bvc	$be80
BE6A: C9 01    cmp #$01
BE6C: D0 06    bne	$be74
BE6E: B9 D8 7E lda	$7ed8, y
BE71: B8       clv
BE72: 50 0C    bvc	$be80
BE74: 98       tya
BE75: C9 AC    cmp #$ac
BE77: 90 03    bcc	$be7c
BE79: 18       clc
BE7A: 69 0C    adc #$0c
BE7C: A8       tay
BE7D: B9 1D 7D lda	$7d1d, y
BE80: 8D 4D 06 sta	$064d
BE83: AD B2 06 lda	$06b2
BE86: C9 01    cmp #$01
BE88: D0 24    bne	$beae
BE8A: AD 4D 06 lda	$064d
BE8D: C9 0B    cmp #$0b
BE8F: D0 05    bne	$be96
BE91: A9 02    lda #$02
BE93: 8D B2 06 sta	$06b2
BE96: AD 4D 06 lda	$064d
BE99: C9 1D    cmp #$1d
BE9B: D0 05    bne	$bea2
BE9D: A9 02    lda #$02
BE9F: 8D B2 06 sta	$06b2
BEA2: AD 4D 06 lda	$064d
BEA5: C9 29    cmp #$29
BEA7: D0 05    bne	$beae
BEA9: A9 02    lda #$02
BEAB: 8D B2 06 sta	$06b2
BEAE: AD B2 06 lda	$06b2
BEB1: C9 02    cmp #$02
BEB3: 90 2F    bcc	$bee4
BEB5: AD C1 06 lda	$06c1
BEB8: D0 15    bne	$becf
BEBA: AC B2 06 ldy	$06b2
BEBD: C0 0E    cpy #$0e
BEBF: D0 05    bne	$bec6
BEC1: A9 01    lda #$01
BEC3: 8D BF 06 sta	$06bf
BEC6: B9 7C 7F lda	$7f7c, y
BEC9: EE B2 06 inc	$06b2
BECC: B8       clv
BECD: 50 12    bvc	$bee1
BECF: AC B2 06 ldy	$06b2
BED2: C0 17    cpy #$17
BED4: D0 05    bne	$bedb
BED6: A9 01    lda #$01
BED8: 8D BF 06 sta	$06bf
BEDB: B9 8C 7F lda	$7f8c, y
BEDE: EE B2 06 inc	$06b2
BEE1: B8       clv
BEE2: 50 03    bvc	$bee7
BEE4: AD 4D 06 lda	$064d
BEE7: A8       tay
BEE8: 20 B7 89 jsr	$89b7
BEEB: AD BF 06 lda	$06bf
BEEE: D0 28    bne	$bf18
BEF0: EE A5 06 inc	$06a5
BEF3: AD A7 06 lda	$06a7
BEF6: D0 08    bne	$bf00
BEF8: AD A5 06 lda	$06a5
BEFB: C9 7C    cmp #$7c
BEFD: B8       clv
BEFE: 50 11    bvc	$bf11
BF00: C9 01    cmp #$01
BF02: D0 08    bne	$bf0c
BF04: AD A5 06 lda	$06a5
BF07: C9 7C    cmp #$7c
BF09: B8       clv
BF0A: 50 05    bvc	$bf11
BF0C: AD A5 06 lda	$06a5
BF0F: C9 B6    cmp #$b6
BF11: 90 05    bcc	$bf18
BF13: A9 01    lda #$01
BF15: 8D BF 06 sta	$06bf
BF18: AD BF 06 lda	$06bf
BF1B: F0 23    beq	$bf40
BF1D: A9 00    lda #$00
BF1F: 8D A5 06 sta	$06a5
BF22: A9 1E    lda #$1e
BF24: 85 43    sta	$0043
BF26: A9 00    lda #$00
BF28: 20 59 E6 jsr	$e659
BF2B: A9 00    lda #$00
BF2D: 85 35    sta	$0035
BF2F: 85 36    sta	$0036
BF31: EE A7 06 inc	$06a7
BF34: AD A7 06 lda	$06a7
BF37: C9 03    cmp #$03
BF39: 90 05    bcc	$bf40
BF3B: A9 00    lda #$00
BF3D: 8D A7 06 sta	$06a7
BF40: 60       rts
BF41: BD 9B 06 lda	$069b, x
BF44: F0 01    beq	$bf47
BF46: 60       rts
BF47: A5 08    lda	$0008
BF49: D0 3C    bne	$bf87
BF4B: B5 77    lda	$0077, x
BF4D: F0 38    beq	$bf87
BF4F: B5 35    lda	$0035, x
BF51: D0 34    bne	$bf87
BF53: A5 0F    lda	$000f
BF55: 29 7F    and #$7f
BF57: D0 2E    bne	$bf87
BF59: BD B5 06 lda	$06b5, x
BF5C: D0 29    bne	$bf87
BF5E: FE B7 06 inc	$06b7, x
BF61: BD B7 06 lda	$06b7, x
BF64: DD BB 06 cmp	$06bb, x
BF67: 90 1E    bcc	$bf87
BF69: 8A       txa
BF6A: 0A       asl a
BF6B: A8       tay
BF6C: B9 30 00 lda	$0030, y
BF6F: C9 30    cmp #$30
BF71: D0 14    bne	$bf87
BF73: B9 31 00 lda	$0031, y
BF76: C9 32    cmp #$32
BF78: 90 0D    bcc	$bf87
BF7A: A9 01    lda #$01
BF7C: 9D B5 06 sta	$06b5, x
BF7F: A9 00    lda #$00
BF81: 9D B9 06 sta	$06b9, x
BF84: 9D BD 06 sta	$06bd, x
BF87: 60       rts
BF88: BD B5 06 lda	$06b5, x
BF8B: D0 01    bne	$bf8e
BF8D: 60       rts
BF8E: FE BD 06 inc	$06bd, x
BF91: BD BD 06 lda	$06bd, x
BF94: C9 07    cmp #$07
BF96: B0 01    bcs	$bf99
BF98: 60       rts
BF99: A9 00    lda #$00
BF9B: 9D BD 06 sta	$06bd, x
BF9E: BD B9 06 lda	$06b9, x
BFA1: C9 44    cmp #$44
BFA3: F0 4F    beq	$bff4
BFA5: E0 00    cpx #$00
BFA7: D0 05    bne	$bfae
BFA9: A9 00    lda #$00
BFAB: B8       clv
BFAC: 50 02    bvc	$bfb0
BFAE: A9 01    lda #$01
BFB0: 8D A4 06 sta	$06a4
BFB3: FE B9 06 inc	$06b9, x
BFB6: BD B9 06 lda	$06b9, x
BFB9: A8       tay
BFBA: B9 A8 C0 lda	$c0a8, y
BFBD: A8       tay
BFBE: 20 B7 89 jsr	$89b7
BFC1: BD B9 06 lda	$06b9, x
BFC4: C9 63    cmp #$63
BFC6: D0 0A    bne	$bfd2
BFC8: A9 00    lda #$00
BFCA: 9D B5 06 sta	$06b5, x
BFCD: A9 F0    lda #$f0
BFCF: 9D BB 06 sta	$06bb, x
BFD2: BD B9 06 lda	$06b9, x
BFD5: C9 8B    cmp #$8b
BFD7: D0 0A    bne	$bfe3
BFD9: A9 00    lda #$00
BFDB: 9D B5 06 sta	$06b5, x
BFDE: A9 F0    lda #$f0
BFE0: 9D BB 06 sta	$06bb, x
BFE3: BD B9 06 lda	$06b9, x
BFE6: C9 B3    cmp #$b3
BFE8: D0 0A    bne	$bff4
BFEA: A9 00    lda #$00
BFEC: 9D B5 06 sta	$06b5, x
BFEF: A9 F0    lda #$f0
BFF1: 9D BB 06 sta	$06bb, x
BFF4: B5 77    lda	$0077, x
BFF6: D0 1F    bne	$c017
BFF8: E0 00    cpx #$00
BFFA: D0 0F    bne	$c00b
BFFC: BD B9 06 lda	$06b9, x
BFFF: C9 64    cmp #$64
C001: B0 05    bcs	$c008
C003: A9 64    lda #$64
C005: 9D B9 06 sta	$06b9, x
C008: B8       clv
C009: 50 0C    bvc	$c017
C00B: BD B9 06 lda	$06b9, x
C00E: C9 8C    cmp #$8c
C010: B0 05    bcs	$c017
C012: A9 8C    lda #$8c
C014: 9D B9 06 sta	$06b9, x
C017: B5 35    lda	$0035, x
C019: F0 0C    beq	$c027
C01B: BD B9 06 lda	$06b9, x
C01E: C9 46    cmp #$46
C020: B0 05    bcs	$c027
C022: A9 46    lda #$46
C024: 9D B9 06 sta	$06b9, x
C027: 60       rts

C15C: A2 00    ldx #$00
C15E: A5 08    lda	$0008
C160: F0 67    beq	$c1c9
C162: C9 FC    cmp #$fc
C164: F0 6F    beq	$c1d5
C166: C9 FB    cmp #$fb
C168: F0 10    beq	$c17a
C16A: C9 EF    cmp #$ef
C16C: F0 0C    beq	$c17a
C16E: C9 EE    cmp #$ee
C170: F0 08    beq	$c17a
C172: C9 F0    cmp #$f0
C174: D0 03    bne	$c179
C176: 4C E5 C3 jmp	$c3e5
C179: 60       rts
C17A: 20 52 D5 jsr	$d552
C17D: AD 7D 06 lda	$067d
C180: F0 14    beq	$c196
C182: A5 0F    lda	$000f
C184: 29 3F    and #$3f
C186: D0 0B    bne	$c193
C188: CE 7D 06 dec	$067d
C18B: AD 7D 06 lda	$067d
C18E: D0 03    bne	$c193
C190: 4C BA C1 jmp	$c1ba
C193: B8       clv
C194: 50 15    bvc	$c1ab
C196: A5 14    lda	$0014
C198: C9 04    cmp #$04
C19A: D0 0F    bne	$c1ab
C19C: A5 13    lda	$0013
C19E: C9 20    cmp #$20
C1A0: F0 06    beq	$c1a8
C1A2: 4C AB C1 jmp	$c1ab
C1A5: B8       clv
C1A6: 50 03    bvc	$c1ab
C1A8: 4C BA C1 jmp	$c1ba
C1AB: 20 28 C2 jsr	$c228
C1AE: C9 00    cmp #$00
C1B0: F0 07    beq	$c1b9
C1B2: A9 00    lda #$00
C1B4: 8D 7D 06 sta	$067d
C1B7: F0 01    beq	$c1ba
C1B9: 60       rts
C1BA: A5 08    lda	$0008
C1BC: C9 FB    cmp #$fb
C1BE: D0 06    bne	$c1c6
C1C0: 4C 8F A8 jmp	$a88f
C1C3: B8       clv
C1C4: 50 03    bvc	$c1c9
C1C6: 4C 64 A8 jmp	$a864
C1C9: AD 19 06 lda	$0619
C1CC: C9 03    cmp #$03
C1CE: 90 57    bcc	$c227
C1D0: E8       inx
C1D1: B5 77    lda	$0077, x
C1D3: F0 52    beq	$c227
C1D5: 20 52 D5 jsr	$d552
C1D8: 20 28 C2 jsr	$c228
C1DB: C9 00    cmp #$00
C1DD: D0 09    bne	$c1e8
C1DF: A5 0F    lda	$000f
C1E1: D0 1A    bne	$c1fd
C1E3: CE 81 06 dec	$0681
C1E6: D0 15    bne	$c1fd
C1E8: A9 00    lda #$00
C1EA: 85 77    sta	$0077
C1EC: 85 78    sta	$0078
C1EE: 8D 77 06 sta	$0677
C1F1: 8D 78 06 sta	$0678
C1F4: 8D 79 06 sta	$0679
C1F7: 8D 7A 06 sta	$067a
C1FA: 4C 8C CA jmp	$ca8c
C1FD: A0 00    ldy #$00
C1FF: A5 0F    lda	$000f
C201: 29 07    and #$07
C203: D0 0E    bne	$c213
C205: AD 30 06 lda	$0630
C208: 38       sec
C209: F5 89    sbc	$0089, x
C20B: F0 06    beq	$c213
C20D: A0 04    ldy #$04
C20F: B0 02    bcs	$c213
C211: A0 08    ldy #$08
C213: A5 0F    lda	$000f
C215: 29 07    and #$07
C217: D0 0C    bne	$c225
C219: AD 31 06 lda	$0631
C21C: 38       sec
C21D: F5 8F    sbc	$008f, x
C21F: F0 04    beq	$c225
C221: 98       tya
C222: 09 01    ora #$01
C224: A8       tay
C225: 94 29    sty	$0029, x
C227: 60       rts
C228: AD 6F 06 lda	$066f
C22B: F0 08    beq	$c235
C22D: CE 6F 06 dec	$066f
C230: A9 00    lda #$00
C232: B8       clv
C233: 50 11    bvc	$c246
C235: A5 27    lda	$0027
C237: 29 08    and #$08
C239: F0 0B    beq	$c246
C23B: A5 28    lda	$0028
C23D: 29 04    and #$04
C23F: F0 05    beq	$c246
C241: A9 28    lda #$28
C243: 8D 6F 06 sta	$066f
C246: 60       rts
C247: A2 00    ldx #$00
C249: A5 08    lda	$0008
C24B: C9 00    cmp #$00
C24D: D0 02    bne	$c251
C24F: A2 01    ldx #$01
C251: A5 08    lda	$0008
C253: C9 F7    cmp #$f7
C255: D0 02    bne	$c259
C257: A2 01    ldx #$01
C259: E0 01    cpx #$01
C25B: F0 03    beq	$c260
C25D: 4C EA C2 jmp	$c2ea
C260: A5 0F    lda	$000f
C262: 29 7F    and #$7f
C264: D0 3F    bne	$c2a5
C266: A2 00    ldx #$00
C268: B5 77    lda	$0077, x
C26A: D0 34    bne	$c2a0
C26C: B5 4E    lda	$004e, x
C26E: D0 30    bne	$c2a0
C270: 86 1B    stx	$001b
C272: A9 01    lda #$01
C274: 38       sec
C275: ED 4B 06 sbc	$064b
C278: 8D 4B 06 sta	$064b
C27B: D0 1B    bne	$c298
C27D: AD C1 00 lda number_of_credits_00c1
C280: D0 0B    bne	$c28d
C282: 18       clc
C283: A9 40    lda #$40
C285: 65 1B    adc	$001b
C287: 20 70 D6 jsr	$d670
C28A: B8       clv
C28B: 50 08    bvc	$c295
C28D: 18       clc
C28E: A9 44    lda #$44
C290: 65 1B    adc	$001b
C292: 20 70 D6 jsr	$d670
C295: B8       clv
C296: 50 08    bvc	$c2a0
C298: 18       clc
C299: A9 42    lda #$42
C29B: 65 1B    adc	$001b
C29D: 20 70 D6 jsr	$d670
C2A0: E8       inx
C2A1: E0 02    cpx #$02
C2A3: 90 C3    bcc	$c268
C2A5: A2 00    ldx #$00
C2A7: BD 63 06 lda	$0663, x
C2AA: 30 2D    bmi	$c2d9
C2AC: 20 E4 E7 jsr	$e7e4
C2AF: BD 63 06 lda	$0663, x
C2B2: 10 25    bpl	$c2d9
C2B4: 20 F4 AF jsr	$aff4
C2B7: A5 77    lda	$0077
C2B9: 05 78    ora	$0078
C2BB: D0 1C    bne	$c2d9
C2BD: A5 4E    lda	$004e
C2BF: 05 4F    ora	$004f
C2C1: D0 16    bne	$c2d9
C2C3: BC 76 BA ldy	$ba76, x
C2C6: B9 63 06 lda	$0663, y
C2C9: 10 0E    bpl	$c2d9
C2CB: A9 00    lda #$00
C2CD: 8D 6D 06 sta	$066d
C2D0: 8D C2 00 sta number_of_coins_inserted_00c2
C2D3: 8D C3 00 sta	$00c3
C2D6: 4C AD A5 jmp	$a5ad
C2D9: E8       inx
C2DA: E0 02    cpx #$02
C2DC: 90 C9    bcc	$c2a7
C2DE: 20 EB C2 jsr	$c2eb
C2E1: A5 4E    lda	$004e
C2E3: 05 4F    ora	$004f
C2E5: F0 03    beq	$c2ea
C2E7: 20 E0 A4 jsr	$a4e0
C2EA: 60       rts
C2EB: A2 00    ldx #$00
C2ED: B5 77    lda	$0077, x
C2EF: D0 19    bne	$c30a
C2F1: BD 63 06 lda	$0663, x
C2F4: 10 14    bpl	$c30a
C2F6: B5 4E    lda	$004e, x
C2F8: C9 0A    cmp #$0a
C2FA: B0 0E    bcs	$c30a
C2FC: AD C1 00 lda number_of_credits_00c1
C2FF: F0 09    beq	$c30a
C301: B5 29    lda	$0029, x
C303: 29 01    and #$01
C305: F0 03    beq	$c30a
C307: 20 10 C3 jsr	$c310
C30A: E8       inx
C30B: E0 02    cpx #$02
C30D: 90 DE    bcc	$c2ed
C30F: 60       rts
C310: A9 16    lda #$16
C312: 20 59 E6 jsr	$e659
C315: AD 18 06 lda	$0618
C318: 38       sec
C319: ED 3E CB sbc	$cb3e
C31C: C9 30    cmp #$30
C31E: B0 05    bcs	$c325
C320: A9 14    lda #$14
C322: 4C 59 E6 jmp	$e659
C325: 8D 18 06 sta	$0618
C328: 78       sei
C329: AD C1 00 lda number_of_credits_00c1
C32C: 38       sec
C32D: ED 3E CB sbc	$cb3e
C330: 8D C1 00 sta number_of_credits_00c1
C333: 58       cli
C334: 20 16 BC jsr	$bc16
C337: A9 00    lda #$00
C339: 85 0B    sta	$000b
C33B: 8D 19 06 sta	$0619
C33E: A5 77    lda	$0077
C340: F0 0B    beq	$c34d
C342: A5 78    lda	$0078
C344: F0 07    beq	$c34d
C346: A9 01    lda #$01
C348: 85 0B    sta	$000b
C34A: 8D 19 06 sta	$0619
C34D: 86 1C    stx	$001c
C34F: A9 48    lda #$48
C351: 18       clc
C352: 65 1C    adc	$001c
C354: 20 70 D6 jsr	$d670
C357: 20 D3 BC jsr	$bcd3
C35A: B5 4E    lda	$004e, x
C35C: D0 24    bne	$c382
C35E: 8A       txa
C35F: 49 01    eor #$01
C361: A8       tay
C362: B9 2F 00 lda	$002f, y
C365: C9 06    cmp #$06
C367: 90 04    bcc	$c36d
C369: A9 02    lda #$02
C36B: D0 0A    bne	$c377
C36D: C9 03    cmp #$03
C36F: 90 04    bcc	$c375
C371: A9 01    lda #$01
C373: D0 02    bne	$c377
C375: A9 00    lda #$00
C377: 95 75    sta	$0075, x
C379: 20 1B AC jsr	$ac1b
C37C: 20 F4 AF jsr	$aff4
C37F: B8       clv
C380: 50 0E    bvc	$c390
C382: A9 03    lda #$03
C384: 95 75    sta	$0075, x
C386: A9 00    lda #$00
C388: 95 4E    sta	$004e, x
C38A: 20 62 AD jsr	$ad62
C38D: 20 F4 AF jsr	$aff4
C390: 60       rts

fade_out_C391:
C391: A5 14    lda	$0014
C393: C9 01    cmp #$01
C395: 90 4D    bcc	$c3e4
C397: AD 45 06 lda	$0645
C39A: C9 14    cmp #$14
C39C: D0 06    bne	$c3a4
C39E: 20 7C CC jsr	$cc7c
C3A1: 20 50 CD jsr	$cd50
C3A4: EE 44 06 inc	$0644
C3A7: AD 44 06 lda	$0644
C3AA: C9 08    cmp #$08
C3AC: 90 36    bcc	$c3e4
C3AE: A9 00    lda #$00
C3B0: 8D 44 06 sta	$0644
C3B3: AD 45 06 lda	$0645
C3B6: C9 14    cmp #$14
C3B8: F0 2A    beq	$c3e4
C3BA: AD 45 06 lda	$0645
C3BD: 0A       asl a
C3BE: A8       tay
C3BF: B9 9E CF lda	$cf9e, y
C3C2: 85 47    sta	$0047
C3C4: B9 9F CF lda	$cf9f, y
C3C7: 85 48    sta	$0048
C3C9: A0 00    ldy #$00
C3CB: B1 47    lda ($47), y
C3CD: 99 00 20 sta	$2000, y
C3D0: C8       iny
C3D1: C0 8F    cpy #$8f
C3D3: 90 F6    bcc	$c3cb
C3D5: EE 45 06 inc	$0645
C3D8: AD 45 06 lda	$0645
C3DB: C9 0A    cmp #$0a
C3DD: D0 05    bne	$c3e4
C3DF: A9 14    lda #$14
C3E1: 8D 45 06 sta	$0645
C3E4: 60       rts
C3E5: 20 52 D5 jsr	$d552
C3E8: A5 08    lda	$0008
C3EA: C9 F0    cmp #$f0
C3EC: F0 01    beq	$c3ef
C3EE: 60       rts
C3EF: 20 28 C2 jsr	$c228
C3F2: C9 00    cmp #$00
C3F4: F0 05    beq	$c3fb
C3F6: A9 3B    lda #$3b
C3F8: 8D 7F 06 sta	$067f
C3FB: CE 7E 06 dec	$067e
C3FE: AD 7E 06 lda	$067e
C401: C9 00    cmp #$00
C403: F0 03    beq	$c408
C405: 4C 53 C4 jmp	$c453
C408: A2 00    ldx #$00
C40A: A9 1D    lda #$1d
C40C: 8D 7E 06 sta	$067e
C40F: EE 7F 06 inc	$067f
C412: AC 7F 06 ldy	$067f
C415: C0 27    cpy #$27
C417: 90 03    bcc	$c41c
C419: 4C 36 C4 jmp	$c436
C41C: AC 7F 06 ldy	$067f
C41F: B9 71 C4 lda	$c471, y
C422: D0 03    bne	$c427
C424: 4C 53 C4 jmp	$c453
C427: 20 FA 9D jsr	$9dfa
C42A: 20 C0 9E jsr	$9ec0
C42D: AC 7F 06 ldy	$067f
C430: B9 71 C4 lda	$c471, y
C433: 20 E9 C4 jsr	$c4e9
C436: AC 7F 06 ldy	$067f
C439: B9 71 C4 lda	$c471, y
C43C: D0 03    bne	$c441
C43E: 4C 53 C4 jmp	$c453
C441: AC 7F 06 ldy	$067f
C444: B9 71 C4 lda	$c471, y
C447: 20 28 C5 jsr	$c528
C44A: AC 7F 06 ldy	$067f
C44D: B9 71 C4 lda	$c471, y
C450: 20 43 C5 jsr	$c543
C453: AC 7F 06 ldy	$067f
C456: B9 AD C4 lda	$c4ad, y
C459: C9 00    cmp #$00
C45B: F0 03    beq	$c460
C45D: 20 70 D6 jsr	$d670
C460: AD 7F 06 lda	$067f
C463: C9 3B    cmp #$3b
C465: 90 09    bcc	$c470
C467: A9 00    lda #$00
C469: 85 77    sta	$0077
C46B: 85 78    sta	$0078
C46D: 20 AD A5 jsr	$a5ad
C470: 60       rts

C4E9: C9 08    cmp #$08
C4EB: D0 02    bne	$c4ef
C4ED: C6 89    dec	$0089
C4EF: C9 04    cmp #$04
C4F1: D0 09    bne	$c4fc
C4F3: E6 89    inc	$0089
C4F5: 20 2A 9F jsr	$9f2a
C4F8: B0 02    bcs	$c4fc
C4FA: C6 89    dec	$0089
C4FC: C9 02    cmp #$02
C4FE: D0 09    bne	$c509
C500: E6 87    inc	$0087
C502: 20 2A 9F jsr	$9f2a
C505: B0 02    bcs	$c509
C507: C6 87    dec	$0087
C509: C9 01    cmp #$01
C50B: D0 14    bne	$c521
C50D: A5 8F    lda	$008f
C50F: 85 1B    sta	$001b
C511: 18       clc
C512: 69 01    adc #$01
C514: 29 03    and #$03
C516: 85 8F    sta	$008f
C518: 20 2A 9F jsr	$9f2a
C51B: B0 04    bcs	$c521
C51D: A5 1B    lda	$001b
C51F: 85 8F    sta	$008f
C521: 20 E8 9E jsr	$9ee8
C524: 20 8F 9E jsr	clear_player_grid_9E8F
C527: 60       rts
C528: C9 10    cmp #$10
C52A: D0 16    bne	$c542
C52C: A9 90    lda #$90
C52E: 85 1F    sta	$001f
C530: A9 03    lda #$03
C532: 85 20    sta	$0020
C534: A0 03    ldy #$03
C536: A9 08    lda #$08
C538: 91 1F    sta ($1f), y
C53A: C8       iny
C53B: C0 0D    cpy #$0d
C53D: 90 F9    bcc	$c538
C53F: 20 B3 A3 jsr	$a3b3
C542: 60       rts
C543: C9 20    cmp #$20
C545: D0 19    bne	$c560
C547: A9 19    lda #$19
C549: 85 93    sta	$0093
C54B: A9 00    lda #$00
C54D: 85 95    sta	$0095
C54F: A2 00    ldx #$00
C551: 20 2E A0 jsr	$a02e
C554: A9 01    lda #$01
C556: 85 95    sta	$0095
C558: A2 00    ldx #$00
C55A: 20 2E A0 jsr	$a02e
C55D: 20 2E A0 jsr	$a02e
C560: 20 6B C6 jsr	$c66b
C563: 60       rts
C564: A5 08    lda	$0008
C566: C9 EC    cmp #$ec
C568: F0 01    beq	$c56b
C56A: 60       rts
C56B: A5 0F    lda	$000f
C56D: 29 1F    and #$1f
C56F: D0 15    bne	$c586
C571: A9 01    lda #$01
C573: 38       sec
C574: ED 50 06 sbc	$0650
C577: 8D 50 06 sta	$0650
C57A: D0 05    bne	$c581
C57C: A9 0B    lda #$0b
C57E: B8       clv
C57F: 50 02    bvc	$c583
C581: A9 37    lda #$37
C583: 20 70 D6 jsr	$d670
C586: A5 29    lda	$0029
C588: 05 2A    ora	$002a
C58A: 29 01    and #$01
C58C: F0 21    beq	$c5af
C58E: AD 55 06 lda	$0655
C591: D0 19    bne	$c5ac
C593: EE 56 06 inc	$0656
C596: AD 56 06 lda	$0656
C599: C9 03    cmp #$03
C59B: 90 0A    bcc	$c5a7
C59D: A9 01    lda #$01
C59F: 8D 7E 06 sta	$067e
C5A2: A9 24    lda #$24
C5A4: 8D 7F 06 sta	$067f
C5A7: A9 01    lda #$01
C5A9: 8D 55 06 sta	$0655
C5AC: B8       clv
C5AD: 50 05    bvc	$c5b4
C5AF: A9 00    lda #$00
C5B1: 8D 55 06 sta	$0655
C5B4: CE 7E 06 dec	$067e
C5B7: AD 7E 06 lda	$067e
C5BA: C9 00    cmp #$00
C5BC: F0 03    beq	$c5c1
C5BE: 4C 0E C6 jmp	$c60e
C5C1: A2 00    ldx #$00
C5C3: A9 1D    lda #$1d
C5C5: 8D 7E 06 sta	$067e
C5C8: EE 7F 06 inc	$067f
C5CB: AC 7F 06 ldy	$067f
C5CE: C0 15    cpy #$15
C5D0: 90 03    bcc	$c5d5
C5D2: 4C EF C5 jmp	$c5ef
C5D5: AC 7F 06 ldy	$067f
C5D8: B9 1E C6 lda	$c61e, y
C5DB: D0 03    bne	$c5e0
C5DD: 4C 0E C6 jmp	$c60e
C5E0: 20 FA 9D jsr	$9dfa
C5E3: 20 C0 9E jsr	$9ec0
C5E6: AC 7F 06 ldy	$067f
C5E9: B9 1E C6 lda	$c61e, y
C5EC: 20 E9 C4 jsr	$c4e9
C5EF: AC 7F 06 ldy	$067f
C5F2: B9 1E C6 lda	$c61e, y
C5F5: 20 28 C5 jsr	$c528
C5F8: AC 7F 06 ldy	$067f
C5FB: B9 1E C6 lda	$c61e, y
C5FE: 20 43 C5 jsr	$c543
C601: AC 7F 06 ldy	$067f
C604: B9 45 C6 lda	$c645, y
C607: C9 00    cmp #$00
C609: F0 03    beq	$c60e
C60B: 20 70 D6 jsr	$d670
C60E: AD 7F 06 lda	$067f
C611: C9 25    cmp #$25
C613: 90 08    bcc	$c61d
C615: AD 4F 06 lda	$064f
C618: 85 0B    sta	$000b
C61A: 20 45 A9 jsr	$a945
C61D: 60       rts

C66B: A9 00    lda #$00
C66D: 85 1B    sta	$001b
C66F: A9 02    lda #$02
C671: 85 1C    sta	$001c
C673: A0 60    ldy #$60
C675: A2 00    ldx #$00
C677: A9 F1    lda #$f1
C679: 91 1B    sta ($1b), y
C67B: 98       tya
C67C: 18       clc
C67D: 69 10    adc #$10
C67F: A8       tay
C680: 90 02    bcc	$c684
C682: E6 1C    inc	$001c
C684: E8       inx
C685: E0 14    cpx #$14
C687: 90 EE    bcc	$c677
C689: A2 00    ldx #$00
C68B: 20 3A A4 jsr	$a43a
C68E: 60       rts
C68F: A9 B0    lda #$b0
C691: 85 05    sta	$0005
C693: A9 5D    lda #$5d
C695: 20 70 D6 jsr	$d670
C698: A9 10    lda #$10
C69A: 85 1B    sta	$001b
C69C: A9 11    lda #$11
C69E: 85 1C    sta	$001c
C6A0: A2 00    ldx #$00
C6A2: BD AA 08 lda	$08aa, x
C6A5: 85 1E    sta	$001e
C6A7: BD AB 08 lda	$08ab, x
C6AA: 85 1F    sta	$001f
C6AC: A0 02    ldy #$02
C6AE: 20 58 C8 jsr	$c858
C6B1: A9 01    lda #$01
C6B3: 20 A1 C8 jsr	$c8a1
C6B6: A5 1B    lda	$001b
C6B8: 18       clc
C6B9: 69 80    adc #$80
C6BB: 85 1B    sta	$001b
C6BD: A5 1C    lda	$001c
C6BF: 69 00    adc #$00
C6C1: 85 1C    sta	$001c
C6C3: E8       inx
C6C4: E8       inx
C6C5: E0 0E    cpx #$0e
C6C7: 90 D9    bcc	$c6a2
C6C9: A9 90    lda #$90
C6CB: 85 1B    sta	$001b
C6CD: A9 14    lda #$14
C6CF: 85 1C    sta	$001c
C6D1: A2 14    ldx #$14
C6D3: BD AA 08 lda	$08aa, x
C6D6: 85 1F    sta	$001f
C6D8: BD AB 08 lda	$08ab, x
C6DB: 85 1E    sta	$001e
C6DD: BD AC 08 lda	$08ac, x
C6E0: 85 1D    sta	$001d
C6E2: A0 03    ldy #$03
C6E4: 20 58 C8 jsr	$c858
C6E7: A9 00    lda #$00
C6E9: 20 A1 C8 jsr	$c8a1
C6EC: A5 1B    lda	$001b
C6EE: 18       clc
C6EF: 69 80    adc #$80
C6F1: 85 1B    sta	$001b
C6F3: A5 1C    lda	$001c
C6F5: 69 00    adc #$00
C6F7: 85 1C    sta	$001c
C6F9: E8       inx
C6FA: E8       inx
C6FB: E8       inx
C6FC: E0 1D    cpx #$1d
C6FE: 90 D3    bcc	$c6d3
C700: A9 10    lda #$10
C702: 85 1B    sta	$001b
C704: A9 16    lda #$16
C706: 85 1C    sta	$001c
C708: A9 00    lda #$00
C70A: 8D E0 06 sta	$06e0
C70D: 8D E1 06 sta	$06e1
C710: A2 06    ldx #$06
C712: AD E0 06 lda	$06e0
C715: 18       clc
C716: 7D AA 08 adc	$08aa, x
C719: 8D E0 06 sta	$06e0
C71C: AD E1 06 lda	$06e1
C71F: 7D AB 08 adc	$08ab, x
C722: 8D E1 06 sta	$06e1
C725: 90 0A    bcc	$c731
C727: A9 FF    lda #$ff
C729: 8D E1 06 sta	$06e1
C72C: 8D E0 06 sta	$06e0
C72F: D0 06    bne	$c737
C731: E8       inx
C732: E8       inx
C733: E0 0E    cpx #$0e
C735: 90 DB    bcc	$c712
C737: AD E0 06 lda	$06e0
C73A: 0D E1 06 ora	$06e1
C73D: D0 05    bne	$c744
C73F: A9 01    lda #$01
C741: 8D E0 06 sta	$06e0
C744: 20 79 C7 jsr	$c779
C747: A9 2A    lda #$2a
C749: 85 1B    sta	$001b
C74B: A9 11    lda #$11
C74D: 85 1C    sta	$001c
C74F: A2 1E    ldx #$1e
C751: BD AA 08 lda	$08aa, x
C754: 85 1E    sta	$001e
C756: BD AB 08 lda	$08ab, x
C759: 85 1F    sta	$001f
C75B: A0 02    ldy #$02
C75D: 20 58 C8 jsr	$c858
C760: A9 01    lda #$01
C762: 20 A1 C8 jsr	$c8a1
C765: A5 1B    lda	$001b
C767: 18       clc
C768: 69 80    adc #$80
C76A: 85 1B    sta	$001b
C76C: A5 1C    lda	$001c
C76E: 69 00    adc #$00
C770: 85 1C    sta	$001c
C772: E8       inx
C773: E8       inx
C774: E0 50    cpx #$50
C776: 90 D9    bcc	$c751
C778: 60       rts
C779: AD C6 08 lda	$08c6
C77C: 0A       asl a
C77D: 8D DC 06 sta	$06dc
C780: AD C5 08 lda	$08c5
C783: 2A       rol a
C784: 8D DD 06 sta	$06dd
C787: AD C4 08 lda	$08c4
C78A: 2A       rol a
C78B: 8D DE 06 sta	$06de
C78E: A9 00    lda #$00
C790: 2A       rol a
C791: 8D DF 06 sta	$06df
C794: AD DC 06 lda	$06dc
C797: 18       clc
C798: 6D C3 08 adc	$08c3
C79B: 8D DC 06 sta	$06dc
C79E: AD DD 06 lda	$06dd
C7A1: 6D C2 08 adc	$08c2
C7A4: 8D DD 06 sta	$06dd
C7A7: AD DE 06 lda	$06de
C7AA: 6D C1 08 adc	$08c1
C7AD: 8D DE 06 sta	$06de
C7B0: AD DF 06 lda	$06df
C7B3: 69 00    adc #$00
C7B5: 8D DF 06 sta	$06df
C7B8: 20 D0 C8 jsr	$c8d0
C7BB: AD DC 06 lda	$06dc
C7BE: 85 1E    sta	$001e
C7C0: AD DD 06 lda	$06dd
C7C3: 85 1F    sta	$001f
C7C5: A0 02    ldy #$02
C7C7: 20 58 C8 jsr	$c858
C7CA: A9 03    lda #$03
C7CC: 20 A1 C8 jsr	$c8a1
C7CF: AD DE 06 lda	$06de
C7D2: 85 1F    sta	$001f
C7D4: 8D DD 06 sta	$06dd
C7D7: AD DF 06 lda	$06df
C7DA: 85 20    sta	$0020
C7DC: 8D DE 06 sta	$06de
C7DF: A9 00    lda #$00
C7E1: 8D DF 06 sta	$06df
C7E4: 8D DC 06 sta	$06dc
C7E7: 4E DE 06 lsr	$06de
C7EA: 6E DD 06 ror	$06dd
C7ED: 6E DC 06 ror	$06dc
C7F0: 4E DE 06 lsr	$06de
C7F3: 6E DD 06 ror	$06dd
C7F6: 6E DC 06 ror	$06dc
C7F9: A9 00    lda #$00
C7FB: 85 21    sta	$0021
C7FD: 06 1F    asl	$001f
C7FF: 26 20    rol	$0020
C801: 26 21    rol	$0021
C803: 06 1F    asl	$001f
C805: 26 20    rol	$0020
C807: 26 21    rol	$0021
C809: AD DC 06 lda	$06dc
C80C: 38       sec
C80D: E5 1F    sbc	$001f
C80F: 8D DC 06 sta	$06dc
C812: AD DD 06 lda	$06dd
C815: E5 20    sbc	$0020
C817: 8D DD 06 sta	$06dd
C81A: AD DE 06 lda	$06de
C81D: E5 21    sbc	$0021
C81F: 8D DE 06 sta	$06de
C822: AD DF 06 lda	$06df
C825: E9 00    sbc #$00
C827: 8D DF 06 sta	$06df
C82A: 20 D0 C8 jsr	$c8d0
C82D: AD DC 06 lda	$06dc
C830: C9 3C    cmp #$3c
C832: 90 02    bcc	$c836
C834: A9 3B    lda #$3b
C836: 85 1F    sta	$001f
C838: A0 01    ldy #$01
C83A: 20 58 C8 jsr	$c858
C83D: A5 1B    lda	$001b
C83F: 18       clc
C840: 69 04    adc #$04
C842: 85 1B    sta	$001b
C844: A9 3A    lda #$3a
C846: A0 00    ldy #$00
C848: 91 1B    sta ($1b), y
C84A: C8       iny
C84B: A9 B0    lda #$b0
C84D: 91 1B    sta ($1b), y
C84F: E6 1B    inc	$001b
C851: E6 1B    inc	$001b
C853: A9 03    lda #$03
C855: 4C A1 C8 jmp	$c8a1
C858: 8A       txa
C859: 48       pha
C85A: A9 00    lda #$00
C85C: 8D D7 06 sta	$06d7
C85F: 8D D8 06 sta	$06d8
C862: 8D D9 06 sta	$06d9
C865: 8D DA 06 sta	$06da
C868: BE 9D C8 ldx	$c89d, y
C86B: F8       sed
C86C: 06 1D    asl	$001d
C86E: 26 1E    rol	$001e
C870: 26 1F    rol	$001f
C872: AD DA 06 lda	$06da
C875: 6D DA 06 adc	$06da
C878: 8D DA 06 sta	$06da
C87B: AD D9 06 lda	$06d9
C87E: 6D D9 06 adc	$06d9
C881: 8D D9 06 sta	$06d9
C884: AD D8 06 lda	$06d8
C887: 6D D8 06 adc	$06d8
C88A: 8D D8 06 sta	$06d8
C88D: AD D7 06 lda	$06d7
C890: 6D D7 06 adc	$06d7
C893: 8D D7 06 sta	$06d7
C896: CA       dex
C897: 10 D3    bpl	$c86c
C899: D8       cld
C89A: 68       pla
C89B: AA       tax
C89C: 60       rts

C8A1: A8       tay
C8A2: 8A       txa
C8A3: 48       pha
C8A4: 98       tya
C8A5: AA       tax
C8A6: A0 00    ldy #$00
C8A8: BD D7 06 lda	$06d7, x
C8AB: 4A       lsr a
C8AC: 4A       lsr a
C8AD: 4A       lsr a
C8AE: 4A       lsr a
C8AF: 09 30    ora #$30
C8B1: 91 1B    sta ($1b), y
C8B3: C8       iny
C8B4: A5 05    lda	$0005
C8B6: 91 1B    sta ($1b), y
C8B8: C8       iny
C8B9: BD D7 06 lda	$06d7, x
C8BC: 29 0F    and #$0f
C8BE: 09 30    ora #$30
C8C0: 91 1B    sta ($1b), y
C8C2: C8       iny
C8C3: A5 05    lda	$0005
C8C5: 91 1B    sta ($1b), y
C8C7: C8       iny
C8C8: E8       inx
C8C9: E0 04    cpx #$04
C8CB: 90 DB    bcc	$c8a8
C8CD: 68       pla
C8CE: AA       tax
C8CF: 60       rts
C8D0: A0 10    ldy #$10
C8D2: 0E DC 06 asl	$06dc
C8D5: 2E DD 06 rol	$06dd
C8D8: 2E DE 06 rol	$06de
C8DB: 2E DF 06 rol	$06df
C8DE: 90 15    bcc	$c8f5
C8E0: AD DE 06 lda	$06de
C8E3: ED E0 06 sbc	$06e0
C8E6: 8D DE 06 sta	$06de
C8E9: AD DF 06 lda	$06df
C8EC: ED E1 06 sbc	$06e1
C8EF: 8D DF 06 sta	$06df
C8F2: 4C 0F C9 jmp	$c90f
C8F5: AD DE 06 lda	$06de
C8F8: CD E0 06 cmp	$06e0
C8FB: AD DF 06 lda	$06df
C8FE: ED E1 06 sbc	$06e1
C901: 90 0F    bcc	$c912
C903: 8D DF 06 sta	$06df
C906: AD DE 06 lda	$06de
C909: ED E0 06 sbc	$06e0
C90C: 8D DE 06 sta	$06de
C90F: EE DC 06 inc	$06dc
C912: 88       dey
C913: D0 BD    bne	$c8d2
C915: 60       rts
C916: 20 1A CA jsr	$ca1a
C919: A9 00    lda #$00
C91B: 85 21    sta	$0021
C91D: 85 22    sta	$0022
C91F: A2 02    ldx #$02
C921: A4 1B    ldy	$001b
C923: 20 6D C9 jsr	$c96d
C926: A5 1B    lda	$001b
C928: 18       clc
C929: 69 04    adc #$04
C92B: A8       tay
C92C: 20 6D C9 jsr	$c96d
C92F: A5 1B    lda	$001b
C931: 18       clc
C932: 69 08    adc #$08
C934: A8       tay
C935: 20 6D C9 jsr	$c96d
C938: A5 1B    lda	$001b
C93A: 18       clc
C93B: 69 0C    adc #$0c
C93D: A8       tay
C93E: 20 6D C9 jsr	$c96d
C941: E8       inx
C942: E0 0E    cpx #$0e
C944: 90 DB    bcc	$c921
C946: A6 1F    ldx	$001f
C948: A4 1D    ldy	$001d
C94A: A5 21    lda	$0021
C94C: 18       clc
C94D: 69 0C    adc #$0c
C94F: C5 22    cmp	$0022
C951: B0 04    bcs	$c957
C953: A6 20    ldx	$0020
C955: A4 1E    ldy	$001e
C957: 8E 31 06 stx	$0631
C95A: A5 1B    lda	$001b
C95C: C9 10    cmp #$10
C95E: D0 09    bne	$c969
C960: E0 01    cpx #$01
C962: F0 04    beq	$c968
C964: E0 03    cpx #$03
C966: D0 01    bne	$c969
C968: 88       dey
C969: 8C 30 06 sty	$0630
C96C: 60       rts
C96D: B9 FD CB lda	$cbfd, y
C970: C9 80    cmp #$80
C972: F0 09    beq	$c97d
C974: 18       clc
C975: 7D C0 05 adc	$05c0, x
C978: DD C1 05 cmp	$05c1, x
C97B: D0 37    bne	$c9b4
C97D: B9 FE CB lda	$cbfe, y
C980: C9 80    cmp #$80
C982: F0 09    beq	$c98d
C984: 18       clc
C985: 7D C0 05 adc	$05c0, x
C988: DD C2 05 cmp	$05c2, x
C98B: D0 27    bne	$c9b4
C98D: B9 FF CB lda	$cbff, y
C990: C9 80    cmp #$80
C992: F0 09    beq	$c99d
C994: 18       clc
C995: 7D C0 05 adc	$05c0, x
C998: DD C3 05 cmp	$05c3, x
C99B: D0 17    bne	$c9b4
C99D: BD C0 05 lda	$05c0, x
C9A0: 18       clc
C9A1: 79 FC CB adc	$cbfc, y
C9A4: C5 21    cmp	$0021
C9A6: 90 0B    bcc	$c9b3
C9A8: 85 21    sta	$0021
C9AA: 86 1D    stx	$001d
C9AC: 98       tya
C9AD: 4A       lsr a
C9AE: 4A       lsr a
C9AF: 29 03    and #$03
C9B1: 85 1F    sta	$001f
C9B3: 60       rts
C9B4: BD C0 05 lda	$05c0, x
C9B7: 85 1C    sta	$001c
C9B9: B9 FD CB lda	$cbfd, y
C9BC: C9 80    cmp #$80
C9BE: F0 12    beq	$c9d2
C9C0: E0 0C    cpx #$0c
C9C2: B0 55    bcs	$ca19
C9C4: 65 1C    adc	$001c
C9C6: 38       sec
C9C7: FD C1 05 sbc	$05c1, x
C9CA: 90 06    bcc	$c9d2
C9CC: 49 FF    eor #$ff
C9CE: 65 1C    adc	$001c
C9D0: 85 1C    sta	$001c
C9D2: B9 FE CB lda	$cbfe, y
C9D5: C9 80    cmp #$80
C9D7: F0 12    beq	$c9eb
C9D9: E0 0C    cpx #$0c
C9DB: B0 3C    bcs	$ca19
C9DD: 65 1C    adc	$001c
C9DF: 38       sec
C9E0: FD C2 05 sbc	$05c2, x
C9E3: 90 06    bcc	$c9eb
C9E5: 49 FF    eor #$ff
C9E7: 65 1C    adc	$001c
C9E9: 85 1C    sta	$001c
C9EB: B9 FF CB lda	$cbff, y
C9EE: C9 80    cmp #$80
C9F0: F0 12    beq	$ca04
C9F2: E0 0C    cpx #$0c
C9F4: B0 23    bcs	$ca19
C9F6: 65 1C    adc	$001c
C9F8: 38       sec
C9F9: FD C3 05 sbc	$05c3, x
C9FC: 90 06    bcc	$ca04
C9FE: 49 FF    eor #$ff
CA00: 65 1C    adc	$001c
CA02: 85 1C    sta	$001c
CA04: A5 1C    lda	$001c
CA06: 18       clc
CA07: 79 FC CB adc	$cbfc, y
CA0A: C5 22    cmp	$0022
CA0C: 90 0B    bcc	$ca19
CA0E: 85 22    sta	$0022
CA10: 86 1E    stx	$001e
CA12: 98       tya
CA13: 4A       lsr a
CA14: 4A       lsr a
CA15: 29 03    and #$03
CA17: 85 20    sta	$0020
CA19: 60       rts
CA1A: B5 8B    lda	$008b, x
CA1C: 0A       asl a
CA1D: 0A       asl a
CA1E: 0A       asl a
CA1F: 0A       asl a
CA20: 85 1B    sta	$001b
CA22: A9 50    lda #$50
CA24: 85 1F    sta	$001f
CA26: 24 0B    bit	$000b
CA28: 10 02    bpl	$ca2c
CA2A: A2 02    ldx #$02
CA2C: BD 8C 9E lda	$9e8c, x
CA2F: 85 20    sta	$0020
CA31: A2 00    ldx #$00
CA33: A0 00    ldy #$00
CA35: 8C D0 05 sty	$05d0
CA38: A5 20    lda	$0020
CA3A: 85 1E    sta	$001e
CA3C: A5 1F    lda	$001f
CA3E: 85 1D    sta	$001d
CA40: A5 1D    lda	$001d
CA42: 18       clc
CA43: 69 10    adc #$10
CA45: 85 1D    sta	$001d
CA47: 90 02    bcc	$ca4b
CA49: E6 1E    inc	$001e
CA4B: B1 1D    lda ($1d), y
CA4D: F0 F1    beq	$ca40
; useless load+shift, A overwritten at CA52
CA4F: A5 1E    lda	$001e
CA51: 4A       lsr a
CA52: A5 1D    lda	$001d
CA54: 6A       ror a
CA55: 29 F8    and #$f8
CA57: 9D C0 05 sta	$05c0, x
CA5A: E6 1F    inc	$001f
CA5C: E8       inx
CA5D: E0 10    cpx #$10
CA5F: 90 D7    bcc	$ca38
CA61: 60       rts
CA62: AD A8 06 lda	$06a8
CA65: 29 01    and #$01
CA67: D0 0C    bne	$ca75
CA69: A9 EF    lda #$ef
CA6B: 85 08    sta	$0008
CA6D: A9 FB    lda #$fb
CA6F: 4C A9 CA jmp	$caa9
CA72: B8       clv
CA73: 50 17    bvc	$ca8c
CA75: A9 EE    lda #$ee
CA77: 85 08    sta	$0008
CA79: A9 0F    lda #$0f
CA7B: 8D 7D 06 sta	$067d
CA7E: A9 08    lda #$08
CA80: 85 07    sta	$0007
CA82: A9 0C    lda #$0c
CA84: 20 18 88 jsr display_screen_and_other_stuff_8818
CA87: A9 54    lda #$54
CA89: 4C 70 D6 jmp	$d670

CA8C: 20 49 E6 jsr	$e649
CA8F: EE A8 06 inc	$06a8
CA92: AD BB 08 lda	$08bb
CA95: 29 04    and #$04
CA97: F0 0C    beq	$caa5
CA99: AD A8 06 lda	$06a8
CA9C: 29 03    and #$03
CA9E: D0 05    bne	$caa5
CAA0: A9 0A    lda #$0a
CAA2: 20 59 E6 jsr	$e659
CAA5: A9 FB    lda #$fb
CAA7: 85 08    sta	$0008
CAA9: A9 02    lda #$02
CAAB: 85 07    sta	$0007
CAAD: 8D AC 06 sta	$06ac
CAB0: A9 F0    lda #$f0
CAB2: 8D BB 06 sta	$06bb
CAB5: 8D BC 06 sta	$06bc
CAB8: A9 00    lda #$00
CABA: 8D B5 06 sta	$06b5
CABD: 8D B6 06 sta	$06b6
CAC0: 8D 7D 06 sta	$067d
CAC3: 8D 44 06 sta	$0644
CAC6: 8D 45 06 sta	$0645
CAC9: 8D 46 06 sta	$0646
CACC: 8D 47 06 sta	$0647
CACF: 8D AB 06 sta	$06ab
CAD2: 8D 59 06 sta	$0659
CAD5: 8D 5A 06 sta	$065a
CAD8: 8D 37 06 sta	$0637
CADB: 85 13    sta	$0013
CADD: 85 14    sta	$0014
CADF: 85 09    sta	$0009
CAE1: 85 93    sta	$0093
CAE3: 85 94    sta	$0094
CAE5: 85 95    sta	$0095
CAE7: 85 96    sta	$0096
CAE9: 85 4E    sta	$004e
CAEB: 85 4F    sta	$004f
CAED: A9 08    lda #$08
CAEF: 20 18 88 jsr display_screen_and_other_stuff_8818
CAF2: 60       rts

CAF3: AD 18 06 lda	$0618
CAF6: C9 31    cmp #$31
CAF8: D0 05    bne	$caff
CAFA: A9 29    lda #$29
CAFC: B8       clv
CAFD: 50 02    bvc	$cb01
CAFF: A9 2A    lda #$2a
CB01: 20 70 D6 jsr	$d670
CB04: 60       rts
CB05: A9 FE    lda #$fe
CB07: 85 08    sta	$0008
CB09: A9 00    lda #$00
CB0B: 85 46    sta	$0046
CB0D: 20 59 E6 jsr	$e659
CB10: A9 14    lda #$14
CB12: 8D B4 06 sta	$06b4
CB15: A9 06    lda #$06
CB17: 85 07    sta	$0007
CB19: A9 06    lda #$06
CB1B: 20 18 88 jsr display_screen_and_other_stuff_8818
CB1E: A9 3E    lda #$3e
CB20: A0 01    ldy #$01
CB22: 20 C0 CB jsr	$cbc0
CB25: AC 19 06 ldy	$0619
CB28: B9 3A CB lda	$cb3a, y
CB2B: 85 0B    sta	$000b
CB2D: 85 91    sta	$0091
CB2F: A9 02    lda #$02
CB31: 20 59 E6 jsr	$e659
CB34: A9 3F    lda #$3f
CB36: 20 70 D6 jsr	$d670
CB39: 60       rts

CB42: A5 08    lda $08                                             
CB44: C9 FE    cmp #$fe
CB46: F0 01    beq	$cb49
CB48: 60       rts
CB49: A5 0F    lda	$000f
CB4B: 29 3F    and #$3f
CB4D: D0 0B    bne	$cb5a
CB4F: CE B4 06 dec	$06b4
CB52: D0 06    bne	$cb5a
CB54: A9 01    lda #$01
CB56: 85 29    sta	$0029
CB58: 85 2A    sta	$002a
CB5A: A5 29    lda	$0029
CB5C: AC 19 06 ldy	$0619
CB5F: C0 01    cpy #$01
CB61: D0 02    bne	$cb65
CB63: A5 2A    lda	$002a
CB65: 29 0E    and #$0e
CB67: F0 08    beq	$cb71
CB69: 20 98 CB jsr	$cb98
CB6C: A9 15    lda #$15
CB6E: 20 59 E6 jsr	$e659
CB71: A5 29    lda	$0029
CB73: AC 19 06 ldy	$0619
CB76: C0 01    cpy #$01
CB78: D0 02    bne	$cb7c
CB7A: A5 2A    lda	$002a
CB7C: 29 01    and #$01
CB7E: D0 01    bne	$cb81
CB80: 60       rts
CB81: A5 46    lda	$0046
CB83: 85 75    sta	$0075
CB85: A4 0B    ldy	$000b
CB87: F0 07    beq	$cb90
CB89: 85 76    sta	$0076
CB8B: A0 04    ldy #$04
CB8D: 20 4C F1 jsr	$f14c
CB90: A9 16    lda #$16
CB92: 20 59 E6 jsr	$e659
CB95: 4C E9 A8 jmp	$a8e9
CB98: 48       pha
CB99: A9 00    lda #$00
CB9B: 20 C0 CB jsr	$cbc0
CB9E: 68       pla
CB9F: 29 04    and #$04
CBA1: F0 10    beq	$cbb3
CBA3: A5 46    lda	$0046
CBA5: 18       clc
CBA6: 69 01    adc #$01
CBA8: C9 03    cmp #$03
CBAA: D0 02    bne	$cbae
CBAC: A9 02    lda #$02
CBAE: 85 46    sta	$0046
CBB0: 4C BE CB jmp	$cbbe
CBB3: A5 46    lda	$0046
CBB5: C9 00    cmp #$00
CBB7: F0 05    beq	$cbbe
CBB9: 38       sec
CBBA: E9 01    sbc #$01
CBBC: 85 46    sta	$0046
CBBE: A9 01    lda #$01
CBC0: 85 1D    sta	$001d
CBC2: 48       pha
CBC3: A5 46    lda	$0046
CBC5: 0A       asl a
CBC6: A8       tay
CBC7: B9 F6 CB lda	$cbf6, y
CBCA: 85 02    sta	$0002
CBCC: B9 F7 CB lda	$cbf7, y
CBCF: 85 03    sta	$0003
CBD1: A9 B0    lda #$b0
CBD3: 85 05    sta	$0005
CBD5: 68       pla
CBD6: F0 02    beq	$cbda
CBD8: A9 3E    lda #$3e
CBDA: 20 4A D6 jsr	$d64a
CBDD: B9 FC CB lda	$cbfc, y
CBE0: 85 02    sta	$0002
CBE2: B9 FD CB lda	$cbfd, y
CBE5: 85 03    sta	$0003
CBE7: A5 1D    lda	$001d
CBE9: F0 02    beq	$cbed
CBEB: A9 3F    lda #$3f
CBED: 20 4A D6 jsr	$d64a
CBF0: 60       rts

CC7C: EE A9 06 inc	$06a9
CC7F: AD A9 06 lda	$06a9
CC82: C9 07    cmp #$07
CC84: F0 01    beq	$cc87
CC86: 60       rts
CC87: A9 00    lda #$00
CC89: 8D A9 06 sta	$06a9
CC8C: A9 00    lda #$00
CC8E: 85 19    sta	$0019
CC90: AD 47 06 lda	$0647
CC93: 29 01    and #$01
CC95: F0 04    beq	$cc9b
CC97: A9 01    lda #$01
CC99: 85 19    sta	$0019
CC9B: AD AD 06 lda	$06ad
CC9E: D0 4F    bne	$ccef
CCA0: AD 47 06 lda	$0647
CCA3: 0A       asl a
CCA4: A8       tay
CCA5: B9 4E CE lda	$ce4e, y
CCA8: 85 47    sta	$0047
CCAA: B9 4F CE lda	$ce4f, y
CCAD: 85 48    sta	$0048
CCAF: AD 46 06 lda	$0646
CCB2: 0A       asl a
CCB3: 0A       asl a
CCB4: 0A       asl a
CCB5: 0A       asl a
CCB6: AA       tax
CCB7: A0 00    ldy #$00
CCB9: A5 19    lda	$0019
CCBB: D0 06    bne	$ccc3
CCBD: BD FE CE lda	$cefe, x
CCC0: B8       clv
CCC1: 50 11    bvc	$ccd4
CCC3: 8E 4D 06 stx	$064d
CCC6: BD 62 CE lda	$ce62, x
CCC9: 18       clc
CCCA: 6D 59 06 adc	$0659
CCCD: AA       tax
CCCE: BD E2 CE lda	$cee2, x
CCD1: AE 4D 06 ldx	$064d
CCD4: 91 47    sta ($47), y
CCD6: E8       inx
CCD7: C8       iny
CCD8: C0 0F    cpy #$0f
CCDA: D0 DD    bne	$ccb9
CCDC: A5 19    lda	$0019
CCDE: F0 0F    beq	$ccef
CCE0: AD 59 06 lda	$0659
CCE3: 18       clc
CCE4: 69 07    adc #$07
CCE6: C9 1C    cmp #$1c
CCE8: 90 02    bcc	$ccec
CCEA: A9 00    lda #$00
CCEC: 8D 59 06 sta	$0659
CCEF: EE 46 06 inc	$0646
CCF2: A5 19    lda	$0019
CCF4: D0 2E    bne	$cd24
CCF6: AD 46 06 lda	$0646
CCF9: C9 0A    cmp #$0a
CCFB: D0 24    bne	$cd21
CCFD: A9 00    lda #$00
CCFF: 8D 46 06 sta	$0646
CD02: 8D AD 06 sta	$06ad
CD05: EE 47 06 inc	$0647
CD08: AD 47 06 lda	$0647
CD0B: C9 04    cmp #$04
CD0D: D0 05    bne	$cd14
CD0F: A9 00    lda #$00
CD11: 8D 47 06 sta	$0647
CD14: AD 47 06 lda	$0647
CD17: CD AC 06 cmp	$06ac
CD1A: D0 05    bne	$cd21
CD1C: A9 01    lda #$01
CD1E: 8D AD 06 sta	$06ad
CD21: B8       clv
CD22: 50 2B    bvc	$cd4f
CD24: AD 46 06 lda	$0646
CD27: C9 08    cmp #$08
CD29: D0 24    bne	$cd4f
CD2B: A9 00    lda #$00
CD2D: 8D 46 06 sta	$0646
CD30: 8D AD 06 sta	$06ad
CD33: EE 47 06 inc	$0647
CD36: AD 47 06 lda	$0647
CD39: C9 04    cmp #$04
CD3B: D0 05    bne	$cd42
CD3D: A9 00    lda #$00
CD3F: 8D 47 06 sta	$0647
CD42: AD 47 06 lda	$0647
CD45: CD AC 06 cmp	$06ac
CD48: D0 05    bne	$cd4f
CD4A: A9 01    lda #$01
CD4C: 8D AD 06 sta	$06ad
CD4F: 60       rts
CD50: EE AA 06 inc	$06aa
CD53: AD AA 06 lda	$06aa
CD56: C9 05    cmp #$05
CD58: F0 01    beq	$cd5b
CD5A: 60       rts
CD5B: A9 00    lda #$00
CD5D: 8D AA 06 sta	$06aa
CD60: A9 00    lda #$00
CD62: 85 19    sta	$0019
CD64: AD AC 06 lda	$06ac
CD67: 29 01    and #$01
CD69: F0 04    beq	$cd6f
CD6B: A9 01    lda #$01
CD6D: 85 19    sta	$0019
CD6F: AD AE 06 lda	$06ae
CD72: D0 4F    bne	$cdc3
CD74: AD AC 06 lda	$06ac
CD77: 0A       asl a
CD78: A8       tay
CD79: B9 56 CE lda	$ce56, y
CD7C: 85 47    sta	$0047
CD7E: B9 57 CE lda	$ce57, y
CD81: 85 48    sta	$0048
CD83: AD AB 06 lda	$06ab
CD86: 0A       asl a
CD87: 0A       asl a
CD88: 0A       asl a
CD89: 0A       asl a
CD8A: AA       tax
CD8B: A0 00    ldy #$00
CD8D: A5 19    lda	$0019
CD8F: D0 06    bne	$cd97
CD91: BD FE CE lda	$cefe, x
CD94: B8       clv
CD95: 50 11    bvc	$cda8
CD97: 8E 4D 06 stx	$064d
CD9A: BD 62 CE lda	$ce62, x
CD9D: 18       clc
CD9E: 6D 59 06 adc	$0659
CDA1: AA       tax
CDA2: BD E2 CE lda	$cee2, x
CDA5: AE 4D 06 ldx	$064d
CDA8: 91 47    sta ($47), y
CDAA: E8       inx
CDAB: C8       iny
CDAC: C0 0F    cpy #$0f
CDAE: D0 DD    bne	$cd8d
CDB0: A5 19    lda	$0019
CDB2: F0 0F    beq	$cdc3
CDB4: AD 59 06 lda	$0659
CDB7: 18       clc
CDB8: 69 07    adc #$07
CDBA: C9 1C    cmp #$1c
CDBC: 90 02    bcc	$cdc0
CDBE: A9 00    lda #$00
CDC0: 8D 59 06 sta	$0659
CDC3: EE AB 06 inc	$06ab
CDC6: A5 19    lda	$0019
CDC8: D0 43    bne	$ce0d
CDCA: AD AB 06 lda	$06ab
CDCD: C9 0A    cmp #$0a
CDCF: D0 39    bne	$ce0a
CDD1: A9 00    lda #$00
CDD3: 8D AB 06 sta	$06ab
CDD6: 8D AE 06 sta	$06ae
CDD9: EE AC 06 inc	$06ac
CDDC: A5 08    lda	$0008
CDDE: C9 F8    cmp #$f8
CDE0: F0 0F    beq	$cdf1
CDE2: AD AC 06 lda	$06ac
CDE5: C9 04    cmp #$04
CDE7: D0 05    bne	$cdee
CDE9: A9 00    lda #$00
CDEB: 8D AC 06 sta	$06ac
CDEE: B8       clv
CDEF: 50 0C    bvc	$cdfd
CDF1: AD AC 06 lda	$06ac
CDF4: C9 06    cmp #$06
CDF6: D0 05    bne	$cdfd
CDF8: A9 00    lda #$00
CDFA: 8D AC 06 sta	$06ac
CDFD: AD AC 06 lda	$06ac
CE00: CD 47 06 cmp	$0647
CE03: D0 05    bne	$ce0a
CE05: A9 01    lda #$01
CE07: 8D AE 06 sta	$06ae
CE0A: B8       clv
CE0B: 50 40    bvc	$ce4d
CE0D: AD AB 06 lda	$06ab
CE10: C9 08    cmp #$08
CE12: D0 39    bne	$ce4d
CE14: A9 00    lda #$00
CE16: 8D AB 06 sta	$06ab
CE19: 8D AE 06 sta	$06ae
CE1C: EE AC 06 inc	$06ac
CE1F: A5 08    lda	$0008
CE21: C9 F8    cmp #$f8
CE23: F0 0F    beq	$ce34
CE25: AD AC 06 lda	$06ac
CE28: C9 04    cmp #$04
CE2A: D0 05    bne	$ce31
CE2C: A9 00    lda #$00
CE2E: 8D AC 06 sta	$06ac
CE31: B8       clv
CE32: 50 0C    bvc	$ce40
CE34: AD AC 06 lda	$06ac
CE37: C9 06    cmp #$06
CE39: D0 05    bne	$ce40
CE3B: A9 00    lda #$00
CE3D: 8D AC 06 sta	$06ac
CE40: AD AC 06 lda	$06ac
CE43: CD 47 06 cmp	$0647
CE46: D0 05    bne	$ce4d
CE48: A9 01    lda #$01
CE4A: 8D AE 06 sta	$06ae
CE4D: 60       rts



D552: AD C1 00 lda number_of_credits_00c1
D555: F0 03    beq	$d55a
D557: 20 5B D5 jsr	$d55b
D55A: 60       rts

D55B: 20 F3 CA jsr	$caf3
D55E: A5 29    lda	$0029
D560: 05 2A    ora	$002a
D562: 29 01    and #$01
D564: D0 01    bne	$d567
D566: 60       rts
D567: A9 16    lda #$16
D569: 20 59 E6 jsr	$e659
D56C: A5 29    lda	$0029
D56E: 29 01    and #$01
D570: F0 08    beq	$d57a
D572: A9 00    lda #$00
D574: 8D 19 06 sta	$0619
D577: B8       clv
D578: 50 05    bvc	$d57f
D57A: A9 01    lda #$01
D57C: 8D 19 06 sta	$0619
D57F: A9 00    lda #$00
D581: 85 77    sta	$0077
D583: 85 78    sta	$0078
D585: AC 19 06 ldy	$0619
D588: AD 18 06 lda	$0618
D58B: 38       sec
D58C: F9 3E CB sbc	$cb3e, y
D58F: C9 30    cmp #$30
D591: B0 05    bcs	$d598
D593: A9 14    lda #$14
D595: 4C 59 E6 jmp	$e659
D598: 8D 18 06 sta	$0618
D59B: 78       sei
D59C: AD C1 00 lda number_of_credits_00c1
D59F: 38       sec
D5A0: F9 3E CB sbc	$cb3e, y
D5A3: 8D C1 00 sta number_of_credits_00c1
D5A6: 58       cli
D5A7: B9 3A CB lda	$cb3a, y
D5AA: 85 0B    sta	$000b
D5AC: A5 4E    lda	$004e
D5AE: 05 4F    ora	$004f
D5B0: D0 03    bne	$d5b5
D5B2: 4C 05 CB jmp	$cb05
D5B5: 4C 45 A9 jmp	$a945

switch_to_bank_0_D5B8:
D5B8: 08       php
D5B9: 78       sei
D5BA: AD 00 60 lda bank_switch_start_6000
D5BD: AD 80 60 lda	$6080
D5C0: 28       plp
D5C1: 60       rts

switch_to_bank_0_d5c2:
D5C2: 08       php
D5C3: 78       sei
D5C4: AD 00 60 lda bank_switch_start_6000
D5C7: AD 90 60 lda	$6090
D5CA: 28       plp
D5CB: 60       rts

D5CC: 85 04    sta	$0004
D5CE: 84 06    sty	$0006
D5D0: A0 00    ldy #$00
D5D2: B1 00    lda ($00), y
D5D4: 91 02    sta ($02), y
D5D6: E6 02    inc	$0002
D5D8: A5 05    lda	$0005
D5DA: 91 02    sta ($02), y
D5DC: C8       iny
D5DD: C4 04    cpy	$0004
D5DF: 90 F1    bcc	$d5d2
D5E1: A4 06    ldy	$0006
D5E3: 60       rts
D5E4: 85 04    sta	$0004
D5E6: 84 06    sty	$0006
D5E8: 08       php
D5E9: 78       sei
; switch to bank 1
D5EA: AD 00 60 lda bank_switch_start_6000
D5ED: AD 4F 75 lda	$754f
D5F0: AD B0 60 lda	$60b0
D5F3: AD 40 75 lda	$7540
D5F6: AD 41 75 lda	$7541
D5F9: AD 51 75 lda	$7551
D5FC: AD 90 60 lda	$6090
D5FF: 28       plp
D600: A0 00    ldy #$00
D602: B1 00    lda ($00), y
D604: F0 0E    beq	$d614
D606: C9 F0    cmp #$f0
D608: 90 04    bcc	$d60e
D60A: A9 00    lda #$00
D60C: F0 06    beq	$d614
D60E: 29 0F    and #$0f
D610: 18       clc
D611: 6D 05 65 adc	$6505
D614: 91 02    sta ($02), y
D616: E6 02    inc	$0002
D618: B1 00    lda ($00), y
D61A: F0 0D    beq	$d629
D61C: C9 F0    cmp #$f0
D61E: 90 04    bcc	$d624
D620: A9 00    lda #$00
D622: F0 05    beq	$d629
D624: 29 70    and #$70
D626: 18       clc
D627: 69 70    adc #$70
D629: 91 02    sta ($02), y
D62B: C8       iny
D62C: C4 04    cpy	$0004
D62E: 90 D2    bcc	$d602
D630: A4 06    ldy	$0006
D632: 60       rts
D633: 85 04    sta	$0004
D635: 84 06    sty	$0006
D637: A0 00    ldy #$00
D639: B1 00    lda ($00), y
D63B: 91 02    sta ($02), y
D63D: C8       iny
D63E: B1 00    lda ($00), y
D640: 91 02    sta ($02), y
D642: C8       iny
D643: C6 04    dec	$0004
D645: D0 F2    bne	$d639
D647: A4 06    ldy	$0006
D649: 60       rts
D64A: 85 04    sta	$0004
D64C: 84 06    sty	$0006
D64E: A0 00    ldy #$00
D650: A5 04    lda	$0004
D652: 91 02    sta ($02), y
D654: C8       iny
D655: A5 05    lda	$0005
D657: 91 02    sta ($02), y
D659: A4 06    ldy	$0006
D65B: 60       rts
D65C: A0 00    ldy #$00
D65E: B1 00    lda ($00), y
D660: 91 02    sta ($02), y
D662: E6 02    inc	$0002
D664: A5 05    lda	$0005
D666: 91 02    sta ($02), y
D668: C8       iny
D669: B1 00    lda ($00), y
D66B: C9 FF    cmp #$ff
D66D: D0 F1    bne	$d660
D66F: 60       rts
D670: 0A       asl a
D671: A8       tay
D672: 08       php
D673: 78       sei
; switch to bank 1
D674: AD 00 60 lda bank_switch_start_6000
D677: AD 4F 75 lda	$754f
D67A: AD 90 60 lda	$6090
D67D: AD 41 75 lda	$7541
D680: AD 43 75 lda	$7543
D683: AD 52 75 lda	$7552
D686: AD 90 60 lda	$6090
D689: 28       plp
D68A: B9 40 40 lda	$4040, y
D68D: 85 00    sta	$0000
D68F: B9 41 40 lda	$4041, y
D692: 85 01    sta	$0001
D694: A0 00    ldy #$00
D696: B1 00    lda ($00), y
D698: F0 1F    beq	$d6b9
D69A: 85 02    sta	$0002
D69C: C8       iny
D69D: B1 00    lda ($00), y
D69F: 85 03    sta	$0003
D6A1: C8       iny
D6A2: B1 00    lda ($00), y
D6A4: 85 05    sta	$0005
D6A6: 98       tya
D6A7: 38       sec
D6A8: 65 00    adc	$0000
D6AA: 85 00    sta	$0000
D6AC: A5 01    lda	$0001
D6AE: 69 00    adc #$00
D6B0: 85 01    sta	$0001
D6B2: 20 5C D6 jsr	$d65c
D6B5: C8       iny
D6B6: 4C 96 D6 jmp	$d696
D6B9: 60       rts
D6BA: 10 05    bpl	$d6c1
D6BC: 49 FF    eor #$ff
D6BE: 18       clc
D6BF: 69 01    adc #$01
D6C1: 60       rts
D6C2: A9 10    lda #$10
D6C4: 85 1C    sta	$001c
D6C6: A9 00    lda #$00
D6C8: 85 1B    sta	$001b
D6CA: A9 00    lda #$00
D6CC: AA       tax
D6CD: A8       tay
D6CE: 91 1B    sta ($1b), y
D6D0: C8       iny
D6D1: D0 FB    bne	$d6ce
D6D3: E6 1C    inc	$001c
D6D5: E8       inx
D6D6: E0 10    cpx #$10
D6D8: D0 F4    bne	$d6ce
D6DA: 60       rts
D6DB: A5 25    lda	$0025
D6DD: 85 23    sta	$0023
D6DF: A5 26    lda	$0026
D6E1: 85 24    sta	$0024
D6E3: 8D 1B 28 sta	$281b
D6E6: AD 18 28 lda	$2818
D6E9: 85 25    sta	$0025
D6EB: 4A       lsr a
D6EC: 4A       lsr a
D6ED: 4A       lsr a
D6EE: 4A       lsr a
D6EF: 85 26    sta	$0026
D6F1: A5 27    lda	$0027
D6F3: 49 FF    eor #$ff
D6F5: 25 25    and	$0025
D6F7: 85 29    sta	$0029
D6F9: A5 28    lda	$0028
D6FB: 49 FF    eor #$ff
D6FD: 25 26    and	$0026
D6FF: 85 2A    sta	$002a
D701: A5 23    lda	$0023
D703: 05 25    ora	$0025
D705: 85 27    sta	$0027
D707: A5 24    lda	$0024
D709: 05 26    ora	$0026
D70B: 85 28    sta	$0028
D70D: 60       rts

periodic_interrupt_D70E:
; save registers
D70E: 48       pha
D70F: 8A       txa
D710: 48       pha
D711: 98       tya
D712: 48       pha
; copy first byte of rom bank in first_byte_of_bank_0d
D713: AD 00 40 lda	$4000
D716: 85 0D    sta first_byte_of_bank_0d
D718: D8       cld
D719: 8D 0B 28 sta	$280b
D71C: AD 08 28 lda	$2808
D71F: 8D 00 07 sta	$0700
D722: 10 21    bpl	$d745
D724: 29 40    and #$40
D726: D0 1A    bne	$d742
D728: E6 AC    inc	$00ac
D72A: E6 09    inc	$0009
D72C: E6 13    inc	$0013
D72E: D0 02    bne	$d732
D730: E6 14    inc	$0014
D732: E6 0F    inc	$000f
D734: D0 02    bne	$d738
D736: E6 10    inc	$0010
D738: A5 0F    lda	$000f
D73A: 29 07    and #$07
D73C: 85 12    sta	$0012
D73E: 29 03    and #$03
D740: 85 11    sta	$0011
D742: 4C D4 D7 jmp	$d7d4
D745: 29 40    and #$40
D747: D0 23    bne	$d76c
D749: A5 09    lda	$0009
D74B: 10 03    bpl	$d750
D74D: 4C 9B 82 jmp	$829b
D750: 8D 00 30 sta watchdog_3000
D753: E6 09    inc	$0009
D755: 20 10 D8 jsr	$d810
D758: E6 13    inc	$0013
D75A: E6 0F    inc	$000f
D75C: D0 04    bne	$d762
D75E: E6 14    inc	$0014
D760: E6 10    inc	$0010
D762: A5 0F    lda	$000f
D764: 29 07    and #$07
D766: 85 12    sta	$0012
D768: 29 03    and #$03
D76A: 85 11    sta	$0011
D76C: AD BC 08 lda	$08bc
D76F: 8D C0 00 sta	$00c0
D772: 20 7E F3 jsr	$f37e
D775: AD C1 00 lda number_of_credits_00c1
; limit number of credits to 9
D778: C9 0A    cmp #$0a
D77A: 90 0C    bcc	$d788
D77C: A9 09    lda #$09
D77E: 8D C1 00 sta number_of_credits_00c1
D781: 85 51    sta	$0051
D783: A9 39    lda #$39
D785: B8       clv
D786: 50 02    bvc	$d78a
D788: 09 30    ora #$30
D78A: 8D 18 06 sta	$0618
D78D: AD C1 00 lda number_of_credits_00c1
D790: C5 51    cmp	$0051
D792: F0 0C    beq	$d7a0
D794: 85 51    sta	$0051
D796: 90 08    bcc	$d7a0
D798: 20 16 BC jsr	$bc16
D79B: A9 13    lda #$13
D79D: 20 59 E6 jsr	$e659
D7A0: A5 52    lda	$0052
D7A2: 49 80    eor #$80
D7A4: 2D C7 00 and	$00c7
D7A7: 10 08    bpl	$d7b1
D7A9: A0 00    ldy #$00
D7AB: 20 4C F1 jsr	$f14c
D7AE: 20 16 BC jsr	$bc16
D7B1: A5 53    lda	$0053
D7B3: 49 80    eor #$80
D7B5: 2D C8 00 and	$00c8
D7B8: 10 08    bpl	$d7c2
D7BA: A0 02    ldy #$02
D7BC: 20 4C F1 jsr	$f14c
D7BF: 20 16 BC jsr	$bc16
D7C2: AD C7 00 lda	$00c7
D7C5: 85 52    sta	$0052
D7C7: 0A       asl a
D7C8: AD C8 00 lda	$00c8
D7CB: 85 53    sta	$0053
D7CD: 6A       ror a
D7CE: 4A       lsr a
D7CF: 4A       lsr a
D7D0: 29 30    and #$30
D7D2: 85 0E    sta	$000e
D7D4: 20 51 E6 jsr	$e651
D7D7: 20 1D EB jsr	$eb1d
; first_byte_of_bank_0d tells if we need to switch bank
D7DA: A5 0D    lda first_byte_of_bank_0d
D7DC: D0 18    bne	$d7f6
D7DE: 08       php
D7DF: 78       sei
; switch to bank 1
D7E0: AD 00 60 lda bank_switch_start_6000
D7E3: AD 4F 75 lda	$754f
D7E6: AD B0 60 lda	$60b0
D7E9: AD 42 75 lda	$7542
D7EC: AD 43 75 lda	$7543
D7EF: AD 53 75 lda	$7553
D7F2: AD B0 60 lda	$60b0
D7F5: 28       plp

D7F6: A5 0E    lda	$000e
D7F8: 8D 00 3C sta	$3c00
D7FB: 8D 0B 28 sta	$280b
D7FE: AD 08 28 lda	$2808
D801: 85 58    sta	$0058
D803: 29 40    and #$40
D805: F0 F4    beq	$d7fb
D807: 8D 00 38 sta	$3800
; restore registers, end of interrupt
D80A: 68       pla
D80B: A8       tay
D80C: 68       pla
D80D: AA       tax
D80E: 68       pla
D80F: 40       rti

; switch to bank 1 (not sure but probably, yes)
D810: AD 00 60 lda bank_switch_start_6000
D813: AD A2 06 lda	$06a2
D816: D0 06    bne	$d81e
D818: 20 5D D8 jsr	$d85d
D81B: B8       clv
D81C: 50 3E    bvc	$d85c
D81E: C9 03    cmp #$03
D820: D0 1F    bne	$d841
D822: AD 4F 75 lda	$754f
; second part of the switch, only switches if reaches there
D825: AD 90 60 lda	$6090
D828: AD 41 75 lda	$7541
D82B: AD 43 75 lda	$7543
D82E: AD 52 75 lda	$7552
D831: AD 90 60 lda	$6090
D834: 20 CA D8 jsr	$d8ca
D837: A9 00    lda #$00
D839: 8D A2 06 sta	$06a2
D83C: A9 00    lda #$00
D83E: 8D A3 06 sta sync_variable_06a3
D841: AD A2 06 lda	$06a2
D844: C9 01    cmp #$01
D846: D0 14    bne	$d85c
D848: A0 00    ldy #$00
D84A: A9 00    lda #$00
D84C: 99 00 20 sta	$2000, y
D84F: C8       iny
D850: D0 F8    bne	$d84a
D852: A9 01    lda #$01
D854: 8D A3 06 sta sync_variable_06a3
D857: A9 02    lda #$02
D859: 8D A2 06 sta	$06a2
D85C: 60       rts

D85D: AD 4F 75 lda	$754f
D860: 85 B8    sta	$00b8
; bank switching occurs here too
D862: AD 90 60 lda	$6090
D865: 85 BC    sta	$00bc
D867: AD 41 75 lda	$7541
D86A: 85 BA    sta	$00ba
D86C: AD 43 75 lda	$7543
D86F: 85 BB    sta	$00bb
D871: AD 53 75 lda	$7553
D874: 85 B9    sta	$00b9
D876: AD 90 60 lda	$6090
D879: 85 BD    sta	$00bd
D87B: 20 F9 E0 jsr	$e0f9
D87E: 20 CA D8 jsr	$d8ca
D881: A5 08    lda	$0008
D883: C9 FB    cmp #$fb
D885: F0 36    beq	$d8bd
D887: C9 EF    cmp #$ef
D889: F0 32    beq	$d8bd
D88B: 20 45 E1 jsr	$e145
D88E: 20 96 E3 jsr	$e396
D891: 20 1B E2 jsr	$e21b
D894: A5 0F    lda	$000f
D896: 29 03    and #$03
D898: D0 06    bne	$d8a0
D89A: 20 12 E4 jsr	$e412
D89D: B8       clv
D89E: 50 17    bvc	$d8b7
D8A0: C9 01    cmp #$01
D8A2: D0 06    bne	$d8aa
D8A4: 20 1D E4 jsr	$e41d
D8A7: B8       clv
D8A8: 50 0D    bvc	$d8b7
D8AA: C9 02    cmp #$02
D8AC: D0 06    bne	$d8b4
D8AE: 20 6F E5 jsr	$e56f
D8B1: B8       clv
D8B2: 50 03    bvc	$d8b7
D8B4: 20 7A E5 jsr	$e57a
D8B7: 20 EE E4 jsr	$e4ee
D8BA: 20 0C E1 jsr	$e10c
D8BD: A5 08    lda	$0008
D8BF: C9 F8    cmp #$f8
D8C1: D0 06    bne	$d8c9
D8C3: 20 7C CC jsr	$cc7c
D8C6: 20 50 CD jsr	$cd50
D8C9: 60       rts
D8CA: A5 07    lda	$0007
D8CC: F0 1A    beq	$d8e8
D8CE: 0A       asl a
D8CF: A8       tay
D8D0: B9 E7 D8 lda	$d8e7, y
D8D3: 85 5A    sta	$005a
D8D5: B9 E8 D8 lda	$d8e8, y
D8D8: 85 5B    sta	$005b
D8DA: A0 00    ldy #$00
D8DC: B1 5A    lda ($5a), y
D8DE: 99 00 20 sta	$2000, y
D8E1: C8       iny
D8E2: D0 F8    bne	$d8dc
D8E4: A9 00    lda #$00
D8E6: 85 07    sta	$0007
D8E8: 60       rts


E0F9: A5 08    lda	$0008
E0FB: C9 FB    cmp #$fb
E0FD: D0 03    bne	$e102
E0FF: 20 91 C3 jsr fade_out_C391
E102: A5 08    lda	$0008
E104: C9 EF    cmp #$ef
E106: D0 03    bne	$e10b
E108: 20 91 C3 jsr fade_out_C391
E10B: 60       rts

E10C: AD 41 06 lda	$0641
E10F: 18       clc
E110: 69 01    adc #$01
E112: 29 07    and #$07
E114: 8D 41 06 sta	$0641
E117: AA       tax
E118: BD 35 E1 lda	$e135, x
E11B: 8D FB 20 sta	$20fb
E11E: A5 11    lda	$0011
E120: D0 12    bne	$e134
E122: AD 42 06 lda	$0642
E125: 18       clc
E126: 69 01    adc #$01
E128: 29 07    and #$07
E12A: 8D 42 06 sta	$0642
E12D: AA       tax
E12E: BD 3D E1 lda	$e13d, x
E131: 8D F6 20 sta	$20f6
E134: 60       rts

E145: A6 45    ldx	$0045
E147: BD FD E1 lda	$e1fd, x
E14A: 8D 53 06 sta	$0653
E14D: BD 00 E2 lda	$e200, x
E150: 8D 54 06 sta	$0654
E153: AD 70 06 lda	$0670
E156: F0 51    beq	$e1a9
E158: A2 00    ldx #$00
E15A: 8A       txa
E15B: 0A       asl a
E15C: A8       tay
E15D: B9 03 E2 lda	$e203, y
E160: 85 5A    sta	$005a
E162: B9 04 E2 lda	$e204, y
E165: 85 5B    sta	$005b
E167: EC 70 06 cpx	$0670
E16A: D0 12    bne	$e17e
E16C: AD 71 06 lda	$0671
E16F: 29 03    and #$03
E171: D0 05    bne	$e178
E173: A9 FF    lda #$ff
E175: B8       clv
E176: 50 03    bvc	$e17b
E178: AD 53 06 lda	$0653
E17B: B8       clv
E17C: 50 03    bvc	$e181
E17E: AD 54 06 lda	$0654
E181: A0 00    ldy #$00
E183: 91 5A    sta ($5a), y
E185: E8       inx
E186: E0 06    cpx #$06
E188: D0 D0    bne	$e15a
E18A: CE 71 06 dec	$0671
E18D: AD 71 06 lda	$0671
E190: D0 14    bne	$e1a6
E192: AD 70 06 lda	$0670
E195: C9 01    cmp #$01
E197: D0 08    bne	$e1a1
E199: A9 64    lda #$64
E19B: 8D 71 06 sta	$0671
E19E: B8       clv
E19F: 50 05    bvc	$e1a6
E1A1: A9 00    lda #$00
E1A3: 8D 70 06 sta	$0670
E1A6: B8       clv
E1A7: 50 53    bvc	$e1fc
E1A9: AD 72 06 lda	$0672
E1AC: F0 4E    beq	$e1fc
E1AE: A2 00    ldx #$00
E1B0: 8A       txa
E1B1: 0A       asl a
E1B2: A8       tay
E1B3: B9 0F E2 lda	$e20f, y
E1B6: 85 5A    sta	$005a
E1B8: B9 10 E2 lda	$e210, y
E1BB: 85 5B    sta	$005b
E1BD: EC 72 06 cpx	$0672
E1C0: D0 12    bne	$e1d4
E1C2: AD 73 06 lda	$0673
E1C5: 29 03    and #$03
E1C7: D0 05    bne	$e1ce
E1C9: A9 FF    lda #$ff
E1CB: B8       clv
E1CC: 50 03    bvc	$e1d1
E1CE: AD 53 06 lda	$0653
E1D1: B8       clv
E1D2: 50 03    bvc	$e1d7
E1D4: AD 54 06 lda	$0654
E1D7: A0 00    ldy #$00
E1D9: 91 5A    sta ($5a), y
E1DB: E8       inx
E1DC: E0 06    cpx #$06
E1DE: D0 D0    bne	$e1b0
E1E0: CE 73 06 dec	$0673
E1E3: AD 73 06 lda	$0673
E1E6: D0 14    bne	$e1fc
E1E8: AD 72 06 lda	$0672
E1EB: C9 01    cmp #$01
E1ED: D0 08    bne	$e1f7
E1EF: A9 64    lda #$64
E1F1: 8D 73 06 sta	$0673
E1F4: B8       clv
E1F5: 50 05    bvc	$e1fc
E1F7: A9 00    lda #$00
E1F9: 8D 72 06 sta	$0672
E1FC: 60       rts

E21B: AD C6 06 lda	$06c6
E21E: F0 08    beq	$e228
E220: 20 6C E3 jsr	$e36c
E223: A9 00    lda #$00
E225: 8D C6 06 sta	$06c6
E228: A5 08    lda	$0008
E22A: F0 01    beq	$e22d
E22C: 60       rts
E22D: A5 2D    lda	$002d
E22F: F0 01    beq	$e232
E231: 60       rts
E232: A5 43    lda	$0043
E234: F0 01    beq	$e237
E236: 60       rts
E237: A5 0B    lda	$000b
E239: C9 01    cmp #$01
E23B: F0 01    beq	$e23e
E23D: 60       rts
E23E: 18       clc
E23F: AD 9B 06 lda	$069b
E242: 6D 9C 06 adc	$069c
E245: F0 01    beq	$e248
E247: 60       rts
E248: A5 0F    lda	$000f
E24A: 29 0F    and #$0f
E24C: F0 01    beq	$e24f
E24E: 60       rts
E24F: A9 00    lda #$00
E251: 8D 9A 06 sta	$069a
E254: A5 35    lda	$0035
E256: F0 03    beq	$e25b
E258: 4C 9B E2 jmp	$e29b
E25B: A5 36    lda	$0036
E25D: F0 03    beq	$e262
E25F: 4C 9B E2 jmp	$e29b
E262: A5 30    lda	$0030
E264: C5 32    cmp	$0032
E266: B0 05    bcs	$e26d
E268: A9 01    lda #$01
E26A: 8D 9A 06 sta	$069a
E26D: A5 32    lda	$0032
E26F: C5 30    cmp	$0030
E271: B0 05    bcs	$e278
E273: A9 02    lda #$02
E275: 8D 9A 06 sta	$069a
E278: AD 9A 06 lda	$069a
E27B: D0 16    bne	$e293
E27D: A5 31    lda	$0031
E27F: C5 33    cmp	$0033
E281: B0 05    bcs	$e288
E283: A9 01    lda #$01
E285: 8D 9A 06 sta	$069a
E288: A5 33    lda	$0033
E28A: C5 31    cmp	$0031
E28C: B0 05    bcs	$e293
E28E: A9 02    lda #$02
E290: 8D 9A 06 sta	$069a
E293: A6 45    ldx	$0045
E295: BD 00 E2 lda	$e200, x
E298: 8D 54 06 sta	$0654
E29B: AD 9A 06 lda	$069a
E29E: C9 00    cmp #$00
E2A0: D0 1E    bne	$e2c0
E2A2: A2 00    ldx #$00
E2A4: 8A       txa
E2A5: 0A       asl a
E2A6: AA       tax
E2A7: BD FD E2 lda	$e2fd, x
E2AA: 85 47    sta	$0047
E2AC: BD FE E2 lda	$e2fe, x
E2AF: 85 48    sta	$0048
E2B1: AD 54 06 lda	$0654
E2B4: A0 00    ldy #$00
E2B6: 91 47    sta ($47), y
E2B8: 8A       txa
E2B9: 4A       lsr a
E2BA: AA       tax
E2BB: E8       inx
E2BC: E0 0A    cpx #$0a
E2BE: 90 E4    bcc	$e2a4
E2C0: AD 9A 06 lda	$069a
E2C3: C9 01    cmp #$01
E2C5: D0 17    bne	$e2de
E2C7: A9 80    lda #$80
E2C9: 8D 54 06 sta	$0654
E2CC: A2 00    ldx #$00
E2CE: 8A       txa
E2CF: 0A       asl a
E2D0: AA       tax
E2D1: BD FD E2 lda	$e2fd, x
E2D4: 85 47    sta	$0047
E2D6: BD FE E2 lda	$e2fe, x
E2D9: 20 1D E3 jsr	$e31d
E2DC: 90 F0    bcc	$e2ce
E2DE: AD 9A 06 lda	$069a
E2E1: C9 02    cmp #$02
E2E3: D0 17    bne	$e2fc
E2E5: A9 02    lda #$02
E2E7: 8D 54 06 sta	$0654
E2EA: A2 00    ldx #$00
E2EC: 8A       txa
E2ED: 0A       asl a
E2EE: AA       tax
E2EF: BD 0D E3 lda	$e30d, x
E2F2: 85 47    sta	$0047
E2F4: BD 0E E3 lda	$e30e, x
E2F7: 20 1D E3 jsr	$e31d
E2FA: 90 F0    bcc	$e2ec
E2FC: 60       rts

E31D: 85 48    sta	$0048
E31F: 8A       txa
E320: 4A       lsr a
E321: AA       tax
E322: E0 02    cpx #$02
E324: B0 0A    bcs	$e330
E326: AD 54 06 lda	$0654
E329: A0 00    ldy #$00
E32B: 91 47    sta ($47), y
E32D: B8       clv
E32E: 50 38    bvc	$e368
E330: E0 05    cpx #$05
E332: 90 0C    bcc	$e340
E334: A4 45    ldy	$0045
E336: B9 00 E2 lda	$e200, y
E339: A0 00    ldy #$00
E33B: 91 47    sta ($47), y
E33D: B8       clv
E33E: 50 28    bvc	$e368
E340: A5 0F    lda	$000f
E342: 4A       lsr a
E343: 4A       lsr a
E344: 4A       lsr a
E345: 4A       lsr a
E346: 29 03    and #$03
E348: 18       clc
E349: 69 02    adc #$02
E34B: 8D 53 06 sta	$0653
E34E: EC 53 06 cpx	$0653
E351: D0 08    bne	$e35b
E353: AD 54 06 lda	$0654
E356: 85 49    sta	$0049
E358: B8       clv
E359: 50 07    bvc	$e362
E35B: A4 45    ldy	$0045
E35D: B9 00 E2 lda	$e200, y
E360: 85 49    sta	$0049
E362: A5 49    lda	$0049
E364: A0 00    ldy #$00
E366: 91 47    sta ($47), y
E368: E8       inx
E369: E0 08    cpx #$08
E36B: 60       rts
E36C: 8A       txa
E36D: 48       pha
E36E: A6 45    ldx	$0045
E370: BD 00 E2 lda	$e200, x
E373: 8D C2 06 sta	$06c2
E376: A2 00    ldx #$00
E378: 8A       txa
E379: 0A       asl a
E37A: AA       tax
E37B: BD FD E2 lda	$e2fd, x
E37E: 85 47    sta	$0047
E380: BD FE E2 lda	$e2fe, x
E383: 85 48    sta	$0048
E385: AD C2 06 lda	$06c2
E388: A0 00    ldy #$00
E38A: 91 47    sta ($47), y
E38C: 8A       txa
E38D: 4A       lsr a
E38E: AA       tax
E38F: E8       inx
E390: E0 0A    cpx #$0a
E392: 90 E4    bcc	$e378
E394: 68       pla
E395: AA       tax
E396: A5 0F    lda	$000f
E398: 29 01    and #$01
E39A: D0 35    bne	$e3d1
E39C: A5 77    lda	$0077
E39E: F0 2E    beq	$e3ce
E3A0: AD 0E E4 lda	$e40e
E3A3: 85 5A    sta	$005a
E3A5: AD 0F E4 lda	$e40f
E3A8: 85 5B    sta	$005b
E3AA: AD 15 06 lda	$0615
E3AD: C9 01    cmp #$01
E3AF: 90 1D    bcc	$e3ce
E3B1: A2 00    ldx #$00
E3B3: 86 47    stx	$0047
E3B5: AD 15 06 lda	$0615
E3B8: 38       sec
E3B9: E9 01    sbc #$01
E3BB: A8       tay
E3BC: BD 04 E4 lda	$e404, x
E3BF: C4 47    cpy	$0047
E3C1: B0 02    bcs	$e3c5
E3C3: A9 00    lda #$00
E3C5: A4 47    ldy	$0047
E3C7: 91 5A    sta ($5a), y
E3C9: E8       inx
E3CA: E0 09    cpx #$09
E3CC: 90 E5    bcc	$e3b3
E3CE: B8       clv
E3CF: 50 32    bvc	$e403
E3D1: A5 78    lda	$0078
E3D3: F0 2E    beq	$e403
E3D5: AD 17 06 lda	$0617
E3D8: C9 01    cmp #$01
E3DA: 90 27    bcc	$e403
E3DC: AD 10 E4 lda	$e410
E3DF: 85 5A    sta	$005a
E3E1: AD 11 E4 lda	$e411
E3E4: 85 5B    sta	$005b
E3E6: A2 00    ldx #$00
E3E8: 86 47    stx	$0047
E3EA: AD 17 06 lda	$0617
E3ED: 38       sec
E3EE: E9 01    sbc #$01
E3F0: A8       tay
E3F1: BD 04 E4 lda	$e404, x
E3F4: C4 47    cpy	$0047
E3F6: B0 02    bcs	$e3fa
E3F8: A9 00    lda #$00
E3FA: A4 47    ldy	$0047
E3FC: 91 5A    sta ($5a), y
E3FE: E8       inx
E3FF: E0 09    cpx #$09
E401: 90 E5    bcc	$e3e8
E403: 60       rts

E412: A9 00    lda #$00
E414: 8D 4C 06 sta	$064c
E417: A2 00    ldx #$00
E419: 20 28 E4 jsr	$e428
E41C: 60       rts

E41D: A9 18    lda #$18
E41F: 8D 4C 06 sta	$064c
E422: A2 01    ldx #$01
E424: 20 28 E4 jsr	$e428
E427: 60       rts

E428: A5 0F    lda	$000f
E42A: 4A       lsr a
E42B: 4A       lsr a
E42C: 29 07    and #$07
E42E: A8       tay
E42F: B9 E0 E4 lda	$e4e0, y
E432: 85 49    sta	$0049
E434: A4 45    ldy	$0045
E436: B9 E8 E4 lda	$e4e8, y
E439: 85 4C    sta	$004c
E43B: A4 45    ldy	$0045
E43D: B9 EB E4 lda	$e4eb, y
E440: 85 4D    sta	$004d
E442: B5 77    lda	$0077, x
E444: F0 45    beq	$e48b
E446: B5 35    lda	$0035, x
E448: C9 02    cmp #$02
E44A: D0 3F    bne	$e48b
E44C: EE 74 06 inc	$0674
E44F: AD 74 06 lda	$0674
E452: C9 0C    cmp #$0c
E454: 90 05    bcc	$e45b
E456: A9 00    lda #$00
E458: 8D 74 06 sta	$0674
E45B: A8       tay
E45C: B9 D4 E4 lda	$e4d4, y
E45F: 85 47    sta	$0047
E461: A2 00    ldx #$00
E463: 8A       txa
E464: 0A       asl a
E465: 18       clc
E466: 6D 4C 06 adc	$064c
E469: A8       tay
E46A: B9 8C E4 lda	$e48c, y
E46D: 85 5A    sta	$005a
E46F: B9 8D E4 lda	$e48d, y
E472: 85 5B    sta	$005b
E474: A5 4C    lda	$004c
E476: E0 06    cpx #$06
E478: 90 02    bcc	$e47c
E47A: A5 4D    lda	$004d
E47C: E4 47    cpx	$0047
E47E: D0 02    bne	$e482
E480: A5 49    lda	$0049
E482: A0 00    ldy #$00
E484: 91 5A    sta ($5a), y
E486: E8       inx
E487: E0 0C    cpx #$0c
E489: 90 D8    bcc	$e463
E48B: 60       rts

E4EE: A5 08    lda	$0008                                             
E4F0: C9 FE    cmp #$fe
E4F2: D0 75    bne	$e569
E4F4: A5 0F    lda	$000f
E4F6: 4A       lsr a
E4F7: 4A       lsr a
E4F8: 29 07    and #$07
E4FA: A8       tay
E4FB: B9 E0 E4 lda	$e4e0, y
E4FE: 85 49    sta	$0049
E500: EE 74 06 inc	$0674
E503: AD 74 06 lda	$0674
E506: C9 0C    cmp #$0c
E508: 90 05    bcc	$e50f
E50A: A9 00    lda #$00
E50C: 8D 74 06 sta	$0674
E50F: A8       tay
E510: B9 D4 E4 lda	$e4d4, y
E513: 85 47    sta	$0047
E515: A2 00    ldx #$00
E517: 8A       txa
E518: 0A       asl a
E519: A8       tay
E51A: B9 8C E4 lda	$e48c, y
E51D: 85 5A    sta	$005a
E51F: B9 8D E4 lda	$e48d, y
E522: 85 5B    sta	$005b
E524: AD 8C 06 lda	$068c
E527: C9 01    cmp #$01
E529: D0 0D    bne	$e538
E52B: B9 A4 E4 lda	$e4a4, y
E52E: 85 5A    sta	$005a
E530: B9 A5 E4 lda	$e4a5, y
E533: 85 5B    sta	$005b
E535: B8       clv
E536: 50 11    bvc	$e549
E538: AD 8C 06 lda	$068c
E53B: C9 02    cmp #$02
E53D: D0 0A    bne	$e549
E53F: B9 BC E4 lda	$e4bc, y
E542: 85 5A    sta	$005a
E544: B9 BD E4 lda	$e4bd, y
E547: 85 5B    sta	$005b
E549: AD E8 E4 lda	$e4e8
E54C: E0 06    cpx #$06
E54E: 90 03    bcc	$e553
E550: AD EB E4 lda	$e4eb
E553: A4 46    ldy	$0046
E555: CC 8C 06 cpy	$068c
E558: D0 06    bne	$e560
E55A: E4 47    cpx	$0047
E55C: D0 02    bne	$e560
E55E: A5 49    lda	$0049
E560: A0 00    ldy #$00
E562: 91 5A    sta ($5a), y
E564: E8       inx
E565: E0 0C    cpx #$0c
E567: 90 AE    bcc	$e517
E569: A5 46    lda	$0046
E56B: 8D 8C 06 sta	$068c
E56E: 60       rts
E56F: A9 00    lda #$00
E571: 8D 4C 06 sta	$064c
E574: A2 00    ldx #$00
E576: 20 85 E5 jsr	$e585
E579: 60       rts
E57A: A9 18    lda #$18
E57C: 8D 4C 06 sta	$064c
E57F: A2 01    ldx #$01
E581: 20 85 E5 jsr	$e585
E584: 60       rts
E585: A5 0F    lda	$000f
E587: 4A       lsr a
E588: 4A       lsr a
E589: 29 07    and #$07
E58B: A8       tay
E58C: B9 E0 E4 lda	$e4e0, y
E58F: 85 49    sta	$0049
E591: A4 45    ldy	$0045
E593: B9 E8 E4 lda	$e4e8, y
E596: 85 4C    sta	$004c
E598: A4 45    ldy	$0045
E59A: B9 EB E4 lda	$e4eb, y
E59D: 85 4D    sta	$004d
E59F: A5 77    lda	$0077
E5A1: F0 79    beq	$e61c
E5A3: A9 00    lda #$00
E5A5: 85 4A    sta	$004a
E5A7: 85 4B    sta	$004b
E5A9: A5 43    lda	$0043
E5AB: F0 06    beq	$e5b3
E5AD: A9 01    lda #$01
E5AF: 85 4A    sta	$004a
E5B1: 85 4B    sta	$004b
E5B3: BD 7B 06 lda	$067b, x
E5B6: F0 03    beq	$e5bb
E5B8: DE 7B 06 dec	$067b, x
E5BB: BD 7B 06 lda	$067b, x
E5BE: F0 04    beq	$e5c4
E5C0: A9 01    lda #$01
E5C2: 85 4B    sta	$004b
E5C4: BD 7B 06 lda	$067b, x
E5C7: C9 01    cmp #$01
E5C9: D0 04    bne	$e5cf
E5CB: A9 01    lda #$01
E5CD: 85 4A    sta	$004a
E5CF: B5 35    lda	$0035, x
E5D1: C9 04    cmp #$04
E5D3: 90 06    bcc	$e5db
E5D5: A9 01    lda #$01
E5D7: 85 4A    sta	$004a
E5D9: 85 4B    sta	$004b
E5DB: B5 35    lda	$0035, x
E5DD: C9 03    cmp #$03
E5DF: D0 02    bne	$e5e3
E5E1: 85 4B    sta	$004b
E5E3: A5 4B    lda	$004b
E5E5: F0 35    beq	$e61c
E5E7: FE 75 06 inc	$0675, x
E5EA: BD 75 06 lda	$0675, x
E5ED: C9 06    cmp #$06
E5EF: 90 05    bcc	$e5f6
E5F1: A9 00    lda #$00
E5F3: 9D 75 06 sta	$0675, x
E5F6: 0A       asl a
E5F7: A8       tay
E5F8: B9 1D E6 lda	$e61d, y
E5FB: 85 47    sta	$0047
E5FD: B9 1E E6 lda	$e61e, y
E600: 85 48    sta	$0048
E602: A2 00    ldx #$00
E604: 8A       txa
E605: 0A       asl a
E606: 18       clc
E607: 6D 4C 06 adc	$064c
E60A: A8       tay
E60B: B9 8C E4 lda	$e48c, y
E60E: 85 5A    sta	$005a
E610: B9 8D E4 lda	$e48d, y
E613: 85 5B    sta	$005b
E615: 20 29 E6 jsr	$e629
E618: E0 0C    cpx #$0c
E61A: 90 E8    bcc	$e604
E61C: 60       rts

E629: A5 4C    lda	$004c                                             
E62B: E0 06    cpx #$06                                            
E62D: 90 02    bcc	$e631
E62F: A5 4D    lda	$004d
E631: A4 4A    ldy	$004a
E633: C0 00    cpy #$00
E635: D0 0C    bne	$e643
E637: E4 47    cpx	$0047
E639: D0 02    bne	$e63d
E63B: A5 49    lda	$0049
E63D: E4 48    cpx	$0048
E63F: D0 02    bne	$e643
E641: A5 49    lda	$0049
E643: A0 00    ldy #$00
E645: 91 5A    sta ($5a), y
E647: E8       inx
E648: 60       rts

E649: 48       pha
E64A: 20 C2 D5 jsr switch_to_bank_0_d5c2
E64D: 68       pla
E64E: 4C 2D 40 jmp	$402d

E651: 48       pha
E652: 20 C2 D5 jsr switch_to_bank_0_d5c2
E655: 68       pla
E656: 4C 04 40 jmp	$4004

E659: 48       pha
E65A: 20 C2 D5 jsr switch_to_bank_0_d5c2
E65D: 68       pla
E65E: 4C 41 41 jmp	$4141

continue_startup_e661:
E661: 78       sei
E662: D8       cld
E663: A2 FF    ldx #$ff
E665: 9A       txs			; set stack on top
E666: E8       inx			; X=0
; switch to bank 1
E667: AD 00 60 lda bank_switch_start_6000
E66A: AD 4F 75 lda	$754f
E66D: AD 90 60 lda	$6090
E670: AD 41 75 lda	$7541
E673: AD 43 75 lda	$7543
E676: AD 52 75 lda	$7552
E679: AD 90 60 lda	$6090
E67C: A0 18    ldy #$18
E67E: A9 30    lda #$30
; put	$0030 in	$0600-$617
E680: 99 00 06 sta	$0600, y
E683: 88       dey
E684: 10 FA    bpl	$e680
; put	$0020 in a lot of RAM locations
E686: A9 20    lda #$20
E688: 8D 5B 06 sta	$065b
E68B: 8D 5C 06 sta	$065c
E68E: 8D 5D 06 sta	$065d
E691: 8D 5E 06 sta	$065e
E694: 8D 5F 06 sta	$065f
E697: 8D 60 06 sta	$0660
E69A: 8D 61 06 sta	$0661
E69D: 8D 62 06 sta	$0662
E6A0: E8       inx			; X=1
E6A1: 86 17    stx	$0017		; store 1 in	$0017
E6A3: 20 CE EE jsr	$eece
E6A6: 20 AD E6 jsr	$e6ad
E6A9: 58       cli
E6AA: 4C 45 9A jmp continue_startup_9a45

E6AD: A0 00    ldy #$00
E6AF: B9 79 09 lda	$0979, y
E6B2: C9 30    cmp #$30
E6B4: 90 43    bcc	$e6f9
E6B6: C9 3A    cmp #$3a
E6B8: B0 3F    bcs	$e6f9
E6BA: C8       iny
E6BB: C0 24    cpy #$24
E6BD: 90 F0    bcc	$e6af
E6BF: A0 00    ldy #$00
E6C1: B9 79 09 lda	$0979, y
E6C4: C9 30    cmp #$30
E6C6: D0 0E    bne	$e6d6
E6C8: B9 7A 09 lda	$097a, y
E6CB: C9 30    cmp #$30
E6CD: D0 07    bne	$e6d6
E6CF: B9 7B 09 lda	$097b, y
E6D2: C9 37    cmp #$37
E6D4: 90 23    bcc	$e6f9
E6D6: 98       tya
E6D7: 18       clc
E6D8: 69 06    adc #$06
E6DA: A8       tay
E6DB: C0 24    cpy #$24
E6DD: 90 E2    bcc	$e6c1
E6DF: A0 00    ldy #$00
E6E1: B9 D9 09 lda	$09d9, y
E6E4: C9 20    cmp #$20
E6E6: F0 08    beq	$e6f0
E6E8: C9 41    cmp #$41
E6EA: 90 0D    bcc	$e6f9
E6EC: C9 5B    cmp #$5b
E6EE: B0 09    bcs	$e6f9
E6F0: C8       iny
E6F1: C0 12    cpy #$12
E6F3: 90 EC    bcc	$e6e1
E6F5: A0 24    ldy #$24
E6F7: D0 07    bne	$e700
E6F9: A9 01    lda #$01
E6FB: 20 D4 F1 jsr	$f1d4
E6FE: A0 00    ldy #$00
E700: 84 1D    sty	$001d
E702: A6 1D    ldx	$001d
E704: A9 03    lda #$03
E706: 85 1B    sta	$001b
E708: B9 FA F2 lda	$f2fa, y
E70B: 4A       lsr a
E70C: 4A       lsr a
E70D: 4A       lsr a
E70E: 4A       lsr a
E70F: 09 30    ora #$30
E711: 9D 79 09 sta	$0979, x
E714: E8       inx
E715: B9 FA F2 lda	$f2fa, y
E718: 29 0F    and #$0f
E71A: 09 30    ora #$30
E71C: 9D 79 09 sta	$0979, x
E71F: E8       inx
E720: C8       iny
E721: C6 1B    dec	$001b
E723: D0 E3    bne	$e708
E725: A5 1D    lda	$001d
E727: 4A       lsr a
E728: AA       tax
E729: B9 FA F2 lda	$f2fa, y
E72C: 9D D9 09 sta	$09d9, x
E72F: C8       iny
E730: E8       inx
E731: B9 FA F2 lda	$f2fa, y
E734: 9D D9 09 sta	$09d9, x
E737: C8       iny
E738: E8       inx
E739: B9 FA F2 lda	$f2fa, y
E73C: 9D D9 09 sta	$09d9, x
E73F: C8       iny
E740: E8       inx
E741: C0 60    cpy #$60
E743: 90 BB    bcc	$e700
E745: A9 80    lda #$80
E747: 8D 63 06 sta	$0663
E74A: 8D 64 06 sta	$0664
E74D: 60       rts

E77E: 86 1B    stx $1b                                             
E780: 8A       txa
E781: 0A       asl a
E782: 0A       asl a
E783: A8       tay
E784: B9 5B 06 lda	$065b, y
E787: 19 5C 06 ora	$065c, y
E78A: 19 5D 06 ora	$065d, y
E78D: F0 04    beq	$e793
E78F: C9 20    cmp #$20
E791: D0 30    bne	$e7c3
E793: AD 0A 28 lda	$280a
E796: 29 3C    and #$3c
E798: AA       tax
E799: 08       php
E79A: 78       sei
; switch to bank 1
E79B: AD 00 60 lda bank_switch_start_6000
E79E: AD 4F 75 lda	$754f
E7A1: AD B0 60 lda	$60b0
E7A4: AD 40 75 lda	$7540
E7A7: AD 42 75 lda	$7542
E7AA: AD 54 75 lda	$7554
E7AD: AD A0 60 lda	$60a0
E7B0: 28       plp
E7B1: BD 5C 76 lda	$765c, x
E7B4: 99 5B 06 sta	$065b, y
E7B7: BD 5D 76 lda	$765d, x
E7BA: 99 5C 06 sta	$065c, y
E7BD: BD 5E 76 lda	$765e, x
E7C0: 99 5D 06 sta	$065d, y
E7C3: A6 1B    ldx	$001b
E7C5: A9 01    lda #$01
E7C7: 9D 65 06 sta	$0665, x
E7CA: A9 00    lda #$00
E7CC: 9D 67 06 sta	$0667, x
E7CF: 9D 69 06 sta	$0669, x
E7D2: A9 50    lda #$50
E7D4: 9D 6B 06 sta	$066b, x
E7D7: 8A       txa
E7D8: 18       clc
E7D9: 69 52    adc #$52
E7DB: 20 70 D6 jsr	$d670
E7DE: A9 0D    lda #$0d
E7E0: 20 59 E6 jsr	$e659
E7E3: 60       rts
E7E4: 86 1B    stx	$001b
E7E6: BD 6B 06 lda	$066b, x
E7E9: F0 0A    beq	$e7f5
E7EB: A4 12    ldy	$0012
E7ED: D0 06    bne	$e7f5
E7EF: DE 6B 06 dec	$066b, x
E7F2: 20 0A E9 jsr	$e90a
E7F5: BD 69 06 lda	$0669, x
E7F8: C9 03    cmp #$03
E7FA: B0 05    bcs	$e801
E7FC: BD 6B 06 lda	$066b, x
E7FF: D0 03    bne	$e804
E801: 4C 73 E9 jmp	$e973
E804: 8A       txa
E805: 0A       asl a
E806: 0A       asl a
E807: 7D 69 06 adc	$0669, x
E80A: A8       tay
E80B: B5 29    lda	$0029, x
E80D: 29 01    and #$01
E80F: F0 1C    beq	$e82d
E811: B9 5B 06 lda	$065b, y
E814: C9 3F    cmp #$3f
E816: F0 05    beq	$e81d
E818: FE 69 06 inc	$0669, x
E81B: D0 0D    bne	$e82a
E81D: BD 69 06 lda	$0669, x
E820: F0 08    beq	$e82a
E822: A9 20    lda #$20
E824: 99 5B 06 sta	$065b, y
E827: DE 69 06 dec	$0669, x
E82A: B8       clv
E82B: 50 4C    bvc	$e879
E82D: B5 29    lda	$0029, x
E82F: 29 0C    and #$0c
E831: F0 17    beq	$e84a
E833: A9 00    lda #$00
E835: 9D 67 06 sta	$0667, x
E838: B5 29    lda	$0029, x
E83A: 29 04    and #$04
E83C: F0 06    beq	$e844
E83E: 4C AC E8 jmp	$e8ac
E841: B8       clv
E842: 50 03    bvc	$e847
E844: 4C CF E8 jmp	$e8cf
E847: B8       clv
E848: 50 2F    bvc	$e879
E84A: B5 27    lda	$0027, x
E84C: 29 0E    and #$0e
E84E: F0 24    beq	$e874
E850: BD 67 06 lda	$0667, x
E853: 18       clc
E854: 69 01    adc #$01
E856: 9D 67 06 sta	$0667, x
E859: C9 0C    cmp #$0c
E85B: 90 14    bcc	$e871
E85D: A9 00    lda #$00
E85F: 9D 67 06 sta	$0667, x
E862: B5 27    lda	$0027, x
E864: 29 04    and #$04
E866: F0 06    beq	$e86e
E868: 4C AC E8 jmp	$e8ac
E86B: B8       clv
E86C: 50 03    bvc	$e871
E86E: 4C CF E8 jmp	$e8cf
E871: B8       clv
E872: 50 05    bvc	$e879
E874: A9 00    lda #$00
E876: 9D 67 06 sta	$0667, x
E879: BD 69 06 lda	$0669, x
E87C: 85 1C    sta	$001c
E87E: 8A       txa
E87F: 0A       asl a
E880: A8       tay
E881: B9 76 E7 lda	$e776, y
E884: 85 02    sta	$0002
E886: B9 77 E7 lda	$e777, y
E889: 85 03    sta	$0003
E88B: 98       tya
E88C: 0A       asl a
E88D: AA       tax
E88E: A0 00    ldy #$00
E890: BD 5B 06 lda	$065b, x
E893: 91 02    sta ($02), y
E895: E6 02    inc	$0002
E897: C4 1C    cpy	$001c
E899: D0 04    bne	$e89f
E89B: A9 80    lda #$80
E89D: D0 02    bne	$e8a1
E89F: A9 90    lda #$90
E8A1: 91 02    sta ($02), y
E8A3: E8       inx
E8A4: C8       iny
E8A5: C0 03    cpy #$03
E8A7: 90 E7    bcc	$e890
E8A9: A6 1B    ldx	$001b
E8AB: 60       rts
E8AC: B9 5B 06 lda	$065b, y
E8AF: C9 5A    cmp #$5a
E8B1: 90 04    bcc	$e8b7
E8B3: A9 3F    lda #$3f
E8B5: D0 13    bne	$e8ca
E8B7: C9 3F    cmp #$3f
E8B9: D0 04    bne	$e8bf
E8BB: A9 20    lda #$20
E8BD: D0 0B    bne	$e8ca
E8BF: C9 20    cmp #$20
E8C1: D0 04    bne	$e8c7
E8C3: A9 41    lda #$41
E8C5: D0 03    bne	$e8ca
E8C7: 18       clc
E8C8: 69 01    adc #$01
E8CA: 99 5B 06 sta	$065b, y
E8CD: D0 21    bne	$e8f0
E8CF: B9 5B 06 lda	$065b, y
E8D2: C9 41    cmp #$41
E8D4: D0 04    bne	$e8da
E8D6: A9 20    lda #$20
E8D8: D0 13    bne	$e8ed
E8DA: C9 20    cmp #$20
E8DC: D0 04    bne	$e8e2
E8DE: A9 3F    lda #$3f
E8E0: D0 0B    bne	$e8ed
E8E2: C9 3F    cmp #$3f
E8E4: D0 04    bne	$e8ea
E8E6: A9 5A    lda #$5a
E8E8: D0 03    bne	$e8ed
E8EA: 38       sec
E8EB: E9 01    sbc #$01
E8ED: 99 5B 06 sta	$065b, y
E8F0: A6 1B    ldx	$001b
E8F2: BD 65 06 lda	$0665, x
E8F5: F0 0E    beq	$e905
E8F7: A9 00    lda #$00
E8F9: 9D 65 06 sta	$0665, x
E8FC: BD 6B 06 lda	$066b, x
E8FF: 18       clc
E900: 69 A0    adc #$a0
E902: 9D 6B 06 sta	$066b, x
E905: A9 15    lda #$15
E907: 4C 59 E6 jmp	$e659
E90A: E0 00    cpx #$00
E90C: D0 04    bne	$e912
E90E: A9 C0    lda #$c0
E910: D0 02    bne	$e914
E912: A9 D0    lda #$d0
E914: 85 05    sta	$0005
E916: 8A       txa
E917: 0A       asl a
E918: A8       tay
E919: B9 7A E7 lda	$e77a, y
E91C: 85 02    sta	$0002
E91E: B9 7B E7 lda	$e77b, y
E921: 85 03    sta	$0003
E923: A0 00    ldy #$00
E925: BD 6B 06 lda	$066b, x
E928: 4A       lsr a
E929: 4A       lsr a
E92A: 4A       lsr a
E92B: C9 1E    cmp #$1e
E92D: 90 09    bcc	$e938
E92F: A9 33    lda #$33
E931: 91 02    sta ($02), y
E933: A9 1E    lda #$1e
E935: B8       clv
E936: 50 20    bvc	$e958
E938: C9 14    cmp #$14
E93A: 90 09    bcc	$e945
E93C: A9 32    lda #$32
E93E: 91 02    sta ($02), y
E940: A9 14    lda #$14
E942: B8       clv
E943: 50 13    bvc	$e958
E945: C9 0A    cmp #$0a
E947: 90 09    bcc	$e952
E949: A9 31    lda #$31
E94B: 91 02    sta ($02), y
E94D: A9 0A    lda #$0a
E94F: B8       clv
E950: 50 06    bvc	$e958
E952: A9 20    lda #$20
E954: 91 02    sta ($02), y
E956: A9 00    lda #$00
E958: 85 1F    sta	$001f
E95A: C8       iny
E95B: A5 05    lda	$0005
E95D: 91 02    sta ($02), y
E95F: C8       iny
E960: BD 6B 06 lda	$066b, x
E963: 4A       lsr a
E964: 4A       lsr a
E965: 4A       lsr a
E966: 38       sec
E967: E5 1F    sbc	$001f
E969: 09 30    ora #$30
E96B: 91 02    sta ($02), y
E96D: C8       iny
E96E: A5 05    lda	$0005
E970: 91 02    sta ($02), y
E972: 60       rts
E973: 20 D0 EA jsr	$ead0
E976: BD 63 06 lda	$0663, x
E979: 10 01    bpl	$e97c
E97B: 60       rts
E97C: A8       tay
E97D: 8A       txa
E97E: 0A       asl a
E97F: 0A       asl a
E980: AA       tax
E981: BD 5B 06 lda	$065b, x
E984: C9 3F    cmp #$3f
E986: D0 05    bne	$e98d
E988: A9 20    lda #$20
E98A: 9D 5B 06 sta	$065b, x
E98D: 99 D9 09 sta	$09d9, y
E990: 8D 03 08 sta	$0803
E993: BD 5C 06 lda	$065c, x
E996: C9 3F    cmp #$3f
E998: D0 05    bne	$e99f
E99A: A9 20    lda #$20
E99C: 9D 5C 06 sta	$065c, x
E99F: 99 DA 09 sta	$09da, y
E9A2: 8D 04 08 sta	$0804
E9A5: BD 5D 06 lda	$065d, x
E9A8: C9 3F    cmp #$3f
E9AA: D0 05    bne	$e9b1
E9AC: A9 20    lda #$20
E9AE: 9D 5D 06 sta	$065d, x
E9B1: 99 DB 09 sta	$09db, y
E9B4: 8D 05 08 sta	$0805
E9B7: 8A       txa
E9B8: 4A       lsr a
E9B9: 4A       lsr a
E9BA: A8       tay
E9BB: B9 63 06 lda	$0663, y
E9BE: 49 FF    eor #$ff
E9C0: 99 63 06 sta	$0663, y
E9C3: 49 FF    eor #$ff
E9C5: C9 24    cmp #$24
E9C7: B0 28    bcs	$e9f1
E9C9: 8A       txa
E9CA: 85 1B    sta	$001b
E9CC: 4A       lsr a
E9CD: 65 1B    adc	$001b
E9CF: AA       tax
E9D0: A0 00    ldy #$00
E9D2: BD 00 06 lda	$0600, x
E9D5: 0A       asl a
E9D6: 0A       asl a
E9D7: 0A       asl a
E9D8: 0A       asl a
E9D9: 85 1C    sta	$001c
E9DB: BD 01 06 lda	$0601, x
E9DE: 29 0F    and #$0f
E9E0: 05 1C    ora	$001c
E9E2: 99 00 08 sta	$0800, y
E9E5: C8       iny
E9E6: E8       inx
E9E7: E8       inx
E9E8: C0 03    cpy #$03
E9EA: 90 E6    bcc	$e9d2
E9EC: 20 A1 EF jsr	$efa1
E9EF: A6 1B    ldx	$001b
E9F1: 8A       txa
E9F2: 4A       lsr a
E9F3: 4A       lsr a
E9F4: AA       tax
E9F5: 49 01    eor #$01
E9F7: A8       tay
E9F8: B9 63 06 lda	$0663, y
E9FB: 10 17    bpl	$ea14
E9FD: C9 80    cmp #$80
E9FF: F0 13    beq	$ea14
EA01: DD 63 06 cmp	$0663, x
EA04: F0 02    beq	$ea08
EA06: B0 0C    bcs	$ea14
EA08: 38       sec
EA09: E9 03    sbc #$03
EA0B: C9 A5    cmp #$a5
EA0D: B0 02    bcs	$ea11
EA0F: A9 80    lda #$80
EA11: 99 63 06 sta	$0663, y
EA14: 60       rts
EA15: 24 0B    bit	$000b
EA17: 10 0B    bpl	$ea24
EA19: 8A       txa
EA1A: 49 01    eor #$01
EA1C: AA       tax
EA1D: 20 24 EA jsr	$ea24
EA20: 8A       txa
EA21: 49 01    eor #$01
EA23: AA       tax
EA24: 86 1B    stx	$001b
EA26: 8A       txa
EA27: 0A       asl a
EA28: 65 1B    adc	$001b
EA2A: 0A       asl a
EA2B: A8       tay
EA2C: AD 19 06 lda	$0619
EA2F: C9 03    cmp #$03
EA31: 90 0B    bcc	$ea3e
EA33: 98       tya
EA34: F0 08    beq	$ea3e
EA36: A6 1B    ldx	$001b
EA38: A9 80    lda #$80
EA3A: 9D 63 06 sta	$0663, x
EA3D: 60       rts
EA3E: A2 5A    ldx #$5a
EA40: B9 05 06 lda	$0605, y
EA43: DD 7E 09 cmp	$097e, x
EA46: B9 04 06 lda	$0604, y
EA49: FD 7D 09 sbc	$097d, x
EA4C: B9 03 06 lda	$0603, y
EA4F: FD 7C 09 sbc	$097c, x
EA52: B9 02 06 lda	$0602, y
EA55: FD 7B 09 sbc	$097b, x
EA58: B9 01 06 lda	$0601, y
EA5B: FD 7A 09 sbc	$097a, x
EA5E: B9 00 06 lda	$0600, y
EA61: FD 79 09 sbc	$0979, x
EA64: 90 06    bcc	$ea6c
EA66: 8A       txa
EA67: E9 06    sbc #$06
EA69: AA       tax
EA6A: B0 D4    bcs	$ea40
EA6C: 8A       txa
EA6D: 18       clc
EA6E: 69 06    adc #$06
EA70: C9 60    cmp #$60
EA72: F0 54    beq	$eac8
EA74: 85 1C    sta	$001c
EA76: A2 5A    ldx #$5a
EA78: E4 1C    cpx	$001c
EA7A: F0 20    beq	$ea9c
EA7C: CA       dex
EA7D: BD 79 09 lda	$0979, x
EA80: 9D 7F 09 sta	$097f, x
EA83: E4 1C    cpx	$001c
EA85: D0 F5    bne	$ea7c
EA87: A5 1C    lda	$001c
EA89: 4A       lsr a
EA8A: 85 1C    sta	$001c
EA8C: A2 2D    ldx #$2d
EA8E: CA       dex
EA8F: BD D9 09 lda	$09d9, x
EA92: 9D DC 09 sta	$09dc, x
EA95: E4 1C    cpx	$001c
EA97: D0 F5    bne	$ea8e
EA99: 8A       txa
EA9A: 0A       asl a
EA9B: AA       tax
EA9C: B9 05 06 lda	$0605, y
EA9F: 9D 7E 09 sta	$097e, x
EAA2: B9 04 06 lda	$0604, y
EAA5: 9D 7D 09 sta	$097d, x
EAA8: B9 03 06 lda	$0603, y
EAAB: 9D 7C 09 sta	$097c, x
EAAE: B9 02 06 lda	$0602, y
EAB1: 9D 7B 09 sta	$097b, x
EAB4: B9 01 06 lda	$0601, y
EAB7: 9D 7A 09 sta	$097a, x
EABA: B9 00 06 lda	$0600, y
EABD: 9D 79 09 sta	$0979, x
EAC0: 8A       txa
EAC1: 4A       lsr a
EAC2: A6 1B    ldx	$001b
EAC4: 9D 63 06 sta	$0663, x
EAC7: 60       rts
EAC8: A6 1B    ldx	$001b
EACA: A9 80    lda #$80
EACC: 9D 63 06 sta	$0663, x
EACF: 60       rts
EAD0: 86 1B    stx	$001b
EAD2: 8A       txa
EAD3: 0A       asl a
EAD4: 65 1B    adc	$001b
EAD6: 0A       asl a
EAD7: A8       tay
EAD8: A2 5A    ldx #$5a
EADA: B9 05 06 lda	$0605, y
EADD: DD 7E 09 cmp	$097e, x
EAE0: B9 04 06 lda	$0604, y
EAE3: FD 7D 09 sbc	$097d, x
EAE6: B9 03 06 lda	$0603, y
EAE9: FD 7C 09 sbc	$097c, x
EAEC: B9 02 06 lda	$0602, y
EAEF: FD 7B 09 sbc	$097b, x
EAF2: B9 01 06 lda	$0601, y
EAF5: FD 7A 09 sbc	$097a, x
EAF8: B9 00 06 lda	$0600, y
EAFB: FD 79 09 sbc	$0979, x
EAFE: 90 06    bcc	$eb06
EB00: 8A       txa
EB01: E9 06    sbc #$06
EB03: AA       tax
EB04: B0 D4    bcs	$eada
EB06: 8A       txa
EB07: 18       clc
EB08: 69 06    adc #$06
EB0A: C9 60    cmp #$60
EB0C: F0 07    beq	$eb15
EB0E: A6 1B    ldx	$001b
EB10: 4A       lsr a
EB11: 9D 63 06 sta	$0663, x
EB14: 60       rts
EB15: A6 1B    ldx	$001b
EB17: A9 80    lda #$80
EB19: 9D 63 06 sta	$0663, x
EB1C: 60       rts
EB1D: 20 28 EB jsr	$eb28
EB20: 20 8C EB jsr	$eb8c
EB23: 18       clc
EB24: 60       rts

EB28: C6 60    dec	$0060
EB2A: D0 2F    bne	$eb5b
EB2C: A9 FA    lda #$fa
EB2E: 85 60    sta	$0060
EB30: A5 08    lda	$0008
EB32: D0 0E    bne	$eb42
EB34: A2 00    ldx #$00
EB36: B5 77    lda	$0077, x
EB38: F0 03    beq	$eb3d
EB3A: 20 5C EB jsr	$eb5c
EB3D: E8       inx
EB3E: E0 02    cpx #$02
EB40: D0 F4    bne	$eb36
EB42: A2 00    ldx #$00
EB44: A5 08    lda	$0008
EB46: D0 10    bne	$eb58
EB48: A5 77    lda	$0077
EB4A: 05 78    ora	$0078
EB4C: F0 0A    beq	$eb58
EB4E: A2 04    ldx #$04
EB50: A5 77    lda	$0077
EB52: 25 78    and	$0078
EB54: F0 02    beq	$eb58
EB56: A2 08    ldx #$08
EB58: 20 6F EB jsr	$eb6f
EB5B: 60       rts
EB5C: 18       clc
EB5D: BD C7 06 lda	$06c7, x
EB60: 69 01    adc #$01
EB62: C9 3C    cmp #$3c
EB64: 90 05    bcc	$eb6b
EB66: FE C9 06 inc	$06c9, x
EB69: A9 00    lda #$00
EB6B: 9D C7 06 sta	$06c7, x
EB6E: 60       rts
EB6F: BD CE 06 lda	$06ce, x
EB72: 18       clc
EB73: 69 01    adc #$01
EB75: C9 3C    cmp #$3c
EB77: 90 0F    bcc	$eb88
EB79: FE CD 06 inc	$06cd, x
EB7C: D0 08    bne	$eb86
EB7E: FE CC 06 inc	$06cc, x
EB81: D0 03    bne	$eb86
EB83: FE CB 06 inc	$06cb, x
EB86: A9 00    lda #$00
EB88: 9D CE 06 sta	$06ce, x
EB8B: 60       rts
EB8C: AD 43 06 lda	$0643
EB8F: F0 05    beq	$eb96
EB91: CE 43 06 dec	$0643
EB94: D0 29    bne	$ebbf
EB96: 20 C0 EB jsr	$ebc0
EB99: B0 1F    bcs	$ebba
EB9B: A6 55    ldx	$0055
EB9D: E4 54    cpx	$0054
EB9F: F0 19    beq	$ebba
EBA1: BD 20 08 lda	$0820, x
EBA4: E8       inx
EBA5: 48       pha
EBA6: BD 20 08 lda	$0820, x
EBA9: E8       inx
EBAA: A8       tay
EBAB: 68       pla
EBAC: 8D 00 34 sta	$3400
EBAF: 99 E0 25 sta	$25e0, y
EBB2: E0 28    cpx #$28
EBB4: 90 02    bcc	$ebb8
EBB6: A2 00    ldx #$00
EBB8: 86 55    stx	$0055
EBBA: A9 04    lda #$04
EBBC: 8D 43 06 sta	$0643
EBBF: 60       rts
EBC0: A4 6E    ldy	$006e
EBC2: C0 FF    cpy #$ff
EBC4: F0 36    beq	$ebfc
EBC6: B9 FB 08 lda	$08fb, y
EBC9: D1 72    cmp ($72), y
EBCB: F0 1A    beq	$ebe7
EBCD: E6 6F    inc	$006f
EBCF: A5 6F    lda	$006f
EBD1: C9 0A    cmp #$0a
EBD3: 90 1D    bcc	$ebf2
EBD5: A6 70    ldx	$0070
EBD7: BD 84 08 lda	$0884, x
EBDA: 4A       lsr a
EBDB: 4A       lsr a
EBDC: 4A       lsr a
EBDD: 4A       lsr a
EBDE: 85 74    sta	$0074
EBE0: A9 FF    lda #$ff
EBE2: 9D 84 08 sta	$0884, x
EBE5: D0 38    bne	$ec1f
EBE7: 88       dey
EBE8: 84 6E    sty	$006e
EBEA: C0 FF    cpy #$ff
EBEC: F0 0E    beq	$ebfc
EBEE: A9 00    lda #$00
EBF0: 85 6F    sta	$006f
EBF2: B9 FB 08 lda	$08fb, y
EBF5: 8D 00 34 sta	$3400
EBF8: 91 72    sta ($72), y
EBFA: 38       sec
EBFB: 60       rts
EBFC: A6 6D    ldx	$006d
EBFE: E4 6C    cpx	$006c
EC00: D0 02    bne	$ec04
EC02: 18       clc
EC03: 60       rts
EC04: BD 0B 09 lda	$090b, x
EC07: 85 74    sta	$0074
EC09: 20 96 EC jsr	$ec96
EC0C: A9 0F    lda #$0f
EC0E: 85 6E    sta	$006e
EC10: A9 00    lda #$00
EC12: 85 6F    sta	$006f
EC14: A6 6D    ldx	$006d
EC16: E8       inx
EC17: E0 09    cpx #$09
EC19: 90 02    bcc	$ec1d
EC1B: A2 00    ldx #$00
EC1D: 86 6D    stx	$006d
EC1F: 20 3B EE jsr	$ee3b
EC22: E0 FF    cpx #$ff
EC24: F0 1F    beq	$ec45
EC26: A4 74    ldy	$0074
EC28: BD 84 08 lda	$0884, x
EC2B: 29 0F    and #$0f
EC2D: 85 69    sta	$0069
EC2F: B9 A2 08 lda	$08a2, y
EC32: 38       sec
EC33: E5 69    sbc	$0069
EC35: B0 07    bcs	$ec3e
EC37: B9 A2 08 lda	$08a2, y
EC3A: 09 10    ora #$10
EC3C: E5 69    sbc	$0069
EC3E: C9 06    cmp #$06
EC40: 90 03    bcc	$ec45
EC42: 4C 6E EC jmp	$ec6e
EC45: A4 71    ldy	$0071
EC47: B9 84 08 lda	$0884, y
EC4A: C9 FF    cmp #$ff
EC4C: F0 19    beq	$ec67
EC4E: 29 0F    and #$0f
EC50: 85 69    sta	$0069
EC52: B9 84 08 lda	$0884, y
EC55: 4A       lsr a
EC56: 4A       lsr a
EC57: 4A       lsr a
EC58: 4A       lsr a
EC59: AA       tax
EC5A: BD A2 08 lda	$08a2, x
EC5D: C5 69    cmp	$0069
EC5F: D0 06    bne	$ec67
EC61: 20 0E EE jsr	$ee0e
EC64: 4C 45 EC jmp	$ec45
EC67: 98       tya
EC68: 48       pha
EC69: 20 0E EE jsr	$ee0e
EC6C: 68       pla
EC6D: AA       tax
EC6E: AC 03 ED ldy	$ed03
EC71: B9 FB 08 lda	$08fb, y
EC74: 9D 84 08 sta	$0884, x
EC77: 8A       txa
EC78: 85 70    sta	$0070
EC7A: 20 23 EE jsr	$ee23
EC7D: A4 74    ldy	$0074
EC7F: B9 A2 08 lda	$08a2, y
EC82: 18       clc
EC83: 69 01    adc #$01
EC85: 29 0F    and #$0f
EC87: 99 A2 08 sta	$08a2, y
EC8A: A4 6E    ldy	$006e
EC8C: B9 FB 08 lda	$08fb, y
EC8F: 8D 00 34 sta	$3400
EC92: 91 72    sta ($72), y
EC94: 38       sec
EC95: 60       rts
EC96: 86 67    stx	$0067
EC98: A9 00    lda #$00
EC9A: 8D FB 08 sta	$08fb
EC9D: 8D FC 08 sta	$08fc
ECA0: 8D FD 08 sta	$08fd
ECA3: 8D FF 08 sta	$08ff
ECA6: 8D 03 09 sta	$0903
ECA9: A4 74    ldy	$0074
ECAB: 98       tya
ECAC: 0A       asl a
ECAD: 0A       asl a
ECAE: 0A       asl a
ECAF: 0A       asl a
ECB0: 85 68    sta	$0068
ECB2: B9 A2 08 lda	$08a2, y
ECB5: 18       clc
ECB6: 69 01    adc #$01
ECB8: 29 0F    and #$0f
ECBA: 05 68    ora	$0068
ECBC: AE 03 ED ldx	$ed03
ECBF: 9D FB 08 sta	$08fb, x
ECC2: 20 09 ED jsr	$ed09
ECC5: A5 67    lda	$0067
ECC7: 20 1B EE jsr	$ee1b
ECCA: A8       tay
ECCB: A2 00    ldx #$00
ECCD: BD F9 EC lda	$ecf9, x
ECD0: 86 67    stx	$0067
ECD2: AA       tax
ECD3: B9 14 09 lda	$0914, y
ECD6: 9D FB 08 sta	$08fb, x
ECD9: 20 09 ED jsr	$ed09
ECDC: A6 67    ldx	$0067
ECDE: C8       iny
ECDF: E8       inx
ECE0: E0 0A    cpx #$0a
ECE2: D0 E9    bne	$eccd
ECE4: AD FB 08 lda	$08fb
ECE7: 4D FC 08 eor	$08fc
ECEA: 4D FD 08 eor	$08fd
ECED: 4D FF 08 eor	$08ff
ECF0: 4D 03 09 eor	$0903
ECF3: 49 FF    eor #$ff
ECF5: 8D FB 08 sta	$08fb
ECF8: 60       rts

ED09: 48       pha
ED0A: 86 68    stx	$0068
ED0C: 46 68    lsr	$0068
ED0E: 90 08    bcc	$ed18
ED10: 68       pla
ED11: 48       pha
ED12: 4D FC 08 eor	$08fc
ED15: 8D FC 08 sta	$08fc
ED18: 46 68    lsr	$0068
ED1A: 90 08    bcc	$ed24
ED1C: 68       pla
ED1D: 48       pha
ED1E: 4D FD 08 eor	$08fd
ED21: 8D FD 08 sta	$08fd
ED24: 46 68    lsr	$0068
ED26: 90 08    bcc	$ed30
ED28: 68       pla
ED29: 48       pha
ED2A: 4D FF 08 eor	$08ff
ED2D: 8D FF 08 sta	$08ff
ED30: 46 68    lsr	$0068
ED32: 90 08    bcc	$ed3c
ED34: 68       pla
ED35: 48       pha
ED36: 4D 03 09 eor	$0903
ED39: 8D 03 09 sta	$0903
ED3C: 68       pla
ED3D: 4D FB 08 eor	$08fb
ED40: 8D FB 08 sta	$08fb
ED43: 60       rts
ED44: 8A       txa
ED45: 48       pha
ED46: 20 23 EE jsr	$ee23
ED49: A0 00    ldy #$00
ED4B: B1 72    lda ($72), y
ED4D: 99 FB 08 sta	$08fb, y
ED50: C8       iny
ED51: C0 10    cpy #$10
ED53: D0 F6    bne	$ed4b
ED55: AD FB 08 lda	$08fb
ED58: 49 FF    eor #$ff
ED5A: 4D FC 08 eor	$08fc
ED5D: 4D FD 08 eor	$08fd
ED60: 4D FF 08 eor	$08ff
ED63: 4D 03 09 eor	$0903
ED66: 8D FB 08 sta	$08fb
ED69: A0 00    ldy #$00
ED6B: B9 F9 EC lda	$ecf9, y
ED6E: AA       tax
ED6F: BD FB 08 lda	$08fb, x
ED72: 99 6E 09 sta	$096e, y
ED75: 20 09 ED jsr	$ed09
ED78: C8       iny
ED79: C0 0B    cpy #$0b
ED7B: D0 EE    bne	$ed6b
ED7D: AD FB 08 lda	$08fb
ED80: 0D FC 08 ora	$08fc
ED83: 0D FD 08 ora	$08fd
ED86: 0D FF 08 ora	$08ff
ED89: 0D 03 09 ora	$0903
ED8C: F0 5C    beq	$edea
ED8E: AD FB 08 lda	$08fb
ED91: F0 64    beq	$edf7
ED93: A9 01    lda #$01
ED95: 85 68    sta	$0068
ED97: A9 00    lda #$00
ED99: 85 67    sta	$0067
ED9B: AD 03 09 lda	$0903
ED9E: 25 68    and	$0068
EDA0: F0 06    beq	$eda8
EDA2: A9 08    lda #$08
EDA4: 05 67    ora	$0067
EDA6: 85 67    sta	$0067
EDA8: AD FF 08 lda	$08ff
EDAB: 25 68    and	$0068
EDAD: F0 06    beq	$edb5
EDAF: A9 04    lda #$04
EDB1: 05 67    ora	$0067
EDB3: 85 67    sta	$0067
EDB5: AD FD 08 lda	$08fd
EDB8: 25 68    and	$0068
EDBA: F0 06    beq	$edc2
EDBC: A9 02    lda #$02
EDBE: 05 67    ora	$0067
EDC0: 85 67    sta	$0067
EDC2: AD FC 08 lda	$08fc
EDC5: 25 68    and	$0068
EDC7: F0 06    beq	$edcf
EDC9: A9 01    lda #$01
EDCB: 05 67    ora	$0067
EDCD: 85 67    sta	$0067
EDCF: AD FB 08 lda	$08fb
EDD2: 25 68    and	$0068
EDD4: F0 10    beq	$ede6
EDD6: A6 67    ldx	$0067
EDD8: BD FE ED lda	$edfe, x
EDDB: 30 16    bmi	$edf3
EDDD: AA       tax
EDDE: BD 6E 09 lda	$096e, x
EDE1: 45 68    eor	$0068
EDE3: 9D 6E 09 sta	$096e, x
EDE6: 06 68    asl	$0068
EDE8: 90 AD    bcc	$ed97
EDEA: 68       pla
EDEB: AA       tax
EDEC: AD 78 09 lda	$0978
EDEF: 9D 84 08 sta	$0884, x
EDF2: 60       rts

EDF3: A5 67    lda $67                                             
EDF5: F0 EF    beq $ede6                                           
EDF7: A9 FF    lda #$ff                                            
EDF9: 8D 78 09 sta $0978                                           
EDFC: D0 EC    bne $edea   ; always branches!                                           

EE0E: E6 71    inc	$0071
EE10: A5 71    lda	$0071
EE12: C9 1E    cmp #$1e
EE14: 90 04    bcc	$ee1a
EE16: A9 00    lda #$00
EE18: 85 71    sta	$0071
EE1A: 60       rts
EE1B: 0A       asl a
EE1C: 85 6A    sta	$006a
EE1E: 0A       asl a
EE1F: 0A       asl a
EE20: 65 6A    adc	$006a
EE22: 60       rts
EE23: A2 00    ldx #$00
EE25: 86 6A    stx	$006a
EE27: 0A       asl a
EE28: 0A       asl a
EE29: 0A       asl a
EE2A: 26 6A    rol	$006a
EE2C: 0A       asl a
EE2D: 26 6A    rol	$006a
EE2F: 18       clc
EE30: 69 00    adc #$00
EE32: 85 72    sta	$0072
EE34: A5 6A    lda	$006a
EE36: 69 24    adc #$24
EE38: 85 73    sta	$0073
EE3A: 60       rts
EE3B: A2 1D    ldx #$1d
EE3D: A9 FF    lda #$ff
EE3F: 85 69    sta	$0069
EE41: BD 84 08 lda	$0884, x
EE44: C9 FF    cmp #$ff
EE46: F0 2E    beq	$ee76
EE48: 85 68    sta	$0068
EE4A: 4A       lsr a
EE4B: 4A       lsr a
EE4C: 4A       lsr a
EE4D: 4A       lsr a
EE4E: C5 74    cmp	$0074
EE50: D0 24    bne	$ee76
EE52: A4 69    ldy	$0069
EE54: C0 FF    cpy #$ff
EE56: F0 1C    beq	$ee74
EE58: A5 68    lda	$0068
EE5A: 29 0F    and #$0f
EE5C: 85 68    sta	$0068
EE5E: B9 84 08 lda	$0884, y
EE61: 29 0F    and #$0f
EE63: 38       sec
EE64: E5 68    sbc	$0068
EE66: B0 08    bcs	$ee70
EE68: 49 FF    eor #$ff
EE6A: C9 08    cmp #$08
EE6C: B0 06    bcs	$ee74
EE6E: 90 06    bcc	$ee76
EE70: C9 08    cmp #$08
EE72: B0 02    bcs	$ee76
EE74: 86 69    stx	$0069
EE76: CA       dex
EE77: 10 C8    bpl	$ee41
EE79: A6 69    ldx	$0069
EE7B: 60       rts
EE7C: 85 66    sta	$0066
EE7E: 8A       txa
EE7F: 48       pha
EE80: 98       tya
EE81: 48       pha
EE82: A6 6D    ldx	$006d
EE84: E4 6C    cpx	$006c
EE86: F0 16    beq	$ee9e
EE88: BD 0B 09 lda	$090b, x
EE8B: C5 66    cmp	$0066
EE8D: D0 04    bne	$ee93
EE8F: E4 6D    cpx	$006d
EE91: D0 1B    bne	$eeae
EE93: E8       inx
EE94: E0 09    cpx #$09
EE96: 90 02    bcc	$ee9a
EE98: A2 00    ldx #$00
EE9A: E4 6C    cpx	$006c
EE9C: D0 EA    bne	$ee88
EE9E: A5 66    lda	$0066
EEA0: 9D 0B 09 sta	$090b, x
EEA3: 8A       txa
EEA4: E8       inx
EEA5: E0 09    cpx #$09
EEA7: 90 02    bcc	$eeab
EEA9: A2 00    ldx #$00
EEAB: 86 6C    stx	$006c
EEAD: AA       tax
EEAE: A5 66    lda	$0066
EEB0: 20 1B EE jsr	$ee1b
EEB3: A8       tay
EEB4: 8A       txa
EEB5: 20 1B EE jsr	$ee1b
EEB8: AA       tax
EEB9: A9 09    lda #$09
EEBB: 85 66    sta	$0066
EEBD: B9 AA 08 lda	$08aa, y
EEC0: 9D 14 09 sta	$0914, x
EEC3: E8       inx
EEC4: C8       iny
EEC5: C6 66    dec	$0066
EEC7: 10 F4    bpl	$eebd
EEC9: 68       pla
EECA: A8       tay
EECB: 68       pla
EECC: AA       tax
EECD: 60       rts

EECE: A2 1F    ldx #$1f
EED0: BD DF 25 lda	$25df, x
EED3: 9D 47 08 sta	$0847, x
EED6: CA       dex
EED7: D0 F7    bne	$eed0
EED9: 20 44 F0 jsr	$f044
EEDC: A9 FF    lda #$ff
EEDE: 85 6E    sta	$006e
EEE0: A2 08    ldx #$08
EEE2: 9D A2 08 sta	$08a2, x
EEE5: CA       dex
EEE6: 10 FA    bpl	$eee2
EEE8: A2 4F    ldx #$4f
EEEA: A9 00    lda #$00
EEEC: 9D AA 08 sta	$08aa, x
EEEF: CA       dex
EEF0: 10 FA    bpl	$eeec
EEF2: AD 25 EB lda	$eb25
EEF5: 8D BC 08 sta	$08bc
EEF8: AD 26 EB lda	$eb26
EEFB: 8D BA 08 sta	$08ba
EEFE: AD 27 EB lda	$eb27
EF01: 8D BB 08 sta	$08bb
EF04: A9 00    lda #$00
EF06: AA       tax
EF07: 85 6C    sta	$006c
EF09: 85 6D    sta	$006d
EF0B: 85 6F    sta	$006f
EF0D: 85 71    sta	$0071
EF0F: 20 44 ED jsr	$ed44
EF12: C9 FF    cmp #$ff
EF14: F0 44    beq	$ef5a
EF16: 85 67    sta	$0067
EF18: 4A       lsr a
EF19: 4A       lsr a
EF1A: 4A       lsr a
EF1B: 4A       lsr a
EF1C: 85 68    sta	$0068
EF1E: A8       tay
EF1F: A5 67    lda	$0067
EF21: 29 0F    and #$0f
EF23: 85 67    sta	$0067
EF25: B9 A2 08 lda	$08a2, y
EF28: C9 FF    cmp #$ff
EF2A: F0 11    beq	$ef3d
EF2C: 38       sec
EF2D: E5 67    sbc	$0067
EF2F: B0 08    bcs	$ef39
EF31: 49 FF    eor #$ff
EF33: C9 08    cmp #$08
EF35: B0 23    bcs	$ef5a
EF37: 90 04    bcc	$ef3d
EF39: C9 08    cmp #$08
EF3B: 90 1D    bcc	$ef5a
EF3D: A5 67    lda	$0067
EF3F: 99 A2 08 sta	$08a2, y
EF42: 86 67    stx	$0067
EF44: A5 68    lda	$0068
EF46: 20 1B EE jsr	$ee1b
EF49: AA       tax
EF4A: A0 00    ldy #$00
EF4C: B9 6E 09 lda	$096e, y
EF4F: 9D AA 08 sta	$08aa, x
EF52: C8       iny
EF53: E8       inx
EF54: C0 0A    cpy #$0a
EF56: D0 F4    bne	$ef4c
EF58: A6 67    ldx	$0067
EF5A: E8       inx
EF5B: E0 1E    cpx #$1e
EF5D: D0 B0    bne	$ef0f
EF5F: A0 00    ldy #$00
EF61: A2 14    ldx #$14
EF63: BD AA 08 lda	$08aa, x
EF66: 99 CB 06 sta	$06cb, y
EF69: E8       inx
EF6A: C8       iny
EF6B: BD AA 08 lda	$08aa, x
EF6E: 99 CB 06 sta	$06cb, y
EF71: E8       inx
EF72: C8       iny
EF73: BD AA 08 lda	$08aa, x
EF76: 99 CB 06 sta	$06cb, y
EF79: E8       inx
EF7A: C8       iny
EF7B: A9 00    lda #$00
EF7D: 99 CB 06 sta	$06cb, y
EF80: C8       iny
EF81: C0 0C    cpy #$0c
EF83: 90 DE    bcc	$ef63
EF85: A9 00    lda #$00
EF87: 85 54    sta	$0054
EF89: 85 55    sta	$0055
EF8B: AD BA 08 lda	$08ba
EF8E: 10 10    bpl	$efa0
EF90: AD B8 08 lda	$08b8
EF93: 0D B9 08 ora	$08b9
EF96: D0 08    bne	$efa0
EF98: 20 77 F2 jsr	$f277
EF9B: A9 01    lda #$01
EF9D: 20 7C EE jsr	$ee7c
EFA0: 60       rts
EFA1: AD 03 08 lda	$0803
EFA4: 20 ED F0 jsr	$f0ed
EFA7: 8D 03 08 sta	$0803
EFAA: AD 04 08 lda	$0804
EFAD: 20 ED F0 jsr	$f0ed
EFB0: 0A       asl a
EFB1: 0A       asl a
EFB2: 0A       asl a
EFB3: 0A       asl a
EFB4: 2E 03 08 rol	$0803
EFB7: 0A       asl a
EFB8: 2E 03 08 rol	$0803
EFBB: 8D 04 08 sta	$0804
EFBE: AD 05 08 lda	$0805
EFC1: 20 ED F0 jsr	$f0ed
EFC4: 0D 04 08 ora	$0804
EFC7: 8D 04 08 sta	$0804
EFCA: A9 00    lda #$00
EFCC: 85 61    sta	$0061
EFCE: A0 19    ldy #$19
EFD0: 84 62    sty	$0062
EFD2: A6 61    ldx	$0061
EFD4: 20 10 F0 jsr	$f010
EFD7: B0 04    bcs	$efdd
EFD9: A5 62    lda	$0062
EFDB: 85 61    sta	$0061
EFDD: A5 62    lda	$0062
EFDF: 38       sec
EFE0: E9 05    sbc #$05
EFE2: A8       tay
EFE3: 10 EB    bpl	$efd0
EFE5: A6 61    ldx	$0061
EFE7: 20 2B F0 jsr	$f02b
EFEA: 90 23    bcc	$f00f
EFEC: AD B9 08 lda	$08b9
EFEF: D0 0F    bne	$f000
EFF1: A9 C8    lda #$c8
EFF3: CD B8 08 cmp	$08b8
EFF6: 90 08    bcc	$f000
EFF8: 8D B8 08 sta	$08b8
EFFB: A9 01    lda #$01
EFFD: 20 7C EE jsr	$ee7c
F000: A2 00    ldx #$00
F002: A4 61    ldy	$0061
F004: BD 00 08 lda	$0800, x
F007: 20 B8 F1 jsr	$f1b8
F00A: E8       inx
F00B: E0 05    cpx #$05
F00D: D0 F5    bne	$f004
F00F: 60       rts
F010: B9 48 08 lda	$0848, y
F013: DD 48 08 cmp	$0848, x
F016: D0 12    bne	$f02a
F018: E8       inx
F019: C8       iny
F01A: B9 48 08 lda	$0848, y
F01D: DD 48 08 cmp	$0848, x
F020: D0 08    bne	$f02a
F022: E8       inx
F023: C8       iny
F024: B9 48 08 lda	$0848, y
F027: DD 48 08 cmp	$0848, x
F02A: 60       rts
F02B: AD 00 08 lda	$0800
F02E: DD 48 08 cmp	$0848, x
F031: D0 10    bne	$f043
F033: E8       inx
F034: AD 01 08 lda	$0801
F037: DD 48 08 cmp	$0848, x
F03A: D0 07    bne	$f043
F03C: E8       inx
F03D: AD 02 08 lda	$0802
F040: DD 48 08 cmp	$0848, x
F043: 60       rts

F044: A0 1E    ldy #$1e
F046: B9 47 08 lda	$0847, y
F049: 99 65 08 sta	$0865, y
F04C: 88       dey
F04D: D0 F7    bne	$f046
F04F: A9 00    lda #$00
F051: 8D 69 06 sta	$0669
F054: A9 06    lda #$06
F056: 85 63    sta	$0063
F058: A9 00    lda #$00
F05A: 85 61    sta	$0061
F05C: 18       clc
F05D: 69 19    adc #$19
F05F: A8       tay
F060: A6 61    ldx	$0061
F062: 84 62    sty	$0062
F064: BD 66 08 lda	$0866, x
F067: D9 66 08 cmp	$0866, y
F06A: D0 12    bne	$f07e
F06C: E8       inx
F06D: C8       iny
F06E: BD 66 08 lda	$0866, x
F071: D9 66 08 cmp	$0866, y
F074: D0 08    bne	$f07e
F076: E8       inx
F077: C8       iny
F078: BD 66 08 lda	$0866, x
F07B: D9 66 08 cmp	$0866, y
F07E: B0 04    bcs	$f084
F080: A5 62    lda	$0062
F082: 85 61    sta	$0061
F084: A5 62    lda	$0062
F086: 38       sec
F087: E9 05    sbc #$05
F089: A8       tay
F08A: D0 D4    bne	$f060
F08C: A9 03    lda #$03
F08E: 85 64    sta	$0064
F090: A6 61    ldx	$0061
F092: AC 69 06 ldy	$0669
F095: BD 66 08 lda	$0866, x
F098: 4A       lsr a
F099: 4A       lsr a
F09A: 4A       lsr a
F09B: 4A       lsr a
F09C: 09 30    ora #$30
F09E: 99 79 09 sta	$0979, y
F0A1: C8       iny
F0A2: BD 66 08 lda	$0866, x
F0A5: 29 0F    and #$0f
F0A7: 09 30    ora #$30
F0A9: 99 79 09 sta	$0979, y
F0AC: A9 00    lda #$00
F0AE: 9D 66 08 sta	$0866, x
F0B1: C8       iny
F0B2: E8       inx
F0B3: C6 64    dec	$0064
F0B5: D0 DE    bne	$f095
F0B7: AD 69 06 lda	$0669
F0BA: 8C 69 06 sty	$0669
F0BD: 4A       lsr a
F0BE: A8       tay
F0BF: BD 67 08 lda	$0867, x
F0C2: 20 F9 F0 jsr	$f0f9
F0C5: 99 DB 09 sta	$09db, y
F0C8: BD 67 08 lda	$0867, x
F0CB: 5E 66 08 lsr	$0866, x
F0CE: 6A       ror a
F0CF: 5E 66 08 lsr	$0866, x
F0D2: 6A       ror a
F0D3: 4A       lsr a
F0D4: 4A       lsr a
F0D5: 4A       lsr a
F0D6: 20 F9 F0 jsr	$f0f9
F0D9: 99 DA 09 sta	$09da, y
F0DC: BD 66 08 lda	$0866, x
F0DF: 20 F9 F0 jsr	$f0f9
F0E2: 99 D9 09 sta	$09d9, y
F0E5: C6 63    dec	$0063
F0E7: F0 03    beq	$f0ec
F0E9: 4C 58 F0 jmp	$f058
F0EC: 60       rts
F0ED: C9 5F    cmp #$5f
F0EF: B0 05    bcs	$f0f6
F0F1: 38       sec
F0F2: E9 41    sbc #$41
F0F4: B0 02    bcs	$f0f8
F0F6: A9 1F    lda #$1f
F0F8: 60       rts
F0F9: 29 1F    and #$1f
F0FB: 18       clc
F0FC: 69 41    adc #$41
F0FE: C9 5F    cmp #$5f
F100: 90 02    bcc	$f104
F102: A9 20    lda #$20
F104: 60       rts
F105: B5 75    lda	$0075, x
F107: 0A       asl a
F108: 69 06    adc #$06
F10A: A8       tay
F10B: 20 4C F1 jsr	$f14c
F10E: 20 7D F1 jsr	$f17d
F111: A9 00    lda #$00
F113: 20 7C EE jsr	$ee7c
F116: A9 01    lda #$01
F118: 20 7C EE jsr	$ee7c
F11B: A0 00    ldy #$00
F11D: A2 14    ldx #$14
F11F: B9 CE 06 lda	$06ce, y
F122: C9 1E    cmp #$1e
F124: B9 CD 06 lda	$06cd, y
F127: 69 00    adc #$00
F129: 9D AC 08 sta	$08ac, x
F12C: B9 CC 06 lda	$06cc, y
F12F: 69 00    adc #$00
F131: 9D AB 08 sta	$08ab, x
F134: B9 CB 06 lda	$06cb, y
F137: 69 00    adc #$00
F139: 9D AA 08 sta	$08aa, x
F13C: E8       inx
F13D: E8       inx
F13E: E8       inx
F13F: C8       iny
F140: C8       iny
F141: C8       iny
F142: C8       iny
F143: C0 0C    cpy #$0c
F145: 90 D8    bcc	$f11f
F147: A9 02    lda #$02
F149: 4C 7C EE jmp	$ee7c
F14C: B9 AA 08 lda	$08aa, y
F14F: 18       clc
F150: 69 01    adc #$01
F152: 99 AA 08 sta	$08aa, y
F155: 90 08    bcc	$f15f
F157: B9 AB 08 lda	$08ab, y
F15A: 69 00    adc #$00
F15C: 99 AB 08 sta	$08ab, y
F15F: 60       rts
F160: 8A       txa
F161: 48       pha
F162: 84 65    sty	$0065
F164: A2 00    ldx #$00
F166: A9 0A    lda #$0a
F168: C5 65    cmp	$0065
F16A: F0 02    beq	$f16e
F16C: B0 08    bcs	$f176
F16E: 18       clc
F16F: 69 0A    adc #$0a
F171: E8       inx
F172: E0 07    cpx #$07
F174: D0 F2    bne	$f168
F176: 8A       txa
F177: 20 7C EE jsr	$ee7c
F17A: 68       pla
F17B: AA       tax
F17C: 60       rts
F17D: 8A       txa
F17E: A0 1E    ldy #$1e
F180: AA       tax
F181: 84 63    sty	$0063
F183: BD C9 06 lda	$06c9, x
F186: 85 62    sta	$0062
F188: BD C7 06 lda	$06c7, x
F18B: C9 1E    cmp #$1e
F18D: 90 07    bcc	$f196
F18F: 26 62    rol	$0062
F191: C9 2D    cmp #$2d
F193: B8       clv
F194: 50 04    bvc	$f19a
F196: 26 62    rol	$0062
F198: C9 0F    cmp #$0f
F19A: 26 62    rol	$0062
F19C: 06 62    asl	$0062
F19E: A5 62    lda	$0062
F1A0: C9 2E    cmp #$2e
F1A2: 90 0A    bcc	$f1ae
F1A4: C9 60    cmp #$60
F1A6: 90 04    bcc	$f1ac
F1A8: A9 30    lda #$30
F1AA: D0 02    bne	$f1ae
F1AC: A9 2E    lda #$2e
F1AE: 18       clc
F1AF: 65 63    adc	$0063
F1B1: A8       tay
F1B2: 20 4C F1 jsr	$f14c
F1B5: 4C 60 F1 jmp	$f160
F1B8: 86 66    stx	$0066
F1BA: 99 48 08 sta	$0848, y
F1BD: A6 54    ldx	$0054
F1BF: 9D 20 08 sta	$0820, x
F1C2: E8       inx
F1C3: 98       tya
F1C4: 9D 20 08 sta	$0820, x
F1C7: E8       inx
F1C8: E0 28    cpx #$28
F1CA: 90 02    bcc	$f1ce
F1CC: A2 00    ldx #$00
F1CE: 86 54    stx	$0054
F1D0: C8       iny
F1D1: A6 66    ldx	$0066
F1D3: 60       rts
F1D4: 48       pha
F1D5: 4A       lsr a
F1D6: 90 03    bcc	$f1db
F1D8: 20 77 F2 jsr	$f277
F1DB: 68       pla
F1DC: 48       pha
F1DD: 29 02    and #$02
F1DF: D0 03    bne	$f1e4
F1E1: 4C 54 F2 jmp	$f254
F1E4: A2 00    ldx #$00
F1E6: 8A       txa
F1E7: 9D AA 08 sta	$08aa, x
F1EA: 9D 14 09 sta	$0914, x
F1ED: E8       inx
F1EE: E0 0E    cpx #$0e
F1F0: 90 F5    bcc	$f1e7
F1F2: BD AA 08 lda	$08aa, x
F1F5: 9D 14 09 sta	$0914, x
F1F8: E8       inx
F1F9: E0 14    cpx #$14
F1FB: 90 F5    bcc	$f1f2
F1FD: A9 00    lda #$00
F1FF: 9D AA 08 sta	$08aa, x
F202: 9D 14 09 sta	$0914, x
F205: E8       inx
F206: E0 50    cpx #$50
F208: 90 F5    bcc	$f1ff
F20A: A2 00    ldx #$00
F20C: A9 FF    lda #$ff
F20E: 9D A2 08 sta	$08a2, x
F211: 86 74    stx	$0074
F213: 20 96 EC jsr	$ec96
F216: A5 74    lda	$0074
F218: 20 23 EE jsr	$ee23
F21B: A6 74    ldx	$0074
F21D: A0 00    ldy #$00
F21F: B9 FB 08 lda	$08fb, y
F222: 8D 00 34 sta	$3400
F225: 91 72    sta ($72), y
F227: 20 DD F2 jsr	$f2dd
F22A: C8       iny
F22B: C0 10    cpy #$10
F22D: 90 F0    bcc	$f21f
F22F: E8       inx
F230: E0 08    cpx #$08
F232: 90 D8    bcc	$f20c
F234: 8A       txa
F235: 48       pha
F236: 20 23 EE jsr	$ee23
F239: 68       pla
F23A: AA       tax
F23B: A0 00    ldy #$00
F23D: A9 FF    lda #$ff
F23F: 8D 00 34 sta	$3400
F242: 91 72    sta ($72), y
F244: 20 DD F2 jsr	$f2dd
F247: C8       iny
F248: C0 10    cpy #$10
F24A: 90 F1    bcc	$f23d
F24C: E8       inx
F24D: E0 1E    cpx #$1e
F24F: 90 E3    bcc	$f234
F251: 20 CE EE jsr	$eece
F254: 68       pla
F255: 48       pha
F256: 29 04    and #$04
F258: F0 12    beq	$f26c
F25A: AD 25 EB lda	$eb25
F25D: 8D BC 08 sta	$08bc
F260: AD 26 EB lda	$eb26
F263: 8D BA 08 sta	$08ba
F266: AD 27 EB lda	$eb27
F269: 8D BB 08 sta	$08bb
F26C: 68       pla
F26D: 29 05    and #$05
F26F: F0 05    beq	$f276
F271: A9 01    lda #$01
F273: 20 7C EE jsr	$ee7c
F276: 60       rts

F277: A9 07    lda #$07
F279: 8D B9 08 sta	$08b9
F27C: A9 D0    lda #$d0
F27E: 8D B8 08 sta	$08b8
F281: A2 00    ldx #$00
F283: A0 00    ldy #$00
F285: BD FA F2 lda	$f2fa, x
F288: E8       inx
F289: 20 CF F2 jsr	$f2cf
F28C: BD FA F2 lda	$f2fa, x
F28F: E8       inx
F290: 20 CF F2 jsr	$f2cf
F293: BD FA F2 lda	$f2fa, x
F296: E8       inx
F297: 20 CF F2 jsr	$f2cf
F29A: BD FA F2 lda	$f2fa, x
F29D: E8       inx
F29E: 20 ED F0 jsr	$f0ed
F2A1: 85 61    sta	$0061
F2A3: BD FA F2 lda	$f2fa, x
F2A6: E8       inx
F2A7: 20 ED F0 jsr	$f0ed
F2AA: 0A       asl a
F2AB: 0A       asl a
F2AC: 0A       asl a
F2AD: 0A       asl a
F2AE: 26 61    rol	$0061
F2B0: 0A       asl a
F2B1: 26 61    rol	$0061
F2B3: 85 62    sta	$0062
F2B5: BD FA F2 lda	$f2fa, x
F2B8: E8       inx
F2B9: 20 ED F0 jsr	$f0ed
F2BC: 05 62    ora	$0062
F2BE: 85 62    sta	$0062
F2C0: A5 61    lda	$0061
F2C2: 20 CF F2 jsr	$f2cf
F2C5: A5 62    lda	$0062
F2C7: 20 CF F2 jsr	$f2cf
F2CA: C0 1E    cpy #$1e
F2CC: D0 B7    bne	$f285
F2CE: 60       rts

F2CF: 8D 00 34 sta	$3400
F2D2: 99 E0 25 sta	$25e0, y
F2D5: 99 48 08 sta	$0848, y
F2D8: C8       iny
F2D9: 20 DD F2 jsr	$f2dd
F2DC: 60       rts
F2DD: 48       pha
F2DE: 8A       txa
F2DF: 48       pha
F2E0: A9 0F    lda #$0f
F2E2: 48       pha
F2E3: 38       sec
F2E4: A9 08    lda #$08
F2E6: A2 BB    ldx #$bb
F2E8: CA       dex
F2E9: D0 FD    bne	$f2e8
F2EB: E9 01    sbc #$01
F2ED: D0 F7    bne	$f2e6
F2EF: 68       pla
F2F0: 4A       lsr a
F2F1: D0 EF    bne	$f2e2
F2F3: 68       pla
F2F4: AA       tax
F2F5: 68       pla
F2F6: 8D 00 30 sta watchdog_3000
F2F9: 60       rts

F37E: A0 00    ldy #$00
F380: A2 01    ldx #$01
F382: AD 00 07 lda	$0700
F385: E0 01    cpx #$01
F387: F0 01    beq	$f38a
F389: 4A       lsr a
F38A: 4A       lsr a
F38B: B5 C5    lda	$00c5, x
F38D: 29 1F    and #$1f
F38F: 90 17    bcc	$f3a8
F391: F0 10    beq	$f3a3
F393: C9 1B    cmp #$1b
F395: B0 0A    bcs	$f3a1
F397: 48       pha
F398: A5 C9    lda	$00c9
F39A: 29 07    and #$07
F39C: C9 07    cmp #$07
F39E: 68       pla
F39F: 90 02    bcc	$f3a3
F3A1: E9 01    sbc #$01
F3A3: 95 C5    sta	$00c5, x
F3A5: 4C E1 F3 jmp	$f3e1
F3A8: C9 1B    cmp #$1b
F3AA: B0 09    bcs	$f3b5
F3AC: B5 C5    lda	$00c5, x
F3AE: 69 20    adc #$20
F3B0: 90 F1    bcc	$f3a3
F3B2: F0 01    beq	$f3b5
F3B4: 18       clc
F3B5: A9 1F    lda #$1f
F3B7: 95 C5    sta	$00c5, x
F3B9: B0 26    bcs	$f3e1
F3BB: C8       iny
F3BC: 8A       txa
F3BD: F0 0C    beq	$f3cb
F3BF: A5 C0    lda	$00c0
F3C1: 29 0C    and #$0c
F3C3: 4A       lsr a
F3C4: 4A       lsr a
F3C5: F0 0C    beq	$f3d3
F3C7: 69 02    adc #$02
F3C9: D0 08    bne	$f3d3
F3CB: A5 C0    lda	$00c0
F3CD: 29 10    and #$10
F3CF: F0 02    beq	$f3d3
F3D1: A9 01    lda #$01
F3D3: 38       sec
F3D4: 48       pha
F3D5: 65 C2    adc	$00c2
F3D7: 85 C2    sta	$00c2
F3D9: 68       pla
F3DA: 38       sec
F3DB: 65 C4    adc	$00c4
F3DD: 85 C4    sta	$00c4
F3DF: F6 C7    inc	$00c7, x
F3E1: CA       dex
F3E2: 10 9E    bpl	$f382
F3E4: 98       tya
F3E5: F0 41    beq	$f428
F3E7: A5 C0    lda	$00c0
F3E9: 4A       lsr a
F3EA: 4A       lsr a
F3EB: 4A       lsr a
F3EC: 4A       lsr a
F3ED: 4A       lsr a
F3EE: 49 07    eor #$07
F3F0: F0 32    beq	$f424
F3F2: A8       tay
F3F3: A5 C2    lda	$00c2
F3F5: 38       sec
; real code but makes no sense at F407
; reached when credit is inserted
F3F6: F9 07 F4 sbc	$f407, y
F3F9: 30 14    bmi	$f40f	; seems to always branch
F3FB: 85 C2    sta	$00c2
F3FD: E6 C3    inc	$00c3
F3FF: C0 04    cpy #$04
F401: D0 F2    bne	$f3f5
F403: E6 C3    inc	$00c3
F405: B0 EF    bcs	$f3f6	; or maybe always branches here
; if we reach here it's going to do WTF...
	.byte   7F 7F 03
	.byte   05 04   
	.byte   04 02   
	.byte   7F A5 C0
; then makes sense again
F40F: A5 C0    lda	$00c0                                             
F411: 29 03    and #$03
F413: 49 FF    eor #$ff
F415: 18       clc
F416: 65 C4    adc	$00c4
F418: B0 08    bcs	$f422
F41A: 65 C3    adc	$00c3
F41C: 30 0A    bmi	$f428
F41E: 85 C3    sta	$00c3
F420: A9 00    lda #$00
F422: E6 C1    inc	$00c1
F424: 85 C4    sta	$00c4
F426: D0 E7    bne	$f40f
F428: E6 C9    inc	$00c9
F42A: A5 C9    lda	$00c9
F42C: 4A       lsr a
F42D: B0 2D    bcs	$f45c
F42F: A5 C7    lda	$00c7
F431: 05 C8    ora	$00c8
F433: F0 27    beq	$f45c
F435: C9 10    cmp #$10
F437: 90 13    bcc	$f44c
F439: A2 01    ldx #$01
F43B: B5 C7    lda	$00c7, x
F43D: F0 08    beq	$f447
F43F: C9 10    cmp #$10
F441: 90 04    bcc	$f447
F443: 69 EF    adc #$ef
F445: 95 C7    sta	$00c7, x
F447: CA       dex
F448: 10 F1    bpl	$f43b
F44A: 30 10    bmi	$f45c
F44C: A2 01    ldx #$01
F44E: B5 C7    lda	$00c7, x
F450: F0 07    beq	$f459
F452: 18       clc
F453: 69 EF    adc #$ef
F455: 95 C7    sta	$00c7, x
F457: 30 03    bmi	$f45c
F459: CA       dex
F45A: 10 F2    bpl	$f44e
F45C: 60       rts

