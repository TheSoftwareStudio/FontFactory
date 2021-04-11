;===============================================================================
; Joystick monitor routines
;===============================================================================

;
; Utility function : monitor joystick in 8*8 edit grid
;
Align
checkeditstick
        DEC editstickcount
        BEQ rxeditstick         ; only process joystick port every nth call
        RTS

rxeditstick
        LDA editstickdelay      ; reset process every nth counter
        STA editstickcount

        LDA joystickport2
        STA joystickbits
        AND #$10
        BNE checkforup
        RTS

checkforup
        LDA joystickbits
        AND #$01                ; test joystick up pressed, 0 = pressed
        BNE checkfordown

        JSR movecrsrup
        LDA joystickbits
        BEQ checkfordown

        JMP donemonstick

checkfordown
        LDA joystickbits
        AND #$02                ; test joystick down pressed, 0 = pressed
        BNE checkforleft

        JSR movecrsrdown
        LDA cursormoved
        BEQ checkforleft

        JMP donemonstick

checkforleft
        LDA joystickbits
        AND #$04                ; test joystick left pressed, 0 = pressed
        BNE checkforright

        JSR movecrsrleft
        LDA cursormoved
        BEQ checkforright

        JMP donemonstick

checkforright
        LDA joystickbits
        AND #$08                ; test joystick right pressed, 0 = pressed
        BNE exitmonstick

        JSR movecrsrright
        LDA cursormoved
        BEQ exitmonstick

donemonstick
        STX keybdbufferbase
        LDA keybdbufferlen
        BNE exitmonstick

        INC keybdbufferlen

exitmonstick
        RTS

;
; Utility function: monitor joystick in 20*6 edit grid
;
checkcharstick
        DEC charstickcount
        BEQ rxcharstick                 ; only process joystick port every nth call
        RTS
                
rxcharstick
        LDA charstickdelay
        STA charstickcount

        LDA joystickport2
        CMP #$7E                        ; up press?
        BEQ charmovedup
        
        CMP #$7D
        BEQ charmoveddown               ; down press?

        CMP #$7B
        BEQ charmovedleft               ; left press?

        CMP #$77
        BEQ charmovedright              ; right press?
        RTS

charmovedup
        LDA charcursorrow+1             ; up
        CMP charcrsrhomerow
        BNE charmoveup
        RTS

charmoveup
        DEC charcursorrow+1             ; move up
        RTS

charmoveddown
        LDA charcursorrow+1             ; down
        CMP charcrsrhomerow+$5
        BNE charmovedown
        RTS

charmovedown
        INC charcursorrow+1             ; move down
        RTS

charmovedleft
        LDA charcursorcol+1             ; left
        CMP charcrsrhomecol
        BNE charmoveleft
        RTS

charmoveleft
        DEC charcursorcol+1             ; move left
        RTS

charmovedright
        LDA charcursorcol+1             ; right
        CMP charcrsrhomerow+$13
        BNE charmoveright
        RTS

charmoveright
        INC charcursorcol+1             ; move right
        RTS

;
; Utility function : check joystick fire button every n-th call
;
monitorfirebtn
        DEC firebtncounter
        LDA firebtncounter
        CMP #$00
        BEQ processfirebtn
        RTS

processfirebtn
        LDA firebtndelay
        STA firebtncounter
        JSR checkfirebtn
        RTS
