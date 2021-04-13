;===============================================================================
; Initialize functions
;===============================================================================

;
; Utility function : initialize program variables
;
; Input:
;       N/A
; Output:
;       N/A
; Uses:
;       A reg
;       X reg
;
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

        LDA #colorwhite
        JSR setscreencolor
        RTS

;
; Utility function : set screen colour ($D800 - $DFFF)
;
; Input:
;       A reg - color
; Output:
;       N/A
; Uses:
;       X reg
;
setscreencolor
        LDX #$00

setpagecolor
        STA lowerchrrom,X
        STA lowerchrrom+$100,X
        STA lowerchrrom+$200,X
        STA lowerchrrom+$300,X
        INX
        BNE setpagecolor
        RTS
