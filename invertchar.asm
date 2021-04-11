;===============================================================================
; Invert editing character pixels
;===============================================================================

invertchar
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00
loop20
        TXA
        PHA
        JSR invertpixel
        PLA
        TAX
        INX
        CPX #$08
        BNE loop20

        JSR storeditgrid
        RTS

invertpixel
        LDY #$00

tstgridpixel
        LDA (workgridposlo),Y
        CMP keyfullblock
        BEQ clrgridpixel
        
        LDA keyfullblock
        JMP nxtgridpixel

clrgridpixel
        LDA keyspace

nxtgridpixel
        STA (workgridposlo),Y
        INY
        CPY #$08
        BNE tstgridpixel
                
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        RTS
