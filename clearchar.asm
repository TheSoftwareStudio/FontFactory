;===============================================================================
; Clear pixels of editing character
;===============================================================================

cleargrid88
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDY #$00
        LDA #$00

loopzerocol
        STA (charmemposlo),Y
        INY
        CPY #$08
        BNE loopzerocol

        LDX #$00

nextzerorow
        TXA
        PHA
        JSR clearcharrow
        PLA
        TAX
        INX
        CPX #$08
        BNE nextzerorow
        RTS

clearcharrow
        LDY #$00
        LDA keyspace

loopclrcol
        STA (workgridposlo),Y
        INY
        CPY #$08
        BNE loopclrcol

        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        RTS
