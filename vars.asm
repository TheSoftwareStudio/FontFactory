;===============================================================================
; PROGRAM VARIABLES
;===============================================================================

cursortimer
        BYTE cursordelay

editingchar
        BYTE $00

hexchartoprint
        BYTE $00

editstickcount
        BYTE $03

joystickbits
        BYTE $7f

cursormoved
        BYTE $01

storagedevnum
        BYTE $38

chrinlen
        BYTE $0a

charstickcount
        BYTE $05

firebtncounter
        BYTE $02

charscrollsave
        BYTE $87

filenameinput
        BYTE $53,$41,$53,$20,$43,$48,$41,$52,$53,$21,$53,$00,$00,$00,$00,$00
        BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

workingchar
        BYTE $a0,$a0,$a0,$20,$20,$a0,$20,$a0,$a0,$a0,$20,$a0,$a0,$a0,$a0,$a0
        BYTE $a0,$20,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20
        BYTE $20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$a0,$20,$a0,$a0
        BYTE $a0,$a0,$20,$a0,$20,$20,$a0,$a0,$20,$a0,$20,$a0,$20,$20,$a0,$a0

editgridtoprowfwdlo
        BYTE <editgridhome
        BYTE <editgridhome+$1
        BYTE <editgridhome+$2
        BYTE <editgridhome+$3
        BYTE <editgridhome+$4
        BYTE <editgridhome+$5
        BYTE <editgridhome+$6
        BYTE <editgridhome+$7

editgridtoprowrevlo
        BYTE <editgridhome+$7
        BYTE <editgridhome+$6
        BYTE <editgridhome+$5
        BYTE <editgridhome+$4
        BYTE <editgridhome+$3
        BYTE <editgridhome+$2
        BYTE <editgridhome+$1
        BYTE <editgridhome

workingcharrowslo
        BYTE <workingchar
        BYTE <workingchar+$8
        BYTE <workingchar+$10
        BYTE <workingchar+$18
        BYTE <workingchar+$20
        BYTE <workingchar+$28
        BYTE <workingchar+$30
        BYTE <workingchar+$38

workingchartoprowrevlo
        BYTE <workingchar+$7
        BYTE <workingchar+$6
        BYTE <workingchar+$5
        BYTE <workingchar+$4
        BYTE <workingchar+$3
        BYTE <workingchar+$2
        BYTE <workingchar+$1
        BYTE <workingchar

datacharsetsave
        BYTE $00,$00,$7E,$66,$7E,$66,$66,$00,$00,$00,$7E,$06,$7E,$66,$7E,$00
        BYTE $00,$00,$7E,$00,$60,$70,$7E,$00,$00,$00,$7E,$06,$66,$66,$7E,$00
        BYTE $00,$00,$7E,$00,$7C,$60,$7E,$00,$00,$00,$7E,$00,$7C,$60,$60,$00
        BYTE $00,$00,$7E,$60,$6E,$66,$7E,$00,$00,$00,$66,$66,$7E,$66,$66,$00
        BYTE $00,$00,$18,$18,$18,$18,$18,$00,$00,$00,$7E,$06,$06,$66,$7E,$00
        BYTE $00,$00,$66,$66,$6C,$66,$66,$00,$00,$00,$60,$60,$60,$70,$7E,$00
        BYTE $00,$00,$FF,$DB,$DB,$DB,$DB,$00,$00,$00,$7E,$66,$66,$66,$66,$00
        BYTE $00,$00,$7E,$66,$66,$66,$7E,$00,$00,$00,$7E,$06,$7E,$60,$60,$00
        BYTE $00,$00,$7E,$66,$66,$6E,$7E,$00,$00,$00,$7E,$06,$7C,$66,$66,$00
        BYTE $00,$00,$7E,$60,$7E,$06,$7E,$00,$00,$00,$7E,$18,$18,$18,$18,$00
        BYTE $00,$00,$66,$66,$66,$66,$7E,$00,$00,$00,$66,$66,$66,$3C,$18,$00
        BYTE $00,$00,$DB,$DB,$DB,$DB,$FF,$00,$00,$00,$66,$66,$3C,$66,$66,$00
        BYTE $00,$00,$66,$66,$3C,$18,$18,$00,$00,$00,$7E,$0C,$18,$30,$7E,$00
        BYTE $00,$3C,$30,$30,$30,$30,$30,$3C,$00,$00,$00,$3C,$30,$3C,$00,$00
        BYTE $00,$3C,$0C,$0C,$0C,$0C,$0C,$3C,$00,$18,$3C,$7E,$18,$18,$18,$00
        BYTE $00,$10,$30,$7E,$7E,$30,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00

varssavearea
        BYTE $00,$30,$29,$04,$70,$02,$00,$00,$00,$00,$3c,$03,$00,$00,$00,$00
        BYTE $69,$05,$d1,$06,$3c,$d2,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
