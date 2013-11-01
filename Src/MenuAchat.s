%Le menu d'achat
%Par Nicolas (Lord_Demos)

*affmenuachat

GOSBVL Flush

%On decremente le ralentissement
LC 00100
GOSUBL Decrralentissement

%Mise en mem de l'ancienne arme,
%au cas ou on quitte le menu
D0=(5)typeweapprimj1
A=DAT0 P
D0=(5)savtypeweapprimj1
DAT0=A P

%Init endroit de debut du surlign
%age
LC 823C3
?ST=1 0 ç
{
 LA 01100
 C+A A
}
D0=(5)mnaR3 DAT0=C.A R3=C.A
D0=(5)mnaR4 DAT0=C.A

D0=(5)typeweapprimj1
LC 1
DAT0=C P

?ST=1 0 SKIPYES
{
 D0=(5)AdrSCREEN1 A=DAT0.A
 D0=A
}
SKELSE
{
 D0=(5)AdrSCREEN2 A=DAT0.A
 D0=A
}
D1=(5)adrMnAchat
C=DAT1 A
D1=C

%Init compteur
P=0
LC 7F
D=C B
P=13
%bcl d'aff du menu
{
 C=DAT1 WP 
 DAT0=C WP
 D1+14
 D0+34
 D-1 B
 UPNC
}

P=0

%On affiche les decors qui entour
%ent les prix, l'argent, et le
%menu de confirmation

?ST=1 0 SKIPYES
{
 D0=(5)AdrSCREEN1 A=DAT0.A
 LC 00A26 A+C.A
 D0=A
}
SKELSE
{
 D0=(5)AdrSCREEN2 A=DAT0.A
 LC 00A26 A+C.A
 D0=A
}
D1=(5)adrgmnaentourprix
C=DAT1 A
D1=C
A=D0

%Init compteur
LC 19
D=C B
P=7
%bcl d'aff du decor
{
 C=DAT1 WP
 DAT0=C WP
 D1+8
 D0+34
 D-1 B
 UPNC
}
P=0
%Init de l'affichage du 2eme
%decor
D1=(5)adrgmnaentourprix
C=DAT1 A
D1=C
A+8 A %On se place a cote sur la
%droite
D0=A

%Init compteur
LC 19
D=C B
P=7
%bcl d'aff du decor2
{
 C=DAT1 WP
 DAT0=C WP
 D1+8
 D0+34
 D-1 B
 UPNC
}
P=0

%On affiche le menu de confirmati
%on

D1=(5)adrgmnaconfirm
C=DAT1 A
D1=C
LC 0036C
A+C A %On se place au bon endroit
%pour afficher
D0=A

%Init compteur
LC 19
D=C B
%bcl d'aff du menu de confirmatio
%n
{
 C=DAT1 W
 DAT0=C W
 D1+16
 D0+34
 D-1 B
 UPNC
}

%On affiche l'argent que possede
%le j1
D0=(5)argentj1
A=DAT0 A
%1er chiffre
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B43 A+C.A
D1=A
GOSUBL affnballscrminifont
%2nd chiffre
A=R2 A
ASR A
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B42 A+C.A
D1=A
GOSUBL affnballscrminifont
%3e chiffre
A=R2 A
ASR A
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B41 A+C.A
D1=A
GOSUBL affnballscrminifont
%4e chiffre
A=R2 A
ASR A
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B40 A+C.A
D1=A
GOSUBL affnballscrminifont
%5e chiffre
%A=R2 A
%ASR A
%R2=A A
%D1=82DF1
%GOSUBL affnb

%On inverse le 1er choix, sinan
%ca merde
LA 15
P=11
C=R3 A
D0=C 
{
 C=DAT0 WP
 C=-C-1 WP
 DAT0=C WP
 D0+34
 A-1 B
 UPNC
}
P=0

%On affiche le prix de la 1ere
%arme parce qu'elle ne s'affiche
%pas automatiquement a l'appariti
%on du menu d'achat

LA 3000
GOSUB affprixweap

%On init R1.p a 0 pour kil y ait
%un refresh du mna
D0=(5)mnaR1 C=0.P DAT0=C.P

%On indique que le test de touche
%doit etre celui de menu dachat
D0=(5)NBTsttUse LC 3 DAT0=C.P
%Interdiction Aff j1 bots level
%impacts
C=0.P
D0=(5)YNAffJ1 DAT0=C.P
D0=(5)YNAffBots DAT0=C.P
D0=(5)YNAffLevel DAT0=C.P
D0=(5)YNAffImpacts DAT0=C.P

RTN

*chc
P=0
C=R3 A
R4=C A
D0=(5)typeweapprimj1
C=DAT0 P
LA 1
?C=A P ç
{
 D1=(5)AdrSCREEN1 A=DAT1.A
 LC 00111 A+C.A
 ?ST=1 0 ç
 {
  LC 01100
  A+C A
 }
 R3=A A
 %Affichage du prix de l'arme
 LA 3000
 GOSUB affprixweap
 RTN
}
SKELSE
{
 LA 2
 ?C=A P ç
 {
  D1=(5)AdrSCREEN1 A=DAT1.A
  LC 003FD A+C.A
  ?ST=1 0 ç
  {
   LC 01100
   A+C A
  }
  R3=A A
  %Affichage du prix de l'arme
  LA 3500
  GOSUB affprixweap
  RTN
 }
 SKELSE
 {
  LA 3
  ?C=A P ç
  {
   D1=(5)AdrSCREEN1 A=DAT1.A
   LC 006E9 A+C.A
   ?ST=1 0 ç
   {
    LC 01100
    A+C A
   }
   R3=A A
   %Affichage du prix de l'arme
   LA 0000
   GOSUB affprixweap
   RTN
  }
  SKELSE
  {
   LA 4
   ?C=A P ç
   {
    D1=(5)AdrSCREEN1 A=DAT1.A
    LC 009D5 A+C.A
    ?ST=1 0 ç
    {
     LC 01100
     A+C A
    }
    R3=A A
    %Affichage du prix de l'arme
    LA 0000
    GOSUB affprixweap
    RTN
   }
   SKELSE
   {
    LA 5
    ?C=A P ç
    {
     D1=(5)AdrSCREEN1 A=DAT1.A
     LC 00CC1 A+C.A
     ?ST=1 0 ç
     {
      LC 01100
      A+C A
     }
     R3=A A
     %Affichage du prix de l'arme
     LA 0000
     GOSUB affprixweap
     RTN
    }
   }
  }
 }
}
RTN

*inv4
C=R4 A
D0=C 
{
 C=DAT0 WP
 C=-C-1 WP
 DAT0=C WP
 D0+34
 A-1 B
 UPNC
}
RTN

*inv3
C=R3 A
D0=C 
{
 C=DAT0 WP
 C=-C-1 WP
 DAT0=C WP
 D0+34
 A-1 B
 UPNC
}
RTN

%Test de touche
*tsttachat

%Gestion des touches
%On recharge R1.p R3.a et R4.a
D0=(5)mnaR3 C=DAT0.A R3=C.A
D0=(5)mnaR4 C=DAT0.A R4=C.A
D0=(5)mnaR1 C=DAT0.P R1=C.P

?C=0 P ç
{
 GOSUB chc
 LA 15
 P=11
 GOSUB inv4
 P=0
 LA 15
 P=11
 GOSUB inv3
 P=0
}

%Tstt

LC 1
R1=C P
%Test fleche haut
LC 040
OUT=C
C=IN2
?CBIT=1 3 ç
{
 C=0 P
 R1=C P
 D0=(5)typeweapprimj1
 C=DAT0 P
 C-1 P
 ?C=0 P ç
 {
  LC 5
 }
 DAT0=C P
}
%Test fleche bas
LC 040
OUT=C
C=IN2
?CBIT=1 1 ç
{
 C=0 P
 R1=C P
 D0=(5)typeweapprimj1
 C=DAT0 P
 C+1 P
 LA 6
 ?C=A P ç
 {
  LC 1
 }
 DAT0=C P
}
%Test annuler => F4
LC 020
OUT=C
C=IN2
?CBIT=1 3 ç
{
 D0=(5)savtypeweapprimj1
 A=DAT0 P
 D0=(5)typeweapprimj1
 DAT0=A P
 GOTO mna2game
}

%Test valider => F5
LC 020
OUT=C
C=IN2
?CBIT=1 4 ç
{
 %On verifie si l'arme voulue
 %est programmee (seul 1 et 2),
 %et si elle l'est on regarde si
 %le j1 a assez d'argent
 GOSUB verifachat
 %On mets les balles de l'arme
 %achetee a 00
 D0=(5)amoj1prim
 C=0 B
 DAT0=C B
 %On mets les balles de l'arme
 %achetee a 00 (chargeur)
 D0=(5)amochargj1prim
 C=0 B
 DAT0=C B
 %On met a jour l'icone de l'arme
 GOSUBL afficoweapec
 %On met a jour la jauge de balle
 GOSUBL affamopoche
 %On met a jour la jauge de balle
 %du chargeur
 GOSUBL affamocharg
 GOTO mna2game
}

%Test Alert => Ctrst haut
LC 080
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %Sauvegarde du contrast en cours
 D0=00101
 C=DAT0 P
 R1=C P
 D0=00102
 C=DAT0 P
 R2=C P
 GOSUBL Alert
 %Restaure le contraste
 C=R1 P
 D0=00101
 DAT0=C 1
 C=R2 P
 D0=00102
 DAT0=C 1
}

%Test Quitter => DROP
LC 001
OUT=C
C=IN2
?CBIT=1 6 ç
{
 GOTOL mainmenu
}

%Sav R1.p R3.a et R4.a
C=R3.A D0=(5)mnaR3 DAT0=C.A
C=R4.A D0=(5)mnaR4 DAT0=C.A
C=R1.P D0=(5)mnaR1 DAT0=C.P

RTN

*mna2game
GOSUBL refrscr
GOSUBL affichej1
%On se met en etat de jeu
D0=(5)NBTsttUse C=0.P DAT0=C.P
LC 1
D0=(5)YNAffJ1 DAT0=C.P
D0=(5)YNAffBots DAT0=C.P
D0=(5)YNAffLevel DAT0=C.P
D0=(5)YNAffImpacts DAT0=C.P
RTN

%Annulation d'un achatet relancem
%ent du menu d'achat, pour cause
%d'arme pas programmee ou de
%manque d'argent
*annulachat

% => restaure arme en cours
D0=(5)savtypeweapprimj1
A=DAT0 P
D0=(5)typeweapprimj1
DAT0=A P
% => Preparation pour relancer
%    le menu d'achat
GOSUBL refrscr
GOSUBL affichej1
C=RSTK C=RSTK %2 level + o
% => reaff le menu d'achat
GOTO affmenuachat

%On verifie si l'arme voulue
%est programmee (seul 1 et 2),
%et si elle l'est on regarde si
%le j1 a assez d'argent
*verifachat

 D0=(5)typeweapprimj1
 A=DAT0 P
 LC 1
 ?A=C P ç
 {
  %Arme: pompe
  %test argent
  D0=(5)argentj1
  A=DAT0 A
  LC 03000
  %test argent
  ?A<C A ç annulachat
  SETDEC
  A-C A
  SETHEX
  DAT0=A A
 }
 SKELSE
 {
  LC 2
  ?A=C P ç
  {
   %Arme: mp5
   %test argent
   D0=(5)argentj1
   A=DAT0 A
   LC 03500
   %Test argent
   ?A<C A ç annulachat
   SETDEC
   A-C A
   SETHEX
   DAT0=A A
  }
  SKELSE
  {
   %L'arme n'est pas programmee
   % => On annule et on relance
   %le menu d'achat
   GOTO annulachat
  }
 }
 
RTN

%Affichage du prix de l'arme qui
%est dans A.3
*affprixweap

%1er chiffre
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B3B A+C.A
D1=A
GOSUBL affnballscrminifont
%2e chiffre
A=R2 A
ASR A
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B3A A+C.A
D1=A
GOSUBL affnballscrminifont
%3e chiffre
A=R2 A
ASR A
R2=A A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B39 A+C.A
D1=A
GOSUBL affnballscrminifont
%4e chiffre
A=R2 A
ASR A
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00B38 A+C.A
D1=A
GOSUBL affnballscrminifont

RTN

@