;===============================================================================
; Scroll editing character commands
;===============================================================================

;
; Command handler : scroll editing character up
;
scrollcharup
        LDA charmemposlo
        STA dataidx3+1
        STA dataidx4+1
        STA dataidx5+1
        STA dataidx6+1
        LDA charmemposhi
        STA dataidx3+2
        STA dataidx4+2
        STA dataidx5+2
        STA dataidx6+2

dataidx3
        LDA charmembase
        STA charscrollsave
        INC dataidx4+1

        LDX #$00

dataidx4
        LDA charmembase+1,X

dataidx5
        STA charmembase,X
        INX
        CPX #$07
        BNE dataidx4

        CLC
        LDA dataidx6+1
        ADC #$07
        STA dataidx6+1
        LDA dataidx6+2
        ADC #$00
        STA dataidx6+2
        LDA charscrollsave

dataidx6
        STA charmembase+7
        RTS

;
; Command handler : scroll editing character down
;
scrollchardown
        LDA charmemposlo
        STA dataidx9+1
        STA dataidx10+1
        STA dataidx11+1
        STA dataidx12+1
        LDA charmemposhi
        STA dataidx9+2
        STA dataidx10+2
        STA dataidx11+2
        STA dataidx12+2
        CLC
        LDA dataidx9+1
        ADC #$07
        STA dataidx9+1
        LDA dataidx9+2
        ADC #$00
        STA dataidx9+2

dataidx9
        LDA charmembase+7
        STA charscrollsave
        INC dataidx11+1

        LDX #$06

dataidx10
        LDA charmembase,X

dataidx11
        STA charmembase+1,X
        DEX
        BPL dataidx10

        LDA charscrollsave

dataidx12
        STA charmembase
        RTS

;
; Command handler : scroll editing character left
;
Align
scrollcharleft
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00
        LDY #$00

loop16
        LDA (workgridposlo),Y
        STA workingchar,X
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INX
        CPX #$08
        BNE loop16

        LDY #$00

loop17
        LDX #$00

dataidx22
        LDA editgridhome+1,X

dataidx23
        STA editgridhome,X
        INX
        CPX #$07
        BNE dataidx22

        CLC
        LDA dataidx22+1
        ADC #$28
        STA dataidx22+1
        LDA dataidx22+2
        ADC #$00
        STA dataidx22+2
        CLC
        LDA dataidx23+1
        ADC #$28
        STA dataidx23+1
        LDA dataidx23+2
        ADC #$00
        STA dataidx23+2
        INY
        CPY #$08
        BNE loop17

        LDA #<editgridhome+7
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00
        LDY #$00

loop18
        LDA workingchar,X
        STA (workgridposlo),Y
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INX
        CPX #$08
        BNE loop18

        JSR storeditgrid

        LDA #<editgridhome+1
        STA dataidx22+1
        LDA #<editgridhome
        STA dataidx23+1
        LDA #>editgridhome
        STA dataidx22+2
        STA dataidx23+2
        RTS

;
; Command handler : scroll editing character right
;
Align
scrollcharright
        LDA #<editgridhome+7
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00
        LDY #$00

loop3
        LDA (workgridposlo),Y
        STA workingchar,X
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INX
        CPX #$08
        BNE loop3

        LDY #$00

loop4
        LDX #$06

dataidx26
        LDA editgridhome,X

dataidx27
        STA editgridhome+1,X
        DEX
        BPL dataidx26

        NOP
        NOP
        CLC
        LDA dataidx26+1
        ADC #$28
        STA dataidx26+1
        LDA dataidx26+2
        ADC #$00
        STA dataidx26+2
        CLC
        LDA dataidx27+1
        ADC #$28
        STA dataidx27+1
        LDA dataidx27+2
        ADC #$00
        STA dataidx27+2
        INY
        CPY #$08
        BNE loop4

        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00
        LDY #$00

loop5
        LDA workingchar,X
        STA (workgridposlo),Y
        CLC
        LDA workgridposlo
        ADC #$28
        STA workgridposlo
        LDA workgridposhi
        ADC #$00
        STA workgridposhi
        INX
        CPX #$08
        BNE loop5

        JSR storeditgrid

        LDA #<editgridhome
        STA dataidx26+1
        LDA #<editgridhome+1
        STA dataidx27+1
        LDA #>editgridhome
        STA dataidx26+2
        STA dataidx27+2
        RTS
