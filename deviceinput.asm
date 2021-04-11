;===============================================================================
; Load character set from an input device
;===============================================================================

Align
loadfromdevice
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

savescrnforload
        LDA displaybase,X
        STA scrnsavebase,X
        LDA displaybase+$100,X
        STA scrnsavebase+$100,X
        LDA displaybase+$200,X
        STA scrnsavebase+$200,X
        LDA displaybase+$300,X
        STA scrnsavebase+$300,X
        INX
        BNE savescrnforload

showloadscrn
        LDX #$00

looploadscrn
        LDA datascrnload,X
        STA displaybase,X
        LDA datascrnload+$100,X
        STA displaybase+$100,X
        LDA datascrnload+$200,X
        STA displaybase+$200,X
        LDA datascrnload+$300,X
        STA displaybase+$300,X
        INX
        BNE looploadscrn

        LDA storagedevnum
        STA dataloaddevnum

waitloadkeys
        JSR krnl_scnkey
        JSR krnl_getin
        CMP #$00
        BEQ waitloadkeys

        CMP keyl
        BEQ doload

        CMP keys
        BEQ doloaddevstatus

        CMP keyd
        BEQ donextloaddev

        CMP keyasterisk
        BEQ doloaddevdir

        CMP keyq
        BEQ loaddevend

        JMP waitloadkeys

doload  
        JSR loadfromfile
        JMP showloadscrn

doloaddevstatus
        JSR showdevstatus
        JMP showloadscrn

donextloaddev
        JSR nextloaddevnum
        JMP showloadscrn

doloaddevdir
        JSR showdevdir
        JMP showloadscrn

loaddevend
        LDX #$00

restorefromload
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
        BNE restorefromload
        
        JSR showcharcursor
        RTS

;
; Utility function : cycle load device number between 1, 8, and 9
;
nextloaddevnum
        LDA dataloaddevnum
        CMP key1
        BNE tstloaddevnum8
        
        LDA key8
        STA storagedevnum
        STA dataloaddevnum
        RTS
                
tstloaddevnum8
        CMP key8
        BNE setloaddevnum1

        LDA key9
        STA dataloaddevnum
        STA storagedevnum
        RTS

setloaddevnum1
        LDA key1
        STA storagedevnum
        STA dataloaddevnum
        RTS

;
; Utility function : load character set file from device
;
loadfromfile
        LDX #$00

storloadvars                    ; save program variables ($A8 - $BD)
        LDA charmemposlo,X
        STA varssavearea,X
        INX
        CPX #$16
        BNE storloadvars

        LDX #$16
        LDY #$00
        CLC
        JSR krnl_plot

        LDX #$00

prtloadname                     ; print "FILENAME : "
        LDA datafilename,X
        JSR krnl_chrout
        INX
        CPX #$0B
        BNE prtloadname

        LDY #$00

loadnamechar
        JSR krnl_chrin
        CMP keyreturn
        BEQ loadbyname

        STA filenameinput,Y
        INY
        CPY #$15
        BNE loadnamechar

loadbyname
        LDA keyreturn
        JSR krnl_chrout
        STY chrinlen
        SEC
        LDA storagedevnum
        SBC #$30
        TXA
        LDA #$01
        LDY #$00
        JSR krnl_setlfs
        LDA chrinlen
        LDX #<filenameinput
        LDY #>filenameinput
        JSR krnl_setnam
        LDA #$00
        LDX #<charmembase
        LDY #>charmembase
        JSR krnl_load

restoreprgvars
        LDX #$00

setloadvars                     ; restore program variables ($A8 - $BD)
        LDA varssavearea,X
        STA charmemposlo,X
        INX
        CPX #$16
        BNE setloadvars

        JSR krnl_clall
        RTS
