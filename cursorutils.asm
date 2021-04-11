;===============================================================================
; Position cursor at home on 8*8 editing grid
;===============================================================================

;
; Utility function : show editing cursor by inverting edit grid 'pixel' temporarily
;
showeditcursor
        LDX #$00
        LDA (editgridposlo,X)
        PHA                   ; save actual 'pixel' value in 8*8 edit grid

        CMP keyfullblock
        BEQ clreditcrsr       ; invert the pixel and pause to make cursor blink

        LDA keyfullblock
        STA (editgridposlo,X)
        JMP waiteditcrsr

clreditcrsr
        LDA keyspace
        STA (editgridposlo,X)

waiteditcrsr
        LDA #$10
        TAY

loopeditcrsry
        TAX

loopeditcrsrx
        DEX
        BNE loopeditcrsrx
        DEY
        BNE loopeditcrsry

        PLA                   ; restore actual 'pixel' value in 8*8 edit grid
        LDX #$00
        STA (editgridposlo,X)
        RTS

;
; Utility function : show character set cursor
;
showcharcursor
        SEI
        LDA #<irqcursor
        STA irqsvcloaddr
        LDA #>irqcursor
        STA irqsvchiaddr

        LDA #$01
        STA irqstatusreg
        STA irqctlreg
        LDA #$00
        STA timeractlreg
        LDA defaultscrnctl
        STA scrnctlreg
        LDA #$00
        STA rasterline
        CLI
        RTS

irqcursor
        LDA #$00

waitraster1
        CMP rasterline
        BNE waitraster1

        LDA #$15
        STA memsetupreg
        LDA #$82

waitraster2
        CMP rasterline
        BNE waitraster2

        LDA #$1D
        STA memsetupreg
        LDA #$FF

waitraster3
        CMP rasterline
        BNE waitraster3

        LDA #$01
        STA irqstatusreg
        JSR blinkcursor
        JMP irqsvcroutine

;
; Utility function : blink character set cursor (under interrupt)
;
blinkcursor
        DEC cursortimer
        BEQ makecursor
        RTS

makecursor
        LDA #cursordelay
        STA cursortimer
        LDX #$00
        LDA (charsetposlo,X)
        CMP editingchar
        BEQ hidechar

        LDA editingchar
        STA (charsetposlo,X)
        RTS

hidechar
        LDA keyspace
        STA (charsetposlo,X)
        RTS

;
; Utility function : show character grid cursor by inverting character grid 'pixel' temporarily
;
showgridcursor
        CLC
        LDA scrnlinepntlo
        ADC scrncolpntr
        STA savegridchar+1
        STA setgridcrsr+1
        STA setgridchar+1
        LDA scrnlinepnthi
        ADC #$00
        STA savegridchar+2
        STA setgridcrsr+2
        STA setgridchar+2

savegridchar
        LDA scrngridhome
        PHA
        LDA keyfullblock
setgridcrsr
        STA scrngridhome
        LDA #$0A
        TAY

waitcrsrony
        TAX

waitcrsronx
        DEX
        BNE waitcrsronx
        DEY
        BNE waitcrsrony

        PLA

setgridchar
        STA scrngridhome
        LDA #$0A
        TAY

waitcharony
        TAX

waitcharonx
        DEX
        BNE waitcharonx
        DEY
        BNE waitcharony
        RTS
