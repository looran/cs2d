%Ce fichier contient certaines
%petites routines, comme celle
%qui affiche un chiffre sur
%le scr ...

%Routine de test si un obj de
%2q est ds l'ecran ou pas
%l'ecran ou pas
%EntrÈes: A.x : CoordsX obj
%         R2.x : CoordsY obj
%Sorties: Si l'objet peut etre af
%         fichÈ, la cary est a 1,
%         et R2.a contient l'adr
%         o˙ aff l'objet.
%         Sinon, la cary est a 0.
*tstobj2jinscr

 C=0 X
 D0=(5)nbcasescrx
 C=DAT0 B
 C+C X %posit scrX en q
 %A.x=Coords objX en pix
 ASRB X
 ASRB X %Posit objX en q
 A-C X
 SKIPNC
 {
  RTNCC %< scrX
 }
 LC 01B
 ?A>C X ç
 {
  RTNCC %>scrX
 }
 B=A X
 C=0 X
 D0=(5)nbcasescry
 C=DAT0 B
 C+C X
 C+C X
 C+C X %Posit scrY en lignes
 A=0 A
 A=R2 X %Coords objY en lignes
 A-C X
 SKIPNC
 {
  RTNCC %< scrY
 }
 LC 038
 ?A>C X ç 
 {
  RTNCC  %>scrY
 }
 A+A X A+A X C=A X ASL X A+C X%lçq
 A+B X %X + Y
 ?ST=1 0 SKIPYES
 {
  D0=(5)AdrSCREEN1 C=DAT0.A
 }
 SKELSE
 {
  D0=(5)AdrSCREEN2 C=DAT0.A
 }
 C+A A
 R2=C A %Pointe sur l'endroit o˙
 %afficher l'objet
RTNSC

*affcharallscrminifont

%On affiche la lettre qui est ds
%A.b a l'adresse contenue ds D1,
%en grs sur les 2 ecrans

LC 81454 %adresse du debut des
%lettres dans la minifont

B=0 X
B=A B
A+A B
A+A B %A*4
B+B B %B*2
B+A X %4+2=6,donc on a * par 6
C+B X %On a ds Ca l'adr du char

%On l'affiche sur le 1er ecran
D=C A %On save l'adr du char pour
%le reutiliser pour l'aff sur le
%2e ecran
D0=C
A=D1 %On save D1
P=10 %(15-5)
{
 C=DAT0.1
 DAT1=C.1
 D0+1
 D1+34
 DAT1=C.1
 D1+34
 P+1
 UPNC
}

LC 01100
C+A A %On passe sur le 2e ecran
D1=C
%On l'affiche sur le 2e ecran
C=D A
D0=C %On a recuperÈ l'adr du char
P=10 %(15-5)
{
 A=DAT0.1
 DAT1=A.1
 D0+1
 D1+34
 DAT1=A.1
 D1+34
 P+1
 UPNC
}

RTN

*affnballscrminifont

%On affiche le chiffre qui est ds
%A.b a l'adresse contenue ds D1,
%en grs sur les 2 ecrans

LC 813EF %adresse du debut des
%chiffres dans la minifont

B=0 A
B=A P
A=B A
A+A B
A+A B %A*4
B+B B %B*2
B+A B %4+2=6,donc on a * par 6
C+B A %On a ds Ca l'adr du char

%On l'affiche sur le 1er ecran
D=C A %Oo save l'adr du char pour
%le reutiliser pour l'aff sur le
%2e ecran
D0=C
A=D1 %On save D1
P=10 %(15-5)
{
 C=DAT0.1
 DAT1=C.1
 D0+1
 D1+34
 DAT1=C.1
 D1+34
 P+1
 UPNC
}

LC 01100
C+A A %On passe sur le 2e ecran
D1=C
%On l'affiche sur le 2e ecran
C=D A
D0=C %On a recuperÈ l'adr du char
P=10 %(15-5)
{
 A=DAT0.1
 DAT1=A.1
 D0+1
 D1+34
 DAT1=A.1
 D1+34
 P+1
 UPNC
}

RTN

*affcharscr1minifont

%On affiche le char qui est ds
%B.w a l'adresse contenue ds D1,
%en 4grs, sur 1 seul ecran
%Sortie: Adresse o˙ on a aff le
%char ds A.a

LC 8144E %adresse du debut des
%lettres dans la minifont, et on
%peut aussi acceder aux chiffres
%-6 car faut laisser 0 pour le
%stop
D=C A %On sav adr minifont

%Init bcl
P=15
LC 7
P=0

{
 A=0 X
 A=B B
 C=0 A
 C=A B
 A+A B
 A+A X %A*4
 C+C B %C*2
 C+A X %4+2=6,donc on a * par 6
 C+D A %On a ds Ca l'adr du char
 
 %On l'affiche sur lecran
 D0=C
 A=D1 %On sav D1
 P=10 %(15-5)
 {
  C=DAT0.1
  DAT1=C.1
  D0+1
  D1+34
  DAT1=C.1
  D1+34
  P+1
  UPNC
 }
 A+1 A %On increm la position
 D1=A %On pointe sur le futur end
 %roit o˙ ecrire
 BSR W
 BSR W
 ?B=0 B ç
 {
  RTN
 }
 C-1 S
 UPNC
}

RTN

*affcharscr1font6

%On affiche le char qui est ds
%B.w a l'adresse contenue ds D1,
%en 4grs, sur 1 seul ecran
%Sortie: Adresse o˙ on a aff le
%char ds A.a

D0=(5)adrfont6
C=DAT0.A
R2=C A %On sav adr font6

%Init bcl
P=15
LC 3
P=0

 *.beginbclcharfontcs2d
 C=0 A
 C=B B
 CSL X %*16
 C+2.X %Ajustage
 A=R2 A
 C+A A %On a ds Ca l'adr du char
 
 D0=C %D0 pointe sur le char 1
 BSR W
 BSR W
 ?B=0 B ç
 {
  A=D1 R3=A A %On sav D1
  P=10 %(15-6+1)
  {
   C=DAT0.B DAT1=C.B
   D1+34
   C=0 B C-1 B DAT1=C.B
   D1+34 D0+2
   P+1
   UPNC
  }
  RTN
 }
 SKELSE
 {
  A=D1 R3=A A %On sav D1
  C=0 A
  C=B B
  CSL X %*16
  C+2.X %Ajustage
  A=R2 A
  A+C A %On a ds Ca l'adr du char
  %Donc D0 pointe sur char1 et
  %A sur char2
  P=10 %(15-6+1)
  {
   C=0 X
   C=DAT0.B D=C X
   AD0EX C=DAT0.B
   CSL.X C+C.X C+C.X
   C!D.X
   DAT1=C.X D1+34
   C=0 X C-1 X DAT1=C.X
   D1+34 A+2.A AD0EX A+2.A
   P+1 UPNC
  }
 }
 A=R3.A
 A+3 A
 D1=A %On pointe sur le futur end
 %roit o˙ ecrire
 BSR W
 BSR W
 ?B=0 B ç
 {
  RTN
 }
 C-1 S
 SKIPC
 {
  GOTO .beginbclcharfontcs2d
 }

RTN

*transitionmontectrste

%On monte le premier chiffre du
%ctrste
D0=00101
A=DAT0 P
B=A P %On sav le 1er chiffre
{
 %Ralentissement
 LC 01AFF
 {
  C-1 A
  UPNC
 }
 A-1 P
 EXITC
 DAT0=A P
 UP
}
%Est ce que le 2e est deja bas ?
D0=00102
C=DAT0 P
B=0 S
?C=0 P ç
{
 RTN
}
{
 B+1 S
}
%On monte le 2e, puis on met le
%premier a fond et on le monte
C=0 P DAT0=C P
D0=00101 LC F DAT0=C P
%On monte le 1er
A=C P
{
 %Ralentissement
 LC 01AFF
 {
  C-1 A
  UPNC
 }
 A-1 P
 EXITC
 DAT0=A P
 UP
}

RTN

*transitionbaissectrste

%On baisse le premier chiffre du
%ctrste
D0=00101
A=DAT0 P
{
 %Ralentissement
 LC 01AFF
 {
  C-1 A
  UPNC
 }
 A+1 P
 EXITC
 ?A>B P ç
 {
  ?B=0 S ç
  {
   RTN
  }
 }
 DAT0=A P
 UP
}
D0=00102
LC 1 DAT0=C P
D0=00101 C=0 P DAT0=C P
%On baisse le 1er
A=C P
{
 %Ralentissement
 LC 01AFF
 {
  C-1 A
  UPNC
 }
 A+1 P
 EXITC
 ?A>B P ç
 {
  EXIT2
 }
 DAT0=A P
 UP
}

RTN

%On sauve le contrast actuel
%comme contrast de jeu
*SavCtrstJeu
D0=00101
A=DAT0 P
D0=(5)ctrstjeu101
DAT0=A P
D0=00102
A=DAT0 P
D0=(5)ctrstjeu102
DAT0=A P
RTN

*affchargrob1font6

%On affiche le char qui est ds
%B.w a l'adresse contenue ds D1,
%sur un grob de R4.a q de large,
%en 4grs, sur 1 seul ecran
%Sortie: Adresse o˙ on a aff le
%char ds A.a

D0=(5)adrfont6
C=DAT0.A
R2=C A %On sav adr font6

%Init bcl
P=15
LC 3
P=0

 *.beginbclcharfontcs2d
 C=0 A
 C=B B
 CSL X %*16
 C+2.X %Ajustage
 A=R2 A
 C+A A %On a ds Ca l'adr du char
 
 D0=C %D0 pointe sur le char 1
 BSR W
 BSR W
 ?B=0 B ç
 {
  A=D1 R3=A A %On sav D1
  A=R4.A %Nb q a sauter 4 nxt l
  P=10 %(15-6+1)
  {
   C=DAT0.B DAT1=C.B
   CD1EX C+A.A D1=C
   C=0 B C-1 B DAT1=C.B
   CD1EX C+A.A D1=C D0+2
   P+1
   UPNC
  }
  RTN
 }
 SKELSE
 {
  A=D1 R3=A A %On sav D1
  C=0 A
  C=B B
  CSL X %*16
  C+2.X %Ajustage
  A=R2 A
  A+C A %On a ds Ca l'adr du char
  %Donc D0 pointe sur char1 et
  %A sur char2
  P=10 %(15-6+1)
  {
   C=0 X
   C=DAT0.B D=C X
   AD0EX C=DAT0.B
   CSL.X C+C.X C+C.X
   C!D.X
   DAT1=C.X
   CD1EX D=C.A C=R4.A C+D.A D1=C
   C=0 X C-1 X DAT1=C.X
   CD1EX D=C.A C=R4.A C+D.A D1=C
   A+2.A AD0EX A+2.A
   P+1 UPNC
  }
 }
 A=R3.A
 A+3 A
 D1=A %On pointe sur le futur end
 %roit o˙ ecrire
 BSR W
 BSR W
 ?B=0 B ç
 {
  RTN
 }
 C-1 S
 SKIPC
 {
  GOTO .beginbclcharfontcs2d
 }

RTN

%SwapScr
*SwapScr

?ST=0 0 SKIPYES
{
 ST=1.0
 D0=(5)AdrSCREEN2 C=DAT0.A
 D1=(5)GreyScr1
 DAT1=C A
 D1=(5)GreyScr2
 DAT1=C A
 D1=(5)GreyScr3
 D0=(5)AdrSCREEN2 C=DAT0.A C+34.A
 DAT1=C A
 
 D0=(5)Disp2Ctl
 A=DAT0 A
 D1=(5)GreySoft1
 DAT1=A A
 D1=(5)GreySoft2
 DAT1=A A
 D1=(5)GreySoft3
 DAT1=A A
 ST=1 0
}
SKELSE
{
 ST=0.0
 D0=(5)AdrSCREEN1 C=DAT0.A
 D1=(5)GreyScr1
 DAT1=C A
 D1=(5)GreyScr2
 DAT1=C A
 D1=(5)GreyScr3
 D0=(5)AdrSCREEN1 C=DAT0.A C+34.A
 DAT1=C A
 
 D0=(5)Disp2Ctl
 A=DAT0 A
 D1=(5)GreySoft1
 DAT1=A A
 D1=(5)GreySoft2
 DAT1=A A
 D1=(5)GreySoft3
 DAT1=A A
 ST=0 0
}

RTN

@