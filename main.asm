; ========================================
; Project   : Font Factory
; Target    : Commodore 64
; Comments  : Copyright (c) 1989 Craig Nottingham. All rights reserved.
; Author    : Craig Nottingham
; ========================================

Target          TGT_C64

IncAsm "kernel.asm"
IncAsm "consts.asm"

;===============================================================================
; CODE
;===============================================================================

;
; Program : main entry point
;
*=$1000
main
        LDA colorlightblue
        STA bordercolor
        LDA colorblue
        STA scrncolor
        LDA colorwhite
        STA cursorcolor

        JSR krnl_clrscrn
        JSR init

        LDX #$00

showmainscrn
        LDA datascrnmain,X
        STA displaybase,X
        LDA datascrnmain+$100,X
        STA displaybase+$100,X
        LDA datascrnmain+$200,X
        STA displaybase+$200,X
        LDA datascrnmain+$300,X
        STA displaybase+$300,X
        INX
        BNE showmainscrn

        LDA keycbmshift
        JSR krnl_chrout ; disable C=-Shift

scankeys
        JSR krnl_scnkey
        JSR krnl_getin
        CMP #$00
        BEQ scankeys

        CMP keyu
        BEQ useuppercase

        CMP keyl
        BEQ uselowercase

        JMP scankeys

useuppercase
        LDA #>upperchrrom       ; copy upper-case chars
        STA srcchrrom+2
        STA copyromcharidx+1    ; set correct case in copy ROM char to RAM char routine
        JMP cpyrom

uselowercase
        LDA #>lowerchrrom       ; copy lower-case chars
        STA srcchrrom+2
        STA copyromcharidx+1    ; set correct case in copy ROM char to RAM char routine

        LDX #$00

cpygrid1
        LDA datachargrid,X
        STA scrngridaddr,X
        INX
        BNE cpygrid1

        LDX #$00

cpygrid2
        LDA datachargrid+$100,X
        STA scrngridaddr+$100,X
        INX
        CPX #$40
        BNE cpygrid2

cpyrom
        LDA #$7F
        STA irqctlstatreg

        LDA #$33
        STA procport

cpychrrom                       ; copy character data from $d000 or $d800 into $3000-$3fff
        LDX #$00

srcchrrom
        LDA upperchrrom,X

destchrrom
        STA charmembase,X
        INX
        BNE srcchrrom

        INC srcchrrom+2
        INC destchrrom+2
        LDA srcchrrom+2
        CMP #>chrromend
        BEQ jmp29
        JMP cpychrrom

jmp29
        LDA #>upperchrrom       ; reset source to upper-case chars in ROM
        STA srcchrrom+2
        LDA #>charmembase       ; reset destination to char-set working area
        STA destchrrom+2
        LDA #$37
        STA procport
        LDA #$81
        STA irqctlstatreg
        
        LDA keyspace
        LDX #$00

loop19
        STA messageareaaddr,X
        INX
        CPX messagearealen
        BNE loop19
        JSR showcharcursor

mainloop
        LDX #$00

loopeditcharrow
        TXA
        PHA
        JSR draweditrow
        PLA
        TAX
        INX
        CPX #$08
        BNE loopeditcharrow

        SEC
        LDA charmemposlo
        SBC #$08
        STA charmemposlo
        LDA charmemposhi
        SBC #$00
        STA charmemposhi

mainprocess
        JSR checkeditstick
        JSR monitorfirebtn
        JSR printhexrows
        JSR showeditcursor

        JSR krnl_scnkey
        JSR krnl_getin
        CMP #$00
        BEQ mainprocess

        LDX #$00

findcmd
        CMP maincommands,X      ; find command index for key press
        BEQ callcmd
        INX
        CPX nummaincommands
        BNE findcmd

        JMP mainprocess

callcmd
        LDA cmdloaddrs,X        ; get lo/hi function pointer for corresponding command index
        LDY cmdhiaddrs,X
        STA cmdpointer+1
        STY cmdpointer+2

cmdpointer
        JSR homecursor          ; call function requested by user - address set above
                
        LDA #<editgridhome
        STA workgridposlo
        LDA #>editgridhome
        STA workgridposhi
        
        LDA editingchar         ; display editing char and hex value (below)
        STA editingcharcode
        STA editingcharprt

        DEC printhexbyte+1      ; TODO: change how this operates
        LDX editcharhexrow
        LDY editcharhexcol
        CLC
        JSR krnl_plot           ; position print cursor
        JSR printhexbyte        ; to print hex value of editing char
        INC printhexbyte+1      ; TODO: change how this operates

        JMP mainloop

IncAsm "init.asm"
IncAsm "exitprogram.asm"
IncAsm "togglepixel.asm"
IncAsm "fillchargridcmds.asm"
IncAsm "scrollcharcmds.asm"
IncAsm "selectcharcmds.asm"
IncAsm "clearchar.asm"
IncAsm "mirrorcharcmds.asm"
IncAsm "rotatechar.asm"
IncAsm "transfermode.asm"
IncAsm "showhelp.asm"
IncAsm "cursorutils.asm"
IncAsm "invertchar.asm"
IncAsm "copyromchar.asm"
IncAsm "togglefocus.asm"
IncAsm "swapmode.asm"
IncAsm "deviceutils.asm"
IncAsm "deviceinput.asm"
IncAsm "deviceoutput.asm"
IncAsm "draweditchar.asm"
IncAsm "printhex.asm"
IncAsm "joystick.asm"
IncAsm "movecursor.asm"

*=$4000
IncAsm "mainscrn.asm"
IncAsm "helpscrn.asm"
IncAsm "loadscrn.asm"
IncAsm "savescrn.asm"

*=$5400
IncAsm "strings.asm"

*=$5600
IncAsm "vars.asm"

*=$5800
IncAsm "cmdmaps.asm"
