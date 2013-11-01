%Tout ce qui a rapport avec les
%tirs et le viseur

*effacevis
D0=(5)adrsavfondvis
A=DAT0.A D0=(5)adrsavfondecran
C=DAT0 A C+A A D0=C
?ST=1 0 SKIPYES
{
 D1=(5)AdrSCREEN1 C=DAT1.A
}
SKELSE
{
 D1=(5)AdrSCREEN2 C=DAT1.A
}
C+A A
D1=C
C=DAT0 B D0+34
DAT1=C P D1+34
C=DAT0 B DAT1=C P
RTN

*afficheonlyviseur

D0=(5)coordpixj1scr
A=DAT0.A LC 00111
A-C.A

%Gestion de la rotation du viseur
%autour du joueur, en utilisant
%le tableau de coord precalculÈs

B=A A %On sav l'init point du vis
D0=(5)tablcoordvise
A=DAT0 A
D0=(5)posviseur
C=0 A
C=DAT0 B
C-1 B %Ajustage parce que la posi
%tion origin de posvis est 1, et
%la on la passe a 0
D=C B
C+C B
C+C B
C+D B %Posit*5 car 1coord=5q
A+C A %AdrBeginCoords+coordVoulu
D0=A
C=0 A
C=DAT0 B %On lit les coords X du
%viseur
D=C P
CSR B
B+C A %On add les coordsX a linit
%point
D0+2
A=0 A
A=DAT0 X
A+B A %On add les coordsY a linit
B=A A

D1=(5)coordpixj1x A=DAT1.B
LC 3
C&A.P
D+C P
LC 3
?D>C P ç
{
 LC 4
 ?D=C P ç
 {
  B+1 A
  D=0 P
 }
 SKELSE
 {
  B+1 A
  D-C P
 }
}
A=B A
D0=(5)adrsavfondvis
DAT0=A.A
?ST=1.0 SKIPYES
{     
 D0=(5)AdrSCREEN1 C=DAT0.A
}
SKELSE
{
 D0=(5)AdrSCREEN2 C=DAT0.A
}
A+C.A
B=A A

LC 1
{
 D-1.P
 EXITC
 C+C.P
 D-1.P
 EXITC
 C+C.P
 D-1.P
 EXITC
 C+C.P
}
D0=A A=DAT0.P
A!C.P 
DAT0=A.P

D0+34 A=DAT0.P
A!C.P
DAT0=A.P
RTN

%Rechargement d'une arme primaire
%ou secondaire
*rechargeweap

%On teste si un rechargement est
%deja en cours
D0=(5)rechargeweapj1
A=DAT0 B
?Aã0 B ç
{
 RTN
}
%On regarde si le j1 utilise son
%arme primaire
D1=(5)weapselectj1
A=DAT1 P
?A=0 P ç
{
 %Il utilise son arme primaire
 %Test si le chargeur est plein
 D1=(5)amochargj1prim
 A=DAT1 B
 LC 25
 ?A=C B EXIT
 %Test si on a des balles a mettr
 %e ds le chargeur
 D1=(5)amoj1prim
 A=DAT1 B
 ?A=0 B EXIT
 %On lance le rechargement de
 %l'arme primaire (le timer va
 %aller de 35 a 0)
 LC 23 %23h = 35d
 DAT0=C B %D0=adresse timer
}
SKELSE
{
 %Il n'utilise pas son arme prima
 %ire
 %On test si il utilise la
 %secondaire
 LC 1
 ?AãC P EXIT
 %Test si le chargeur est plein
 D1=(5)amochargj1second
 A=DAT1 B
 LC 12
 ?A=C B EXIT
 %Test si on a des balles a mettr
 %e ds le chargeur
 D1=(5)amoj1second
 A=DAT1 B
 ?A=0 B EXIT
 %On lance le rechargement de
 %l'arme primaire (le timer va
 %aller de 70 a 50)
 LC 46 %46h = 70d
 DAT0=C B %D0=adresse timer
}

RTN

%Gestion du rechargement
*rechargeweapec

%On soustrait 1
A-1 B
%On regarde si le rechargement
%est sur l'arme primaire ou
%secondaire, ou si c un cadencage
%de tir
LC 23
?A<C B ç
{
 %Rechargement de l'arme primaire
 %Test si le rechargement est fin
 %i
 ?A=0 B ç
 {
  %Le rechargement est fini, on
  %doit l'appliquer
  DAT0=A B
  %On met les balles dans le char
  %geur et on les enleves des poc
  %hes
  D1=(5)amoj1prim
  A=DAT1 B
  B=A B
  LC 25
  SETDEC
  A-C B
  SETHEX
  SKIPNC
  {
   A=0 B
  }
  DAT1=A B
  D1=(5)amochargj1prim
  ?C>B B ç
  {
   C=B B
  }
  DAT1=C B
  GOSUBL affamocharg
  GOSUBL affamopoche
 }
 SKELSE
 {
  DAT0=A B %J'ecris la new value
 }
}
SKELSE
{
 %On regarde si c'est un recharge
 %ment de larme secondaire ou un
 %cadencage de tir
 LC 45
 ?A<C B ç
 {
  %Rechargement de l'arme secondai
  %re
  %Test si le rechargement est fin
  %i
  LC 32 %32h =50d
  ?A=C B ç
  {
   %Le rechargement est fini, on
   %doit l'appliquer
   A=0 B
   DAT0=A B
   %On met les balles dans le char
   %geur et on les enleves des poc
   %hes
   D1=(5)amoj1second
   A=DAT1 B
   B=A B
   LC 12
   SETDEC
   A-C B
   SETHEX
   SKIPNC
   {
    A=0 B
   }
   DAT1=A B
   D1=(5)amochargj1second
   ?C>B B ç
   {
    C=B B
   }
   DAT1=C B
   GOSUBL affamocharg
   GOSUBL affamopoche
  }
  SKELSE
  {
   DAT0=A B %J'ecris la new value
  }
 }
 SKELSE
 {
  %C'est un cadencage de tir
  %On regarde si le cadencage
  %est fini
  LC 46
  ?A=C B ç
  {
   %On indique qu'on peut retirer
   A=0 B
   DAT0=A B
  }
  SKELSE
  {
   %On ecrit le nouveau compteur
   DAT0=A B
  }
 }
}

RTN

%Routine de gestion des tirs
*gesttirs
%On va passer en revue tt les tir
%s, et s'occuper de ceux qui sont
%actifs
%On decremente le ralentissement
LC 00300
GOSUBL Decrralentissement
P=0
D0=(5)etattirsj1
A=DAT0 16
R1=A W %Sav ds R1.w
%Boucle de recherche
{
 A=R1 W
 A-1 P
 GONC gesttiractif
 *aftgesttiractif
 P+1
 UPNC
}
%P revient tt seul a 0
%On reecrit l'etat des tirs
D0=(5)etattirsj1
A=R1 W
DAT0=A 16
%On retourne a la mainbcl du jeu
RTN

%Gestion d'un tir actif
*gesttiractif
C=0 A
C=P 0
P=0
R2=C P %P ds R2.0
CSL B
D0=(5)adrtbtirj1
A=DAT0 A
A+C A
D0=A %D0 pointe sur le tir voulu
C=DAT0 B %On lit la puissance
D=C B
D0+2
A=DAT0 B %On lit le timer
A-1 B %On le decremente
SKIPNC
{
 %Si <0 => stop balle
 GOTO stoptir
}
DAT0=A B
D0+2
%On add les coords X
A=DAT0 X B=A X D0+6 %x EC
C=DAT0 B %x a ADD ou SOUSTR
A=0 X
A=C B
ASR B
%C.0 contient si on doit-/+
C-1 P
SKIPNC
{
 %On doit soustaire
 B-A X
 A=B X
}
SKELSE
{
 %On doit additionner
 A+B X
}
D0-6 DAT0=A X %On ecrit new X
D0+3
%On add les coords Y
A=DAT0 X B=A X D0+5 %y EC
C=DAT0 B %y a ADD ou SOUSTR
A=0 X
A=C B
ASR B
%C.0 contient si on doit-/+
C-1 P
SKIPNC
{
 %On doit soustaire
 B-A X
 A=B X
}
SKELSE
{
 %On doit additionner
 A+B X
}
D0-5 DAT0=A X %On ecrit oew Y
%Maintenant on va tester si la
%balle touche qqun
%...PAS PROG CAR PAS D'ENNEMIS

%On restaure P
C=R2 P
P=C 0
%Retour a la boucle de recherche
GOTO aftgesttiractif

%Arret d'une balle
*stoptir

%On affiche l'impact de la balle
C=0 X
D1=(5)nbcasescrx
C=DAT1 B
C+C X %posit scrX en q
D0+2
A=DAT0 X %Coords balleX en pix
R3=A X
ASRB X
ASRB X %Posit balleX en q
A-C X
SKIPNC
{
 GOTO finaffimpactballe %< scrX
}
LC 1D
?A>C B ç
{
 GOTO finaffimpactballe %>scrX
}
B=A X
C=0 X
D1=(5)nbcasescry
C=DAT1 B
C+C X
C+C X
C+C X %Posit scrY en lignes
A=0 A
D0+3
A=DAT0 X %Coords balleY en lignes
R4=A X
A-C X
SKIPNC
{
 GOTO finaffimpactballe %< scrY
}
LC 3F
?A>C B ç
{
 GOTO finaffimpactballe %>scrY
}
A+A X A+A X C=A X ASL X A+C X%lçq
A+B X %X + Y
?ST=1 0 SKIPYES
{
 D1=(5)AdrSCREEN1 C=DAT1.A
}
SKELSE
{
 D1=(5)AdrSCREEN2 C=DAT1.A
}
A+C A
D1=A %Pointe sur l'endroit o˙ aff
%l'impact
%Et on affiche notre impact (en f
%esant une INV d'un q a l'endroit
%voulu)
C=DAT1 P C=-C-1 P DAT1=C P D1+34
C=DAT1 P C=-C-1 P DAT1=C P
%On enregistre qu'on a affichÈ
%l'impact, pour plus tard l'effac
%er
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
A=0 A
C=DAT0 B
A=C B
C+1 B
DAT0=C B
A+A B
C=A B
A+A B
A+C B %*6
C=DAT1 A
A+C A
D0=A
A=R3 X DAT0=A X D0+3 %Write X
A=R4 X DAT0=A X %Write Y

*finaffimpactballe
%On restaure P
C=R2 P
P=C 0
%On met la balle EC a 0
A=R1 W
A=0 P %P=balle EC
R1=A W
%On decr le nb de tirs EC du j1
D0=(5)nbtirecj1
A=DAT0 P
A-1 P
DAT0=A P

%Retour a la boucle de recherche
GOTO aftgesttiractif

%Routine de gestion d'un oouveau
%tir
*newtirj1

%Test si le j1 est en train
%de recharger
D0=(5)rechargeweapj1
A=DAT0 P
?Aã0 P ç
{
 RTN
}
%Test si la routine des tirs est
%saturee
D0=(5)nbtirecj1
A=DAT0 P
A+1 P
SKIPNC
{
 RTN
}

%INIT DE LA BOUCLE DE TEST DES
%MURS

%On calc le reste de la /8 des co
%ords X et Y du j1
D0=(5)coordpixj1x
A=DAT0 X
LC 7
C&A P
P=C 0
C=P 15
B=C S %Reste X dans B.s
P=0
D0=(5)coordpixj1y
A=DAT0 X
LC 7
C&A P
P=C 0
C=P 15
D=C S %Reste Y dans D.s
P=0

%Recuperation de combien il va fa
%loir add aux coords de la balle
%pour la faire avancer a chaque
%bcl, dans R1.s et R2.s
D0=(5)tablcoordballes
A=DAT0 A
D0=(5)posviseur
C=0 A
C=DAT0 B
C-1 B
C+C B
C+C B
A+C A
D0=A
C=DAT0 B
?C=0 P ç
{
 ST=0 6
}
SKELSE
{
 ST=1 6
}
P=C 1
C=P 15
P=0
R1=C S%Coords balle a addX ds R1s
CSL X
CSL A
D0+2
C=DAT0 B
?C=0 P ç
{
 ST=0 11
}
SKELSE
{
 ST=1 11
}
P=C 1
C=P 15
R2=C S %Coords balles a addY R2s
D1=C %On save les coords a add
P=0

%Reperage de la position du j1 ds
%la bdd ç R1.a
A=0 A
D0=(5)coordpixj1y
A=DAT0 3
A+3 X %Ajustage Y
ASRB X
ASRB X
ASRB X %/8 pque c des cases
C=0 A
D0=(5)nbcasebddnivx
C=DAT0 B
GOSBVL 03991
A=0 A
D0=(5)coordpixj1x
A=DAT0 3
A+3 X %Ajustage X
ASRB X
ASRB X
ASRB X %A/8 pque c d cases
A+B X
D0=(5)adrbddobj
C=DAT0 A
C+A A
R1=C A

%Initialisation du timer qui serv
%ira pour determioer la duree de
%vie d'une balle en fct de l'arme
%selectionnÈe (dans B.b)
%Et en meme tps :
%Initialisation de la puissance
%de la balle en fct de l'arme
%selectionnÈe (dans D.b)
D0=(5)weapselectj1
A=DAT0 P
?A#0 P ç
{
 GOTO .pasarmeprimselect
}
 %Arme prim selectionnÈe
 D0=(5)typeweapprimj1
 A=DAT0 P
 LC 1
 ?A=C P ç
 {
  D0=(5)rechargeweapj1
  LC 5C
  DAT0=C B
  LC 10
  RSTK=C
  B=C B %Timer en Hex
  LC 41
  D=C B %Puissance en Dec
  %On decremente les balles
  D0=(5)amochargj1prim
  A=DAT0 B
  SETDEC
  A-1 B
  SETHEX
  SKIPNC
  {
   %Le joueur n'a plus de balle
   %dans l'arme qu'il a select
   C=RSTK
   RTN
  }
  DAT0=A B
 }
 SKELSE
 {
  D0=(5)rechargeweapj1
  LC 4A
  DAT0=C B
  LC 28
  RSTK=C
  B=C B %Timer en Hex
  LC 24
  D=C B %Puissance en Dec
  %On decremente les balles
  D0=(5)amochargj1prim
  A=DAT0 B
  SETDEC
  A-1 B
  SETHEX
  SKIPNC
  {
   %Le joueur n'a plus de balle
   %dans l'arme qu'il a select
   C=RSTK
   RTN
  }
  DAT0=A B
 }
GOTO .armeprimeselect
*.pasarmeprimselect
 LC 1
 ?A=C P ç
 {
  %Arme 2de selectionnÈe
  D0=(5)rechargeweapj1
  LC 59
  DAT0=C B
  LC 22
  RSTK=C
  B=C B %Timer en Hex
  LC 13
  D=C B %Puissaoce en Dec
  %On decremente les balles
  D0=(5)amochargj1second
  A=DAT0 B
  SETDEC
  A-1 B
  SETHEX
  SKIPNC
  {
   %Le joueur n'a plus de balle
   %dans l'arme qu'il a select
   C=RSTK
   RTN
  }
  DAT0=A B
 }
 SKELSE
 {
  %C'est l'arme 3 qui est select
  % => on quitte
  RTN
 }
*.armeprimeselect

%On fait le bruit du tir (un peti
%t TIC pour le moment, mais ca va
%s'ameliorer)

LC 800 OUT=C
C=0 X OUT=C
LC 800 OUT=C
C=0 X OUT=C

%Mise de la marge a droite du niv
%eau dans R2.b
D0=(5)nbcasebddmdroite
A=DAT0 B
R2=A B

%Mise de la taille du niveau hori
%zontalement dans R3.b
D0=(5)nbcasebddnivx
A=DAT0 B
R3=A B

%Mise de la taille du niveau vert
%icalement dans R4.b
D0=(5)nbcasebddnivy
A=DAT0 B
R4=A B

%On ajoute un tir
D0=(5)nbtirecj1
A=DAT0 P
A+1 P
DAT0=A P

%BOUCLE DE TEST DE COLLISION AVEC
%LES MURS

*bcltstballecolmur
 %Teste si on doit incr ou decr X
 ?ST=1 6 ç
 {
  %Incremente les X
  A=R1 S
  A+B S
  P=15
  LC 8
  ?AäC P ç supaddballeX
  P=0
  B=A S
 }
 SKELSE
 {
  %Decremente les X
  A=R1 S
  C=B S
  C-A S
  GOC carryaddballeX
  B=C S
 }
 *rtnaftX
 %Teste si on doit incr ou decr Y
 ?ST=1 11 ç
 {
  %Incremente les Y
  C=R2 S
  C+D S
  P=15
  LA 8
  ?CäA P ç supaddballeY
  P=0
  D=C S
 }
 SKELSE
 {
  %Decremente les Y
  A=R2 S
  C=D S
  C-A S
  SKIPNC
  {
   GOTO carryaddballeY
  }
  D=C S
 }
 *rtnaftY
 %Teste si on doit tester une
 %nouvelle case
 ?ST=0 7 SKIPYES
 {
  GOTO tstnewcase
 }
 %Decremente le timer
 B-1 B
GONC bcltstballecolmur
B=0 B %On met le timer a 0
GOTO writenewballetable

%Quand X a depasse 8
*supaddballeX
P=0
ST=1 7 %Active le flag de nouvell
%e case a tester
%On calc le new reste
A-C S
B=A S
%On incr la position de la balle
A=R1 A
A+1 A
R1=A.A
GOTO rtnaftX

%Quand X passe sous 0
*carryaddballeX
ST=1 7 %Active le flag de nouvell
%e case a tester
%On calc le new reste
A-B S
P=15
LC 8
P=0
C-A S
B=C S
%On decr la position de la balle
A=R1 A
A-1 A
R1=A.A
GOTO rtnaftX

%Quand Y a depasse 8
*supaddballeY
P=0
ST=1 7 %Active le flag de nouvell
%e case a tester
%On calc le new reste
C-A S
D=C S
%On incr la position de la balle
A=R1 A
C=0 A
C=R3 B
A+C A
R1=A.A
GOTO rtnaftY

%Quand Y passe sous 0
*carryaddballeY
ST=1 7 %Active le flag de nouvell
%e case a tester
%On calc le new reste
C=D S
A-C S
P=15
LC 8
P=0
C-A S
D=C S
%On decr la position de la balle
A=R1 A
C=0 A
C=R3 B
A-C A
R1=A.A
GOTO rtnaftY

%Teste la nouvelle case ou se tro
%uve la balle
*tstnewcase
ST=0 7
A=R1 A
D0=A
A=DAT0 P
LC 1
%La balle sarrete la car on la
%case ou elle est est un mur.
%On ecrit ses infos ds le tablea
%u
?A=C P ç writenewballetable
%Decremente le timer
B-1 B
SKIPC
{
 GOTO bcltstballecolmur
}
B=0 B %On met le timer a 0
%La balle sarrete car elle a parc
%ouru le max qu'elle pouvait
*writenewballetable
%On va rechercher un endroit libr
%e dans le tab de balles
%On regarde un emplacement a ete
%libere

%On fait le bruit du tir (un peti
%t TIC pour le moment, mais ca va
%s'ameliorer)

LC 800 OUT=C
C=0 X OUT=C

D0=(5)tbtirj1lastfree
C=0 A
C=DAT0 B
?Cã0 B SKIPYES
{
 %Aucun emplacement n'a ete liber
 %e,on va donc effectuer une rech
 %erche grace aux 16q indiquants
 %l'activation des tirs
 D0=(5)etattirsj1
 A=DAT0 16
 %Boucle de recherche
 {
  ?A=0 P ç
  {
   EXIT2
  }
  P+1
  UPNC
 }
 C=P 0
 %L'emplacement libre est dans C0
 %On indique qu'il est now occupÈ
 D0=(5)etattirsj1
 A=DAT0 16
 LA 1
 DAT0=A 16
 P=0
}
SKELSE
{
 GOTOL debugdk
 %L'emplacement libre est dans C.0
 %On indique qu'il est now occupÈ
 D0=(5)etattirsj1
 A=DAT0 16
 P=C 0
 LA 1
 DAT0=A 16
 P=0
}
%L'emplacement libre est dans C.0
CSL B
D0=(5)adrtbtirj1
A=DAT0 A
A+C A
D0=A %D0 pointe la ou on doit
%ecrire le tir
C=D B
DAT0=C B %Ecriture de la puissanc
%e ds le tableau
C=RSTK %Recup timer original
C-B B %On retire la valeur a laqu
%elle le timer s'est arretÈ
D0+2
DAT0=C B %On ecrit le timer
CD1EX
D1=(5)coordpixj1x
A=DAT1 X
A+3 X %Ajustage X
D0+2
DAT0=A X %On ecrit les coordsX
D1=(5)coordpixj1y
A=DAT1 X
A+3 X %Ajustage Y
D0+3
DAT0=A X %On ecrit les coordsY
D0+5
DAT0=C B %Write incr coordY
CSR A
CSR X
D0-2
DAT0=C B %Write incr coordX

%On raffraichit le compteur des
%bales de la statbare
GOSUBL affamocharg

%On fait le bruit du tir (un peti
%t TIC pour le moment, mais ca va
%s'ameliorer)

LC 800 OUT=C
C=0 X OUT=C
LC 800 OUT=C
C=0 X OUT=C

RTN

%Gestion de l'effacagÖøOes impact
%s des balle tirÈes par le j1
*gesteffimpactballej1


P=C 0
C=P 15
P=0
D=C S
A=0 A
DAT0=A B %On met a 0 le compteur
C+C B
A=C B
C+C B
A+C B %*6
C=DAT1 A
A+C A
R1=A A%Pointe (dans le tableau)
%sur le dernier impact affichÈ
%Boucle d'eff des impacts
*bcleffimpact
 C=R1 A
 C-6 A%On passe au la last impact
 D1=C %Restaure point tableau
 R1=C A
 A=DAT1 X
 C=0 X
 D0=(5)nbcasescrx
 C=DAT0 B
 C+C X %posit scrX en q
 %A.x=Coords balleX en pix
 ASRB X
 ASRB X %Posit balleX en q
 A-C X
 SKIPNC
 {
  GOTO finbcleffimpact %< scrX
 }
 LC 1D
 ?A>C B ç
 {
  GOTO finbcleffimpact %>scrX
 }
 B=A X
 C=0 X
 D0=(5)nbcasescry
 C=DAT0 B
 C+C X
 C+C X
 C+C X %Posit scrY en lignes
 A=0 A
 D1+3
 A=DAT1 X %Coords balleY en lignes
 A-C X
 GOC finbcleffimpact %< scrY
 LC 3F
 ?A>C B ç finbcleffimpact %>scrY
 A+A X A+A X C=A X ASL X A+C X%lçq
 A+B X %X + Y
 ?ST=1 0 SKIPYES
 {
  D1=(5)AdrSCREEN1 C=DAT1.A
 }
 SKELSE
 {
  D1=(5)AdrSCREEN2 C=DAT1.A
 }
 C+A A
 D1=C %Pointe sur l'endroit o˙ eff
 %l'impact
 D0=(5)adrsavfondecran
 C=DAT0 A C+A A D0=C
 
 C=DAT0 B D0+34
 DAT1=C B D1+34
 C=DAT0 B DAT1=C B
 *finbcleffimpact
 D-1 S
SKIPC
{
 GOTO bcleffimpact
}

RTN

@