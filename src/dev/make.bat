@echo off

set game=lala_beta

echo Compilando script
cd ..\script
msc %game.spt msc.h 25 > nul
copy *.h ..\dev > nul
cd ..\dev

echo Convirtiendo mapa
..\utils\mapcnv.exe ..\map\mapa.map 5 5 15 10 15 packed > nul
cd ..\dev

echo Convirtiendo enemigos/hotspots
..\utils\ene2h.exe ..\enems\enems.ene enems.h

echo Importando GFX
..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin >nul
..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
..\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
..\utils\png2scr.exe ..\gfx\loading.png ..\gfx\loading.bin > nul
..\utils\apack.exe ..\gfx\title.scr title.bin > nul
..\utils\apack.exe ..\gfx\marco.scr marco.bin > nul
..\utils\apack.exe ..\gfx\ending.scr ending.bin > nul
..\utils\sprcnv.exe ..\gfx\sprites.png sprites.h > nul

echo Compilando guego
zcc +zx -vn mk1.c -o %game.bin -lsplib2_mk2.lib -zorg=24000 > nul

echo Construyendo cinta
rem cambia LOADER por el nombre que quieres que salga en Program:
..\utils\bas2tap -a10 -sLOADER loader.bas loader.tap > nul
..\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
..\utils\bin2tap -o main.tap -a 24000 %game.bin > nul
copy /b loader.tap + screen.tap + main.tap %game.tap > nul

echo Limpiando
del loader.tap > nul
del screen.tap > nul
del main.tap > nul
del *.bin > nul

echo �Hecho!