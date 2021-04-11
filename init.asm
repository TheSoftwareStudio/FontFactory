;===============================================================================
; Initialize program and variables
;===============================================================================

init
        LDA #<charmembase
        STA charmemposlo
        LDA #>charmembase
        STA charmemposhi

        LDA #<editgridhome
        STA workgridposlo
        STA editgridposlo
        LDA #>editgridhome
        STA workgridposhi
        STA editgridposhi

        LDA #<charsethome
        STA charsetposlo
        LDA #>charsethome
        STA charsetposhi

        LDA #cursordelay
        STA cursortimer

        LDA charstickdelay
        STA charstickcount
        LDA editstickdelay
        STA editstickcount

        LDA #$00
        STA editingchar

        LDA key8
        STA storagedevnum
        STA dataloaddevnum

        LDA charcrsrhomerow
        STA charcursorrow+1
        LDA charcrsrhomecol
        STA charcursorcol+1

        JSR clrlowchrrom
        RTS

;
; Utility function : clear $D800 - $DFFF
;
clrlowchrrom
        LDX #$00

nextchrpos
        LDA #$01
        STA lowerchrrom,X
        STA lowerchrrom+$100,X
        STA lowerchrrom+$200,X
        STA lowerchrrom+$300,X
        INX
        BNE nextchrpos
        RTS
