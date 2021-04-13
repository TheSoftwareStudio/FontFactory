
00001  0000             ; ========================================
00002  0001             ; PROJECT   : FONT FACTORY
00003  0001             ; TARGET    : COMMODORE 64
00004  0001             ; COMMENTS  : COPYRIGHT (C) 1989 CRAIG NOTTINGHAM. ALL RIGHTS RESERVED.
00005  0001             ; AUTHOR    : CRAIG NOTTINGHAM
00006  0001             ; ========================================
00007  0001             
00008  0001             TARGET     TGT_C64
00009  0001             
00010  0001             ;===============================================================================
00011  0001             ; KERNEL CONSTANTS
00012  0001             ;===============================================================================
00013  0001             
00014  0001             ; ZERO-PAGE MEMORY
00015  0001             ;
00016  0001             PROCPORT   = $01
00017  0001             DEVICESTATUS = $90
00018  0001             BITCIRS232 = $A8
00019  0001             RINONERS232 = $A9
00020  0001             RIDATARS232 = $AA
00021  0001             RIPRTYRS232 = $AB
00022  0001             DEVICEENDLO = $AE
00023  0001             DEVICEENDHI = $AF
00024  0001             FILENAMLEN = $B7
00025  0001             FILELOGNUM = $B8
00026  0001             FILESECADDR = $B9
00027  0001             DEVICENUM  = $BA
00028  0001             FILENAMELO = $BB
00029  0001             FILENAMEHI = $BC
00030  0001             DEVICESTARTLO = $C1
00031  0001             DEVICESTARTHI = $C2
00032  0001             KEYBDMATRIX = $C5
00033  0001             KEYBDBUFFERLEN = $C6
00034  0001             SCRNLINEPNTLO = $D1
00035  0001             SCRNLINEPNTHI = $D2
00036  0001             SCRNCOLPNTR = $D3
00037  0001             
00038  0001             ; SYSTEM MEMORY
00039  0001             ;
00040  0001             KEYBDBUFFERBASE = $0277
00041  0001             CURSORCOLOR = $0286
00042  0001             IRQSVCLOADDR = $0314
00043  0001             IRQSVCHIADDR = $0315
00044  0001             DISPLAYBASE = $0400
00045  0001             CARTRIDGESIG = $8008
00046  0001             UPPERCHRROM = $D000
00047  0001             SCRNCTLREG = $D011
00048  0001             RASTERLINE = $D012
00049  0001             MEMSETUPREG = $D018
00050  0001             IRQSTATUSREG = $D019
00051  0001             IRQCTLREG  = $D01A
00052  0001             BORDERCOLOR = $D020
00053  0001             SCRNCOLOR  = $D021
00054  0001             LOWERCHRROM = $D800
00055  0001             JOYSTICKPORT2 = $DC00
00056  0001             JOYSTICKPORT1 = $DC01
00057  0001             IRQCTLSTATREG = $DC0D
00058  0001             TIMERACTLREG = $DC0E
00059  0001             TIMERBCTLREG = $DC0F
00060  0001             CHRROMEND  = $E000
00061  0001             
00062  0001             ; KERNEL ROUTINES
00063  0001             ;
00064  0001             KRNL_LINPRT = $BDCD
00065  0001             KRNL_CLRSCRN = $E544
00066  0001             IRQSVCROUTINE = $EA31
00067  0001             KRNL_PRTLOADING = $F3D5
00068  0001             KRNL_GOSAVE = $F5EA
00069  0001             KRNL_CLOSEFILE = $F642
00070  0001             KRNL_COLDSTART = $FCE2
00071  0001             KRNL_TKSA  = $FF96
00072  0001             KRNL_SCNKEY = $FF9F
00073  0001             KRNL_IECIN = $FFA5
00074  0001             KRNL_UNTLK = $FFAB
00075  0001             KRNL_TALK  = $FFB4
00076  0001             KRNL_SETLFS = $FFBA
00077  0001             KRNL_SETNAM = $FFBD
00078  0001             KRNL_CHRIN = $FFCF
00079  0001             KRNL_CHROUT = $FFD2
00080  0001             KRNL_LOAD  = $FFD5
00081  0001             KRNL_SAVE  = $FFD8
00082  0001             KRNL_GETIN = $FFE4
00083  0001             KRNL_CLALL = $FFE7
00084  0001             KRNL_PLOT  = $FFF0
00085  0001             
00086  0001             ; COLOR CODES
00087  0001             ;
00088  0001             COLORWHITE = #$01
00089  0001             COLORBLUE  = #$06
00090  0001             COLORLIGHTBLUE = #$0E
00091  0001             
00092  0001             ; KEY CODES
00093  0001             ;
00094  0001             KEYCBMSHIFT = #$08
00095  0001             KEYRETURN  = #$0D
00096  0001             KEYSPACE   = #$20
00097  0001             KEYASTERISK = #$2A
00098  0001             KEYPLUS    = #$2B
00099  0001             KEYMINUS   = #$2D
00100  0001             KEY0       = #$30
00101  0001             KEY1       = #$31
00102  0001             KEY2       = #$32
00103  0001             KEY3       = #$33
00104  0001             KEY4       = #$34
00105  0001             KEY5       = #$35
00106  0001             KEY6       = #$36
00107  0001             KEY7       = #$37
00108  0001             KEY8       = #$38
00109  0001             KEY9       = #$39
00110  0001             KEYD       = #$44
00111  0001             KEYL       = #$4C
00112  0001             KEYQ       = #$51
00113  0001             KEYS       = #$53
00114  0001             KEYT       = #$54
00115  0001             KEYU       = #$55
00116  0001             KEYSTERLING = #$5C
00117  0001             KEYF5      = #$87
00118  0001             KEYF7      = #$88
00119  0001             KEYFULLBLOCK = #$A0
00120  0001             ;===============================================================================
00121  0001             ; CONSTANTS
00122  0001             ;===============================================================================
00123  0001             
00124  0001             ; PROGRAM CONSTANTS
00125  0001             ;
00126  0001             DEFAULTSCRNCTL = #$1B
00127  0001             MESSAGEAREALEN = #$19   ; LENGTH OF MESSAGE DISPLAY AREA
00128  0001             NUMMAINCOMMANDS = #$1A   ; NUMBER OF MAIN EDITING KEY COMMANDS
00129  0001             EDITGRIDHEXROW = #$01   ; LINE/ROW NUMBER OF EDIT GRID HEX VALUES
00130  0001             EDITGRIDHEXCOL = #$0B   ; COLUMN OF EDIT GRID HEX VALUES
00131  0001             EDITCHARHEXROW = #$09   ; LINE/ROW NUMBER OF EDITING CHAR HEX VALUE DISPLAY
00132  0001             EDITCHARHEXCOL = #$26   ; COLUMN OF EDITING CHAR HEX VALUE DISPLAY
00133  0001             FIREBTNDELAY = #$03   ; NUMBER OF CALLS TO MONITOR FIRE BTN BEFORE CHECKING PORT
00134  0001             EDITSTICKDELAY = #$03   ; NUMBER OF CALLS TO MONITOR JOYSTICK USE IN 8*8 GRID BEFORE READING PORT
00135  0001             CHARSTICKDELAY = #$05   ; NUMBER OF CALLS TO MONITOR JOYSTICK USE IN 20*6 GRID BEFORE READING PORT
00136  0001             CHARCRSRHOMEROW = #$0B   ; DEFAULT CURSOR LINE IN 20*6 GRID
00137  0001             CHARCRSRHOMECOL = #$01   ; DEFAULT CURSOR COL IN 20*6 GRID
00138  0001             CURSORDELAY = $10    ; TIMING DELAY FOR INTERRUPT-DRIVEN BLINKING CURSOR
00139  0001             
00140  0001             ; PROGRAM VARIABLES
00141  0001             ;
00142  0001             CHARMEMPOSLO = $A8    ; LO/HI POINTER IN CHARMEMBASE $3000 - $37F8
00143  0001             CHARMEMPOSHI = $A9
00144  0001             EDITGRIDPOSLO = $AA    ; LO/HI POINTER OF EDIT GRID CURSOR POSITION
00145  0001             EDITGRIDPOSHI = $AB
00146  0001             TEMPSAVE4  = $AC
00147  0001             TEMPSAVE5  = $AD
00148  0001             WORKGRIDPOSLO = $B8    ; LO/HI POINTER OF EDIT GRID MANIPULATION FUNCTIONS
00149  0001             WORKGRIDPOSHI = $B9
00150  0001             CHARSETPOSLO = $BA    ; LO/HI POINTER IN DISPLAY EDITING CHARACTER CHARSETHOME $06D1 - $07DC
00151  0001             CHARSETPOSHI = $BB
00152  0001             TEMPCHARSAVE = $BC
00153  0001             TEMPSAVE6  = $BD
00154  0001             TEMPSAVE1  = $FB
00155  0001             TEMPSAVE2  = $FC
00156  0001             TEMPSAVE3  = $FD
00157  0001             EDITGRIDHOME = $0429  ; TOP-LEFT 'PIXEL' OF EDIT GRID
00158  0001             GRIDMODEADDR = $043C  ; GRID MODE DISPLAY AREA
00159  0001             MESSAGEAREAADDR = $04AE  ; MESSAGE DISPLAY AREA
00160  0001             EDITINGCHARCODE = $058A  ; EDITING CHARACTER DISPLAY AREA
00161  0001             EDITINGCHARPRT = $05B2  ; EDITING CHARACTER SECOND DISPLAY AREA
00162  0001             SCRNGRIDADDR = $0590  ; START OF 20*6 DISPLAY AREA
00163  0001             SCRNGRIDHOME = $05B9  ; TOP-LEFT AND FIRST CHARACTER OF 20*6 DISPLAY AREA
00164  0001             CHARSETHOME = $06D1  ; START OF CHARACTER SET DISPLAY AREA
00165  0001             CHARSETEND = $07DC  ; END OF CHARACTER SET DISPLAY AREA
00166  0001             CHARMEMBASE = $3000  ; CHARACTER SET REPRESENTED AS 1 BYTE = 1 CHARACTER LINE. 8 BYTES = 1 CHAR
00167  0001             CHARMEMEND = $37F8  ; CHARACTER SET MEMORY END ADDRESS
00168  0001             SCRNSAVEBASE = $5C00  ; TEMPORARY SCREEN SAVE AREA $5C00 - $5FFF
00169  0001             
00170  0001             ;===============================================================================
00171  0001             ; CODE
00172  0001             ;===============================================================================
00173  0001             
00174  0001             ;
00175  0001             ; PROGRAM : MAIN ENTRY POINT
00176  0001             ;
00177  0001             *=$1000
00178  1000             MAIN
00179  1000  A9 0E                 LDA COLORLIGHTBLUE
00180  1002  8D 20 D0              STA BORDERCOLOR
00181  1005  A9 06                 LDA COLORBLUE
00182  1007  8D 21 D0              STA SCRNCOLOR
00183  100A  A9 01                 LDA COLORWHITE
00184  100C  8D 86 02              STA CURSORCOLOR
00185  100F             
00186  100F  20 44 E5              JSR KRNL_CLRSCRN
00187  1012  20 31 11              JSR INIT
00188  1015             
00189  1015  A2 00                 LDX #$00
00190  1017             
00191  1017             SHOWMAINSCRN 
00192  1017  BD 00 40              LDA DATASCRNMAIN,X
00193  101A  9D 00 04              STA DISPLAYBASE,X
00194  101D  BD 00 41              LDA DATASCRNMAIN+$100,X
00195  1020  9D 00 05              STA DISPLAYBASE+$100,X
00196  1023  BD 00 42              LDA DATASCRNMAIN+$200,X
00197  1026  9D 00 06              STA DISPLAYBASE+$200,X
00198  1029  BD 00 43              LDA DATASCRNMAIN+$300,X
00199  102C  9D 00 07              STA DISPLAYBASE+$300,X
00200  102F  E8                    INX
00201  1030  D0 E5                 BNE SHOWMAINSCRN
00202  1032             
00203  1032  A9 08                 LDA KEYCBMSHIFT
00204  1034  20 D2 FF              JSR KRNL_CHROUT ; DISABLE C=-SHIFT
00205  1037             
00206  1037             SCANKEYS
00207  1037  20 9F FF              JSR KRNL_SCNKEY
00208  103A  20 E4 FF              JSR KRNL_GETIN
00209  103D  C9 00                 CMP #$00
00210  103F  F0 F6                 BEQ SCANKEYS
00211  1041             
00212  1041  C9 55                 CMP KEYU
00213  1043  F0 07                 BEQ USEUPPERCASE
00214  1045             
00215  1045  C9 4C                 CMP KEYL
00216  1047  F0 0E                 BEQ USELOWERCASE
00217  1049             
00218  1049  4C 37 10              JMP SCANKEYS
00219  104C             
00220  104C             USEUPPERCASE 
00221  104C  A9 D0                 LDA #>UPPERCHRROM       ; COPY UPPER-CASE CHARS
00222  104E  8D 84 10              STA SRCCHRROM+2
00223  1051  8D E3 1B              STA COPYROMCHARIDX+1    ; SET CORRECT CASE IN COPY ROM CHAR TO RAM CHAR ROUTINE
00224  1054  4C 77 10              JMP CPYROM
00225  1057             
00226  1057             USELOWERCASE 
00227  1057  A9 D8                 LDA #>LOWERCHRROM       ; COPY LOWER-CASE CHARS
00228  1059  8D 84 10              STA SRCCHRROM+2
00229  105C  8D E3 1B              STA COPYROMCHARIDX+1    ; SET CORRECT CASE IN COPY ROM CHAR TO RAM CHAR ROUTINE
00230  105F             
00231  105F  A2 00                 LDX #$00
00232  1061             
00233  1061             CPYGRID1
00234  1061  BD 00 54              LDA DATACHARGRID,X
00235  1064  9D 90 05              STA SCRNGRIDADDR,X
00236  1067  E8                    INX
00237  1068  D0 F7                 BNE CPYGRID1
00238  106A             
00239  106A  A2 00                 LDX #$00
00240  106C             
00241  106C             CPYGRID2
00242  106C  BD 00 55              LDA DATACHARGRID+$100,X
00243  106F  9D 90 06              STA SCRNGRIDADDR+$100,X
00244  1072  E8                    INX
00245  1073  E0 40                 CPX #$40
00246  1075  D0 F5                 BNE CPYGRID2
00247  1077             
00248  1077             CPYROM
00249  1077  A9 7F                 LDA #$7F
00250  1079  8D 0D DC              STA IRQCTLSTATREG
00251  107C             
00252  107C  A9 33                 LDA #$33
00253  107E  85 01                 STA PROCPORT
00254  1080             
00255  1080             CPYCHRROM  ; COPY CHARACTER DATA FROM $D000 OR $D800 INTO $3000-$3FFF
00256  1080  A2 00                 LDX #$00
00257  1082             
00258  1082             SRCCHRROM
00259  1082  BD 00 D0              LDA UPPERCHRROM,X
00260  1085             
00261  1085             DESTCHRROM 
00262  1085  9D 00 30              STA CHARMEMBASE,X
00263  1088  E8                    INX
00264  1089  D0 F7                 BNE SRCCHRROM
00265  108B             
00266  108B  EE 84 10              INC SRCCHRROM+2
00267  108E  EE 87 10              INC DESTCHRROM+2
00268  1091  AD 84 10              LDA SRCCHRROM+2
00269  1094  C9 E0                 CMP #>CHRROMEND
00270  1096  F0 03                 BEQ JMP29
00271  1098  4C 80 10              JMP CPYCHRROM
00272  109B             
00273  109B             JMP29
00274  109B  A9 D0                 LDA #>UPPERCHRROM       ; RESET SOURCE TO UPPER-CASE CHARS IN ROM
00275  109D  8D 84 10              STA SRCCHRROM+2
00276  10A0  A9 30                 LDA #>CHARMEMBASE       ; RESET DESTINATION TO CHAR-SET WORKING AREA
00277  10A2  8D 87 10              STA DESTCHRROM+2
00278  10A5  A9 37                 LDA #$37
00279  10A7  85 01                 STA PROCPORT
00280  10A9  A9 81                 LDA #$81
00281  10AB  8D 0D DC              STA IRQCTLSTATREG
00282  10AE                        
00283  10AE  A9 20                 LDA KEYSPACE
00284  10B0  A2 00                 LDX #$00
00285  10B2             
00286  10B2             LOOP19
00287  10B2  9D AE 04              STA MESSAGEAREAADDR,X
00288  10B5  E8                    INX
00289  10B6  E0 19                 CPX MESSAGEAREALEN
00290  10B8  D0 F8                 BNE LOOP19
00291  10BA  20 DB 1A              JSR SHOWCHARCURSOR
00292  10BD             
00293  10BD             MAINLOOP
00294  10BD  A2 00                 LDX #$00
00295  10BF             
00296  10BF             LOOPEDITCHARROW 
00297  10BF  8A                    TXA
00298  10C0  48                    PHA
00299  10C1  20 5D 23              JSR DRAWEDITROW
00300  10C4  68                    PLA
00301  10C5  AA                    TAX
00302  10C6  E8                    INX
00303  10C7  E0 08                 CPX #$08
00304  10C9  D0 F4                 BNE LOOPEDITCHARROW
00305  10CB             
00306  10CB  38                    SEC
00307  10CC  A5 A8                 LDA CHARMEMPOSLO
00308  10CE  E9 08                 SBC #$08
00309  10D0  85 A8                 STA CHARMEMPOSLO
00310  10D2  A5 A9                 LDA CHARMEMPOSHI
00311  10D4  E9 00                 SBC #$00
00312  10D6  85 A9                 STA CHARMEMPOSHI
00313  10D8             
00314  10D8             MAINPROCESS 
00315  10D8  20 00 24              JSR CHECKEDITSTICK
00316  10DB  20 B4 24              JSR MONITORFIREBTN
00317  10DE  20 92 23              JSR PRINTHEXROWS
00318  10E1  20 B7 1A              JSR SHOWEDITCURSOR
00319  10E4             
00320  10E4  20 9F FF              JSR KRNL_SCNKEY
00321  10E7  20 E4 FF              JSR KRNL_GETIN
00322  10EA  C9 00                 CMP #$00
00323  10EC  F0 EA                 BEQ MAINPROCESS
00324  10EE             
00325  10EE  A2 00                 LDX #$00
00326  10F0             
00327  10F0             FINDCMD
00328  10F0  DD 0A 58              CMP MAINCOMMANDS,X      ; FIND COMMAND INDEX FOR KEY PRESS
00329  10F3  F0 08                 BEQ CALLCMD
00330  10F5  E8                    INX
00331  10F6  E0 1A                 CPX NUMMAINCOMMANDS
00332  10F8  D0 F6                 BNE FINDCMD
00333  10FA             
00334  10FA  4C D8 10              JMP MAINPROCESS
00335  10FD             
00336  10FD             CALLCMD
00337  10FD  BD 23 58              LDA CMDLOADDRS,X        ; GET LO/HI FUNCTION POINTER FOR CORRESPONDING COMMAND INDEX
00338  1100  BC 3C 58              LDY CMDHIADDRS,X
00339  1103  8D 0A 11              STA CMDPOINTER+1
00340  1106  8C 0B 11              STY CMDPOINTER+2
00341  1109             
00342  1109             CMDPOINTER 
00343  1109  20 C8 24              JSR HOMECURSOR          ; CALL FUNCTION REQUESTED BY USER - ADDRESS SET ABOVE
00344  110C                        
00345  110C  A9 29                 LDA #<EDITGRIDHOME
00346  110E  85 B8                 STA WORKGRIDPOSLO
00347  1110  A9 04                 LDA #>EDITGRIDHOME
00348  1112  85 B9                 STA WORKGRIDPOSHI
00349  1114                        
00350  1114  AD 01 56              LDA EDITINGCHAR         ; DISPLAY EDITING CHAR AND HEX VALUE (BELOW)
00351  1117  8D 8A 05              STA EDITINGCHARCODE
00352  111A  8D B2 05              STA EDITINGCHARPRT
00353  111D             
00354  111D  CE C2 23              DEC PRINTHEXBYTE+1      ; TODO: CHANGE HOW THIS OPERATES
00355  1120  A2 09                 LDX EDITCHARHEXROW
00356  1122  A0 26                 LDY EDITCHARHEXCOL
00357  1124  18                    CLC
00358  1125  20 F0 FF              JSR KRNL_PLOT           ; POSITION PRINT CURSOR
00359  1128  20 C1 23              JSR PRINTHEXBYTE        ; TO PRINT HEX VALUE OF EDITING CHAR
00360  112B  EE C2 23              INC PRINTHEXBYTE+1      ; TODO: CHANGE HOW THIS OPERATES
00361  112E             
00362  112E  4C BD 10              JMP MAINLOOP
00363  1131             
00364  1131             ;===============================================================================
00365  1131             ; INITIALIZE FUNCTIONS
00366  1131             ;===============================================================================
00367  1131             
00368  1131             ;
00369  1131             ; UTILITY FUNCTION : INITIALIZE PROGRAM VARIABLES
00370  1131             ;
00371  1131             ; INPUT:
00372  1131             ;       N/A
00373  1131             ; OUTPUT:
00374  1131             ;       N/A
00375  1131             ; USES:
00376  1131             ;       A REG
00377  1131             ;       X REG
00378  1131             ;
00379  1131             INIT
00380  1131  A9 00                 LDA #<CHARMEMBASE
00381  1133  85 A8                 STA CHARMEMPOSLO
00382  1135  A9 30                 LDA #>CHARMEMBASE
00383  1137  85 A9                 STA CHARMEMPOSHI
00384  1139             
00385  1139  A9 29                 LDA #<EDITGRIDHOME
00386  113B  85 B8                 STA WORKGRIDPOSLO
00387  113D  85 AA                 STA EDITGRIDPOSLO
00388  113F  A9 04                 LDA #>EDITGRIDHOME
00389  1141  85 B9                 STA WORKGRIDPOSHI
00390  1143  85 AB                 STA EDITGRIDPOSHI
00391  1145             
00392  1145  A9 D1                 LDA #<CHARSETHOME
00393  1147  85 BA                 STA CHARSETPOSLO
00394  1149  A9 06                 LDA #>CHARSETHOME
00395  114B  85 BB                 STA CHARSETPOSHI
00396  114D             
00397  114D  A9 10                 LDA #CURSORDELAY
00398  114F  8D 00 56              STA CURSORTIMER
00399  1152             
00400  1152  A9 05                 LDA CHARSTICKDELAY
00401  1154  8D 08 56              STA CHARSTICKCOUNT
00402  1157  A9 03                 LDA EDITSTICKDELAY
00403  1159  8D 03 56              STA EDITSTICKCOUNT
00404  115C             
00405  115C  A9 00                 LDA #$00
00406  115E  8D 01 56              STA EDITINGCHAR
00407  1161             
00408  1161  A9 38                 LDA KEY8
00409  1163  8D 06 56              STA STORAGEDEVNUM
00410  1166  8D D9 4D              STA DATALOADDEVNUM
00411  1169             
00412  1169  A9 0B                 LDA CHARCRSRHOMEROW
00413  116B  8D 15 1D              STA CHARCURSORROW+1
00414  116E  A9 01                 LDA CHARCRSRHOMECOL
00415  1170  8D 17 1D              STA CHARCURSORCOL+1
00416  1173             
00417  1173  A9 01                 LDA #COLORWHITE
00418  1175  20 79 11              JSR SETSCREENCOLOR
00419  1178  60                    RTS
00420  1179             
00421  1179             ;
00422  1179             ; UTILITY FUNCTION : SET SCREEN COLOUR ($D800 - $DFFF)
00423  1179             ;
00424  1179             ; INPUT:
00425  1179             ;       A REG - COLOR
00426  1179             ; OUTPUT:
00427  1179             ;       N/A
00428  1179             ; USES:
00429  1179             ;       X REG
00430  1179             ;
00431  1179             SETSCREENCOLOR 
00432  1179  A2 00                 LDX #$00
00433  117B             
00434  117B             SETPAGECOLOR 
00435  117B  9D 00 D8              STA LOWERCHRROM,X
00436  117E  9D 00 D9              STA LOWERCHRROM+$100,X
00437  1181  9D 00 DA              STA LOWERCHRROM+$200,X
00438  1184  9D 00 DB              STA LOWERCHRROM+$300,X
00439  1187  E8                    INX
00440  1188  D0 F1                 BNE SETPAGECOLOR
00441  118A  60                    RTS
00442  118B             ;===============================================================================
00443  118B             ; EXIT PROGRAM (COLD START)
00444  118B             ;===============================================================================
00445  118B             
00446  118B             EXITPROGRAM 
00447  118B  78                    SEI
00448  118C  A9 31                 LDA #<IRQSVCROUTINE
00449  118E  8D 14 03              STA IRQSVCLOADDR
00450  1191  A9 EA                 LDA #>IRQSVCROUTINE
00451  1193  8D 15 03              STA IRQSVCHIADDR
00452  1196             
00453  1196  A9 79                 LDA #$79
00454  1198  8D 19 D0              STA IRQSTATUSREG
00455  119B  A9 F0                 LDA #$F0
00456  119D  8D 1A D0              STA IRQCTLREG
00457  11A0  A9 01                 LDA #$01
00458  11A2  8D 0E DC              STA TIMERACTLREG
00459  11A5  58                    CLI
00460  11A6             
00461  11A6  A9 01                 LDA #$01
00462  11A8  8D 08 80              STA CARTRIDGESIG        ; PREVENT CARTRIDGE AUTO-START BY SPOILING CBM80 SIGNATURE
00463  11AB             
00464  11AB  4C E2 FC              JMP KRNL_COLDSTART
00465  11AE             ;===============================================================================
00466  11AE             ; COMMAND HANDLER: TOGGLE EDITING PIXEL ON/OFF
00467  11AE             ;===============================================================================
00468  11AE             
00469  11AE             CHECKFIREBTN 
00470  11AE  AD 00 DC              LDA JOYSTICKPORT2
00471  11B1  C9 6F                 CMP #$6F
00472  11B3  F0 01                 BEQ PIXELINVERT
00473  11B5  60                    RTS
00474  11B6             
00475  11B6             PIXELINVERT 
00476  11B6  A2 00                 LDX #$00
00477  11B8  A1 AA                 LDA (EDITGRIDPOSLO,X)
00478  11BA  C9 A0                 CMP KEYFULLBLOCK        ; PIXEL ON?
00479  11BC  F0 07                 BEQ CLRPIXEL
00480  11BE             
00481  11BE  A9 A0                 LDA KEYFULLBLOCK        ; SET PIXEL
00482  11C0  81 AA                 STA (EDITGRIDPOSLO,X)
00483  11C2  4C C9 11              JMP SHOWPIXEL
00484  11C5             
00485  11C5             CLRPIXEL
00486  11C5  A9 20                 LDA KEYSPACE            ; CLEAR PIXEL
00487  11C7  81 AA                 STA (EDITGRIDPOSLO,X)
00488  11C9             
00489  11C9             SHOWPIXEL
00490  11C9  EA                    NOP
00491  11CA  EA                    NOP
00492  11CB  EA                    NOP
00493  11CC             
00494  11CC             STOREDITGRID 
00495  11CC  A0 00                 LDY #$00                ; CLEAR 8-BYTES IN-MEMORY OF THE CHAR READY FOR NEW VALUES
00496  11CE  A9 00                 LDA #$00
00497  11D0             
00498  11D0             CLRMEMPIXEL 
00499  11D0  91 A8                 STA (CHARMEMPOSLO),Y
00500  11D2  C8                    INY
00501  11D3  C0 08                 CPY #$08
00502  11D5  D0 F9                 BNE CLRMEMPIXEL
00503  11D7             
00504  11D7  A9 29                 LDA #<EDITGRIDHOME      ; START AT TOP-LEFT OF DISPLAY 8*8 EDIT GRID
00505  11D9  85 B8                 STA WORKGRIDPOSLO
00506  11DB  A9 04                 LDA #>EDITGRIDHOME
00507  11DD  85 B9                 STA WORKGRIDPOSHI
00508  11DF             
00509  11DF  A2 00                 LDX #$00
00510  11E1             
00511  11E1             STORMEMPIXEL 
00512  11E1  8A                    TXA
00513  11E2  48                    PHA
00514  11E3  20 00 12              JSR SETMEMPIXEL
00515  11E6  68                    PLA
00516  11E7  AA                    TAX
00517  11E8  E8                    INX
00518  11E9  E0 08                 CPX #$08
00519  11EB  D0 F4                 BNE STORMEMPIXEL
00520  11ED             
00521  11ED  38                    SEC                     ; SET CHARACTER MEMORY POINTER POSITIONS BACK TO CHAR START
00522  11EE  A5 A8                 LDA CHARMEMPOSLO
00523  11F0  E9 08                 SBC #$08
00524  11F2  85 A8                 STA CHARMEMPOSLO
00525  11F4  A5 A9                 LDA CHARMEMPOSHI
00526  11F6  E9 00                 SBC #$00
00527  11F8  85 A9                 STA CHARMEMPOSHI
00528  11FA  60                    RTS
00529  11FB             
00530  11FB             ;
00531  11FB             ; UTILITY FUNCTION : SET PIXEL IN CHARACTER MEMORY FROM DISPLAY EDITING GRID
00532  11FB             ;
00533  11FB             ALIGN
00534  1200             SETMEMPIXEL 
00535  1200  A0 80                 LDY #$80
00536  1202             
00537  1202             CHKGRIDPIXEL 
00538  1202  A2 00                 LDX #$00
00539  1204  A1 B8                 LDA (WORKGRIDPOSLO,X)
00540  1206  C9 A0                 CMP KEYFULLBLOCK        ; IS THE PIXEL SET? REPRESENTING A '1', IGNORE IF CLEAR/'0'
00541  1208  D0 06                 BNE NEXTPIXELPOS
00542  120A             
00543  120A  98                    TYA
00544  120B  18                    CLC
00545  120C  61 A8                 ADC (CHARMEMPOSLO,X)
00546  120E  81 A8                 STA (CHARMEMPOSLO,X)
00547  1210             
00548  1210             NEXTPIXELPOS 
00549  1210  E6 B8                 INC WORKGRIDPOSLO       ; MOVE TO NEXT 'PIXEL' IN DISPLAY 8*8 EDIT GRID
00550  1212  D0 02                 BNE NEXTPIXELCOL
00551  1214  E6 B9                 INC WORKGRIDPOSHI
00552  1216             
00553  1216             NEXTPIXELCOL 
00554  1216  98                    TYA
00555  1217  4A                    LSR
00556  1218  A8                    TAY
00557  1219  D0 E7                 BNE CHKGRIDPIXEL
00558  121B             
00559  121B  18                    CLC
00560  121C  A5 B8                 LDA WORKGRIDPOSLO       ; MOVE TO NEXT ROW IN DISPLAY 8*8 EDIT GRID
00561  121E  69 20                 ADC #$20
00562  1220  85 B8                 STA WORKGRIDPOSLO
00563  1222  A5 B9                 LDA WORKGRIDPOSHI
00564  1224  69 00                 ADC #$00
00565  1226  85 B9                 STA WORKGRIDPOSHI
00566  1228                        
00567  1228  E6 A8                 INC CHARMEMPOSLO        ; MOVE TO NEXT CHARACTER MEMORY POSITION
00568  122A  D0 02                 BNE EXITSETMEMPIXEL
00569  122C  E6 A9                 INC CHARMEMPOSHI
00570  122E             
00571  122E             EXITSETMEMPIXEL 
00572  122E  60                    RTS
00573  122F             ;===============================================================================
00574  122F             ; COMMAND HANDLER: FILL 20*6 CHARACTER GRID WITH SPACE OR SAME CHARACTER
00575  122F             ;===============================================================================
00576  122F             
00577  122F             CLEARGRID206 
00578  122F  A9 20                 LDA KEYSPACE
00579  1231  4C 37 12              JMP CPYCHARGRID206
00580  1234             
00581  1234             FILLGRID206 
00582  1234  AD 01 56              LDA EDITINGCHAR
00583  1237             
00584  1237             CPYCHARGRID206 
00585  1237  A2 00                 LDX #$00
00586  1239             
00587  1239             NEXTGRIDPOS 
00588  1239  9D B9 05              STA SCRNGRIDHOME,X
00589  123C  9D E1 05              STA SCRNGRIDHOME+$28,X
00590  123F  9D 09 06              STA SCRNGRIDHOME+$50,X
00591  1242  9D 31 06              STA SCRNGRIDHOME+$78,X
00592  1245  9D 59 06              STA SCRNGRIDHOME+$A0,X
00593  1248  9D 81 06              STA SCRNGRIDHOME+$C8,X
00594  124B  E8                    INX
00595  124C  E0 14                 CPX #$14
00596  124E  D0 E9                 BNE NEXTGRIDPOS
00597  1250  60                    RTS
00598  1251             ;===============================================================================
00599  1251             ; SCROLL EDITING CHARACTER COMMANDS
00600  1251             ;===============================================================================
00601  1251             
00602  1251             ;
00603  1251             ; COMMAND HANDLER : SCROLL EDITING CHARACTER UP
00604  1251             ;
00605  1251             SCROLLCHARUP 
00606  1251  A5 A8                 LDA CHARMEMPOSLO
00607  1253  8D 6E 12              STA DATAIDX3+1
00608  1256  8D 79 12              STA DATAIDX4+1
00609  1259  8D 7C 12              STA DATAIDX5+1
00610  125C  8D 98 12              STA DATAIDX6+1
00611  125F  A5 A9                 LDA CHARMEMPOSHI
00612  1261  8D 6F 12              STA DATAIDX3+2
00613  1264  8D 7A 12              STA DATAIDX4+2
00614  1267  8D 7D 12              STA DATAIDX5+2
00615  126A  8D 99 12              STA DATAIDX6+2
00616  126D             
00617  126D             DATAIDX3
00618  126D  AD 00 30              LDA CHARMEMBASE
00619  1270  8D 0A 56              STA CHARSCROLLSAVE
00620  1273  EE 79 12              INC DATAIDX4+1
00621  1276             
00622  1276  A2 00                 LDX #$00
00623  1278             
00624  1278             DATAIDX4
00625  1278  BD 01 30              LDA CHARMEMBASE+1,X
00626  127B             
00627  127B             DATAIDX5
00628  127B  9D 00 30              STA CHARMEMBASE,X
00629  127E  E8                    INX
00630  127F  E0 07                 CPX #$07
00631  1281  D0 F5                 BNE DATAIDX4
00632  1283             
00633  1283  18                    CLC
00634  1284  AD 98 12              LDA DATAIDX6+1
00635  1287  69 07                 ADC #$07
00636  1289  8D 98 12              STA DATAIDX6+1
00637  128C  AD 99 12              LDA DATAIDX6+2
00638  128F  69 00                 ADC #$00
00639  1291  8D 99 12              STA DATAIDX6+2
00640  1294  AD 0A 56              LDA CHARSCROLLSAVE
00641  1297             
00642  1297             DATAIDX6
00643  1297  8D 07 30              STA CHARMEMBASE+7
00644  129A  60                    RTS
00645  129B             
00646  129B             ;
00647  129B             ; COMMAND HANDLER : SCROLL EDITING CHARACTER DOWN
00648  129B             ;
00649  129B             SCROLLCHARDOWN 
00650  129B  A5 A8                 LDA CHARMEMPOSLO
00651  129D  8D C9 12              STA DATAIDX9+1
00652  12A0  8D D4 12              STA DATAIDX10+1
00653  12A3  8D D7 12              STA DATAIDX11+1
00654  12A6  8D E0 12              STA DATAIDX12+1
00655  12A9  A5 A9                 LDA CHARMEMPOSHI
00656  12AB  8D CA 12              STA DATAIDX9+2
00657  12AE  8D D5 12              STA DATAIDX10+2
00658  12B1  8D D8 12              STA DATAIDX11+2
00659  12B4  8D E1 12              STA DATAIDX12+2
00660  12B7  18                    CLC
00661  12B8  AD C9 12              LDA DATAIDX9+1
00662  12BB  69 07                 ADC #$07
00663  12BD  8D C9 12              STA DATAIDX9+1
00664  12C0  AD CA 12              LDA DATAIDX9+2
00665  12C3  69 00                 ADC #$00
00666  12C5  8D CA 12              STA DATAIDX9+2
00667  12C8             
00668  12C8             DATAIDX9
00669  12C8  AD 07 30              LDA CHARMEMBASE+7
00670  12CB  8D 0A 56              STA CHARSCROLLSAVE
00671  12CE  EE D7 12              INC DATAIDX11+1
00672  12D1             
00673  12D1  A2 06                 LDX #$06
00674  12D3             
00675  12D3             DATAIDX10
00676  12D3  BD 00 30              LDA CHARMEMBASE,X
00677  12D6             
00678  12D6             DATAIDX11
00679  12D6  9D 01 30              STA CHARMEMBASE+1,X
00680  12D9  CA                    DEX
00681  12DA  10 F7                 BPL DATAIDX10
00682  12DC             
00683  12DC  AD 0A 56              LDA CHARSCROLLSAVE
00684  12DF             
00685  12DF             DATAIDX12
00686  12DF  8D 00 30              STA CHARMEMBASE
00687  12E2  60                    RTS
00688  12E3             
00689  12E3             ;
00690  12E3             ; COMMAND HANDLER : SCROLL EDITING CHARACTER LEFT
00691  12E3             ;
00692  12E3             ALIGN
00693  1300             SCROLLCHARLEFT 
00694  1300  A9 29                 LDA #<EDITGRIDHOME
00695  1302  85 B8                 STA WORKGRIDPOSLO
00696  1304  A9 04                 LDA #>EDITGRIDHOME
00697  1306  85 B9                 STA WORKGRIDPOSHI
00698  1308             
00699  1308  A2 00                 LDX #$00
00700  130A  A0 00                 LDY #$00
00701  130C             
00702  130C             LOOP16
00703  130C  B1 B8                 LDA (WORKGRIDPOSLO),Y
00704  130E  9D 2B 56              STA WORKINGCHAR,X
00705  1311  18                    CLC
00706  1312  A5 B8                 LDA WORKGRIDPOSLO
00707  1314  69 28                 ADC #$28
00708  1316  85 B8                 STA WORKGRIDPOSLO
00709  1318  A5 B9                 LDA WORKGRIDPOSHI
00710  131A  69 00                 ADC #$00
00711  131C  85 B9                 STA WORKGRIDPOSHI
00712  131E  E8                    INX
00713  131F  E0 08                 CPX #$08
00714  1321  D0 E9                 BNE LOOP16
00715  1323             
00716  1323  A0 00                 LDY #$00
00717  1325             
00718  1325             LOOP17
00719  1325  A2 00                 LDX #$00
00720  1327             
00721  1327             DATAIDX22
00722  1327  BD 2A 04              LDA EDITGRIDHOME+1,X
00723  132A             
00724  132A             DATAIDX23
00725  132A  9D 29 04              STA EDITGRIDHOME,X
00726  132D  E8                    INX
00727  132E  E0 07                 CPX #$07
00728  1330  D0 F5                 BNE DATAIDX22
00729  1332             
00730  1332  18                    CLC
00731  1333  AD 28 13              LDA DATAIDX22+1
00732  1336  69 28                 ADC #$28
00733  1338  8D 28 13              STA DATAIDX22+1
00734  133B  AD 29 13              LDA DATAIDX22+2
00735  133E  69 00                 ADC #$00
00736  1340  8D 29 13              STA DATAIDX22+2
00737  1343  18                    CLC
00738  1344  AD 2B 13              LDA DATAIDX23+1
00739  1347  69 28                 ADC #$28
00740  1349  8D 2B 13              STA DATAIDX23+1
00741  134C  AD 2C 13              LDA DATAIDX23+2
00742  134F  69 00                 ADC #$00
00743  1351  8D 2C 13              STA DATAIDX23+2
00744  1354  C8                    INY
00745  1355  C0 08                 CPY #$08
00746  1357  D0 CC                 BNE LOOP17
00747  1359             
00748  1359  A9 30                 LDA #<EDITGRIDHOME+7
00749  135B  85 B8                 STA WORKGRIDPOSLO
00750  135D  A9 04                 LDA #>EDITGRIDHOME
00751  135F  85 B9                 STA WORKGRIDPOSHI
00752  1361             
00753  1361  A2 00                 LDX #$00
00754  1363  A0 00                 LDY #$00
00755  1365             
00756  1365             LOOP18
00757  1365  BD 2B 56              LDA WORKINGCHAR,X
00758  1368  91 B8                 STA (WORKGRIDPOSLO),Y
00759  136A  18                    CLC
00760  136B  A5 B8                 LDA WORKGRIDPOSLO
00761  136D  69 28                 ADC #$28
00762  136F  85 B8                 STA WORKGRIDPOSLO
00763  1371  A5 B9                 LDA WORKGRIDPOSHI
00764  1373  69 00                 ADC #$00
00765  1375  85 B9                 STA WORKGRIDPOSHI
00766  1377  E8                    INX
00767  1378  E0 08                 CPX #$08
00768  137A  D0 E9                 BNE LOOP18
00769  137C             
00770  137C  20 CC 11              JSR STOREDITGRID
00771  137F             
00772  137F  A9 2A                 LDA #<EDITGRIDHOME+1
00773  1381  8D 28 13              STA DATAIDX22+1
00774  1384  A9 29                 LDA #<EDITGRIDHOME
00775  1386  8D 2B 13              STA DATAIDX23+1
00776  1389  A9 04                 LDA #>EDITGRIDHOME
00777  138B  8D 29 13              STA DATAIDX22+2
00778  138E  8D 2C 13              STA DATAIDX23+2
00779  1391  60                    RTS
00780  1392             
00781  1392             ;
00782  1392             ; COMMAND HANDLER : SCROLL EDITING CHARACTER RIGHT
00783  1392             ;
00784  1392             ALIGN
00785  1400             SCROLLCHARRIGHT 
00786  1400  A9 30                 LDA #<EDITGRIDHOME+7
00787  1402  85 B8                 STA WORKGRIDPOSLO
00788  1404  A9 04                 LDA #>EDITGRIDHOME
00789  1406  85 B9                 STA WORKGRIDPOSHI
00790  1408             
00791  1408  A2 00                 LDX #$00
00792  140A  A0 00                 LDY #$00
00793  140C             
00794  140C             LOOP3
00795  140C  B1 B8                 LDA (WORKGRIDPOSLO),Y
00796  140E  9D 2B 56              STA WORKINGCHAR,X
00797  1411  18                    CLC
00798  1412  A5 B8                 LDA WORKGRIDPOSLO
00799  1414  69 28                 ADC #$28
00800  1416  85 B8                 STA WORKGRIDPOSLO
00801  1418  A5 B9                 LDA WORKGRIDPOSHI
00802  141A  69 00                 ADC #$00
00803  141C  85 B9                 STA WORKGRIDPOSHI
00804  141E  E8                    INX
00805  141F  E0 08                 CPX #$08
00806  1421  D0 E9                 BNE LOOP3
00807  1423             
00808  1423  A0 00                 LDY #$00
00809  1425             
00810  1425             LOOP4
00811  1425  A2 06                 LDX #$06
00812  1427             
00813  1427             DATAIDX26
00814  1427  BD 29 04              LDA EDITGRIDHOME,X
00815  142A             
00816  142A             DATAIDX27
00817  142A  9D 2A 04              STA EDITGRIDHOME+1,X
00818  142D  CA                    DEX
00819  142E  10 F7                 BPL DATAIDX26
00820  1430             
00821  1430  EA                    NOP
00822  1431  EA                    NOP
00823  1432  18                    CLC
00824  1433  AD 28 14              LDA DATAIDX26+1
00825  1436  69 28                 ADC #$28
00826  1438  8D 28 14              STA DATAIDX26+1
00827  143B  AD 29 14              LDA DATAIDX26+2
00828  143E  69 00                 ADC #$00
00829  1440  8D 29 14              STA DATAIDX26+2
00830  1443  18                    CLC
00831  1444  AD 2B 14              LDA DATAIDX27+1
00832  1447  69 28                 ADC #$28
00833  1449  8D 2B 14              STA DATAIDX27+1
00834  144C  AD 2C 14              LDA DATAIDX27+2
00835  144F  69 00                 ADC #$00
00836  1451  8D 2C 14              STA DATAIDX27+2
00837  1454  C8                    INY
00838  1455  C0 08                 CPY #$08
00839  1457  D0 CC                 BNE LOOP4
00840  1459             
00841  1459  A9 29                 LDA #<EDITGRIDHOME
00842  145B  85 B8                 STA WORKGRIDPOSLO
00843  145D  A9 04                 LDA #>EDITGRIDHOME
00844  145F  85 B9                 STA WORKGRIDPOSHI
00845  1461             
00846  1461  A2 00                 LDX #$00
00847  1463  A0 00                 LDY #$00
00848  1465             
00849  1465             LOOP5
00850  1465  BD 2B 56              LDA WORKINGCHAR,X
00851  1468  91 B8                 STA (WORKGRIDPOSLO),Y
00852  146A  18                    CLC
00853  146B  A5 B8                 LDA WORKGRIDPOSLO
00854  146D  69 28                 ADC #$28
00855  146F  85 B8                 STA WORKGRIDPOSLO
00856  1471  A5 B9                 LDA WORKGRIDPOSHI
00857  1473  69 00                 ADC #$00
00858  1475  85 B9                 STA WORKGRIDPOSHI
00859  1477  E8                    INX
00860  1478  E0 08                 CPX #$08
00861  147A  D0 E9                 BNE LOOP5
00862  147C             
00863  147C  20 CC 11              JSR STOREDITGRID
00864  147F             
00865  147F  A9 29                 LDA #<EDITGRIDHOME
00866  1481  8D 28 14              STA DATAIDX26+1
00867  1484  A9 2A                 LDA #<EDITGRIDHOME+1
00868  1486  8D 2B 14              STA DATAIDX27+1
00869  1489  A9 04                 LDA #>EDITGRIDHOME
00870  148B  8D 29 14              STA DATAIDX26+2
00871  148E  8D 2C 14              STA DATAIDX27+2
00872  1491  60                    RTS
00873  1492             ;===============================================================================
00874  1492             ; TRANSFER MODE COMMANDS
00875  1492             ;===============================================================================
00876  1492             
00877  1492             ;
00878  1492             ; COMMAND HANDLER : SELECT NEXT CHARACTER IN CHARACTER SET
00879  1492             ;
00880  1492             SELECTNEXTCHR 
00881  1492  A5 BA                 LDA CHARSETPOSLO
00882  1494  C9 DC                 CMP #<CHARSETEND
00883  1496  D0 21                 BNE MOVENEXTCHR
00884  1498             
00885  1498  A5 BB                 LDA CHARSETPOSHI
00886  149A  C9 07                 CMP #>CHARSETEND
00887  149C  D0 1B                 BNE MOVENEXTCHR
00888  149E             
00889  149E  A9 D1                 LDA #<CHARSETHOME
00890  14A0  85 BA                 STA CHARSETPOSLO
00891  14A2  A9 06                 LDA #>CHARSETHOME
00892  14A4  85 BB                 STA CHARSETPOSHI
00893  14A6             
00894  14A6  A2 00                 LDX #$00
00895  14A8  AD 01 56              LDA EDITINGCHAR
00896  14AB  81 BA                 STA (CHARSETPOSLO,X)
00897  14AD  A9 00                 LDA #$00
00898  14AF  85 A8                 STA CHARMEMPOSLO
00899  14B1  8D 01 56              STA EDITINGCHAR
00900  14B4  A9 30                 LDA #>CHARMEMBASE
00901  14B6  85 A9                 STA CHARMEMPOSHI
00902  14B8  60                    RTS
00903  14B9             
00904  14B9             MOVENEXTCHR 
00905  14B9  A2 00                 LDX #$00
00906  14BB             
00907  14BB             LOOP13
00908  14BB  A5 BA                 LDA CHARSETPOSLO
00909  14BD             
00910  14BD             DATAIDX17
00911  14BD  C9 F6                 CMP #$F6
00912  14BF  D0 11                 BNE JMP21
00913  14C1             
00914  14C1  A5 BB                 LDA CHARSETPOSHI
00915  14C3             
00916  14C3             DATAIDX18
00917  14C3  C9 06                 CMP #$06
00918  14C5  D0 0B                 BNE JMP21
00919  14C7             
00920  14C7  A9 F6                 LDA #$F6
00921  14C9  8D BE 14              STA DATAIDX17+1
00922  14CC  A9 06                 LDA #$06
00923  14CE  8D C4 14              STA DATAIDX18+1
00924  14D1  60                    RTS
00925  14D2             
00926  14D2             JMP21
00927  14D2  18                    CLC
00928  14D3  AD BE 14              LDA DATAIDX17+1
00929  14D6  69 28                 ADC #$28
00930  14D8  8D BE 14              STA DATAIDX17+1
00931  14DB  AD C4 14              LDA DATAIDX18+1
00932  14DE  69 00                 ADC #$00
00933  14E0  8D C4 14              STA DATAIDX18+1
00934  14E3  E8                    INX
00935  14E4  E0 08                 CPX #$08
00936  14E6  D0 D3                 BNE LOOP13
00937  14E8             
00938  14E8  A2 00                 LDX #$00
00939  14EA  AD 01 56              LDA EDITINGCHAR
00940  14ED  81 BA                 STA (CHARSETPOSLO,X)
00941  14EF  A9 F6                 LDA #$F6
00942  14F1  8D BE 14              STA DATAIDX17+1
00943  14F4  A9 06                 LDA #$06
00944  14F6  8D C4 14              STA DATAIDX18+1
00945  14F9  18                    CLC
00946  14FA  A5 BA                 LDA CHARSETPOSLO
00947  14FC  69 01                 ADC #$01
00948  14FE  85 BA                 STA CHARSETPOSLO
00949  1500  A5 BB                 LDA CHARSETPOSHI
00950  1502  69 00                 ADC #$00
00951  1504  85 BB                 STA CHARSETPOSHI
00952  1506  18                    CLC
00953  1507  A5 A8                 LDA CHARMEMPOSLO
00954  1509  69 08                 ADC #$08
00955  150B  85 A8                 STA CHARMEMPOSLO
00956  150D  A5 A9                 LDA CHARMEMPOSHI
00957  150F  69 00                 ADC #$00
00958  1511  85 A9                 STA CHARMEMPOSHI
00959  1513  EE 01 56              INC EDITINGCHAR
00960  1516  60                    RTS
00961  1517             
00962  1517             ;
00963  1517             ; COMMAND HANDLER : SELECT PREVIOUS CHARACTER IN CHARACTER SET
00964  1517             ;
00965  1517             ALIGN
00966  1600             SELECTPREVCHR 
00967  1600  A5 BA                 LDA CHARSETPOSLO ; AT START OF CHARACTER MAP?
00968  1602  C9 D1                 CMP #<CHARSETHOME
00969  1604  D0 23                 BNE JMP22
00970  1606             
00971  1606  A5 BB                 LDA CHARSETPOSHI
00972  1608  C9 06                 CMP #>CHARSETHOME
00973  160A  D0 1D                 BNE JMP22
00974  160C             
00975  160C  A9 DC                 LDA #<CHARSETEND        ; AT BEGINNING SO WRAP TO END OF CHARACTERS $07DC ON SCREEN
00976  160E  85 BA                 STA CHARSETPOSLO
00977  1610  A9 07                 LDA #>CHARSETEND
00978  1612  85 BB                 STA CHARSETPOSHI
00979  1614  A2 00                 LDX #$00
00980  1616  AD 01 56              LDA EDITINGCHAR
00981  1619  81 BA                 STA (CHARSETPOSLO,X)
00982  161B  A9 FF                 LDA #$FF                ; EDITING LAST CHAR - $FF
00983  161D  8D 01 56              STA EDITINGCHAR
00984  1620  A9 F8                 LDA #<CHARMEMEND
00985  1622  85 A8                 STA CHARMEMPOSLO
00986  1624  A9 37                 LDA #>CHARMEMEND
00987  1626  85 A9                 STA CHARMEMPOSHI
00988  1628  60                    RTS
00989  1629             
00990  1629             JMP22
00991  1629  A2 00                 LDX #$00
00992  162B             
00993  162B             LOOP14
00994  162B  A5 BA                 LDA CHARSETPOSLO        ; START OF A ROW POSITION INSTEAD?
00995  162D             
00996  162D             DATAIDX19
00997  162D  C9 D1                 CMP #<CHARSETHOME
00998  162F  D0 11                 BNE JMP23
00999  1631             
01000  1631  A5 BB                 LDA CHARSETPOSHI
01001  1633             
01002  1633             DATAIDX20
01003  1633  C9 06                 CMP #>CHARSETHOME
01004  1635  D0 0B                 BNE JMP23
01005  1637             
01006  1637  A9 D1                 LDA #<CHARSETHOME       ; RESET POSITION COMPARISON TO BEGINNING OF SCREEN CHAR MAP
01007  1639  8D 2E 16              STA DATAIDX19+1
01008  163C  A9 06                 LDA #>CHARSETHOME
01009  163E  8D 34 16              STA DATAIDX20+1
01010  1641  60                    RTS
01011  1642             
01012  1642             JMP23
01013  1642  18                    CLC
01014  1643  AD 2E 16              LDA DATAIDX19+1
01015  1646  69 28                 ADC #$28
01016  1648  8D 2E 16              STA DATAIDX19+1
01017  164B  AD 34 16              LDA DATAIDX20+1
01018  164E  69 00                 ADC #$00
01019  1650  8D 34 16              STA DATAIDX20+1
01020  1653  E8                    INX
01021  1654  E0 08                 CPX #$08
01022  1656  D0 D3                 BNE LOOP14
01023  1658             
01024  1658  A2 00                 LDX #$00
01025  165A  AD 01 56              LDA EDITINGCHAR
01026  165D  81 BA                 STA (CHARSETPOSLO,X)
01027  165F  A9 D1                 LDA #<CHARSETHOME
01028  1661  8D 2E 16              STA DATAIDX19+1
01029  1664  A9 06                 LDA #>CHARSETHOME
01030  1666  8D 34 16              STA DATAIDX20+1
01031  1669  38                    SEC
01032  166A  A5 BA                 LDA CHARSETPOSLO
01033  166C  E9 01                 SBC #$01
01034  166E  85 BA                 STA CHARSETPOSLO
01035  1670  A5 BB                 LDA CHARSETPOSHI
01036  1672  E9 00                 SBC #$00
01037  1674  85 BB                 STA CHARSETPOSHI
01038  1676  38                    SEC
01039  1677  A5 A8                 LDA CHARMEMPOSLO
01040  1679  E9 08                 SBC #$08
01041  167B  85 A8                 STA CHARMEMPOSLO
01042  167D  A5 A9                 LDA CHARMEMPOSHI
01043  167F  E9 00                 SBC #$00
01044  1681  85 A9                 STA CHARMEMPOSHI
01045  1683  CE 01 56              DEC EDITINGCHAR
01046  1686  60                    RTS
01047  1687             
01048  1687             ;
01049  1687             ; COMMAND HANDLER : MOVE UP A LINE IN CHARACTER SET
01050  1687             ;
01051  1687             MOVEUPALINE 
01052  1687  A2 00                 LDX #$00
01053  1689             
01054  1689             LOOP15
01055  1689  A5 BA                 LDA CHARSETPOSLO
01056  168B             
01057  168B             DATAIDX21
01058  168B  C9 D1                 CMP #<CHARSETHOME
01059  168D  D0 0C                 BNE JMP24
01060  168F             
01061  168F  A5 BB                 LDA CHARSETPOSHI
01062  1691  C9 06                 CMP #>CHARSETHOME
01063  1693  D0 06                 BNE JMP24
01064  1695             
01065  1695  A9 D1                 LDA #<CHARSETHOME
01066  1697  8D 8C 16              STA DATAIDX21+1
01067  169A  60                    RTS
01068  169B             
01069  169B             JMP24
01070  169B  EE 8C 16              INC DATAIDX21+1
01071  169E  E8                    INX
01072  169F  E0 26                 CPX #$26
01073  16A1  D0 E6                 BNE LOOP15
01074  16A3             
01075  16A3  A9 D1                 LDA #<CHARSETHOME
01076  16A5  8D 8C 16              STA DATAIDX21+1
01077  16A8  AD 01 56              LDA EDITINGCHAR
01078  16AB  A2 00                 LDX #$00
01079  16AD  81 BA                 STA (CHARSETPOSLO,X)
01080  16AF  38                    SEC
01081  16B0  A5 BA                 LDA CHARSETPOSLO
01082  16B2  E9 28                 SBC #$28
01083  16B4  85 BA                 STA CHARSETPOSLO
01084  16B6  A5 BB                 LDA CHARSETPOSHI
01085  16B8  E9 00                 SBC #$00
01086  16BA  85 BB                 STA CHARSETPOSHI
01087  16BC  38                    SEC
01088  16BD  AD 01 56              LDA EDITINGCHAR
01089  16C0  E9 26                 SBC #$26
01090  16C2  8D 01 56              STA EDITINGCHAR
01091  16C5  38                    SEC
01092  16C6  A5 A8                 LDA CHARMEMPOSLO
01093  16C8  E9 30                 SBC #$30
01094  16CA  85 A8                 STA CHARMEMPOSLO
01095  16CC  A5 A9                 LDA CHARMEMPOSHI
01096  16CE  E9 01                 SBC #$01
01097  16D0  85 A9                 STA CHARMEMPOSHI
01098  16D2  60                    RTS
01099  16D3             
01100  16D3             ;
01101  16D3             ; COMMAND HANDLER : MOVE DOWN A LINE IN CHARACTER SET
01102  16D3             ;
01103  16D3             ALIGN
01104  1700             MOVEDOWNALINE 
01105  1700  A2 00                 LDX #$00
01106  1702             
01107  1702             LOOP1
01108  1702  A5 BA                 LDA CHARSETPOSLO
01109  1704             
01110  1704             DATAIDX24
01111  1704  C9 B5                 CMP #$B5
01112  1706  D0 0C                 BNE JMP20
01113  1708             
01114  1708  A5 BB                 LDA CHARSETPOSHI
01115  170A  C9 07                 CMP #$07
01116  170C  D0 06                 BNE JMP20
01117  170E             
01118  170E  A9 B5                 LDA #$B5
01119  1710  8D 05 17              STA DATAIDX24+1
01120  1713  60                    RTS
01121  1714             
01122  1714             JMP20
01123  1714  EE 05 17              INC DATAIDX24+1
01124  1717  E8                    INX
01125  1718  E0 0A                 CPX #$0A
01126  171A  D0 E6                 BNE LOOP1
01127  171C             
01128  171C  A9 B5                 LDA #$B5
01129  171E  8D 05 17              STA DATAIDX24+1
01130  1721  A2 00                 LDX #$00
01131  1723             
01132  1723             LOOP2
01133  1723  A5 BA                 LDA CHARSETPOSLO
01134  1725             
01135  1725             DATAIDX25
01136  1725  C9 C1                 CMP #$C1
01137  1727  D0 0C                 BNE JMP25
01138  1729             
01139  1729  A5 BB                 LDA CHARSETPOSHI
01140  172B  C9 07                 CMP #$07
01141  172D  D0 06                 BNE JMP25
01142  172F             
01143  172F  A9 C1                 LDA #$C1
01144  1731  8D 26 17              STA DATAIDX25+1
01145  1734  60                    RTS
01146  1735             
01147  1735             JMP25
01148  1735  EE 26 17              INC DATAIDX25+1
01149  1738  E8                    INX
01150  1739  E0 26                 CPX #$26
01151  173B  D0 E6                 BNE LOOP2
01152  173D             
01153  173D  A9 C1                 LDA #$C1
01154  173F  8D 26 17              STA DATAIDX25+1
01155  1742  AD 01 56              LDA EDITINGCHAR
01156  1745  A2 00                 LDX #$00
01157  1747  81 BA                 STA (CHARSETPOSLO,X)
01158  1749  18                    CLC
01159  174A  A5 BA                 LDA CHARSETPOSLO
01160  174C  69 28                 ADC #$28
01161  174E  85 BA                 STA CHARSETPOSLO
01162  1750  A5 BB                 LDA CHARSETPOSHI
01163  1752  69 00                 ADC #$00
01164  1754  85 BB                 STA CHARSETPOSHI
01165  1756  18                    CLC
01166  1757  AD 01 56              LDA EDITINGCHAR
01167  175A  69 26                 ADC #$26
01168  175C  8D 01 56              STA EDITINGCHAR
01169  175F  18                    CLC
01170  1760  A5 A8                 LDA CHARMEMPOSLO
01171  1762  69 30                 ADC #$30
01172  1764  85 A8                 STA CHARMEMPOSLO
01173  1766  A5 A9                 LDA CHARMEMPOSHI
01174  1768  69 01                 ADC #$01
01175  176A  85 A9                 STA CHARMEMPOSHI
01176  176C  60                    RTS
01177  176D             ;===============================================================================
01178  176D             ; CLEAR PIXELS OF EDITING CHARACTER
01179  176D             ;===============================================================================
01180  176D             
01181  176D             CLEARGRID88 
01182  176D  A9 29                 LDA #<EDITGRIDHOME
01183  176F  85 B8                 STA WORKGRIDPOSLO
01184  1771  A9 04                 LDA #>EDITGRIDHOME
01185  1773  85 B9                 STA WORKGRIDPOSHI
01186  1775             
01187  1775  A0 00                 LDY #$00
01188  1777  A9 00                 LDA #$00
01189  1779             
01190  1779             LOOPZEROCOL 
01191  1779  91 A8                 STA (CHARMEMPOSLO),Y
01192  177B  C8                    INY
01193  177C  C0 08                 CPY #$08
01194  177E  D0 F9                 BNE LOOPZEROCOL
01195  1780             
01196  1780  A2 00                 LDX #$00
01197  1782             
01198  1782             NEXTZEROROW 
01199  1782  8A                    TXA
01200  1783  48                    PHA
01201  1784  20 8F 17              JSR CLEARCHARROW
01202  1787  68                    PLA
01203  1788  AA                    TAX
01204  1789  E8                    INX
01205  178A  E0 08                 CPX #$08
01206  178C  D0 F4                 BNE NEXTZEROROW
01207  178E  60                    RTS
01208  178F             
01209  178F             CLEARCHARROW 
01210  178F  A0 00                 LDY #$00
01211  1791  A9 20                 LDA KEYSPACE
01212  1793             
01213  1793             LOOPCLRCOL 
01214  1793  91 B8                 STA (WORKGRIDPOSLO),Y
01215  1795  C8                    INY
01216  1796  C0 08                 CPY #$08
01217  1798  D0 F9                 BNE LOOPCLRCOL
01218  179A             
01219  179A  18                    CLC
01220  179B  A5 B8                 LDA WORKGRIDPOSLO
01221  179D  69 28                 ADC #$28
01222  179F  85 B8                 STA WORKGRIDPOSLO
01223  17A1  A5 B9                 LDA WORKGRIDPOSHI
01224  17A3  69 00                 ADC #$00
01225  17A5  85 B9                 STA WORKGRIDPOSHI
01226  17A7  60                    RTS
01227  17A8             ;===============================================================================
01228  17A8             ; MIRROR EDITING CHARACTER COMMANDS
01229  17A8             ;===============================================================================
01230  17A8             
01231  17A8             ;
01232  17A8             ; COMMAND HANDLER : MIRROR EDITING CHARACTER UP/DOWN (HORIZONTAL)
01233  17A8             ;
01234  17A8             ALIGN
01235  1800             MIRRORCHARHORZ 
01236  1800  A9 29                 LDA #<EDITGRIDHOME
01237  1802  85 B8                 STA WORKGRIDPOSLO
01238  1804  A9 04                 LDA #>EDITGRIDHOME
01239  1806  85 B9                 STA WORKGRIDPOSHI
01240  1808             
01241  1808  A2 00                 LDX #$00
01242  180A             
01243  180A             LOOP22
01244  180A  A0 00                 LDY #$00
01245  180C             
01246  180C             LOOP21
01247  180C  B1 B8                 LDA (WORKGRIDPOSLO),Y
01248  180E             
01249  180E             DATAIDX28
01250  180E  99 2B 56              STA WORKINGCHAR,Y
01251  1811  C8                    INY
01252  1812  C0 08                 CPY #$08
01253  1814  D0 F6                 BNE LOOP21
01254  1816             
01255  1816  18                    CLC
01256  1817  AD 0F 18              LDA DATAIDX28+1
01257  181A  69 08                 ADC #$08
01258  181C  8D 0F 18              STA DATAIDX28+1
01259  181F  18                    CLC
01260  1820  A5 B8                 LDA WORKGRIDPOSLO
01261  1822  69 28                 ADC #$28
01262  1824  85 B8                 STA WORKGRIDPOSLO
01263  1826  A5 B9                 LDA WORKGRIDPOSHI
01264  1828  69 00                 ADC #$00
01265  182A  85 B9                 STA WORKGRIDPOSHI
01266  182C  E8                    INX
01267  182D  E0 08                 CPX #$08
01268  182F  D0 D9                 BNE LOOP22
01269  1831             
01270  1831  A2 00                 LDX #$00
01271  1833             
01272  1833             LOOP24
01273  1833  BD 6B 56              LDA EDITGRIDTOPROWFWDLO,X
01274  1836  85 B8                 STA WORKGRIDPOSLO
01275  1838  A9 04                 LDA #$04
01276  183A  85 B9                 STA WORKGRIDPOSHI
01277  183C  BD 83 56              LDA WORKINGCHARTOPROWREVLO,X
01278  183F  8D 49 18              STA DATAIDX29+1
01279  1842  A0 00                 LDY #$00
01280  1844             
01281  1844             LOOP23
01282  1844  98                    TYA
01283  1845  48                    PHA
01284  1846  A0 00                 LDY #$00
01285  1848             
01286  1848             DATAIDX29
01287  1848  AD 32 56              LDA WORKINGCHAR+7
01288  184B  91 B8                 STA (WORKGRIDPOSLO),Y
01289  184D  68                    PLA
01290  184E  A8                    TAY
01291  184F  18                    CLC
01292  1850  AD 49 18              LDA DATAIDX29+1
01293  1853  69 08                 ADC #$08
01294  1855  8D 49 18              STA DATAIDX29+1
01295  1858  18                    CLC
01296  1859  A5 B8                 LDA WORKGRIDPOSLO
01297  185B  69 28                 ADC #$28
01298  185D  85 B8                 STA WORKGRIDPOSLO
01299  185F  A5 B9                 LDA WORKGRIDPOSHI
01300  1861  69 00                 ADC #$00
01301  1863  85 B9                 STA WORKGRIDPOSHI
01302  1865  C8                    INY
01303  1866  C0 08                 CPY #$08
01304  1868  D0 DA                 BNE LOOP23
01305  186A             
01306  186A  E8                    INX
01307  186B  E0 08                 CPX #$08
01308  186D  D0 C4                 BNE LOOP24
01309  186F             
01310  186F  A9 2B                 LDA #<WORKINGCHAR
01311  1871  8D 0F 18              STA DATAIDX28+1
01312  1874  A9 32                 LDA #<WORKINGCHAR+7
01313  1876  8D 49 18              STA DATAIDX29+1
01314  1879             
01315  1879  20 CC 11              JSR STOREDITGRID
01316  187C  60                    RTS
01317  187D             
01318  187D             ;
01319  187D             ; COMMAND HANDLER : MIRROR EDITING CHARACTER LEFT/RIGHT (VERTICAL)
01320  187D             ;
01321  187D             MIRRORCHARVERT 
01322  187D  A9 29                 LDA #<EDITGRIDHOME
01323  187F  85 B8                 STA WORKGRIDPOSLO
01324  1881  A9 04                 LDA #>EDITGRIDHOME
01325  1883  85 B9                 STA WORKGRIDPOSHI
01326  1885             
01327  1885  A2 00                 LDX #$00
01328  1887             
01329  1887             NEXTMIRRORCHAR 
01330  1887  A0 00                 LDY #$00
01331  1889             
01332  1889             SAVEMIRRORVARS 
01333  1889  B1 B8                 LDA (WORKGRIDPOSLO),Y
01334  188B             
01335  188B             DATAIDX30
01336  188B  99 2B 56              STA WORKINGCHAR,Y
01337  188E  C8                    INY
01338  188F  C0 08                 CPY #$08
01339  1891  D0 F6                 BNE SAVEMIRRORVARS
01340  1893             
01341  1893  18                    CLC
01342  1894  AD 8C 18              LDA DATAIDX30+1
01343  1897  69 08                 ADC #$08
01344  1899  8D 8C 18              STA DATAIDX30+1
01345  189C  18                    CLC
01346  189D  A5 B8                 LDA WORKGRIDPOSLO
01347  189F  69 28                 ADC #$28
01348  18A1  85 B8                 STA WORKGRIDPOSLO
01349  18A3  A5 B9                 LDA WORKGRIDPOSHI
01350  18A5  69 00                 ADC #$00
01351  18A7  85 B9                 STA WORKGRIDPOSHI
01352  18A9  E8                    INX
01353  18AA  E0 08                 CPX #$08
01354  18AC  D0 D9                 BNE NEXTMIRRORCHAR
01355  18AE             
01356  18AE  A9 2B                 LDA #<WORKINGCHAR
01357  18B0  8D 8C 18              STA DATAIDX30+1
01358  18B3  A9 41                 LDA #$41                ; LINE 8 OF 8*8 EDITING GRID
01359  18B5  85 B8                 STA WORKGRIDPOSLO
01360  18B7  A9 05                 LDA #$05                ; LINE 8 OF 8*8 EDITING GRID
01361  18B9  85 B9                 STA WORKGRIDPOSHI
01362  18BB             
01363  18BB  A2 00                 LDX #$00
01364  18BD             
01365  18BD             NEXTMIRRORCALC 
01366  18BD  A0 00                 LDY #$00
01367  18BF             
01368  18BF             LOADMIRRORVARS 
01369  18BF  B9 2B 56              LDA WORKINGCHAR,Y
01370  18C2  91 B8                 STA (WORKGRIDPOSLO),Y
01371  18C4  C8                    INY
01372  18C5  C0 08                 CPY #$08
01373  18C7  D0 F6                 BNE LOADMIRRORVARS
01374  18C9             
01375  18C9  38                    SEC
01376  18CA  A5 B8                 LDA WORKGRIDPOSLO
01377  18CC  E9 28                 SBC #$28
01378  18CE  85 B8                 STA WORKGRIDPOSLO
01379  18D0  A5 B9                 LDA WORKGRIDPOSHI
01380  18D2  E9 00                 SBC #$00
01381  18D4  85 B9                 STA WORKGRIDPOSHI
01382  18D6  18                    CLC
01383  18D7  AD C0 18              LDA LOADMIRRORVARS+1
01384  18DA  69 08                 ADC #$08
01385  18DC  8D C0 18              STA LOADMIRRORVARS+1
01386  18DF  E8                    INX
01387  18E0  E0 08                 CPX #$08
01388  18E2  D0 D9                 BNE NEXTMIRRORCALC
01389  18E4             
01390  18E4  A9 2B                 LDA #<WORKINGCHAR
01391  18E6  8D C0 18              STA LOADMIRRORVARS+1
01392  18E9  20 CC 11              JSR STOREDITGRID
01393  18EC  60                    RTS
01394  18ED             ;===============================================================================
01395  18ED             ; ROTATE EDITING CHARACTER 90 DEGREES
01396  18ED             ;===============================================================================
01397  18ED             
01398  18ED             ALIGN
01399  1900             ROTATECHAR90 
01400  1900  A9 29                 LDA #<EDITGRIDHOME
01401  1902  85 B8                 STA WORKGRIDPOSLO
01402  1904  A9 04                 LDA #>EDITGRIDHOME
01403  1906  85 B9                 STA WORKGRIDPOSHI
01404  1908             
01405  1908  A2 00                 LDX #$00
01406  190A             
01407  190A             NEXTROTATECHAR 
01408  190A  A0 00                 LDY #$00
01409  190C             
01410  190C             SAVEROTATECHAR 
01411  190C  B1 B8                 LDA (WORKGRIDPOSLO),Y
01412  190E             
01413  190E             DATAIDX31
01414  190E  99 2B 56              STA WORKINGCHAR,Y
01415  1911  C8                    INY
01416  1912  C0 08                 CPY #$08
01417  1914  D0 F6                 BNE SAVEROTATECHAR
01418  1916             
01419  1916  18                    CLC
01420  1917  AD 0F 19              LDA DATAIDX31+1
01421  191A  69 08                 ADC #$08
01422  191C  8D 0F 19              STA DATAIDX31+1
01423  191F             
01424  191F  18                    CLC
01425  1920  A5 B8                 LDA WORKGRIDPOSLO
01426  1922  69 28                 ADC #$28
01427  1924  85 B8                 STA WORKGRIDPOSLO
01428  1926  A5 B9                 LDA WORKGRIDPOSHI
01429  1928  69 00                 ADC #$00
01430  192A  85 B9                 STA WORKGRIDPOSHI
01431  192C             
01432  192C  E8                    INX
01433  192D  E0 08                 CPX #$08
01434  192F  D0 D9                 BNE NEXTROTATECHAR
01435  1931             
01436  1931  A9 2B                 LDA #<WORKINGCHAR
01437  1933  8D 0F 19              STA DATAIDX31+1
01438  1936             
01439  1936  A2 00                 LDX #$00
01440  1938             
01441  1938             LOADROTATECHAR 
01442  1938  BD 73 56              LDA EDITGRIDTOPROWREVLO,X
01443  193B  85 B8                 STA WORKGRIDPOSLO
01444  193D  A9 04                 LDA #>EDITGRIDHOME
01445  193F  85 B9                 STA WORKGRIDPOSHI
01446  1941  BD 7B 56              LDA WORKINGCHARROWSLO,X
01447  1944  8D 4C 19              STA DATAIDX32+1
01448  1947  A0 00                 LDY #$00
01449  1949             
01450  1949             NEXTROTATECALC 
01451  1949  98                    TYA
01452  194A  48                    PHA
01453  194B             
01454  194B             DATAIDX32
01455  194B  B9 2B 56              LDA WORKINGCHAR,Y
01456  194E  A0 00                 LDY #$00
01457  1950  91 B8                 STA (WORKGRIDPOSLO),Y
01458  1952  68                    PLA
01459  1953  A8                    TAY
01460  1954  18                    CLC
01461  1955  A5 B8                 LDA WORKGRIDPOSLO
01462  1957  69 28                 ADC #$28
01463  1959  85 B8                 STA WORKGRIDPOSLO
01464  195B  A5 B9                 LDA WORKGRIDPOSHI
01465  195D  69 00                 ADC #$00
01466  195F  85 B9                 STA WORKGRIDPOSHI
01467  1961  C8                    INY
01468  1962  C0 08                 CPY #$08
01469  1964  D0 E3                 BNE NEXTROTATECALC
01470  1966             
01471  1966  E8                    INX
01472  1967  E0 08                 CPX #$08
01473  1969  D0 CD                 BNE LOADROTATECHAR
01474  196B             
01475  196B  A9 2B                 LDA #<WORKINGCHAR
01476  196D  8D 4C 19              STA DATAIDX32+1
01477  1970             
01478  1970  20 CC 11              JSR STOREDITGRID
01479  1973  60                    RTS
01480  1974             ;===============================================================================
01481  1974             ; TOGGLE TRANSFER MODE ON/OFF AND PROCESS MODE COMMANDS
01482  1974             ;===============================================================================
01483  1974             
01484  1974             TRFRMODETOGGLE 
01485  1974  A2 00                 LDX #$00
01486  1976             
01487  1976             SHOWTRFRMSG 
01488  1976  BD 59 55              LDA DATATRFRMODE,X
01489  1979  9D B0 04              STA MESSAGEAREAADDR+2,X
01490  197C  E8                    INX
01491  197D  E0 0D                 CPX #$0D
01492  197F  D0 F5                 BNE SHOWTRFRMSG
01493  1981             
01494  1981  A5 A8                 LDA CHARMEMPOSLO
01495  1983  85 FB                 STA TEMPSAVE1
01496  1985  A5 A9                 LDA CHARMEMPOSHI
01497  1987  85 FC                 STA TEMPSAVE2
01498  1989             
01499  1989             TRFRMODESTART 
01500  1989  A9 29                 LDA #<EDITGRIDHOME
01501  198B  85 B8                 STA WORKGRIDPOSLO
01502  198D  A9 04                 LDA #>EDITGRIDHOME
01503  198F  85 B9                 STA WORKGRIDPOSHI
01504  1991  A2 00                 LDX #$00
01505  1993             
01506  1993             DRAWNEXTROW 
01507  1993  8A                    TXA
01508  1994  48                    PHA
01509  1995  20 5D 23              JSR DRAWEDITROW
01510  1998  68                    PLA
01511  1999  AA                    TAX
01512  199A  E8                    INX
01513  199B  E0 08                 CPX #$08
01514  199D  D0 F4                 BNE DRAWNEXTROW
01515  199F             
01516  199F  38                    SEC
01517  19A0  A5 A8                 LDA CHARMEMPOSLO
01518  19A2  E9 08                 SBC #$08
01519  19A4  85 A8                 STA CHARMEMPOSLO
01520  19A6  A5 A9                 LDA CHARMEMPOSHI
01521  19A8  E9 00                 SBC #$00
01522  19AA  85 A9                 STA CHARMEMPOSHI
01523  19AC             
01524  19AC             WAITTRFRKEYS 
01525  19AC  20 9F FF              JSR KRNL_SCNKEY
01526  19AF  20 E4 FF              JSR KRNL_GETIN
01527  19B2  C9 00                 CMP #$00
01528  19B4  F0 F6                 BEQ WAITTRFRKEYS
01529  19B6             
01530  19B6  C9 5C                 CMP KEYSTERLING
01531  19B8  F0 2B                 BEQ TRFRMODEOFF
01532  19BA             
01533  19BA  C9 2B                 CMP KEYPLUS
01534  19BC  F0 0F                 BEQ TRFRNEXTCHR
01535  19BE             
01536  19BE  C9 2D                 CMP KEYMINUS
01537  19C0  F0 11                 BEQ TRFRPREVCHR
01538  19C2             
01539  19C2  C9 87                 CMP KEYF5
01540  19C4  F0 13                 BEQ TRFRUPALINE
01541  19C6             
01542  19C6  C9 88                 CMP KEYF7
01543  19C8  F0 15                 BEQ TRFRDOWNALINE
01544  19CA             
01545  19CA  4C AC 19              JMP WAITTRFRKEYS
01546  19CD             
01547  19CD             TRFRNEXTCHR 
01548  19CD  20 92 14              JSR SELECTNEXTCHR
01549  19D0  4C 89 19              JMP TRFRMODESTART
01550  19D3             
01551  19D3             TRFRPREVCHR 
01552  19D3  20 00 16              JSR SELECTPREVCHR
01553  19D6  4C 89 19              JMP TRFRMODESTART
01554  19D9             
01555  19D9             TRFRUPALINE 
01556  19D9  20 87 16              JSR MOVEUPALINE
01557  19DC  4C 89 19              JMP TRFRMODESTART
01558  19DF             
01559  19DF             TRFRDOWNALINE 
01560  19DF  20 00 17              JSR MOVEDOWNALINE
01561  19E2  4C 89 19              JMP TRFRMODESTART
01562  19E5             
01563  19E5             TRFRMODEOFF 
01564  19E5  A0 00                 LDY #$00
01565  19E7             
01566  19E7             LOOPTRFRCHAR 
01567  19E7  B1 FB                 LDA (TEMPSAVE1),Y
01568  19E9  91 A8                 STA (CHARMEMPOSLO),Y
01569  19EB  C8                    INY
01570  19EC  C0 08                 CPY #$08
01571  19EE  D0 F7                 BNE LOOPTRFRCHAR
01572  19F0             
01573  19F0  A2 00                 LDX #$00
01574  19F2  A9 20                 LDA KEYSPACE
01575  19F4             
01576  19F4             CLEARTRFRMSG 
01577  19F4  9D B0 04              STA MESSAGEAREAADDR+2,X
01578  19F7  E8                    INX
01579  19F8  E0 0D                 CPX #$0D
01580  19FA  D0 F8                 BNE CLEARTRFRMSG
01581  19FC  60                    RTS
01582  19FD             ;===============================================================================
01583  19FD             ; SHOW HELP COMMAND
01584  19FD             ;===============================================================================
01585  19FD             
01586  19FD             SHOWHELP
01587  19FD  A9 15                 LDA #$15
01588  19FF  8D 18 D0              STA MEMSETUPREG
01589  1A02  78                    SEI
01590  1A03  A9 31                 LDA #<IRQSVCROUTINE
01591  1A05  8D 14 03              STA IRQSVCLOADDR
01592  1A08  A9 EA                 LDA #>IRQSVCROUTINE
01593  1A0A  8D 15 03              STA IRQSVCHIADDR
01594  1A0D  A9 79                 LDA #$79
01595  1A0F  8D 19 D0              STA IRQSTATUSREG
01596  1A12  A9 F0                 LDA #$F0
01597  1A14  8D 1A D0              STA IRQCTLREG
01598  1A17  A9 1B                 LDA DEFAULTSCRNCTL
01599  1A19  8D 11 D0              STA SCRNCTLREG
01600  1A1C  A9 01                 LDA #$01
01601  1A1E  8D 0E DC              STA TIMERACTLREG
01602  1A21  58                    CLI
01603  1A22             
01604  1A22  A2 00                 LDX #$00
01605  1A24             
01606  1A24             LOOPSCRNHELP1 
01607  1A24  BD 00 04              LDA DISPLAYBASE,X
01608  1A27  9D 00 5C              STA SCRNSAVEBASE,X
01609  1A2A  BD 00 05              LDA DISPLAYBASE+$100,X
01610  1A2D  9D 00 5D              STA SCRNSAVEBASE+$100,X
01611  1A30  BD 00 06              LDA DISPLAYBASE+$200,X
01612  1A33  9D 00 5E              STA SCRNSAVEBASE+$200,X
01613  1A36  BD 00 07              LDA DISPLAYBASE+$300,X
01614  1A39  9D 00 5F              STA SCRNSAVEBASE+$300,X
01615  1A3C  BD 00 44              LDA DATASCRNHELP1,X
01616  1A3F  9D 00 04              STA DISPLAYBASE,X
01617  1A42  BD 00 45              LDA DATASCRNHELP1+$100,X
01618  1A45  9D 00 05              STA DISPLAYBASE+$100,X
01619  1A48  BD 00 46              LDA DATASCRNHELP1+$200,X
01620  1A4B  9D 00 06              STA DISPLAYBASE+$200,X
01621  1A4E  BD 00 47              LDA DATASCRNHELP1+$300,X
01622  1A51  9D 00 07              STA DISPLAYBASE+$300,X
01623  1A54  E8                    INX
01624  1A55  D0 CD                 BNE LOOPSCRNHELP1
01625  1A57             
01626  1A57             WAITKEYHELP1 
01627  1A57  20 9F FF              JSR KRNL_SCNKEY
01628  1A5A  20 E4 FF              JSR KRNL_GETIN
01629  1A5D  C9 20                 CMP KEYSPACE
01630  1A5F  D0 F6                 BNE WAITKEYHELP1
01631  1A61             
01632  1A61  A2 00                 LDX #$00
01633  1A63             
01634  1A63             LOOPSCRNHELP2 
01635  1A63  BD 00 48              LDA DATASCRNHELP2,X
01636  1A66  9D 00 04              STA DISPLAYBASE,X
01637  1A69  BD 00 49              LDA DATASCRNHELP2+$100,X
01638  1A6C  9D 00 05              STA DISPLAYBASE+$100,X
01639  1A6F  BD 00 4A              LDA DATASCRNHELP2+$200,X
01640  1A72  9D 00 06              STA DISPLAYBASE+$200,X
01641  1A75  BD 00 4B              LDA DATASCRNHELP2+$300,X
01642  1A78  9D 00 07              STA DISPLAYBASE+$300,X
01643  1A7B  E8                    INX
01644  1A7C  D0 E5                 BNE LOOPSCRNHELP2
01645  1A7E             
01646  1A7E             WAITKEYHELP2 
01647  1A7E  20 9F FF              JSR KRNL_SCNKEY
01648  1A81  20 E4 FF              JSR KRNL_GETIN
01649  1A84  C9 20                 CMP KEYSPACE
01650  1A86  D0 F6                 BNE WAITKEYHELP2
01651  1A88             
01652  1A88  A2 00                 LDX #$00
01653  1A8A             
01654  1A8A             LOOPSHOWSCRN 
01655  1A8A  BD 00 5C              LDA SCRNSAVEBASE,X
01656  1A8D  9D 00 04              STA DISPLAYBASE,X
01657  1A90  BD 00 5D              LDA SCRNSAVEBASE+$100,X
01658  1A93  9D 00 05              STA DISPLAYBASE+$100,X
01659  1A96  BD 00 5E              LDA SCRNSAVEBASE+$200,X
01660  1A99  9D 00 06              STA DISPLAYBASE+$200,X
01661  1A9C  BD 00 5F              LDA SCRNSAVEBASE+$300,X
01662  1A9F  9D 00 07              STA DISPLAYBASE+$300,X
01663  1AA2             
01664  1AA2  A9 00                 LDA #$00
01665  1AA4  9D 00 5C              STA SCRNSAVEBASE,X
01666  1AA7  9D 00 5D              STA SCRNSAVEBASE+$100,X
01667  1AAA  9D 00 5E              STA SCRNSAVEBASE+$200,X
01668  1AAD  9D 00 5F              STA SCRNSAVEBASE+$300,X
01669  1AB0  E8                    INX
01670  1AB1  D0 D7                 BNE LOOPSHOWSCRN
01671  1AB3             
01672  1AB3  20 DB 1A              JSR SHOWCHARCURSOR
01673  1AB6  60                    RTS
01674  1AB7             ;===============================================================================
01675  1AB7             ; POSITION CURSOR AT HOME ON 8*8 EDITING GRID
01676  1AB7             ;===============================================================================
01677  1AB7             
01678  1AB7             ;
01679  1AB7             ; UTILITY FUNCTION : SHOW EDITING CURSOR BY INVERTING EDIT GRID 'PIXEL' TEMPORARILY
01680  1AB7             ;
01681  1AB7             SHOWEDITCURSOR 
01682  1AB7  A2 00                 LDX #$00
01683  1AB9  A1 AA                 LDA (EDITGRIDPOSLO,X)
01684  1ABB  48                    PHA                   ; SAVE ACTUAL 'PIXEL' VALUE IN 8*8 EDIT GRID
01685  1ABC             
01686  1ABC  C9 A0                 CMP KEYFULLBLOCK
01687  1ABE  F0 07                 BEQ CLREDITCRSR       ; INVERT THE PIXEL AND PAUSE TO MAKE CURSOR BLINK
01688  1AC0             
01689  1AC0  A9 A0                 LDA KEYFULLBLOCK
01690  1AC2  81 AA                 STA (EDITGRIDPOSLO,X)
01691  1AC4  4C CB 1A              JMP WAITEDITCRSR
01692  1AC7             
01693  1AC7             CLREDITCRSR 
01694  1AC7  A9 20                 LDA KEYSPACE
01695  1AC9  81 AA                 STA (EDITGRIDPOSLO,X)
01696  1ACB             
01697  1ACB             WAITEDITCRSR 
01698  1ACB  A9 10                 LDA #$10
01699  1ACD  A8                    TAY
01700  1ACE             
01701  1ACE             LOOPEDITCRSRY 
01702  1ACE  AA                    TAX
01703  1ACF             
01704  1ACF             LOOPEDITCRSRX 
01705  1ACF  CA                    DEX
01706  1AD0  D0 FD                 BNE LOOPEDITCRSRX
01707  1AD2  88                    DEY
01708  1AD3  D0 F9                 BNE LOOPEDITCRSRY
01709  1AD5             
01710  1AD5  68                    PLA                   ; RESTORE ACTUAL 'PIXEL' VALUE IN 8*8 EDIT GRID
01711  1AD6  A2 00                 LDX #$00
01712  1AD8  81 AA                 STA (EDITGRIDPOSLO,X)
01713  1ADA  60                    RTS
01714  1ADB             
01715  1ADB             ;
01716  1ADB             ; UTILITY FUNCTION : SHOW CHARACTER SET CURSOR
01717  1ADB             ;
01718  1ADB             SHOWCHARCURSOR 
01719  1ADB  78                    SEI
01720  1ADC  A9 FF                 LDA #<IRQCURSOR
01721  1ADE  8D 14 03              STA IRQSVCLOADDR
01722  1AE1  A9 1A                 LDA #>IRQCURSOR
01723  1AE3  8D 15 03              STA IRQSVCHIADDR
01724  1AE6             
01725  1AE6  A9 01                 LDA #$01
01726  1AE8  8D 19 D0              STA IRQSTATUSREG
01727  1AEB  8D 1A D0              STA IRQCTLREG
01728  1AEE  A9 00                 LDA #$00
01729  1AF0  8D 0E DC              STA TIMERACTLREG
01730  1AF3  A9 1B                 LDA DEFAULTSCRNCTL
01731  1AF5  8D 11 D0              STA SCRNCTLREG
01732  1AF8  A9 00                 LDA #$00
01733  1AFA  8D 12 D0              STA RASTERLINE
01734  1AFD  58                    CLI
01735  1AFE  60                    RTS
01736  1AFF             
01737  1AFF             IRQCURSOR
01738  1AFF  A9 00                 LDA #$00
01739  1B01             
01740  1B01             WAITRASTER1 
01741  1B01  CD 12 D0              CMP RASTERLINE
01742  1B04  D0 FB                 BNE WAITRASTER1
01743  1B06             
01744  1B06  A9 15                 LDA #$15
01745  1B08  8D 18 D0              STA MEMSETUPREG
01746  1B0B  A9 82                 LDA #$82
01747  1B0D             
01748  1B0D             WAITRASTER2 
01749  1B0D  CD 12 D0              CMP RASTERLINE
01750  1B10  D0 FB                 BNE WAITRASTER2
01751  1B12             
01752  1B12  A9 1D                 LDA #$1D
01753  1B14  8D 18 D0              STA MEMSETUPREG
01754  1B17  A9 FF                 LDA #$FF
01755  1B19             
01756  1B19             WAITRASTER3 
01757  1B19  CD 12 D0              CMP RASTERLINE
01758  1B1C  D0 FB                 BNE WAITRASTER3
01759  1B1E             
01760  1B1E  A9 01                 LDA #$01
01761  1B20  8D 19 D0              STA IRQSTATUSREG
01762  1B23  20 29 1B              JSR BLINKCURSOR
01763  1B26  4C 31 EA              JMP IRQSVCROUTINE
01764  1B29             
01765  1B29             ;
01766  1B29             ; UTILITY FUNCTION : BLINK CHARACTER SET CURSOR (UNDER INTERRUPT)
01767  1B29             ;
01768  1B29             BLINKCURSOR 
01769  1B29  CE 00 56              DEC CURSORTIMER
01770  1B2C  F0 01                 BEQ MAKECURSOR
01771  1B2E  60                    RTS
01772  1B2F             
01773  1B2F             MAKECURSOR 
01774  1B2F  A9 10                 LDA #CURSORDELAY
01775  1B31  8D 00 56              STA CURSORTIMER
01776  1B34  A2 00                 LDX #$00
01777  1B36  A1 BA                 LDA (CHARSETPOSLO,X)
01778  1B38  CD 01 56              CMP EDITINGCHAR
01779  1B3B  F0 06                 BEQ HIDECHAR
01780  1B3D             
01781  1B3D  AD 01 56              LDA EDITINGCHAR
01782  1B40  81 BA                 STA (CHARSETPOSLO,X)
01783  1B42  60                    RTS
01784  1B43             
01785  1B43             HIDECHAR
01786  1B43  A9 20                 LDA KEYSPACE
01787  1B45  81 BA                 STA (CHARSETPOSLO,X)
01788  1B47  60                    RTS
01789  1B48             
01790  1B48             ;
01791  1B48             ; UTILITY FUNCTION : SHOW CHARACTER GRID CURSOR BY INVERTING CHARACTER GRID 'PIXEL' TEMPORARILY
01792  1B48             ;
01793  1B48             SHOWGRIDCURSOR 
01794  1B48  18                    CLC
01795  1B49  A5 D1                 LDA SCRNLINEPNTLO
01796  1B4B  65 D3                 ADC SCRNCOLPNTR
01797  1B4D  8D 64 1B              STA SAVEGRIDCHAR+1
01798  1B50  8D 6A 1B              STA SETGRIDCRSR+1
01799  1B53  8D 78 1B              STA SETGRIDCHAR+1
01800  1B56  A5 D2                 LDA SCRNLINEPNTHI
01801  1B58  69 00                 ADC #$00
01802  1B5A  8D 65 1B              STA SAVEGRIDCHAR+2
01803  1B5D  8D 6B 1B              STA SETGRIDCRSR+2
01804  1B60  8D 79 1B              STA SETGRIDCHAR+2
01805  1B63             
01806  1B63             SAVEGRIDCHAR 
01807  1B63  AD B9 05              LDA SCRNGRIDHOME
01808  1B66  48                    PHA
01809  1B67  A9 A0                 LDA KEYFULLBLOCK
01810  1B69             SETGRIDCRSR 
01811  1B69  8D B9 05              STA SCRNGRIDHOME
01812  1B6C  A9 0A                 LDA #$0A
01813  1B6E  A8                    TAY
01814  1B6F             
01815  1B6F             WAITCRSRONY 
01816  1B6F  AA                    TAX
01817  1B70             
01818  1B70             WAITCRSRONX 
01819  1B70  CA                    DEX
01820  1B71  D0 FD                 BNE WAITCRSRONX
01821  1B73  88                    DEY
01822  1B74  D0 F9                 BNE WAITCRSRONY
01823  1B76             
01824  1B76  68                    PLA
01825  1B77             
01826  1B77             SETGRIDCHAR 
01827  1B77  8D B9 05              STA SCRNGRIDHOME
01828  1B7A  A9 0A                 LDA #$0A
01829  1B7C  A8                    TAY
01830  1B7D             
01831  1B7D             WAITCHARONY 
01832  1B7D  AA                    TAX
01833  1B7E             
01834  1B7E             WAITCHARONX 
01835  1B7E  CA                    DEX
01836  1B7F  D0 FD                 BNE WAITCHARONX
01837  1B81  88                    DEY
01838  1B82  D0 F9                 BNE WAITCHARONY
01839  1B84  60                    RTS
01840  1B85             ;===============================================================================
01841  1B85             ; INVERT EDITING CHARACTER PIXELS
01842  1B85             ;===============================================================================
01843  1B85             
01844  1B85             INVERTCHAR 
01845  1B85  A9 29                 LDA #<EDITGRIDHOME
01846  1B87  85 B8                 STA WORKGRIDPOSLO
01847  1B89  A9 04                 LDA #>EDITGRIDHOME
01848  1B8B  85 B9                 STA WORKGRIDPOSHI
01849  1B8D             
01850  1B8D  A2 00                 LDX #$00
01851  1B8F             LOOP20
01852  1B8F  8A                    TXA
01853  1B90  48                    PHA
01854  1B91  20 9F 1B              JSR INVERTPIXEL
01855  1B94  68                    PLA
01856  1B95  AA                    TAX
01857  1B96  E8                    INX
01858  1B97  E0 08                 CPX #$08
01859  1B99  D0 F4                 BNE LOOP20
01860  1B9B             
01861  1B9B  20 CC 11              JSR STOREDITGRID
01862  1B9E  60                    RTS
01863  1B9F             
01864  1B9F             INVERTPIXEL 
01865  1B9F  A0 00                 LDY #$00
01866  1BA1             
01867  1BA1             TSTGRIDPIXEL 
01868  1BA1  B1 B8                 LDA (WORKGRIDPOSLO),Y
01869  1BA3  C9 A0                 CMP KEYFULLBLOCK
01870  1BA5  F0 05                 BEQ CLRGRIDPIXEL
01871  1BA7                        
01872  1BA7  A9 A0                 LDA KEYFULLBLOCK
01873  1BA9  4C AE 1B              JMP NXTGRIDPIXEL
01874  1BAC             
01875  1BAC             CLRGRIDPIXEL 
01876  1BAC  A9 20                 LDA KEYSPACE
01877  1BAE             
01878  1BAE             NXTGRIDPIXEL 
01879  1BAE  91 B8                 STA (WORKGRIDPOSLO),Y
01880  1BB0  C8                    INY
01881  1BB1  C0 08                 CPY #$08
01882  1BB3  D0 EC                 BNE TSTGRIDPIXEL
01883  1BB5                        
01884  1BB5  18                    CLC
01885  1BB6  A5 B8                 LDA WORKGRIDPOSLO
01886  1BB8  69 28                 ADC #$28
01887  1BBA  85 B8                 STA WORKGRIDPOSLO
01888  1BBC  A5 B9                 LDA WORKGRIDPOSHI
01889  1BBE  69 00                 ADC #$00
01890  1BC0  85 B9                 STA WORKGRIDPOSHI
01891  1BC2  60                    RTS
01892  1BC3             ;===============================================================================
01893  1BC3             ; COPY ROM CHAR TO RAM CHAR POSITION
01894  1BC3             ;===============================================================================
01895  1BC3             
01896  1BC3             COPYROMCHAR 
01897  1BC3  78                    SEI
01898  1BC4  A9 31                 LDA #<IRQSVCROUTINE
01899  1BC6  8D 14 03              STA IRQSVCLOADDR
01900  1BC9  A9 EA                 LDA #>IRQSVCROUTINE
01901  1BCB  8D 15 03              STA IRQSVCHIADDR
01902  1BCE             
01903  1BCE  A9 79                 LDA #$79
01904  1BD0  8D 19 D0              STA IRQSTATUSREG
01905  1BD3  A9 F0                 LDA #$F0
01906  1BD5  8D 1A D0              STA IRQCTLREG
01907  1BD8  A9 01                 LDA #$01
01908  1BDA  8D 0E DC              STA TIMERACTLREG
01909  1BDD  58                    CLI
01910  1BDE             
01911  1BDE  A9 00                 LDA #$00
01912  1BE0  85 BC                 STA TEMPCHARSAVE
01913  1BE2             
01914  1BE2             COPYROMCHARIDX 
01915  1BE2  A9 D0                 LDA #>UPPERCHRROM
01916  1BE4  85 BD                 STA TEMPSAVE6
01917  1BE6             
01918  1BE6  38                    SEC
01919  1BE7  A5 A8                 LDA CHARMEMPOSLO
01920  1BE9  E9 00                 SBC #$00
01921  1BEB  85 AC                 STA TEMPSAVE4
01922  1BED  A5 A9                 LDA CHARMEMPOSHI
01923  1BEF  E9 30                 SBC #$30
01924  1BF1  85 AD                 STA TEMPSAVE5
01925  1BF3             
01926  1BF3  18                    CLC
01927  1BF4  A5 BC                 LDA TEMPCHARSAVE
01928  1BF6  65 AC                 ADC TEMPSAVE4
01929  1BF8  85 BC                 STA TEMPCHARSAVE
01930  1BFA  A5 BD                 LDA TEMPSAVE6
01931  1BFC  65 AD                 ADC TEMPSAVE5
01932  1BFE  85 BD                 STA TEMPSAVE6
01933  1C00             
01934  1C00  A9 7F                 LDA #$7F
01935  1C02  8D 0D DC              STA IRQCTLSTATREG
01936  1C05  A9 33                 LDA #$33
01937  1C07  85 01                 STA PROCPORT
01938  1C09             
01939  1C09  A0 00                 LDY #$00
01940  1C0B             LOOP25
01941  1C0B  B1 BC                 LDA (TEMPCHARSAVE),Y
01942  1C0D  91 A8                 STA (CHARMEMPOSLO),Y
01943  1C0F  C8                    INY
01944  1C10  C0 08                 CPY #$08
01945  1C12  D0 F7                 BNE LOOP25
01946  1C14             
01947  1C14  A9 37                 LDA #$37
01948  1C16  85 01                 STA PROCPORT
01949  1C18  A9 81                 LDA #$81
01950  1C1A  8D 0D DC              STA IRQCTLSTATREG
01951  1C1D             
01952  1C1D  20 DB 1A              JSR SHOWCHARCURSOR
01953  1C20  60                    RTS
01954  1C21             ;===============================================================================
01955  1C21             ; TOGGLE FOCUS BETWEEN 8*8 AND 20*6 GRIDS
01956  1C21             ;===============================================================================
01957  1C21             
01958  1C21             ALIGN
01959  1D00             SWAPWINDOWMAPS 
01960  1D00  A9 32                 LDA KEY2                ; PRINT 20*6
01961  1D02  8D 3C 04              STA GRIDMODEADDR
01962  1D05  A9 30                 LDA KEY0
01963  1D07  8D 3D 04              STA GRIDMODEADDR+1
01964  1D0A  A9 2A                 LDA KEYASTERISK
01965  1D0C  8D 3E 04              STA GRIDMODEADDR+2
01966  1D0F  A9 36                 LDA KEY6
01967  1D11  8D 3F 04              STA GRIDMODEADDR+3
01968  1D14             
01969  1D14             CHARCURSORROW 
01970  1D14  A2 0B                 LDX CHARCRSRHOMEROW     ; TODO: THIS IS MODIFIED OUTSIDE OF ROUTINE
01971  1D16             
01972  1D16             CHARCURSORCOL 
01973  1D16  A0 01                 LDY CHARCRSRHOMECOL
01974  1D18  18                    CLC
01975  1D19  20 F0 FF              JSR KRNL_PLOT
01976  1D1C             
01977  1D1C             WAITSWAPCMDS 
01978  1D1C  20 9F FF              JSR KRNL_SCNKEY
01979  1D1F  20 E4 FF              JSR KRNL_GETIN
01980  1D22  A2 00                 LDX #$00
01981  1D24             
01982  1D24             SCANSWAPCMDS 
01983  1D24  DD 00 58              CMP SWAPCMDS,X
01984  1D27  F0 F3                 BEQ WAITSWAPCMDS
01985  1D29             
01986  1D29  E8                    INX
01987  1D2A  E0 0A                 CPX #$0A
01988  1D2C  D0 F6                 BNE SCANSWAPCMDS
01989  1D2E             
01990  1D2E  C9 0D                 CMP KEYRETURN
01991  1D30  F0 0C                 BEQ SWAPWINDOWOFF
01992  1D32             
01993  1D32  20 D2 FF              JSR KRNL_CHROUT
01994  1D35             
01995  1D35  20 48 1B              JSR SHOWGRIDCURSOR
01996  1D38  20 65 24              JSR CHECKCHARSTICK
01997  1D3B  4C 14 1D              JMP CHARCURSORROW
01998  1D3E             
01999  1D3E             SWAPWINDOWOFF 
02000  1D3E  A9 0B                 LDA CHARCRSRHOMEROW
02001  1D40  8D 15 1D              STA CHARCURSORROW+1
02002  1D43  A9 01                 LDA CHARCRSRHOMECOL
02003  1D45  8D 17 1D              STA CHARCURSORCOL+1
02004  1D48             
02005  1D48  A9 20                 LDA KEYSPACE            ; PRINT 8*8
02006  1D4A  8D 3C 04              STA GRIDMODEADDR
02007  1D4D  A9 38                 LDA KEY8
02008  1D4F  8D 3D 04              STA GRIDMODEADDR+1
02009  1D52  A9 2A                 LDA KEYASTERISK
02010  1D54  8D 3E 04              STA GRIDMODEADDR+2
02011  1D57  A9 38                 LDA KEY8
02012  1D59  8D 3F 04              STA GRIDMODEADDR+3
02013  1D5C  60                    RTS
02014  1D5D             ;===============================================================================
02015  1D5D             ; TOGGLE SWAP MODE ON/OFF AND PROCESS SWAPPING POSITION OF TWO CHARACTERS
02016  1D5D             ;===============================================================================
02017  1D5D             
02018  1D5D             SWAPCHARPOSNS 
02019  1D5D  A2 00                 LDX #$00
02020  1D5F             
02021  1D5F             SHOWSWAPMSG 
02022  1D5F  BD 50 55              LDA DATASWAPMODE,X
02023  1D62  9D B0 04              STA MESSAGEAREAADDR+2,X
02024  1D65  E8                    INX
02025  1D66  E0 09                 CPX #$09
02026  1D68  D0 F5                 BNE SHOWSWAPMSG
02027  1D6A             
02028  1D6A  A5 A8                 LDA CHARMEMPOSLO
02029  1D6C  85 FB                 STA TEMPSAVE1
02030  1D6E  A5 A9                 LDA CHARMEMPOSHI
02031  1D70  85 FC                 STA TEMPSAVE2
02032  1D72             
02033  1D72  A0 00                 LDY #$00
02034  1D74             
02035  1D74             SWAPSAVECHARS 
02036  1D74  B1 FB                 LDA (TEMPSAVE1),Y
02037  1D76  99 8B 56              STA DATACHARSETSAVE,Y
02038  1D79  C8                    INY
02039  1D7A  D0 F8                 BNE SWAPSAVECHARS
02040  1D7C             
02041  1D7C             SWAPMODESTART 
02042  1D7C  A9 29                 LDA #<EDITGRIDHOME
02043  1D7E  85 B8                 STA WORKGRIDPOSLO
02044  1D80  A9 04                 LDA #>EDITGRIDHOME
02045  1D82  85 B9                 STA WORKGRIDPOSHI
02046  1D84             
02047  1D84  A2 00                 LDX #$00
02048  1D86             
02049  1D86             SHOWNEXTROW 
02050  1D86  8A                    TXA
02051  1D87  48                    PHA
02052  1D88  20 5D 23              JSR DRAWEDITROW
02053  1D8B  68                    PLA
02054  1D8C  AA                    TAX
02055  1D8D  E8                    INX
02056  1D8E  E0 08                 CPX #$08
02057  1D90  D0 F4                 BNE SHOWNEXTROW
02058  1D92             
02059  1D92  38                    SEC
02060  1D93  A5 A8                 LDA CHARMEMPOSLO
02061  1D95  E9 08                 SBC #$08
02062  1D97  85 A8                 STA CHARMEMPOSLO
02063  1D99  A5 A9                 LDA CHARMEMPOSHI
02064  1D9B  E9 00                 SBC #$00
02065  1D9D  85 A9                 STA CHARMEMPOSHI
02066  1D9F             
02067  1D9F             WAITSWAPKEYS 
02068  1D9F  20 9F FF              JSR KRNL_SCNKEY
02069  1DA2  20 E4 FF              JSR KRNL_GETIN
02070  1DA5  C9 00                 CMP #$00
02071  1DA7  F0 F6                 BEQ WAITSWAPKEYS
02072  1DA9             
02073  1DA9  C9 53                 CMP KEYS
02074  1DAB  F0 2B                 BEQ SWAPMODEOFF
02075  1DAD             
02076  1DAD  C9 2B                 CMP KEYPLUS
02077  1DAF  F0 0F                 BEQ SWAPNEXTCHR
02078  1DB1             
02079  1DB1  C9 2D                 CMP KEYMINUS
02080  1DB3  F0 11                 BEQ SWAPPREVCHR
02081  1DB5             
02082  1DB5  C9 87                 CMP KEYF5
02083  1DB7  F0 13                 BEQ SWAPUPALINE
02084  1DB9             
02085  1DB9  C9 88                 CMP KEYF7
02086  1DBB  F0 15                 BEQ SWAPDOWNALINE
02087  1DBD             
02088  1DBD  4C 9F 1D              JMP WAITSWAPKEYS
02089  1DC0             
02090  1DC0             SWAPNEXTCHR 
02091  1DC0  20 92 14              JSR SELECTNEXTCHR
02092  1DC3  4C 7C 1D              JMP SWAPMODESTART
02093  1DC6             
02094  1DC6             SWAPPREVCHR 
02095  1DC6  20 00 16              JSR SELECTPREVCHR
02096  1DC9  4C 7C 1D              JMP SWAPMODESTART
02097  1DCC             
02098  1DCC             SWAPUPALINE 
02099  1DCC  20 87 16              JSR MOVEUPALINE
02100  1DCF  4C 7C 1D              JMP SWAPMODESTART
02101  1DD2             
02102  1DD2             SWAPDOWNALINE 
02103  1DD2  20 00 17              JSR MOVEDOWNALINE
02104  1DD5  4C 7C 1D              JMP SWAPMODESTART
02105  1DD8             
02106  1DD8             SWAPMODEOFF 
02107  1DD8  A0 00                 LDY #$00
02108  1DDA             
02109  1DDA             LOOPSWAPCHAR 
02110  1DDA  B1 A8                 LDA (CHARMEMPOSLO),Y
02111  1DDC  91 FB                 STA (TEMPSAVE1),Y
02112  1DDE  B9 8B 56              LDA DATACHARSETSAVE,Y
02113  1DE1  91 A8                 STA (CHARMEMPOSLO),Y
02114  1DE3  C8                    INY
02115  1DE4  C0 08                 CPY #$08
02116  1DE6  D0 F2                 BNE LOOPSWAPCHAR
02117  1DE8             
02118  1DE8  A2 00                 LDX #$00
02119  1DEA  A9 20                 LDA KEYSPACE
02120  1DEC             
02121  1DEC             CLEARSWAPMSG 
02122  1DEC  9D B0 04              STA MESSAGEAREAADDR+2,X
02123  1DEF  E8                    INX
02124  1DF0  E0 09                 CPX #$09
02125  1DF2  D0 F8                 BNE CLEARSWAPMSG
02126  1DF4  60                    RTS
02127  1DF5             ;===============================================================================
02128  1DF5             ; DEVICE UTILITY FUNCTIONS
02129  1DF5             ;===============================================================================
02130  1DF5             
02131  1DF5             ;
02132  1DF5             ; UTILITY FUNCTION : DISPLAY DEVICE STATUS FOR LOAD/SAVE OPERATIONS
02133  1DF5             ;
02134  1DF5             ALIGN
02135  1E00             SHOWDEVSTATUS 
02136  1E00  A2 16                 LDX #$16
02137  1E02  A0 00                 LDY #$00
02138  1E04  18                    CLC
02139  1E05  20 F0 FF              JSR KRNL_PLOT
02140  1E08             
02141  1E08  A2 00                 LDX #$00
02142  1E0A             
02143  1E0A             PRINTSTATUS ; PRINT "STATUS: "
02144  1E0A  BD 76 55              LDA DATASTATUS,X
02145  1E0D  20 D2 FF              JSR KRNL_CHROUT
02146  1E10  E8                    INX
02147  1E11  E0 08                 CPX #$08
02148  1E13  D0 F5                 BNE PRINTSTATUS
02149  1E15             
02150  1E15  A2 00                 LDX #$00
02151  1E17             
02152  1E17             STORVARS   ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02153  1E17  B5 A8                 LDA CHARMEMPOSLO,X
02154  1E19  9D 8B 57              STA VARSSAVEAREA,X
02155  1E1C  E8                    INX
02156  1E1D  E0 16                 CPX #$16
02157  1E1F  D0 F6                 BNE STORVARS
02158  1E21             
02159  1E21  A9 00                 LDA #$00
02160  1E23  85 90                 STA DEVICESTATUS
02161  1E25  A9 08                 LDA #$08
02162  1E27  85 BA                 STA DEVICENUM
02163  1E29  20 B4 FF              JSR KRNL_TALK
02164  1E2C  A9 6F                 LDA #$6F
02165  1E2E  85 B9                 STA FILESECADDR
02166  1E30  20 96 FF              JSR KRNL_TKSA
02167  1E33             
02168  1E33             GETDEVSTATUS 
02169  1E33  A4 90                 LDY DEVICESTATUS
02170  1E35  D0 0A                 BNE DEVSTATUSDONE
02171  1E37             
02172  1E37  20 A5 FF              JSR KRNL_IECIN
02173  1E3A  20 D2 FF              JSR KRNL_CHROUT
02174  1E3D  C9 0D                 CMP #$0D
02175  1E3F  D0 F2                 BNE GETDEVSTATUS
02176  1E41             
02177  1E41             DEVSTATUSDONE 
02178  1E41  20 AB FF              JSR KRNL_UNTLK
02179  1E44             
02180  1E44             WAITKEYSPC 
02181  1E44  20 9F FF              JSR KRNL_SCNKEY
02182  1E47  20 E4 FF              JSR KRNL_GETIN
02183  1E4A  C9 20                 CMP KEYSPACE
02184  1E4C  D0 F6                 BNE WAITKEYSPC
02185  1E4E             
02186  1E4E  A2 00                 LDX #$00                ; RESTORE PROGRAM VARIABLES ($A8 - $BD)
02187  1E50             
02188  1E50             LOOP26
02189  1E50  BD 8B 57              LDA VARSSAVEAREA,X
02190  1E53  95 A8                 STA CHARMEMPOSLO,X
02191  1E55  E8                    INX
02192  1E56  E0 16                 CPX #$16
02193  1E58  D0 F6                 BNE LOOP26
02194  1E5A             
02195  1E5A  60                    RTS
02196  1E5B             
02197  1E5B             ;
02198  1E5B             ; UTILITY FUNCTION : DISPLAY DEVICE (DISC) DIRECTORY
02199  1E5B             ;
02200  1E5B             ALIGN
02201  1F00             SHOWDEVDIR 
02202  1F00  AD 06 56              LDA STORAGEDEVNUM
02203  1F03  C9 31                 CMP KEY1
02204  1F05  D0 01                 BNE BEGINDEVDIR
02205  1F07  60                    RTS
02206  1F08             
02207  1F08             BEGINDEVDIR 
02208  1F08  A2 00                 LDX #$00
02209  1F0A             
02210  1F0A             STORDEVDIRVARS ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02211  1F0A  B5 A8                 LDA CHARMEMPOSLO,X
02212  1F0C  9D 8B 57              STA VARSSAVEAREA,X
02213  1F0F  E8                    INX
02214  1F10  E0 16                 CPX #$16
02215  1F12  D0 F6                 BNE STORDEVDIRVARS
02216  1F14             
02217  1F14  20 44 E5              JSR KRNL_CLRSCRN
02218  1F17             
02219  1F17  AD 06 56              LDA STORAGEDEVNUM
02220  1F1A  C9 38                 CMP KEY8
02221  1F1C  D0 0B                 BNE LISTSECONDDISC
02222  1F1E             
02223  1F1E  A9 30                 LDA KEY0
02224  1F20  85 FC                 STA TEMPSAVE2
02225  1F22  A9 02                 LDA #$02
02226  1F24  85 FD                 STA TEMPSAVE3
02227  1F26  4C 31 1F              JMP LISTDEVDIR
02228  1F29             
02229  1F29             LISTSECONDDISC 
02230  1F29  A9 31                 LDA KEY1
02231  1F2B  85 FC                 STA TEMPSAVE2
02232  1F2D  A9 02                 LDA #$02
02233  1F2F  85 FD                 STA TEMPSAVE3
02234  1F31                        
02235  1F31             LISTDEVDIR 
02236  1F31  A9 00                 LDA #$00
02237  1F33  85 90                 STA DEVICESTATUS
02238  1F35  A9 24                 LDA #$24
02239  1F37  85 FB                 STA TEMPSAVE1
02240  1F39  A9 FB                 LDA #$FB
02241  1F3B  85 BB                 STA FILENAMELO
02242  1F3D  A9 00                 LDA #$00
02243  1F3F  85 BC                 STA FILENAMEHI
02244  1F41  A5 FD                 LDA TEMPSAVE3
02245  1F43  85 B7                 STA FILENAMLEN
02246  1F45  A9 08                 LDA #$08
02247  1F47  85 BA                 STA DEVICENUM
02248  1F49  A9 60                 LDA #$60
02249  1F4B  85 B9                 STA FILESECADDR
02250  1F4D             
02251  1F4D  20 D5 F3              JSR KRNL_PRTLOADING
02252  1F50  A5 BA                 LDA DEVICENUM
02253  1F52  20 B4 FF              JSR KRNL_TALK
02254  1F55             
02255  1F55  A5 B9                 LDA FILESECADDR
02256  1F57  20 96 FF              JSR KRNL_TKSA
02257  1F5A  A4 90                 LDY DEVICESTATUS
02258  1F5C             
02259  1F5C             GETDEVDIR
02260  1F5C  D0 3D                 BNE LISTDEVDIREND
02261  1F5E             
02262  1F5E  A0 06                 LDY #$06
02263  1F60             
02264  1F60             NEXTDEVDIR 
02265  1F60  84 FB                 STY TEMPSAVE1
02266  1F62  20 A5 FF              JSR KRNL_IECIN
02267  1F65  A6 FC                 LDX TEMPSAVE2
02268  1F67  85 FC                 STA TEMPSAVE2
02269  1F69  A4 90                 LDY DEVICESTATUS
02270  1F6B  D0 2E                 BNE LISTDEVDIREND
02271  1F6D             
02272  1F6D  A4 FB                 LDY TEMPSAVE1
02273  1F6F  88                    DEY
02274  1F70  D0 EE                 BNE NEXTDEVDIR
02275  1F72             
02276  1F72  A4 FC                 LDY TEMPSAVE2
02277  1F74  20 CD BD              JSR KRNL_LINPRT
02278  1F77  A9 20                 LDA KEYSPACE
02279  1F79  20 D2 FF              JSR KRNL_CHROUT
02280  1F7C             
02281  1F7C             READDEVDIR 
02282  1F7C  20 A5 FF              JSR KRNL_IECIN
02283  1F7F  A6 90                 LDX DEVICESTATUS
02284  1F81  D0 18                 BNE LISTDEVDIREND
02285  1F83             
02286  1F83  AA                    TAX
02287  1F84  F0 06                 BEQ ENDDEVDIRITEM
02288  1F86             
02289  1F86  20 D2 FF              JSR KRNL_CHROUT
02290  1F89  4C 7C 1F              JMP READDEVDIR
02291  1F8C             
02292  1F8C             ENDDEVDIRITEM 
02293  1F8C  A9 0D                 LDA KEYRETURN
02294  1F8E  20 D2 FF              JSR KRNL_CHROUT
02295  1F91             
02296  1F91  A5 C5                 LDA KEYBDMATRIX
02297  1F93  C9 3F                 CMP #$3F
02298  1F95  F0 04                 BEQ LISTDEVDIREND
02299  1F97  A0 04                 LDY #$04
02300  1F99  D0 C5                 BNE NEXTDEVDIR
02301  1F9B             
02302  1F9B             LISTDEVDIREND 
02303  1F9B  20 42 F6              JSR KRNL_CLOSEFILE
02304  1F9E             
02305  1F9E  A2 00                 LDX #$00
02306  1FA0             
02307  1FA0             SETDEVDIRVARS ; RESTORE PROGRAM VARIABLES ($A8 - $BD)
02308  1FA0  BD 8B 57              LDA VARSSAVEAREA,X
02309  1FA3  95 A8                 STA CHARMEMPOSLO,X
02310  1FA5  E8                    INX
02311  1FA6  E0 16                 CPX #$16
02312  1FA8  D0 F6                 BNE SETDEVDIRVARS
02313  1FAA             
02314  1FAA             WAITDEVDIRSPC 
02315  1FAA  20 9F FF              JSR KRNL_SCNKEY
02316  1FAD  20 E4 FF              JSR KRNL_GETIN
02317  1FB0  C9 20                 CMP KEYSPACE
02318  1FB2  D0 F6                 BNE WAITDEVDIRSPC
02319  1FB4             
02320  1FB4  60                    RTS
02321  1FB5             ;===============================================================================
02322  1FB5             ; LOAD CHARACTER SET FROM AN INPUT DEVICE
02323  1FB5             ;===============================================================================
02324  1FB5             
02325  1FB5             ALIGN
02326  2000             LOADFROMDEVICE 
02327  2000  78                    SEI
02328  2001  A9 31                 LDA #<IRQSVCROUTINE
02329  2003  8D 14 03              STA IRQSVCLOADDR
02330  2006  A9 EA                 LDA #>IRQSVCROUTINE
02331  2008  8D 15 03              STA IRQSVCHIADDR
02332  200B             
02333  200B  A9 79                 LDA #$79
02334  200D  8D 19 D0              STA IRQSTATUSREG
02335  2010  A9 F0                 LDA #$F0
02336  2012  8D 1A D0              STA IRQCTLREG
02337  2015  A9 1B                 LDA DEFAULTSCRNCTL
02338  2017  8D 11 D0              STA SCRNCTLREG
02339  201A  A9 01                 LDA #$01
02340  201C  8D 0E DC              STA TIMERACTLREG
02341  201F  58                    CLI
02342  2020             
02343  2020  A9 15                 LDA #$15
02344  2022  8D 18 D0              STA MEMSETUPREG
02345  2025             
02346  2025  A2 00                 LDX #$00
02347  2027             
02348  2027             SAVESCRNFORLOAD 
02349  2027  BD 00 04              LDA DISPLAYBASE,X
02350  202A  9D 00 5C              STA SCRNSAVEBASE,X
02351  202D  BD 00 05              LDA DISPLAYBASE+$100,X
02352  2030  9D 00 5D              STA SCRNSAVEBASE+$100,X
02353  2033  BD 00 06              LDA DISPLAYBASE+$200,X
02354  2036  9D 00 5E              STA SCRNSAVEBASE+$200,X
02355  2039  BD 00 07              LDA DISPLAYBASE+$300,X
02356  203C  9D 00 5F              STA SCRNSAVEBASE+$300,X
02357  203F  E8                    INX
02358  2040  D0 E5                 BNE SAVESCRNFORLOAD
02359  2042             
02360  2042             SHOWLOADSCRN 
02361  2042  A2 00                 LDX #$00
02362  2044             
02363  2044             LOOPLOADSCRN 
02364  2044  BD 00 4C              LDA DATASCRNLOAD,X
02365  2047  9D 00 04              STA DISPLAYBASE,X
02366  204A  BD 00 4D              LDA DATASCRNLOAD+$100,X
02367  204D  9D 00 05              STA DISPLAYBASE+$100,X
02368  2050  BD 00 4E              LDA DATASCRNLOAD+$200,X
02369  2053  9D 00 06              STA DISPLAYBASE+$200,X
02370  2056  BD 00 4F              LDA DATASCRNLOAD+$300,X
02371  2059  9D 00 07              STA DISPLAYBASE+$300,X
02372  205C  E8                    INX
02373  205D  D0 E5                 BNE LOOPLOADSCRN
02374  205F             
02375  205F  AD 06 56              LDA STORAGEDEVNUM
02376  2062  8D D9 4D              STA DATALOADDEVNUM
02377  2065             
02378  2065             WAITLOADKEYS 
02379  2065  20 9F FF              JSR KRNL_SCNKEY
02380  2068  20 E4 FF              JSR KRNL_GETIN
02381  206B  C9 00                 CMP #$00
02382  206D  F0 F6                 BEQ WAITLOADKEYS
02383  206F             
02384  206F  C9 4C                 CMP KEYL
02385  2071  F0 13                 BEQ DOLOAD
02386  2073             
02387  2073  C9 53                 CMP KEYS
02388  2075  F0 15                 BEQ DOLOADDEVSTATUS
02389  2077             
02390  2077  C9 44                 CMP KEYD
02391  2079  F0 17                 BEQ DONEXTLOADDEV
02392  207B             
02393  207B  C9 2A                 CMP KEYASTERISK
02394  207D  F0 19                 BEQ DOLOADDEVDIR
02395  207F             
02396  207F  C9 51                 CMP KEYQ
02397  2081  F0 1B                 BEQ LOADDEVEND
02398  2083             
02399  2083  4C 65 20              JMP WAITLOADKEYS
02400  2086             
02401  2086             DOLOAD     
02402  2086  20 F3 20              JSR LOADFROMFILE
02403  2089  4C 42 20              JMP SHOWLOADSCRN
02404  208C             
02405  208C             DOLOADDEVSTATUS 
02406  208C  20 00 1E              JSR SHOWDEVSTATUS
02407  208F  4C 42 20              JMP SHOWLOADSCRN
02408  2092             
02409  2092             DONEXTLOADDEV 
02410  2092  20 CD 20              JSR NEXTLOADDEVNUM
02411  2095  4C 42 20              JMP SHOWLOADSCRN
02412  2098             
02413  2098             DOLOADDEVDIR 
02414  2098  20 00 1F              JSR SHOWDEVDIR
02415  209B  4C 42 20              JMP SHOWLOADSCRN
02416  209E             
02417  209E             LOADDEVEND 
02418  209E  A2 00                 LDX #$00
02419  20A0             
02420  20A0             RESTOREFROMLOAD 
02421  20A0  BD 00 5C              LDA SCRNSAVEBASE,X
02422  20A3  9D 00 04              STA DISPLAYBASE,X
02423  20A6  BD 00 5D              LDA SCRNSAVEBASE+$100,X
02424  20A9  9D 00 05              STA DISPLAYBASE+$100,X
02425  20AC  BD 00 5E              LDA SCRNSAVEBASE+$200,X
02426  20AF  9D 00 06              STA DISPLAYBASE+$200,X
02427  20B2  BD 00 5F              LDA SCRNSAVEBASE+$300,X
02428  20B5  9D 00 07              STA DISPLAYBASE+$300,X
02429  20B8  A9 00                 LDA #$00
02430  20BA  9D 00 5C              STA SCRNSAVEBASE,X
02431  20BD  9D 00 5D              STA SCRNSAVEBASE+$100,X
02432  20C0  9D 00 5E              STA SCRNSAVEBASE+$200,X
02433  20C3  9D 00 5F              STA SCRNSAVEBASE+$300,X
02434  20C6  E8                    INX
02435  20C7  D0 D7                 BNE RESTOREFROMLOAD
02436  20C9                        
02437  20C9  20 DB 1A              JSR SHOWCHARCURSOR
02438  20CC  60                    RTS
02439  20CD             
02440  20CD             ;
02441  20CD             ; UTILITY FUNCTION : CYCLE LOAD DEVICE NUMBER BETWEEN 1, 8, AND 9
02442  20CD             ;
02443  20CD             NEXTLOADDEVNUM 
02444  20CD  AD D9 4D              LDA DATALOADDEVNUM
02445  20D0  C9 31                 CMP KEY1
02446  20D2  D0 09                 BNE TSTLOADDEVNUM8
02447  20D4                        
02448  20D4  A9 38                 LDA KEY8
02449  20D6  8D 06 56              STA STORAGEDEVNUM
02450  20D9  8D D9 4D              STA DATALOADDEVNUM
02451  20DC  60                    RTS
02452  20DD                        
02453  20DD             TSTLOADDEVNUM8 
02454  20DD  C9 38                 CMP KEY8
02455  20DF  D0 09                 BNE SETLOADDEVNUM1
02456  20E1             
02457  20E1  A9 39                 LDA KEY9
02458  20E3  8D D9 4D              STA DATALOADDEVNUM
02459  20E6  8D 06 56              STA STORAGEDEVNUM
02460  20E9  60                    RTS
02461  20EA             
02462  20EA             SETLOADDEVNUM1 
02463  20EA  A9 31                 LDA KEY1
02464  20EC  8D 06 56              STA STORAGEDEVNUM
02465  20EF  8D D9 4D              STA DATALOADDEVNUM
02466  20F2  60                    RTS
02467  20F3             
02468  20F3             ;
02469  20F3             ; UTILITY FUNCTION : LOAD CHARACTER SET FILE FROM DEVICE
02470  20F3             ;
02471  20F3             LOADFROMFILE 
02472  20F3  A2 00                 LDX #$00
02473  20F5             
02474  20F5             STORLOADVARS ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02475  20F5  B5 A8                 LDA CHARMEMPOSLO,X
02476  20F7  9D 8B 57              STA VARSSAVEAREA,X
02477  20FA  E8                    INX
02478  20FB  E0 16                 CPX #$16
02479  20FD  D0 F6                 BNE STORLOADVARS
02480  20FF             
02481  20FF  A2 16                 LDX #$16
02482  2101  A0 00                 LDY #$00
02483  2103  18                    CLC
02484  2104  20 F0 FF              JSR KRNL_PLOT
02485  2107             
02486  2107  A2 00                 LDX #$00
02487  2109             
02488  2109             PRTLOADNAME ; PRINT "FILENAME : "
02489  2109  BD 66 55              LDA DATAFILENAME,X
02490  210C  20 D2 FF              JSR KRNL_CHROUT
02491  210F  E8                    INX
02492  2110  E0 0B                 CPX #$0B
02493  2112  D0 F5                 BNE PRTLOADNAME
02494  2114             
02495  2114  A0 00                 LDY #$00
02496  2116             
02497  2116             LOADNAMECHAR 
02498  2116  20 CF FF              JSR KRNL_CHRIN
02499  2119  C9 0D                 CMP KEYRETURN
02500  211B  F0 08                 BEQ LOADBYNAME
02501  211D             
02502  211D  99 0B 56              STA FILENAMEINPUT,Y
02503  2120  C8                    INY
02504  2121  C0 15                 CPY #$15
02505  2123  D0 F1                 BNE LOADNAMECHAR
02506  2125             
02507  2125             LOADBYNAME 
02508  2125  A9 0D                 LDA KEYRETURN
02509  2127  20 D2 FF              JSR KRNL_CHROUT
02510  212A  8C 07 56              STY CHRINLEN
02511  212D  38                    SEC
02512  212E  AD 06 56              LDA STORAGEDEVNUM
02513  2131  E9 30                 SBC #$30
02514  2133  8A                    TXA
02515  2134  A9 01                 LDA #$01
02516  2136  A0 00                 LDY #$00
02517  2138  20 BA FF              JSR KRNL_SETLFS
02518  213B  AD 07 56              LDA CHRINLEN
02519  213E  A2 0B                 LDX #<FILENAMEINPUT
02520  2140  A0 56                 LDY #>FILENAMEINPUT
02521  2142  20 BD FF              JSR KRNL_SETNAM
02522  2145  A9 00                 LDA #$00
02523  2147  A2 00                 LDX #<CHARMEMBASE
02524  2149  A0 30                 LDY #>CHARMEMBASE
02525  214B  20 D5 FF              JSR KRNL_LOAD
02526  214E             
02527  214E             RESTOREPRGVARS 
02528  214E  A2 00                 LDX #$00
02529  2150             
02530  2150             SETLOADVARS ; RESTORE PROGRAM VARIABLES ($A8 - $BD)
02531  2150  BD 8B 57              LDA VARSSAVEAREA,X
02532  2153  95 A8                 STA CHARMEMPOSLO,X
02533  2155  E8                    INX
02534  2156  E0 16                 CPX #$16
02535  2158  D0 F6                 BNE SETLOADVARS
02536  215A             
02537  215A  20 E7 FF              JSR KRNL_CLALL
02538  215D  60                    RTS
02539  215E             ;===============================================================================
02540  215E             ; SAVE CHARACTER SET TO AN OUTPUT DEVICE
02541  215E             ;===============================================================================
02542  215E             
02543  215E             ALIGN
02544  2200             SAVETODEVICE 
02545  2200  78                    SEI
02546  2201  A9 31                 LDA #<IRQSVCROUTINE
02547  2203  8D 14 03              STA IRQSVCLOADDR
02548  2206  A9 EA                 LDA #>IRQSVCROUTINE
02549  2208  8D 15 03              STA IRQSVCHIADDR
02550  220B             
02551  220B  A9 79                 LDA #$79
02552  220D  8D 19 D0              STA IRQSTATUSREG
02553  2210  A9 F0                 LDA #$F0
02554  2212  8D 1A D0              STA IRQCTLREG
02555  2215  A9 1B                 LDA DEFAULTSCRNCTL
02556  2217  8D 11 D0              STA SCRNCTLREG
02557  221A  A9 01                 LDA #$01
02558  221C  8D 0E DC              STA TIMERACTLREG
02559  221F  58                    CLI
02560  2220             
02561  2220  A9 15                 LDA #$15
02562  2222  8D 18 D0              STA MEMSETUPREG
02563  2225             
02564  2225  A2 00                 LDX #$00
02565  2227             
02566  2227             SAVESCRNFORSAVE 
02567  2227  BD 00 04              LDA DISPLAYBASE,X
02568  222A  9D 00 5C              STA SCRNSAVEBASE,X
02569  222D  BD 00 05              LDA DISPLAYBASE+$100,X
02570  2230  9D 00 5D              STA SCRNSAVEBASE+$100,X
02571  2233  BD 00 06              LDA DISPLAYBASE+$200,X
02572  2236  9D 00 5E              STA SCRNSAVEBASE+$200,X
02573  2239  BD 00 07              LDA DISPLAYBASE+$300,X
02574  223C  9D 00 5F              STA SCRNSAVEBASE+$300,X
02575  223F  E8                    INX
02576  2240  D0 E5                 BNE SAVESCRNFORSAVE
02577  2242             
02578  2242             SHOWSAVESCRN 
02579  2242  A2 00                 LDX #$00
02580  2244             
02581  2244             LOOPSAVESCRN 
02582  2244  BD 00 50              LDA DATASCRNSAVE,X
02583  2247  9D 00 04              STA DISPLAYBASE,X
02584  224A  BD 00 51              LDA DATASCRNSAVE+$100,X
02585  224D  9D 00 05              STA DISPLAYBASE+$100,X
02586  2250  BD 00 52              LDA DATASCRNSAVE+$200,X
02587  2253  9D 00 06              STA DISPLAYBASE+$200,X
02588  2256  BD 00 53              LDA DATASCRNSAVE+$300,X
02589  2259  9D 00 07              STA DISPLAYBASE+$300,X
02590  225C  E8                    INX
02591  225D  D0 E5                 BNE LOOPSAVESCRN
02592  225F             
02593  225F  AD 06 56              LDA STORAGEDEVNUM
02594  2262  8D D9 51              STA DATASAVEDEVNUM
02595  2265             
02596  2265             WAITSAVEKEYS 
02597  2265  20 9F FF              JSR KRNL_SCNKEY
02598  2268  20 E4 FF              JSR KRNL_GETIN
02599  226B  C9 00                 CMP #$00
02600  226D  F0 F6                 BEQ WAITSAVEKEYS
02601  226F             
02602  226F  C9 53                 CMP KEYS
02603  2271  F0 13                 BEQ DOSAVE
02604  2273             
02605  2273  C9 54                 CMP KEYT
02606  2275  F0 15                 BEQ DOSAVEDEVSTATUS
02607  2277             
02608  2277  C9 44                 CMP KEYD
02609  2279  F0 17                 BEQ DONEXTSAVEDEV
02610  227B             
02611  227B  C9 2A                 CMP KEYASTERISK
02612  227D  F0 19                 BEQ DOSAVEDEVDIR
02613  227F             
02614  227F  C9 51                 CMP KEYQ
02615  2281  F0 1B                 BEQ SAVEDEVEND
02616  2283             
02617  2283  4C 65 22              JMP WAITSAVEKEYS
02618  2286             
02619  2286             DOSAVE
02620  2286  20 F3 22              JSR SAVETOFILE
02621  2289  4C 42 22              JMP SHOWSAVESCRN
02622  228C             
02623  228C             DOSAVEDEVSTATUS 
02624  228C  20 00 1E              JSR SHOWDEVSTATUS
02625  228F  4C 42 22              JMP SHOWSAVESCRN
02626  2292             
02627  2292             DONEXTSAVEDEV 
02628  2292  20 CD 22              JSR NEXTSAVEDEVNUM
02629  2295  4C 42 22              JMP SHOWSAVESCRN
02630  2298             
02631  2298             DOSAVEDEVDIR 
02632  2298  20 00 1F              JSR SHOWDEVDIR
02633  229B  4C 42 22              JMP SHOWSAVESCRN
02634  229E             
02635  229E             SAVEDEVEND 
02636  229E  A2 00                 LDX #$00
02637  22A0             
02638  22A0             RESTOREFROMSAVE 
02639  22A0  BD 00 5C              LDA SCRNSAVEBASE,X
02640  22A3  9D 00 04              STA DISPLAYBASE,X
02641  22A6  BD 00 5D              LDA SCRNSAVEBASE+$100,X
02642  22A9  9D 00 05              STA DISPLAYBASE+$100,X
02643  22AC  BD 00 5E              LDA SCRNSAVEBASE+$200,X
02644  22AF  9D 00 06              STA DISPLAYBASE+$200,X
02645  22B2  BD 00 5F              LDA SCRNSAVEBASE+$300,X
02646  22B5  9D 00 07              STA DISPLAYBASE+$300,X
02647  22B8  A9 00                 LDA #$00
02648  22BA  9D 00 5C              STA SCRNSAVEBASE,X
02649  22BD  9D 00 5D              STA SCRNSAVEBASE+$100,X
02650  22C0  9D 00 5E              STA SCRNSAVEBASE+$200,X
02651  22C3  9D 00 5F              STA SCRNSAVEBASE+$300,X
02652  22C6  E8                    INX
02653  22C7  D0 D7                 BNE RESTOREFROMSAVE
02654  22C9             
02655  22C9  20 DB 1A              JSR SHOWCHARCURSOR
02656  22CC  60                    RTS
02657  22CD             
02658  22CD             ;
02659  22CD             ; UTILITY FUNCTION : CYCLE SAVE DEVICE NUMBER BETWEEN 1, 8, AND 9
02660  22CD             ;
02661  22CD             NEXTSAVEDEVNUM 
02662  22CD  AD D9 51              LDA DATASAVEDEVNUM
02663  22D0  C9 31                 CMP KEY1
02664  22D2  D0 09                 BNE TSTSAVEDEVNUM8
02665  22D4             
02666  22D4  A9 38                 LDA KEY8
02667  22D6  8D 06 56              STA STORAGEDEVNUM
02668  22D9  8D D9 51              STA DATASAVEDEVNUM
02669  22DC  60                    RTS
02670  22DD             
02671  22DD             TSTSAVEDEVNUM8 
02672  22DD  C9 38                 CMP KEY8
02673  22DF  D0 09                 BNE SETSAVEDEVNUM1
02674  22E1             
02675  22E1  A9 39                 LDA KEY9
02676  22E3  8D D9 51              STA DATASAVEDEVNUM
02677  22E6  8D 06 56              STA STORAGEDEVNUM
02678  22E9  60                    RTS
02679  22EA             
02680  22EA             SETSAVEDEVNUM1 
02681  22EA  A9 31                 LDA KEY1
02682  22EC  8D 06 56              STA STORAGEDEVNUM
02683  22EF  8D D9 51              STA DATASAVEDEVNUM
02684  22F2  60                    RTS
02685  22F3             
02686  22F3             ;
02687  22F3             ; UTILITY FUNCTION : SAVE CHARACTER SET TO FILE ON DEVICE
02688  22F3             ;
02689  22F3             SAVETOFILE 
02690  22F3  A2 00                 LDX #$00
02691  22F5             
02692  22F5             STORSAVEVARS ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02693  22F5  B5 A8                 LDA CHARMEMPOSLO,X
02694  22F7  9D 8B 57              STA VARSSAVEAREA,X
02695  22FA  E8                    INX
02696  22FB  E0 16                 CPX #$16
02697  22FD  D0 F6                 BNE STORSAVEVARS
02698  22FF             
02699  22FF  A2 16                 LDX #$16
02700  2301  A0 00                 LDY #$00
02701  2303  18                    CLC
02702  2304  20 F0 FF              JSR KRNL_PLOT
02703  2307             
02704  2307  A2 00                 LDX #$00
02705  2309             
02706  2309             PRTSAVENAME ; PRINT "FILENAME : "
02707  2309  BD 66 55              LDA DATAFILENAME,X
02708  230C  20 D2 FF              JSR KRNL_CHROUT
02709  230F  E8                    INX
02710  2310  E0 0B                 CPX #$0B
02711  2312  D0 F5                 BNE PRTSAVENAME
02712  2314             
02713  2314  A0 00                 LDY #$00
02714  2316             
02715  2316             SAVENAMECHAR 
02716  2316  20 CF FF              JSR KRNL_CHRIN
02717  2319  C9 0D                 CMP KEYRETURN
02718  231B  F0 08                 BEQ SAVEBYNAME
02719  231D             
02720  231D  99 0B 56              STA FILENAMEINPUT,Y
02721  2320  C8                    INY
02722  2321  C0 15                 CPY #$15
02723  2323  D0 F1                 BNE SAVENAMECHAR
02724  2325             
02725  2325             SAVEBYNAME 
02726  2325  A9 0D                 LDA KEYRETURN
02727  2327  20 D2 FF              JSR KRNL_CHROUT
02728  232A  8C 07 56              STY CHRINLEN
02729  232D             
02730  232D  38                    SEC
02731  232E  AD 06 56              LDA STORAGEDEVNUM
02732  2331  E9 30                 SBC #$30
02733  2333  85 BA                 STA DEVICENUM
02734  2335             
02735  2335  AD 07 56              LDA CHRINLEN
02736  2338  85 B7                 STA FILENAMLEN
02737  233A  A9 0B                 LDA #<FILENAMEINPUT
02738  233C  85 BB                 STA FILENAMELO
02739  233E  A9 56                 LDA #>FILENAMEINPUT
02740  2340  85 BC                 STA FILENAMEHI
02741  2342             
02742  2342  A9 00                 LDA #<CHARMEMBASE
02743  2344  85 C1                 STA DEVICESTARTLO
02744  2346  A9 30                 LDA #>CHARMEMBASE
02745  2348  85 C2                 STA DEVICESTARTHI
02746  234A  A9 00                 LDA #<CHARMEMBASE
02747  234C  85 AE                 STA DEVICEENDLO
02748  234E             
02749  234E  A9 40                 LDA #>CHARMEMBASE+$10
02750  2350  85 AF                 STA DEVICEENDHI
02751  2352  A9 00                 LDA #$00
02752  2354  85 B9                 STA FILESECADDR
02753  2356             
02754  2356  20 EA F5              JSR KRNL_GOSAVE
02755  2359             
02756  2359  20 4E 21              JSR RESTOREPRGVARS
02757  235C  60                    RTS
02758  235D             ;===============================================================================
02759  235D             ; DRAW PIXELS OF CHARACTER IN EDITING GRID
02760  235D             ;===============================================================================
02761  235D             
02762  235D             DRAWEDITROW 
02763  235D  A2 00                 LDX #$00
02764  235F  A1 A8                 LDA (CHARMEMPOSLO,X)
02765  2361  85 BC                 STA TEMPCHARSAVE
02766  2363  A0 80                 LDY #$80
02767  2365  98                    TYA
02768  2366             
02769  2366             SETPIXELBIT 
02770  2366  24 BC                 BIT TEMPCHARSAVE
02771  2368  F0 05                 BEQ SETCLRPIXEL
02772  236A             
02773  236A  A9 A0                 LDA KEYFULLBLOCK
02774  236C  4C 71 23              JMP SETPIXEL
02775  236F             
02776  236F             SETCLRPIXEL 
02777  236F  A9 20                 LDA KEYSPACE
02778  2371             
02779  2371             SETPIXEL
02780  2371  81 B8                 STA (WORKGRIDPOSLO,X)
02781  2373  E6 B8                 INC WORKGRIDPOSLO
02782  2375  D0 02                 BNE NEXTBITPOS
02783  2377  E6 B9                 INC WORKGRIDPOSHI
02784  2379             
02785  2379             NEXTBITPOS 
02786  2379  98                    TYA
02787  237A  4A                    LSR
02788  237B  A8                    TAY
02789  237C  D0 E8                 BNE SETPIXELBIT
02790  237E                        
02791  237E  18                    CLC
02792  237F  A5 B8                 LDA WORKGRIDPOSLO
02793  2381  69 20                 ADC #$20
02794  2383  85 B8                 STA WORKGRIDPOSLO
02795  2385  A5 B9                 LDA WORKGRIDPOSHI
02796  2387  69 00                 ADC #$00
02797  2389  85 B9                 STA WORKGRIDPOSHI
02798  238B             
02799  238B  E6 A8                 INC CHARMEMPOSLO
02800  238D  D0 02                 BNE DRAWROWEXIT
02801  238F  E6 A9                 INC CHARMEMPOSHI
02802  2391             
02803  2391             DRAWROWEXIT 
02804  2391  60                    RTS
02805  2392             ;===============================================================================
02806  2392             ; PRINT HEX VALUES
02807  2392             ;===============================================================================
02808  2392             
02809  2392             ;
02810  2392             ; UTILITY FUNCTION : PRINT HEX VALUES FOR EACH ROW IN 8*8 EDITING GRID
02811  2392             ;
02812  2392             PRINTHEXROWS 
02813  2392  A9 01                 LDA EDITGRIDHEXROW
02814  2394  8D A5 23              STA LOADROWNUM+1
02815  2397             
02816  2397  A0 00                 LDY #$00
02817  2399             
02818  2399             PRINTHEXROW 
02819  2399  A2 00                 LDX #$00
02820  239B  B1 A8                 LDA (CHARMEMPOSLO),Y
02821  239D  8D 02 56              STA HEXCHARTOPRINT
02822  23A0  98                    TYA
02823  23A1  48                    PHA
02824  23A2  8A                    TXA
02825  23A3  48                    PHA
02826  23A4             
02827  23A4             LOADROWNUM 
02828  23A4  A2 01                 LDX EDITGRIDHEXROW ; LINE NUMBER - INCREMENTED
02829  23A6  A0 0B                 LDY EDITGRIDHEXCOL ; COLUMN TO RIGHT OF 8*8 EDITING GRID
02830  23A8  18                    CLC
02831  23A9  20 F0 FF              JSR KRNL_PLOT
02832  23AC  20 C1 23              JSR PRINTHEXBYTE
02833  23AF  68                    PLA
02834  23B0  AA                    TAX
02835  23B1  68                    PLA
02836  23B2  A8                    TAY
02837  23B3  EE A5 23              INC LOADROWNUM+1
02838  23B6  C8                    INY
02839  23B7  C0 08                 CPY #$08
02840  23B9  D0 DE                 BNE PRINTHEXROW
02841  23BB             
02842  23BB  A9 01                 LDA EDITGRIDHEXROW
02843  23BD  8D A5 23              STA LOADROWNUM+1
02844  23C0  60                    RTS
02845  23C1             
02846  23C1             ;
02847  23C1             ; UTILITY FUNCTION : PRINT HEX BYTE AS 2-CHARS
02848  23C1             ;
02849  23C1             PRINTHEXBYTE 
02850  23C1  AC 02 56              LDY HEXCHARTOPRINT
02851  23C4  98                    TYA
02852  23C5  48                    PHA
02853  23C6  20 CE 23              JSR PRINTHINIBBLE
02854  23C9  68                    PLA
02855  23CA  20 D3 23              JSR PRINTLONIBBLE
02856  23CD  60                    RTS
02857  23CE             
02858  23CE             PRINTHINIBBLE 
02859  23CE  18                    CLC
02860  23CF  6A                    ROR
02861  23D0  6A                    ROR
02862  23D1  6A                    ROR
02863  23D2  6A                    ROR
02864  23D3             
02865  23D3             PRINTLONIBBLE 
02866  23D3  29 0F                 AND #$0F
02867  23D5  18                    CLC
02868  23D6  69 30                 ADC #$30         ; TURN IN TO ASCII 0-9
02869  23D8  C9 3A                 CMP #$3A
02870  23DA  90 02                 BCC PRINTHEXCHAR ; PRINT 0-9 ELSE ADD 6 FOR A-F ASCII CHARS BEFORE PRITING
02871  23DC  69 06                 ADC #$06
02872  23DE             
02873  23DE             PRINTHEXCHAR 
02874  23DE  20 D2 FF              JSR KRNL_CHROUT
02875  23E1  60                    RTS
02876  23E2             ;===============================================================================
02877  23E2             ; JOYSTICK MONITOR ROUTINES
02878  23E2             ;===============================================================================
02879  23E2             
02880  23E2             ;
02881  23E2             ; UTILITY FUNCTION : MONITOR JOYSTICK IN 8*8 EDIT GRID
02882  23E2             ;
02883  23E2             ALIGN
02884  2400             CHECKEDITSTICK 
02885  2400  CE 03 56              DEC EDITSTICKCOUNT
02886  2403  F0 01                 BEQ RXEDITSTICK         ; ONLY PROCESS JOYSTICK PORT EVERY NTH CALL
02887  2405  60                    RTS
02888  2406             
02889  2406             RXEDITSTICK 
02890  2406  A9 03                 LDA EDITSTICKDELAY      ; RESET PROCESS EVERY NTH COUNTER
02891  2408  8D 03 56              STA EDITSTICKCOUNT
02892  240B             
02893  240B  AD 00 DC              LDA JOYSTICKPORT2
02894  240E  8D 04 56              STA JOYSTICKBITS
02895  2411  29 10                 AND #$10
02896  2413  D0 01                 BNE CHECKFORUP
02897  2415  60                    RTS
02898  2416             
02899  2416             CHECKFORUP 
02900  2416  AD 04 56              LDA JOYSTICKBITS
02901  2419  29 01                 AND #$01                ; TEST JOYSTICK UP PRESSED, 0 = PRESSED
02902  241B  D0 0B                 BNE CHECKFORDOWN
02903  241D             
02904  241D  20 D1 24              JSR MOVECRSRUP
02905  2420  AD 04 56              LDA JOYSTICKBITS
02906  2423  F0 03                 BEQ CHECKFORDOWN
02907  2425             
02908  2425  4C 5B 24              JMP DONEMONSTICK
02909  2428             
02910  2428             CHECKFORDOWN 
02911  2428  AD 04 56              LDA JOYSTICKBITS
02912  242B  29 02                 AND #$02                ; TEST JOYSTICK DOWN PRESSED, 0 = PRESSED
02913  242D  D0 0B                 BNE CHECKFORLEFT
02914  242F             
02915  242F  20 14 25              JSR MOVECRSRDOWN
02916  2432  AD 05 56              LDA CURSORMOVED
02917  2435  F0 03                 BEQ CHECKFORLEFT
02918  2437             
02919  2437  4C 5B 24              JMP DONEMONSTICK
02920  243A             
02921  243A             CHECKFORLEFT 
02922  243A  AD 04 56              LDA JOYSTICKBITS
02923  243D  29 04                 AND #$04                ; TEST JOYSTICK LEFT PRESSED, 0 = PRESSED
02924  243F  D0 0B                 BNE CHECKFORRIGHT
02925  2441             
02926  2441  20 59 25              JSR MOVECRSRLEFT
02927  2444  AD 05 56              LDA CURSORMOVED
02928  2447  F0 03                 BEQ CHECKFORRIGHT
02929  2449             
02930  2449  4C 5B 24              JMP DONEMONSTICK
02931  244C             
02932  244C             CHECKFORRIGHT 
02933  244C  AD 04 56              LDA JOYSTICKBITS
02934  244F  29 08                 AND #$08                ; TEST JOYSTICK RIGHT PRESSED, 0 = PRESSED
02935  2451  D0 11                 BNE EXITMONSTICK
02936  2453             
02937  2453  20 AF 25              JSR MOVECRSRRIGHT
02938  2456  AD 05 56              LDA CURSORMOVED
02939  2459  F0 09                 BEQ EXITMONSTICK
02940  245B             
02941  245B             DONEMONSTICK 
02942  245B  8E 77 02              STX KEYBDBUFFERBASE
02943  245E  A5 C6                 LDA KEYBDBUFFERLEN
02944  2460  D0 02                 BNE EXITMONSTICK
02945  2462             
02946  2462  E6 C6                 INC KEYBDBUFFERLEN
02947  2464             
02948  2464             EXITMONSTICK 
02949  2464  60                    RTS
02950  2465             
02951  2465             ;
02952  2465             ; UTILITY FUNCTION: MONITOR JOYSTICK IN 20*6 EDIT GRID
02953  2465             ;
02954  2465             CHECKCHARSTICK 
02955  2465  CE 08 56              DEC CHARSTICKCOUNT
02956  2468  F0 01                 BEQ RXCHARSTICK                 ; ONLY PROCESS JOYSTICK PORT EVERY NTH CALL
02957  246A  60                    RTS
02958  246B                        
02959  246B             RXCHARSTICK 
02960  246B  A9 05                 LDA CHARSTICKDELAY
02961  246D  8D 08 56              STA CHARSTICKCOUNT
02962  2470             
02963  2470  AD 00 DC              LDA JOYSTICKPORT2
02964  2473  C9 7E                 CMP #$7E                        ; UP PRESS?
02965  2475  F0 0D                 BEQ CHARMOVEDUP
02966  2477                        
02967  2477  C9 7D                 CMP #$7D
02968  2479  F0 15                 BEQ CHARMOVEDDOWN               ; DOWN PRESS?
02969  247B             
02970  247B  C9 7B                 CMP #$7B
02971  247D  F0 1D                 BEQ CHARMOVEDLEFT               ; LEFT PRESS?
02972  247F             
02973  247F  C9 77                 CMP #$77
02974  2481  F0 25                 BEQ CHARMOVEDRIGHT              ; RIGHT PRESS?
02975  2483  60                    RTS
02976  2484             
02977  2484             CHARMOVEDUP 
02978  2484  AD 15 1D              LDA CHARCURSORROW+1             ; UP
02979  2487  C9 0B                 CMP CHARCRSRHOMEROW
02980  2489  D0 01                 BNE CHARMOVEUP
02981  248B  60                    RTS
02982  248C             
02983  248C             CHARMOVEUP 
02984  248C  CE 15 1D              DEC CHARCURSORROW+1             ; MOVE UP
02985  248F  60                    RTS
02986  2490             
02987  2490             CHARMOVEDDOWN 
02988  2490  AD 15 1D              LDA CHARCURSORROW+1             ; DOWN
02989  2493  C5 10                 CMP CHARCRSRHOMEROW+$5
02990  2495  D0 01                 BNE CHARMOVEDOWN
02991  2497  60                    RTS
02992  2498             
02993  2498             CHARMOVEDOWN 
02994  2498  EE 15 1D              INC CHARCURSORROW+1             ; MOVE DOWN
02995  249B  60                    RTS
02996  249C             
02997  249C             CHARMOVEDLEFT 
02998  249C  AD 17 1D              LDA CHARCURSORCOL+1             ; LEFT
02999  249F  C9 01                 CMP CHARCRSRHOMECOL
03000  24A1  D0 01                 BNE CHARMOVELEFT
03001  24A3  60                    RTS
03002  24A4             
03003  24A4             CHARMOVELEFT 
03004  24A4  CE 17 1D              DEC CHARCURSORCOL+1             ; MOVE LEFT
03005  24A7  60                    RTS
03006  24A8             
03007  24A8             CHARMOVEDRIGHT 
03008  24A8  AD 17 1D              LDA CHARCURSORCOL+1             ; RIGHT
03009  24AB  C5 1E                 CMP CHARCRSRHOMEROW+$13
03010  24AD  D0 01                 BNE CHARMOVERIGHT
03011  24AF  60                    RTS
03012  24B0             
03013  24B0             CHARMOVERIGHT 
03014  24B0  EE 17 1D              INC CHARCURSORCOL+1             ; MOVE RIGHT
03015  24B3  60                    RTS
03016  24B4             
03017  24B4             ;
03018  24B4             ; UTILITY FUNCTION : CHECK JOYSTICK FIRE BUTTON EVERY N-TH CALL
03019  24B4             ;
03020  24B4             MONITORFIREBTN 
03021  24B4  CE 09 56              DEC FIREBTNCOUNTER
03022  24B7  AD 09 56              LDA FIREBTNCOUNTER
03023  24BA  C9 00                 CMP #$00
03024  24BC  F0 01                 BEQ PROCESSFIREBTN
03025  24BE  60                    RTS
03026  24BF             
03027  24BF             PROCESSFIREBTN 
03028  24BF  A9 03                 LDA FIREBTNDELAY
03029  24C1  8D 09 56              STA FIREBTNCOUNTER
03030  24C4  20 AE 11              JSR CHECKFIREBTN
03031  24C7  60                    RTS
03032  24C8             ;===============================================================================
03033  24C8             ; MOVE EDITING GRID CURSOR ROUTINES
03034  24C8             ;===============================================================================
03035  24C8             
03036  24C8             ;
03037  24C8             ; COMMAND HANDLER : SET EDITING GRID CURSOR TO HOME POSITION
03038  24C8             ;
03039  24C8             HOMECURSOR 
03040  24C8  A9 29                 LDA #<EDITGRIDHOME
03041  24CA  85 AA                 STA EDITGRIDPOSLO
03042  24CC  A9 04                 LDA #>EDITGRIDHOME
03043  24CE  85 AB                 STA EDITGRIDPOSHI
03044  24D0  60                    RTS
03045  24D1             
03046  24D1             ;
03047  24D1             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR UP
03048  24D1             ;
03049  24D1             MOVECRSRUP 
03050  24D1  A2 00                 LDX #$00
03051  24D3  A1 AA                 LDA (EDITGRIDPOSLO,X)
03052  24D5  85 BC                 STA TEMPCHARSAVE
03053  24D7             
03054  24D7             LOOP9
03055  24D7  A5 AA                 LDA EDITGRIDPOSLO       ; CONFIRM NOT TRYING TO MOVE UP IF CURSOR ON TOP LINE
03056  24D9             
03057  24D9             DATAIDX7
03058  24D9  C9 29                 CMP #<EDITGRIDHOME
03059  24DB  D0 11                 BNE JMP14
03060  24DD             
03061  24DD  A5 AB                 LDA EDITGRIDPOSHI
03062  24DF  C9 04                 CMP #>EDITGRIDHOME
03063  24E1  D0 0B                 BNE JMP14
03064  24E3             
03065  24E3  A9 29                 LDA #<EDITGRIDHOME
03066  24E5  8D DA 24              STA DATAIDX7+1
03067  24E8                        
03068  24E8  A9 00                 LDA #$00
03069  24EA  8D 05 56              STA CURSORMOVED
03070  24ED  60                    RTS
03071  24EE             
03072  24EE             JMP14
03073  24EE  EE DA 24              INC DATAIDX7+1
03074  24F1  E8                    INX
03075  24F2  E0 08                 CPX #$08
03076  24F4  D0 E1                 BNE LOOP9
03077  24F6                        
03078  24F6  A5 BC                 LDA TEMPCHARSAVE
03079  24F8  A2 00                 LDX #$00
03080  24FA  81 AA                 STA (EDITGRIDPOSLO,X)
03081  24FC  38                    SEC
03082  24FD  A5 AA                 LDA EDITGRIDPOSLO
03083  24FF  E9 28                 SBC #$28
03084  2501  85 AA                 STA EDITGRIDPOSLO
03085  2503  A5 AB                 LDA EDITGRIDPOSHI
03086  2505  E9 00                 SBC #$00
03087  2507  85 AB                 STA EDITGRIDPOSHI
03088  2509             
03089  2509  A9 29                 LDA #<EDITGRIDHOME
03090  250B  8D DA 24              STA DATAIDX7+1
03091  250E             
03092  250E  A9 01                 LDA #$01
03093  2510  8D 05 56              STA CURSORMOVED
03094  2513  60                    RTS
03095  2514             
03096  2514             ;
03097  2514             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR DOWN
03098  2514             ;
03099  2514             MOVECRSRDOWN 
03100  2514  A2 00                 LDX #$00
03101  2516  A1 AA                 LDA (EDITGRIDPOSLO,X)
03102  2518  85 BC                 STA TEMPCHARSAVE
03103  251A             
03104  251A             LOOP10
03105  251A  A5 AA                 LDA EDITGRIDPOSLO
03106  251C             
03107  251C             DATAIDX8
03108  251C  C9 41                 CMP #$41
03109  251E  D0 11                 BNE JMP15
03110  2520             
03111  2520  A5 AB                 LDA EDITGRIDPOSHI
03112  2522  C9 05                 CMP #$05
03113  2524  D0 0B                 BNE JMP15
03114  2526             
03115  2526  A9 41                 LDA #$41
03116  2528  8D 1D 25              STA DATAIDX8+1
03117  252B             
03118  252B  A9 00                 LDA #$00
03119  252D  8D 05 56              STA CURSORMOVED
03120  2530  60                    RTS
03121  2531             
03122  2531             JMP15
03123  2531  EE 1D 25              INC DATAIDX8+1
03124  2534  E8                    INX
03125  2535  E0 08                 CPX #$08
03126  2537  D0 E1                 BNE LOOP10
03127  2539                        
03128  2539  A5 BC                 LDA TEMPCHARSAVE
03129  253B  A2 00                 LDX #$00
03130  253D  81 AA                 STA (EDITGRIDPOSLO,X)
03131  253F  18                    CLC
03132  2540  A5 AA                 LDA EDITGRIDPOSLO
03133  2542  69 28                 ADC #$28
03134  2544  85 AA                 STA EDITGRIDPOSLO
03135  2546  A5 AB                 LDA EDITGRIDPOSHI
03136  2548  69 00                 ADC #$00
03137  254A  85 AB                 STA EDITGRIDPOSHI
03138  254C  A2 11                 LDX #$11
03139  254E  A9 41                 LDA #$41
03140  2550  8D 1D 25              STA DATAIDX8+1
03141  2553             
03142  2553  A9 01                 LDA #$01
03143  2555  8D 05 56              STA CURSORMOVED
03144  2558  60                    RTS
03145  2559             
03146  2559             ;
03147  2559             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR LEFT
03148  2559             ;
03149  2559             MOVECRSRLEFT 
03150  2559  A2 00                 LDX #$00
03151  255B  A1 AA                 LDA (EDITGRIDPOSLO,X)
03152  255D  85 BC                 STA TEMPCHARSAVE
03153  255F             
03154  255F             LOOP11
03155  255F  A5 AA                 LDA EDITGRIDPOSLO
03156  2561             
03157  2561             DATAIDX13
03158  2561  C9 29                 CMP #<EDITGRIDHOME
03159  2563  D0 16                 BNE JMP16
03160  2565             
03161  2565  A5 AB                 LDA EDITGRIDPOSHI
03162  2567             
03163  2567             DATAIDX14
03164  2567  C9 04                 CMP #>EDITGRIDHOME
03165  2569  D0 10                 BNE JMP16
03166  256B             
03167  256B  A9 29                 LDA #<EDITGRIDHOME
03168  256D  8D 62 25              STA DATAIDX13+1
03169  2570  A9 04                 LDA #>EDITGRIDHOME
03170  2572  8D 68 25              STA DATAIDX14+1
03171  2575             
03172  2575  A9 00                 LDA #$00
03173  2577  8D 05 56              STA CURSORMOVED
03174  257A  60                    RTS
03175  257B             
03176  257B             JMP16
03177  257B  18                    CLC
03178  257C  AD 62 25              LDA DATAIDX13+1
03179  257F  69 28                 ADC #$28
03180  2581  8D 62 25              STA DATAIDX13+1
03181  2584  AD 68 25              LDA DATAIDX14+1
03182  2587  69 00                 ADC #$00
03183  2589  8D 68 25              STA DATAIDX14+1
03184  258C  E8                    INX
03185  258D  E0 08                 CPX #$08
03186  258F  D0 CE                 BNE LOOP11
03187  2591             
03188  2591  A5 BC                 LDA TEMPCHARSAVE
03189  2593  A2 00                 LDX #$00
03190  2595  81 AA                 STA (EDITGRIDPOSLO,X)
03191  2597  C6 AA                 DEC EDITGRIDPOSLO
03192  2599  D0 02                 BNE JMP17
03193  259B  C6 AB                 DEC EDITGRIDPOSHI
03194  259D             
03195  259D             JMP17
03196  259D  A2 9D                 LDX #$9D
03197  259F             
03198  259F  A9 01                 LDA #$01
03199  25A1  8D 05 56              STA CURSORMOVED
03200  25A4             
03201  25A4  A9 29                 LDA #<EDITGRIDHOME
03202  25A6  8D 62 25              STA DATAIDX13+1
03203  25A9  A9 04                 LDA #>EDITGRIDHOME
03204  25AB  8D 68 25              STA DATAIDX14+1
03205  25AE  60                    RTS
03206  25AF             
03207  25AF             ;
03208  25AF             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR RIGHT
03209  25AF             ;
03210  25AF             MOVECRSRRIGHT 
03211  25AF  A2 00                 LDX #$00
03212  25B1  A1 AA                 LDA (EDITGRIDPOSLO,X)
03213  25B3  85 BC                 STA TEMPCHARSAVE
03214  25B5             
03215  25B5             LOOP12
03216  25B5  A5 AA                 LDA EDITGRIDPOSLO
03217  25B7             
03218  25B7             DATAIDX15
03219  25B7  C9 30                 CMP #<EDITGRIDHOME+$7
03220  25B9  D0 16                 BNE JMP18
03221  25BB             
03222  25BB  A5 AB                 LDA EDITGRIDPOSHI
03223  25BD             
03224  25BD             DATAIDX16
03225  25BD  C9 04                 CMP #>EDITGRIDHOME
03226  25BF  D0 10                 BNE JMP18
03227  25C1             
03228  25C1  A9 30                 LDA #<EDITGRIDHOME+$7
03229  25C3  8D B8 25              STA DATAIDX15+1
03230  25C6  A9 04                 LDA #>EDITGRIDHOME
03231  25C8  8D BE 25              STA DATAIDX16+1
03232  25CB             
03233  25CB  A9 00                 LDA #$00
03234  25CD  8D 05 56              STA CURSORMOVED
03235  25D0  60                    RTS
03236  25D1             
03237  25D1             JMP18
03238  25D1  18                    CLC
03239  25D2  AD B8 25              LDA DATAIDX15+1
03240  25D5  69 28                 ADC #$28
03241  25D7  8D B8 25              STA DATAIDX15+1
03242  25DA  AD BE 25              LDA DATAIDX16+1
03243  25DD  69 00                 ADC #$00
03244  25DF  8D BE 25              STA DATAIDX16+1
03245  25E2  E8                    INX
03246  25E3  E0 08                 CPX #$08
03247  25E5  D0 CE                 BNE LOOP12
03248  25E7             
03249  25E7  A5 BC                 LDA TEMPCHARSAVE
03250  25E9  A2 00                 LDX #$00
03251  25EB  81 AA                 STA (EDITGRIDPOSLO,X)
03252  25ED  E6 AA                 INC EDITGRIDPOSLO
03253  25EF  D0 02                 BNE JMP19
03254  25F1             
03255  25F1  E6 AB                 INC EDITGRIDPOSHI
03256  25F3             
03257  25F3             JMP19
03258  25F3  A9 01                 LDA #$01
03259  25F5  8D 05 56              STA CURSORMOVED
03260  25F8  A9 30                 LDA #<EDITGRIDHOME+$7
03261  25FA  8D B8 25              STA DATAIDX15+1
03262  25FD  A9 04                 LDA #>EDITGRIDHOME
03263  25FF  8D BE 25              STA DATAIDX16+1
03264  2602  60                    RTS
03265  2603             
03266  2603             *=$4000
03267  4000             ;===============================================================================
03268  4000             ; MAIN SCREEN DATA
03269  4000             ;===============================================================================
03270  4000             
03271  4000             DATASCRNMAIN 
03272  4000  70 43 43              BYTE $70,$43,$43,$43,$43,$43,$43,$43,$43,$72,$43,$43,$43,$72,$43,$43
03273  4010  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$72,$43,$43,$43,$43,$43,$43,$43
03274  4020  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$6E,$42,$A0,$A0,$A0,$20,$20,$20,$20
03275  4030  20 42 24              BYTE $20,$42,$24,$05,$30,$42,$07,$12,$09,$04,$3A,$20,$20,$38,$2A,$38
03276  4040  42 86 8F              BYTE $42,$86,$8F,$8E,$94,$A0,$86,$81,$83,$94,$8F,$92,$99,$A0,$B2,$42
03277  4050  42 A0 20              BYTE $42,$A0,$20,$20,$20,$20,$20,$20,$20,$42,$24,$38,$30,$6B,$43,$43
03278  4060  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$71,$43,$43,$43,$43,$43,$43,$43
03279  4070  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$73,$42,$A0,$20,$20,$20,$20,$20,$20
03280  4080  20 42 24              BYTE $20,$42,$24,$38,$30,$42,$20,$0B,$05,$19,$20,$27,$08,$27,$20,$06
03281  4090  0F 12 20              BYTE $0F,$12,$20,$08,$05,$0C,$10,$20,$13,$03,$12,$05,$05,$0E,$20,$42
03282  40A0  42 A0 A0              BYTE $42,$A0,$A0,$A0,$20,$20,$20,$20,$20,$42,$24,$05,$30,$42,$95,$90
03283  40B0  90 85 92              BYTE $90,$85,$92,$20,$8F,$92,$20,$8C,$8F,$97,$85,$92,$20,$93,$85,$94
03284  40C0  20 28 95              BYTE $20,$28,$95,$AF,$8C,$29,$3F,$42,$42,$20,$20,$20,$A0,$20,$20,$E0
03285  40D0  20 42 24              BYTE $20,$42,$24,$31,$32,$42,$20,$20,$4E,$20,$20,$20,$60,$20,$20,$20
03286  40E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$42
03287  40F0  42 20 20              BYTE $42,$20,$20,$20,$A0,$A0,$20,$E0,$20,$42,$24,$31,$01,$42,$20,$4E
03288  4100  4F 77 20              BYTE $4F,$77,$20,$4F,$77,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03289  4110  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$42,$42,$20,$20,$20,$A0,$20,$A0,$A0
03290  4120  20 42 24              BYTE $20,$42,$24,$31,$36,$42,$4E,$65,$4C,$6F,$20,$4C,$6F,$20,$20,$20
03291  4130  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$42
03292  4140  42 20 20              BYTE $42,$20,$20,$20,$A0,$20,$20,$A0,$20,$42,$24,$31,$32,$42,$20,$65
03293  4150  65 20 20              BYTE $65,$20,$20,$65,$20,$03,$2E,$0E,$0F,$14,$14,$09,$0E,$07,$08,$01
03294  4160  0D 70 43              BYTE $0D,$70,$43,$43,$43,$43,$43,$7D,$6D,$43,$43,$43,$43,$43,$43,$43
03295  4170  43 71 43              BYTE $43,$71,$43,$43,$43,$71,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43
03296  4180  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$43,$7D,$00,$20,$3D,$24,$30,$30
03297  4190  70 43 43              BYTE $70,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43
03298  41A0  43 43 43              BYTE $43,$43,$43,$43,$43,$6E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03299  41B0  20 20 00              BYTE $20,$20,$00,$20,$20,$20,$20,$20,$42,$00,$01,$02,$03,$04,$05,$06
03300  41C0  07 08 09              BYTE $07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$42,$20,$20
03301  41D0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03302  41E0  42 14 15              BYTE $42,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22
03303  41F0  23 24 25              BYTE $23,$24,$25,$26,$27,$42,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03304  4200  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$42,$28,$29,$2A,$2B,$2C,$2D,$2E
03305  4210  2F 30 31              BYTE $2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$42,$20,$20
03306  4220  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03307  4230  42 3C 3D              BYTE $42,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A
03308  4240  4B 4C 4D              BYTE $4B,$4C,$4D,$4E,$4F,$42,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03309  4250  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$42,$50,$51,$52,$53,$54,$55,$56
03310  4260  57 58 59              BYTE $57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$42,$20,$20
03311  4270  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03312  4280  42 64 65              BYTE $42,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72
03313  4290  73 74 75              BYTE $73,$74,$75,$76,$77,$42,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03314  42A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$6D,$43,$43,$43,$43,$43,$43,$43
03315  42B0  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$7D,$20,$20
03316  42C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03317  42D0  20 00 01              BYTE $20,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E
03318  42E0  0F 10 11              BYTE $0F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E
03319  42F0  1F 20 21              BYTE $1F,$20,$21,$22,$23,$24,$25,$20,$20,$26,$27,$28,$29,$2A,$2B,$2C
03320  4300  2D 2E 2F              BYTE $2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C
03321  4310  3D 3E 3F              BYTE $3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$20
03322  4320  20 4C 4D              BYTE $20,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A
03323  4330  5B 5C 5D              BYTE $5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A
03324  4340  6B 6C 6D              BYTE $6B,$6C,$6D,$6E,$6F,$70,$71,$20,$20,$72,$73,$74,$75,$76,$77,$78
03325  4350  79 7A 7B              BYTE $79,$7A,$7B,$7C,$7D,$7E,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88
03326  4360  89 8A 8B              BYTE $89,$8A,$8B,$8C,$8D,$8E,$8F,$90,$91,$92,$93,$94,$95,$96,$97,$20
03327  4370  20 98 99              BYTE $20,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6
03328  4380  A7 A8 A9              BYTE $A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$B4,$B5,$B6
03329  4390  B7 B8 B9              BYTE $B7,$B8,$B9,$BA,$BB,$BC,$BD,$20,$20,$BE,$BF,$C0,$C1,$C2,$C3,$C4
03330  43A0  C5 C6 C7              BYTE $C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$D0,$D1,$D2,$D3,$D4
03331  43B0  D5 D6 D7              BYTE $D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$E0,$E1,$E2,$E3,$20
03332  43C0  20 E4 E5              BYTE $20,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F0,$F1,$F2
03333  43D0  F3 F4 F5              BYTE $F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$20,$20,$20
03334  43E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03335  43F0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03336  4400             ;===============================================================================
03337  4400             ; HELP SCREEN DATA
03338  4400             ;===============================================================================
03339  4400             
03340  4400             DATASCRNHELP1 
03341  4400  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03342  4410  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03343  4420  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03344  4430  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03345  4440  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03346  4450  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03347  4460  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03348  4470  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$13,$10,$03,$20,$20,$3A
03349  4480  10 09 18              BYTE $10,$09,$18,$05,$0C,$20,$0F,$0E,$2F,$0F,$06,$06,$20,$20,$20,$20
03350  4490  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03351  44A0  20 20 20              BYTE $20,$20,$20,$2B,$20,$20,$20,$3A,$09,$0E,$03,$12,$05,$01,$13,$05
03352  44B0  20 03 08              BYTE $20,$03,$08,$01,$12,$20,$09,$0E,$20,$07,$12,$09,$04,$20,$20,$20
03353  44C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$20,$20,$20,$3A
03354  44D0  04 05 03              BYTE $04,$05,$03,$12,$05,$01,$13,$05,$20,$03,$08,$01,$12,$20,$09,$0E
03355  44E0  20 07 12              BYTE $20,$07,$12,$09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03356  44F0  20 20 20              BYTE $20,$20,$20,$08,$20,$20,$20,$3A,$14,$08,$09,$13,$20,$13,$03,$12
03357  4500  05 05 0E              BYTE $05,$05,$0E,$21,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03358  4510  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$15,$20,$20,$20,$3A
03359  4520  13 03 12              BYTE $13,$03,$12,$0F,$0C,$0C,$20,$38,$2A,$38,$20,$07,$12,$09,$04,$20
03360  4530  15 10 20              BYTE $15,$10,$20,$0F,$0E,$05,$20,$10,$09,$18,$05,$0C,$20,$20,$20,$20
03361  4540  20 20 20              BYTE $20,$20,$20,$04,$20,$20,$20,$3A,$13,$03,$12,$0F,$0C,$0C,$20,$38
03362  4550  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$04,$0F,$17,$0E,$20,$0F,$0E,$05
03363  4560  20 10 09              BYTE $20,$10,$09,$18,$05,$0C,$20,$20,$20,$20,$20,$0C,$20,$20,$20,$3A
03364  4570  12 0F 14              BYTE $12,$0F,$14,$01,$14,$05,$20,$38,$2A,$38,$20,$07,$12,$09,$04,$20
03365  4580  0C 05 06              BYTE $0C,$05,$06,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03366  4590  20 20 20              BYTE $20,$20,$20,$12,$20,$20,$20,$3A,$12,$0F,$14,$01,$14,$05,$20,$38
03367  45A0  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$12,$09,$07,$08,$14,$20,$20,$20
03368  45B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$09,$20,$20,$20,$3A
03369  45C0  09 0E 10              BYTE $09,$0E,$10,$15,$14,$20,$06,$12,$0F,$0D,$20,$01,$20,$04,$05,$16
03370  45D0  09 03 05              BYTE $09,$03,$05,$20,$2B,$20,$04,$09,$13,$03,$20,$15,$14,$09,$0C,$13
03371  45E0  20 20 20              BYTE $20,$20,$20,$0F,$20,$20,$20,$3A,$0F,$15,$14,$10,$15,$14,$20,$14
03372  45F0  0F 20 01              BYTE $0F,$20,$01,$20,$04,$05,$16,$09,$03,$05,$20,$2B,$20,$04,$09,$13
03373  4600  03 20 15              BYTE $03,$20,$15,$14,$09,$0C,$13,$20,$20,$20,$20,$17,$20,$20,$20,$3A
03374  4610  13 17 01              BYTE $13,$17,$01,$10,$20,$17,$09,$0E,$04,$0F,$17,$20,$0D,$01,$10,$13
03375  4620  3A 38 2A              BYTE $3A,$38,$2A,$38,$20,$14,$0F,$20,$32,$30,$2A,$36,$20,$16,$2E,$16
03376  4630  20 20 20              BYTE $20,$20,$20,$03,$20,$20,$20,$20,$03,$0F,$10,$19,$20,$12,$0F,$0D
03377  4640  20 03 08              BYTE $20,$03,$08,$01,$12,$20,$14,$0F,$20,$10,$0F,$13,$20,$09,$0E,$20
03378  4650  03 08 01              BYTE $03,$08,$01,$12,$20,$13,$05,$14,$20,$20,$20,$18,$20,$20,$20,$3A
03379  4660  05 18 09              BYTE $05,$18,$09,$14,$20,$10,$12,$0F,$07,$12,$01,$0D,$20,$20,$20,$20
03380  4670  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03381  4680  20 20 20              BYTE $20,$20,$20,$2A,$20,$20,$20,$3A,$12,$0F,$14,$01,$14,$05,$20,$14
03382  4690  08 12 0F              BYTE $08,$12,$0F,$15,$07,$08,$20,$33,$36,$30,$20,$09,$0E,$20,$39,$30
03383  46A0  20 13 14              BYTE $20,$13,$14,$05,$10,$13,$20,$20,$20,$20,$20,$06,$31,$20,$20,$3A
03384  46B0  12 05 16              BYTE $12,$05,$16,$05,$12,$13,$05,$20,$10,$09,$18,$05,$0C,$13,$20,$09
03385  46C0  0E 20 07              BYTE $0E,$20,$07,$12,$09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03386  46D0  20 20 20              BYTE $20,$20,$20,$06,$33,$20,$20,$3A,$03,$0C,$05,$01,$12,$20,$07,$12
03387  46E0  09 04 20              BYTE $09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03388  46F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$06,$35,$20,$20,$3A
03389  4700  0D 0F 16              BYTE $0D,$0F,$16,$05,$20,$03,$15,$12,$13,$0F,$12,$20,$15,$10,$20,$0F
03390  4710  0E 05 20              BYTE $0E,$05,$20,$0C,$09,$0E,$05,$20,$09,$0E,$20,$13,$05,$14,$20,$20
03391  4720  20 20 20              BYTE $20,$20,$20,$06,$37,$20,$20,$3A,$0D,$0F,$16,$05,$20,$03,$15,$12
03392  4730  13 0F 12              BYTE $13,$0F,$12,$20,$04,$0F,$17,$0E,$20,$0F,$0E,$05,$20,$0C,$09,$0E
03393  4740  05 20 09              BYTE $05,$20,$09,$0E,$20,$13,$05,$20,$20,$20,$08,$0F,$0D,$05,$20,$3A
03394  4750  10 0C 01              BYTE $10,$0C,$01,$03,$05,$20,$03,$15,$12,$0F,$13,$12,$20,$09,$0E,$20
03395  4760  38 2A 38              BYTE $38,$2A,$38,$20,$14,$0F,$20,$08,$0F,$0D,$05,$20,$10,$0F,$13,$2E
03396  4770  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03397  4780  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03398  4790  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03399  47A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03400  47B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03401  47C0  20 20 20              BYTE $20,$20,$20,$2A,$2A,$20,$90,$92,$85,$93,$93,$A0,$93,$90,$81,$83
03402  47D0  85 A0 82              BYTE $85,$A0,$82,$81,$92,$A0,$94,$8F,$A0,$83,$8F,$8E,$94,$89,$8E,$95
03403  47E0  85 20 2A              BYTE $85,$20,$2A,$2A,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03404  47F0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03405  4800             
03406  4800             DATASCRNHELP2 
03407  4800  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03408  4810  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03409  4820  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03410  4830  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03411  4840  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03412  4850  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03413  4860  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03414  4870  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03415  4880  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03416  4890  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03417  48A0  20 20 3E              BYTE $20,$20,$3E,$20,$20,$3A,$0D,$09,$12,$12,$0F,$12,$20,$38,$2A,$38
03418  48B0  20 09 0D              BYTE $20,$09,$0D,$01,$07,$05,$20,$0C,$05,$06,$14,$2F,$12,$09,$07,$08
03419  48C0  14 20 20              BYTE $14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$3C,$20,$20,$3A,$0D,$09
03420  48D0  12 12 0F              BYTE $12,$12,$0F,$12,$20,$38,$2A,$38,$20,$09,$0D,$01,$07,$05,$20,$15
03421  48E0  10 2F 04              BYTE $10,$2F,$04,$0F,$17,$0E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03422  48F0  20 20 1E              BYTE $20,$20,$1E,$20,$20,$3A,$03,$0C,$05,$01,$12,$20,$32,$30,$2A,$36
03423  4900  20 07 12              BYTE $20,$07,$12,$09,$04,$20,$17,$09,$14,$08,$20,$13,$10,$01,$03,$05
03424  4910  13 20 20              BYTE $13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$3D,$20,$20,$3A,$06,$09
03425  4920  0C 0C 20              BYTE $0C,$0C,$20,$32,$30,$2A,$36,$20,$07,$12,$09,$04,$20,$17,$09,$14
03426  4930  08 20 03              BYTE $08,$20,$03,$15,$12,$12,$05,$0E,$14,$20,$03,$08,$01,$12,$2E,$20
03427  4940  20 20 13              BYTE $20,$20,$13,$20,$20,$3A,$13,$17,$01,$10,$20,$14,$17,$0F,$20,$03
03428  4950  08 01 12              BYTE $08,$01,$12,$13,$20,$06,$12,$0F,$0D,$20,$0F,$0E,$05,$20,$14,$0F
03429  4960  20 0F 14              BYTE $20,$0F,$14,$08,$05,$12,$2E,$20,$20,$20,$1C,$20,$20,$3A,$14,$12
03430  4970  01 0E 13              BYTE $01,$0E,$13,$06,$05,$12,$20,$0F,$0E,$20,$03,$08,$01,$12,$20,$14
03431  4980  0F 20 01              BYTE $0F,$20,$01,$0E,$0F,$14,$08,$05,$12,$20,$10,$0F,$13,$2E,$20,$20
03432  4990  20 12 15              BYTE $20,$12,$15,$0E,$2F,$3A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03433  49A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03434  49B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$13,$14,$0F,$10,$3A,$01,$02
03435  49C0  0F 12 14              BYTE $0F,$12,$14,$20,$03,$15,$12,$12,$05,$0E,$14,$20,$04,$09,$13,$03
03436  49D0  20 03 0F              BYTE $20,$03,$0F,$0D,$0D,$01,$0E,$04,$20,$20,$20,$20,$20,$20,$20,$20
03437  49E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03438  49F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03439  4A00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03440  4A10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03441  4A20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03442  4A30  20 20 20              BYTE $20,$20,$20,$15,$13,$05,$20,$0A,$0F,$19,$13,$14,$09,$03,$0B,$20
03443  4A40  09 0E 20              BYTE $09,$0E,$20,$10,$0F,$12,$14,$20,$32,$20,$14,$0F,$20,$03,$0F,$0E
03444  4A50  14 12 0F              BYTE $14,$12,$0F,$0C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03445  4A60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03446  4A70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03447  4A80  20 20 20              BYTE $20,$20,$20,$20,$20,$03,$15,$12,$13,$0F,$12,$20,$09,$0E,$20,$38
03448  4A90  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$01,$0E,$04,$20,$32,$30,$2A,$36
03449  4AA0  20 07 12              BYTE $20,$07,$12,$09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03450  4AB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03451  4AC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03452  4AD0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$10,$12,$05,$13,$13,$20,$27,$06,$09
03453  4AE0  12 05 27              BYTE $12,$05,$27,$20,$0F,$12,$20,$13,$10,$01,$03,$05,$20,$14,$0F,$20
03454  4AF0  14 15 12              BYTE $14,$15,$12,$0E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03455  4B00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03456  4B10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03457  4B20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$01,$20,$10,$09,$18,$05,$0C
03458  4B30  20 0F 0E              BYTE $20,$0F,$0E,$2F,$0F,$06,$06,$20,$09,$0E,$20,$14,$08,$05,$20,$38
03459  4B40  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$84,$8F,$8E,$A7,$94,$A0,$93,$85
03460  4B50  8C 85 83              BYTE $8C,$85,$83,$94,$A0,$81,$A0,$84,$89,$93,$83,$A0,$83,$8F,$8D,$8D
03461  4B60  81 8E 84              BYTE $81,$8E,$84,$A0,$89,$86,$A0,$99,$8F,$95,$A0,$88,$81,$96,$85,$A0
03462  4B70  8E 8F 94              BYTE $8E,$8F,$94,$A0,$87,$8F,$94,$A0,$81,$A0,$84,$89,$93,$83,$A0,$84
03463  4B80  92 89 96              BYTE $92,$89,$96,$85,$A0,$A8,$83,$92,$81,$93,$88,$A0,$94,$88,$85,$A0
03464  4B90  93 99 93              BYTE $93,$99,$93,$94,$85,$8D,$A1,$A9,$20,$20,$20,$20,$20,$20,$20,$20
03465  4BA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03466  4BB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03467  4BC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$2A,$2A,$20,$10,$12,$05,$13,$13,$20,$93
03468  4BD0  90 81 83              BYTE $90,$81,$83,$85,$20,$14,$0F,$20,$12,$05,$14,$15,$12,$0E,$20,$2A
03469  4BE0  2A 20 20              BYTE $2A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03470  4BF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03471  4C00             ;===============================================================================
03472  4C00             ; LOAD FROM FILE SCREEN DATA
03473  4C00             ;===============================================================================
03474  4C00             
03475  4C00             DATASCRNLOAD 
03476  4C00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03477  4C10  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03478  4C20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03479  4C30  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03480  4C40  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03481  4C50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03482  4C60  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03483  4C70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03484  4C80  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03485  4C90  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03486  4CA0  20 04 01              BYTE $20,$04,$01,$14,$01,$20,$09,$0E,$10,$15,$14,$20,$20,$20,$20,$20
03487  4CB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03488  4CC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$77,$77,$77,$77,$77,$77,$77
03489  4CD0  77 77 77              BYTE $77,$77,$77,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03490  4CE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03491  4CF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03492  4D00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03493  4D10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03494  4D20  20 20 0C              BYTE $20,$20,$0C,$2E,$2E,$2E,$0C,$0F,$01,$04,$20,$01,$20,$03,$08,$01
03495  4D30  12 01 03              BYTE $12,$01,$03,$14,$05,$12,$20,$13,$05,$14,$20,$20,$20,$20,$20,$20
03496  4D40  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03497  4D50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03498  4D60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03499  4D70  20 20 13              BYTE $20,$20,$13,$2E,$2E,$2E,$04,$09,$13,$03,$20,$13,$14,$01,$14,$15
03500  4D80  13 20 20              BYTE $13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03501  4D90  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03502  4DA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03503  4DB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03504  4DC0  20 20 04              BYTE $20,$20,$04,$2E,$2E,$2E,$03,$08,$01,$0E,$07,$05,$20,$04,$05,$16
03505  4DD0  09 03 05              BYTE $09,$03,$05,$20,$28,$04,$05,$16,$3D
03506  4DD9             DATALOADDEVNUM 
03507  4DD9  38                    BYTE $38
03508  4DDA  29 20 20              BYTE $29,$20,$20,$20,$20,$20
03509  4DE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03510  4DF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03511  4E00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03512  4E10  20 20 2A              BYTE $20,$20,$2A,$2E,$2E,$2E,$04,$09,$13,$03,$20,$04,$09,$12,$05,$03
03513  4E20  14 0F 12              BYTE $14,$0F,$12,$19,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03514  4E30  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03515  4E40  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03516  4E50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03517  4E60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03518  4E70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03519  4E80  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$11,$2E,$2E,$2E,$07,$0F
03520  4E90  14 0F 20              BYTE $14,$0F,$20,$14,$08,$05,$20,$06,$01,$03,$14,$0F,$12,$19,$20,$20
03521  4EA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03522  4EB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03523  4EC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03524  4ED0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03525  4EE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03526  4EF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03527  4F00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03528  4F10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03529  4F20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0D,$01,$0B,$05,$20,$19
03530  4F30  0F 15 12              BYTE $0F,$15,$12,$20,$03,$08,$0F,$09,$03,$05,$21,$21,$20,$20,$20,$20
03531  4F40  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03532  4F50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03533  4F60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03534  4F70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03535  4F80  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03536  4F90  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03537  4FA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03538  4FB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03539  4FC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03540  4FD0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03541  4FE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03542  4FF0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03543  5000             ;===============================================================================
03544  5000             ; SAVE FILE SCREEN DATA
03545  5000             ;===============================================================================
03546  5000             
03547  5000             DATASCRNSAVE 
03548  5000  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03549  5010  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03550  5020  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03551  5030  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03552  5040  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03553  5050  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03554  5060  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03555  5070  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03556  5080  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03557  5090  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03558  50A0  20 04 01              BYTE $20,$04,$01,$14,$01,$20,$0F,$15,$14,$10,$15,$14,$20,$20,$20,$20
03559  50B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03560  50C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$77,$77,$77,$77,$77,$77,$77
03561  50D0  77 77 77              BYTE $77,$77,$77,$77,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03562  50E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03563  50F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03564  5100  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03565  5110  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03566  5120  20 20 13              BYTE $20,$20,$13,$2E,$2E,$2E,$13,$01,$16,$05,$20,$01,$20,$03,$08,$01
03567  5130  12 20 13              BYTE $12,$20,$13,$05,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03568  5140  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03569  5150  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03570  5160  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03571  5170  20 20 14              BYTE $20,$20,$14,$2E,$2E,$2E,$04,$09,$13,$03,$20,$13,$14,$01,$14,$15
03572  5180  13 20 20              BYTE $13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03573  5190  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03574  51A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03575  51B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03576  51C0  20 20 04              BYTE $20,$20,$04,$2E,$2E,$2E,$03,$08,$01,$0E,$07,$05,$20,$04,$05,$16
03577  51D0  09 03 05              BYTE $09,$03,$05,$20,$28,$04,$05,$16,$3D
03578  51D9             DATASAVEDEVNUM 
03579  51D9  38                    BYTE $38
03580  51DA  29 20 20              BYTE $29,$20,$20,$20,$20,$20
03581  51E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03582  51F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03583  5200  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03584  5210  20 20 2A              BYTE $20,$20,$2A,$2E,$2E,$2E,$04,$09,$13,$03,$20,$04,$09,$12,$05,$03
03585  5220  14 0F 12              BYTE $14,$0F,$12,$19,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03586  5230  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03587  5240  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03588  5250  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03589  5260  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03590  5270  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03591  5280  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$11,$2E,$2E,$2E,$07,$0F
03592  5290  14 0F 20              BYTE $14,$0F,$20,$14,$08,$05,$20,$06,$01,$03,$14,$0F,$12,$19,$20,$20
03593  52A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03594  52B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03595  52C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03596  52D0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03597  52E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03598  52F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03599  5300  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03600  5310  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03601  5320  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0D,$01,$0B,$05,$20,$19
03602  5330  0F 15 12              BYTE $0F,$15,$12,$20,$03,$08,$0F,$09,$03,$05,$21,$21,$20,$20,$20,$20
03603  5340  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03604  5350  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03605  5360  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03606  5370  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03607  5380  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03608  5390  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03609  53A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03610  53B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03611  53C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03612  53D0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03613  53E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03614  53F0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03615  5400             
03616  5400             *=$5400
03617  5400             ;===============================================================================
03618  5400             ; STRINGS FOR DISPLAY
03619  5400             ;===============================================================================
03620  5400             
03621  5400             DATACHARGRID 
03622  5400  DF DF DF              BYTE $DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF
03623  5410  DF DF DF              BYTE $DF,$DF,$DF,$DF,$DF,$DF,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03624  5420  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$00,$01,$02,$03,$04,$05,$06
03625  5430  07 08 09              BYTE $07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$DF,$60,$20
03626  5440  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03627  5450  DF 14 15              BYTE $DF,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22
03628  5460  23 24 25              BYTE $23,$24,$25,$26,$27,$DF,$20,$20,$20,$60,$20,$20,$20,$20,$20,$20
03629  5470  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$28,$29,$2A,$2B,$2C,$2D,$2E
03630  5480  2F 30 31              BYTE $2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$DF,$60,$20
03631  5490  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03632  54A0  DF 3C 3D              BYTE $DF,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A
03633  54B0  4B 4C 4D              BYTE $4B,$4C,$4D,$4E,$4F,$DF,$60,$20,$20,$20,$20,$20,$20,$20,$20,$20
03634  54C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$50,$51,$52,$53,$54,$55,$56
03635  54D0  57 58 59              BYTE $57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$DF,$20,$20
03636  54E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03637  54F0  DF 64 65              BYTE $DF,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72
03638  5500  73 74 75              BYTE $73,$74,$75,$76,$77,$DF,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03639  5510  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF
03640  5520  DF DF DF              BYTE $DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$20,$20
03641  5530  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03642  5540  20 00 00              BYTE $20,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03643  5550             
03644  5550             DATASWAPMODE 
03645  5550  13 17 01              BYTE $13,$17,$01,$10,$20,$0D,$0F,$04,$05
03646  5559             
03647  5559             DATATRFRMODE 
03648  5559  14 12 01              BYTE $14,$12,$01,$0E,$13,$06,$05,$12,$20,$0D,$0F,$04,$05
03649  5566             
03650  5566             DATAFILENAME 
03651  5566  46 49 4C              BYTE $46,$49,$4C,$45,$4E,$41,$4D,$45,$20,$3A,$20,$00,$00,$00,$00,$00
03652  5576             
03653  5576             DATASTATUS 
03654  5576  53 54 41              BYTE $53,$54,$41,$54,$55,$53,$3A,$20,$00,$00,$00,$00,$00,$00,$00,$00
03655  5586             
03656  5586             *=$5600
03657  5600             ;===============================================================================
03658  5600             ; PROGRAM VARIABLES
03659  5600             ;===============================================================================
03660  5600             
03661  5600             CURSORTIMER 
03662  5600  10                    BYTE CURSORDELAY
03663  5601             
03664  5601             EDITINGCHAR 
03665  5601  00                    BYTE $00
03666  5602             
03667  5602             HEXCHARTOPRINT 
03668  5602  00                    BYTE $00
03669  5603             
03670  5603             EDITSTICKCOUNT 
03671  5603  03                    BYTE $03
03672  5604             
03673  5604             JOYSTICKBITS 
03674  5604  7F                    BYTE $7F
03675  5605             
03676  5605             CURSORMOVED 
03677  5605  01                    BYTE $01
03678  5606             
03679  5606             STORAGEDEVNUM 
03680  5606  38                    BYTE $38
03681  5607             
03682  5607             CHRINLEN
03683  5607  0A                    BYTE $0A
03684  5608             
03685  5608             CHARSTICKCOUNT 
03686  5608  05                    BYTE $05
03687  5609             
03688  5609             FIREBTNCOUNTER 
03689  5609  02                    BYTE $02
03690  560A             
03691  560A             CHARSCROLLSAVE 
03692  560A  87                    BYTE $87
03693  560B             
03694  560B             FILENAMEINPUT 
03695  560B  53 41 53              BYTE $53,$41,$53,$20,$43,$48,$41,$52,$53,$21,$53,$00,$00,$00,$00,$00
03696  561B  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03697  562B             
03698  562B             WORKINGCHAR 
03699  562B  A0 A0 A0              BYTE $A0,$A0,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0
03700  563B  A0 20 20              BYTE $A0,$20,$20,$20,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20
03701  564B  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$A0,$A0
03702  565B  A0 A0 20              BYTE $A0,$A0,$20,$A0,$20,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$20,$A0,$A0
03703  566B             
03704  566B             EDITGRIDTOPROWFWDLO 
03705  566B  29                    BYTE <EDITGRIDHOME
03706  566C  2A                    BYTE <EDITGRIDHOME+$1
03707  566D  2B                    BYTE <EDITGRIDHOME+$2
03708  566E  2C                    BYTE <EDITGRIDHOME+$3
03709  566F  2D                    BYTE <EDITGRIDHOME+$4
03710  5670  2E                    BYTE <EDITGRIDHOME+$5
03711  5671  2F                    BYTE <EDITGRIDHOME+$6
03712  5672  30                    BYTE <EDITGRIDHOME+$7
03713  5673             
03714  5673             EDITGRIDTOPROWREVLO 
03715  5673  30                    BYTE <EDITGRIDHOME+$7
03716  5674  2F                    BYTE <EDITGRIDHOME+$6
03717  5675  2E                    BYTE <EDITGRIDHOME+$5
03718  5676  2D                    BYTE <EDITGRIDHOME+$4
03719  5677  2C                    BYTE <EDITGRIDHOME+$3
03720  5678  2B                    BYTE <EDITGRIDHOME+$2
03721  5679  2A                    BYTE <EDITGRIDHOME+$1
03722  567A  29                    BYTE <EDITGRIDHOME
03723  567B             
03724  567B             WORKINGCHARROWSLO 
03725  567B  2B                    BYTE <WORKINGCHAR
03726  567C  33                    BYTE <WORKINGCHAR+$8
03727  567D  3B                    BYTE <WORKINGCHAR+$10
03728  567E  43                    BYTE <WORKINGCHAR+$18
03729  567F  4B                    BYTE <WORKINGCHAR+$20
03730  5680  53                    BYTE <WORKINGCHAR+$28
03731  5681  5B                    BYTE <WORKINGCHAR+$30
03732  5682  63                    BYTE <WORKINGCHAR+$38
03733  5683             
03734  5683             WORKINGCHARTOPROWREVLO 
03735  5683  32                    BYTE <WORKINGCHAR+$7
03736  5684  31                    BYTE <WORKINGCHAR+$6
03737  5685  30                    BYTE <WORKINGCHAR+$5
03738  5686  2F                    BYTE <WORKINGCHAR+$4
03739  5687  2E                    BYTE <WORKINGCHAR+$3
03740  5688  2D                    BYTE <WORKINGCHAR+$2
03741  5689  2C                    BYTE <WORKINGCHAR+$1
03742  568A  2B                    BYTE <WORKINGCHAR
03743  568B             
03744  568B             DATACHARSETSAVE 
03745  568B  00 00 7E              BYTE $00,$00,$7E,$66,$7E,$66,$66,$00,$00,$00,$7E,$06,$7E,$66,$7E,$00
03746  569B  00 00 7E              BYTE $00,$00,$7E,$00,$60,$70,$7E,$00,$00,$00,$7E,$06,$66,$66,$7E,$00
03747  56AB  00 00 7E              BYTE $00,$00,$7E,$00,$7C,$60,$7E,$00,$00,$00,$7E,$00,$7C,$60,$60,$00
03748  56BB  00 00 7E              BYTE $00,$00,$7E,$60,$6E,$66,$7E,$00,$00,$00,$66,$66,$7E,$66,$66,$00
03749  56CB  00 00 18              BYTE $00,$00,$18,$18,$18,$18,$18,$00,$00,$00,$7E,$06,$06,$66,$7E,$00
03750  56DB  00 00 66              BYTE $00,$00,$66,$66,$6C,$66,$66,$00,$00,$00,$60,$60,$60,$70,$7E,$00
03751  56EB  00 00 FF              BYTE $00,$00,$FF,$DB,$DB,$DB,$DB,$00,$00,$00,$7E,$66,$66,$66,$66,$00
03752  56FB  00 00 7E              BYTE $00,$00,$7E,$66,$66,$66,$7E,$00,$00,$00,$7E,$06,$7E,$60,$60,$00
03753  570B  00 00 7E              BYTE $00,$00,$7E,$66,$66,$6E,$7E,$00,$00,$00,$7E,$06,$7C,$66,$66,$00
03754  571B  00 00 7E              BYTE $00,$00,$7E,$60,$7E,$06,$7E,$00,$00,$00,$7E,$18,$18,$18,$18,$00
03755  572B  00 00 66              BYTE $00,$00,$66,$66,$66,$66,$7E,$00,$00,$00,$66,$66,$66,$3C,$18,$00
03756  573B  00 00 DB              BYTE $00,$00,$DB,$DB,$DB,$DB,$FF,$00,$00,$00,$66,$66,$3C,$66,$66,$00
03757  574B  00 00 66              BYTE $00,$00,$66,$66,$3C,$18,$18,$00,$00,$00,$7E,$0C,$18,$30,$7E,$00
03758  575B  00 3C 30              BYTE $00,$3C,$30,$30,$30,$30,$30,$3C,$00,$00,$00,$3C,$30,$3C,$00,$00
03759  576B  00 3C 0C              BYTE $00,$3C,$0C,$0C,$0C,$0C,$0C,$3C,$00,$18,$3C,$7E,$18,$18,$18,$00
03760  577B  00 10 30              BYTE $00,$10,$30,$7E,$7E,$30,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
03761  578B             
03762  578B             VARSSAVEAREA 
03763  578B  00 30 29              BYTE $00,$30,$29,$04,$70,$02,$00,$00,$00,$00,$3C,$03,$00,$00,$00,$00
03764  579B  69 05 D1              BYTE $69,$05,$D1,$06,$3C,$D2,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03765  57AB             
03766  57AB             *=$5800
03767  5800             ;===============================================================================
03768  5800             ; COMMAND MAPS DATA
03769  5800             ;===============================================================================
03770  5800             
03771  5800             SWAPCMDS
03772  5800  13 93 11              BYTE $13,$93,$11,$1D,$91,$9D,$8D,$8E,$94,$D4
03773  580A             
03774  580A             MAINCOMMANDS 
03775  580A  20 2B 2D              BYTE $20,$2B,$2D,$48,$55,$44,$4C,$52,$49,$4F,$57,$43,$58,$2A,$85,$86
03776  581A  87 88 13              BYTE $87,$88,$13,$2E,$2C,$5E,$3D,$53,$5C
03777  5823             
03778  5823             CMDLOADDRS 
03779  5823  B6                    BYTE <PIXELINVERT
03780  5824  92                    BYTE <SELECTNEXTCHR
03781  5825  00                    BYTE <SELECTPREVCHR
03782  5826  FD                    BYTE <SHOWHELP
03783  5827  51                    BYTE <SCROLLCHARUP
03784  5828  9B                    BYTE <SCROLLCHARDOWN
03785  5829  00                    BYTE <SCROLLCHARLEFT
03786  582A  00                    BYTE <SCROLLCHARRIGHT
03787  582B  00                    BYTE <LOADFROMDEVICE
03788  582C  00                    BYTE <SAVETODEVICE
03789  582D  00                    BYTE <SWAPWINDOWMAPS
03790  582E  C3                    BYTE <COPYROMCHAR
03791  582F  8B                    BYTE <EXITPROGRAM
03792  5830  00                    BYTE <ROTATECHAR90
03793  5831  85                    BYTE <INVERTCHAR
03794  5832  6D                    BYTE <CLEARGRID88
03795  5833  87                    BYTE <MOVEUPALINE
03796  5834  00                    BYTE <MOVEDOWNALINE
03797  5835  C8                    BYTE <HOMECURSOR
03798  5836  00                    BYTE <MIRRORCHARHORZ
03799  5837  7D                    BYTE <MIRRORCHARVERT
03800  5838  2F                    BYTE <CLEARGRID206
03801  5839  34                    BYTE <FILLGRID206
03802  583A  5D                    BYTE <SWAPCHARPOSNS
03803  583B  74                    BYTE <TRFRMODETOGGLE
03804  583C             
03805  583C             CMDHIADDRS 
03806  583C  11                    BYTE >PIXELINVERT
03807  583D  14                    BYTE >SELECTNEXTCHR
03808  583E  16                    BYTE >SELECTPREVCHR
03809  583F  19                    BYTE >SHOWHELP
03810  5840  12                    BYTE >SCROLLCHARUP
03811  5841  12                    BYTE >SCROLLCHARDOWN
03812  5842  13                    BYTE >SCROLLCHARLEFT
03813  5843  14                    BYTE >SCROLLCHARRIGHT
03814  5844  20                    BYTE >LOADFROMDEVICE
03815  5845  22                    BYTE >SAVETODEVICE
03816  5846  1D                    BYTE >SWAPWINDOWMAPS
03817  5847  1B                    BYTE >COPYROMCHAR
03818  5848  11                    BYTE >EXITPROGRAM
03819  5849  19                    BYTE >ROTATECHAR90
03820  584A  1B                    BYTE >INVERTCHAR
03821  584B  17                    BYTE >CLEARGRID88
03822  584C  16                    BYTE >MOVEUPALINE
03823  584D  17                    BYTE >MOVEDOWNALINE
03824  584E  24                    BYTE >HOMECURSOR
03825  584F  18                    BYTE >MIRRORCHARHORZ
03826  5850  18                    BYTE >MIRRORCHARVERT
03827  5851  12                    BYTE >CLEARGRID206
03828  5852  12                    BYTE >FILLGRID206
03829  5853  1D                    BYTE >SWAPCHARPOSNS
03830  5854  19                    BYTE >TRFRMODETOGGLE
03831  5855             
