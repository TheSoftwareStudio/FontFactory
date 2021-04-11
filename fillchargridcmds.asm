;===============================================================================
; Command Handler: fill 20*6 character grid with space or same character
;===============================================================================

cleargrid206
        LDA keyspace
        JMP cpychargrid206

fillgrid206
        LDA editingchar

cpychargrid206
        LDX #$00

nextgridpos
        STA scrngridhome,X
        STA scrngridhome+$28,X
        STA scrngridhome+$50,X
        STA scrngridhome+$78,X
        STA scrngridhome+$A0,X
        STA scrngridhome+$C8,X
        INX
        CPX #$14
        BNE nextgridpos
        RTS
