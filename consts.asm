;===============================================================================
; CONSTANTS
;===============================================================================

; program constants
;
defaultscrnctl  = #$1B
messagearealen  = #$19   ; length of message display area
nummaincommands = #$1A   ; number of main editing key commands
editgridhexrow  = #$01   ; line/row number of edit grid hex values
editgridhexcol  = #$0B   ; column of edit grid hex values
editcharhexrow  = #$09   ; line/row number of editing char hex value display
editcharhexcol  = #$26   ; column of editing char hex value display
firebtndelay    = #$03   ; number of calls to monitor fire btn before checking port
editstickdelay  = #$03   ; number of calls to monitor joystick use in 8*8 grid before reading port
charstickdelay  = #$05   ; number of calls to monitor joystick use in 20*6 grid before reading port
charcrsrhomerow = #$0B   ; default cursor line in 20*6 grid
charcrsrhomecol = #$01   ; default cursor col in 20*6 grid
cursordelay     = $10    ; timing delay for interrupt-driven blinking cursor

; program variables
;
charmemposlo    = $A8    ; lo/hi pointer in charmembase $3000 - $37F8
charmemposhi    = $A9
editgridposlo   = $AA    ; lo/hi pointer of edit grid cursor position
editgridposhi   = $AB
tempsave4       = $AC
tempsave5       = $AD
workgridposlo   = $B8    ; lo/hi pointer of edit grid manipulation functions
workgridposhi   = $B9
charsetposlo    = $BA    ; lo/hi pointer in display editing character charsethome $06D1 - $07DC
charsetposhi    = $BB
tempcharsave    = $BC
tempsave6       = $BD
tempsave1       = $FB
tempsave2       = $FC
tempsave3       = $FD
editgridhome    = $0429  ; top-left 'pixel' of edit grid
gridmodeaddr    = $043C  ; grid mode display area
messageareaaddr = $04AE  ; message display area
editingcharcode = $058A  ; editing character display area
editingcharprt  = $05B2  ; editing character second display area
scrngridaddr    = $0590  ; start of 20*6 display area
scrngridhome    = $05B9  ; top-left and first character of 20*6 display area
charsethome     = $06D1  ; start of character set display area
charsetend      = $07DC  ; end of character set display area
charmembase     = $3000  ; character set represented as 1 byte = 1 character line. 8 bytes = 1 char
charmemend      = $37F8  ; character set memory end address
scrnsavebase    = $5C00  ; temporary screen save area $5C00 - $5FFF
