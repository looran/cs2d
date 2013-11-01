%Refresh entier de lecran

*refrscr

D0=(5)nbcasescr
C=DAT0 A

D0=(5)adrbddwad2
A=DAT0 A

A=A+C A
R4=A A %R4a pointe sur lendroit
%de la bdd2 ou est le scr a upt
D0=(5)adrbddwad1
A=DAT0 A
A=A+C A
R3=A A %R3a pointe sur lendroit
%de la bdd1 ou est le scr a upt
D0=(5)adrgwad
C=DAT0 A
D=C A %Da est le debut du g wad
?ST=0.0 SKIPYES
{
 D1=(5)AdrSCREEN1 C=DAT1.A
 D1=C
}
SKELSE
{
 D1=(5)AdrSCREEN2 C=DAT1.A
 D1=C
}

%Init bcl du nb de fois kon va
%faire des read dans B.w (8 car
%64l / 8wad )
%Dans R4.s
P=15
LC 7
R4=C P

%Boucle avec Bw
*affwada

A=R3 A
D0=A
P=14
C=DAT0 15
R1=C WP
A=R4 A
D0=A
C=DAT0 15
B=C WP
%On recherche cbien fo rajouter
%pour passer a la nextline ds bdd
C=0 A
D0=(5)nbcasebddmdroite
C=DAT0 B
A=A+C A
A=A+16 A
R4=A A %R4a pointe sur la future
%ligne de la bdd a afficher
A=R3 A
A=A+C A
A=A+16 A
R3=A A %Pareil pour R3

P=15
LC E %Init bcl 8wad (1/2l.‘Qds D.s
D=C P
P=0

%Bcl de decal dans B.w et R1
*affwadb

%Partie dans R1 pour la selection
%de la partie du grob wad dans
%lakel se trouve
%la wad a afficher au final

C=0 A

A=R1 P
?A=0 P ç
{
 GOTO finselectpartgwad
}
LC 1
?A=C P ç
{
 C=P 15
 P=0
 LC 00200
 P=C 15
 GOTO finselectpartgwad
}

*finselectpartgwad

%Partie dans B pour trouver kelle
%wad afficher dans le grob select
%ionnÈ grace a R1

A=0 A

%Bcl qui recherche kel wad
%aff en fct de la bdd
*kelwad
B-1 P
GOC affwad
A+32 A
GOTO kelwad

*affwad
%Pas touch a Aa Bw D0 D1 Ds P Da
%R4s R4a
%On rajoute ladresse de la partie
%du grob avec ladresse de la wad
%dans la partie du grob
A=A+C A

%On rajoute ladresse de depart
%du grob des wad a cette adresse
C=D A
A=A+C A
D0=A %D0 pointe sur la texture
A=D1 %On sauve la position o˙ aff
%la texture sur l'ecran
C=0 S

%On recopies la texture
{
 C=DAT0 B
 DAT1=C B
 D0+2
 D1+34
 C+1 S
 UPNC
}
%On passe a la texture suivante
%sur la ligne
A+2 A
D1=A
P+1
D-1 S
GOTONC affwadb

%On passe a la ligne suivante
P=0
LC 00202
A=A+C A
D1=A

C=R4 S
C-1 S
R4=C S
GOTONC affwada

%A la fin, active le nouvel ecran
%et on recopies l'ecran vers la
%zone de fond pur
?ST=1 0 ç
{
 GOTO .recop0
}
 ST=1 0
 %Recopiage vers fond pur
 D1=(5)AdrSCREEN2 C=DAT1.A
 GOSUBL zoneecrançzonefondpur
 D1=(5)AdrSCREEN2 C=DAT1.A
 D1=(5)GreyScr1
 DAT1=C A
 D1=(5)GreyScr2
 DAT1=C A
 D1=(5)GreyScr3
 D0=(5)AdrSCREEN2 C=DAT0.A
 C+34.A
 DAT1=C A
 
 D0=(5)Disp2Ctl
 A=DAT0 A
 D1=(5)GreySoft1
 DAT1=A A
 D1=(5)GreySoft2
 DAT1=A A
 D1=(5)GreySoft3
 DAT1=A A
 GOTO .finrecop0
*.recop0
 ST=0 0
 %Recopiage vers fond pur
 D1=(5)AdrSCREEN1 C=DAT1.A
 GOSUB zoneecrançzonefondpur
 D1=(5)AdrSCREEN1 C=DAT1.A
 D1=(5)GreyScr1
 DAT1=C A
 D1=(5)GreyScr2
 DAT1=C A
 D1=(5)GreyScr3
 D1=(5)AdrSCREEN1 C=DAT1.A C+34.A
 DAT1=C A
 
 D0=(5)Disp2Ctl
 A=DAT0 A
 D1=(5)GreySoft1
 DAT1=A A
 D1=(5)GreySoft2
 DAT1=A A
 D1=(5)GreySoft3
 DAT1=A A
*.finrecop0

P=0

RTN

%Raffraichissement de l'ecran
%d'une case vers le haut avec
%le double scr

*refrscro

%On decremente le ralentissement
LC 01200
GOSUBL Decrralentissement

D0=(5)adrgwad
C=DAT0 A
R1=C A
?ST=1 0 SKIPYES
{
 D1=(5)adrsavfondecran
 C=DAT1 A D1=C
 D0=(5)AdrSCREEN2 A=DAT0.A
 LC 00220 C+A.A D0=C
}
SKELSE
{
 D1=(5)adrsavfondecran
 C=DAT1 A D1=C
 D0=(5)AdrSCREEN1 A=DAT0.A
 LC 00220 C+A.A D0=C
}
%On recopie le haut de l'ancien
%Ècran sur le nouvel scr + 1c
LC 6F %56 lignes *2grs
{
 A=DAT1.16
 DAT0=A.16
 D1+16
 D0+16
 A=DAT1.14
 DAT0=A.14
 D0+18
 D1+18
 C-1 B
 UPNC
}
D0=(5)nbcasescr
A=DAT0 A
D0=(5)adrbddwad1
C=DAT0 A
C+A A
D0=C
C=DAT0.15
B=C W
D0=(5)adrbddwad2
C=DAT0 A
C+A A
D0=C
C=DAT0.15
D=C W
?ST=1 0 SKIPYES
{
 D1=(5)AdrSCREEN2 A=DAT1.A
 A+28.A D1=A
}
SKELSE
{
 D1=(5)AdrSCREEN1 A=DAT1.A
 A+28.A D1=A
}
P=14
{
 GOSUB searchwad
 A=D1
 C=P 15
 P=0
 %Recopiage de texture
 {
  C=DAT0 B
  DAT1=C B
  D0+2
  D1+34
  P+1
  UPNC
 }
 P=C 15
 A-2 A
 D1=A
 P-1
 UPNC
}
P=0

GOSUB changescr

RTN

%Raffraichissement de l'ecran
%d'une case vers le bas avec
%le double scr

*refrscrb

%On decremente le ralentissement
LC 01200
GOSUBL Decrralentissement

D0=(5)adrgwad
C=DAT0 A
R1=C A
?ST=1 0 SKIPYES
{
 D0=(5)adrsavfondecran
 A=DAT0 A LC 00220 C+A A D1=C
 D0=(5)AdrSCREEN2 C=DAT0.A
 D0=C
}
SKELSE
{
 D0=(5)adrsavfondecran
 A=DAT0 A LC 00220 C+A A D1=C
 D0=(5)AdrSCREEN1 C=DAT0.A
 D0=C
}
%On recopie le haut de l'ancien
%Ècran sur le nouvel scr - 1c
LC 6F %56 lignes *2grs
{
 A=DAT1.16
 DAT0=A.16
 D1+16
 D0+16
 A=DAT1.14
 DAT0=A.14
 D0+18
 D1+18
 C-1 B
 UPNC
}
D0=(5)nbcasescr
A=DAT0 A
D0=(5)nbcasebddnivx
C=0 A
C=DAT0 B
B=C X
C+C X
C+C X
C+B X
C+B X
C+B X
A+C A
D0=(5)adrbddwad1
C=DAT0 A
C+A A
D0=C
C=DAT0.15
B=C W
D0=(5)adrbddwad2
C=DAT0 A
C+A A
D0=C
C=DAT0.15
D=C W
?ST=1 0 SKIPYES
{
 D1=(5)AdrSCREEN2 A=DAT1.A
 LC 00EFC A+C.A D1=A
}
SKELSE
{
 D1=(5)AdrSCREEN1 A=DAT1.A
 LC 00EFC A+C.A D1=A
}
P=14
{
 GOSUB searchwad
 A=D1
 C=P 15
 P=0
 %Recopiage de la texture
 {
  C=DAT0 B
  DAT1=C B
  D0+2
  D1+34
  P+1
  UPNC
 }
 P=C 15
 A-2 A
 D1=A
 P-1
 UPNC
}
P=0

GOSUB changescr

RTN

%Raffraichissement de l'ecran
%d'une case vers la gauche avec
%le double scr

*refrscrg

%On decremente le ralentissement
LC 01200
GOSUBL Decrralentissement

D0=(5)nbcasebddmdroite
A=0 A
A=DAT0 B
A+16 B
R3=A A
D0=(5)adrgwad
C=DAT0 A
R1=C A
?ST=1 0 SKIPYES
{
 D0=(5)adrsavfondecran
 C=DAT0 A D1=C
 D0=(5)AdrSCREEN2 C=DAT0.A
 C+2.A D0=C
}
SKELSE
{
 D0=(5)adrsavfondecran
 C=DAT0 A D1=C
 D0=(5)AdrSCREEN1 C=DAT0.A
 C+2.A D0=C
}
%On recopie le haut de l'ancien
%Ècran sur le nouvel scr - 1c
LC 7F %64 lignes *2grs -1
{
 A=DAT1.16
 DAT0=A.16
 D1+16
 D0+16
 A=DAT1.12
 DAT0=A.12
 D0+18
 D1+18
 C-1 B
 UPNC
}
D0=(5)nbcasescr
A=DAT0 A
D0=(5)adrbddwad1
C=DAT0 A
C+A A
B=C A
D0=(5)adrbddwad2
C=DAT0 A
C+A A
D=C A
?ST=1 0 SKIPYES
{
 D1=(5)AdrSCREEN2 A=DAT1.A
 D1=A
}
SKELSE
{
 D1=(5)AdrSCREEN1 A=DAT1.A
 D1=A
}
P=8
{
 C=D A
 D0=C
 C=DAT0 P
 D=C P
 A=B A
 D0=A
 A=DAT0 P
 B=A P
 GOSUB searchwad
 A=D1
 C=P 15
 P=0
 %Recopiage de la texture
 {
  C=DAT0 B
  DAT1=C B
  D0+2
  D1+34
  P+1
  UPNC
 }
 LC 00220
 P=C 15
 A+C A
 D1=A
 C=R3 A
 B+C A
 D+C A
 P+1
 UPNC
}
P=0

GOSUB changescr

RTN

%Raffraichissement de l'ecran
%d'une case vers la droite avec
%le double scr

*refrscrd

%On decremente le ralentissement
LC 01200
GOSUBL Decrralentissement

D0=(5)nbcasebddmdroite
A=0 A
A=DAT0 B
A+16 B
R3=A A
D0=(5)adrgwad
C=DAT0 A
R1=C A
?ST=1 0 SKIPYES
{
 D0=(5)adrsavfondecran
 C=DAT0 A C+2 A D1=C
 D0=(5)AdrSCREEN2 A=DAT0.A
 D0=A
}
SKELSE
{
 D0=(5)adrsavfondecran
 C=DAT0 A C+2 A D1=C
 D0=(5)AdrSCREEN1 A=DAT0.A
 D0=A
}
%On recopie le haut de l'ancien
%Ècran sur le nouvel scr - 1c
LC 7F %64 lignes *2grs -1
{
 A=DAT1.16
 DAT0=A.16
 D1+16
 D0+16
 A=DAT1.12
 DAT0=A.12
 D0+18
 D1+18
 C-1 B
 UPNC
}
D0=(5)nbcasescr
A=DAT0 A
A+14 A
D0=(5)adrbddwad1
C=DAT0 A
C+A A
B=C A
D0=(5)adrbddwad2
C=DAT0 A
C+A A
D=C A
?ST=1 0 SKIPYES
{
 D1=(5)AdrSCREEN2 A=DAT1.A
 A+28.A D1=A
}
SKELSE
{
 D1=(5)AdrSCREEN1 A=DAT1.A
 A+28.A D1=A
}
P=8
{
 C=D A
 D0=C
 C=DAT0 P
 D=C P
 A=B A
 D0=A
 A=DAT0 P
 B=A P
 GOSUB searchwad
 A=D1
 C=P 15
 P=0
 %Recopiage de la texture
 {
  C=DAT0 B
  DAT1=C B
  D0+2
  D1+34
  P+1
  UPNC
 }
 LC 00220
 P=C 15
 A+C A
 D1=A
 C=R3 A
 B+C A
 D+C A
 P+1
 UPNC
}
P=0

GOSUB changescr

RTN

*searchwad

?B=0 P ç
{
 C=0 A
 GOTO finselectpartgwad2scr
}
LC 1
?B=C P ç
{
 C=P 15
 P=0
 LC 00200
 P=C 15
 GOTO finselectpartgwad2scr
}
LC 2
?B=C P ç
{
 C=P 15
 P=0
 LC 00400
 P=C 15
 GOTO finselectpartgwad2scr
}
LC 3
?B=C P ç
{
 C=P 15
 P=0
 LC 00600
 P=C 15
 GOTO finselectpartgwad2scr
}
LC 4
?B=C P ç {
 C=P 15
 P=0
 LC 00800
 P=C 15
 GOTO finselectpartgwad2scr
}
*finselectpartgwad2scr
A=0 A
{
 D-1 P
 EXITC
 A+32 A
 UP
}
A+C A
C=R1 A
C+A A
D0=C

RTN

%Routine de chaogement entre le
%scr 1 et le 2, dapres ST 0

*changescr

?ST=1 0 ç
{
 GOTO .chg0
}
 %Recopiage vers fond pur
 D0=(5)AdrSCREEN2 C=DAT0.A
 GOSUB zoneecrançzonefondpur
 D0=(5)AdrSCREEN2 C=DAT0.A
 D1=(5)GreyScr1
 DAT1=C A
 D1=(5)GreyScr2
 DAT1=C A
 D1=(5)GreyScr3
 D0=(5)AdrSCREEN2 C=DAT0.A
 C+34.A
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
GOTO .finchg0
*.chg0
 %Recopiage vers fond pur
 D0=(5)AdrSCREEN1 C=DAT0.A
 GOSUB zoneecrançzonefondpur
 D0=(5)AdrSCREEN1 C=DAT0.A
 D1=(5)GreyScr1
 DAT1=C A
 D1=(5)GreyScr2
 DAT1=C A
 D1=(5)GreyScr3
 D0=(5)AdrSCREEN1 C=DAT0.A
 C+34.A
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
*.finchg0

RTN

%Recopiage de l'ecran dans la zon
%e de fond pur
*zoneecrançzonefondpur

D1=C %Pointe sur l'ecran
D0=(5)adrsavfondecran
C=DAT0 A D0=C %Pointe sur zone
%o˙ on va recop le fond pur
%Boucle de recopiage
LC 7F %Cbien de fois on la fait
P=14 %Pour le WP (lecture de la
%fin de la ligne)
{
 A=DAT1 16 D1+16
 DAT0=A 16 D0+16
 A=DAT1 WP D1+18
 DAT0=A WP D0+18
 C-1 B
 UPNC
}
P=0

RTN

@