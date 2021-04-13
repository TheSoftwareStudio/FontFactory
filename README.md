# Font Factory
6510 assembler project for Font Factory '89

I developed the Font Factory in 1989 as 'bare metal' 6510 code using a C-64 cartridge. This is a reverse-engineered assembler version of the code published in Volume 2, Number 5 of the Commodore Disk User magazine. The original magazine images are in the doc folder. Enjoy!

## Build
Use the CBM Prg Studio to compile the project to bin\FontFactory.prg.\
Use VICE, or another CBM 64 Emulator, to load FontFactory.prg.\
SYS 4096 to run.\
Answer 'U' or 'L' to edit upper or lower case characters. Press 'H' for help screens.

## Design
Display screen from $0400 to $07FF\
Program Code from $1000 to $2FFF\
Font set design from $3000 to $3FFF\
Program screen data from $4000 to $53FF\
Program string data from $5400 to $55FF\
Program vars from $5600 to $57FF\
Program command map $5800 to $58FF\
Program screen save area from $5C00 - $5FFF
