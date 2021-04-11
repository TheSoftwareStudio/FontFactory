;===============================================================================
; Transfer mode commands
;===============================================================================

;
; Command handler : select next character in character set
;
selectnextchr
        LDA charsetposlo
        CMP #<charsetend
        BNE movenextchr

        LDA charsetposhi
        CMP #>charsetend
        BNE movenextchr

        LDA #<charsethome
        STA charsetposlo
        LDA #>charsethome
        STA charsetposhi

        LDX #$00
        LDA editingchar
        STA (charsetposlo,X)
        LDA #$00
        STA charmemposlo
        STA editingchar
        LDA #>charmembase
        STA charmemposhi
        RTS

movenextchr
        LDX #$00

loop13
        LDA charsetposlo

dataidx17
        CMP #$F6
        BNE jmp21

        LDA charsetposhi

dataidx18
        CMP #$06
        BNE jmp21

        LDA #$F6
        STA dataidx17+1
        LDA #$06
        STA dataidx18+1
        RTS

jmp21
        CLC
        LDA dataidx17+1
        ADC #$28
        STA dataidx17+1
        LDA dataidx18+1
        ADC #$00
        STA dataidx18+1
        INX
        CPX #$08
        BNE loop13

        LDX #$00
        LDA editingchar
        STA (charsetposlo,X)
        LDA #$F6
        STA dataidx17+1
        LDA #$06
        STA dataidx18+1
        CLC
        LDA charsetposlo
        ADC #$01
        STA charsetposlo
        LDA charsetposhi
        ADC #$00
        STA charsetposhi
        CLC
        LDA charmemposlo
        ADC #$08
        STA charmemposlo
        LDA charmemposhi
        ADC #$00
        STA charmemposhi
        INC editingchar
        RTS

;
; Command handler : select previous character in character set
;
Align
selectprevchr
        LDA charsetposlo ; at start of character map?
        CMP #<charsethome
        BNE jmp22

        LDA charsetposhi
        CMP #>charsethome
        BNE jmp22

        LDA #<charsetend        ; at beginning so wrap to end of characters $07DC on screen
        STA charsetposlo
        LDA #>charsetend
        STA charsetposhi
        LDX #$00
        LDA editingchar
        STA (charsetposlo,X)
        LDA #$FF                ; editing last char - $FF
        STA editingchar
        LDA #<charmemend
        STA charmemposlo
        LDA #>charmemend
        STA charmemposhi
        RTS

jmp22
        LDX #$00

loop14
        LDA charsetposlo        ; start of a row position instead?

dataidx19
        CMP #<charsethome
        BNE jmp23

        LDA charsetposhi

dataidx20
        CMP #>charsethome
        BNE jmp23

        LDA #<charsethome       ; reset position comparison to beginning of screen char map
        STA dataidx19+1
        LDA #>charsethome
        STA dataidx20+1
        RTS

jmp23
        CLC
        LDA dataidx19+1
        ADC #$28
        STA dataidx19+1
        LDA dataidx20+1
        ADC #$00
        STA dataidx20+1
        INX
        CPX #$08
        BNE loop14

        LDX #$00
        LDA editingchar
        STA (charsetposlo,X)
        LDA #<charsethome
        STA dataidx19+1
        LDA #>charsethome
        STA dataidx20+1
        SEC
        LDA charsetposlo
        SBC #$01
        STA charsetposlo
        LDA charsetposhi
        SBC #$00
        STA charsetposhi
        SEC
        LDA charmemposlo
        SBC #$08
        STA charmemposlo
        LDA charmemposhi
        SBC #$00
        STA charmemposhi
        DEC editingchar
        RTS

;
; Command handler : move up a line in character set
;
moveupaline
        LDX #$00

loop15
        LDA charsetposlo

dataidx21
        CMP #<charsethome
        BNE jmp24

        LDA charsetposhi
        CMP #>charsethome
        BNE jmp24

        LDA #<charsethome
        STA dataidx21+1
        RTS

jmp24
        INC dataidx21+1
        INX
        CPX #$26
        BNE loop15

        LDA #<charsethome
        STA dataidx21+1
        LDA editingchar
        LDX #$00
        STA (charsetposlo,X)
        SEC
        LDA charsetposlo
        SBC #$28
        STA charsetposlo
        LDA charsetposhi
        SBC #$00
        STA charsetposhi
        SEC
        LDA editingchar
        SBC #$26
        STA editingchar
        SEC
        LDA charmemposlo
        SBC #$30
        STA charmemposlo
        LDA charmemposhi
        SBC #$01
        STA charmemposhi
        RTS

;
; Command handler : move down a line in character set
;
Align
movedownaline
        LDX #$00

loop1
        LDA charsetposlo

dataidx24
        CMP #$B5
        BNE jmp20

        LDA charsetposhi
        CMP #$07
        BNE jmp20

        LDA #$B5
        STA dataidx24+1
        RTS

jmp20
        INC dataidx24+1
        INX
        CPX #$0A
        BNE loop1

        LDA #$B5
        STA dataidx24+1
        LDX #$00

loop2
        LDA charsetposlo

dataidx25
        CMP #$C1
        BNE jmp25

        LDA charsetposhi
        CMP #$07
        BNE jmp25

        LDA #$C1
        STA dataidx25+1
        RTS

jmp25
        INC dataidx25+1
        INX
        CPX #$26
        BNE loop2

        LDA #$C1
        STA dataidx25+1
        LDA editingchar
        LDX #$00
        STA (charsetposlo,X)
        CLC
        LDA charsetposlo
        ADC #$28
        STA charsetposlo
        LDA charsetposhi
        ADC #$00
        STA charsetposhi
        CLC
        LDA editingchar
        ADC #$26
        STA editingchar
        CLC
        LDA charmemposlo
        ADC #$30
        STA charmemposlo
        LDA charmemposhi
        ADC #$01
        STA charmemposhi
        RTS
