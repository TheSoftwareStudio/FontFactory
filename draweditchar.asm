;===============================================================================
; Draw pixels of character in editing grid
;===============================================================================

draweditrow
        LDX #$00
        LDA (charmemposlo,X)
        STA tempcharsave
        LDY #$80
        TYA

setpixelbit
        BIT tempcharsave
        BEQ setclrpixel

        LDA keyfullblock
        JMP setpixel

setclrpixel
        LDA keyspace

setpixel
        STA (workgridposlo,X)
        INC workgridposlo
        BNE nextbitpos
        INC workgridposhi

nextbitpos
        TYA
        LSR
        TAY
        BNE setpixelbit
        
        CLC
        LDA workgridposlo
        ADC #$20
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi

        INC charmemposlo
        BNE drawrowexit
        INC charmemposhi

drawrowexit
        RTS
