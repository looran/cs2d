%Routine qui affiche la
%statbarre ou des morceaux de
%celle ci

*affstatbar

%On affche la ligne de separation
%avec l'ecran de jeu

D0=(5)AdrSCREEN1 A=DAT0.A
A+30.A
D0=A
LA 1
LC 7F %On trace la ligne sur 1
%scr
{
 DAT0=A 1
 D0+34
 C-1 B
 UPNC
}
D0=(5)AdrSCREEN2 A=DAT0.A
A+30.A
D0=A
LA 1
LC 7F %On trace la ligne sur 1
%scr
{
 DAT0=A 1
 D0+34
 C-1 B
 UPNC
}

%On va afficher les icones

%Affichage de l'icone des vies

D0=(5)AdrSCREEN1 A=DAT0.A
LC 000A6 A+C.A
D0=A
D1=(5)adrgicovies
A=DAT1 A
B=A A
D1=A
LC 1
D=C P
{
 LC 001
 P=4
 {
  A=0 X
  A=DAT1 B
  A+A X %On decal d'1 pix pour
  %centrer
  A!C X %Astuce pour pas effacer
  %la ligne de separation
  DAT0=A 3
  D0+34
  D1+2
  P+1
  UPNC
 }
 D0=(5)AdrSCREEN2 A=DAT0.A
 LC 000A6 A+C.A
 D0=A
 A=B A
 D1=A
 D-1 P
 UPNC
}

%Affichage de l'icone de l'armure

D0=(5)AdrSCREEN1 A=DAT0.A
LC 0045E A+C.A
D0=A
D1=(5)adrgicoarmu
A=DAT1 A
B=A A
D1=A
LC 1
D=C P
{
 LC 01
 P=2
 {
  A=DAT1 B
  A+A B %On decal d'1 pix pour
  %centrer
  A!C B %Astuce pour pas effacer
  %la ligne de separation
  DAT0=A B
  D0+34
  D1+2
  P+1
  UPNC
 }
 D0=(5)AdrSCREEN2 A=DAT0.A
 LC 0045E A+C.A
 D0=A
 A=B A
 D1=A
 D-1 P
 UPNC
}

%Affichage de l'icone de l'arme
%En Cour
GOSUB afficoweapec

%Maintenant on affiche les
%donnÈes

GOSUB affvies

GOSUB affarmu

GOSUB affamocharg

GOSUB affamopoche

RTN

%Affichage des vies seulement

*affvies

%Effacage de la zone
D1=(5)AdrSCREEN1 A=DAT1.A
LC 0023E A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}
D1=(5)AdrSCREEN2 A=DAT1.A
LC 0023E A+C.A
D1=A
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}

%Affichage des 2 chiffres
D0=(5)Lifej1
A=DAT0 B
R1=A B
LC 01100
D=C A %D.a contient combien il fo
%ajouter pour passer a l'ecran 2
LC 813EF
R3=C A %Adresse du debut des
%chiffres ds la minifont
D1=(5)AdrSCREEN1 A=DAT1.A
LC 0023E A+C.A
D1=A %Adresse ou aff le 1er
%chiffre des vies sur l'ecran 1
P=1
{
 A=R1 P
 C=R3 A
 {
  A-1 P
  EXITC
  C+6 A
  UP
 }
 R2=C A
 A=D1
 R4=A A
 D0=C
 GOSUB affnbstatbar
 C=R4 A
 C+D A
 D1=C
 C=R2 A
 D0=C
 GOSUB affnbstatbar
 D1=(5)AdrSCREEN1 A=DAT1.A
 C=P.15 P=0 LC 0023F P=C.15
 A+C.A
 D1=A %Adresse ou aff le 2e
 %chiffre des vies sur le scr 1
 P-1
 UPNC
}

P=0

RTN

*affarmu

%Effacage de la zone
D1=(5)AdrSCREEN1 A=DAT1.A
LC 0063A A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}
D1=(5)AdrSCREEN2 A=DAT1.A
LC 0063A A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}

%Affichage des 2 chiffres

D0=(5)Armuj1
A=DAT0 B
R1=A B
LC 01100
D=C A %D/a contient combien il fo
%ajouter pour passer a l'ecran 2
LC 813EF
R3=C A %Adresse du debut des
%chiffres ds la minifont
D1=(5)AdrSCREEN1 A=DAT1.A
LC 0063A A+C.A
D1=A %Adresse ou aff le 1er
%chiffre des vies sur l'ecrao 1
P=1
{
 A=R1 P
 C=R3 A
 {
  A-1 P
  EXITC
  C+6 A
  UP
 }
 R2=C A
 A=D1
 R4=A A
 D0=C
 GOSUB affnbstatbar
 C=R4 A
 C+D A
 D1=C
 C=R2 A
 D0=C
 GOSUBL affnbstatbar
 D1=(5)AdrSCREEN1 A=DAT1.A
 C=P.15 P=0 LC 0063B P=C.15
 A+C.A
 D1=A %Adresse ou aff le 2e
 %chiffre des vies sur le scr 1
 P-1
 UPNC
}

P=0

RTN

*affamocharg

%On regarde quelle est l'arme
%que le j1 utilise (prim,sec...)
D0=(5)weapselectj1
A=DAT0 P
?Aã0 P SKIPYES
{
 %Arme primaire
 D0=(5)amochargj1prim
}
SKELSE
{
 LC 1
 ?A=C P ç
 {
  %Arme secondaire
  D0=(5)amochargj1second
 }
 SKELSE
 {
  %Arme tertiaire
  D0=(5)nbweapon3
 }
}

%Effacage de la zone
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00A36 A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}
D1=(5)AdrSCREEN2 A=DAT1.A
LC 00A36 A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}

%Affichage des 2 chiffres

%On a deja fixÈ D0
A=DAT0 B
R1=A B
LC 01100
D=C A %D.a contient combien il fo
%ajouter pour passer a l'ecran 2
LC 813EF
R3=C A %Adresse du debut des
%chiffres ds la minifont
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00A36 A+C.A
D1=A %Adresse ou aff le 1er
%chiffre des vies sur l'ecran 1
P=1
{
 A=R1 P
 C=R3 A
 {
  A-1 P
  EXITC
  C+6 A
  UP
 }
 R2=C A
 A=D1
 R4=A A
 D0=C
 GOSUB affnbstatbar
 C=R4 A
 C+D A
 D1=C
 C=R2 A
 D0=C
 GOSUBL affnbstatbar
 D1=(5)AdrSCREEN1 A=DAT1.A
 C=P.15 P=0 LC 00A37 P=C.15
 A+C.A
 D1=A %Adresse ou aff le 2e
 %chiffre des vies sur le scr 1
 P-1
 UPNC
}

P=0

RTN

*affamopoche

%On regarde quelle arme le j1
%est en train d'utiliser
D0=(5)weapselectj1
A=DAT0 P
?Aã0 P SKIPYES
{
 %Arme primaire
 D0=(5)amoj1prim
}
SKELSE
{
 LC 1
 ?A=C P ç
 {
  %Arme secondaire
  D0=(5)amoj1second
 }
 SKELSE
 {
  %Arme tertiaire
  D0=(5)nbweapon3
 }
}

%Effacage de la zone
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00C12 A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}
D1=(5)AdrSCREEN2 A=DAT1.A
LC 00C12 A+C.A
D1=A
LC 001
P=6
{
 DAT1=C 3
 D1+34
 P+1
 UPNC
}

%Affichage des 2 chiffres

%On a deja fixÈ D0
A=DAT0 B
R1=A B
LC 01100
D=C A %D.a contient combien il fo
%ajouter pour passer a l'ecran 2
LC 813EF
R3=C A %Adresse du debut des
%chiffres ds la minifont
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00C12 A+C.A
D1=A %Adresse ou aff le 1er
%chiffre des vies sur l'ecran 1
P=1
{
 A=R1 P
 C=R3 A
 {
  A-1 P
  EXITC
  C+6 A
  UP
 }
 R2=C A
 A=D1
 R4=A A
 D0=C
 GOSUB affnbstatbar
 C=R4 A
 C+D A
 D1=C
 C=R2 A
 D0=C
 GOSUBL affnbstatbar
 D1=(5)AdrSCREEN1 A=DAT1.A
 C=P.15 P=0 LC 00C13 P=C.15
 A+C.A
 D1=A %Adresse ou aff le 2e
 %chiffre des vies sur le scr 1
 P-1
 UPNC
}

P=0

RTN

*affnbstatbar

C=0 B
C=DAT0 1
C+C B
C+C B
A=DAT1 B
C!A B
DAT1=C B
D1+34
DAT1=C B
D0+1 D1+34

C=0 B
C=DAT0 1
C+C B
C+C B
A=DAT1 B
C!A B
DAT1=C B
D1+34
DAT1=C B
D0+1 D1+34

C=0 B
C=DAT0 1
C+C B
C+C B
A=DAT1 B
C!A B
DAT1=C B
D1+34
DAT1=C B
D0+1 D1+34

C=0 B
C=DAT0 1
C+C B
C+C B
A=DAT1 B
C!A B
DAT1=C B
D1+34
DAT1=C B
D0+1 D1+34

C=0 B
C=DAT0 1
C+C B
C+C B
A=DAT1 B
C!A B
DAT1=C B
D1+34
DAT1=C B
D0+1 D1+34

RTN

%Affichage de l'icone de l'arme
%En Cours
*afficoweapec

%On regarde si le j1 utilise son
%arme prim ou secondaire
D0=(5)weapselectj1
A=DAT0 P
?A=0 P ç
{
 %C'est une arme primaire, mais
 %laquelle ?
 D0=(5)typeweapprimj1
 A=DAT0.P
 %Test si c'est un mp5
 LC 2
 ?A=C P ç
 {
  %C'est un MP5
  D1=(5)adrgicomp5
 }
 SKELSE
 {
  %Test si c'est un pompe
  LC 1
  ?A=C P ç
  {
   %C'est un pompe
   D1=(5)adrgicopompe
  }
 }
}
SKELSE
{
 %On teste si le j1 utilise son
 %arme secondaire
 LC 1
 ?A=C P ç
 {
  %C'est une arme secondaire
  % => gun
  D1=(5)adrgicogun
 }
 SKELSE
 {
  %On teste s'il utilise son
  %arme 3
  LC 2
  ?A=C P ç
  {
   %Il utilise son arme 3 ç cout
   %eau
   D1=(5)adrgicocouteau
  }
 }
}
D0=(5)AdrSCREEN1 A=DAT0.A
LC 0085A A+C.A
D0=A
A=DAT1 A
B=A A
D1=A
LC 1
D=C P
{
 LC 001
 P=4
 {
  A=0 X
  A=DAT1 B
  A+A X 
  A+A X %On decal de 2 pix pour
  %centrer
  A!C X %Astuce pour pas effacer
  %la ligne de separation
  DAT0=A 3
  D0+34
  D1+2
  P+1
  UPNC
 }
 D1=(5)AdrSCREEN2 A=DAT1.A
 LC 0085A A+C.A
 D1=A
 A=B A
 D1=A
 D-1 P
 UPNC
}
RTN

@