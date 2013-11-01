%Menu principal, qui contient
%le choix du level, les options,
%et plein d'autres choses :)

*mainmenu

%On eteint tt les indicateurs
D0=0010B
C=0 P
DAT0=C P
D0=0010C
LC C
A=DAT0 P
C&A P
DAT0=C P

%On se place sur le 1er ecran
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

%Effacage de tt lecrao de jeu

D0=(5)AdrSCREEN1 A=DAT0.A D0=A
A=0 W
LC 10F
{
 DAT0=A W
 D0+ 16
 C-1 X
 UPNC
}

%On recopie la jolie image de fon
%d logocs2dmainmenu sur lecran
%(On copie le foncÈ du logo sur
%le clair de lecran, et sans les
%10 lignes du bas)
D0=(5)adrLogoCs
A=DAT0.A
D0=A
D1=(5)AdrSCREEN2 A=DAT1.A D1=A
LC 35 %64d - 10d - 1
{
 A=DAT0.16 DAT1=A.16
 D0+16 D1+16
 A=DAT0.16 DAT1=A.16
 D0+16 D1+16
 A=DAT0.B DAT1=A.B
 D0+36 D1+36
 C-1.B
 UPNC
}

%On va marquer 'Quit'
%en bas a gauche de l'ecran
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00F25 A+C.A D1=A
LC 0000000074697551
B=C W
GOSUBL affcharscr1font6
%On va marquer 'Perso'
%en bas au milieu de l'ecran
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00F30 A+C.A D1=A
LC 0000006F73726550
B=C W
GOSUBL affcharscr1font6
%On va marquer 'Jeu'
%en bas a droite de l'ecran
D1=(5)AdrSCREEN1 A=DAT1.A
LC 00F3D A+C.A D1=A
LC 000000000075654A
B=C W
GOSUBL affcharscr1font6

%On fait une jolie transition en
%restaurant le contraste de jeu
D0=(5)ctrstjeu101
A=DAT0.P B=A.P
D0=(5)ctrstjeu102
A=DAT0.S B=A.S
GOSUBL transitionbaissectrste

%On met le cache de la derniere
%tche a 0 et le flag d'appuis
%de touche a 0
D=0 P
ST=0 11

%Wait
{
 %Test ctrst + foncÈ
 LC 001
 OUT=C
 C=IN2
 ?CBIT=1 1 ç
 {
  ST=1 11
  LC 2
  ?C=D P ç
  {
   EXIT2
  }
  D=C P
  D0=00101
  A=DAT0 P
  A+1 P
  SKNC
  {
   D0=00102
   A=DAT0.P
   ?Aã0.P ç
   {
    EXIT2
   }
   D1=00101
   C=0.P
   DAT1=C.P
   A+1.P
   DAT0=A.P
  }
  DAT0=A P
 }
 %Test ctrst + clair
 LC 001
 OUT=C
 C=IN2
 ?CBIT=1 2 ç
 {
  ST=1 11
  LC 3
  ?C=D P ç
  {
   EXIT2
  }
  D=C P
  D0=00101
  A=DAT0 P
  A-1 P
  SKNC
  {
   D0=00102
   A=DAT0.P
   ?A=0.P ç
   {
    EXIT2
   }
   D1=00101
   LC F
   DAT1=C.P
   A-1.P
   DAT0=A.P
  }
  DAT0=A P
 }
 %Test Start partie CT (F6)
 LC 020
 OUT=C
 C=IN2
 ?CBIT=1 5 ç
 {
  %On met le j1 en CT, actif et
  %vivant
  D0=(5)stj1
  LC 7
  DAT0=C P
  %Oo mets 0 terro et 1 CT
  D0=(5)nbT
  LC 0
  DAT0=C P
  D0=(5)nbCT
  LC 1
  DAT0=C P
  EXIT2
 }
 %Test Start partie T (F5)
 LC 020
 OUT=C
 C=IN2
 ?CBIT=1 4 ç
 {
  %Oo met le j1 en T, actif et
  %vivant, et avec la bombe
  D0=(5)stj1
  LC B
  DAT0=C P
  %On active l'indicateur de poss
  %ession de la bombe
  D0=0010B
  A=DAT0 P
  LC 1
  A!C P
  DAT0=A P
  %On mets 1 terro et 0 cT
  D0=(5)nbT
  LC 1
  DAT0=C P
  D0=(5)nbCT
  LC 0
  DAT0=C P
  EXIT2
 }
 %Test QUIT (F1)
 LC 020
 OUT=C
 C=IN2
 ?CBIT=1 0 ç
 {
  GOTOL FIN
 }
 ?CBIT=1 1 ç
 {
  GOTOL FIN
 }
 %Si on a pas appuyÈ sur 1 tche
 %alors on met le cache des tches
 %a 0
 ?ST=1 11 SKIPYES
 {
  D=0 P
 }
 ST=0 11
 UP
}

LC 0AAAA
{
 C-1 A
 UPNC
}

%On sauve le contrast actuel
%comme contrast de jeu
GOSUBL SavCtrstJeu

%On va chercher le oiveau choisi
GOSUBL recupniveaudemo001
%Oo demarre la partie
GOTOL begingame

@