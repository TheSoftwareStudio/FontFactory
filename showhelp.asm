;===============================================================================
; Show help command
;===============================================================================

showhelp
        LDA #$15
        STA memsetupreg
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

        LDX #$00

loopscrnhelp1
        LDA displaybase,X
        STA scrnsavebase,X
        LDA displaybase+$100,X
        STA scrnsavebase+$100,X
        LDA displaybase+$200,X
        STA scrnsavebase+$200,X
        LDA displaybase+$300,X
        STA scrnsavebase+$300,X
        LDA datascrnhelp1,X
        STA displaybase,X
        LDA datascrnhelp1+$100,X
        STA displaybase+$100,X
        LDA datascrnhelp1+$200,X
        STA displaybase+$200,X
        LDA datascrnhelp1+$300,X
        STA displaybase+$300,X
        INX
        BNE loopscrnhelp1

waitkeyhelp1
        JSR krnl_scnkey
        JSR krnl_getin
        CMP keyspace
        BNE waitkeyhelp1

        LDX #$00

loopscrnhelp2
        LDA datascrnhelp2,X
        STA displaybase,X
        LDA datascrnhelp2+$100,X
        STA displaybase+$100,X
        LDA datascrnhelp2+$200,X
        STA displaybase+$200,X
        LDA datascrnhelp2+$300,X
        STA displaybase+$300,X
        INX
        BNE loopscrnhelp2

waitkeyhelp2
        JSR krnl_scnkey
        JSR krnl_getin
        CMP keyspace
        BNE waitkeyhelp2

        LDX #$00

loopshowscrn
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
        BNE loopshowscrn

        JSR showcharcursor
        RTS
