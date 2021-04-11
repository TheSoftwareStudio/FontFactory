;===============================================================================
; Kernel constants
;===============================================================================

; zero-page memory
;
procport        = $01
devicestatus    = $90
bitcirs232      = $A8
rinoners232     = $A9
ridatars232     = $AA
riprtyrs232     = $AB
deviceendlo     = $AE
deviceendhi     = $AF
filenamlen      = $B7
filelognum      = $B8
filesecaddr     = $B9
devicenum       = $BA
filenamelo      = $BB
filenamehi      = $BC
devicestartlo   = $C1
devicestarthi   = $C2
keybdmatrix     = $C5
keybdbufferlen  = $C6
scrnlinepntlo   = $D1
scrnlinepnthi   = $D2
scrncolpntr     = $D3

; system memory
;
keybdbufferbase = $0277
cursorcolor     = $0286
irqsvcloaddr    = $0314
irqsvchiaddr    = $0315
displaybase     = $0400
cartridgesig    = $8008
upperchrrom     = $D000
scrnctlreg      = $D011
rasterline      = $D012
memsetupreg     = $D018
irqstatusreg    = $D019
irqctlreg       = $D01A
bordercolor     = $D020
scrncolor       = $D021
lowerchrrom     = $D800
joystickport2   = $DC00
joystickport1   = $DC01
irqctlstatreg   = $DC0D
timeractlreg    = $DC0E
timerbctlreg    = $DC0F
chrromend       = $E000

; kernel routines
;
krnl_linprt     = $BDCD
krnl_clrscrn    = $E544
irqsvcroutine   = $EA31
krnl_prtloading = $F3D5
krnl_gosave     = $F5EA
krnl_closefile  = $F642
krnl_coldstart  = $FCE2
krnl_tksa       = $FF96
krnl_scnkey     = $FF9F
krnl_iecin      = $FFA5
krnl_untlk      = $FFAB
krnl_talk       = $FFB4
krnl_setlfs     = $FFBA
krnl_setnam     = $FFBD
krnl_chrin      = $FFCF
krnl_chrout     = $FFD2
krnl_load       = $FFD5
krnl_save       = $FFD8
krnl_getin      = $FFE4
krnl_clall      = $FFE7
krnl_plot       = $FFF0

; color codes
;
colorwhite      = #$01
colorblue       = #$06
colorlightblue  = #$0E

; key codes
;
keycbmshift     = #$08
keyreturn       = #$0D
keyspace        = #$20
keyasterisk     = #$2A
keyplus         = #$2B
keyminus        = #$2D
key0            = #$30
key1            = #$31
key2            = #$32
key3            = #$33
key4            = #$34
key5            = #$35
key6            = #$36
key7            = #$37
key8            = #$38
key9            = #$39
keyd            = #$44
keyl            = #$4C
keyq            = #$51
keys            = #$53
keyt            = #$54
keyu            = #$55
keysterling     = #$5C
keyf5           = #$87
keyf7           = #$88
keyfullblock    = #$A0
