;===============================================================================
; Device utility functions
;===============================================================================

;
; Utility function : display device status for load/save operations
;
Align
showdevstatus
        LDX #$16
        LDY #$00
        CLC
        JSR krnl_plot

        LDX #$00

printstatus                     ; print "STATUS: "
        LDA datastatus,X
        JSR krnl_chrout
        INX
        CPX #$08
        BNE printstatus

        LDX #$00

storvars                        ; save program variables ($A8 - $BD)
        LDA charmemposlo,X
        STA varssavearea,X
        INX
        CPX #$16
        BNE storvars

        LDA #$00
        STA devicestatus
        LDA #$08
        STA devicenum
        JSR krnl_talk
        LDA #$6F
        STA filesecaddr
        JSR krnl_tksa

getdevstatus
        LDY devicestatus
        BNE devstatusdone

        JSR krnl_iecin
        JSR krnl_chrout
        CMP #$0D
        BNE getdevstatus

devstatusdone
        JSR krnl_untlk

waitkeyspc
        JSR krnl_scnkey
        JSR krnl_getin
        CMP keyspace
        BNE waitkeyspc

        LDX #$00                ; restore program variables ($A8 - $BD)

loop26
        LDA varssavearea,X
        STA charmemposlo,X
        INX
        CPX #$16
        BNE loop26

        RTS

;
; Utility function : display device (disc) directory
;
Align
showdevdir
        LDA storagedevnum
        CMP key1
        BNE begindevdir
        RTS

begindevdir
        LDX #$00

stordevdirvars                  ; save program variables ($A8 - $BD)
        LDA charmemposlo,X
        STA varssavearea,X
        INX
        CPX #$16
        BNE stordevdirvars

        JSR krnl_clrscrn

        LDA storagedevnum
        CMP key8
        BNE listseconddisc

        LDA key0
        STA tempsave2
        LDA #$02
        STA tempsave3
        JMP listdevdir

listseconddisc
        LDA key1
        STA tempsave2
        LDA #$02
        STA tempsave3
                
listdevdir
        LDA #$00
        STA devicestatus
        LDA #$24
        STA tempsave1
        LDA #$FB
        STA filenamelo
        LDA #$00
        STA filenamehi
        LDA tempsave3
        STA filenamlen
        LDA #$08
        STA devicenum
        LDA #$60
        STA filesecaddr

        JSR krnl_prtloading
        LDA devicenum
        JSR krnl_talk

        LDA filesecaddr
        JSR krnl_tksa
        LDY devicestatus

getdevdir
        BNE listdevdirend

        LDY #$06

nextdevdir
        STY tempsave1
        JSR krnl_iecin
        LDX tempsave2
        STA tempsave2
        LDY devicestatus
        BNE listdevdirend

        LDY tempsave1
        DEY
        BNE nextdevdir

        LDY tempsave2
        JSR krnl_linprt
        LDA keyspace
        JSR krnl_chrout

readdevdir
        JSR krnl_iecin
        LDX devicestatus
        BNE listdevdirend

        TAX
        BEQ enddevdiritem

        JSR krnl_chrout
        JMP readdevdir

enddevdiritem
        LDA keyreturn
        JSR krnl_chrout

        LDA keybdmatrix
        CMP #$3F
        BEQ listdevdirend
        LDY #$04
        BNE nextdevdir

listdevdirend
        JSR krnl_closefile

        LDX #$00

setdevdirvars                   ; restore program variables ($A8 - $BD)
        LDA varssavearea,X
        STA charmemposlo,X
        INX
        CPX #$16
        BNE setdevdirvars

waitdevdirspc
        JSR krnl_scnkey
        JSR krnl_getin
        CMP keyspace
        BNE waitdevdirspc

        RTS
