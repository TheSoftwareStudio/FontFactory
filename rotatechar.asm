;===============================================================================
; Rotate editing character 90 degrees
;===============================================================================

Align
rotatechar90
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00

nextrotatechar
        LDY #$00

saverotatechar
        LDA (workgridposlo),Y

dataidx31
        STA workingchar,Y
        INY
        CPY #$08
        BNE saverotatechar

        CLC
        LDA dataidx31+1
        ADC #$08
        STA dataidx31+1

        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi

        INX
        CPX #$08
        BNE nextrotatechar

        LDA #<workingchar
        STA dataidx31+1

        LDX #$00

loadrotatechar
        LDA editgridtoprowrevlo,X
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi
        LDA workingcharrowslo,X
        STA dataidx32+1
        LDY #$00

nextrotatecalc
        TYA
        PHA

dataidx32
        LDA workingchar,Y
        LDY #$00
        STA (workgridposlo),Y
        PLA
        TAY
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INY
        CPY #$08
        BNE nextrotatecalc

        INX
        CPX #$08
        BNE loadrotatechar

        LDA #<workingchar
        STA dataidx32+1

        JSR storeditgrid
        RTS
