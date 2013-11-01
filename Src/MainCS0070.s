!RPL !NO CODE 
::
TURNMENUOFF
CODE 

%-------------------------------
% Counter Strike 2d pour HP49
%         version 0070
% Par Laurent GHIGONIS (lolmax)
%   lolmax@free.fr 0622729017
%       calcarena.free.fr
%-------------------------------

%Activation du deboggeur
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%! A NE PAS ATTACHER SI LE JEU  !
%! DOIT ETRE UTILIS… SUR UNE HP !
%! QUI N'A PAS LE DEBOGGEUR     !
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%En cas d'utilisation, virer le
%SAVE placÈ juste avant de sav D1
'AsmDebug49.s

SETHEX
!0-15

%Sav reg
%SAVE

%On sav D1 (qui pointe sur le lev
%el 1 de la pile), afin de pouvoi
%r ensuite recuperer les donnees
%qui st sur la pile RPL
CP=822B2
DCCP 5 adrpile
%On restaure les regs pour pouvoi
%r recuperer D1
LOAD
%Recup D1
D0=(5)adrpile
CD1EX
DAT0=C.A

%Ici je met des sources qui provo
%quent des JumpTooLong si je les
%lient a la fin du prog
GOTOL finzoneattachs1
 %Init vars
 'Initvars.s
 
 %Recup de l'adresses des differen
 %ts fichiers (grobs,dbb...)
 'Includefiles.s
*finzoneattachs1

*INITIALISATION

CP=80319
DCCP 5 SAV_SCR

CP=8069C
DCCP 1 GreyOn?
DCCP 5 GreyScr1
DCCP 5 GreySoft1
DCCP 5 GreyScr2
DCCP 5 GreySoft2
DCCP 5 GreyScr3
DCCP 5 GreySoft3

DC Disp1Ctl 8068D
DC Disp2Ctl 80695

%------------------
%INITIALISATION CS
%------------------

%Reserv vars
'Reservvars.s

GOSUBL includefiles

%Sauvegarde du contrast de l'util
%isateur, en vue de le restaurer
%quand il quitte le prog
D0=00101
C=DAT0 P
D0=(5)ctrstuser101
DAT0=C P
D0=00102
C=DAT0 P
D0=(5)ctrstuser102
DAT0=C P

%On fait une jolie transition
GOSUBL transitionmontectrste

%Init marge droite pque ya 1 scr
%a sauter pour chq ligne
LC 022
D0=00125
DAT0=C X

%Fin INIT CS

%----------------
% INITIALISATION
%----------------

  %------------- 
  % LOAD SCREEN
  %-------------
  GOSBVL "D0->Row1"
  D1=(5)SAV_SCR
  CD0EX
  DAT1=C.A


  %-- INIT   
  D0=(5)AdrSCREEN1
  C=DAT0.A
  D1=(5)GreyScr1
  DAT1=C A
  D1=(5)GreyScr2
  DAT1=C A
  D1=(5)GreyScr3
  D0=(5)AdrSCREEN2
  C=DAT0.A
  DAT1=C A

  D0=(5)Disp2Ctl
  A=DAT0 A
  D1=(5)GreySoft1
  DAT1=A A
  D1=(5)GreySoft2
  DAT1=A A
  D1=(5)GreySoft3
  DAT1=A A

CP=8069D
DCCP 5 IGreyScr1
DCCP 5 NOTUSED
DCCP 5 IGreyScr2

CP=80419
DCCP 8 SAV_TIMER
DCCP 10 COUNT_IT
DCCP 16 SAV_IT

%'IntGreyOn.s

%Desactivation du sablier
D1=0010C
C=DAT1.1
CBIT=0.0
DAT1=C.1

%On aff le jeu meme qd les levels
%de grs sont pas actives (pour
%pouvoir aff DISKEY çd debug)
D0=00120
D1=(5)AdrSCREEN1
C=DAT1.A
DAT0=C A

%On se met sur l'ecran 1
ST=0 0

%On execute la peresentation
GOSUBL Presentation

%On fait une jolie transition
GOSUBL transitionmontectrste

%On va au menu principal
GOTOL mainmenu

*begingame

%On sauve le contrast actuel
%comme contrast de jeu
GOSUBL SavCtrstJeu

%On fait une jolie transition
GOSUBL transitionmontectrste

GOSUBL initvars

%Effacage de tt lecran de jeu

D0=(5)AdrSCREEN1
A=DAT0.A D0=A
A=0 W
LC 10F
{
 DAT0=A W
 D0+ 16
 C-1 X
 UPNC
}
D0=(5)AdrSCREEN2
A=DAT0.A D0=A
A=0 W
LC 10F
{
 DAT0=A W
 D0+ 16
 C-1 X
 UPNC
}

%Calcul de qq coords
GOSUBL calccoordj1scrjeu

%Affichage du niveau
GOSUB refrscr

%On aff le j1
GOSUBL affichej1

%On affiche la statbar
GOSUBL affstatbar

%On fait une jolie transition en
%restaurant le contraste de jeu
D0=(5)ctrstjeu101
A=DAT0.P B=A.P
D0=(5)ctrstjeu102
A=DAT0.S B=A.S
GOSUBL transitionbaissectrste

%-------------------
% Boucle principale
%-------------------


*MAINBCL

%On met le ralentissement a
%#1900h, ce qui sera decrementÈ
%suivant le nb de taches a faire
D0=(5)Ralentissement
LC 01900
DAT0=C A

%On verifie quon est bien en etat
%de jeu OU menutalk
D0=(5)YNAffLevel
A=DAT0.P
?A=0.P SKIPYES
{
 %Si il fo decal lecrao vers le o
 ?ST=1 2 ç
 {
  %Alors on le decal
  GOSUBL decalscro
 }

 %Si il fo decal lecran vers le b
 ?ST=1 3 ç
 {
  %Alors on le decal
  GOSUBL decalscrb
 }

 %Si il fo decal lecran vers la
 %gauche
 ?ST=1 4 ç
 {
  %Alors on le decal
  GOSUBL decalscrg
 }

 %Si il fo decal lecran vers la
 %droite
 ?ST=1 5 ç
 {
  %Alors on le decal
  GOSUBL decalscrd
 }
}

GOSUBL tstt

%On gere la gestion du deplacemen
%t des bots
GOSUBL gestdeplacementbots

%On teste si un rechargement est
%En Cours (pour le j1)
D0=(5)rechargeweapj1
A=DAT0 B
?Aã0 B ç
{
 GOSUBL rechargeweapec
}

%Gestion de l'effacage de l'impa
%ct des balles
%On regarde si un impact est actu
%ellement affiche, dans la 1ere
%case du tableau d'impact, ou
%dans la 2eme,  suivant le flag
%d'etat
%Test si aff impact = 1
D0=(5)YNAffImpacts
A=DAT0.P
?A=0.P SKIPYES
{
 ?ST=0 1 ç
 {
  D0=(5)compteurtabimpactsballe0j1
  D1=(5)adrtabimpactsballe0j1
 }
 SKELSE
 {
  D0=(5)compteurtabimpactsballe1j1
  D1=(5)adrtabimpactsballe1j1
 }
 C=DAT0 B
 ?Cã0 B ç
 {
  GOSUBL gesteffimpactballej1
 }
}

%On regarde si la bombe a ÈtÈ pos
%˘e
D0=(5)TimerC4
A=DAT0 B
?Aã0 B ç
{
 %Elle a ÈtÈ posÈe
 %On dimioue le timer de 1
 A-1 B
 DAT0=A B
 A-1 B %Pour que la bombe explose
 %a 1 et pas a 0
 SKIPNC
 {
  %Si le timer est a 0, la bombe
  %explose de les T ont gagnÈs
  GOTOL Presentation
 }
}

%Routine de gestion des tirs
%Test si il y a au moin un tir
%en cours
D0=(5)nbtirecj1
A=DAT0 P
?Aã0 P ç
{
 %On saute a la routine de gest
 %ion des tirs
 GOSUBL gesttirs
}

%Wait
D0=(5)Ralentissement
C=DAT0 A
{
 C-1 A
 UPNC
}

%On change d'etat le flag d'etat
?ST=1 1 SKIPYES
{
 ST=1 1
}
SKELSE
{
 ST=0 1
}

GOTO MAINBCL

%Refresh entier de lecran
'Refreshscr.s

%Calcul des coordonnÈs du j1
%sur lecran de jeu et lecran
%de fond
'Calccoordj1.s

%Effacage de lecran a lendroit
%ou etait le joueur en y aff
%le fond sauvegardÈ
'Effacej1.s

%Routines diverses (aff d'un
%char...)
'Routines.s

%Tirs
'Tirs.s

%Routine daff d1 grob 4grs + msq
%En entrelace
'Affj1.s

%Test de touche
'Tstt.s

%Test de collision
'Tstcollision.s

%Si le joueur a bougÈ,il fo verif
%kil ne soit pas hors de lecran,
%et dans ce cas il faut decaler
%lecran sur la bdd,en verifiant
%si on est pas o bord du nivo
'Decalscr.s

%Routines de Debuggage du jeu
'Debug.s

%Les menus d'achat
%Par Nicolas (Lord_Demos)
'MenuAchat.s

%Affichage de la barre de gauche,
%qui contient les viees ./.
'Statbar.s

%Gere l'adaptation de la bcl de
%ralentissement en fct de ce que
%l'on fait
'Ralentissement.s

%Presentation (Anim,ecran intro)
'Presentation.s

%Menu Principal
'MainMenu.s

%Gestion du deplacement des bots
%actifs
'GestDeplacementBots.s

%Routine concernant certaines
%fct des bots (ajout, suppression
%)
'RoutinesBots.s

%Tout ce qui concerne le dialogue
%Permet de donner des ordres aux
%bots, de leur 'parler'
'MenuTalk.s

%Tout ce qui concerne la console
%et lafficheur de message sur le
%haut de lecran
'Console.s

%Tout ce qui concerne le FreeLook
%Mode
'FreeLook.s

%|--------|
%| FIN CS |
%|--------|

%----
*FIN
%----

%On fait une jolie transition
GOSUBL transitionmontectrste

%GOSUB GREY_OFF

%Restaure marge droite
LC 000
D0=00125
DAT0=C X

D0=(5)SAV_SCR
  C=DAT0.A
  D0=00120
  DAT0=C.A
  %All flags a 0
  CLRST
  
  %Vide buffer key
  GOSBVL Flush
  
  %On fait une jolie transition en
  %restaurant le contraste de jeu
  D0=(5)ctrstuser101
  A=DAT0.P B=A.P
  D0=(5)ctrstuser102
  A=DAT0.S B=A.S
  GOSUBL transitionbaissectrste
  
  LOADRPL


% GESTIONOAIRE
'Inter.s

*lalogocs
/logocs
ENDCODE
RECLAIMDISP
"Merci Â Madchrist,Yam" DISPROW1
"Eric,Vbl,Farfad,Neo" DISPROW2
"RoccoHP,Talaron,TotoHP" DISPROW3
"Lord_Demos,Denis M." DISPROW4
"   calcarena.free.fr" DISPROW7
WaitForKey
2DROP
;

@