;===============================================================================
; Exit program (cold start)
;===============================================================================

exitprogram
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

        LDA #$01
        STA cartridgesig        ; prevent cartridge auto-start by spoiling CBM80 signature

        JMP krnl_coldstart
