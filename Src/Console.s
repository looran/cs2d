
%Tout ce qui concerne la console
%et lafficheur de message sur le
%haut de lecran

%Affichage de la console
*AffConsole

%On efface a l'emplacement de la
%console sur les 2 scr
%(CAD tt sof bordure droite)
D0=822B2 A=0.W
LC FF %64l * 2grs * 2scr
{
 DAT0=A.16 D0+16 DAT0=A.14 D0+18
 C-1.B UPNC
}

%On trace les contours de la
%console sur les 2 scr
D0=83192 %822B2+(34q*2grs*56l)
A=0.W A-1.W
DAT0=A.16 D0+16 DAT0=A.14
D0=84292 %833B2+(34q*2grs*56l)
DAT0=A.16 D0+16 DAT0=A.14

%On aff le txt de la console
GOSUB CslCreatAffImg

%On refr la ligne de cmd
GOSUB CslRefrCmd

%On indique que le test de touche
%doit etre celui de la console
D0=(5)NBTsttUse LC 2 DAT0=C.P
%Interdiction Aff j1 bots level
%impacts
C=0.P
D0=(5)YNAffJ1 DAT0=C.P
D0=(5)YNAffBots DAT0=C.P
D0=(5)YNAffLevel DAT0=C.P
D0=(5)YNAffImpacts DAT0=C.P

RTN

%Test de touche du mode console
*tsttconsole

%Tst fleche o
LC 040
OUT=C
C=IN2
?CBIT=1 3 ç
{
 %Test si on peut scroll vers
 %le haut
 
 %Scroll vers le haut
 
}

%Tst fleche bas
LC 040
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %Test si on peut scroll vers
 %le bas
 
 %Scroll vers le bas
 
}

%Tst fleche droite (Quit)
LC 040
OUT=C
C=IN2
?CBIT=1 0 ç
{
 %Retour jeu
 GOTOL mna2game
}

%On verifie si il y a des new msg
%a afficher
D0=(5)CslNewMsg A=DAT0.P
?Aã0.P ç
{
 %On se place en bas de la csl
 D0=(5)CslLastLigneBuffer
 A=DAT0.B
 D0=(5)CslLigneBImgOnBuffer
 DAT0=A.B
 %On reaf
 GOSUB CslCreatAffImg
}

%On test l'alphabet, on verifie
%si une touche netait pas appuye
%juste avant, on regarde si on
%est pas o bout dla ligne de
%commande, et enfin on aff la
%lettre
%RETOUR:
%Carry=0 => aucune touche press
%Carry=1 => 1 touche a ete press
GOSUB CslTstAlph
SKIPC
{
 %On dit que no touch press
 D0=(5)CslToucheAlphP
 C=0.P DAT0=C.P
}
SKELSE
{
 %Si 1 touch dja press, quit
 D0=(5)CslToucheAlphP A=DAT0.P
 ?Aã0.P ç
 {
  EXIT2
 }
 B=C.B %Sav new lettre
 ?C=0.B ç
 {
  %On a push flech g ç eff 1 char
  D0=(5)CslPositCurs A=0.A
  A=DAT0.P
  ?A=0.P ç
  {
   EXIT3
  }
  A-1.P DAT0=A.P
  D0=(5)CslAdrBufferCmd C=DAT0.A
  A+A.B A+C.A D0=A
  LC 10 DAT0=C.B
  GOSUB CslRefrCmd
  EXIT2
 }
 D0=(5)CslPositCurs
 A=0.A A=DAT0.P
 LC E
 ?A=C.P ç
 {
  %La ligne de cmd est pleine
  EXIT2
 }
 A+A.B %*2 car 2q par char
 D0=(5)CslAdrBufferCmd C=DAT0.A
 A+C.A D0=A
 C=B.B DAT0=C.B %Writ new lettre
 %dans buffer ligne cmd
 D0+2 LC 10 DAT0=C.B %Curseur
 GOSUB CslRefrCmd
}

%On test la touch ENTER, qui
%valide la ligne de commande
%Tst fleche droite (Quit)
LC 001
OUT=C
C=IN2
?CBIT=1 0 ç
{
 %Test si ya qq chose decrit
 %sur la ligne de cmd
 D0=(5)CslPositCurs A=DAT0.P
 ?A=0.P ç
 {
  EXIT2
 }
 %Interpretation de skil ya mark
 %sur la cmd line
 %...
 GOSUB CslEffBufferCmd
 GOSUB CslRefrCmd
}

RTN

%Affichage du txt de la console
*CslCreatAffImg

%INIT
%On pointe sur la ligne du buffer
%qui sera aff en bas de lecran
%dans R1.a
D0=(5)CslLigneBImgOnBuffer
A=0.A A=DAT0.B B=A.A
ASL.X A+A.A A+A.A %*64
B+B.X B+B.X
A-B.A %*64 - *4 = *60
D0=(5)CslAdrBuffer C=DAT0.A
C+A.A R1=A.A
%On pointe en bas de la csl, sur
%le scr different du scr EC,
%dans R2.a
?ST=0.0 SKIPYES
{
 LC 82F72 %822B2h + CC0h
}
SKELSE
{
 LC 84072 %833B2h + CC0h
}
R2=C.A
%Si CslLigneBImgOnBuffer ==
%CslLastLigneBuffer => CslNewMsg
%= 0, et eff indik new msg
D0=(5)CslLigneBImgOnBuffer
A=DAT0.B
D0=(5)CslLastLigneBuffer
C=DAT0.B
?A=C.B ç
{
 D0=(5)CslNewMsg C=0.P DAT0=C.P
 %Eff indik (Fleche droite)
 %...
}
%On met le nb de ligne a afficher
%dans D.s
D0=(5)CslNbLigneBuffer
A=DAT0.B LC 09
?AäC.B ç
{
 P=15 LC 8 P=0 D=C.S
}
SKELSE
{
 C=DAT0.S C-1.S D=C.S
}

%BOUCLE
*CslBclCreatAffImgB
 C=R1.A D0=C C+16.A R1=C.A
 C=DAT0.16
 ?C=0.W ç
 {
  GOTO CslBclCreatAffImgE
 }
 B=C.W
 A=R2.A D1=A A+8.A R2=A.A
 GOSUBL affcharscr1minifont
 
 C=R1.A D0=C C+16.A R1=C.A
 C=DAT0.16
 ?C=0.W ç
 {
  GOTO CslBclCreatAffImgE
 }
 B=C.W
 A=R2.A D1=A A+8.A R2=A.A
 GOSUBL affcharscr1minifont
 
 C=R1.A D0=C C+16.A R1=C.A
 C=DAT0.16
 ?C=0.W ç
 {
  GOTO CslBclCreatAffImgE
 }
 B=C.W
 A=R2.A D1=A A+8.A R2=A.A
 GOSUBL affcharscr1minifont

 C=R1.A D0=C C+12.A
 D1=(5)CslOutBuffer A=DAT1.A
 ?C=A.A ç
 {
  C-60.A
 }
 R1=C.A
 C=0.W C=DAT0.12
 ?C=0.W ç CslBclCreatAffImgE
 B=C.W
 A=R2.A D1=A
 LC 001B0 A-C.A R2=A.A
 GOSUBL affcharscr1minifont
 
 D-1.S
 SKIPC
 {
  GOTO CslBclCreatAffImgB
 }
*CslBclCreatAffImgE

RTN

%Rafraichissement de la ligne
%de commande
*CslRefrCmd
%...
RTN

%On test l'alphabet, on verifie
%si une touche netait pas appuye
%juste avant, on regarde si on
%est pas o bout dla ligne de
%commande, et enfin on aff la
%lettre
%RETOUR:
%Carry=0 => aucune touche press
%Carry=1 => 1 touche a ete press

*CslTstAlph

%Flech gauche (Drop 1 char)
LC 001
OUT=C
C=IN2
?CBIT=1 6 ç
{
 C=0.B
 RTNSC
}

%A
LC 020
OUT=C
C=IN2
?CBIT=1 0 ç
{
 LC 41
 RTNSC
}

%B
LC 020
OUT=C
C=IN2
?CBIT=1 1 ç
{
 LC 42
 RTNSC
}

%C
LC 020
OUT=C
C=IN2
?CBIT=1 2 ç
{
 LC 43
 RTNSC
}

%D
LC 020
OUT=C
C=IN2
?CBIT=1 3 ç
{
 LC 44
 RTNSC
}

%E
LC 020
OUT=C
C=IN2
?CBIT=1 4 ç
{
 LC 45
 RTNSC
}

%F
LC 020
OUT=C
C=IN2
?CBIT=1 5 ç
{
 LC 46
 RTNSC
}

%...

RTNCC

%Effacage du buffer de la cmd
%line
*CslEffBufferCmd
%Curseur a 0
D0=(5)CslPositCurs C=0.P DAT0=C.P
%Eff buffer
D0=(5)CslAdrBufferCmd A=DAT0.A
D0=A A=0.W
DAT0=A.16 LC 01 DAT0=C.B
D0+16 DAT0=A.16
RTN

@