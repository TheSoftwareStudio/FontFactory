;===============================================================================
; Command Handler: toggle editing pixel on/off
;===============================================================================

checkfirebtn
        LDA joystickport2
        CMP #$6F
        BEQ pixelinvert
        RTS

pixelinvert
        LDX #$00
        LDA (editgridposlo,X)
        CMP keyfullblock        ; pixel on?
        BEQ clrpixel

        LDA keyfullblock        ; set pixel
        STA (editgridposlo,X)
        JMP showpixel

clrpixel
        LDA keyspace            ; clear pixel
        STA (editgridposlo,X)

showpixel
        NOP
        NOP
        NOP

storeditgrid
        LDY #$00                ; clear 8-bytes in-memory of the char ready for new values
        LDA #$00

clrmempixel
        STA (charmemposlo),Y
        INY
        CPY #$08
        BNE clrmempixel

        LDA #<editgridhome      ; start at top-left of display 8*8 edit grid
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00

stormempixel
        TXA
        PHA
        JSR setmempixel
        PLA
        TAX
        INX
        CPX #$08
        BNE stormempixel

        SEC                     ; set character memory pointer positions back to char start
        LDA charmemposlo
        SBC #$08
        STA charmemposlo
        LDA charmemposhi
        SBC #$00
        STA charmemposhi
        RTS

;
; Utility function : set pixel in character memory from display editing grid
;
Align
setmempixel
        LDY #$80

chkgridpixel
        LDX #$00
        LDA (workgridposlo,X)
        CMP keyfullblock        ; is the pixel set? representing a '1', ignore if clear/'0'
        BNE nextpixelpos

        TYA
        CLC
        ADC (charmemposlo,X)
        STA (charmemposlo,X)

nextpixelpos
        INC workgridposlo       ; move to next 'pixel' in display 8*8 edit grid
        BNE nextpixelcol
        INC workgridposhi

nextpixelcol
        TYA
        LSR
        TAY
        BNE chkgridpixel

        CLC
        LDA workgridposlo       ; move to next row in display 8*8 edit grid
        ADC #$20
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        
        INC charmemposlo        ; move to next character memory position
        BNE exitsetmempixel
        INC charmemposhi

exitsetmempixel
        RTS
