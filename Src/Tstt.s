%Test de touche

*tstt

%On regarde quelle tstt on va
%faire
D0=(5)NBTsttUse A=DAT0.P
?A=0.P SKIPYES
{
 LC 1
 ?C=A.P ç
 {
  %Tstt de menu de dialogue
  GOSUBL tsttmenutalk
  GOSUBL tstpad
  RTN
 }
 SKELSE
 {
  LC 2
  ?C=A.P ç
  {
   %Tstt de console
   GOSUBL tsttconsole
   RTN
  }
  SKELSE
  {
   LC 3
   ?A=C.P ç
   {
    %Tstt du menuchat
    GOSUBL tsttachat
    RTN
   }
   SKELSE
   {
    %Tstt de Free Look Mode
    GOSUBL tsttfreelook
    RTN
   }
  }
 }
}
%Etat de jeu normal

%On va tester le pad
GOSUBL tstpad

%Test straff gauche (VAR)
LC 004
OUT=C
C=IN2
?CBIT=0 7 ç
{
 GOTO .NoStraffG
}
 D0=(5)directj1
 A=DAT0 1
 ?A=0 P ç
 {
  %Test de collision avec les mur
  %s
  %vers la gauche
  GOSUBL tstcolg
  GOSUB resulttstcol
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %Test collision dans les bots
  D0=(5)coordpixj1x A=DAT0.X
  A-1.X
  B=A.X
  D0=(5)coordpixj1y C=DAT0.X
  D=C.X
  GOSUBL TstColJ1Bot
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %On regardes si il ne faut pas
  %decaler l'ecran pour suivre
  %le perso
  GOSUBL tstdecalscrg
  %On efface la derniere position
  %du j1
  GOSUBL effacej1
  %On incremente les coords
  D0=(5)coordpixj1x
  A=DAT0 3
  A-1 X
  DAT0=A 3
  %On recalcule qq coords
  GOSUBL calccoordj1scrjeu
  %On reaffiche le j1 a sa new
  %position
  GOSUB affichej1
 }
 SKELSE
 {
  GOSUB straffg2
 }
*.NoStraffG

%Test straff droite (STO)
LC 002
OUT=C
C=IN2
?CBIT=0 7 ç
{
 GOTO .NoStraffD
}
 D0=(5)directj1
 A=DAT0 1
 ?A=0 P ç
 {
  %Test de collision avec les murs
  %vers la droite
  GOSUBL tstcold
  GOSUB resulttstcol
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %Test collision dans les bots
  D0=(5)coordpixj1x A=DAT0.X
  A+1.X
  B=A.X
  D0=(5)coordpixj1y C=DAT0.X
  D=C.X
  GOSUBL TstColJ1Bot
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %On regardes si il ne faut pas
  %decaler l'ecran pour suivre
  %le perso
  GOSUBL tstdecalscrd
  %On efface la derniere position
  %du j1
  GOSUBL effacej1
  %On incremente les coords
  D0=(5)coordpixj1x
  A=DAT0 3
  A+1 X
  DAT0=A 3
  %On recalcule qq coords
  GOSUBL calccoordj1scrjeu
  %On reaffiche le j1 a sa new
  %position
  GOSUB affichej1
 }
 SKELSE
 {
  GOSUB straffd2
 }
*.NoStraffD

%Test bouge viseur droite
LC 008
OUT=C
C=IN2
?CBIT=1 6 ç
{
 D0=(5)posviseur
 A=DAT0 B
 A=A+1 B
 LC 30
 ?A>C B ç
 {
  LA 01
 }
 DAT0=A B
 %Efface le viseur
 GOSUBL effacevis
 %affichage du viseur
 GOSUBL afficheonlyviseur
}
%Test bouge viseur gauche
LC 010
OUT=C
C=IN2
?CBIT=1 6 ç
{
 D0=(5)posviseur
 A=DAT0 B
 A=A-1 B
 ?A=0 B ç
 {
  LA 30
 }
 DAT0=A B
 %Efface le viseur
 GOSUBL effacevis
 %affichage du viseur
 GOSUBL afficheonlyviseur
}

%Test tir (APPS)
LC 020
OUT=C
C=IN2
?CBIT=1 7 ç
{
 %On lance la routine de traiteme
 %nt d'un nouveau tir
 GOSUBL newtirj1
}

%Test 1 => Menu achat arme prim
LC 008
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %On teste si on est dans une
 %zone d'achat
 A=R0 P
 LC 4
 ?AãC P ç
 {
  EXIT2
 }
 %On est ds 1 zone d'achat
 % => On affiche le menu d'achat
 %des armes primaires
 GOSUBL affmenuachat
 RTN
}

%Test ALPHA => suicide & FreeLook
LC 080
OUT=C
C=IN2
?CBIT=1 3 ç
{
 {
  %Decrementation des vies
  D0=(5)Lifej1
  A=DAT0 B
  LC 01
  SETDEC
  A-C B
  SETHEX
  EXITC
  DAT0=A B
  GOSUBL affvies
  %Wait
  LC 8FF
  {
   C-1 X
   UPNC
  }
  UP
 }
 %Mise en place du FreeLookMode
 GOSUBL SetFreeLook
 RTN
}

%Test recadrage de l'ecran
LC 001
OUT=C
C=IN2
?CBIT=1 7 ç
{
 GOSUBL recadrscr
}

%Test touche de selection de
%l'arme primaire
LC 020
OUT=C
C=IN2
?CBIT=1 0 ç
{
 %On regarde s'il possede une
 %arme primaire
 D0=(5)typeweapprimj1
 C=DAT0 P
 ?C=0 P ç
 {
  EXIT2
 }
 %On coupe tout rechargement
 %de quelque arme
 D0=(5)rechargeweapj1
 C=0 B
 DAT0=C B
 %Il a une arme primaire, on la
 %selectionne
 D0=(5)weapselectj1
 C=0 P
 DAT0=C P
 %On met a jour l'icone de l'arme
 GOSUBL afficoweapec
 %On met a jour la jauge de balle
 GOSUBL affamopoche
 %On met a jour la jauge de balle
 %du chargeur
 GOSUBL affamocharg
}

%Test touche de selection de
%l'arme secondaire
LC 020
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %On coupe tout rechargement
 %de quelque arme
 D0=(5)rechargeweapj1
 C=0 B
 DAT0=C B
 %On select l'arme secondaire
 D0=(5)weapselectj1
 LC 1
 DAT0=C P
 %On met a jour l'icone de l'arme
 GOSUBL afficoweapec
 %On met a jour la jauge de balle
 GOSUBL affamopoche
 %On met a jour la jauge de balle
 %du chargeur
 GOSUBL affamocharg
}

%Test touche de selection de
%l'arme tertiaire
LC 020
OUT=C
C=IN2
?CBIT=1 2 ç
{
 %On coupe tout rechargement
 %de quelque arme
 D0=(5)rechargeweapj1
 C=0 B
 DAT0=C B
 %On select l'arme tertiaire
 D0=(5)weapselectj1
 LC 2
 DAT0=C P
 %On met a jour l'icone de l'arme
 GOSUBL afficoweapec
 %On met a jour la jauge de balle
 GOSUBL affamopoche
 %On met a jour la jauge de balle
 %du chargeur
 GOSUBL affamocharg
}

%Test touche d'achat des munition
%s de l'arme primaire
LC 004
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %On teste si le j1 est dans une
 %zone d'achat
 A=R0 P
 LC 4
 ?AãC P EXIT
 %Test si le j1 a une arme prim
 D0=(5)typeweapprimj1
 A=DAT0 P
 ?A=0 P EXIT %Il en a pas
 %Test si le j1 n'a pas le max
 %de balle possible
 D0=(5)amoj1prim
 A=DAT0 B
 LC 60
 ?AäC B EXIT %Il est au max
 %On teste si le j1 a assez
 %d'argent, et si oui, on enleve
 %4
 D1=(5)argentj1
 C=DAT1 A
 SETDEC
 C-1 A
 SETHEX
 EXITC
 SETDEC
 C-1 A
 SETHEX
 EXITC
 SETDEC
 C-1 A
 SETHEX
 EXITC
 SETDEC
 C-1 A
 SETHEX
 EXITC
 C-1 A
 SETHEX
 EXITC
 DAT1=C A
 %On rajoute une balle
 SETDEC
 A+1 B %Dans Ab on a les balles
 SETHEX
 DAT0=A B %D0=adresse balles
 %On raffraichit le compteur des
 %bales de la statbare
 GOSUBL affamopoche
}

%Test touche d'achat des munition
%s de l'arme secondaire
LC 002
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %On teste si le j1 est dans une
 %zone d'achat
 A=R0 P
 LC 4
 ?AãC P EXIT
 %Test si le j1 n'a pas le max
 %de balle possible
 D0=(5)amoj1second
 A=DAT0 B
 LC 50
 ?AäC B EXIT %Il est au max
 %On teste si le j1 a assez
 %d'argent, et si oui, on enleve
 %2
 D1=(5)argentj1
 C=DAT1 A
 SETDEC
 C-1 A
 SETHEX
 EXITC
 SETDEC
 C-1 A
 SETHEX
 EXITC
 DAT1=C A
 %On rajoute une balle
 SETDEC
 A+1 B
 SETHEX
 DAT0=A B
 %On raffraichit le compteur des
 %balles de la statbare
 GOSUBL affamopoche
}

%Test touche de selection du chat
%(TOOL)
LC 008
OUT=C
C=IN2
?CBIT=1 7 ç
{
 GOSUBL Aff1MenuTalk2Team
}

%Test touche de selection de la
%console (F5)
LC 020
OUT=C
C=IN2
?CBIT=1 4 ç
{
 GOSUBL AffConsole
}

%Test de la touche de rechargemen
%t (F6)
LC 020
OUT=C
C=IN2
?CBIT=1 5 ç
{
 GOSUBL rechargeweap
}

%Test Quit => Menu principal
LC 001
OUT=C
C=IN2
?CBIT=1 6 ç
{
 %On fige un peu l'image
 LC 0F000
 {
  C-1 A
  UPNC
 }
 
 %On fait une jolie transition
 GOSUBL transitionmontectrste

 %Retour au mainmenu
 GOTOL mainmenu
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
 GOSUB Alert
 %Restaure le contraste
 C=R1 P
 D0=00101
 DAT0=C 1
 C=R2 P
 D0=00102
 DAT0=C 1
}

%Test AddBot Terro (*)
LC 001
OUT=C
C=IN2
?CBIT=1 3 ç
{
 ST=0 6 %On indique que le newbot
 %est un Terro
 GOSUBL newbot
}

%Test AddBot Counter (+)
LC 001
OUT=C
C=IN2
?CBIT=1 1 ç
{
 ST=1 6 %On indique que le newbot
 %est un Counter
 GOSUBL newbot
}

%Test Pose bombe (F4)
LC 020
OUT=C
C=IN2
?CBIT=1 3 ç
{
 %On teste si le j1 a la bombe
 D0=(5)stj1
 C=DAT0 P
 ?CBIT=1 3 ç
 {
  %Il a la bombe
  %On teste si il est en zone de
  %C4
  A=R0 P
  LC 5
  ?A=C P ç
  {
   %Il est dans la zone avec la
   %bombe
   %On la lui enleve car il l'a pos
   %Èe
   LA 7
   C&A P
   DAT0=C P
   %On eteint l'indicateur de poss
   %ession de la bombe
   D0=0010B
   A=DAT0 P
   LC E %bit0
   A&C P
   DAT0=A P
   %On active le timer C4
   D0=(5)TimerC4
   LC FF
   DAT0=C B
  }
 }
 SKELSE
 {
  %Fonction de desamorcage
  %...
 }
}

RTN

*resulttstcol

%On gere le resultat du test
%Qui est dans A.p

C=R0 P
%Est ce qu'on est sur une case de
%meme type que l'ancienne
?A=C P ç
{
 %Si oui on fait juste le test 
 %pour voir si on est pas sur
 %uoe case lent
 LC 2
 ?A=C P ç
 {
  ?ST=1 1 ç
  {
   RTNSC
  }
 }
 RTNCC
}

%Mur => quit
LC 1
?A=C P ç
{
 RTNSC
}

%On teste sur quel type de case
%on etait avant
B=A P %On sav la new case
A=R0 P
LC 3
%On etait sur 1 case sombre
?CãA P SKIPYES
{
 %On applique le ctrst que l'ut
 %a choisi pour jouer
 D0=(5)ctrstjeu101
 C=DAT0 1
 D0=00101
 DAT0=C 1
 D0=(5)ctrstjeu102
 C=DAT0 1
 D0=00102
 DAT0=C 1
}
SKELSE
{
 LC 4
 ?AãC P SKIPYES
 {
  %On etait en zone d'achat
  %On eteint l'indic Achat
  D0=0010B
  A=DAT0 1
  LC B %Pour eteindre le bit 2
  A&C P
  DAT0=A 1
 }
 SKELSE
 {
  %On etait dans une zone de pose
  %de bombe
  %On eteint l'indic de cette zon
  %e
  D0=0010C
  A=DAT0 1
  LC D %Pour eteindre le bit 1
  A&C P
  DAT0=A 1
 }
}
A=B P
%Maintenant on va tester quel est
%le type de la nouvelle case ou
%on se trouves
?A=0 P ç
{
 R0=A P
 RTNCC
}
SKELSE
{
 LC 4
 ?AãC P SKIPYES
 {
  R0=A P
  %On est en zone dachat
  %On allume l'indicateur d'achat
  D0=0010B
  A=DAT0 1
  LC 4 %Pour allumer le bit3
  A!C P
  DAT0=A 1
  RTNCC
 }
 SKELSE
 {
  LC 3
  ?AãC P SKIPYES
  {
   R0=A P
   %On est sur une zone sombre
   %Il faut appliquer le contrast
   %sombre
   D0=00101
   LC 4
   DAT0=C 1
   D0=00102
   LC 1
   DAT0=C 1
   RTNCC
  }
  SKELSE
  {
   %Est ce quon est sur une case
   %lente
   LC 2
   ?A=C P ç
   {
    ?ST=1 1 ç
    {
     %Si c pas le bon moment pour
     %bouger alors on quitte
     RTNSC
    }
    R0=A P
    RTNCC
   }
   SKELSE
   {
    R0=A P
    %On est dans une zone de pose
    %de bombe
    %On allume l'indic de cette
    %zone
    D0=0010C
    A=DAT0 1
    LC 2 %Pour allumer le bit 1
    A!C P
    DAT0=A 1
    RTNCC
   }
  }
 }
}

%La nouvelle case ne peut etre
%que un 1
RTNSC %On met le carry a 1 pour
%indiquer que c 1 mur

RTN

*straffg2

  LC 1
  ?A=C P ç
  {
    %Test de collision avec les murs
    %vers le haut
    GOSUB tstcolo
    GOSUB resulttstcol
    %Si ya carry, alors on quitte
    SKNC
    {
     EXIT2
    }
    %Test collision dans les bots
    D0=(5)coordpixj1x A=DAT0.X
    B=A.X
    D0=(5)coordpixj1y C=DAT0.X
    C-1.X
    D=C.X
    GOSUBL TstColJ1Bot
    %Si ya carry, alors on quitte
    SKNC
    {
     EXIT2
    }
    %On regardes si il ne faut pas
    %decaler l'ecran pour suivre
    %le perso
    GOSUBL tstdecalscro
    %On efface la derniere position
    %du j1
    GOSUBL effacej1
    %On incremente les coords
    D0=(5)coordpixj1y
    A=DAT0 3
    A-1 X
    DAT0=A 3
    %On recalcule qq coords
    GOSUBL calccoordj1scrjeu
    %On reaffiche le j1 a sa new
    %position
    GOSUBL affichej1
  }
  SKELSE
  {
    LC 2
    ?A=C P ç
    {
      %Test de collision avec les murs
      %vers la droite
      GOSUB tstcold
      GOSUB resulttstcol
      %Si ya carry, alors on quitte
      SKNC
      {
       EXIT2
      }
      %Test collision dans les bots
      D0=(5)coordpixj1x A=DAT0.X
      A+1.X
      B=A.X
      D0=(5)coordpixj1y C=DAT0.X
      D=C.X
      GOSUBL TstColJ1Bot
      %Si ya carry, alors on quitte
      SKNC
      {
       EXIT2
      }
      %On regardes si il ne faut pas
      %decaler l'ecran pour suivre
      %le perso
      GOSUBL tstdecalscrd
      %On efface la derniere position
      %du j1
      GOSUBL effacej1
      %On incremente les coords
      D0=(5)coordpixj1x
      A=DAT0 3
      A+1 X
      DAT0=A 3
      %On recalcule qq coords
      GOSUBL calccoordj1scrjeu
      %On reaffiche le j1 a sa new
      %position
      GOSUBL affichej1
    }
    SKELSE
    {
      %C'est forcement 3 => bas
      %Test de collision avec les murs
      %vers le bas
      GOSUB tstcolb
      GOSUB resulttstcol
      %Si ya carry, alors on quitte
      SKNC
      {
       EXIT2
      }
      %Test collision dans les bots
      D0=(5)coordpixj1x A=DAT0.X
      B=A.X
      D0=(5)coordpixj1y C=DAT0.X
      C+1.X
      D=C.X
      GOSUBL TstColJ1Bot
      %Si ya carry, alors on quitte
      SKNC
      {
       EXIT2
      }
      %On regardes si il ne faut pas
      %decaler l'ecran pour suivre
      %le perso
      GOSUBL tstdecalscrb
      %On efface la derniere position
      %du j1
      GOSUBL effacej1
      %On incremente les coords
      D0=(5)coordpixj1y
      A=DAT0 3
      A+1 X
      DAT0=A 3
      %On recalcule qq coords
      GOSUBL calccoordj1scrjeu
      %On reaffiche le j1 a sa new
      %position
      GOSUBL affichej1
    }
  }

RTN

*straffd2

LC 1
?A=C P ç
{
 %Test de collision avec les murs
 %vers le bas
 GOSUB tstcolb
 GOSUB resulttstcol
 %Si ya carry, alors on quitte
 SKNC
 {
  EXIT2
 }
 %Test collision dans les bots
 D0=(5)coordpixj1x A=DAT0.X
 B=A.X
 D0=(5)coordpixj1y C=DAT0.X
 C+1.X
 D=C.X
 GOSUBL TstColJ1Bot
 %Si ya carry, alors on quitte
 SKNC
 {
  EXIT2
 }
 %On regardes si il ne faut pas
 %decaler l'ecran pour suivre
 %le perso
 GOSUBL tstdecalscrb
 %On efface la derniere position
 %du j1
 GOSUBL effacej1
 %On incremente les coords
 D0=(5)coordpixj1y
 A=DAT0 3
 A+1 X
 DAT0=A 3
 %On recalcule qq coords
 GOSUBL calccoordj1scrjeu
 %On reaffiche le j1 a sa new
 %position
 GOSUBL affichej1
}
SKELSE
{
 LC 2
 ?A=C P ç
 {
  %Test de collision avec les murs
  %vers la gauche
  GOSUB tstcolg
  GOSUB resulttstcol
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %Test collision dans les bots
  D0=(5)coordpixj1x A=DAT0.X
  A-1.X
  B=A.X
  D0=(5)coordpixj1y C=DAT0.X
  D=C.X
  GOSUBL TstColJ1Bot
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %On regardes si il ne faut pas
  %decaler l'ecran pour suivre
  %le perso
  GOSUBL tstdecalscrg
  %On efface la derniere position
  %du j1
  GOSUBL effacej1
  %On incremente les coords
  D0=(5)coordpixj1x
  A=DAT0 3
  A-1 X
  DAT0=A 3
  %On recalcule qq coords
  GOSUBL calccoordj1scrjeu
  %On reaffiche le j1 a sa new
  %position
  GOSUBL affichej1
 } SKELSE
 {
  %C'est forcement 3 => haut
  %Test de collision avec les murs
  %vers le haut
  GOSUB tstcolo
  GOSUB resulttstcol
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %Test collision dans les bots
  D0=(5)coordpixj1x A=DAT0.X
  B=A.X
  D0=(5)coordpixj1y C=DAT0.X
  C-1.X
  D=C.X
  GOSUBL TstColJ1Bot
  %Si ya carry, alors on quitte
  SKNC
  {
   EXIT2
  }
  %On regardes si il ne faut pas
  %decaler l'ecran pour suivre
  %le perso
  GOSUB tstdecalscro
  %On efface la derniere position
  %du j1
  GOSUBL effacej1
  %On incremente les coords
  D0=(5)coordpixj1y
  A=DAT0 3
  A-1 X
  DAT0=A 3
  %On recalcule qq coords
  GOSUBL calccoordj1scrjeu
  %On reaffiche le j1 a sa new
  %position
  GOSUBL affichej1
 }
}

RTN

*tstpad

%Test fleche haut

LC 040
OUT=C
C=IN2
?CBIT=0 3 ç
{
 GOTO .NoFlechO
}
 %Test de collision avec les murs
 %vers le haut
 GOSUB tstcolo
 GOSUB resulttstcol
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Test collision dans les bots
 D0=(5)coordpixj1x A=DAT0.X
 B=A.X
 D0=(5)coordpixj1y C=DAT0.X
 C-1.X
 D=C.X
 GOSUB TstColJ1Bot
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Je mets la direction du joueur
 %vers le haut, et on positionne
 %le viseur vers le haut au milie
 %u si le j1 n'etait pas deja
 %en train de regarder vers le ha
 %ut
 D0=(5)directj1
 C=DAT0 P
 ?Cã0 P ç
 {
  D1=(5)posviseur
  LC 04
  DAT1=C B
  A=0 P
  DAT0=A 1
 }
 %On regardes si il ne faut pas
 %decaler l'ecran pour suivre
 %le perso
 GOSUB tstdecalscro
 %On efface la derniere position
 %du j1
 GOSUBL effacej1
 %On incremente les coords
 D0=(5)coordpixj1y
 A=DAT0 3
 A-1 X
 DAT0=A 3
 %On recalcule qq coords
 GOSUBL calccoordj1scrjeu
 %On reaffiche le j1 a sa new
 %position
 GOSUBL affichej1
 %On quite le test pad
 RTN
*.NoFlechO

%Test fleche bas

LC 040
OUT=C=IN
?CBIT=0 1 ç
{
 GOTO .NoFlechB
}
 %Test de collision avec les murs
 %vers le bas
 GOSUB tstcolb
 GOSUB resulttstcol
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Test collision dans les bots
 D0=(5)coordpixj1x A=DAT0.X
 B=A.X
 D0=(5)coordpixj1y C=DAT0.X
 C+1.X
 D=C.X
 GOSUB TstColJ1Bot
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Je mets la direction du joueur
 %vers le bas, et on positionne
 %le viseur vers le haut au milie
 %u si le j1 n'etait pas deja
 %en train de regarder vers le ba
 %s
 D0=(5)directj1
 A=DAT0 P
 LC 2
 ?AãC P ç
 {
  DAT0=C 1
  D1=(5)posviseur
  LC 1C
  DAT1=C B
 }
 %On regardes si il ne faut pas
 %decaler l'ecran pour suivre
 %le perso
 GOSUB tstdecalscrb
 %On efface la derniere position
 %du j1
 GOSUBL effacej1
 %On incremente les coords
 D0=(5)coordpixj1y
 A=DAT0 3
 A+1 X
 DAT0=A 3
 %On recalcule qq coords
 GOSUBL calccoordj1scrjeu
 %On reaffiche le j1 a sa new
 %position
 GOSUBL affichej1
 %On quite le test pad
 RTN
*.NoFlechB

%Test fleche gauche

LC 040
OUT=C=IN
?CBIT=0 2 ç
{
 GOTO .NoFlechG
}
 %Test de collision avec les murs
 %vers la gauche
 GOSUB tstcolg
 GOSUB resulttstcol
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Test collision dans les bots
 D0=(5)coordpixj1x A=DAT0.X
 A-1.X
 B=A.X
 D0=(5)coordpixj1y C=DAT0.X
 D=C.X
 GOSUB TstColJ1Bot
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Je mets la direction du joueur
 %vers la g, et on positionne
 %le viseur vers le haut au milie
 %u si le j1 n'etait pas deja
 %en train de regarder vers la ga
 %uche
 D0=(5)directj1
 A=DAT0 P
 LC 3
 ?AãC P ç
 {
  DAT0=C 1
  D1=(5)posviseur
  LC 29
  DAT1=C B
 }
 %On regardes si il ne faut pas
 %decaler l'ecran pour suivre
 %le perso
 GOSUBL tstdecalscrg
 %On efface la derniere position
 %du j1
 GOSUBL effacej1
 %On incremente les coords
 D0=(5)coordpixj1x
 A=DAT0 3
 A-1 X
 DAT0=A 3
 %On recalcule qq coords
 GOSUBL calccoordj1scrjeu
 %On reaffiche le j1 a sa new
 %position
 GOSUBL affichej1
 %On quite le test pad
 RTN
*.NoFlechG

%Test fleche droite

LC 040
OUT=C=IN
?CBIT=0 0 ç
{
 GOTO .NoFlechD
}
 %Test de collision avec les murs
 %vers la droite
 GOSUB tstcold
 GOSUB resulttstcol
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Test collision dans les bots
 D0=(5)coordpixj1x A=DAT0.X
 A+1.X
 B=A.X
 D0=(5)coordpixj1y C=DAT0.X
 D=C.X
 GOSUB TstColJ1Bot
 %Si ya carry, alors on quitte
 SKNC
 {
  %On quitte le teste pad => 2e
  %RTN
  C=RSTK
  RTN
 }
 %Je mets la direction du joueur
 %vers la d, et on positionne
 %le viseur vers le haut au milie
 %u si le j1 n'etait pas deja
 %en train de regarder vers la dr
 %oite
 D0=(5)directj1
 A=DAT0 P
 LC 1
 ?AãC P ç
 {
  DAT0=C 1
  D1=(5)posviseur
  LC 0F
  DAT1=C B
 }
 %On regardes si il ne faut pas
 %decaler l'ecran pour suivre
 %le perso
 GOSUBL tstdecalscrd
 %On efface la derniere position
 %du j1
 GOSUBL effacej1
 %On incremente les coords
 D0=(5)coordpixj1x
 A=DAT0 3
 A+1 X
 DAT0=A 3
 %On recalcule qq coords
 GOSUBL calccoordj1scrjeu
 %On reaffiche le j1 a sa new
 %position
 GOSUBL affichej1
 %On quite le test pad
 RTN
*.NoFlechD

RTN

*Alert

 %On monte le ctrst a fond
 D0=00101
 LC 1
 DAT0=C 1
 D0=00102
 LC E
 A=DAT0 P
 A&C P
 DAT0=A 1
 %On attends un appuis sur Lshift
 %pour ensuite continuer le jeu
 {
  LC 080
  OUT=C
  C=IN2
  ?CBIT=1 2 ç
  {
   EXIT2
  }
  UP
 }

RTN

@