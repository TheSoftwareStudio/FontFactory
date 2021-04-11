;===============================================================================
; Command maps data
;===============================================================================

swapcmds
        BYTE $13,$93,$11,$1d,$91,$9d,$8d,$8e,$94,$d4

maincommands
        BYTE $20,$2B,$2D,$48,$55,$44,$4C,$52,$49,$4F,$57,$43,$58,$2A,$85,$86
        BYTE $87,$88,$13,$2E,$2C,$5E,$3D,$53,$5C

cmdloaddrs
        BYTE <pixelinvert
        BYTE <selectnextchr
        BYTE <selectprevchr
        BYTE <showhelp
        BYTE <scrollcharup
        BYTE <scrollchardown
        BYTE <scrollcharleft
        BYTE <scrollcharright
        BYTE <loadfromdevice
        BYTE <savetodevice
        BYTE <swapwindowmaps
        BYTE <copyromchar
        BYTE <exitprogram
        BYTE <rotatechar90
        BYTE <invertchar
        BYTE <cleargrid88
        BYTE <moveupaline
        BYTE <movedownaline
        BYTE <homecursor
        BYTE <mirrorcharhorz
        BYTE <mirrorcharvert
        BYTE <cleargrid206
        BYTE <fillgrid206
        BYTE <swapcharposns
        BYTE <trfrmodetoggle

cmdhiaddrs
        BYTE >pixelinvert
        BYTE >selectnextchr
        BYTE >selectprevchr
        BYTE >showhelp
        BYTE >scrollcharup
        BYTE >scrollchardown
        BYTE >scrollcharleft
        BYTE >scrollcharright
        BYTE >loadfromdevice
        BYTE >savetodevice
        BYTE >swapwindowmaps
        BYTE >copyromchar
        BYTE >exitprogram
        BYTE >rotatechar90
        BYTE >invertchar
        BYTE >cleargrid88
        BYTE >moveupaline
        BYTE >movedownaline
        BYTE >homecursor
        BYTE >mirrorcharhorz
        BYTE >mirrorcharvert
        BYTE >cleargrid206
        BYTE >fillgrid206
        BYTE >swapcharposns
        BYTE >trfrmodetoggle
