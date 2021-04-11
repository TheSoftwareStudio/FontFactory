;===============================================================================
; Print hex values
;===============================================================================

;
; Utility function : print hex values for each row in 8*8 editing grid
;
printhexrows
        LDA editgridhexrow
        STA loadrownum+1

        LDY #$00

printhexrow
        LDX #$00
        LDA (charmemposlo),Y
        STA hexchartoprint
        TYA
        PHA
        TXA
        PHA

loadrownum
        LDX editgridhexrow ; line number - incremented
        LDY editgridhexcol ; column to right of 8*8 editing grid
        CLC
        JSR krnl_plot
        JSR printhexbyte
        PLA
        TAX
        PLA
        TAY
        INC loadrownum+1
        INY
        CPY #$08
        BNE printhexrow

        LDA editgridhexrow
        STA loadrownum+1
        RTS

;
; Utility function : print hex byte as 2-chars
;
printhexbyte
        LDY hexchartoprint
        TYA
        PHA
        JSR printhinibble
        PLA
        JSR printlonibble
        RTS

printhinibble
        CLC
        ROR
        ROR
        ROR
        ROR

printlonibble
        AND #$0F
        CLC
        ADC #$30         ; turn in to ASCII 0-9
        CMP #$3A
        BCC printhexchar ; print 0-9 else add 6 for A-F ASCII chars before priting
        ADC #$06

printhexchar
        JSR krnl_chrout
        RTS
