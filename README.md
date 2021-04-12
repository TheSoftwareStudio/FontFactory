# FontFactory
6510 assembler project for Font Factory '89

I wrote the Font Factory in 1989 and it was published in the Volume 2, Number 5 of the Commodore Disk User magazine.\
The original magazine images are in the docs folder.\
Enjoy!

## Build
Use the CBM Prg Studio to compile the project to bin\FontFactory.prg.\
Use VICE, or another CBM 64 Emulator, to load the FontFactory.prg.\
SYS 4096 to run.\
After initially selecting to edit upper case 'U' or lower case 'L' characters, press 'H' for help.

## Design
Display screen from $0400 to $07FF\
Program Code from $1000 to $2FFF\
Font set design from $3000 to $3FFF\
Program screen data from $4000 to $53FF\
Program string data from $5400 to $55FF\
Program vars from $5600 to $57FF\
Program command map $5800 to $58FF\
Program screen save area from $5C00 - $5FFF\
