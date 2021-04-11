;===============================================================================
; Copy ROM char to RAM char position
;===============================================================================

copyromchar
        SEI
        LDA #<irqsvcroutine
        STA irqsvcloaddr
        LDA #>irqsvcroutine
        STA irqsvchiaddr

        LDA #$79
        STA irqstatusreg
        LDA #$F0
        STA irqctlreg
        LDA #$01
        STA timeractlreg
        CLI

        LDA #$00
        STA tempcharsave

copyromcharidx
        LDA #>upperchrrom
        STA tempsave6

        SEC
        LDA charmemposlo
        SBC #$00
        STA tempsave4
        LDA charmemposhi
        SBC #$30
        STA tempsave5

        CLC
        LDA tempcharsave
        ADC tempsave4
        STA tempcharsave
        LDA tempsave6
        ADC tempsave5
        STA tempsave6

        LDA #$7F
        STA irqctlstatreg
        LDA #$33
        STA procport

        LDY #$00
loop25
        LDA (tempcharsave),Y
        STA (charmemposlo),Y
        INY
        CPY #$08
        BNE loop25

        LDA #$37
        STA procport
        LDA #$81
        STA irqctlstatreg

        JSR showcharcursor
        RTS
