;===============================================================================
; Save character set to an output device
;===============================================================================

Align
savetodevice
        SEI
        LDA #<irqsvcroutine
        STA irqsvcloaddr
        LDA #>irqsvcroutine
        STA irqsvchiaddr

        LDA #$79
        STA irqstatusreg
        LDA #$F0
        STA irqctlreg
        LDA defaultscrnctl
        STA scrnctlreg
        LDA #$01
        STA timeractlreg
        CLI

        LDA #$15
        STA memsetupreg

        LDX #$00

savescrnforsave
        LDA displaybase,X
        STA scrnsavebase,X
        LDA displaybase+$100,X
        STA scrnsavebase+$100,X
        LDA displaybase+$200,X
        STA scrnsavebase+$200,X
        LDA displaybase+$300,X
        STA scrnsavebase+$300,X
        INX
        BNE savescrnforsave

showsavescrn
        LDX #$00

loopsavescrn
        LDA datascrnsave,X
        STA displaybase,X
        LDA datascrnsave+$100,X
        STA displaybase+$100,X
        LDA datascrnsave+$200,X
        STA displaybase+$200,X
        LDA datascrnsave+$300,X
        STA displaybase+$300,X
        INX
        BNE loopsavescrn

        LDA storagedevnum
        STA datasavedevnum

waitsavekeys
        JSR krnl_scnkey
        JSR krnl_getin
        CMP #$00
        BEQ waitsavekeys

        CMP keys
        BEQ dosave

        CMP keyt
        BEQ dosavedevstatus

        CMP keyd
        BEQ donextsavedev

        CMP keyasterisk
        BEQ dosavedevdir

        CMP keyq
        BEQ savedevend

        JMP waitsavekeys

dosave
        JSR savetofile
        JMP showsavescrn

dosavedevstatus
        JSR showdevstatus
        JMP showsavescrn

donextsavedev
        JSR nextsavedevnum
        JMP showsavescrn

dosavedevdir
        JSR showdevdir
        JMP showsavescrn

savedevend
        LDX #$00

restorefromsave
        LDA scrnsavebase,X
        STA displaybase,X
        LDA scrnsavebase+$100,X
        STA displaybase+$100,X
        LDA scrnsavebase+$200,X
        STA displaybase+$200,X
        LDA scrnsavebase+$300,X
        STA displaybase+$300,X
        LDA #$00
        STA scrnsavebase,X
        STA scrnsavebase+$100,X
        STA scrnsavebase+$200,X
        STA scrnsavebase+$300,X
        INX
        BNE restorefromsave

        JSR showcharcursor
        RTS

;
; Utility function : cycle save device number between 1, 8, and 9
;
nextsavedevnum
        LDA datasavedevnum
        CMP key1
        BNE tstsavedevnum8

        LDA key8
        STA storagedevnum
        STA datasavedevnum
        RTS

tstsavedevnum8
        CMP key8
        BNE setsavedevnum1

        LDA key9
        STA datasavedevnum
        STA storagedevnum
        RTS

setsavedevnum1
        LDA key1
        STA storagedevnum
        STA datasavedevnum
        RTS

;
; Utility function : save character set to file on device
;
savetofile
        LDX #$00

storsavevars                    ; save program variables ($A8 - $BD)
        LDA charmemposlo,X
        STA varssavearea,X
        INX
        CPX #$16
        BNE storsavevars

        LDX #$16
        LDY #$00
        CLC
        JSR krnl_plot

        LDX #$00

prtsavename                     ; print "FILENAME : "
        LDA datafilename,X
        JSR krnl_chrout
        INX
        CPX #$0B
        BNE prtsavename

        LDY #$00

savenamechar
        JSR krnl_chrin
        CMP keyreturn
        BEQ savebyname

        STA filenameinput,Y
        INY
        CPY #$15
        BNE savenamechar

savebyname
        LDA keyreturn
        JSR krnl_chrout
        STY chrinlen

        SEC
        LDA storagedevnum
        SBC #$30
        STA devicenum

        LDA chrinlen
        STA filenamlen
        LDA #<filenameinput
        STA filenamelo
        LDA #>filenameinput
        STA filenamehi

        LDA #<charmembase
        STA devicestartlo
        LDA #>charmembase
        STA devicestarthi
        LDA #<charmembase
        STA deviceendlo

        LDA #>charmembase+$10
        STA deviceendhi
        LDA #$00
        STA filesecaddr

        JSR krnl_gosave

        JSR restoreprgvars
        RTS
