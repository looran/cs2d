;STO: ASMDEBUG49.S
; ASMdebug49.s
; exemple of use:

;'ASMDEBUG49.S ; Include me
; before doing anything (including SAVE)
; ( it do some initialisations )
; it save the rpl SAVE is useless

;GOSBVL DISP ; Eoter debugger 
;            ; like that
;LOADRPL





DC _MaxLabSize 40

DC SwitchAdr $8086A
DC DISP SwitchAdr+7
DC ROMPTAB $8611D

GOSUB INITTABLE
SKIP
{
*INITTABLE
SAVE
D1=(5)ROMPTAB C=DAT1.X 
D=C.X D1+3 LC(3)261
{D-1.X GOC NOTFOUND A=DAT1.X D1+16 ?C#A.X UP }
D1-8 C=DAT1.A D=C.A D1-5 C=DAT1.A D1=C
?D=0.A { C=D.A GOSUB .PC=C }
D1+13 A=DAT1.A ?A=0.A ç NOTFOUND
CD1EX A+C.A A+10.A D1=A C=DAT1.A
C+A.A C+20.A

*.PC=C PC=C 
*NOTFOUND
LOADRPL
}
@