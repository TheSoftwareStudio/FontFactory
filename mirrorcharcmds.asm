;===============================================================================
; Mirror editing character commands
;===============================================================================

;
; Command handler : mirror editing character up/down (horizontal)
;
Align
mirrorcharhorz
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00

loop22
        LDY #$00

loop21
        LDA (workgridposlo),Y

dataidx28
        STA workingchar,Y
        INY
        CPY #$08
        BNE loop21

        CLC
        LDA dataidx28+1
        ADC #$08
        STA dataidx28+1
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INX
        CPX #$08
        BNE loop22

        LDX #$00

loop24
        LDA editgridtoprowfwdlo,X
        STA workgridposlo
        LDA #$04
        STA workgridposhi
        LDA workingchartoprowrevlo,X
        STA dataidx29+1
        LDY #$00

loop23
        TYA
        PHA
        LDY #$00

dataidx29
        LDA workingchar+7
        STA (workgridposlo),Y
        PLA
        TAY
        CLC
        LDA dataidx29+1
        ADC #$08
        STA dataidx29+1
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INY
        CPY #$08
        BNE loop23

        INX
        CPX #$08
        BNE loop24

        LDA #<workingchar
        STA dataidx28+1
        LDA #<workingchar+7
        STA dataidx29+1

        JSR storeditgrid
        RTS

;
; Command handler : mirror editing character left/right (vertical)
;
mirrorcharvert
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00

nextmirrorchar
        LDY #$00

savemirrorvars
        LDA (workgridposlo),Y

dataidx30
        STA workingchar,Y
        INY
        CPY #$08
        BNE savemirrorvars

        CLC
        LDA dataidx30+1
        ADC #$08
        STA dataidx30+1
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INX
        CPX #$08
        BNE nextmirrorchar

        LDA #<workingchar
        STA dataidx30+1
        LDA #$41                ; line 8 of 8*8 editing grid
        STA workgridposlo
        LDA #$05                ; line 8 of 8*8 editing grid
        STA workgridposhi

        LDX #$00

nextmirrorcalc
        LDY #$00

loadmirrorvars
        LDA workingchar,Y
        STA (workgridposlo),Y
        INY
        CPY #$08
        BNE loadmirrorvars

        SEC
        LDA workgridposlo
        SBC #$28
        STA workgridposlo
        LDA workgridposhi
        SBC #$00
        STA workgridposhi
        CLC
        LDA loadmirrorvars+1
        ADC #$08
        STA loadmirrorvars+1
        INX
        CPX #$08
        BNE nextmirrorcalc

        LDA #<workingchar
        STA loadmirrorvars+1
        JSR storeditgrid
        RTS
