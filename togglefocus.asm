;===============================================================================
; Toggle focus between 8*8 and 20*6 grids
;===============================================================================

Align
swapwindowmaps
        LDA key2                ; print 20*6
        STA gridmodeaddr
        LDA key0
        STA gridmodeaddr+1
        LDA keyasterisk
        STA gridmodeaddr+2
        LDA key6
        STA gridmodeaddr+3

charcursorrow
        LDX charcrsrhomerow     ; TODO: this is modified outside of routine

charcursorcol
        LDY charcrsrhomecol
        CLC
        JSR krnl_plot

waitswapcmds
        JSR krnl_scnkey
        JSR krnl_getin
        LDX #$00

scanswapcmds
        CMP swapcmds,X
        BEQ waitswapcmds

        INX
        CPX #$0A
        BNE scanswapcmds

        CMP keyreturn
        BEQ swapwindowoff

        JSR krnl_chrout

        JSR showgridcursor
        JSR checkcharstick
        JMP charcursorrow

swapwindowoff
        LDA charcrsrhomerow
        STA charcursorrow+1
        LDA charcrsrhomecol
        STA charcursorcol+1

        LDA keyspace            ; print 8*8
        STA gridmodeaddr
        LDA key8
        STA gridmodeaddr+1
        LDA keyasterisk
        STA gridmodeaddr+2
        LDA key8
        STA gridmodeaddr+3
        RTS
