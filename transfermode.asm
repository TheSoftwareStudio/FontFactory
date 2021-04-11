;===============================================================================
; Toggle transfer mode on/off and process mode commands
;===============================================================================

trfrmodetoggle
        LDX #$00

showtrfrmsg
        LDA datatrfrmode,X
        STA messageareaaddr+2,X
        INX
        CPX #$0D
        BNE showtrfrmsg

        LDA charmemposlo
        STA tempsave1
        LDA charmemposhi
        STA tempsave2

trfrmodestart
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi
        LDX #$00

drawnextrow
        TXA
        PHA
        JSR draweditrow
        PLA
        TAX
        INX
        CPX #$08
        BNE drawnextrow

        SEC
        LDA charmemposlo
        SBC #$08
        STA charmemposlo
        LDA charmemposhi
        SBC #$00
        STA charmemposhi

waittrfrkeys
        JSR krnl_scnkey
        JSR krnl_getin
        CMP #$00
        BEQ waittrfrkeys

        CMP keysterling
        BEQ trfrmodeoff

        CMP keyplus
        BEQ trfrnextchr

        CMP keyminus
        BEQ trfrprevchr

        CMP keyf5
        BEQ trfrupaline

        CMP keyf7
        BEQ trfrdownaline

        JMP waittrfrkeys

trfrnextchr
        JSR selectnextchr
        JMP trfrmodestart

trfrprevchr
        JSR selectprevchr
        JMP trfrmodestart

trfrupaline
        JSR moveupaline
        JMP trfrmodestart

trfrdownaline
        JSR movedownaline
        JMP trfrmodestart

trfrmodeoff
        LDY #$00

looptrfrchar
        LDA (tempsave1),Y
        STA (charmemposlo),Y
        INY
        CPY #$08
        BNE looptrfrchar

        LDX #$00
        LDA keyspace

cleartrfrmsg
        STA messageareaaddr+2,X
        INX
        CPX #$0D
        BNE cleartrfrmsg
        RTS
