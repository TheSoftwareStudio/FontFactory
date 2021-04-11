
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
00274  109B  A9 D0                 LDA #>UPPERCHRROM ; RESET SOURCE TO UPPER-CASE CHARS IN ROM
00275  109D  8D 84 10              STA SRCCHRROM+2
00276  10A0  A9 30                 LDA #>CHARMEMBASE ; RESET DESTINATION TO CHAR-SET WORKING AREA
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
00365  1131             ; INITIALIZE PROGRAM AND VARIABLES
00366  1131             ;===============================================================================
00367  1131             
00368  1131             INIT
00369  1131  A9 00                 LDA #<CHARMEMBASE
00370  1133  85 A8                 STA CHARMEMPOSLO
00371  1135  A9 30                 LDA #>CHARMEMBASE
00372  1137  85 A9                 STA CHARMEMPOSHI
00373  1139             
00374  1139  A9 29                 LDA #<EDITGRIDHOME
00375  113B  85 B8                 STA WORKGRIDPOSLO
00376  113D  85 AA                 STA EDITGRIDPOSLO
00377  113F  A9 04                 LDA #>EDITGRIDHOME
00378  1141  85 B9                 STA WORKGRIDPOSHI
00379  1143  85 AB                 STA EDITGRIDPOSHI
00380  1145             
00381  1145  A9 D1                 LDA #<CHARSETHOME
00382  1147  85 BA                 STA CHARSETPOSLO
00383  1149  A9 06                 LDA #>CHARSETHOME
00384  114B  85 BB                 STA CHARSETPOSHI
00385  114D             
00386  114D  A9 10                 LDA #CURSORDELAY
00387  114F  8D 00 56              STA CURSORTIMER
00388  1152             
00389  1152  A9 05                 LDA CHARSTICKDELAY
00390  1154  8D 08 56              STA CHARSTICKCOUNT
00391  1157  A9 03                 LDA EDITSTICKDELAY
00392  1159  8D 03 56              STA EDITSTICKCOUNT
00393  115C             
00394  115C  A9 00                 LDA #$00
00395  115E  8D 01 56              STA EDITINGCHAR
00396  1161             
00397  1161  A9 38                 LDA KEY8
00398  1163  8D 06 56              STA STORAGEDEVNUM
00399  1166  8D D9 4D              STA DATALOADDEVNUM
00400  1169             
00401  1169  A9 0B                 LDA CHARCRSRHOMEROW
00402  116B  8D 15 1D              STA CHARCURSORROW+1
00403  116E  A9 01                 LDA CHARCRSRHOMECOL
00404  1170  8D 17 1D              STA CHARCURSORCOL+1
00405  1173             
00406  1173  20 77 11              JSR CLRLOWCHRROM
00407  1176  60                    RTS
00408  1177             
00409  1177             ;
00410  1177             ; UTILITY FUNCTION : CLEAR $D800 - $DFFF
00411  1177             ;
00412  1177             CLRLOWCHRROM 
00413  1177  A2 00                 LDX #$00
00414  1179             
00415  1179             NEXTCHRPOS 
00416  1179  A9 01                 LDA #$01
00417  117B  9D 00 D8              STA LOWERCHRROM,X
00418  117E  9D 00 D9              STA LOWERCHRROM+$100,X
00419  1181  9D 00 DA              STA LOWERCHRROM+$200,X
00420  1184  9D 00 DB              STA LOWERCHRROM+$300,X
00421  1187  E8                    INX
00422  1188  D0 EF                 BNE NEXTCHRPOS
00423  118A  60                    RTS
00424  118B             ;===============================================================================
00425  118B             ; EXIT PROGRAM (COLD START)
00426  118B             ;===============================================================================
00427  118B             
00428  118B             EXITPROGRAM 
00429  118B  78                    SEI
00430  118C  A9 31                 LDA #<IRQSVCROUTINE
00431  118E  8D 14 03              STA IRQSVCLOADDR
00432  1191  A9 EA                 LDA #>IRQSVCROUTINE
00433  1193  8D 15 03              STA IRQSVCHIADDR
00434  1196             
00435  1196  A9 79                 LDA #$79
00436  1198  8D 19 D0              STA IRQSTATUSREG
00437  119B  A9 F0                 LDA #$F0
00438  119D  8D 1A D0              STA IRQCTLREG
00439  11A0  A9 01                 LDA #$01
00440  11A2  8D 0E DC              STA TIMERACTLREG
00441  11A5  58                    CLI
00442  11A6             
00443  11A6  A9 01                 LDA #$01
00444  11A8  8D 08 80              STA CARTRIDGESIG        ; PREVENT CARTRIDGE AUTO-START BY SPOILING CBM80 SIGNATURE
00445  11AB             
00446  11AB  4C E2 FC              JMP KRNL_COLDSTART
00447  11AE             ;===============================================================================
00448  11AE             ; COMMAND HANDLER: TOGGLE EDITING PIXEL ON/OFF
00449  11AE             ;===============================================================================
00450  11AE             
00451  11AE             CHECKFIREBTN 
00452  11AE  AD 00 DC              LDA JOYSTICKPORT2
00453  11B1  C9 6F                 CMP #$6F
00454  11B3  F0 01                 BEQ PIXELINVERT
00455  11B5  60                    RTS
00456  11B6             
00457  11B6             PIXELINVERT 
00458  11B6  A2 00                 LDX #$00
00459  11B8  A1 AA                 LDA (EDITGRIDPOSLO,X)
00460  11BA  C9 A0                 CMP KEYFULLBLOCK        ; PIXEL ON?
00461  11BC  F0 07                 BEQ CLRPIXEL
00462  11BE             
00463  11BE  A9 A0                 LDA KEYFULLBLOCK        ; SET PIXEL
00464  11C0  81 AA                 STA (EDITGRIDPOSLO,X)
00465  11C2  4C C9 11              JMP SHOWPIXEL
00466  11C5             
00467  11C5             CLRPIXEL
00468  11C5  A9 20                 LDA KEYSPACE            ; CLEAR PIXEL
00469  11C7  81 AA                 STA (EDITGRIDPOSLO,X)
00470  11C9             
00471  11C9             SHOWPIXEL
00472  11C9  EA                    NOP
00473  11CA  EA                    NOP
00474  11CB  EA                    NOP
00475  11CC             
00476  11CC             STOREDITGRID 
00477  11CC  A0 00                 LDY #$00                ; CLEAR 8-BYTES IN-MEMORY OF THE CHAR READY FOR NEW VALUES
00478  11CE  A9 00                 LDA #$00
00479  11D0             
00480  11D0             CLRMEMPIXEL 
00481  11D0  91 A8                 STA (CHARMEMPOSLO),Y
00482  11D2  C8                    INY
00483  11D3  C0 08                 CPY #$08
00484  11D5  D0 F9                 BNE CLRMEMPIXEL
00485  11D7             
00486  11D7  A9 29                 LDA #<EDITGRIDHOME      ; START AT TOP-LEFT OF DISPLAY 8*8 EDIT GRID
00487  11D9  85 B8                 STA WORKGRIDPOSLO
00488  11DB  A9 04                 LDA #>EDITGRIDHOME
00489  11DD  85 B9                 STA WORKGRIDPOSHI
00490  11DF             
00491  11DF  A2 00                 LDX #$00
00492  11E1             
00493  11E1             STORMEMPIXEL 
00494  11E1  8A                    TXA
00495  11E2  48                    PHA
00496  11E3  20 00 12              JSR SETMEMPIXEL
00497  11E6  68                    PLA
00498  11E7  AA                    TAX
00499  11E8  E8                    INX
00500  11E9  E0 08                 CPX #$08
00501  11EB  D0 F4                 BNE STORMEMPIXEL
00502  11ED             
00503  11ED  38                    SEC                     ; SET CHARACTER MEMORY POINTER POSITIONS BACK TO CHAR START
00504  11EE  A5 A8                 LDA CHARMEMPOSLO
00505  11F0  E9 08                 SBC #$08
00506  11F2  85 A8                 STA CHARMEMPOSLO
00507  11F4  A5 A9                 LDA CHARMEMPOSHI
00508  11F6  E9 00                 SBC #$00
00509  11F8  85 A9                 STA CHARMEMPOSHI
00510  11FA  60                    RTS
00511  11FB             
00512  11FB             ;
00513  11FB             ; UTILITY FUNCTION : SET PIXEL IN CHARACTER MEMORY FROM DISPLAY EDITING GRID
00514  11FB             ;
00515  11FB             ALIGN
00516  1200             SETMEMPIXEL 
00517  1200  A0 80                 LDY #$80
00518  1202             
00519  1202             CHKGRIDPIXEL 
00520  1202  A2 00                 LDX #$00
00521  1204  A1 B8                 LDA (WORKGRIDPOSLO,X)
00522  1206  C9 A0                 CMP KEYFULLBLOCK        ; IS THE PIXEL SET? REPRESENTING A '1', IGNORE IF CLEAR/'0'
00523  1208  D0 06                 BNE NEXTPIXELPOS
00524  120A             
00525  120A  98                    TYA
00526  120B  18                    CLC
00527  120C  61 A8                 ADC (CHARMEMPOSLO,X)
00528  120E  81 A8                 STA (CHARMEMPOSLO,X)
00529  1210             
00530  1210             NEXTPIXELPOS 
00531  1210  E6 B8                 INC WORKGRIDPOSLO       ; MOVE TO NEXT 'PIXEL' IN DISPLAY 8*8 EDIT GRID
00532  1212  D0 02                 BNE NEXTPIXELCOL
00533  1214  E6 B9                 INC WORKGRIDPOSHI
00534  1216             
00535  1216             NEXTPIXELCOL 
00536  1216  98                    TYA
00537  1217  4A                    LSR
00538  1218  A8                    TAY
00539  1219  D0 E7                 BNE CHKGRIDPIXEL
00540  121B             
00541  121B  18                    CLC
00542  121C  A5 B8                 LDA WORKGRIDPOSLO       ; MOVE TO NEXT ROW IN DISPLAY 8*8 EDIT GRID
00543  121E  69 20                 ADC #$20
00544  1220  85 B8                 STA WORKGRIDPOSLO
00545  1222  A5 B9                 LDA WORKGRIDPOSHI
00546  1224  69 00                 ADC #$00
00547  1226  85 B9                 STA WORKGRIDPOSHI
00548  1228                        
00549  1228  E6 A8                 INC CHARMEMPOSLO        ; MOVE TO NEXT CHARACTER MEMORY POSITION
00550  122A  D0 02                 BNE EXITSETMEMPIXEL
00551  122C  E6 A9                 INC CHARMEMPOSHI
00552  122E             
00553  122E             EXITSETMEMPIXEL 
00554  122E  60                    RTS
00555  122F             ;===============================================================================
00556  122F             ; COMMAND HANDLER: FILL 20*6 CHARACTER GRID WITH SPACE OR SAME CHARACTER
00557  122F             ;===============================================================================
00558  122F             
00559  122F             CLEARGRID206 
00560  122F  A9 20                 LDA KEYSPACE
00561  1231  4C 37 12              JMP CPYCHARGRID206
00562  1234             
00563  1234             FILLGRID206 
00564  1234  AD 01 56              LDA EDITINGCHAR
00565  1237             
00566  1237             CPYCHARGRID206 
00567  1237  A2 00                 LDX #$00
00568  1239             
00569  1239             NEXTGRIDPOS 
00570  1239  9D B9 05              STA SCRNGRIDHOME,X
00571  123C  9D E1 05              STA SCRNGRIDHOME+$28,X
00572  123F  9D 09 06              STA SCRNGRIDHOME+$50,X
00573  1242  9D 31 06              STA SCRNGRIDHOME+$78,X
00574  1245  9D 59 06              STA SCRNGRIDHOME+$A0,X
00575  1248  9D 81 06              STA SCRNGRIDHOME+$C8,X
00576  124B  E8                    INX
00577  124C  E0 14                 CPX #$14
00578  124E  D0 E9                 BNE NEXTGRIDPOS
00579  1250  60                    RTS
00580  1251             ;===============================================================================
00581  1251             ; SCROLL EDITING CHARACTER COMMANDS
00582  1251             ;===============================================================================
00583  1251             
00584  1251             ;
00585  1251             ; COMMAND HANDLER : SCROLL EDITING CHARACTER UP
00586  1251             ;
00587  1251             SCROLLCHARUP 
00588  1251  A5 A8                 LDA CHARMEMPOSLO
00589  1253  8D 6E 12              STA DATAIDX3+1
00590  1256  8D 79 12              STA DATAIDX4+1
00591  1259  8D 7C 12              STA DATAIDX5+1
00592  125C  8D 98 12              STA DATAIDX6+1
00593  125F  A5 A9                 LDA CHARMEMPOSHI
00594  1261  8D 6F 12              STA DATAIDX3+2
00595  1264  8D 7A 12              STA DATAIDX4+2
00596  1267  8D 7D 12              STA DATAIDX5+2
00597  126A  8D 99 12              STA DATAIDX6+2
00598  126D             
00599  126D             DATAIDX3
00600  126D  AD 00 30              LDA CHARMEMBASE
00601  1270  8D 0A 56              STA CHARSCROLLSAVE
00602  1273  EE 79 12              INC DATAIDX4+1
00603  1276             
00604  1276  A2 00                 LDX #$00
00605  1278             
00606  1278             DATAIDX4
00607  1278  BD 01 30              LDA CHARMEMBASE+1,X
00608  127B             
00609  127B             DATAIDX5
00610  127B  9D 00 30              STA CHARMEMBASE,X
00611  127E  E8                    INX
00612  127F  E0 07                 CPX #$07
00613  1281  D0 F5                 BNE DATAIDX4
00614  1283             
00615  1283  18                    CLC
00616  1284  AD 98 12              LDA DATAIDX6+1
00617  1287  69 07                 ADC #$07
00618  1289  8D 98 12              STA DATAIDX6+1
00619  128C  AD 99 12              LDA DATAIDX6+2
00620  128F  69 00                 ADC #$00
00621  1291  8D 99 12              STA DATAIDX6+2
00622  1294  AD 0A 56              LDA CHARSCROLLSAVE
00623  1297             
00624  1297             DATAIDX6
00625  1297  8D 07 30              STA CHARMEMBASE+7
00626  129A  60                    RTS
00627  129B             
00628  129B             ;
00629  129B             ; COMMAND HANDLER : SCROLL EDITING CHARACTER DOWN
00630  129B             ;
00631  129B             SCROLLCHARDOWN 
00632  129B  A5 A8                 LDA CHARMEMPOSLO
00633  129D  8D C9 12              STA DATAIDX9+1
00634  12A0  8D D4 12              STA DATAIDX10+1
00635  12A3  8D D7 12              STA DATAIDX11+1
00636  12A6  8D E0 12              STA DATAIDX12+1
00637  12A9  A5 A9                 LDA CHARMEMPOSHI
00638  12AB  8D CA 12              STA DATAIDX9+2
00639  12AE  8D D5 12              STA DATAIDX10+2
00640  12B1  8D D8 12              STA DATAIDX11+2
00641  12B4  8D E1 12              STA DATAIDX12+2
00642  12B7  18                    CLC
00643  12B8  AD C9 12              LDA DATAIDX9+1
00644  12BB  69 07                 ADC #$07
00645  12BD  8D C9 12              STA DATAIDX9+1
00646  12C0  AD CA 12              LDA DATAIDX9+2
00647  12C3  69 00                 ADC #$00
00648  12C5  8D CA 12              STA DATAIDX9+2
00649  12C8             
00650  12C8             DATAIDX9
00651  12C8  AD 07 30              LDA CHARMEMBASE+7
00652  12CB  8D 0A 56              STA CHARSCROLLSAVE
00653  12CE  EE D7 12              INC DATAIDX11+1
00654  12D1             
00655  12D1  A2 06                 LDX #$06
00656  12D3             
00657  12D3             DATAIDX10
00658  12D3  BD 00 30              LDA CHARMEMBASE,X
00659  12D6             
00660  12D6             DATAIDX11
00661  12D6  9D 01 30              STA CHARMEMBASE+1,X
00662  12D9  CA                    DEX
00663  12DA  10 F7                 BPL DATAIDX10
00664  12DC             
00665  12DC  AD 0A 56              LDA CHARSCROLLSAVE
00666  12DF             
00667  12DF             DATAIDX12
00668  12DF  8D 00 30              STA CHARMEMBASE
00669  12E2  60                    RTS
00670  12E3             
00671  12E3             ;
00672  12E3             ; COMMAND HANDLER : SCROLL EDITING CHARACTER LEFT
00673  12E3             ;
00674  12E3             ALIGN
00675  1300             SCROLLCHARLEFT 
00676  1300  A9 29                 LDA #<EDITGRIDHOME
00677  1302  85 B8                 STA WORKGRIDPOSLO
00678  1304  A9 04                 LDA #>EDITGRIDHOME
00679  1306  85 B9                 STA WORKGRIDPOSHI
00680  1308             
00681  1308  A2 00                 LDX #$00
00682  130A  A0 00                 LDY #$00
00683  130C             
00684  130C             LOOP16
00685  130C  B1 B8                 LDA (WORKGRIDPOSLO),Y
00686  130E  9D 2B 56              STA WORKINGCHAR,X
00687  1311  18                    CLC
00688  1312  A5 B8                 LDA WORKGRIDPOSLO
00689  1314  69 28                 ADC #$28
00690  1316  85 B8                 STA WORKGRIDPOSLO
00691  1318  A5 B9                 LDA WORKGRIDPOSHI
00692  131A  69 00                 ADC #$00
00693  131C  85 B9                 STA WORKGRIDPOSHI
00694  131E  E8                    INX
00695  131F  E0 08                 CPX #$08
00696  1321  D0 E9                 BNE LOOP16
00697  1323             
00698  1323  A0 00                 LDY #$00
00699  1325             
00700  1325             LOOP17
00701  1325  A2 00                 LDX #$00
00702  1327             
00703  1327             DATAIDX22
00704  1327  BD 2A 04              LDA EDITGRIDHOME+1,X
00705  132A             
00706  132A             DATAIDX23
00707  132A  9D 29 04              STA EDITGRIDHOME,X
00708  132D  E8                    INX
00709  132E  E0 07                 CPX #$07
00710  1330  D0 F5                 BNE DATAIDX22
00711  1332             
00712  1332  18                    CLC
00713  1333  AD 28 13              LDA DATAIDX22+1
00714  1336  69 28                 ADC #$28
00715  1338  8D 28 13              STA DATAIDX22+1
00716  133B  AD 29 13              LDA DATAIDX22+2
00717  133E  69 00                 ADC #$00
00718  1340  8D 29 13              STA DATAIDX22+2
00719  1343  18                    CLC
00720  1344  AD 2B 13              LDA DATAIDX23+1
00721  1347  69 28                 ADC #$28
00722  1349  8D 2B 13              STA DATAIDX23+1
00723  134C  AD 2C 13              LDA DATAIDX23+2
00724  134F  69 00                 ADC #$00
00725  1351  8D 2C 13              STA DATAIDX23+2
00726  1354  C8                    INY
00727  1355  C0 08                 CPY #$08
00728  1357  D0 CC                 BNE LOOP17
00729  1359             
00730  1359  A9 30                 LDA #<EDITGRIDHOME+7
00731  135B  85 B8                 STA WORKGRIDPOSLO
00732  135D  A9 04                 LDA #>EDITGRIDHOME
00733  135F  85 B9                 STA WORKGRIDPOSHI
00734  1361             
00735  1361  A2 00                 LDX #$00
00736  1363  A0 00                 LDY #$00
00737  1365             
00738  1365             LOOP18
00739  1365  BD 2B 56              LDA WORKINGCHAR,X
00740  1368  91 B8                 STA (WORKGRIDPOSLO),Y
00741  136A  18                    CLC
00742  136B  A5 B8                 LDA WORKGRIDPOSLO
00743  136D  69 28                 ADC #$28
00744  136F  85 B8                 STA WORKGRIDPOSLO
00745  1371  A5 B9                 LDA WORKGRIDPOSHI
00746  1373  69 00                 ADC #$00
00747  1375  85 B9                 STA WORKGRIDPOSHI
00748  1377  E8                    INX
00749  1378  E0 08                 CPX #$08
00750  137A  D0 E9                 BNE LOOP18
00751  137C             
00752  137C  20 CC 11              JSR STOREDITGRID
00753  137F             
00754  137F  A9 2A                 LDA #<EDITGRIDHOME+1
00755  1381  8D 28 13              STA DATAIDX22+1
00756  1384  A9 29                 LDA #<EDITGRIDHOME
00757  1386  8D 2B 13              STA DATAIDX23+1
00758  1389  A9 04                 LDA #>EDITGRIDHOME
00759  138B  8D 29 13              STA DATAIDX22+2
00760  138E  8D 2C 13              STA DATAIDX23+2
00761  1391  60                    RTS
00762  1392             
00763  1392             ;
00764  1392             ; COMMAND HANDLER : SCROLL EDITING CHARACTER RIGHT
00765  1392             ;
00766  1392             ALIGN
00767  1400             SCROLLCHARRIGHT 
00768  1400  A9 30                 LDA #<EDITGRIDHOME+7
00769  1402  85 B8                 STA WORKGRIDPOSLO
00770  1404  A9 04                 LDA #>EDITGRIDHOME
00771  1406  85 B9                 STA WORKGRIDPOSHI
00772  1408             
00773  1408  A2 00                 LDX #$00
00774  140A  A0 00                 LDY #$00
00775  140C             
00776  140C             LOOP3
00777  140C  B1 B8                 LDA (WORKGRIDPOSLO),Y
00778  140E  9D 2B 56              STA WORKINGCHAR,X
00779  1411  18                    CLC
00780  1412  A5 B8                 LDA WORKGRIDPOSLO
00781  1414  69 28                 ADC #$28
00782  1416  85 B8                 STA WORKGRIDPOSLO
00783  1418  A5 B9                 LDA WORKGRIDPOSHI
00784  141A  69 00                 ADC #$00
00785  141C  85 B9                 STA WORKGRIDPOSHI
00786  141E  E8                    INX
00787  141F  E0 08                 CPX #$08
00788  1421  D0 E9                 BNE LOOP3
00789  1423             
00790  1423  A0 00                 LDY #$00
00791  1425             
00792  1425             LOOP4
00793  1425  A2 06                 LDX #$06
00794  1427             
00795  1427             DATAIDX26
00796  1427  BD 29 04              LDA EDITGRIDHOME,X
00797  142A             
00798  142A             DATAIDX27
00799  142A  9D 2A 04              STA EDITGRIDHOME+1,X
00800  142D  CA                    DEX
00801  142E  10 F7                 BPL DATAIDX26
00802  1430             
00803  1430  EA                    NOP
00804  1431  EA                    NOP
00805  1432  18                    CLC
00806  1433  AD 28 14              LDA DATAIDX26+1
00807  1436  69 28                 ADC #$28
00808  1438  8D 28 14              STA DATAIDX26+1
00809  143B  AD 29 14              LDA DATAIDX26+2
00810  143E  69 00                 ADC #$00
00811  1440  8D 29 14              STA DATAIDX26+2
00812  1443  18                    CLC
00813  1444  AD 2B 14              LDA DATAIDX27+1
00814  1447  69 28                 ADC #$28
00815  1449  8D 2B 14              STA DATAIDX27+1
00816  144C  AD 2C 14              LDA DATAIDX27+2
00817  144F  69 00                 ADC #$00
00818  1451  8D 2C 14              STA DATAIDX27+2
00819  1454  C8                    INY
00820  1455  C0 08                 CPY #$08
00821  1457  D0 CC                 BNE LOOP4
00822  1459             
00823  1459  A9 29                 LDA #<EDITGRIDHOME
00824  145B  85 B8                 STA WORKGRIDPOSLO
00825  145D  A9 04                 LDA #>EDITGRIDHOME
00826  145F  85 B9                 STA WORKGRIDPOSHI
00827  1461             
00828  1461  A2 00                 LDX #$00
00829  1463  A0 00                 LDY #$00
00830  1465             
00831  1465             LOOP5
00832  1465  BD 2B 56              LDA WORKINGCHAR,X
00833  1468  91 B8                 STA (WORKGRIDPOSLO),Y
00834  146A  18                    CLC
00835  146B  A5 B8                 LDA WORKGRIDPOSLO
00836  146D  69 28                 ADC #$28
00837  146F  85 B8                 STA WORKGRIDPOSLO
00838  1471  A5 B9                 LDA WORKGRIDPOSHI
00839  1473  69 00                 ADC #$00
00840  1475  85 B9                 STA WORKGRIDPOSHI
00841  1477  E8                    INX
00842  1478  E0 08                 CPX #$08
00843  147A  D0 E9                 BNE LOOP5
00844  147C             
00845  147C  20 CC 11              JSR STOREDITGRID
00846  147F             
00847  147F  A9 29                 LDA #<EDITGRIDHOME
00848  1481  8D 28 14              STA DATAIDX26+1
00849  1484  A9 2A                 LDA #<EDITGRIDHOME+1
00850  1486  8D 2B 14              STA DATAIDX27+1
00851  1489  A9 04                 LDA #>EDITGRIDHOME
00852  148B  8D 29 14              STA DATAIDX26+2
00853  148E  8D 2C 14              STA DATAIDX27+2
00854  1491  60                    RTS
00855  1492             ;===============================================================================
00856  1492             ; TRANSFER MODE COMMANDS
00857  1492             ;===============================================================================
00858  1492             
00859  1492             ;
00860  1492             ; COMMAND HANDLER : SELECT NEXT CHARACTER IN CHARACTER SET
00861  1492             ;
00862  1492             SELECTNEXTCHR 
00863  1492  A5 BA                 LDA CHARSETPOSLO
00864  1494  C9 DC                 CMP #<CHARSETEND
00865  1496  D0 21                 BNE MOVENEXTCHR
00866  1498             
00867  1498  A5 BB                 LDA CHARSETPOSHI
00868  149A  C9 07                 CMP #>CHARSETEND
00869  149C  D0 1B                 BNE MOVENEXTCHR
00870  149E             
00871  149E  A9 D1                 LDA #<CHARSETHOME
00872  14A0  85 BA                 STA CHARSETPOSLO
00873  14A2  A9 06                 LDA #>CHARSETHOME
00874  14A4  85 BB                 STA CHARSETPOSHI
00875  14A6             
00876  14A6  A2 00                 LDX #$00
00877  14A8  AD 01 56              LDA EDITINGCHAR
00878  14AB  81 BA                 STA (CHARSETPOSLO,X)
00879  14AD  A9 00                 LDA #$00
00880  14AF  85 A8                 STA CHARMEMPOSLO
00881  14B1  8D 01 56              STA EDITINGCHAR
00882  14B4  A9 30                 LDA #>CHARMEMBASE
00883  14B6  85 A9                 STA CHARMEMPOSHI
00884  14B8  60                    RTS
00885  14B9             
00886  14B9             MOVENEXTCHR 
00887  14B9  A2 00                 LDX #$00
00888  14BB             
00889  14BB             LOOP13
00890  14BB  A5 BA                 LDA CHARSETPOSLO
00891  14BD             
00892  14BD             DATAIDX17
00893  14BD  C9 F6                 CMP #$F6
00894  14BF  D0 11                 BNE JMP21
00895  14C1             
00896  14C1  A5 BB                 LDA CHARSETPOSHI
00897  14C3             
00898  14C3             DATAIDX18
00899  14C3  C9 06                 CMP #$06
00900  14C5  D0 0B                 BNE JMP21
00901  14C7             
00902  14C7  A9 F6                 LDA #$F6
00903  14C9  8D BE 14              STA DATAIDX17+1
00904  14CC  A9 06                 LDA #$06
00905  14CE  8D C4 14              STA DATAIDX18+1
00906  14D1  60                    RTS
00907  14D2             
00908  14D2             JMP21
00909  14D2  18                    CLC
00910  14D3  AD BE 14              LDA DATAIDX17+1
00911  14D6  69 28                 ADC #$28
00912  14D8  8D BE 14              STA DATAIDX17+1
00913  14DB  AD C4 14              LDA DATAIDX18+1
00914  14DE  69 00                 ADC #$00
00915  14E0  8D C4 14              STA DATAIDX18+1
00916  14E3  E8                    INX
00917  14E4  E0 08                 CPX #$08
00918  14E6  D0 D3                 BNE LOOP13
00919  14E8             
00920  14E8  A2 00                 LDX #$00
00921  14EA  AD 01 56              LDA EDITINGCHAR
00922  14ED  81 BA                 STA (CHARSETPOSLO,X)
00923  14EF  A9 F6                 LDA #$F6
00924  14F1  8D BE 14              STA DATAIDX17+1
00925  14F4  A9 06                 LDA #$06
00926  14F6  8D C4 14              STA DATAIDX18+1
00927  14F9  18                    CLC
00928  14FA  A5 BA                 LDA CHARSETPOSLO
00929  14FC  69 01                 ADC #$01
00930  14FE  85 BA                 STA CHARSETPOSLO
00931  1500  A5 BB                 LDA CHARSETPOSHI
00932  1502  69 00                 ADC #$00
00933  1504  85 BB                 STA CHARSETPOSHI
00934  1506  18                    CLC
00935  1507  A5 A8                 LDA CHARMEMPOSLO
00936  1509  69 08                 ADC #$08
00937  150B  85 A8                 STA CHARMEMPOSLO
00938  150D  A5 A9                 LDA CHARMEMPOSHI
00939  150F  69 00                 ADC #$00
00940  1511  85 A9                 STA CHARMEMPOSHI
00941  1513  EE 01 56              INC EDITINGCHAR
00942  1516  60                    RTS
00943  1517             
00944  1517             ;
00945  1517             ; COMMAND HANDLER : SELECT PREVIOUS CHARACTER IN CHARACTER SET
00946  1517             ;
00947  1517             ALIGN
00948  1600             SELECTPREVCHR 
00949  1600  A5 BA                 LDA CHARSETPOSLO ; AT START OF CHARACTER MAP?
00950  1602  C9 D1                 CMP #<CHARSETHOME
00951  1604  D0 23                 BNE JMP22
00952  1606             
00953  1606  A5 BB                 LDA CHARSETPOSHI
00954  1608  C9 06                 CMP #>CHARSETHOME
00955  160A  D0 1D                 BNE JMP22
00956  160C             
00957  160C  A9 DC                 LDA #<CHARSETEND        ; AT BEGINNING SO WRAP TO END OF CHARACTERS $07DC ON SCREEN
00958  160E  85 BA                 STA CHARSETPOSLO
00959  1610  A9 07                 LDA #>CHARSETEND
00960  1612  85 BB                 STA CHARSETPOSHI
00961  1614  A2 00                 LDX #$00
00962  1616  AD 01 56              LDA EDITINGCHAR
00963  1619  81 BA                 STA (CHARSETPOSLO,X)
00964  161B  A9 FF                 LDA #$FF                ; EDITING LAST CHAR - $FF
00965  161D  8D 01 56              STA EDITINGCHAR
00966  1620  A9 F8                 LDA #<CHARMEMEND
00967  1622  85 A8                 STA CHARMEMPOSLO
00968  1624  A9 37                 LDA #>CHARMEMEND
00969  1626  85 A9                 STA CHARMEMPOSHI
00970  1628  60                    RTS
00971  1629             
00972  1629             JMP22
00973  1629  A2 00                 LDX #$00
00974  162B             
00975  162B             LOOP14
00976  162B  A5 BA                 LDA CHARSETPOSLO        ; START OF A ROW POSITION INSTEAD?
00977  162D             
00978  162D             DATAIDX19
00979  162D  C9 D1                 CMP #<CHARSETHOME
00980  162F  D0 11                 BNE JMP23
00981  1631             
00982  1631  A5 BB                 LDA CHARSETPOSHI
00983  1633             
00984  1633             DATAIDX20
00985  1633  C9 06                 CMP #>CHARSETHOME
00986  1635  D0 0B                 BNE JMP23
00987  1637             
00988  1637  A9 D1                 LDA #<CHARSETHOME       ; RESET POSITION COMPARISON TO BEGINNING OF SCREEN CHAR MAP
00989  1639  8D 2E 16              STA DATAIDX19+1
00990  163C  A9 06                 LDA #>CHARSETHOME
00991  163E  8D 34 16              STA DATAIDX20+1
00992  1641  60                    RTS
00993  1642             
00994  1642             JMP23
00995  1642  18                    CLC
00996  1643  AD 2E 16              LDA DATAIDX19+1
00997  1646  69 28                 ADC #$28
00998  1648  8D 2E 16              STA DATAIDX19+1
00999  164B  AD 34 16              LDA DATAIDX20+1
01000  164E  69 00                 ADC #$00
01001  1650  8D 34 16              STA DATAIDX20+1
01002  1653  E8                    INX
01003  1654  E0 08                 CPX #$08
01004  1656  D0 D3                 BNE LOOP14
01005  1658             
01006  1658  A2 00                 LDX #$00
01007  165A  AD 01 56              LDA EDITINGCHAR
01008  165D  81 BA                 STA (CHARSETPOSLO,X)
01009  165F  A9 D1                 LDA #<CHARSETHOME
01010  1661  8D 2E 16              STA DATAIDX19+1
01011  1664  A9 06                 LDA #>CHARSETHOME
01012  1666  8D 34 16              STA DATAIDX20+1
01013  1669  38                    SEC
01014  166A  A5 BA                 LDA CHARSETPOSLO
01015  166C  E9 01                 SBC #$01
01016  166E  85 BA                 STA CHARSETPOSLO
01017  1670  A5 BB                 LDA CHARSETPOSHI
01018  1672  E9 00                 SBC #$00
01019  1674  85 BB                 STA CHARSETPOSHI
01020  1676  38                    SEC
01021  1677  A5 A8                 LDA CHARMEMPOSLO
01022  1679  E9 08                 SBC #$08
01023  167B  85 A8                 STA CHARMEMPOSLO
01024  167D  A5 A9                 LDA CHARMEMPOSHI
01025  167F  E9 00                 SBC #$00
01026  1681  85 A9                 STA CHARMEMPOSHI
01027  1683  CE 01 56              DEC EDITINGCHAR
01028  1686  60                    RTS
01029  1687             
01030  1687             ;
01031  1687             ; COMMAND HANDLER : MOVE UP A LINE IN CHARACTER SET
01032  1687             ;
01033  1687             MOVEUPALINE 
01034  1687  A2 00                 LDX #$00
01035  1689             
01036  1689             LOOP15
01037  1689  A5 BA                 LDA CHARSETPOSLO
01038  168B             
01039  168B             DATAIDX21
01040  168B  C9 D1                 CMP #<CHARSETHOME
01041  168D  D0 0C                 BNE JMP24
01042  168F             
01043  168F  A5 BB                 LDA CHARSETPOSHI
01044  1691  C9 06                 CMP #>CHARSETHOME
01045  1693  D0 06                 BNE JMP24
01046  1695             
01047  1695  A9 D1                 LDA #<CHARSETHOME
01048  1697  8D 8C 16              STA DATAIDX21+1
01049  169A  60                    RTS
01050  169B             
01051  169B             JMP24
01052  169B  EE 8C 16              INC DATAIDX21+1
01053  169E  E8                    INX
01054  169F  E0 26                 CPX #$26
01055  16A1  D0 E6                 BNE LOOP15
01056  16A3             
01057  16A3  A9 D1                 LDA #<CHARSETHOME
01058  16A5  8D 8C 16              STA DATAIDX21+1
01059  16A8  AD 01 56              LDA EDITINGCHAR
01060  16AB  A2 00                 LDX #$00
01061  16AD  81 BA                 STA (CHARSETPOSLO,X)
01062  16AF  38                    SEC
01063  16B0  A5 BA                 LDA CHARSETPOSLO
01064  16B2  E9 28                 SBC #$28
01065  16B4  85 BA                 STA CHARSETPOSLO
01066  16B6  A5 BB                 LDA CHARSETPOSHI
01067  16B8  E9 00                 SBC #$00
01068  16BA  85 BB                 STA CHARSETPOSHI
01069  16BC  38                    SEC
01070  16BD  AD 01 56              LDA EDITINGCHAR
01071  16C0  E9 26                 SBC #$26
01072  16C2  8D 01 56              STA EDITINGCHAR
01073  16C5  38                    SEC
01074  16C6  A5 A8                 LDA CHARMEMPOSLO
01075  16C8  E9 30                 SBC #$30
01076  16CA  85 A8                 STA CHARMEMPOSLO
01077  16CC  A5 A9                 LDA CHARMEMPOSHI
01078  16CE  E9 01                 SBC #$01
01079  16D0  85 A9                 STA CHARMEMPOSHI
01080  16D2  60                    RTS
01081  16D3             
01082  16D3             ;
01083  16D3             ; COMMAND HANDLER : MOVE DOWN A LINE IN CHARACTER SET
01084  16D3             ;
01085  16D3             ALIGN
01086  1700             MOVEDOWNALINE 
01087  1700  A2 00                 LDX #$00
01088  1702             
01089  1702             LOOP1
01090  1702  A5 BA                 LDA CHARSETPOSLO
01091  1704             
01092  1704             DATAIDX24
01093  1704  C9 B5                 CMP #$B5
01094  1706  D0 0C                 BNE JMP20
01095  1708             
01096  1708  A5 BB                 LDA CHARSETPOSHI
01097  170A  C9 07                 CMP #$07
01098  170C  D0 06                 BNE JMP20
01099  170E             
01100  170E  A9 B5                 LDA #$B5
01101  1710  8D 05 17              STA DATAIDX24+1
01102  1713  60                    RTS
01103  1714             
01104  1714             JMP20
01105  1714  EE 05 17              INC DATAIDX24+1
01106  1717  E8                    INX
01107  1718  E0 0A                 CPX #$0A
01108  171A  D0 E6                 BNE LOOP1
01109  171C             
01110  171C  A9 B5                 LDA #$B5
01111  171E  8D 05 17              STA DATAIDX24+1
01112  1721  A2 00                 LDX #$00
01113  1723             
01114  1723             LOOP2
01115  1723  A5 BA                 LDA CHARSETPOSLO
01116  1725             
01117  1725             DATAIDX25
01118  1725  C9 C1                 CMP #$C1
01119  1727  D0 0C                 BNE JMP25
01120  1729             
01121  1729  A5 BB                 LDA CHARSETPOSHI
01122  172B  C9 07                 CMP #$07
01123  172D  D0 06                 BNE JMP25
01124  172F             
01125  172F  A9 C1                 LDA #$C1
01126  1731  8D 26 17              STA DATAIDX25+1
01127  1734  60                    RTS
01128  1735             
01129  1735             JMP25
01130  1735  EE 26 17              INC DATAIDX25+1
01131  1738  E8                    INX
01132  1739  E0 26                 CPX #$26
01133  173B  D0 E6                 BNE LOOP2
01134  173D             
01135  173D  A9 C1                 LDA #$C1
01136  173F  8D 26 17              STA DATAIDX25+1
01137  1742  AD 01 56              LDA EDITINGCHAR
01138  1745  A2 00                 LDX #$00
01139  1747  81 BA                 STA (CHARSETPOSLO,X)
01140  1749  18                    CLC
01141  174A  A5 BA                 LDA CHARSETPOSLO
01142  174C  69 28                 ADC #$28
01143  174E  85 BA                 STA CHARSETPOSLO
01144  1750  A5 BB                 LDA CHARSETPOSHI
01145  1752  69 00                 ADC #$00
01146  1754  85 BB                 STA CHARSETPOSHI
01147  1756  18                    CLC
01148  1757  AD 01 56              LDA EDITINGCHAR
01149  175A  69 26                 ADC #$26
01150  175C  8D 01 56              STA EDITINGCHAR
01151  175F  18                    CLC
01152  1760  A5 A8                 LDA CHARMEMPOSLO
01153  1762  69 30                 ADC #$30
01154  1764  85 A8                 STA CHARMEMPOSLO
01155  1766  A5 A9                 LDA CHARMEMPOSHI
01156  1768  69 01                 ADC #$01
01157  176A  85 A9                 STA CHARMEMPOSHI
01158  176C  60                    RTS
01159  176D             ;===============================================================================
01160  176D             ; CLEAR PIXELS OF EDITING CHARACTER
01161  176D             ;===============================================================================
01162  176D             
01163  176D             CLEARGRID88 
01164  176D  A9 29                 LDA #<EDITGRIDHOME
01165  176F  85 B8                 STA WORKGRIDPOSLO
01166  1771  A9 04                 LDA #>EDITGRIDHOME
01167  1773  85 B9                 STA WORKGRIDPOSHI
01168  1775             
01169  1775  A0 00                 LDY #$00
01170  1777  A9 00                 LDA #$00
01171  1779             
01172  1779             LOOPZEROCOL 
01173  1779  91 A8                 STA (CHARMEMPOSLO),Y
01174  177B  C8                    INY
01175  177C  C0 08                 CPY #$08
01176  177E  D0 F9                 BNE LOOPZEROCOL
01177  1780             
01178  1780  A2 00                 LDX #$00
01179  1782             
01180  1782             NEXTZEROROW 
01181  1782  8A                    TXA
01182  1783  48                    PHA
01183  1784  20 8F 17              JSR CLEARCHARROW
01184  1787  68                    PLA
01185  1788  AA                    TAX
01186  1789  E8                    INX
01187  178A  E0 08                 CPX #$08
01188  178C  D0 F4                 BNE NEXTZEROROW
01189  178E  60                    RTS
01190  178F             
01191  178F             CLEARCHARROW 
01192  178F  A0 00                 LDY #$00
01193  1791  A9 20                 LDA KEYSPACE
01194  1793             
01195  1793             LOOPCLRCOL 
01196  1793  91 B8                 STA (WORKGRIDPOSLO),Y
01197  1795  C8                    INY
01198  1796  C0 08                 CPY #$08
01199  1798  D0 F9                 BNE LOOPCLRCOL
01200  179A             
01201  179A  18                    CLC
01202  179B  A5 B8                 LDA WORKGRIDPOSLO
01203  179D  69 28                 ADC #$28
01204  179F  85 B8                 STA WORKGRIDPOSLO
01205  17A1  A5 B9                 LDA WORKGRIDPOSHI
01206  17A3  69 00                 ADC #$00
01207  17A5  85 B9                 STA WORKGRIDPOSHI
01208  17A7  60                    RTS
01209  17A8             ;===============================================================================
01210  17A8             ; MIRROR EDITING CHARACTER COMMANDS
01211  17A8             ;===============================================================================
01212  17A8             
01213  17A8             ;
01214  17A8             ; COMMAND HANDLER : MIRROR EDITING CHARACTER UP/DOWN (HORIZONTAL)
01215  17A8             ;
01216  17A8             ALIGN
01217  1800             MIRRORCHARHORZ 
01218  1800  A9 29                 LDA #<EDITGRIDHOME
01219  1802  85 B8                 STA WORKGRIDPOSLO
01220  1804  A9 04                 LDA #>EDITGRIDHOME
01221  1806  85 B9                 STA WORKGRIDPOSHI
01222  1808             
01223  1808  A2 00                 LDX #$00
01224  180A             
01225  180A             LOOP22
01226  180A  A0 00                 LDY #$00
01227  180C             
01228  180C             LOOP21
01229  180C  B1 B8                 LDA (WORKGRIDPOSLO),Y
01230  180E             
01231  180E             DATAIDX28
01232  180E  99 2B 56              STA WORKINGCHAR,Y
01233  1811  C8                    INY
01234  1812  C0 08                 CPY #$08
01235  1814  D0 F6                 BNE LOOP21
01236  1816             
01237  1816  18                    CLC
01238  1817  AD 0F 18              LDA DATAIDX28+1
01239  181A  69 08                 ADC #$08
01240  181C  8D 0F 18              STA DATAIDX28+1
01241  181F  18                    CLC
01242  1820  A5 B8                 LDA WORKGRIDPOSLO
01243  1822  69 28                 ADC #$28
01244  1824  85 B8                 STA WORKGRIDPOSLO
01245  1826  A5 B9                 LDA WORKGRIDPOSHI
01246  1828  69 00                 ADC #$00
01247  182A  85 B9                 STA WORKGRIDPOSHI
01248  182C  E8                    INX
01249  182D  E0 08                 CPX #$08
01250  182F  D0 D9                 BNE LOOP22
01251  1831             
01252  1831  A2 00                 LDX #$00
01253  1833             
01254  1833             LOOP24
01255  1833  BD 6B 56              LDA EDITGRIDTOPROWFWDLO,X
01256  1836  85 B8                 STA WORKGRIDPOSLO
01257  1838  A9 04                 LDA #$04
01258  183A  85 B9                 STA WORKGRIDPOSHI
01259  183C  BD 83 56              LDA WORKINGCHARTOPROWREVLO,X
01260  183F  8D 49 18              STA DATAIDX29+1
01261  1842  A0 00                 LDY #$00
01262  1844             
01263  1844             LOOP23
01264  1844  98                    TYA
01265  1845  48                    PHA
01266  1846  A0 00                 LDY #$00
01267  1848             
01268  1848             DATAIDX29
01269  1848  AD 32 56              LDA WORKINGCHAR+7
01270  184B  91 B8                 STA (WORKGRIDPOSLO),Y
01271  184D  68                    PLA
01272  184E  A8                    TAY
01273  184F  18                    CLC
01274  1850  AD 49 18              LDA DATAIDX29+1
01275  1853  69 08                 ADC #$08
01276  1855  8D 49 18              STA DATAIDX29+1
01277  1858  18                    CLC
01278  1859  A5 B8                 LDA WORKGRIDPOSLO
01279  185B  69 28                 ADC #$28
01280  185D  85 B8                 STA WORKGRIDPOSLO
01281  185F  A5 B9                 LDA WORKGRIDPOSHI
01282  1861  69 00                 ADC #$00
01283  1863  85 B9                 STA WORKGRIDPOSHI
01284  1865  C8                    INY
01285  1866  C0 08                 CPY #$08
01286  1868  D0 DA                 BNE LOOP23
01287  186A             
01288  186A  E8                    INX
01289  186B  E0 08                 CPX #$08
01290  186D  D0 C4                 BNE LOOP24
01291  186F             
01292  186F  A9 2B                 LDA #<WORKINGCHAR
01293  1871  8D 0F 18              STA DATAIDX28+1
01294  1874  A9 32                 LDA #<WORKINGCHAR+7
01295  1876  8D 49 18              STA DATAIDX29+1
01296  1879             
01297  1879  20 CC 11              JSR STOREDITGRID
01298  187C  60                    RTS
01299  187D             
01300  187D             ;
01301  187D             ; COMMAND HANDLER : MIRROR EDITING CHARACTER LEFT/RIGHT (VERTICAL)
01302  187D             ;
01303  187D             MIRRORCHARVERT 
01304  187D  A9 29                 LDA #<EDITGRIDHOME
01305  187F  85 B8                 STA WORKGRIDPOSLO
01306  1881  A9 04                 LDA #>EDITGRIDHOME
01307  1883  85 B9                 STA WORKGRIDPOSHI
01308  1885             
01309  1885  A2 00                 LDX #$00
01310  1887             
01311  1887             NEXTMIRRORCHAR 
01312  1887  A0 00                 LDY #$00
01313  1889             
01314  1889             SAVEMIRRORVARS 
01315  1889  B1 B8                 LDA (WORKGRIDPOSLO),Y
01316  188B             
01317  188B             DATAIDX30
01318  188B  99 2B 56              STA WORKINGCHAR,Y
01319  188E  C8                    INY
01320  188F  C0 08                 CPY #$08
01321  1891  D0 F6                 BNE SAVEMIRRORVARS
01322  1893             
01323  1893  18                    CLC
01324  1894  AD 8C 18              LDA DATAIDX30+1
01325  1897  69 08                 ADC #$08
01326  1899  8D 8C 18              STA DATAIDX30+1
01327  189C  18                    CLC
01328  189D  A5 B8                 LDA WORKGRIDPOSLO
01329  189F  69 28                 ADC #$28
01330  18A1  85 B8                 STA WORKGRIDPOSLO
01331  18A3  A5 B9                 LDA WORKGRIDPOSHI
01332  18A5  69 00                 ADC #$00
01333  18A7  85 B9                 STA WORKGRIDPOSHI
01334  18A9  E8                    INX
01335  18AA  E0 08                 CPX #$08
01336  18AC  D0 D9                 BNE NEXTMIRRORCHAR
01337  18AE             
01338  18AE  A9 2B                 LDA #<WORKINGCHAR
01339  18B0  8D 8C 18              STA DATAIDX30+1
01340  18B3  A9 41                 LDA #$41                ; LINE 8 OF 8*8 EDITING GRID
01341  18B5  85 B8                 STA WORKGRIDPOSLO
01342  18B7  A9 05                 LDA #$05                ; LINE 8 OF 8*8 EDITING GRID
01343  18B9  85 B9                 STA WORKGRIDPOSHI
01344  18BB             
01345  18BB  A2 00                 LDX #$00
01346  18BD             
01347  18BD             NEXTMIRRORCALC 
01348  18BD  A0 00                 LDY #$00
01349  18BF             
01350  18BF             LOADMIRRORVARS 
01351  18BF  B9 2B 56              LDA WORKINGCHAR,Y
01352  18C2  91 B8                 STA (WORKGRIDPOSLO),Y
01353  18C4  C8                    INY
01354  18C5  C0 08                 CPY #$08
01355  18C7  D0 F6                 BNE LOADMIRRORVARS
01356  18C9             
01357  18C9  38                    SEC
01358  18CA  A5 B8                 LDA WORKGRIDPOSLO
01359  18CC  E9 28                 SBC #$28
01360  18CE  85 B8                 STA WORKGRIDPOSLO
01361  18D0  A5 B9                 LDA WORKGRIDPOSHI
01362  18D2  E9 00                 SBC #$00
01363  18D4  85 B9                 STA WORKGRIDPOSHI
01364  18D6  18                    CLC
01365  18D7  AD C0 18              LDA LOADMIRRORVARS+1
01366  18DA  69 08                 ADC #$08
01367  18DC  8D C0 18              STA LOADMIRRORVARS+1
01368  18DF  E8                    INX
01369  18E0  E0 08                 CPX #$08
01370  18E2  D0 D9                 BNE NEXTMIRRORCALC
01371  18E4             
01372  18E4  A9 2B                 LDA #<WORKINGCHAR
01373  18E6  8D C0 18              STA LOADMIRRORVARS+1
01374  18E9  20 CC 11              JSR STOREDITGRID
01375  18EC  60                    RTS
01376  18ED             ;===============================================================================
01377  18ED             ; ROTATE EDITING CHARACTER 90 DEGREES
01378  18ED             ;===============================================================================
01379  18ED             
01380  18ED             ALIGN
01381  1900             ROTATECHAR90 
01382  1900  A9 29                 LDA #<EDITGRIDHOME
01383  1902  85 B8                 STA WORKGRIDPOSLO
01384  1904  A9 04                 LDA #>EDITGRIDHOME
01385  1906  85 B9                 STA WORKGRIDPOSHI
01386  1908             
01387  1908  A2 00                 LDX #$00
01388  190A             
01389  190A             NEXTROTATECHAR 
01390  190A  A0 00                 LDY #$00
01391  190C             
01392  190C             SAVEROTATECHAR 
01393  190C  B1 B8                 LDA (WORKGRIDPOSLO),Y
01394  190E             
01395  190E             DATAIDX31
01396  190E  99 2B 56              STA WORKINGCHAR,Y
01397  1911  C8                    INY
01398  1912  C0 08                 CPY #$08
01399  1914  D0 F6                 BNE SAVEROTATECHAR
01400  1916             
01401  1916  18                    CLC
01402  1917  AD 0F 19              LDA DATAIDX31+1
01403  191A  69 08                 ADC #$08
01404  191C  8D 0F 19              STA DATAIDX31+1
01405  191F             
01406  191F  18                    CLC
01407  1920  A5 B8                 LDA WORKGRIDPOSLO
01408  1922  69 28                 ADC #$28
01409  1924  85 B8                 STA WORKGRIDPOSLO
01410  1926  A5 B9                 LDA WORKGRIDPOSHI
01411  1928  69 00                 ADC #$00
01412  192A  85 B9                 STA WORKGRIDPOSHI
01413  192C             
01414  192C  E8                    INX
01415  192D  E0 08                 CPX #$08
01416  192F  D0 D9                 BNE NEXTROTATECHAR
01417  1931             
01418  1931  A9 2B                 LDA #<WORKINGCHAR
01419  1933  8D 0F 19              STA DATAIDX31+1
01420  1936             
01421  1936  A2 00                 LDX #$00
01422  1938             
01423  1938             LOADROTATECHAR 
01424  1938  BD 73 56              LDA EDITGRIDTOPROWREVLO,X
01425  193B  85 B8                 STA WORKGRIDPOSLO
01426  193D  A9 04                 LDA #>EDITGRIDHOME
01427  193F  85 B9                 STA WORKGRIDPOSHI
01428  1941  BD 7B 56              LDA WORKINGCHARROWSLO,X
01429  1944  8D 4C 19              STA DATAIDX32+1
01430  1947  A0 00                 LDY #$00
01431  1949             
01432  1949             NEXTROTATECALC 
01433  1949  98                    TYA
01434  194A  48                    PHA
01435  194B             
01436  194B             DATAIDX32
01437  194B  B9 2B 56              LDA WORKINGCHAR,Y
01438  194E  A0 00                 LDY #$00
01439  1950  91 B8                 STA (WORKGRIDPOSLO),Y
01440  1952  68                    PLA
01441  1953  A8                    TAY
01442  1954  18                    CLC
01443  1955  A5 B8                 LDA WORKGRIDPOSLO
01444  1957  69 28                 ADC #$28
01445  1959  85 B8                 STA WORKGRIDPOSLO
01446  195B  A5 B9                 LDA WORKGRIDPOSHI
01447  195D  69 00                 ADC #$00
01448  195F  85 B9                 STA WORKGRIDPOSHI
01449  1961  C8                    INY
01450  1962  C0 08                 CPY #$08
01451  1964  D0 E3                 BNE NEXTROTATECALC
01452  1966             
01453  1966  E8                    INX
01454  1967  E0 08                 CPX #$08
01455  1969  D0 CD                 BNE LOADROTATECHAR
01456  196B             
01457  196B  A9 2B                 LDA #<WORKINGCHAR
01458  196D  8D 4C 19              STA DATAIDX32+1
01459  1970             
01460  1970  20 CC 11              JSR STOREDITGRID
01461  1973  60                    RTS
01462  1974             ;===============================================================================
01463  1974             ; TOGGLE TRANSFER MODE ON/OFF AND PROCESS MODE COMMANDS
01464  1974             ;===============================================================================
01465  1974             
01466  1974             TRFRMODETOGGLE 
01467  1974  A2 00                 LDX #$00
01468  1976             
01469  1976             SHOWTRFRMSG 
01470  1976  BD 59 55              LDA DATATRFRMODE,X
01471  1979  9D B0 04              STA MESSAGEAREAADDR+2,X
01472  197C  E8                    INX
01473  197D  E0 0D                 CPX #$0D
01474  197F  D0 F5                 BNE SHOWTRFRMSG
01475  1981             
01476  1981  A5 A8                 LDA CHARMEMPOSLO
01477  1983  85 FB                 STA TEMPSAVE1
01478  1985  A5 A9                 LDA CHARMEMPOSHI
01479  1987  85 FC                 STA TEMPSAVE2
01480  1989             
01481  1989             TRFRMODESTART 
01482  1989  A9 29                 LDA #<EDITGRIDHOME
01483  198B  85 B8                 STA WORKGRIDPOSLO
01484  198D  A9 04                 LDA #>EDITGRIDHOME
01485  198F  85 B9                 STA WORKGRIDPOSHI
01486  1991  A2 00                 LDX #$00
01487  1993             
01488  1993             DRAWNEXTROW 
01489  1993  8A                    TXA
01490  1994  48                    PHA
01491  1995  20 5D 23              JSR DRAWEDITROW
01492  1998  68                    PLA
01493  1999  AA                    TAX
01494  199A  E8                    INX
01495  199B  E0 08                 CPX #$08
01496  199D  D0 F4                 BNE DRAWNEXTROW
01497  199F             
01498  199F  38                    SEC
01499  19A0  A5 A8                 LDA CHARMEMPOSLO
01500  19A2  E9 08                 SBC #$08
01501  19A4  85 A8                 STA CHARMEMPOSLO
01502  19A6  A5 A9                 LDA CHARMEMPOSHI
01503  19A8  E9 00                 SBC #$00
01504  19AA  85 A9                 STA CHARMEMPOSHI
01505  19AC             
01506  19AC             WAITTRFRKEYS 
01507  19AC  20 9F FF              JSR KRNL_SCNKEY
01508  19AF  20 E4 FF              JSR KRNL_GETIN
01509  19B2  C9 00                 CMP #$00
01510  19B4  F0 F6                 BEQ WAITTRFRKEYS
01511  19B6             
01512  19B6  C9 5C                 CMP KEYSTERLING
01513  19B8  F0 2B                 BEQ TRFRMODEOFF
01514  19BA             
01515  19BA  C9 2B                 CMP KEYPLUS
01516  19BC  F0 0F                 BEQ TRFRNEXTCHR
01517  19BE             
01518  19BE  C9 2D                 CMP KEYMINUS
01519  19C0  F0 11                 BEQ TRFRPREVCHR
01520  19C2             
01521  19C2  C9 87                 CMP KEYF5
01522  19C4  F0 13                 BEQ TRFRUPALINE
01523  19C6             
01524  19C6  C9 88                 CMP KEYF7
01525  19C8  F0 15                 BEQ TRFRDOWNALINE
01526  19CA             
01527  19CA  4C AC 19              JMP WAITTRFRKEYS
01528  19CD             
01529  19CD             TRFRNEXTCHR 
01530  19CD  20 92 14              JSR SELECTNEXTCHR
01531  19D0  4C 89 19              JMP TRFRMODESTART
01532  19D3             
01533  19D3             TRFRPREVCHR 
01534  19D3  20 00 16              JSR SELECTPREVCHR
01535  19D6  4C 89 19              JMP TRFRMODESTART
01536  19D9             
01537  19D9             TRFRUPALINE 
01538  19D9  20 87 16              JSR MOVEUPALINE
01539  19DC  4C 89 19              JMP TRFRMODESTART
01540  19DF             
01541  19DF             TRFRDOWNALINE 
01542  19DF  20 00 17              JSR MOVEDOWNALINE
01543  19E2  4C 89 19              JMP TRFRMODESTART
01544  19E5             
01545  19E5             TRFRMODEOFF 
01546  19E5  A0 00                 LDY #$00
01547  19E7             
01548  19E7             LOOPTRFRCHAR 
01549  19E7  B1 FB                 LDA (TEMPSAVE1),Y
01550  19E9  91 A8                 STA (CHARMEMPOSLO),Y
01551  19EB  C8                    INY
01552  19EC  C0 08                 CPY #$08
01553  19EE  D0 F7                 BNE LOOPTRFRCHAR
01554  19F0             
01555  19F0  A2 00                 LDX #$00
01556  19F2  A9 20                 LDA KEYSPACE
01557  19F4             
01558  19F4             CLEARTRFRMSG 
01559  19F4  9D B0 04              STA MESSAGEAREAADDR+2,X
01560  19F7  E8                    INX
01561  19F8  E0 0D                 CPX #$0D
01562  19FA  D0 F8                 BNE CLEARTRFRMSG
01563  19FC  60                    RTS
01564  19FD             ;===============================================================================
01565  19FD             ; SHOW HELP COMMAND
01566  19FD             ;===============================================================================
01567  19FD             
01568  19FD             SHOWHELP
01569  19FD  A9 15                 LDA #$15
01570  19FF  8D 18 D0              STA MEMSETUPREG
01571  1A02  78                    SEI
01572  1A03  A9 31                 LDA #<IRQSVCROUTINE
01573  1A05  8D 14 03              STA IRQSVCLOADDR
01574  1A08  A9 EA                 LDA #>IRQSVCROUTINE
01575  1A0A  8D 15 03              STA IRQSVCHIADDR
01576  1A0D  A9 79                 LDA #$79
01577  1A0F  8D 19 D0              STA IRQSTATUSREG
01578  1A12  A9 F0                 LDA #$F0
01579  1A14  8D 1A D0              STA IRQCTLREG
01580  1A17  A9 1B                 LDA DEFAULTSCRNCTL
01581  1A19  8D 11 D0              STA SCRNCTLREG
01582  1A1C  A9 01                 LDA #$01
01583  1A1E  8D 0E DC              STA TIMERACTLREG
01584  1A21  58                    CLI
01585  1A22             
01586  1A22  A2 00                 LDX #$00
01587  1A24             
01588  1A24             LOOPSCRNHELP1 
01589  1A24  BD 00 04              LDA DISPLAYBASE,X
01590  1A27  9D 00 5C              STA SCRNSAVEBASE,X
01591  1A2A  BD 00 05              LDA DISPLAYBASE+$100,X
01592  1A2D  9D 00 5D              STA SCRNSAVEBASE+$100,X
01593  1A30  BD 00 06              LDA DISPLAYBASE+$200,X
01594  1A33  9D 00 5E              STA SCRNSAVEBASE+$200,X
01595  1A36  BD 00 07              LDA DISPLAYBASE+$300,X
01596  1A39  9D 00 5F              STA SCRNSAVEBASE+$300,X
01597  1A3C  BD 00 44              LDA DATASCRNHELP1,X
01598  1A3F  9D 00 04              STA DISPLAYBASE,X
01599  1A42  BD 00 45              LDA DATASCRNHELP1+$100,X
01600  1A45  9D 00 05              STA DISPLAYBASE+$100,X
01601  1A48  BD 00 46              LDA DATASCRNHELP1+$200,X
01602  1A4B  9D 00 06              STA DISPLAYBASE+$200,X
01603  1A4E  BD 00 47              LDA DATASCRNHELP1+$300,X
01604  1A51  9D 00 07              STA DISPLAYBASE+$300,X
01605  1A54  E8                    INX
01606  1A55  D0 CD                 BNE LOOPSCRNHELP1
01607  1A57             
01608  1A57             WAITKEYHELP1 
01609  1A57  20 9F FF              JSR KRNL_SCNKEY
01610  1A5A  20 E4 FF              JSR KRNL_GETIN
01611  1A5D  C9 20                 CMP KEYSPACE
01612  1A5F  D0 F6                 BNE WAITKEYHELP1
01613  1A61             
01614  1A61  A2 00                 LDX #$00
01615  1A63             
01616  1A63             LOOPSCRNHELP2 
01617  1A63  BD 00 48              LDA DATASCRNHELP2,X
01618  1A66  9D 00 04              STA DISPLAYBASE,X
01619  1A69  BD 00 49              LDA DATASCRNHELP2+$100,X
01620  1A6C  9D 00 05              STA DISPLAYBASE+$100,X
01621  1A6F  BD 00 4A              LDA DATASCRNHELP2+$200,X
01622  1A72  9D 00 06              STA DISPLAYBASE+$200,X
01623  1A75  BD 00 4B              LDA DATASCRNHELP2+$300,X
01624  1A78  9D 00 07              STA DISPLAYBASE+$300,X
01625  1A7B  E8                    INX
01626  1A7C  D0 E5                 BNE LOOPSCRNHELP2
01627  1A7E             
01628  1A7E             WAITKEYHELP2 
01629  1A7E  20 9F FF              JSR KRNL_SCNKEY
01630  1A81  20 E4 FF              JSR KRNL_GETIN
01631  1A84  C9 20                 CMP KEYSPACE
01632  1A86  D0 F6                 BNE WAITKEYHELP2
01633  1A88             
01634  1A88  A2 00                 LDX #$00
01635  1A8A             
01636  1A8A             LOOPSHOWSCRN 
01637  1A8A  BD 00 5C              LDA SCRNSAVEBASE,X
01638  1A8D  9D 00 04              STA DISPLAYBASE,X
01639  1A90  BD 00 5D              LDA SCRNSAVEBASE+$100,X
01640  1A93  9D 00 05              STA DISPLAYBASE+$100,X
01641  1A96  BD 00 5E              LDA SCRNSAVEBASE+$200,X
01642  1A99  9D 00 06              STA DISPLAYBASE+$200,X
01643  1A9C  BD 00 5F              LDA SCRNSAVEBASE+$300,X
01644  1A9F  9D 00 07              STA DISPLAYBASE+$300,X
01645  1AA2             
01646  1AA2  A9 00                 LDA #$00
01647  1AA4  9D 00 5C              STA SCRNSAVEBASE,X
01648  1AA7  9D 00 5D              STA SCRNSAVEBASE+$100,X
01649  1AAA  9D 00 5E              STA SCRNSAVEBASE+$200,X
01650  1AAD  9D 00 5F              STA SCRNSAVEBASE+$300,X
01651  1AB0  E8                    INX
01652  1AB1  D0 D7                 BNE LOOPSHOWSCRN
01653  1AB3             
01654  1AB3  20 DB 1A              JSR SHOWCHARCURSOR
01655  1AB6  60                    RTS
01656  1AB7             ;===============================================================================
01657  1AB7             ; POSITION CURSOR AT HOME ON 8*8 EDITING GRID
01658  1AB7             ;===============================================================================
01659  1AB7             
01660  1AB7             ;
01661  1AB7             ; UTILITY FUNCTION : SHOW EDITING CURSOR BY INVERTING EDIT GRID 'PIXEL' TEMPORARILY
01662  1AB7             ;
01663  1AB7             SHOWEDITCURSOR 
01664  1AB7  A2 00                 LDX #$00
01665  1AB9  A1 AA                 LDA (EDITGRIDPOSLO,X)
01666  1ABB  48                    PHA                   ; SAVE ACTUAL 'PIXEL' VALUE IN 8*8 EDIT GRID
01667  1ABC             
01668  1ABC  C9 A0                 CMP KEYFULLBLOCK
01669  1ABE  F0 07                 BEQ CLREDITCRSR       ; INVERT THE PIXEL AND PAUSE TO MAKE CURSOR BLINK
01670  1AC0             
01671  1AC0  A9 A0                 LDA KEYFULLBLOCK
01672  1AC2  81 AA                 STA (EDITGRIDPOSLO,X)
01673  1AC4  4C CB 1A              JMP WAITEDITCRSR
01674  1AC7             
01675  1AC7             CLREDITCRSR 
01676  1AC7  A9 20                 LDA KEYSPACE
01677  1AC9  81 AA                 STA (EDITGRIDPOSLO,X)
01678  1ACB             
01679  1ACB             WAITEDITCRSR 
01680  1ACB  A9 10                 LDA #$10
01681  1ACD  A8                    TAY
01682  1ACE             
01683  1ACE             LOOPEDITCRSRY 
01684  1ACE  AA                    TAX
01685  1ACF             
01686  1ACF             LOOPEDITCRSRX 
01687  1ACF  CA                    DEX
01688  1AD0  D0 FD                 BNE LOOPEDITCRSRX
01689  1AD2  88                    DEY
01690  1AD3  D0 F9                 BNE LOOPEDITCRSRY
01691  1AD5             
01692  1AD5  68                    PLA                   ; RESTORE ACTUAL 'PIXEL' VALUE IN 8*8 EDIT GRID
01693  1AD6  A2 00                 LDX #$00
01694  1AD8  81 AA                 STA (EDITGRIDPOSLO,X)
01695  1ADA  60                    RTS
01696  1ADB             
01697  1ADB             ;
01698  1ADB             ; UTILITY FUNCTION : SHOW CHARACTER SET CURSOR
01699  1ADB             ;
01700  1ADB             SHOWCHARCURSOR 
01701  1ADB  78                    SEI
01702  1ADC  A9 FF                 LDA #<IRQCURSOR
01703  1ADE  8D 14 03              STA IRQSVCLOADDR
01704  1AE1  A9 1A                 LDA #>IRQCURSOR
01705  1AE3  8D 15 03              STA IRQSVCHIADDR
01706  1AE6             
01707  1AE6  A9 01                 LDA #$01
01708  1AE8  8D 19 D0              STA IRQSTATUSREG
01709  1AEB  8D 1A D0              STA IRQCTLREG
01710  1AEE  A9 00                 LDA #$00
01711  1AF0  8D 0E DC              STA TIMERACTLREG
01712  1AF3  A9 1B                 LDA DEFAULTSCRNCTL
01713  1AF5  8D 11 D0              STA SCRNCTLREG
01714  1AF8  A9 00                 LDA #$00
01715  1AFA  8D 12 D0              STA RASTERLINE
01716  1AFD  58                    CLI
01717  1AFE  60                    RTS
01718  1AFF             
01719  1AFF             IRQCURSOR
01720  1AFF  A9 00                 LDA #$00
01721  1B01             
01722  1B01             WAITRASTER1 
01723  1B01  CD 12 D0              CMP RASTERLINE
01724  1B04  D0 FB                 BNE WAITRASTER1
01725  1B06             
01726  1B06  A9 15                 LDA #$15
01727  1B08  8D 18 D0              STA MEMSETUPREG
01728  1B0B  A9 82                 LDA #$82
01729  1B0D             
01730  1B0D             WAITRASTER2 
01731  1B0D  CD 12 D0              CMP RASTERLINE
01732  1B10  D0 FB                 BNE WAITRASTER2
01733  1B12             
01734  1B12  A9 1D                 LDA #$1D
01735  1B14  8D 18 D0              STA MEMSETUPREG
01736  1B17  A9 FF                 LDA #$FF
01737  1B19             
01738  1B19             WAITRASTER3 
01739  1B19  CD 12 D0              CMP RASTERLINE
01740  1B1C  D0 FB                 BNE WAITRASTER3
01741  1B1E             
01742  1B1E  A9 01                 LDA #$01
01743  1B20  8D 19 D0              STA IRQSTATUSREG
01744  1B23  20 29 1B              JSR BLINKCURSOR
01745  1B26  4C 31 EA              JMP IRQSVCROUTINE
01746  1B29             
01747  1B29             ;
01748  1B29             ; UTILITY FUNCTION : BLINK CHARACTER SET CURSOR (UNDER INTERRUPT)
01749  1B29             ;
01750  1B29             BLINKCURSOR 
01751  1B29  CE 00 56              DEC CURSORTIMER
01752  1B2C  F0 01                 BEQ MAKECURSOR
01753  1B2E  60                    RTS
01754  1B2F             
01755  1B2F             MAKECURSOR 
01756  1B2F  A9 10                 LDA #CURSORDELAY
01757  1B31  8D 00 56              STA CURSORTIMER
01758  1B34  A2 00                 LDX #$00
01759  1B36  A1 BA                 LDA (CHARSETPOSLO,X)
01760  1B38  CD 01 56              CMP EDITINGCHAR
01761  1B3B  F0 06                 BEQ HIDECHAR
01762  1B3D             
01763  1B3D  AD 01 56              LDA EDITINGCHAR
01764  1B40  81 BA                 STA (CHARSETPOSLO,X)
01765  1B42  60                    RTS
01766  1B43             
01767  1B43             HIDECHAR
01768  1B43  A9 20                 LDA KEYSPACE
01769  1B45  81 BA                 STA (CHARSETPOSLO,X)
01770  1B47  60                    RTS
01771  1B48             
01772  1B48             ;
01773  1B48             ; UTILITY FUNCTION : SHOW CHARACTER GRID CURSOR BY INVERTING CHARACTER GRID 'PIXEL' TEMPORARILY
01774  1B48             ;
01775  1B48             SHOWGRIDCURSOR 
01776  1B48  18                    CLC
01777  1B49  A5 D1                 LDA SCRNLINEPNTLO
01778  1B4B  65 D3                 ADC SCRNCOLPNTR
01779  1B4D  8D 64 1B              STA SAVEGRIDCHAR+1
01780  1B50  8D 6A 1B              STA SETGRIDCRSR+1
01781  1B53  8D 78 1B              STA SETGRIDCHAR+1
01782  1B56  A5 D2                 LDA SCRNLINEPNTHI
01783  1B58  69 00                 ADC #$00
01784  1B5A  8D 65 1B              STA SAVEGRIDCHAR+2
01785  1B5D  8D 6B 1B              STA SETGRIDCRSR+2
01786  1B60  8D 79 1B              STA SETGRIDCHAR+2
01787  1B63             
01788  1B63             SAVEGRIDCHAR 
01789  1B63  AD B9 05              LDA SCRNGRIDHOME
01790  1B66  48                    PHA
01791  1B67  A9 A0                 LDA KEYFULLBLOCK
01792  1B69             SETGRIDCRSR 
01793  1B69  8D B9 05              STA SCRNGRIDHOME
01794  1B6C  A9 0A                 LDA #$0A
01795  1B6E  A8                    TAY
01796  1B6F             
01797  1B6F             WAITCRSRONY 
01798  1B6F  AA                    TAX
01799  1B70             
01800  1B70             WAITCRSRONX 
01801  1B70  CA                    DEX
01802  1B71  D0 FD                 BNE WAITCRSRONX
01803  1B73  88                    DEY
01804  1B74  D0 F9                 BNE WAITCRSRONY
01805  1B76             
01806  1B76  68                    PLA
01807  1B77             
01808  1B77             SETGRIDCHAR 
01809  1B77  8D B9 05              STA SCRNGRIDHOME
01810  1B7A  A9 0A                 LDA #$0A
01811  1B7C  A8                    TAY
01812  1B7D             
01813  1B7D             WAITCHARONY 
01814  1B7D  AA                    TAX
01815  1B7E             
01816  1B7E             WAITCHARONX 
01817  1B7E  CA                    DEX
01818  1B7F  D0 FD                 BNE WAITCHARONX
01819  1B81  88                    DEY
01820  1B82  D0 F9                 BNE WAITCHARONY
01821  1B84  60                    RTS
01822  1B85             ;===============================================================================
01823  1B85             ; INVERT EDITING CHARACTER PIXELS
01824  1B85             ;===============================================================================
01825  1B85             
01826  1B85             INVERTCHAR 
01827  1B85  A9 29                 LDA #<EDITGRIDHOME
01828  1B87  85 B8                 STA WORKGRIDPOSLO
01829  1B89  A9 04                 LDA #>EDITGRIDHOME
01830  1B8B  85 B9                 STA WORKGRIDPOSHI
01831  1B8D             
01832  1B8D  A2 00                 LDX #$00
01833  1B8F             LOOP20
01834  1B8F  8A                    TXA
01835  1B90  48                    PHA
01836  1B91  20 9F 1B              JSR INVERTPIXEL
01837  1B94  68                    PLA
01838  1B95  AA                    TAX
01839  1B96  E8                    INX
01840  1B97  E0 08                 CPX #$08
01841  1B99  D0 F4                 BNE LOOP20
01842  1B9B             
01843  1B9B  20 CC 11              JSR STOREDITGRID
01844  1B9E  60                    RTS
01845  1B9F             
01846  1B9F             INVERTPIXEL 
01847  1B9F  A0 00                 LDY #$00
01848  1BA1             
01849  1BA1             TSTGRIDPIXEL 
01850  1BA1  B1 B8                 LDA (WORKGRIDPOSLO),Y
01851  1BA3  C9 A0                 CMP KEYFULLBLOCK
01852  1BA5  F0 05                 BEQ CLRGRIDPIXEL
01853  1BA7                        
01854  1BA7  A9 A0                 LDA KEYFULLBLOCK
01855  1BA9  4C AE 1B              JMP NXTGRIDPIXEL
01856  1BAC             
01857  1BAC             CLRGRIDPIXEL 
01858  1BAC  A9 20                 LDA KEYSPACE
01859  1BAE             
01860  1BAE             NXTGRIDPIXEL 
01861  1BAE  91 B8                 STA (WORKGRIDPOSLO),Y
01862  1BB0  C8                    INY
01863  1BB1  C0 08                 CPY #$08
01864  1BB3  D0 EC                 BNE TSTGRIDPIXEL
01865  1BB5                        
01866  1BB5  18                    CLC
01867  1BB6  A5 B8                 LDA WORKGRIDPOSLO
01868  1BB8  69 28                 ADC #$28
01869  1BBA  85 B8                 STA WORKGRIDPOSLO
01870  1BBC  A5 B9                 LDA WORKGRIDPOSHI
01871  1BBE  69 00                 ADC #$00
01872  1BC0  85 B9                 STA WORKGRIDPOSHI
01873  1BC2  60                    RTS
01874  1BC3             ;===============================================================================
01875  1BC3             ; COPY ROM CHAR TO RAM CHAR POSITION
01876  1BC3             ;===============================================================================
01877  1BC3             
01878  1BC3             COPYROMCHAR 
01879  1BC3  78                    SEI
01880  1BC4  A9 31                 LDA #<IRQSVCROUTINE
01881  1BC6  8D 14 03              STA IRQSVCLOADDR
01882  1BC9  A9 EA                 LDA #>IRQSVCROUTINE
01883  1BCB  8D 15 03              STA IRQSVCHIADDR
01884  1BCE             
01885  1BCE  A9 79                 LDA #$79
01886  1BD0  8D 19 D0              STA IRQSTATUSREG
01887  1BD3  A9 F0                 LDA #$F0
01888  1BD5  8D 1A D0              STA IRQCTLREG
01889  1BD8  A9 01                 LDA #$01
01890  1BDA  8D 0E DC              STA TIMERACTLREG
01891  1BDD  58                    CLI
01892  1BDE             
01893  1BDE  A9 00                 LDA #$00
01894  1BE0  85 BC                 STA TEMPCHARSAVE
01895  1BE2             
01896  1BE2             COPYROMCHARIDX 
01897  1BE2  A9 D0                 LDA #>UPPERCHRROM
01898  1BE4  85 BD                 STA TEMPSAVE6
01899  1BE6             
01900  1BE6  38                    SEC
01901  1BE7  A5 A8                 LDA CHARMEMPOSLO
01902  1BE9  E9 00                 SBC #$00
01903  1BEB  85 AC                 STA TEMPSAVE4
01904  1BED  A5 A9                 LDA CHARMEMPOSHI
01905  1BEF  E9 30                 SBC #$30
01906  1BF1  85 AD                 STA TEMPSAVE5
01907  1BF3             
01908  1BF3  18                    CLC
01909  1BF4  A5 BC                 LDA TEMPCHARSAVE
01910  1BF6  65 AC                 ADC TEMPSAVE4
01911  1BF8  85 BC                 STA TEMPCHARSAVE
01912  1BFA  A5 BD                 LDA TEMPSAVE6
01913  1BFC  65 AD                 ADC TEMPSAVE5
01914  1BFE  85 BD                 STA TEMPSAVE6
01915  1C00             
01916  1C00  A9 7F                 LDA #$7F
01917  1C02  8D 0D DC              STA IRQCTLSTATREG
01918  1C05  A9 33                 LDA #$33
01919  1C07  85 01                 STA PROCPORT
01920  1C09             
01921  1C09  A0 00                 LDY #$00
01922  1C0B             LOOP25
01923  1C0B  B1 BC                 LDA (TEMPCHARSAVE),Y
01924  1C0D  91 A8                 STA (CHARMEMPOSLO),Y
01925  1C0F  C8                    INY
01926  1C10  C0 08                 CPY #$08
01927  1C12  D0 F7                 BNE LOOP25
01928  1C14             
01929  1C14  A9 37                 LDA #$37
01930  1C16  85 01                 STA PROCPORT
01931  1C18  A9 81                 LDA #$81
01932  1C1A  8D 0D DC              STA IRQCTLSTATREG
01933  1C1D             
01934  1C1D  20 DB 1A              JSR SHOWCHARCURSOR
01935  1C20  60                    RTS
01936  1C21             ;===============================================================================
01937  1C21             ; TOGGLE FOCUS BETWEEN 8*8 AND 20*6 GRIDS
01938  1C21             ;===============================================================================
01939  1C21             
01940  1C21             ALIGN
01941  1D00             SWAPWINDOWMAPS 
01942  1D00  A9 32                 LDA KEY2                ; PRINT 20*6
01943  1D02  8D 3C 04              STA GRIDMODEADDR
01944  1D05  A9 30                 LDA KEY0
01945  1D07  8D 3D 04              STA GRIDMODEADDR+1
01946  1D0A  A9 2A                 LDA KEYASTERISK
01947  1D0C  8D 3E 04              STA GRIDMODEADDR+2
01948  1D0F  A9 36                 LDA KEY6
01949  1D11  8D 3F 04              STA GRIDMODEADDR+3
01950  1D14             
01951  1D14             CHARCURSORROW 
01952  1D14  A2 0B                 LDX CHARCRSRHOMEROW     ; TODO: THIS IS MODIFIED OUTSIDE OF ROUTINE
01953  1D16             
01954  1D16             CHARCURSORCOL 
01955  1D16  A0 01                 LDY CHARCRSRHOMECOL
01956  1D18  18                    CLC
01957  1D19  20 F0 FF              JSR KRNL_PLOT
01958  1D1C             
01959  1D1C             WAITSWAPCMDS 
01960  1D1C  20 9F FF              JSR KRNL_SCNKEY
01961  1D1F  20 E4 FF              JSR KRNL_GETIN
01962  1D22  A2 00                 LDX #$00
01963  1D24             
01964  1D24             SCANSWAPCMDS 
01965  1D24  DD 00 58              CMP SWAPCMDS,X
01966  1D27  F0 F3                 BEQ WAITSWAPCMDS
01967  1D29             
01968  1D29  E8                    INX
01969  1D2A  E0 0A                 CPX #$0A
01970  1D2C  D0 F6                 BNE SCANSWAPCMDS
01971  1D2E             
01972  1D2E  C9 0D                 CMP KEYRETURN
01973  1D30  F0 0C                 BEQ SWAPWINDOWOFF
01974  1D32             
01975  1D32  20 D2 FF              JSR KRNL_CHROUT
01976  1D35             
01977  1D35  20 48 1B              JSR SHOWGRIDCURSOR
01978  1D38  20 65 24              JSR CHECKCHARSTICK
01979  1D3B  4C 14 1D              JMP CHARCURSORROW
01980  1D3E             
01981  1D3E             SWAPWINDOWOFF 
01982  1D3E  A9 0B                 LDA CHARCRSRHOMEROW
01983  1D40  8D 15 1D              STA CHARCURSORROW+1
01984  1D43  A9 01                 LDA CHARCRSRHOMECOL
01985  1D45  8D 17 1D              STA CHARCURSORCOL+1
01986  1D48             
01987  1D48  A9 20                 LDA KEYSPACE            ; PRINT 8*8
01988  1D4A  8D 3C 04              STA GRIDMODEADDR
01989  1D4D  A9 38                 LDA KEY8
01990  1D4F  8D 3D 04              STA GRIDMODEADDR+1
01991  1D52  A9 2A                 LDA KEYASTERISK
01992  1D54  8D 3E 04              STA GRIDMODEADDR+2
01993  1D57  A9 38                 LDA KEY8
01994  1D59  8D 3F 04              STA GRIDMODEADDR+3
01995  1D5C  60                    RTS
01996  1D5D             ;===============================================================================
01997  1D5D             ; TOGGLE SWAP MODE ON/OFF AND PROCESS SWAPPING POSITION OF TWO CHARACTERS
01998  1D5D             ;===============================================================================
01999  1D5D             
02000  1D5D             SWAPCHARPOSNS 
02001  1D5D  A2 00                 LDX #$00
02002  1D5F             
02003  1D5F             SHOWSWAPMSG 
02004  1D5F  BD 50 55              LDA DATASWAPMODE,X
02005  1D62  9D B0 04              STA MESSAGEAREAADDR+2,X
02006  1D65  E8                    INX
02007  1D66  E0 09                 CPX #$09
02008  1D68  D0 F5                 BNE SHOWSWAPMSG
02009  1D6A             
02010  1D6A  A5 A8                 LDA CHARMEMPOSLO
02011  1D6C  85 FB                 STA TEMPSAVE1
02012  1D6E  A5 A9                 LDA CHARMEMPOSHI
02013  1D70  85 FC                 STA TEMPSAVE2
02014  1D72             
02015  1D72  A0 00                 LDY #$00
02016  1D74             
02017  1D74             SWAPSAVECHARS 
02018  1D74  B1 FB                 LDA (TEMPSAVE1),Y
02019  1D76  99 8B 56              STA DATACHARSETSAVE,Y
02020  1D79  C8                    INY
02021  1D7A  D0 F8                 BNE SWAPSAVECHARS
02022  1D7C             
02023  1D7C             SWAPMODESTART 
02024  1D7C  A9 29                 LDA #<EDITGRIDHOME
02025  1D7E  85 B8                 STA WORKGRIDPOSLO
02026  1D80  A9 04                 LDA #>EDITGRIDHOME
02027  1D82  85 B9                 STA WORKGRIDPOSHI
02028  1D84             
02029  1D84  A2 00                 LDX #$00
02030  1D86             
02031  1D86             SHOWNEXTROW 
02032  1D86  8A                    TXA
02033  1D87  48                    PHA
02034  1D88  20 5D 23              JSR DRAWEDITROW
02035  1D8B  68                    PLA
02036  1D8C  AA                    TAX
02037  1D8D  E8                    INX
02038  1D8E  E0 08                 CPX #$08
02039  1D90  D0 F4                 BNE SHOWNEXTROW
02040  1D92             
02041  1D92  38                    SEC
02042  1D93  A5 A8                 LDA CHARMEMPOSLO
02043  1D95  E9 08                 SBC #$08
02044  1D97  85 A8                 STA CHARMEMPOSLO
02045  1D99  A5 A9                 LDA CHARMEMPOSHI
02046  1D9B  E9 00                 SBC #$00
02047  1D9D  85 A9                 STA CHARMEMPOSHI
02048  1D9F             
02049  1D9F             WAITSWAPKEYS 
02050  1D9F  20 9F FF              JSR KRNL_SCNKEY
02051  1DA2  20 E4 FF              JSR KRNL_GETIN
02052  1DA5  C9 00                 CMP #$00
02053  1DA7  F0 F6                 BEQ WAITSWAPKEYS
02054  1DA9             
02055  1DA9  C9 53                 CMP KEYS
02056  1DAB  F0 2B                 BEQ SWAPMODEOFF
02057  1DAD             
02058  1DAD  C9 2B                 CMP KEYPLUS
02059  1DAF  F0 0F                 BEQ SWAPNEXTCHR
02060  1DB1             
02061  1DB1  C9 2D                 CMP KEYMINUS
02062  1DB3  F0 11                 BEQ SWAPPREVCHR
02063  1DB5             
02064  1DB5  C9 87                 CMP KEYF5
02065  1DB7  F0 13                 BEQ SWAPUPALINE
02066  1DB9             
02067  1DB9  C9 88                 CMP KEYF7
02068  1DBB  F0 15                 BEQ SWAPDOWNALINE
02069  1DBD             
02070  1DBD  4C 9F 1D              JMP WAITSWAPKEYS
02071  1DC0             
02072  1DC0             SWAPNEXTCHR 
02073  1DC0  20 92 14              JSR SELECTNEXTCHR
02074  1DC3  4C 7C 1D              JMP SWAPMODESTART
02075  1DC6             
02076  1DC6             SWAPPREVCHR 
02077  1DC6  20 00 16              JSR SELECTPREVCHR
02078  1DC9  4C 7C 1D              JMP SWAPMODESTART
02079  1DCC             
02080  1DCC             SWAPUPALINE 
02081  1DCC  20 87 16              JSR MOVEUPALINE
02082  1DCF  4C 7C 1D              JMP SWAPMODESTART
02083  1DD2             
02084  1DD2             SWAPDOWNALINE 
02085  1DD2  20 00 17              JSR MOVEDOWNALINE
02086  1DD5  4C 7C 1D              JMP SWAPMODESTART
02087  1DD8             
02088  1DD8             SWAPMODEOFF 
02089  1DD8  A0 00                 LDY #$00
02090  1DDA             
02091  1DDA             LOOPSWAPCHAR 
02092  1DDA  B1 A8                 LDA (CHARMEMPOSLO),Y
02093  1DDC  91 FB                 STA (TEMPSAVE1),Y
02094  1DDE  B9 8B 56              LDA DATACHARSETSAVE,Y
02095  1DE1  91 A8                 STA (CHARMEMPOSLO),Y
02096  1DE3  C8                    INY
02097  1DE4  C0 08                 CPY #$08
02098  1DE6  D0 F2                 BNE LOOPSWAPCHAR
02099  1DE8             
02100  1DE8  A2 00                 LDX #$00
02101  1DEA  A9 20                 LDA KEYSPACE
02102  1DEC             
02103  1DEC             CLEARSWAPMSG 
02104  1DEC  9D B0 04              STA MESSAGEAREAADDR+2,X
02105  1DEF  E8                    INX
02106  1DF0  E0 09                 CPX #$09
02107  1DF2  D0 F8                 BNE CLEARSWAPMSG
02108  1DF4  60                    RTS
02109  1DF5             ;===============================================================================
02110  1DF5             ; DEVICE UTILITY FUNCTIONS
02111  1DF5             ;===============================================================================
02112  1DF5             
02113  1DF5             ;
02114  1DF5             ; UTILITY FUNCTION : DISPLAY DEVICE STATUS FOR LOAD/SAVE OPERATIONS
02115  1DF5             ;
02116  1DF5             ALIGN
02117  1E00             SHOWDEVSTATUS 
02118  1E00  A2 16                 LDX #$16
02119  1E02  A0 00                 LDY #$00
02120  1E04  18                    CLC
02121  1E05  20 F0 FF              JSR KRNL_PLOT
02122  1E08             
02123  1E08  A2 00                 LDX #$00
02124  1E0A             
02125  1E0A             PRINTSTATUS ; PRINT "STATUS: "
02126  1E0A  BD 76 55              LDA DATASTATUS,X
02127  1E0D  20 D2 FF              JSR KRNL_CHROUT
02128  1E10  E8                    INX
02129  1E11  E0 08                 CPX #$08
02130  1E13  D0 F5                 BNE PRINTSTATUS
02131  1E15             
02132  1E15  A2 00                 LDX #$00
02133  1E17             
02134  1E17             STORVARS   ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02135  1E17  B5 A8                 LDA CHARMEMPOSLO,X
02136  1E19  9D 8B 57              STA VARSSAVEAREA,X
02137  1E1C  E8                    INX
02138  1E1D  E0 16                 CPX #$16
02139  1E1F  D0 F6                 BNE STORVARS
02140  1E21             
02141  1E21  A9 00                 LDA #$00
02142  1E23  85 90                 STA DEVICESTATUS
02143  1E25  A9 08                 LDA #$08
02144  1E27  85 BA                 STA DEVICENUM
02145  1E29  20 B4 FF              JSR KRNL_TALK
02146  1E2C  A9 6F                 LDA #$6F
02147  1E2E  85 B9                 STA FILESECADDR
02148  1E30  20 96 FF              JSR KRNL_TKSA
02149  1E33             
02150  1E33             GETDEVSTATUS 
02151  1E33  A4 90                 LDY DEVICESTATUS
02152  1E35  D0 0A                 BNE DEVSTATUSDONE
02153  1E37             
02154  1E37  20 A5 FF              JSR KRNL_IECIN
02155  1E3A  20 D2 FF              JSR KRNL_CHROUT
02156  1E3D  C9 0D                 CMP #$0D
02157  1E3F  D0 F2                 BNE GETDEVSTATUS
02158  1E41             
02159  1E41             DEVSTATUSDONE 
02160  1E41  20 AB FF              JSR KRNL_UNTLK
02161  1E44             
02162  1E44             WAITKEYSPC 
02163  1E44  20 9F FF              JSR KRNL_SCNKEY
02164  1E47  20 E4 FF              JSR KRNL_GETIN
02165  1E4A  C9 20                 CMP KEYSPACE
02166  1E4C  D0 F6                 BNE WAITKEYSPC
02167  1E4E             
02168  1E4E  A2 00                 LDX #$00                ; RESTORE PROGRAM VARIABLES ($A8 - $BD)
02169  1E50             
02170  1E50             LOOP26
02171  1E50  BD 8B 57              LDA VARSSAVEAREA,X
02172  1E53  95 A8                 STA CHARMEMPOSLO,X
02173  1E55  E8                    INX
02174  1E56  E0 16                 CPX #$16
02175  1E58  D0 F6                 BNE LOOP26
02176  1E5A             
02177  1E5A  60                    RTS
02178  1E5B             
02179  1E5B             ;
02180  1E5B             ; UTILITY FUNCTION : DISPLAY DEVICE (DISC) DIRECTORY
02181  1E5B             ;
02182  1E5B             ALIGN
02183  1F00             SHOWDEVDIR 
02184  1F00  AD 06 56              LDA STORAGEDEVNUM
02185  1F03  C9 31                 CMP KEY1
02186  1F05  D0 01                 BNE BEGINDEVDIR
02187  1F07  60                    RTS
02188  1F08             
02189  1F08             BEGINDEVDIR 
02190  1F08  A2 00                 LDX #$00
02191  1F0A             
02192  1F0A             STORDEVDIRVARS ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02193  1F0A  B5 A8                 LDA CHARMEMPOSLO,X
02194  1F0C  9D 8B 57              STA VARSSAVEAREA,X
02195  1F0F  E8                    INX
02196  1F10  E0 16                 CPX #$16
02197  1F12  D0 F6                 BNE STORDEVDIRVARS
02198  1F14             
02199  1F14  20 44 E5              JSR KRNL_CLRSCRN
02200  1F17             
02201  1F17  AD 06 56              LDA STORAGEDEVNUM
02202  1F1A  C9 38                 CMP KEY8
02203  1F1C  D0 0B                 BNE LISTSECONDDISC
02204  1F1E             
02205  1F1E  A9 30                 LDA KEY0
02206  1F20  85 FC                 STA TEMPSAVE2
02207  1F22  A9 02                 LDA #$02
02208  1F24  85 FD                 STA TEMPSAVE3
02209  1F26  4C 31 1F              JMP LISTDEVDIR
02210  1F29             
02211  1F29             LISTSECONDDISC 
02212  1F29  A9 31                 LDA KEY1
02213  1F2B  85 FC                 STA TEMPSAVE2
02214  1F2D  A9 02                 LDA #$02
02215  1F2F  85 FD                 STA TEMPSAVE3
02216  1F31                        
02217  1F31             LISTDEVDIR 
02218  1F31  A9 00                 LDA #$00
02219  1F33  85 90                 STA DEVICESTATUS
02220  1F35  A9 24                 LDA #$24
02221  1F37  85 FB                 STA TEMPSAVE1
02222  1F39  A9 FB                 LDA #$FB
02223  1F3B  85 BB                 STA FILENAMELO
02224  1F3D  A9 00                 LDA #$00
02225  1F3F  85 BC                 STA FILENAMEHI
02226  1F41  A5 FD                 LDA TEMPSAVE3
02227  1F43  85 B7                 STA FILENAMLEN
02228  1F45  A9 08                 LDA #$08
02229  1F47  85 BA                 STA DEVICENUM
02230  1F49  A9 60                 LDA #$60
02231  1F4B  85 B9                 STA FILESECADDR
02232  1F4D             
02233  1F4D  20 D5 F3              JSR KRNL_PRTLOADING
02234  1F50  A5 BA                 LDA DEVICENUM
02235  1F52  20 B4 FF              JSR KRNL_TALK
02236  1F55             
02237  1F55  A5 B9                 LDA FILESECADDR
02238  1F57  20 96 FF              JSR KRNL_TKSA
02239  1F5A  A4 90                 LDY DEVICESTATUS
02240  1F5C             
02241  1F5C             GETDEVDIR
02242  1F5C  D0 3D                 BNE LISTDEVDIREND
02243  1F5E             
02244  1F5E  A0 06                 LDY #$06
02245  1F60             
02246  1F60             NEXTDEVDIR 
02247  1F60  84 FB                 STY TEMPSAVE1
02248  1F62  20 A5 FF              JSR KRNL_IECIN
02249  1F65  A6 FC                 LDX TEMPSAVE2
02250  1F67  85 FC                 STA TEMPSAVE2
02251  1F69  A4 90                 LDY DEVICESTATUS
02252  1F6B  D0 2E                 BNE LISTDEVDIREND
02253  1F6D             
02254  1F6D  A4 FB                 LDY TEMPSAVE1
02255  1F6F  88                    DEY
02256  1F70  D0 EE                 BNE NEXTDEVDIR
02257  1F72             
02258  1F72  A4 FC                 LDY TEMPSAVE2
02259  1F74  20 CD BD              JSR KRNL_LINPRT
02260  1F77  A9 20                 LDA KEYSPACE
02261  1F79  20 D2 FF              JSR KRNL_CHROUT
02262  1F7C             
02263  1F7C             READDEVDIR 
02264  1F7C  20 A5 FF              JSR KRNL_IECIN
02265  1F7F  A6 90                 LDX DEVICESTATUS
02266  1F81  D0 18                 BNE LISTDEVDIREND
02267  1F83             
02268  1F83  AA                    TAX
02269  1F84  F0 06                 BEQ ENDDEVDIRITEM
02270  1F86             
02271  1F86  20 D2 FF              JSR KRNL_CHROUT
02272  1F89  4C 7C 1F              JMP READDEVDIR
02273  1F8C             
02274  1F8C             ENDDEVDIRITEM 
02275  1F8C  A9 0D                 LDA KEYRETURN
02276  1F8E  20 D2 FF              JSR KRNL_CHROUT
02277  1F91             
02278  1F91  A5 C5                 LDA KEYBDMATRIX
02279  1F93  C9 3F                 CMP #$3F
02280  1F95  F0 04                 BEQ LISTDEVDIREND
02281  1F97  A0 04                 LDY #$04
02282  1F99  D0 C5                 BNE NEXTDEVDIR
02283  1F9B             
02284  1F9B             LISTDEVDIREND 
02285  1F9B  20 42 F6              JSR KRNL_CLOSEFILE
02286  1F9E             
02287  1F9E  A2 00                 LDX #$00
02288  1FA0             
02289  1FA0             SETDEVDIRVARS ; RESTORE PROGRAM VARIABLES ($A8 - $BD)
02290  1FA0  BD 8B 57              LDA VARSSAVEAREA,X
02291  1FA3  95 A8                 STA CHARMEMPOSLO,X
02292  1FA5  E8                    INX
02293  1FA6  E0 16                 CPX #$16
02294  1FA8  D0 F6                 BNE SETDEVDIRVARS
02295  1FAA             
02296  1FAA             WAITDEVDIRSPC 
02297  1FAA  20 9F FF              JSR KRNL_SCNKEY
02298  1FAD  20 E4 FF              JSR KRNL_GETIN
02299  1FB0  C9 20                 CMP KEYSPACE
02300  1FB2  D0 F6                 BNE WAITDEVDIRSPC
02301  1FB4             
02302  1FB4  60                    RTS
02303  1FB5             ;===============================================================================
02304  1FB5             ; LOAD CHARACTER SET FROM AN INPUT DEVICE
02305  1FB5             ;===============================================================================
02306  1FB5             
02307  1FB5             ALIGN
02308  2000             LOADFROMDEVICE 
02309  2000  78                    SEI
02310  2001  A9 31                 LDA #<IRQSVCROUTINE
02311  2003  8D 14 03              STA IRQSVCLOADDR
02312  2006  A9 EA                 LDA #>IRQSVCROUTINE
02313  2008  8D 15 03              STA IRQSVCHIADDR
02314  200B             
02315  200B  A9 79                 LDA #$79
02316  200D  8D 19 D0              STA IRQSTATUSREG
02317  2010  A9 F0                 LDA #$F0
02318  2012  8D 1A D0              STA IRQCTLREG
02319  2015  A9 1B                 LDA DEFAULTSCRNCTL
02320  2017  8D 11 D0              STA SCRNCTLREG
02321  201A  A9 01                 LDA #$01
02322  201C  8D 0E DC              STA TIMERACTLREG
02323  201F  58                    CLI
02324  2020             
02325  2020  A9 15                 LDA #$15
02326  2022  8D 18 D0              STA MEMSETUPREG
02327  2025             
02328  2025  A2 00                 LDX #$00
02329  2027             
02330  2027             SAVESCRNFORLOAD 
02331  2027  BD 00 04              LDA DISPLAYBASE,X
02332  202A  9D 00 5C              STA SCRNSAVEBASE,X
02333  202D  BD 00 05              LDA DISPLAYBASE+$100,X
02334  2030  9D 00 5D              STA SCRNSAVEBASE+$100,X
02335  2033  BD 00 06              LDA DISPLAYBASE+$200,X
02336  2036  9D 00 5E              STA SCRNSAVEBASE+$200,X
02337  2039  BD 00 07              LDA DISPLAYBASE+$300,X
02338  203C  9D 00 5F              STA SCRNSAVEBASE+$300,X
02339  203F  E8                    INX
02340  2040  D0 E5                 BNE SAVESCRNFORLOAD
02341  2042             
02342  2042             SHOWLOADSCRN 
02343  2042  A2 00                 LDX #$00
02344  2044             
02345  2044             LOOPLOADSCRN 
02346  2044  BD 00 4C              LDA DATASCRNLOAD,X
02347  2047  9D 00 04              STA DISPLAYBASE,X
02348  204A  BD 00 4D              LDA DATASCRNLOAD+$100,X
02349  204D  9D 00 05              STA DISPLAYBASE+$100,X
02350  2050  BD 00 4E              LDA DATASCRNLOAD+$200,X
02351  2053  9D 00 06              STA DISPLAYBASE+$200,X
02352  2056  BD 00 4F              LDA DATASCRNLOAD+$300,X
02353  2059  9D 00 07              STA DISPLAYBASE+$300,X
02354  205C  E8                    INX
02355  205D  D0 E5                 BNE LOOPLOADSCRN
02356  205F             
02357  205F  AD 06 56              LDA STORAGEDEVNUM
02358  2062  8D D9 4D              STA DATALOADDEVNUM
02359  2065             
02360  2065             WAITLOADKEYS 
02361  2065  20 9F FF              JSR KRNL_SCNKEY
02362  2068  20 E4 FF              JSR KRNL_GETIN
02363  206B  C9 00                 CMP #$00
02364  206D  F0 F6                 BEQ WAITLOADKEYS
02365  206F             
02366  206F  C9 4C                 CMP KEYL
02367  2071  F0 13                 BEQ DOLOAD
02368  2073             
02369  2073  C9 53                 CMP KEYS
02370  2075  F0 15                 BEQ DOLOADDEVSTATUS
02371  2077             
02372  2077  C9 44                 CMP KEYD
02373  2079  F0 17                 BEQ DONEXTLOADDEV
02374  207B             
02375  207B  C9 2A                 CMP KEYASTERISK
02376  207D  F0 19                 BEQ DOLOADDEVDIR
02377  207F             
02378  207F  C9 51                 CMP KEYQ
02379  2081  F0 1B                 BEQ LOADDEVEND
02380  2083             
02381  2083  4C 65 20              JMP WAITLOADKEYS
02382  2086             
02383  2086             DOLOAD     
02384  2086  20 F3 20              JSR LOADFROMFILE
02385  2089  4C 42 20              JMP SHOWLOADSCRN
02386  208C             
02387  208C             DOLOADDEVSTATUS 
02388  208C  20 00 1E              JSR SHOWDEVSTATUS
02389  208F  4C 42 20              JMP SHOWLOADSCRN
02390  2092             
02391  2092             DONEXTLOADDEV 
02392  2092  20 CD 20              JSR NEXTLOADDEVNUM
02393  2095  4C 42 20              JMP SHOWLOADSCRN
02394  2098             
02395  2098             DOLOADDEVDIR 
02396  2098  20 00 1F              JSR SHOWDEVDIR
02397  209B  4C 42 20              JMP SHOWLOADSCRN
02398  209E             
02399  209E             LOADDEVEND 
02400  209E  A2 00                 LDX #$00
02401  20A0             
02402  20A0             RESTOREFROMLOAD 
02403  20A0  BD 00 5C              LDA SCRNSAVEBASE,X
02404  20A3  9D 00 04              STA DISPLAYBASE,X
02405  20A6  BD 00 5D              LDA SCRNSAVEBASE+$100,X
02406  20A9  9D 00 05              STA DISPLAYBASE+$100,X
02407  20AC  BD 00 5E              LDA SCRNSAVEBASE+$200,X
02408  20AF  9D 00 06              STA DISPLAYBASE+$200,X
02409  20B2  BD 00 5F              LDA SCRNSAVEBASE+$300,X
02410  20B5  9D 00 07              STA DISPLAYBASE+$300,X
02411  20B8  A9 00                 LDA #$00
02412  20BA  9D 00 5C              STA SCRNSAVEBASE,X
02413  20BD  9D 00 5D              STA SCRNSAVEBASE+$100,X
02414  20C0  9D 00 5E              STA SCRNSAVEBASE+$200,X
02415  20C3  9D 00 5F              STA SCRNSAVEBASE+$300,X
02416  20C6  E8                    INX
02417  20C7  D0 D7                 BNE RESTOREFROMLOAD
02418  20C9                        
02419  20C9  20 DB 1A              JSR SHOWCHARCURSOR
02420  20CC  60                    RTS
02421  20CD             
02422  20CD             ;
02423  20CD             ; UTILITY FUNCTION : CYCLE LOAD DEVICE NUMBER BETWEEN 1, 8, AND 9
02424  20CD             ;
02425  20CD             NEXTLOADDEVNUM 
02426  20CD  AD D9 4D              LDA DATALOADDEVNUM
02427  20D0  C9 31                 CMP KEY1
02428  20D2  D0 09                 BNE TSTLOADDEVNUM8
02429  20D4                        
02430  20D4  A9 38                 LDA KEY8
02431  20D6  8D 06 56              STA STORAGEDEVNUM
02432  20D9  8D D9 4D              STA DATALOADDEVNUM
02433  20DC  60                    RTS
02434  20DD                        
02435  20DD             TSTLOADDEVNUM8 
02436  20DD  C9 38                 CMP KEY8
02437  20DF  D0 09                 BNE SETLOADDEVNUM1
02438  20E1             
02439  20E1  A9 39                 LDA KEY9
02440  20E3  8D D9 4D              STA DATALOADDEVNUM
02441  20E6  8D 06 56              STA STORAGEDEVNUM
02442  20E9  60                    RTS
02443  20EA             
02444  20EA             SETLOADDEVNUM1 
02445  20EA  A9 31                 LDA KEY1
02446  20EC  8D 06 56              STA STORAGEDEVNUM
02447  20EF  8D D9 4D              STA DATALOADDEVNUM
02448  20F2  60                    RTS
02449  20F3             
02450  20F3             ;
02451  20F3             ; UTILITY FUNCTION : LOAD CHARACTER SET FILE FROM DEVICE
02452  20F3             ;
02453  20F3             LOADFROMFILE 
02454  20F3  A2 00                 LDX #$00
02455  20F5             
02456  20F5             STORLOADVARS ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02457  20F5  B5 A8                 LDA CHARMEMPOSLO,X
02458  20F7  9D 8B 57              STA VARSSAVEAREA,X
02459  20FA  E8                    INX
02460  20FB  E0 16                 CPX #$16
02461  20FD  D0 F6                 BNE STORLOADVARS
02462  20FF             
02463  20FF  A2 16                 LDX #$16
02464  2101  A0 00                 LDY #$00
02465  2103  18                    CLC
02466  2104  20 F0 FF              JSR KRNL_PLOT
02467  2107             
02468  2107  A2 00                 LDX #$00
02469  2109             
02470  2109             PRTLOADNAME ; PRINT "FILENAME : "
02471  2109  BD 66 55              LDA DATAFILENAME,X
02472  210C  20 D2 FF              JSR KRNL_CHROUT
02473  210F  E8                    INX
02474  2110  E0 0B                 CPX #$0B
02475  2112  D0 F5                 BNE PRTLOADNAME
02476  2114             
02477  2114  A0 00                 LDY #$00
02478  2116             
02479  2116             LOADNAMECHAR 
02480  2116  20 CF FF              JSR KRNL_CHRIN
02481  2119  C9 0D                 CMP KEYRETURN
02482  211B  F0 08                 BEQ LOADBYNAME
02483  211D             
02484  211D  99 0B 56              STA FILENAMEINPUT,Y
02485  2120  C8                    INY
02486  2121  C0 15                 CPY #$15
02487  2123  D0 F1                 BNE LOADNAMECHAR
02488  2125             
02489  2125             LOADBYNAME 
02490  2125  A9 0D                 LDA KEYRETURN
02491  2127  20 D2 FF              JSR KRNL_CHROUT
02492  212A  8C 07 56              STY CHRINLEN
02493  212D  38                    SEC
02494  212E  AD 06 56              LDA STORAGEDEVNUM
02495  2131  E9 30                 SBC #$30
02496  2133  8A                    TXA
02497  2134  A9 01                 LDA #$01
02498  2136  A0 00                 LDY #$00
02499  2138  20 BA FF              JSR KRNL_SETLFS
02500  213B  AD 07 56              LDA CHRINLEN
02501  213E  A2 0B                 LDX #<FILENAMEINPUT
02502  2140  A0 56                 LDY #>FILENAMEINPUT
02503  2142  20 BD FF              JSR KRNL_SETNAM
02504  2145  A9 00                 LDA #$00
02505  2147  A2 00                 LDX #<CHARMEMBASE
02506  2149  A0 30                 LDY #>CHARMEMBASE
02507  214B  20 D5 FF              JSR KRNL_LOAD
02508  214E             
02509  214E             RESTOREPRGVARS 
02510  214E  A2 00                 LDX #$00
02511  2150             
02512  2150             SETLOADVARS ; RESTORE PROGRAM VARIABLES ($A8 - $BD)
02513  2150  BD 8B 57              LDA VARSSAVEAREA,X
02514  2153  95 A8                 STA CHARMEMPOSLO,X
02515  2155  E8                    INX
02516  2156  E0 16                 CPX #$16
02517  2158  D0 F6                 BNE SETLOADVARS
02518  215A             
02519  215A  20 E7 FF              JSR KRNL_CLALL
02520  215D  60                    RTS
02521  215E             ;===============================================================================
02522  215E             ; SAVE CHARACTER SET TO AN OUTPUT DEVICE
02523  215E             ;===============================================================================
02524  215E             
02525  215E             ALIGN
02526  2200             SAVETODEVICE 
02527  2200  78                    SEI
02528  2201  A9 31                 LDA #<IRQSVCROUTINE
02529  2203  8D 14 03              STA IRQSVCLOADDR
02530  2206  A9 EA                 LDA #>IRQSVCROUTINE
02531  2208  8D 15 03              STA IRQSVCHIADDR
02532  220B             
02533  220B  A9 79                 LDA #$79
02534  220D  8D 19 D0              STA IRQSTATUSREG
02535  2210  A9 F0                 LDA #$F0
02536  2212  8D 1A D0              STA IRQCTLREG
02537  2215  A9 1B                 LDA DEFAULTSCRNCTL
02538  2217  8D 11 D0              STA SCRNCTLREG
02539  221A  A9 01                 LDA #$01
02540  221C  8D 0E DC              STA TIMERACTLREG
02541  221F  58                    CLI
02542  2220             
02543  2220  A9 15                 LDA #$15
02544  2222  8D 18 D0              STA MEMSETUPREG
02545  2225             
02546  2225  A2 00                 LDX #$00
02547  2227             
02548  2227             SAVESCRNFORSAVE 
02549  2227  BD 00 04              LDA DISPLAYBASE,X
02550  222A  9D 00 5C              STA SCRNSAVEBASE,X
02551  222D  BD 00 05              LDA DISPLAYBASE+$100,X
02552  2230  9D 00 5D              STA SCRNSAVEBASE+$100,X
02553  2233  BD 00 06              LDA DISPLAYBASE+$200,X
02554  2236  9D 00 5E              STA SCRNSAVEBASE+$200,X
02555  2239  BD 00 07              LDA DISPLAYBASE+$300,X
02556  223C  9D 00 5F              STA SCRNSAVEBASE+$300,X
02557  223F  E8                    INX
02558  2240  D0 E5                 BNE SAVESCRNFORSAVE
02559  2242             
02560  2242             SHOWSAVESCRN 
02561  2242  A2 00                 LDX #$00
02562  2244             
02563  2244             LOOPSAVESCRN 
02564  2244  BD 00 50              LDA DATASCRNSAVE,X
02565  2247  9D 00 04              STA DISPLAYBASE,X
02566  224A  BD 00 51              LDA DATASCRNSAVE+$100,X
02567  224D  9D 00 05              STA DISPLAYBASE+$100,X
02568  2250  BD 00 52              LDA DATASCRNSAVE+$200,X
02569  2253  9D 00 06              STA DISPLAYBASE+$200,X
02570  2256  BD 00 53              LDA DATASCRNSAVE+$300,X
02571  2259  9D 00 07              STA DISPLAYBASE+$300,X
02572  225C  E8                    INX
02573  225D  D0 E5                 BNE LOOPSAVESCRN
02574  225F             
02575  225F  AD 06 56              LDA STORAGEDEVNUM
02576  2262  8D D9 51              STA DATASAVEDEVNUM
02577  2265             
02578  2265             WAITSAVEKEYS 
02579  2265  20 9F FF              JSR KRNL_SCNKEY
02580  2268  20 E4 FF              JSR KRNL_GETIN
02581  226B  C9 00                 CMP #$00
02582  226D  F0 F6                 BEQ WAITSAVEKEYS
02583  226F             
02584  226F  C9 53                 CMP KEYS
02585  2271  F0 13                 BEQ DOSAVE
02586  2273             
02587  2273  C9 54                 CMP KEYT
02588  2275  F0 15                 BEQ DOSAVEDEVSTATUS
02589  2277             
02590  2277  C9 44                 CMP KEYD
02591  2279  F0 17                 BEQ DONEXTSAVEDEV
02592  227B             
02593  227B  C9 2A                 CMP KEYASTERISK
02594  227D  F0 19                 BEQ DOSAVEDEVDIR
02595  227F             
02596  227F  C9 51                 CMP KEYQ
02597  2281  F0 1B                 BEQ SAVEDEVEND
02598  2283             
02599  2283  4C 65 22              JMP WAITSAVEKEYS
02600  2286             
02601  2286             DOSAVE
02602  2286  20 F3 22              JSR SAVETOFILE
02603  2289  4C 42 22              JMP SHOWSAVESCRN
02604  228C             
02605  228C             DOSAVEDEVSTATUS 
02606  228C  20 00 1E              JSR SHOWDEVSTATUS
02607  228F  4C 42 22              JMP SHOWSAVESCRN
02608  2292             
02609  2292             DONEXTSAVEDEV 
02610  2292  20 CD 22              JSR NEXTSAVEDEVNUM
02611  2295  4C 42 22              JMP SHOWSAVESCRN
02612  2298             
02613  2298             DOSAVEDEVDIR 
02614  2298  20 00 1F              JSR SHOWDEVDIR
02615  229B  4C 42 22              JMP SHOWSAVESCRN
02616  229E             
02617  229E             SAVEDEVEND 
02618  229E  A2 00                 LDX #$00
02619  22A0             
02620  22A0             RESTOREFROMSAVE 
02621  22A0  BD 00 5C              LDA SCRNSAVEBASE,X
02622  22A3  9D 00 04              STA DISPLAYBASE,X
02623  22A6  BD 00 5D              LDA SCRNSAVEBASE+$100,X
02624  22A9  9D 00 05              STA DISPLAYBASE+$100,X
02625  22AC  BD 00 5E              LDA SCRNSAVEBASE+$200,X
02626  22AF  9D 00 06              STA DISPLAYBASE+$200,X
02627  22B2  BD 00 5F              LDA SCRNSAVEBASE+$300,X
02628  22B5  9D 00 07              STA DISPLAYBASE+$300,X
02629  22B8  A9 00                 LDA #$00
02630  22BA  9D 00 5C              STA SCRNSAVEBASE,X
02631  22BD  9D 00 5D              STA SCRNSAVEBASE+$100,X
02632  22C0  9D 00 5E              STA SCRNSAVEBASE+$200,X
02633  22C3  9D 00 5F              STA SCRNSAVEBASE+$300,X
02634  22C6  E8                    INX
02635  22C7  D0 D7                 BNE RESTOREFROMSAVE
02636  22C9             
02637  22C9  20 DB 1A              JSR SHOWCHARCURSOR
02638  22CC  60                    RTS
02639  22CD             
02640  22CD             ;
02641  22CD             ; UTILITY FUNCTION : CYCLE SAVE DEVICE NUMBER BETWEEN 1, 8, AND 9
02642  22CD             ;
02643  22CD             NEXTSAVEDEVNUM 
02644  22CD  AD D9 51              LDA DATASAVEDEVNUM
02645  22D0  C9 31                 CMP KEY1
02646  22D2  D0 09                 BNE TSTSAVEDEVNUM8
02647  22D4             
02648  22D4  A9 38                 LDA KEY8
02649  22D6  8D 06 56              STA STORAGEDEVNUM
02650  22D9  8D D9 51              STA DATASAVEDEVNUM
02651  22DC  60                    RTS
02652  22DD             
02653  22DD             TSTSAVEDEVNUM8 
02654  22DD  C9 38                 CMP KEY8
02655  22DF  D0 09                 BNE SETSAVEDEVNUM1
02656  22E1             
02657  22E1  A9 39                 LDA KEY9
02658  22E3  8D D9 51              STA DATASAVEDEVNUM
02659  22E6  8D 06 56              STA STORAGEDEVNUM
02660  22E9  60                    RTS
02661  22EA             
02662  22EA             SETSAVEDEVNUM1 
02663  22EA  A9 31                 LDA KEY1
02664  22EC  8D 06 56              STA STORAGEDEVNUM
02665  22EF  8D D9 51              STA DATASAVEDEVNUM
02666  22F2  60                    RTS
02667  22F3             
02668  22F3             ;
02669  22F3             ; UTILITY FUNCTION : SAVE CHARACTER SET TO FILE ON DEVICE
02670  22F3             ;
02671  22F3             SAVETOFILE 
02672  22F3  A2 00                 LDX #$00
02673  22F5             
02674  22F5             STORSAVEVARS ; SAVE PROGRAM VARIABLES ($A8 - $BD)
02675  22F5  B5 A8                 LDA CHARMEMPOSLO,X
02676  22F7  9D 8B 57              STA VARSSAVEAREA,X
02677  22FA  E8                    INX
02678  22FB  E0 16                 CPX #$16
02679  22FD  D0 F6                 BNE STORSAVEVARS
02680  22FF             
02681  22FF  A2 16                 LDX #$16
02682  2301  A0 00                 LDY #$00
02683  2303  18                    CLC
02684  2304  20 F0 FF              JSR KRNL_PLOT
02685  2307             
02686  2307  A2 00                 LDX #$00
02687  2309             
02688  2309             PRTSAVENAME ; PRINT "FILENAME : "
02689  2309  BD 66 55              LDA DATAFILENAME,X
02690  230C  20 D2 FF              JSR KRNL_CHROUT
02691  230F  E8                    INX
02692  2310  E0 0B                 CPX #$0B
02693  2312  D0 F5                 BNE PRTSAVENAME
02694  2314             
02695  2314  A0 00                 LDY #$00
02696  2316             
02697  2316             SAVENAMECHAR 
02698  2316  20 CF FF              JSR KRNL_CHRIN
02699  2319  C9 0D                 CMP KEYRETURN
02700  231B  F0 08                 BEQ SAVEBYNAME
02701  231D             
02702  231D  99 0B 56              STA FILENAMEINPUT,Y
02703  2320  C8                    INY
02704  2321  C0 15                 CPY #$15
02705  2323  D0 F1                 BNE SAVENAMECHAR
02706  2325             
02707  2325             SAVEBYNAME 
02708  2325  A9 0D                 LDA KEYRETURN
02709  2327  20 D2 FF              JSR KRNL_CHROUT
02710  232A  8C 07 56              STY CHRINLEN
02711  232D             
02712  232D  38                    SEC
02713  232E  AD 06 56              LDA STORAGEDEVNUM
02714  2331  E9 30                 SBC #$30
02715  2333  85 BA                 STA DEVICENUM
02716  2335             
02717  2335  AD 07 56              LDA CHRINLEN
02718  2338  85 B7                 STA FILENAMLEN
02719  233A  A9 0B                 LDA #<FILENAMEINPUT
02720  233C  85 BB                 STA FILENAMELO
02721  233E  A9 56                 LDA #>FILENAMEINPUT
02722  2340  85 BC                 STA FILENAMEHI
02723  2342             
02724  2342  A9 00                 LDA #<CHARMEMBASE
02725  2344  85 C1                 STA DEVICESTARTLO
02726  2346  A9 30                 LDA #>CHARMEMBASE
02727  2348  85 C2                 STA DEVICESTARTHI
02728  234A  A9 00                 LDA #<CHARMEMBASE
02729  234C  85 AE                 STA DEVICEENDLO
02730  234E             
02731  234E  A9 40                 LDA #>CHARMEMBASE+$10
02732  2350  85 AF                 STA DEVICEENDHI
02733  2352  A9 00                 LDA #$00
02734  2354  85 B9                 STA FILESECADDR
02735  2356             
02736  2356  20 EA F5              JSR KRNL_GOSAVE
02737  2359             
02738  2359  20 4E 21              JSR RESTOREPRGVARS
02739  235C  60                    RTS
02740  235D             ;===============================================================================
02741  235D             ; DRAW PIXELS OF CHARACTER IN EDITING GRID
02742  235D             ;===============================================================================
02743  235D             
02744  235D             DRAWEDITROW 
02745  235D  A2 00                 LDX #$00
02746  235F  A1 A8                 LDA (CHARMEMPOSLO,X)
02747  2361  85 BC                 STA TEMPCHARSAVE
02748  2363  A0 80                 LDY #$80
02749  2365  98                    TYA
02750  2366             
02751  2366             SETPIXELBIT 
02752  2366  24 BC                 BIT TEMPCHARSAVE
02753  2368  F0 05                 BEQ SETCLRPIXEL
02754  236A             
02755  236A  A9 A0                 LDA KEYFULLBLOCK
02756  236C  4C 71 23              JMP SETPIXEL
02757  236F             
02758  236F             SETCLRPIXEL 
02759  236F  A9 20                 LDA KEYSPACE
02760  2371             
02761  2371             SETPIXEL
02762  2371  81 B8                 STA (WORKGRIDPOSLO,X)
02763  2373  E6 B8                 INC WORKGRIDPOSLO
02764  2375  D0 02                 BNE NEXTBITPOS
02765  2377  E6 B9                 INC WORKGRIDPOSHI
02766  2379             
02767  2379             NEXTBITPOS 
02768  2379  98                    TYA
02769  237A  4A                    LSR
02770  237B  A8                    TAY
02771  237C  D0 E8                 BNE SETPIXELBIT
02772  237E                        
02773  237E  18                    CLC
02774  237F  A5 B8                 LDA WORKGRIDPOSLO
02775  2381  69 20                 ADC #$20
02776  2383  85 B8                 STA WORKGRIDPOSLO
02777  2385  A5 B9                 LDA WORKGRIDPOSHI
02778  2387  69 00                 ADC #$00
02779  2389  85 B9                 STA WORKGRIDPOSHI
02780  238B             
02781  238B  E6 A8                 INC CHARMEMPOSLO
02782  238D  D0 02                 BNE DRAWROWEXIT
02783  238F  E6 A9                 INC CHARMEMPOSHI
02784  2391             
02785  2391             DRAWROWEXIT 
02786  2391  60                    RTS
02787  2392             ;===============================================================================
02788  2392             ; PRINT HEX VALUES
02789  2392             ;===============================================================================
02790  2392             
02791  2392             ;
02792  2392             ; UTILITY FUNCTION : PRINT HEX VALUES FOR EACH ROW IN 8*8 EDITING GRID
02793  2392             ;
02794  2392             PRINTHEXROWS 
02795  2392  A9 01                 LDA EDITGRIDHEXROW
02796  2394  8D A5 23              STA LOADROWNUM+1
02797  2397             
02798  2397  A0 00                 LDY #$00
02799  2399             
02800  2399             PRINTHEXROW 
02801  2399  A2 00                 LDX #$00
02802  239B  B1 A8                 LDA (CHARMEMPOSLO),Y
02803  239D  8D 02 56              STA HEXCHARTOPRINT
02804  23A0  98                    TYA
02805  23A1  48                    PHA
02806  23A2  8A                    TXA
02807  23A3  48                    PHA
02808  23A4             
02809  23A4             LOADROWNUM 
02810  23A4  A2 01                 LDX EDITGRIDHEXROW ; LINE NUMBER - INCREMENTED
02811  23A6  A0 0B                 LDY EDITGRIDHEXCOL ; COLUMN TO RIGHT OF 8*8 EDITING GRID
02812  23A8  18                    CLC
02813  23A9  20 F0 FF              JSR KRNL_PLOT
02814  23AC  20 C1 23              JSR PRINTHEXBYTE
02815  23AF  68                    PLA
02816  23B0  AA                    TAX
02817  23B1  68                    PLA
02818  23B2  A8                    TAY
02819  23B3  EE A5 23              INC LOADROWNUM+1
02820  23B6  C8                    INY
02821  23B7  C0 08                 CPY #$08
02822  23B9  D0 DE                 BNE PRINTHEXROW
02823  23BB             
02824  23BB  A9 01                 LDA EDITGRIDHEXROW
02825  23BD  8D A5 23              STA LOADROWNUM+1
02826  23C0  60                    RTS
02827  23C1             
02828  23C1             ;
02829  23C1             ; UTILITY FUNCTION : PRINT HEX BYTE AS 2-CHARS
02830  23C1             ;
02831  23C1             PRINTHEXBYTE 
02832  23C1  AC 02 56              LDY HEXCHARTOPRINT
02833  23C4  98                    TYA
02834  23C5  48                    PHA
02835  23C6  20 CE 23              JSR PRINTHINIBBLE
02836  23C9  68                    PLA
02837  23CA  20 D3 23              JSR PRINTLONIBBLE
02838  23CD  60                    RTS
02839  23CE             
02840  23CE             PRINTHINIBBLE 
02841  23CE  18                    CLC
02842  23CF  6A                    ROR
02843  23D0  6A                    ROR
02844  23D1  6A                    ROR
02845  23D2  6A                    ROR
02846  23D3             
02847  23D3             PRINTLONIBBLE 
02848  23D3  29 0F                 AND #$0F
02849  23D5  18                    CLC
02850  23D6  69 30                 ADC #$30         ; TURN IN TO ASCII 0-9
02851  23D8  C9 3A                 CMP #$3A
02852  23DA  90 02                 BCC PRINTHEXCHAR ; PRINT 0-9 ELSE ADD 6 FOR A-F ASCII CHARS BEFORE PRITING
02853  23DC  69 06                 ADC #$06
02854  23DE             
02855  23DE             PRINTHEXCHAR 
02856  23DE  20 D2 FF              JSR KRNL_CHROUT
02857  23E1  60                    RTS
02858  23E2             ;===============================================================================
02859  23E2             ; JOYSTICK MONITOR ROUTINES
02860  23E2             ;===============================================================================
02861  23E2             
02862  23E2             ;
02863  23E2             ; UTILITY FUNCTION : MONITOR JOYSTICK IN 8*8 EDIT GRID
02864  23E2             ;
02865  23E2             ALIGN
02866  2400             CHECKEDITSTICK 
02867  2400  CE 03 56              DEC EDITSTICKCOUNT
02868  2403  F0 01                 BEQ RXEDITSTICK         ; ONLY PROCESS JOYSTICK PORT EVERY NTH CALL
02869  2405  60                    RTS
02870  2406             
02871  2406             RXEDITSTICK 
02872  2406  A9 03                 LDA EDITSTICKDELAY      ; RESET PROCESS EVERY NTH COUNTER
02873  2408  8D 03 56              STA EDITSTICKCOUNT
02874  240B             
02875  240B  AD 00 DC              LDA JOYSTICKPORT2
02876  240E  8D 04 56              STA JOYSTICKBITS
02877  2411  29 10                 AND #$10
02878  2413  D0 01                 BNE CHECKFORUP
02879  2415  60                    RTS
02880  2416             
02881  2416             CHECKFORUP 
02882  2416  AD 04 56              LDA JOYSTICKBITS
02883  2419  29 01                 AND #$01                ; TEST JOYSTICK UP PRESSED, 0 = PRESSED
02884  241B  D0 0B                 BNE CHECKFORDOWN
02885  241D             
02886  241D  20 D1 24              JSR MOVECRSRUP
02887  2420  AD 04 56              LDA JOYSTICKBITS
02888  2423  F0 03                 BEQ CHECKFORDOWN
02889  2425             
02890  2425  4C 5B 24              JMP DONEMONSTICK
02891  2428             
02892  2428             CHECKFORDOWN 
02893  2428  AD 04 56              LDA JOYSTICKBITS
02894  242B  29 02                 AND #$02                ; TEST JOYSTICK DOWN PRESSED, 0 = PRESSED
02895  242D  D0 0B                 BNE CHECKFORLEFT
02896  242F             
02897  242F  20 14 25              JSR MOVECRSRDOWN
02898  2432  AD 05 56              LDA CURSORMOVED
02899  2435  F0 03                 BEQ CHECKFORLEFT
02900  2437             
02901  2437  4C 5B 24              JMP DONEMONSTICK
02902  243A             
02903  243A             CHECKFORLEFT 
02904  243A  AD 04 56              LDA JOYSTICKBITS
02905  243D  29 04                 AND #$04                ; TEST JOYSTICK LEFT PRESSED, 0 = PRESSED
02906  243F  D0 0B                 BNE CHECKFORRIGHT
02907  2441             
02908  2441  20 59 25              JSR MOVECRSRLEFT
02909  2444  AD 05 56              LDA CURSORMOVED
02910  2447  F0 03                 BEQ CHECKFORRIGHT
02911  2449             
02912  2449  4C 5B 24              JMP DONEMONSTICK
02913  244C             
02914  244C             CHECKFORRIGHT 
02915  244C  AD 04 56              LDA JOYSTICKBITS
02916  244F  29 08                 AND #$08                ; TEST JOYSTICK RIGHT PRESSED, 0 = PRESSED
02917  2451  D0 11                 BNE EXITMONSTICK
02918  2453             
02919  2453  20 AF 25              JSR MOVECRSRRIGHT
02920  2456  AD 05 56              LDA CURSORMOVED
02921  2459  F0 09                 BEQ EXITMONSTICK
02922  245B             
02923  245B             DONEMONSTICK 
02924  245B  8E 77 02              STX KEYBDBUFFERBASE
02925  245E  A5 C6                 LDA KEYBDBUFFERLEN
02926  2460  D0 02                 BNE EXITMONSTICK
02927  2462             
02928  2462  E6 C6                 INC KEYBDBUFFERLEN
02929  2464             
02930  2464             EXITMONSTICK 
02931  2464  60                    RTS
02932  2465             
02933  2465             ;
02934  2465             ; UTILITY FUNCTION: MONITOR JOYSTICK IN 20*6 EDIT GRID
02935  2465             ;
02936  2465             CHECKCHARSTICK 
02937  2465  CE 08 56              DEC CHARSTICKCOUNT
02938  2468  F0 01                 BEQ RXCHARSTICK                 ; ONLY PROCESS JOYSTICK PORT EVERY NTH CALL
02939  246A  60                    RTS
02940  246B                        
02941  246B             RXCHARSTICK 
02942  246B  A9 05                 LDA CHARSTICKDELAY
02943  246D  8D 08 56              STA CHARSTICKCOUNT
02944  2470             
02945  2470  AD 00 DC              LDA JOYSTICKPORT2
02946  2473  C9 7E                 CMP #$7E                        ; UP PRESS?
02947  2475  F0 0D                 BEQ CHARMOVEDUP
02948  2477                        
02949  2477  C9 7D                 CMP #$7D
02950  2479  F0 15                 BEQ CHARMOVEDDOWN               ; DOWN PRESS?
02951  247B             
02952  247B  C9 7B                 CMP #$7B
02953  247D  F0 1D                 BEQ CHARMOVEDLEFT               ; LEFT PRESS?
02954  247F             
02955  247F  C9 77                 CMP #$77
02956  2481  F0 25                 BEQ CHARMOVEDRIGHT              ; RIGHT PRESS?
02957  2483  60                    RTS
02958  2484             
02959  2484             CHARMOVEDUP 
02960  2484  AD 15 1D              LDA CHARCURSORROW+1             ; UP
02961  2487  C9 0B                 CMP CHARCRSRHOMEROW
02962  2489  D0 01                 BNE CHARMOVEUP
02963  248B  60                    RTS
02964  248C             
02965  248C             CHARMOVEUP 
02966  248C  CE 15 1D              DEC CHARCURSORROW+1             ; MOVE UP
02967  248F  60                    RTS
02968  2490             
02969  2490             CHARMOVEDDOWN 
02970  2490  AD 15 1D              LDA CHARCURSORROW+1             ; DOWN
02971  2493  C5 10                 CMP CHARCRSRHOMEROW+$5
02972  2495  D0 01                 BNE CHARMOVEDOWN
02973  2497  60                    RTS
02974  2498             
02975  2498             CHARMOVEDOWN 
02976  2498  EE 15 1D              INC CHARCURSORROW+1             ; MOVE DOWN
02977  249B  60                    RTS
02978  249C             
02979  249C             CHARMOVEDLEFT 
02980  249C  AD 17 1D              LDA CHARCURSORCOL+1             ; LEFT
02981  249F  C9 01                 CMP CHARCRSRHOMECOL
02982  24A1  D0 01                 BNE CHARMOVELEFT
02983  24A3  60                    RTS
02984  24A4             
02985  24A4             CHARMOVELEFT 
02986  24A4  CE 17 1D              DEC CHARCURSORCOL+1             ; MOVE LEFT
02987  24A7  60                    RTS
02988  24A8             
02989  24A8             CHARMOVEDRIGHT 
02990  24A8  AD 17 1D              LDA CHARCURSORCOL+1             ; RIGHT
02991  24AB  C5 1E                 CMP CHARCRSRHOMEROW+$13
02992  24AD  D0 01                 BNE CHARMOVERIGHT
02993  24AF  60                    RTS
02994  24B0             
02995  24B0             CHARMOVERIGHT 
02996  24B0  EE 17 1D              INC CHARCURSORCOL+1             ; MOVE RIGHT
02997  24B3  60                    RTS
02998  24B4             
02999  24B4             ;
03000  24B4             ; UTILITY FUNCTION : CHECK JOYSTICK FIRE BUTTON EVERY N-TH CALL
03001  24B4             ;
03002  24B4             MONITORFIREBTN 
03003  24B4  CE 09 56              DEC FIREBTNCOUNTER
03004  24B7  AD 09 56              LDA FIREBTNCOUNTER
03005  24BA  C9 00                 CMP #$00
03006  24BC  F0 01                 BEQ PROCESSFIREBTN
03007  24BE  60                    RTS
03008  24BF             
03009  24BF             PROCESSFIREBTN 
03010  24BF  A9 03                 LDA FIREBTNDELAY
03011  24C1  8D 09 56              STA FIREBTNCOUNTER
03012  24C4  20 AE 11              JSR CHECKFIREBTN
03013  24C7  60                    RTS
03014  24C8             ;===============================================================================
03015  24C8             ; MOVE EDITING GRID CURSOR ROUTINES
03016  24C8             ;===============================================================================
03017  24C8             
03018  24C8             ;
03019  24C8             ; COMMAND HANDLER : SET EDITING GRID CURSOR TO HOME POSITION
03020  24C8             ;
03021  24C8             HOMECURSOR 
03022  24C8  A9 29                 LDA #<EDITGRIDHOME
03023  24CA  85 AA                 STA EDITGRIDPOSLO
03024  24CC  A9 04                 LDA #>EDITGRIDHOME
03025  24CE  85 AB                 STA EDITGRIDPOSHI
03026  24D0  60                    RTS
03027  24D1             
03028  24D1             ;
03029  24D1             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR UP
03030  24D1             ;
03031  24D1             MOVECRSRUP 
03032  24D1  A2 00                 LDX #$00
03033  24D3  A1 AA                 LDA (EDITGRIDPOSLO,X)
03034  24D5  85 BC                 STA TEMPCHARSAVE
03035  24D7             
03036  24D7             LOOP9
03037  24D7  A5 AA                 LDA EDITGRIDPOSLO       ; CONFIRM NOT TRYING TO MOVE UP IF CURSOR ON TOP LINE
03038  24D9             
03039  24D9             DATAIDX7
03040  24D9  C9 29                 CMP #<EDITGRIDHOME
03041  24DB  D0 11                 BNE JMP14
03042  24DD             
03043  24DD  A5 AB                 LDA EDITGRIDPOSHI
03044  24DF  C9 04                 CMP #>EDITGRIDHOME
03045  24E1  D0 0B                 BNE JMP14
03046  24E3             
03047  24E3  A9 29                 LDA #<EDITGRIDHOME
03048  24E5  8D DA 24              STA DATAIDX7+1
03049  24E8                        
03050  24E8  A9 00                 LDA #$00
03051  24EA  8D 05 56              STA CURSORMOVED
03052  24ED  60                    RTS
03053  24EE             
03054  24EE             JMP14
03055  24EE  EE DA 24              INC DATAIDX7+1
03056  24F1  E8                    INX
03057  24F2  E0 08                 CPX #$08
03058  24F4  D0 E1                 BNE LOOP9
03059  24F6                        
03060  24F6  A5 BC                 LDA TEMPCHARSAVE
03061  24F8  A2 00                 LDX #$00
03062  24FA  81 AA                 STA (EDITGRIDPOSLO,X)
03063  24FC  38                    SEC
03064  24FD  A5 AA                 LDA EDITGRIDPOSLO
03065  24FF  E9 28                 SBC #$28
03066  2501  85 AA                 STA EDITGRIDPOSLO
03067  2503  A5 AB                 LDA EDITGRIDPOSHI
03068  2505  E9 00                 SBC #$00
03069  2507  85 AB                 STA EDITGRIDPOSHI
03070  2509             
03071  2509  A9 29                 LDA #<EDITGRIDHOME
03072  250B  8D DA 24              STA DATAIDX7+1
03073  250E             
03074  250E  A9 01                 LDA #$01
03075  2510  8D 05 56              STA CURSORMOVED
03076  2513  60                    RTS
03077  2514             
03078  2514             ;
03079  2514             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR DOWN
03080  2514             ;
03081  2514             MOVECRSRDOWN 
03082  2514  A2 00                 LDX #$00
03083  2516  A1 AA                 LDA (EDITGRIDPOSLO,X)
03084  2518  85 BC                 STA TEMPCHARSAVE
03085  251A             
03086  251A             LOOP10
03087  251A  A5 AA                 LDA EDITGRIDPOSLO
03088  251C             
03089  251C             DATAIDX8
03090  251C  C9 41                 CMP #$41
03091  251E  D0 11                 BNE JMP15
03092  2520             
03093  2520  A5 AB                 LDA EDITGRIDPOSHI
03094  2522  C9 05                 CMP #$05
03095  2524  D0 0B                 BNE JMP15
03096  2526             
03097  2526  A9 41                 LDA #$41
03098  2528  8D 1D 25              STA DATAIDX8+1
03099  252B             
03100  252B  A9 00                 LDA #$00
03101  252D  8D 05 56              STA CURSORMOVED
03102  2530  60                    RTS
03103  2531             
03104  2531             JMP15
03105  2531  EE 1D 25              INC DATAIDX8+1
03106  2534  E8                    INX
03107  2535  E0 08                 CPX #$08
03108  2537  D0 E1                 BNE LOOP10
03109  2539                        
03110  2539  A5 BC                 LDA TEMPCHARSAVE
03111  253B  A2 00                 LDX #$00
03112  253D  81 AA                 STA (EDITGRIDPOSLO,X)
03113  253F  18                    CLC
03114  2540  A5 AA                 LDA EDITGRIDPOSLO
03115  2542  69 28                 ADC #$28
03116  2544  85 AA                 STA EDITGRIDPOSLO
03117  2546  A5 AB                 LDA EDITGRIDPOSHI
03118  2548  69 00                 ADC #$00
03119  254A  85 AB                 STA EDITGRIDPOSHI
03120  254C  A2 11                 LDX #$11
03121  254E  A9 41                 LDA #$41
03122  2550  8D 1D 25              STA DATAIDX8+1
03123  2553             
03124  2553  A9 01                 LDA #$01
03125  2555  8D 05 56              STA CURSORMOVED
03126  2558  60                    RTS
03127  2559             
03128  2559             ;
03129  2559             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR LEFT
03130  2559             ;
03131  2559             MOVECRSRLEFT 
03132  2559  A2 00                 LDX #$00
03133  255B  A1 AA                 LDA (EDITGRIDPOSLO,X)
03134  255D  85 BC                 STA TEMPCHARSAVE
03135  255F             
03136  255F             LOOP11
03137  255F  A5 AA                 LDA EDITGRIDPOSLO
03138  2561             
03139  2561             DATAIDX13
03140  2561  C9 29                 CMP #<EDITGRIDHOME
03141  2563  D0 16                 BNE JMP16
03142  2565             
03143  2565  A5 AB                 LDA EDITGRIDPOSHI
03144  2567             
03145  2567             DATAIDX14
03146  2567  C9 04                 CMP #>EDITGRIDHOME
03147  2569  D0 10                 BNE JMP16
03148  256B             
03149  256B  A9 29                 LDA #<EDITGRIDHOME
03150  256D  8D 62 25              STA DATAIDX13+1
03151  2570  A9 04                 LDA #>EDITGRIDHOME
03152  2572  8D 68 25              STA DATAIDX14+1
03153  2575             
03154  2575  A9 00                 LDA #$00
03155  2577  8D 05 56              STA CURSORMOVED
03156  257A  60                    RTS
03157  257B             
03158  257B             JMP16
03159  257B  18                    CLC
03160  257C  AD 62 25              LDA DATAIDX13+1
03161  257F  69 28                 ADC #$28
03162  2581  8D 62 25              STA DATAIDX13+1
03163  2584  AD 68 25              LDA DATAIDX14+1
03164  2587  69 00                 ADC #$00
03165  2589  8D 68 25              STA DATAIDX14+1
03166  258C  E8                    INX
03167  258D  E0 08                 CPX #$08
03168  258F  D0 CE                 BNE LOOP11
03169  2591             
03170  2591  A5 BC                 LDA TEMPCHARSAVE
03171  2593  A2 00                 LDX #$00
03172  2595  81 AA                 STA (EDITGRIDPOSLO,X)
03173  2597  C6 AA                 DEC EDITGRIDPOSLO
03174  2599  D0 02                 BNE JMP17
03175  259B  C6 AB                 DEC EDITGRIDPOSHI
03176  259D             
03177  259D             JMP17
03178  259D  A2 9D                 LDX #$9D
03179  259F             
03180  259F  A9 01                 LDA #$01
03181  25A1  8D 05 56              STA CURSORMOVED
03182  25A4             
03183  25A4  A9 29                 LDA #<EDITGRIDHOME
03184  25A6  8D 62 25              STA DATAIDX13+1
03185  25A9  A9 04                 LDA #>EDITGRIDHOME
03186  25AB  8D 68 25              STA DATAIDX14+1
03187  25AE  60                    RTS
03188  25AF             
03189  25AF             ;
03190  25AF             ; UTILITY FUNCTION : MOVE EDITING GRID CURSOR RIGHT
03191  25AF             ;
03192  25AF             MOVECRSRRIGHT 
03193  25AF  A2 00                 LDX #$00
03194  25B1  A1 AA                 LDA (EDITGRIDPOSLO,X)
03195  25B3  85 BC                 STA TEMPCHARSAVE
03196  25B5             
03197  25B5             LOOP12
03198  25B5  A5 AA                 LDA EDITGRIDPOSLO
03199  25B7             
03200  25B7             DATAIDX15
03201  25B7  C9 30                 CMP #<EDITGRIDHOME+$7
03202  25B9  D0 16                 BNE JMP18
03203  25BB             
03204  25BB  A5 AB                 LDA EDITGRIDPOSHI
03205  25BD             
03206  25BD             DATAIDX16
03207  25BD  C9 04                 CMP #>EDITGRIDHOME
03208  25BF  D0 10                 BNE JMP18
03209  25C1             
03210  25C1  A9 30                 LDA #<EDITGRIDHOME+$7
03211  25C3  8D B8 25              STA DATAIDX15+1
03212  25C6  A9 04                 LDA #>EDITGRIDHOME
03213  25C8  8D BE 25              STA DATAIDX16+1
03214  25CB             
03215  25CB  A9 00                 LDA #$00
03216  25CD  8D 05 56              STA CURSORMOVED
03217  25D0  60                    RTS
03218  25D1             
03219  25D1             JMP18
03220  25D1  18                    CLC
03221  25D2  AD B8 25              LDA DATAIDX15+1
03222  25D5  69 28                 ADC #$28
03223  25D7  8D B8 25              STA DATAIDX15+1
03224  25DA  AD BE 25              LDA DATAIDX16+1
03225  25DD  69 00                 ADC #$00
03226  25DF  8D BE 25              STA DATAIDX16+1
03227  25E2  E8                    INX
03228  25E3  E0 08                 CPX #$08
03229  25E5  D0 CE                 BNE LOOP12
03230  25E7             
03231  25E7  A5 BC                 LDA TEMPCHARSAVE
03232  25E9  A2 00                 LDX #$00
03233  25EB  81 AA                 STA (EDITGRIDPOSLO,X)
03234  25ED  E6 AA                 INC EDITGRIDPOSLO
03235  25EF  D0 02                 BNE JMP19
03236  25F1             
03237  25F1  E6 AB                 INC EDITGRIDPOSHI
03238  25F3             
03239  25F3             JMP19
03240  25F3  A9 01                 LDA #$01
03241  25F5  8D 05 56              STA CURSORMOVED
03242  25F8  A9 30                 LDA #<EDITGRIDHOME+$7
03243  25FA  8D B8 25              STA DATAIDX15+1
03244  25FD  A9 04                 LDA #>EDITGRIDHOME
03245  25FF  8D BE 25              STA DATAIDX16+1
03246  2602  60                    RTS
03247  2603             
03248  2603             *=$4000
03249  4000             ;===============================================================================
03250  4000             ; MAIN SCREEN DATA
03251  4000             ;===============================================================================
03252  4000             
03253  4000             DATASCRNMAIN 
03254  4000  70 43 43              BYTE $70,$43,$43,$43,$43,$43,$43,$43,$43,$72,$43,$43,$43,$72,$43,$43
03255  4010  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$72,$43,$43,$43,$43,$43,$43,$43
03256  4020  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$6E,$42,$A0,$A0,$A0,$20,$20,$20,$20
03257  4030  20 42 24              BYTE $20,$42,$24,$05,$30,$42,$07,$12,$09,$04,$3A,$20,$20,$38,$2A,$38
03258  4040  42 86 8F              BYTE $42,$86,$8F,$8E,$94,$A0,$86,$81,$83,$94,$8F,$92,$99,$A0,$B2,$42
03259  4050  42 A0 20              BYTE $42,$A0,$20,$20,$20,$20,$20,$20,$20,$42,$24,$38,$30,$6B,$43,$43
03260  4060  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$71,$43,$43,$43,$43,$43,$43,$43
03261  4070  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$73,$42,$A0,$20,$20,$20,$20,$20,$20
03262  4080  20 42 24              BYTE $20,$42,$24,$38,$30,$42,$20,$0B,$05,$19,$20,$27,$08,$27,$20,$06
03263  4090  0F 12 20              BYTE $0F,$12,$20,$08,$05,$0C,$10,$20,$13,$03,$12,$05,$05,$0E,$20,$42
03264  40A0  42 A0 A0              BYTE $42,$A0,$A0,$A0,$20,$20,$20,$20,$20,$42,$24,$05,$30,$42,$95,$90
03265  40B0  90 85 92              BYTE $90,$85,$92,$20,$8F,$92,$20,$8C,$8F,$97,$85,$92,$20,$93,$85,$94
03266  40C0  20 28 95              BYTE $20,$28,$95,$AF,$8C,$29,$3F,$42,$42,$20,$20,$20,$A0,$20,$20,$E0
03267  40D0  20 42 24              BYTE $20,$42,$24,$31,$32,$42,$20,$20,$4E,$20,$20,$20,$60,$20,$20,$20
03268  40E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$42
03269  40F0  42 20 20              BYTE $42,$20,$20,$20,$A0,$A0,$20,$E0,$20,$42,$24,$31,$01,$42,$20,$4E
03270  4100  4F 77 20              BYTE $4F,$77,$20,$4F,$77,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03271  4110  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$42,$42,$20,$20,$20,$A0,$20,$A0,$A0
03272  4120  20 42 24              BYTE $20,$42,$24,$31,$36,$42,$4E,$65,$4C,$6F,$20,$4C,$6F,$20,$20,$20
03273  4130  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$42
03274  4140  42 20 20              BYTE $42,$20,$20,$20,$A0,$20,$20,$A0,$20,$42,$24,$31,$32,$42,$20,$65
03275  4150  65 20 20              BYTE $65,$20,$20,$65,$20,$03,$2E,$0E,$0F,$14,$14,$09,$0E,$07,$08,$01
03276  4160  0D 70 43              BYTE $0D,$70,$43,$43,$43,$43,$43,$7D,$6D,$43,$43,$43,$43,$43,$43,$43
03277  4170  43 71 43              BYTE $43,$71,$43,$43,$43,$71,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43
03278  4180  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$43,$7D,$00,$20,$3D,$24,$30,$30
03279  4190  70 43 43              BYTE $70,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43
03280  41A0  43 43 43              BYTE $43,$43,$43,$43,$43,$6E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03281  41B0  20 20 00              BYTE $20,$20,$00,$20,$20,$20,$20,$20,$42,$00,$01,$02,$03,$04,$05,$06
03282  41C0  07 08 09              BYTE $07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$42,$20,$20
03283  41D0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03284  41E0  42 14 15              BYTE $42,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22
03285  41F0  23 24 25              BYTE $23,$24,$25,$26,$27,$42,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03286  4200  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$42,$28,$29,$2A,$2B,$2C,$2D,$2E
03287  4210  2F 30 31              BYTE $2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$42,$20,$20
03288  4220  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03289  4230  42 3C 3D              BYTE $42,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A
03290  4240  4B 4C 4D              BYTE $4B,$4C,$4D,$4E,$4F,$42,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03291  4250  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$42,$50,$51,$52,$53,$54,$55,$56
03292  4260  57 58 59              BYTE $57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$42,$20,$20
03293  4270  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03294  4280  42 64 65              BYTE $42,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72
03295  4290  73 74 75              BYTE $73,$74,$75,$76,$77,$42,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03296  42A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$6D,$43,$43,$43,$43,$43,$43,$43
03297  42B0  43 43 43              BYTE $43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$7D,$20,$20
03298  42C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03299  42D0  20 00 01              BYTE $20,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E
03300  42E0  0F 10 11              BYTE $0F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E
03301  42F0  1F 20 21              BYTE $1F,$20,$21,$22,$23,$24,$25,$20,$20,$26,$27,$28,$29,$2A,$2B,$2C
03302  4300  2D 2E 2F              BYTE $2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C
03303  4310  3D 3E 3F              BYTE $3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$20
03304  4320  20 4C 4D              BYTE $20,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A
03305  4330  5B 5C 5D              BYTE $5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A
03306  4340  6B 6C 6D              BYTE $6B,$6C,$6D,$6E,$6F,$70,$71,$20,$20,$72,$73,$74,$75,$76,$77,$78
03307  4350  79 7A 7B              BYTE $79,$7A,$7B,$7C,$7D,$7E,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88
03308  4360  89 8A 8B              BYTE $89,$8A,$8B,$8C,$8D,$8E,$8F,$90,$91,$92,$93,$94,$95,$96,$97,$20
03309  4370  20 98 99              BYTE $20,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6
03310  4380  A7 A8 A9              BYTE $A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$B4,$B5,$B6
03311  4390  B7 B8 B9              BYTE $B7,$B8,$B9,$BA,$BB,$BC,$BD,$20,$20,$BE,$BF,$C0,$C1,$C2,$C3,$C4
03312  43A0  C5 C6 C7              BYTE $C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$D0,$D1,$D2,$D3,$D4
03313  43B0  D5 D6 D7              BYTE $D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$E0,$E1,$E2,$E3,$20
03314  43C0  20 E4 E5              BYTE $20,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F0,$F1,$F2
03315  43D0  F3 F4 F5              BYTE $F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$20,$20,$20
03316  43E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03317  43F0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03318  4400             ;===============================================================================
03319  4400             ; HELP SCREEN DATA
03320  4400             ;===============================================================================
03321  4400             
03322  4400             DATASCRNHELP1 
03323  4400  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03324  4410  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03325  4420  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03326  4430  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03327  4440  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03328  4450  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03329  4460  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03330  4470  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$13,$10,$03,$20,$20,$3A
03331  4480  10 09 18              BYTE $10,$09,$18,$05,$0C,$20,$0F,$0E,$2F,$0F,$06,$06,$20,$20,$20,$20
03332  4490  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03333  44A0  20 20 20              BYTE $20,$20,$20,$2B,$20,$20,$20,$3A,$09,$0E,$03,$12,$05,$01,$13,$05
03334  44B0  20 03 08              BYTE $20,$03,$08,$01,$12,$20,$09,$0E,$20,$07,$12,$09,$04,$20,$20,$20
03335  44C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$20,$20,$20,$3A
03336  44D0  04 05 03              BYTE $04,$05,$03,$12,$05,$01,$13,$05,$20,$03,$08,$01,$12,$20,$09,$0E
03337  44E0  20 07 12              BYTE $20,$07,$12,$09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03338  44F0  20 20 20              BYTE $20,$20,$20,$08,$20,$20,$20,$3A,$14,$08,$09,$13,$20,$13,$03,$12
03339  4500  05 05 0E              BYTE $05,$05,$0E,$21,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03340  4510  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$15,$20,$20,$20,$3A
03341  4520  13 03 12              BYTE $13,$03,$12,$0F,$0C,$0C,$20,$38,$2A,$38,$20,$07,$12,$09,$04,$20
03342  4530  15 10 20              BYTE $15,$10,$20,$0F,$0E,$05,$20,$10,$09,$18,$05,$0C,$20,$20,$20,$20
03343  4540  20 20 20              BYTE $20,$20,$20,$04,$20,$20,$20,$3A,$13,$03,$12,$0F,$0C,$0C,$20,$38
03344  4550  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$04,$0F,$17,$0E,$20,$0F,$0E,$05
03345  4560  20 10 09              BYTE $20,$10,$09,$18,$05,$0C,$20,$20,$20,$20,$20,$0C,$20,$20,$20,$3A
03346  4570  12 0F 14              BYTE $12,$0F,$14,$01,$14,$05,$20,$38,$2A,$38,$20,$07,$12,$09,$04,$20
03347  4580  0C 05 06              BYTE $0C,$05,$06,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03348  4590  20 20 20              BYTE $20,$20,$20,$12,$20,$20,$20,$3A,$12,$0F,$14,$01,$14,$05,$20,$38
03349  45A0  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$12,$09,$07,$08,$14,$20,$20,$20
03350  45B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$09,$20,$20,$20,$3A
03351  45C0  09 0E 10              BYTE $09,$0E,$10,$15,$14,$20,$06,$12,$0F,$0D,$20,$01,$20,$04,$05,$16
03352  45D0  09 03 05              BYTE $09,$03,$05,$20,$2B,$20,$04,$09,$13,$03,$20,$15,$14,$09,$0C,$13
03353  45E0  20 20 20              BYTE $20,$20,$20,$0F,$20,$20,$20,$3A,$0F,$15,$14,$10,$15,$14,$20,$14
03354  45F0  0F 20 01              BYTE $0F,$20,$01,$20,$04,$05,$16,$09,$03,$05,$20,$2B,$20,$04,$09,$13
03355  4600  03 20 15              BYTE $03,$20,$15,$14,$09,$0C,$13,$20,$20,$20,$20,$17,$20,$20,$20,$3A
03356  4610  13 17 01              BYTE $13,$17,$01,$10,$20,$17,$09,$0E,$04,$0F,$17,$20,$0D,$01,$10,$13
03357  4620  3A 38 2A              BYTE $3A,$38,$2A,$38,$20,$14,$0F,$20,$32,$30,$2A,$36,$20,$16,$2E,$16
03358  4630  20 20 20              BYTE $20,$20,$20,$03,$20,$20,$20,$20,$03,$0F,$10,$19,$20,$12,$0F,$0D
03359  4640  20 03 08              BYTE $20,$03,$08,$01,$12,$20,$14,$0F,$20,$10,$0F,$13,$20,$09,$0E,$20
03360  4650  03 08 01              BYTE $03,$08,$01,$12,$20,$13,$05,$14,$20,$20,$20,$18,$20,$20,$20,$3A
03361  4660  05 18 09              BYTE $05,$18,$09,$14,$20,$10,$12,$0F,$07,$12,$01,$0D,$20,$20,$20,$20
03362  4670  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03363  4680  20 20 20              BYTE $20,$20,$20,$2A,$20,$20,$20,$3A,$12,$0F,$14,$01,$14,$05,$20,$14
03364  4690  08 12 0F              BYTE $08,$12,$0F,$15,$07,$08,$20,$33,$36,$30,$20,$09,$0E,$20,$39,$30
03365  46A0  20 13 14              BYTE $20,$13,$14,$05,$10,$13,$20,$20,$20,$20,$20,$06,$31,$20,$20,$3A
03366  46B0  12 05 16              BYTE $12,$05,$16,$05,$12,$13,$05,$20,$10,$09,$18,$05,$0C,$13,$20,$09
03367  46C0  0E 20 07              BYTE $0E,$20,$07,$12,$09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03368  46D0  20 20 20              BYTE $20,$20,$20,$06,$33,$20,$20,$3A,$03,$0C,$05,$01,$12,$20,$07,$12
03369  46E0  09 04 20              BYTE $09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03370  46F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$06,$35,$20,$20,$3A
03371  4700  0D 0F 16              BYTE $0D,$0F,$16,$05,$20,$03,$15,$12,$13,$0F,$12,$20,$15,$10,$20,$0F
03372  4710  0E 05 20              BYTE $0E,$05,$20,$0C,$09,$0E,$05,$20,$09,$0E,$20,$13,$05,$14,$20,$20
03373  4720  20 20 20              BYTE $20,$20,$20,$06,$37,$20,$20,$3A,$0D,$0F,$16,$05,$20,$03,$15,$12
03374  4730  13 0F 12              BYTE $13,$0F,$12,$20,$04,$0F,$17,$0E,$20,$0F,$0E,$05,$20,$0C,$09,$0E
03375  4740  05 20 09              BYTE $05,$20,$09,$0E,$20,$13,$05,$20,$20,$20,$08,$0F,$0D,$05,$20,$3A
03376  4750  10 0C 01              BYTE $10,$0C,$01,$03,$05,$20,$03,$15,$12,$0F,$13,$12,$20,$09,$0E,$20
03377  4760  38 2A 38              BYTE $38,$2A,$38,$20,$14,$0F,$20,$08,$0F,$0D,$05,$20,$10,$0F,$13,$2E
03378  4770  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03379  4780  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03380  4790  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03381  47A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03382  47B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03383  47C0  20 20 20              BYTE $20,$20,$20,$2A,$2A,$20,$90,$92,$85,$93,$93,$A0,$93,$90,$81,$83
03384  47D0  85 A0 82              BYTE $85,$A0,$82,$81,$92,$A0,$94,$8F,$A0,$83,$8F,$8E,$94,$89,$8E,$95
03385  47E0  85 20 2A              BYTE $85,$20,$2A,$2A,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03386  47F0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03387  4800             
03388  4800             DATASCRNHELP2 
03389  4800  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03390  4810  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03391  4820  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03392  4830  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03393  4840  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03394  4850  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03395  4860  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03396  4870  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03397  4880  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03398  4890  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03399  48A0  20 20 3E              BYTE $20,$20,$3E,$20,$20,$3A,$0D,$09,$12,$12,$0F,$12,$20,$38,$2A,$38
03400  48B0  20 09 0D              BYTE $20,$09,$0D,$01,$07,$05,$20,$0C,$05,$06,$14,$2F,$12,$09,$07,$08
03401  48C0  14 20 20              BYTE $14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$3C,$20,$20,$3A,$0D,$09
03402  48D0  12 12 0F              BYTE $12,$12,$0F,$12,$20,$38,$2A,$38,$20,$09,$0D,$01,$07,$05,$20,$15
03403  48E0  10 2F 04              BYTE $10,$2F,$04,$0F,$17,$0E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03404  48F0  20 20 1E              BYTE $20,$20,$1E,$20,$20,$3A,$03,$0C,$05,$01,$12,$20,$32,$30,$2A,$36
03405  4900  20 07 12              BYTE $20,$07,$12,$09,$04,$20,$17,$09,$14,$08,$20,$13,$10,$01,$03,$05
03406  4910  13 20 20              BYTE $13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$3D,$20,$20,$3A,$06,$09
03407  4920  0C 0C 20              BYTE $0C,$0C,$20,$32,$30,$2A,$36,$20,$07,$12,$09,$04,$20,$17,$09,$14
03408  4930  08 20 03              BYTE $08,$20,$03,$15,$12,$12,$05,$0E,$14,$20,$03,$08,$01,$12,$2E,$20
03409  4940  20 20 13              BYTE $20,$20,$13,$20,$20,$3A,$13,$17,$01,$10,$20,$14,$17,$0F,$20,$03
03410  4950  08 01 12              BYTE $08,$01,$12,$13,$20,$06,$12,$0F,$0D,$20,$0F,$0E,$05,$20,$14,$0F
03411  4960  20 0F 14              BYTE $20,$0F,$14,$08,$05,$12,$2E,$20,$20,$20,$1C,$20,$20,$3A,$14,$12
03412  4970  01 0E 13              BYTE $01,$0E,$13,$06,$05,$12,$20,$0F,$0E,$20,$03,$08,$01,$12,$20,$14
03413  4980  0F 20 01              BYTE $0F,$20,$01,$0E,$0F,$14,$08,$05,$12,$20,$10,$0F,$13,$2E,$20,$20
03414  4990  20 12 15              BYTE $20,$12,$15,$0E,$2F,$3A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03415  49A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03416  49B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$13,$14,$0F,$10,$3A,$01,$02
03417  49C0  0F 12 14              BYTE $0F,$12,$14,$20,$03,$15,$12,$12,$05,$0E,$14,$20,$04,$09,$13,$03
03418  49D0  20 03 0F              BYTE $20,$03,$0F,$0D,$0D,$01,$0E,$04,$20,$20,$20,$20,$20,$20,$20,$20
03419  49E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03420  49F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03421  4A00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03422  4A10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03423  4A20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03424  4A30  20 20 20              BYTE $20,$20,$20,$15,$13,$05,$20,$0A,$0F,$19,$13,$14,$09,$03,$0B,$20
03425  4A40  09 0E 20              BYTE $09,$0E,$20,$10,$0F,$12,$14,$20,$32,$20,$14,$0F,$20,$03,$0F,$0E
03426  4A50  14 12 0F              BYTE $14,$12,$0F,$0C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03427  4A60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03428  4A70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03429  4A80  20 20 20              BYTE $20,$20,$20,$20,$20,$03,$15,$12,$13,$0F,$12,$20,$09,$0E,$20,$38
03430  4A90  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$01,$0E,$04,$20,$32,$30,$2A,$36
03431  4AA0  20 07 12              BYTE $20,$07,$12,$09,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03432  4AB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03433  4AC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03434  4AD0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$10,$12,$05,$13,$13,$20,$27,$06,$09
03435  4AE0  12 05 27              BYTE $12,$05,$27,$20,$0F,$12,$20,$13,$10,$01,$03,$05,$20,$14,$0F,$20
03436  4AF0  14 15 12              BYTE $14,$15,$12,$0E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03437  4B00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03438  4B10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03439  4B20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$01,$20,$10,$09,$18,$05,$0C
03440  4B30  20 0F 0E              BYTE $20,$0F,$0E,$2F,$0F,$06,$06,$20,$09,$0E,$20,$14,$08,$05,$20,$38
03441  4B40  2A 38 20              BYTE $2A,$38,$20,$07,$12,$09,$04,$20,$84,$8F,$8E,$A7,$94,$A0,$93,$85
03442  4B50  8C 85 83              BYTE $8C,$85,$83,$94,$A0,$81,$A0,$84,$89,$93,$83,$A0,$83,$8F,$8D,$8D
03443  4B60  81 8E 84              BYTE $81,$8E,$84,$A0,$89,$86,$A0,$99,$8F,$95,$A0,$88,$81,$96,$85,$A0
03444  4B70  8E 8F 94              BYTE $8E,$8F,$94,$A0,$87,$8F,$94,$A0,$81,$A0,$84,$89,$93,$83,$A0,$84
03445  4B80  92 89 96              BYTE $92,$89,$96,$85,$A0,$A8,$83,$92,$81,$93,$88,$A0,$94,$88,$85,$A0
03446  4B90  93 99 93              BYTE $93,$99,$93,$94,$85,$8D,$A1,$A9,$20,$20,$20,$20,$20,$20,$20,$20
03447  4BA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03448  4BB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03449  4BC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$2A,$2A,$20,$10,$12,$05,$13,$13,$20,$93
03450  4BD0  90 81 83              BYTE $90,$81,$83,$85,$20,$14,$0F,$20,$12,$05,$14,$15,$12,$0E,$20,$2A
03451  4BE0  2A 20 20              BYTE $2A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03452  4BF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03453  4C00             ;===============================================================================
03454  4C00             ; LOAD FROM FILE SCREEN DATA
03455  4C00             ;===============================================================================
03456  4C00             
03457  4C00             DATASCRNLOAD 
03458  4C00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03459  4C10  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03460  4C20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03461  4C30  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03462  4C40  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03463  4C50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03464  4C60  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03465  4C70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03466  4C80  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03467  4C90  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03468  4CA0  20 04 01              BYTE $20,$04,$01,$14,$01,$20,$09,$0E,$10,$15,$14,$20,$20,$20,$20,$20
03469  4CB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03470  4CC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$77,$77,$77,$77,$77,$77,$77
03471  4CD0  77 77 77              BYTE $77,$77,$77,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03472  4CE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03473  4CF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03474  4D00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03475  4D10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03476  4D20  20 20 0C              BYTE $20,$20,$0C,$2E,$2E,$2E,$0C,$0F,$01,$04,$20,$01,$20,$03,$08,$01
03477  4D30  12 01 03              BYTE $12,$01,$03,$14,$05,$12,$20,$13,$05,$14,$20,$20,$20,$20,$20,$20
03478  4D40  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03479  4D50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03480  4D60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03481  4D70  20 20 13              BYTE $20,$20,$13,$2E,$2E,$2E,$04,$09,$13,$03,$20,$13,$14,$01,$14,$15
03482  4D80  13 20 20              BYTE $13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03483  4D90  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03484  4DA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03485  4DB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03486  4DC0  20 20 04              BYTE $20,$20,$04,$2E,$2E,$2E,$03,$08,$01,$0E,$07,$05,$20,$04,$05,$16
03487  4DD0  09 03 05              BYTE $09,$03,$05,$20,$28,$04,$05,$16,$3D
03488  4DD9             DATALOADDEVNUM 
03489  4DD9  38                    BYTE $38
03490  4DDA  29 20 20              BYTE $29,$20,$20,$20,$20,$20
03491  4DE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03492  4DF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03493  4E00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03494  4E10  20 20 2A              BYTE $20,$20,$2A,$2E,$2E,$2E,$04,$09,$13,$03,$20,$04,$09,$12,$05,$03
03495  4E20  14 0F 12              BYTE $14,$0F,$12,$19,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03496  4E30  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03497  4E40  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03498  4E50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03499  4E60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03500  4E70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03501  4E80  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$11,$2E,$2E,$2E,$07,$0F
03502  4E90  14 0F 20              BYTE $14,$0F,$20,$14,$08,$05,$20,$06,$01,$03,$14,$0F,$12,$19,$20,$20
03503  4EA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03504  4EB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03505  4EC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03506  4ED0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03507  4EE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03508  4EF0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03509  4F00  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03510  4F10  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03511  4F20  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0D,$01,$0B,$05,$20,$19
03512  4F30  0F 15 12              BYTE $0F,$15,$12,$20,$03,$08,$0F,$09,$03,$05,$21,$21,$20,$20,$20,$20
03513  4F40  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03514  4F50  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03515  4F60  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03516  4F70  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03517  4F80  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03518  4F90  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03519  4FA0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03520  4FB0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03521  4FC0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03522  4FD0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03523  4FE0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03524  4FF0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03525  5000             ;===============================================================================
03526  5000             ; SAVE FILE SCREEN DATA
03527  5000             ;===============================================================================
03528  5000             
03529  5000             DATASCRNSAVE 
03530  5000  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03531  5010  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03532  5020  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03533  5030  20 20 3E              BYTE $20,$20,$3E,$3E,$3E,$20,$06,$0F,$0E,$14,$20,$06,$01,$03,$14,$0F
03534  5040  12 19 20              BYTE $12,$19,$20,$3C,$3C,$3C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03535  5050  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
03536  5060  2D 2D 2D              BYTE $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20
03537  5070  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03538  5080  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03539  5090  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03540  50A0  20 04 01              BYTE $20,$04,$01,$14,$01,$20,$0F,$15,$14,$10,$15,$14,$20,$20,$20,$20
03541  50B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03542  50C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$77,$77,$77,$77,$77,$77,$77
03543  50D0  77 77 77              BYTE $77,$77,$77,$77,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03544  50E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03545  50F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03546  5100  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03547  5110  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03548  5120  20 20 13              BYTE $20,$20,$13,$2E,$2E,$2E,$13,$01,$16,$05,$20,$01,$20,$03,$08,$01
03549  5130  12 20 13              BYTE $12,$20,$13,$05,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03550  5140  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03551  5150  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03552  5160  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03553  5170  20 20 14              BYTE $20,$20,$14,$2E,$2E,$2E,$04,$09,$13,$03,$20,$13,$14,$01,$14,$15
03554  5180  13 20 20              BYTE $13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03555  5190  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03556  51A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03557  51B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03558  51C0  20 20 04              BYTE $20,$20,$04,$2E,$2E,$2E,$03,$08,$01,$0E,$07,$05,$20,$04,$05,$16
03559  51D0  09 03 05              BYTE $09,$03,$05,$20,$28,$04,$05,$16,$3D
03560  51D9             DATASAVEDEVNUM 
03561  51D9  38                    BYTE $38
03562  51DA  29 20 20              BYTE $29,$20,$20,$20,$20,$20
03563  51E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03564  51F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03565  5200  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03566  5210  20 20 2A              BYTE $20,$20,$2A,$2E,$2E,$2E,$04,$09,$13,$03,$20,$04,$09,$12,$05,$03
03567  5220  14 0F 12              BYTE $14,$0F,$12,$19,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03568  5230  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03569  5240  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03570  5250  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03571  5260  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03572  5270  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03573  5280  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$11,$2E,$2E,$2E,$07,$0F
03574  5290  14 0F 20              BYTE $14,$0F,$20,$14,$08,$05,$20,$06,$01,$03,$14,$0F,$12,$19,$20,$20
03575  52A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03576  52B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03577  52C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03578  52D0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03579  52E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03580  52F0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03581  5300  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03582  5310  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03583  5320  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0D,$01,$0B,$05,$20,$19
03584  5330  0F 15 12              BYTE $0F,$15,$12,$20,$03,$08,$0F,$09,$03,$05,$21,$21,$20,$20,$20,$20
03585  5340  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03586  5350  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03587  5360  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03588  5370  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03589  5380  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03590  5390  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03591  53A0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03592  53B0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03593  53C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03594  53D0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03595  53E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
03596  53F0  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03597  5400             
03598  5400             *=$5400
03599  5400             ;===============================================================================
03600  5400             ; STRINGS FOR DISPLAY
03601  5400             ;===============================================================================
03602  5400             
03603  5400             DATACHARGRID 
03604  5400  DF DF DF              BYTE $DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF
03605  5410  DF DF DF              BYTE $DF,$DF,$DF,$DF,$DF,$DF,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03606  5420  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$00,$01,$02,$03,$04,$05,$06
03607  5430  07 08 09              BYTE $07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$DF,$60,$20
03608  5440  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03609  5450  DF 14 15              BYTE $DF,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22
03610  5460  23 24 25              BYTE $23,$24,$25,$26,$27,$DF,$20,$20,$20,$60,$20,$20,$20,$20,$20,$20
03611  5470  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$28,$29,$2A,$2B,$2C,$2D,$2E
03612  5480  2F 30 31              BYTE $2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$DF,$60,$20
03613  5490  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03614  54A0  DF 3C 3D              BYTE $DF,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A
03615  54B0  4B 4C 4D              BYTE $4B,$4C,$4D,$4E,$4F,$DF,$60,$20,$20,$20,$20,$20,$20,$20,$20,$20
03616  54C0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$50,$51,$52,$53,$54,$55,$56
03617  54D0  57 58 59              BYTE $57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$DF,$20,$20
03618  54E0  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03619  54F0  DF 64 65              BYTE $DF,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72
03620  5500  73 74 75              BYTE $73,$74,$75,$76,$77,$DF,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03621  5510  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF
03622  5520  DF DF DF              BYTE $DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$DF,$20,$20
03623  5530  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
03624  5540  20 00 00              BYTE $20,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03625  5550             
03626  5550             DATASWAPMODE 
03627  5550  13 17 01              BYTE $13,$17,$01,$10,$20,$0D,$0F,$04,$05
03628  5559             
03629  5559             DATATRFRMODE 
03630  5559  14 12 01              BYTE $14,$12,$01,$0E,$13,$06,$05,$12,$20,$0D,$0F,$04,$05
03631  5566             
03632  5566             DATAFILENAME 
03633  5566  46 49 4C              BYTE $46,$49,$4C,$45,$4E,$41,$4D,$45,$20,$3A,$20,$00,$00,$00,$00,$00
03634  5576             
03635  5576             DATASTATUS 
03636  5576  53 54 41              BYTE $53,$54,$41,$54,$55,$53,$3A,$20,$00,$00,$00,$00,$00,$00,$00,$00
03637  5586             
03638  5586             *=$5600
03639  5600             ;===============================================================================
03640  5600             ; PROGRAM VARIABLES
03641  5600             ;===============================================================================
03642  5600             
03643  5600             CURSORTIMER 
03644  5600  10                    BYTE CURSORDELAY
03645  5601             
03646  5601             EDITINGCHAR 
03647  5601  00                    BYTE $00
03648  5602             
03649  5602             HEXCHARTOPRINT 
03650  5602  00                    BYTE $00
03651  5603             
03652  5603             EDITSTICKCOUNT 
03653  5603  03                    BYTE $03
03654  5604             
03655  5604             JOYSTICKBITS 
03656  5604  7F                    BYTE $7F
03657  5605             
03658  5605             CURSORMOVED 
03659  5605  01                    BYTE $01
03660  5606             
03661  5606             STORAGEDEVNUM 
03662  5606  38                    BYTE $38
03663  5607             
03664  5607             CHRINLEN
03665  5607  0A                    BYTE $0A
03666  5608             
03667  5608             CHARSTICKCOUNT 
03668  5608  05                    BYTE $05
03669  5609             
03670  5609             FIREBTNCOUNTER 
03671  5609  02                    BYTE $02
03672  560A             
03673  560A             CHARSCROLLSAVE 
03674  560A  87                    BYTE $87
03675  560B             
03676  560B             FILENAMEINPUT 
03677  560B  53 41 53              BYTE $53,$41,$53,$20,$43,$48,$41,$52,$53,$21,$53,$00,$00,$00,$00,$00
03678  561B  00 00 00              BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03679  562B             
03680  562B             WORKINGCHAR 
03681  562B  A0 A0 A0              BYTE $A0,$A0,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0
03682  563B  A0 20 20              BYTE $A0,$20,$20,$20,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20
03683  564B  20 20 20              BYTE $20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$A0,$A0
03684  565B  A0 A0 20              BYTE $A0,$A0,$20,$A0,$20,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$20,$A0,$A0
03685  566B             
03686  566B             EDITGRIDTOPROWFWDLO 
03687  566B  29                    BYTE <EDITGRIDHOME
03688  566C  2A                    BYTE <EDITGRIDHOME+$1
03689  566D  2B                    BYTE <EDITGRIDHOME+$2
03690  566E  2C                    BYTE <EDITGRIDHOME+$3
03691  566F  2D                    BYTE <EDITGRIDHOME+$4
03692  5670  2E                    BYTE <EDITGRIDHOME+$5
03693  5671  2F                    BYTE <EDITGRIDHOME+$6
03694  5672  30                    BYTE <EDITGRIDHOME+$7
03695  5673             
03696  5673             EDITGRIDTOPROWREVLO 
03697  5673  30                    BYTE <EDITGRIDHOME+$7
03698  5674  2F                    BYTE <EDITGRIDHOME+$6
03699  5675  2E                    BYTE <EDITGRIDHOME+$5
03700  5676  2D                    BYTE <EDITGRIDHOME+$4
03701  5677  2C                    BYTE <EDITGRIDHOME+$3
03702  5678  2B                    BYTE <EDITGRIDHOME+$2
03703  5679  2A                    BYTE <EDITGRIDHOME+$1
03704  567A  29                    BYTE <EDITGRIDHOME
03705  567B             
03706  567B             WORKINGCHARROWSLO 
03707  567B  2B                    BYTE <WORKINGCHAR
03708  567C  33                    BYTE <WORKINGCHAR+$8
03709  567D  3B                    BYTE <WORKINGCHAR+$10
03710  567E  43                    BYTE <WORKINGCHAR+$18
03711  567F  4B                    BYTE <WORKINGCHAR+$20
03712  5680  53                    BYTE <WORKINGCHAR+$28
03713  5681  5B                    BYTE <WORKINGCHAR+$30
03714  5682  63                    BYTE <WORKINGCHAR+$38
03715  5683             
03716  5683             WORKINGCHARTOPROWREVLO 
03717  5683  32                    BYTE <WORKINGCHAR+$7
03718  5684  31                    BYTE <WORKINGCHAR+$6
03719  5685  30                    BYTE <WORKINGCHAR+$5
03720  5686  2F                    BYTE <WORKINGCHAR+$4
03721  5687  2E                    BYTE <WORKINGCHAR+$3
03722  5688  2D                    BYTE <WORKINGCHAR+$2
03723  5689  2C                    BYTE <WORKINGCHAR+$1
03724  568A  2B                    BYTE <WORKINGCHAR
03725  568B             
03726  568B             DATACHARSETSAVE 
03727  568B  00 00 7E              BYTE $00,$00,$7E,$66,$7E,$66,$66,$00,$00,$00,$7E,$06,$7E,$66,$7E,$00
03728  569B  00 00 7E              BYTE $00,$00,$7E,$00,$60,$70,$7E,$00,$00,$00,$7E,$06,$66,$66,$7E,$00
03729  56AB  00 00 7E              BYTE $00,$00,$7E,$00,$7C,$60,$7E,$00,$00,$00,$7E,$00,$7C,$60,$60,$00
03730  56BB  00 00 7E              BYTE $00,$00,$7E,$60,$6E,$66,$7E,$00,$00,$00,$66,$66,$7E,$66,$66,$00
03731  56CB  00 00 18              BYTE $00,$00,$18,$18,$18,$18,$18,$00,$00,$00,$7E,$06,$06,$66,$7E,$00
03732  56DB  00 00 66              BYTE $00,$00,$66,$66,$6C,$66,$66,$00,$00,$00,$60,$60,$60,$70,$7E,$00
03733  56EB  00 00 FF              BYTE $00,$00,$FF,$DB,$DB,$DB,$DB,$00,$00,$00,$7E,$66,$66,$66,$66,$00
03734  56FB  00 00 7E              BYTE $00,$00,$7E,$66,$66,$66,$7E,$00,$00,$00,$7E,$06,$7E,$60,$60,$00
03735  570B  00 00 7E              BYTE $00,$00,$7E,$66,$66,$6E,$7E,$00,$00,$00,$7E,$06,$7C,$66,$66,$00
03736  571B  00 00 7E              BYTE $00,$00,$7E,$60,$7E,$06,$7E,$00,$00,$00,$7E,$18,$18,$18,$18,$00
03737  572B  00 00 66              BYTE $00,$00,$66,$66,$66,$66,$7E,$00,$00,$00,$66,$66,$66,$3C,$18,$00
03738  573B  00 00 DB              BYTE $00,$00,$DB,$DB,$DB,$DB,$FF,$00,$00,$00,$66,$66,$3C,$66,$66,$00
03739  574B  00 00 66              BYTE $00,$00,$66,$66,$3C,$18,$18,$00,$00,$00,$7E,$0C,$18,$30,$7E,$00
03740  575B  00 3C 30              BYTE $00,$3C,$30,$30,$30,$30,$30,$3C,$00,$00,$00,$3C,$30,$3C,$00,$00
03741  576B  00 3C 0C              BYTE $00,$3C,$0C,$0C,$0C,$0C,$0C,$3C,$00,$18,$3C,$7E,$18,$18,$18,$00
03742  577B  00 10 30              BYTE $00,$10,$30,$7E,$7E,$30,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
03743  578B             
03744  578B             VARSSAVEAREA 
03745  578B  00 30 29              BYTE $00,$30,$29,$04,$70,$02,$00,$00,$00,$00,$3C,$03,$00,$00,$00,$00
03746  579B  69 05 D1              BYTE $69,$05,$D1,$06,$3C,$D2,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
03747  57AB             
03748  57AB             *=$5800
03749  5800             ;===============================================================================
03750  5800             ; COMMAND MAPS DATA
03751  5800             ;===============================================================================
03752  5800             
03753  5800             SWAPCMDS
03754  5800  13 93 11              BYTE $13,$93,$11,$1D,$91,$9D,$8D,$8E,$94,$D4
03755  580A             
03756  580A             MAINCOMMANDS 
03757  580A  20 2B 2D              BYTE $20,$2B,$2D,$48,$55,$44,$4C,$52,$49,$4F,$57,$43,$58,$2A,$85,$86
03758  581A  87 88 13              BYTE $87,$88,$13,$2E,$2C,$5E,$3D,$53,$5C
03759  5823             
03760  5823             CMDLOADDRS 
03761  5823  B6                    BYTE <PIXELINVERT
03762  5824  92                    BYTE <SELECTNEXTCHR
03763  5825  00                    BYTE <SELECTPREVCHR
03764  5826  FD                    BYTE <SHOWHELP
03765  5827  51                    BYTE <SCROLLCHARUP
03766  5828  9B                    BYTE <SCROLLCHARDOWN
03767  5829  00                    BYTE <SCROLLCHARLEFT
03768  582A  00                    BYTE <SCROLLCHARRIGHT
03769  582B  00                    BYTE <LOADFROMDEVICE
03770  582C  00                    BYTE <SAVETODEVICE
03771  582D  00                    BYTE <SWAPWINDOWMAPS
03772  582E  C3                    BYTE <COPYROMCHAR
03773  582F  8B                    BYTE <EXITPROGRAM
03774  5830  00                    BYTE <ROTATECHAR90
03775  5831  85                    BYTE <INVERTCHAR
03776  5832  6D                    BYTE <CLEARGRID88
03777  5833  87                    BYTE <MOVEUPALINE
03778  5834  00                    BYTE <MOVEDOWNALINE
03779  5835  C8                    BYTE <HOMECURSOR
03780  5836  00                    BYTE <MIRRORCHARHORZ
03781  5837  7D                    BYTE <MIRRORCHARVERT
03782  5838  2F                    BYTE <CLEARGRID206
03783  5839  34                    BYTE <FILLGRID206
03784  583A  5D                    BYTE <SWAPCHARPOSNS
03785  583B  74                    BYTE <TRFRMODETOGGLE
03786  583C             
03787  583C             CMDHIADDRS 
03788  583C  11                    BYTE >PIXELINVERT
03789  583D  14                    BYTE >SELECTNEXTCHR
03790  583E  16                    BYTE >SELECTPREVCHR
03791  583F  19                    BYTE >SHOWHELP
03792  5840  12                    BYTE >SCROLLCHARUP
03793  5841  12                    BYTE >SCROLLCHARDOWN
03794  5842  13                    BYTE >SCROLLCHARLEFT
03795  5843  14                    BYTE >SCROLLCHARRIGHT
03796  5844  20                    BYTE >LOADFROMDEVICE
03797  5845  22                    BYTE >SAVETODEVICE
03798  5846  1D                    BYTE >SWAPWINDOWMAPS
03799  5847  1B                    BYTE >COPYROMCHAR
03800  5848  11                    BYTE >EXITPROGRAM
03801  5849  19                    BYTE >ROTATECHAR90
03802  584A  1B                    BYTE >INVERTCHAR
03803  584B  17                    BYTE >CLEARGRID88
03804  584C  16                    BYTE >MOVEUPALINE
03805  584D  17                    BYTE >MOVEDOWNALINE
03806  584E  24                    BYTE >HOMECURSOR
03807  584F  18                    BYTE >MIRRORCHARHORZ
03808  5850  18                    BYTE >MIRRORCHARVERT
03809  5851  12                    BYTE >CLEARGRID206
03810  5852  12                    BYTE >FILLGRID206
03811  5853  1D                    BYTE >SWAPCHARPOSNS
03812  5854  19                    BYTE >TRFRMODETOGGLE
03813  5855             
