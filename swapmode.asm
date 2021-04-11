;===============================================================================
; Toggle swap mode on/off and process swapping position of two characters
;===============================================================================

swapcharposns
        LDX #$00

showswapmsg
        LDA dataswapmode,X
        STA messageareaaddr+2,X
        INX
        CPX #$09
        BNE showswapmsg

        LDA charmemposlo
        STA tempsave1
        LDA charmemposhi
        STA tempsave2

        LDY #$00

swapsavechars
        LDA (tempsave1),Y
        STA datacharsetsave,Y
        INY
        BNE swapsavechars

swapmodestart
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi

        LDX #$00

shownextrow
        TXA
        PHA
        JSR draweditrow
        PLA
        TAX
        INX
        CPX #$08
        BNE shownextrow

        SEC
        LDA charmemposlo
        SBC #$08
        STA charmemposlo
        LDA charmemposhi
        SBC #$00
        STA charmemposhi

waitswapkeys
        JSR krnl_scnkey
        JSR krnl_getin
        CMP #$00
        BEQ waitswapkeys

        CMP keys
        BEQ swapmodeoff

        CMP keyplus
        BEQ swapnextchr

        CMP keyminus
        BEQ swapprevchr

        CMP keyf5
        BEQ swapupaline

        CMP keyf7
        BEQ swapdownaline

        JMP waitswapkeys

swapnextchr
        JSR selectnextchr
        JMP swapmodestart

swapprevchr
        JSR selectprevchr
        JMP swapmodestart

swapupaline
        JSR moveupaline
        JMP swapmodestart

swapdownaline
        JSR movedownaline
        JMP swapmodestart

swapmodeoff
        LDY #$00

loopswapchar
        LDA (charmemposlo),Y
        STA (tempsave1),Y
        LDA datacharsetsave,Y
        STA (charmemposlo),Y
        INY
        CPY #$08
        BNE loopswapchar

        LDX #$00
        LDA keyspace

clearswapmsg
        STA messageareaaddr+2,X
        INX
        CPX #$09
        BNE clearswapmsg
        RTS
