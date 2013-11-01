%Test si on doit dÈcaler vers le
%haut de l'Ècran

*tstdecalscro

D0=(5)coordpixj1y
A=DAT0 3
D0=(5)nbcasescry
C=0 X
C=DAT0 B
B=C B
C+C B
C+C X
C+C X
A-C X
LC 09
?A<C B ç
{
 A=B B %On recupere nbcasescry
 P=12
 C=0 P %C.p compte le nb de cases
 %a decaler
 P=15
 LA 4 %On limite le decalage a
 %4c
 P=12
 {
  A-1 B
  EXITC %On regarde si on n'es
  %t pas o bord 2 l'ecran
  C=C+1 P
  A-1 S
  UPNC
 }
 %Si rien a changÈ on sort
 ?C=0 P ç
 {
  P=0
  RTN
 }
 %Sinon on iodike cbien va faloir
 %decaler
 R0=C P
 P=0
 %On met a 1 le flag de decal
 %vers le haut
 ST=1 2
}
RTN

%Decal vers le haut

*decalscro

%On decremente de 1 dans R0
%Cest a dire dans ce kil reste a
%decaler
P=12
A=R0 P
A-1 P
SKNC
{
 %Extinction de l'indicateur
 %de ramure
 P=0
 D0=0010B
 A=DAT0 1
 LC 7 %Pour eteindre le bit3
 A&C P
 DAT0=A 1
 %Flag de decal vers le haut
 ST=0 2
 RTN
}
R0=A P
P=0
%MAJ des coords
D0=(5)nbcasescry
A=DAT0 B
A=A-1 B
DAT0=A B
D0=(5)nbcasescr
A=DAT0 A
C=0 A
D1=(5)nbcasebddnivx
C=DAT1 B
A-C A
DAT0=A A
%On refresh l'ecran
GOSUBL refrscro
GOSUBL calccoordj1scrjeu
GOSUBL affichej1

RTN

%Test si on doit decal vers le
%bas de lecran

*tstdecalscrb

D0=(5)coordpixj1y
A=DAT0 3
D0=(5)nbcasescry
C=0 X
C=DAT0 B
B=C B
C+C B
C+C X
C+C X
A-C X
LC 2E
?A>C B ç
{
 A=B B %On recupere nbcasescry
 D0=(5)nbcasebddnivy
 C=DAT0 B
 C=C-7 B
 B=C B %Bord de l'ecran en bas
 P=13
 C=0 P %C/p compte le nb de cases
 %a decaler
 P=15
 LA 4 %On limite le decalage a 4c
 P=13
 {
  A=A+1 B
  %Tst bord niveau
  ?AäB B ç
  {
   EXIT2
  }
  C=C+1 P
  A-1 S
  UPNC
 }
 %Si rien a changÈ on sort
 ?C=0 P ç
 {
  P=0
  RTN
 }
 %Sinon on indike cbien va faloir
 %decaler
 R0=C P
 P=0
 %On met a 1 le flag de decal
 %vers le bas
 ST=1 3
}
RTN

%Decal vers le bas

*decalscrb

%On decremente de 1 dans R0
%Cest a dire dans ce kil reste a
%decaler
P=13
A=R0 P
A-1 P
SKNC
{
 %Extinction de l'iodicateur
 %de ramure
 P=0
 D0=0010B
 A=DAT0 1
 LC 7 %Pour eteindre le bit3
 A&C P
 DAT0=A 1
 %Flag de decal vers le bas
 ST=0 3
 RTN
}
R0=A P
P=0
%Maj des coords
D0=(5)nbcasescry
A=DAT0 B
A=A+1 B
DAT0=A B
D0=(5)nbcasescr
A=DAT0 A
C=0 A
D1=(5)nbcasebddnivx
C=DAT1 B
A=A+C A
DAT0=A A
%On refresh l'ecran
GOSUBL refrscrb
GOSUBL calccoordj1scrjeu
GOSUBL affichej1

RTN


%Teste si on doit dÈcaler vers la
%gauche de l'Ècran

*tstdecalscrg

D0=(5)coordpixj1x
A=DAT0 3
D0=(5)nbcasescrx
C=0 X
C=DAT0 B
B=C B
C+C B
C+C X
C+C X
A-C X
LC 10
?A<C B ç
{
 A=B B %On recupere nbcasescrx
 P=14
 C=0 P %C.p compte le nb de cases
 %a decaler
 P=15
 LA 8 %On limite le decalage a
 %8c
 P=14
 {
  A-1 B
  EXITC %On regarde si on n'es
  %t pas o bord 2 l'ecran
  C=C+1 P
  A-1 S
  UPNC
 }
 %Si rien a changÈ on sort
 ?C=0 P ç
 {
  P=0
  RTN
 }
 %Sinon on indike cbien va faloir
 %decaler
 R0=C P
 P=0
 %On met a 1 le flag de decal
 %vers le haut
 ST=1 4
}
RTN

%Decal vers la gauche

*decalscrg

%On decremente de 1 dans R0
%Cest a dire dans ce kil reste a
%decaler
P=14
A=R0 P
A-1 P
SKNC
{
 %Extinction de l'indicateur
 %de ramure
 P=0
 D0=0010B
 A=DAT0 1
 LC 7 %Pour eteindre le bit3
 A&C P
 DAT0=A 1
 %Flag de decal vers la gauche
 ST=0 4
 RTN
}
R0=A P
P=0
%MAJ des coords
D0=(5)nbcasescrx
A=DAT0 B
A=A-1 B
DAT0=A B
D0=(5)nbcasescr
A=DAT0 A
A-1 A
DAT0=A A
%On refresh l'ecran
GOSUBL refrscrg
GOSUBL calccoordj1scrjeu
GOSUBL affichej1

RTN


%Test si on doit decal vers la
%droite de lecran

*tstdecalscrd

D0=(5)coordpixj1x
A=DAT0 3
D0=(5)nbcasescrx
C=0 X
C=DAT0 B
B=C B
C+C B
C+C X
C+C X
A-C X
LC 62
?A>C B ç
{
 A=B B %On recupere nbcasescrx
 D0=(5)nbcasebddnivx
 C=DAT0 B
 C=C-14 B
 B=C B %Bord de l'ecran a droite
 P=15
 C=0 P %C.p compte le nb de cases
 %a decaler
 %P=15 ne sert a rien car on est
 %deja avec P=15
 LA 8 %On limite le decalage a 8c
 %P=15 idem
 {
  A=A+1 B
  ?AäB B ç %On regarde si on n'es
  %t pas o bord 2 l'ecran
  {
   EXIT2
  }
  C=C+1 P
  A-1 S
  UPNC
 }
 %Si rien a changÈ on sort
 ?C=0 P ç
 {
  P=0
  RTN
 }
 %Sinon on indike cbien va faloir
 %decaler
 R0=C P
 P=0
 %On met a 1 le flag de decal
 %vers la droite
 ST=1 5
}
RTN

%Decal vers la droite

*decalscrd

%On decremente de 1 dans R0
%Cest a dire dans ce kil reste a
%decaler
P=15
A=R0 P
A-1 P
SKNC
{
 %Extinction de l'indicateur
 %de ramure
 P=0
 D0=0010B
 A=DAT0 1
 LC 7 %Pour eteindre le bit3
 A&C P
 DAT0=A 1
 %Flag de decal vers la droite
 ST=0 5
 RTN
}
R0=A P
P=0
%Maj des coords
D0=(5)nbcasescrx
A=DAT0 B
A=A+1 B
DAT0=A B
D0=(5)nbcasescr
A=DAT0 A
A=A+1 A
DAT0=A A
%On refresh l'ecran
GOSUBL refrscrd
GOSUBL calccoordj1scrjeu
GOSUBL affichej1

RTN

%Recadrage de l'ecran sur le pers
%o, suivant la direction de son
%regard
*recadrscr

D0=(5)directj1
A=DAT0 P
%Si le j1 regardes vers le haut
?Aã0 P SKIPYES
{
 GOSUB recadrlooko
}
SKELSE
{
 LC 1
 ?AãC P SKIPYES
 {
  GOSUB recadrlookd
 }
 SKELSE
 {
  LC 2
  ?AãC P SKIPYES
  {
   GOSUB recadrlookb
  }
  SKELSE
  {
   GOSUB recadrlookg
  }
 }
}

RTN

*recadrlooko

 %Centrage au milieu (X)
 {
  D0=(5)coordpixj1x
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  A-7 X %Gauche de lecran
  SKIPNC
  {
   A=0 B
  }
  %Test si on sort du niveau a
  %droite
  D0=(5)nbcasebddmdroite
  C=DAT0 B
  C+1 B
  ?A>C B ç
  {
   A=C B
  }
  D0=(5)nbcasescrx
  C=DAT0 B
  %Si on est deja a la bonne pos
  %en x, alors on passe au Y
  ?A=C B ç
  {
   EXIT2
  }
  ?A>C B ç
  {
   A-C.B
   C=A P
   P=C.0
   C=P.15
   P=15
   %On stok le nb de cases a deca
   %l vers la droite
   R0=C P
   P=0
   %On active le flag de decal
   %vers la droite
   ST=1 5
  }
  SKELSE
  {
   C-A B
   P=C 0
   C=P 14
   P=14
   R0=C P
   P=0
   ST=1 4
  }
 }
 %Mise du perso en bas de lecran
 %(Y)
 {
  D0=(5)coordpixj1y
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  A-5 X %Haut de l'ecran
  SKNC
  {
   A=0 X
  }
  D0=(5)nbcasescry
  C=DAT0 B
  ?A=C B ç
  {
   EXIT2
  }
  SKELSE
  {
   C-A B
   P=C 0
   C=P 12
   P=12
   R0=C P
   P=0
   ST=1 2
  }
 }

RTN

*recadrlookd

 %Centrage au milieu (Y)
 {
  D0=(5)coordpixj1y
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  A-3 X %Haut de lecran
  SKIPNC
  {
   A=0 B
  }
  %Test si on sort du niveau en
  %bas
  D0=(5)nbcasebddnivy
  C=DAT0 B
  C-8 B
  ?A>C B ç
  {
   A=C B
  }
  D0=(5)nbcasescry
  C=DAT0 B
  %Si on est deja a la bonne pos
  %en x, alors on passe au Y
  ?A=C B ç
  {
   EXIT2
  }
  ?A>C B ç
  {
   A-C.B
   C=A P
   P=C.0
   C=P.13
   P=13
   %On stok le nb de cases a deca
   %l vers la droite
   R0=C P
   P=0
   %On active le flag de decal
   %vers le bas
   ST=1 3
  }
  SKELSE
  {
   C-A B
   P=C 0
   C=P 12
   P=12
   R0=C P
   P=0
   ST=1 2
  }
 }
 %Mise du perso a gauch de lecran
 %(X)
 {
  D0=(5)coordpixj1x
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  %Test si on sort du niveau a
  %droite
  D0=(5)nbcasebddmdroite
  C=DAT0 B
  C+1 B
  ?A>C B ç
  {
   D0=(5)nbcasescrx
   A=DAT0 B
   C-A B
  }
  SKELSE
  {
   D0=(5)nbcasescrx
   C=DAT0 B
   C+1 B
   ?A=C B ç
   {
    EXIT3
   }
   A-C B
   C=A B
  }
  P=C 0
  C=P 15
  P=15
  R0=C P
  P=0
  ST=1 5
 }

RTN

*recadrlookb

 %Centrage au milieu (X)
 {
  D0=(5)coordpixj1x
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  A-7 X %Gauche de lecran
  SKIPNC
  {
   A=0 B
  }
  %Test si on sort du niveau a
  %droite
  D0=(5)nbcasebddmdroite
  C=DAT0 B
  C+1 B
  ?A>C B ç
  {
   A=C B
  }
  D0=(5)nbcasescrx
  C=DAT0 B
  %Si on est deja a la bonne pos
  %en x, alors on passe au Y
  ?A=C B ç
  {
   EXIT2
  }
  ?A>C B ç
  {
   A-C.B
   C=A P
   P=C.0
   C=P.15
   P=15
   %On stok le nb de cases a deca
   %l vers la droite
   R0=C P
   P=0
   %On active le flag de decal
   %vers la droite
   ST=1 5
  }
  SKELSE
  {
   C-A B
   P=C 0
   C=P 14
   P=14
   R0=C P
   P=0
   ST=1 4
  }
 }
 %Mise du perso en o de lecran
 %(Y)
 {
  D0=(5)coordpixj1y
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  %Test si on sort du niveau a
  %droite
  D0=(5)nbcasebddnivy
  C=DAT0 B
  C-8 B
  ?A>C B ç
  {
   D0=(5)nbcasescry
   A=DAT0 B
   C-A B
  }
  SKELSE
  {
   D0=(5)nbcasescry
   C=DAT0 B
   C+1 B
   ?A=C B ç
   {
    EXIT3
   }
   A-C B
   C=A B
  }
  P=C 0
  C=P 13
  P=13
  R0=C P
  P=0
  ST=1 3
 }

RTN

*recadrlookg

 %Centrage au milieu (Y)
 {
  D0=(5)coordpixj1y
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  A-3 X %Haut de lecran
  SKIPNC
  {
   A=0 B
  }
  %Test si on sort du niveau en
  %bas
  D0=(5)nbcasebddnivy
  C=DAT0 B
  C-8 B
  ?A>C B ç
  {
   A=C B
  }
  D0=(5)nbcasescry
  C=DAT0 B
  %Si on est deja a la bonne pos
  %en x, alors on passe au Y
  ?A=C B ç
  {
   EXIT2
  }
  ?A>C B ç
  {
   A-C.B
   C=A P
   P=C.0
   C=P.13
   P=13
   %On stok le nb de cases a deca
   %l vers la droite
   R0=C P
   P=0
   %On active le flag de decal
   %vers le bas
   ST=1 3
  }
  SKELSE
  {
   C-A B
   P=C 0
   C=P 12
   P=12
   R0=C P
   P=0
   ST=1 2
  }
 }
 %Mise du perso a droite du scr
 %(X)
 {
  D0=(5)coordpixj1x
  A=DAT0 X
  ASRB X
  ASRB X
  ASRB X %/8
  A-12 B
  %Test si on sort pas de l'ecran
  %sur la gauche
  SKIPNC
  {
   A=0 B
  }
  D0=(5)nbcasescrx
  C=DAT0 B
  ?A=C B ç
  {
   EXIT2
  }
  SKELSE
  {
   C-A B
   P=C 0
   C=P 14
   P=14
   R0=C P
   P=0
   ST=1 4
  }
 }

RTN

@