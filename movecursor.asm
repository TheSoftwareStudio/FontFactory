;===============================================================================
; Move editing grid cursor routines
;===============================================================================

;
; Command handler : set editing grid cursor to home position
;
homecursor
        LDA #<editgridhome
        STA editgridposlo
        LDA #>editgridhome
        STA editgridposhi
        RTS

;
; Utility function : move editing grid cursor up
;
movecrsrup
        LDX #$00
        LDA (editgridposlo,X)
        STA tempcharsave

loop9
        LDA editgridposlo       ; confirm not trying to move up if cursor on top line

dataidx7
        CMP #<editgridhome
        BNE jmp14

        LDA editgridposhi
        CMP #>editgridhome
        BNE jmp14

        LDA #<editgridhome
        STA dataidx7+1
        
        LDA #$00
        STA cursormoved
        RTS

jmp14
        INC dataidx7+1
        INX
        CPX #$08
        BNE loop9
        
        LDA tempcharsave
        LDX #$00
        STA (editgridposlo,X)
        SEC
        LDA editgridposlo
        SBC #$28
        STA editgridposlo
        LDA editgridposhi
        SBC #$00
        STA editgridposhi

        LDA #<editgridhome
        STA dataidx7+1

        LDA #$01
        STA cursormoved
        RTS

;
; Utility function : move editing grid cursor down
;
movecrsrdown
        LDX #$00
        LDA (editgridposlo,X)
        STA tempcharsave

loop10
        LDA editgridposlo

dataidx8
        CMP #$41
        BNE jmp15

        LDA editgridposhi
        CMP #$05
        BNE jmp15

        LDA #$41
        STA dataidx8+1

        LDA #$00
        STA cursormoved
        RTS

jmp15
        INC dataidx8+1
        INX
        CPX #$08
        BNE loop10
        
        LDA tempcharsave
        LDX #$00
        STA (editgridposlo,X)
        CLC
        LDA editgridposlo
        ADC #$28
        STA editgridposlo
        LDA editgridposhi
        ADC #$00
        STA editgridposhi
        LDX #$11
        LDA #$41
        STA dataidx8+1

        LDA #$01
        STA cursormoved
        RTS

;
; Utility function : move editing grid cursor left
;
movecrsrleft
        LDX #$00
        LDA (editgridposlo,X)
        STA tempcharsave

loop11
        LDA editgridposlo

dataidx13
        CMP #<editgridhome
        BNE jmp16

        LDA editgridposhi

dataidx14
        CMP #>editgridhome
        BNE jmp16

        LDA #<editgridhome
        STA dataidx13+1
        LDA #>editgridhome
        STA dataidx14+1

        LDA #$00
        STA cursormoved
        RTS

jmp16
        CLC
        LDA dataidx13+1
        ADC #$28
        STA dataidx13+1
        LDA dataidx14+1
        ADC #$00
        STA dataidx14+1
        INX
        CPX #$08
        BNE loop11

        LDA tempcharsave
        LDX #$00
        STA (editgridposlo,X)
        DEC editgridposlo
        BNE jmp17
        DEC editgridposhi

jmp17
        LDX #$9D

        LDA #$01
        STA cursormoved

        LDA #<editgridhome
        STA dataidx13+1
        LDA #>editgridhome
        STA dataidx14+1
        RTS

;
; Utility function : move editing grid cursor right
;
movecrsrright
        LDX #$00
        LDA (editgridposlo,X)
        STA tempcharsave

loop12
        LDA editgridposlo

dataidx15
        CMP #<editgridhome+$7
        BNE jmp18

        LDA editgridposhi

dataidx16
        CMP #>editgridhome
        BNE jmp18

        LDA #<editgridhome+$7
        STA dataidx15+1
        LDA #>editgridhome
        STA dataidx16+1

        LDA #$00
        STA cursormoved
        RTS

jmp18
        CLC
        LDA dataidx15+1
        ADC #$28
        STA dataidx15+1
        LDA dataidx16+1
        ADC #$00
        STA dataidx16+1
        INX
        CPX #$08
        BNE loop12

        LDA tempcharsave
        LDX #$00
        STA (editgridposlo,X)
        INC editgridposlo
        BNE jmp19

        INC editgridposhi

jmp19
        LDA #$01
        STA cursormoved
        LDA #<editgridhome+$7
        STA dataidx15+1
        LDA #>editgridhome
        STA dataidx16+1
        RTS
