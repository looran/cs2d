%Gere le deplacement du/des bots
%actives

*gestdeplacementbots

D0=(5)nbbots
A=DAT0 P
?A=0 P ç
{
 RTN
}
C=0 P
R4=C P %Compteur dans R4.p

*bcltraitementdeplacbots

 %On decremente le ralentissement
 LC 00100
 GOSUBL Decrralentissement
 %On met a 0 le flag de deplaceme
 %nt X (6) et Y (11)
 ST=0.6 ST=0.11
 A=0 A
 A=R4 P
 LC(5)directbots
 C+A A
 D0=C
 C=DAT0 S
 R4=C S %On stoque la direction
 %du bot EC ds R4.s
 LC(5)stbots
 C+A A
 D0=C
 C=DAT0 P
 R3=C P %On stoque le statut du
 %bot EC dans R3.p
 C=A B A+A B A+A B A+C B A+C B%*6
 D0=(5)adrtabcoordsbots
 C=DAT0 A
 A+C A
 R1=A A%Pointe sur les coordsX du
 %bot EC
 %Ici on met l'IA et tst col
 %On ne doit pas toucher a R4.p
 %R4.s R3.p R1.a
 %On met dans R1s les mouvsX a
 %faire et ds R3s les mouvsY sous
 %la forme +1 (0 pour -1,1 pour 0
 %, 2 pour 1)
 %On met a 1 les mouvs a faire
 %(Cad a 0 car -1)
 C=0 S C+1 S R1=C S R3=C S
 %On va chercher le mouv a faire
 A=0 A
 A=R4 P
 ASL B
 A+A X
 C=A X A+A X A+A X %*16*8=*128
 A+C X %*128+*32 = *160
 D0=(5)adrtabmouvbots
 C=DAT0 A
 A+C A
 B=A A%Pointe au debut de la list
 %e des mouvements que doit faire
 %le bot
 %Il faut maintenant se positionn
 %er au bon endroit dans la liste
 %pour lire le 1er mouv a faire
 A=0 A
 A=R4 P
 A+A B
 D1=(5)adrtabnbmouvbots
 C=DAT1 A
 C+A A
 D1=C
 A=0 A
 A=DAT1 B
   %DEBUG OK: check nb mouvs
   %B=A.B
   %GOTOL debugdk
 A-1 B %On pointe sur le dernier
 A+A B A+A B A+A B %*8
 A+B A
   %DEBUG OK: Check D0
   %B=A.A
   %D0=(5)adrtabmouvbots C=DAT0.A
   %D=C.A
   %GOTOL debugdk
 D0=A %Pointe a l'endroit o˙ est
 %le mouv a faire
 A=DAT0 P
 ?A=0 P ç
 {
  %Le bot campe, on quitte l'IA
  %(par la suite il faudra qu'il
  %guette les autres ...)
  GOTO affbotsamecoordonly
 }
 SKELSE
 {
  LC 1
  ?AãC P ç
  {
   GOTO .mouvnot1
  }
   %Le bot doit aller a un endroi
   %t dont les coords sont indiqu
   %Ès sur les 6q aprËs
   D0+1 A=DAT0 X
   C=R1 A D1=C C=DAT1 X
   ?C=A X ç
   {
    D0+3 D1+3
    A=DAT0 X C=DAT1 X
    ?A=C X ç
    {
     %On est arrivÈ a destination
     %On enleve 1 mouv de la list
     %e
     A=0 A
     A=R4 P
     A+A B
     D1=(5)adrtabnbmouvbots
     C=DAT1 A
     C+A A
     D1=C
     A=DAT1 B
     A-1 B
     DAT1=A B
     GOTO affbotsamecoordonly
    }
    SKELSE
    {
     GOTO .gerebotgoY
    }
   }
   ?C>A X ç
   {
    %On doit aller vers la gauche
    ST=1.6 %mouv X
    C=0.S
    R1=C S
    P=15 LC 3 P=0
    R4=C.S %En vue de stok dans
    %directbots
   }
   SKELSE
   {
    %On doit aller vers la droite
    ST=1.6 %mouv X
    P=15 LC 2
    R1=C.S
    LC 1 P=0
    R4=C.S %En vue de stok dans
    %directbots
   }
   D0+3 D1+3 %On passe aux Y
   A=DAT0 X C=DAT1 X
   *.gerebotgoY
   ?A=C X ç
   {
    GOTO .gerebotgoaftY
   }
   P=15
   ?C>A X ç
   {
    %On doit aller vers le haut
    ST=1.11 %mouv Y
    C=0 S
    R3=C S
    R4=C.S %En vue de stok dans
    %directbots
   }
   SKELSE
   {
    %On doit aller vers le bas
    ST=1.11 %mouv Y
    LC 2
    R3=C S
    R4=C.S %En vue de stok dans
    %directbots
   }
   P=0
   GOTO .aftgeremouv
   *.gerebotgoaftY
  *.mouvnot1
  
   LC 3
   ?A=C P ç
   {
    %Le bot doit poser la bombe
    %On lui enleve la bombe car
    %il l'a posÈe
    A=0 A
    A=R4 P
    LC(5)stbots
    A+C A
    D1=A
    A=DAT1 P
    LC 7
    A&C P
    DAT1=A P
    %On active le timer
    D1=(5)TimerC4
    LC FF
    DAT1=C B
    %On enleve 1 mouv de la list
    %e
    A=0 A
    A=R4 P
    A+A B
    D1=(5)adrtabnbmouvbots
    C=DAT1 A
    C+A A
    D1=C
    A=DAT1 B
    A-1 B
    DAT1=A B
    GOTO affbotsamecoordonly
   }
   SKELSE
   {
    LC 5
    ?A=C P ç
    {
     %Le bot doit aller ds 1 zone
     %specifiÈ sur les 2q suivant
     %s
     GOSUB botgozone
    }
    SKELSE
    {
     LC 6
     ?A=C P ç
     {
      %Le bot doit aller dans un
      %endroit specifique (genre
      %un initpt, un C4 ...)
      GOSUB botgospecialplace
     }
    }
   }
 }
 %...
*.aftgeremouv
%On teste si le bot va bouger
 B=0.X D=0.X
 C=R1.A D1=C
 ?ST=0.6 ç
 {
  ?ST=0.11 ç
  {
   GOTO affbotsamecoordonly
  }
 }
 SKELSE
 {
  %Ya un deplacement X
  A=R1.S
  ?A=0.S ç
  {
   %Deplacement ç g
   C=DAT1.X
   ?ST=0.11 ç
   {
    C-7.X
   }
   SKELSE
   {
    C-1.X
   }
   B=C.X
   D1+3 C=DAT1.X R2=C.X
  }
  SKELSE
  {
   %Deplacement ç d
   C=DAT1.X
   ?ST=0.11 ç
   {
    C+7.X
   }
   SKELSE
   {
    C+1.X
   }
   B=C.X
   D1+3 C=DAT1.X R2=C.X
  }
 }
 C=R1.A D1=C
 A=R3.S
 ?A=0.S ç
 {
  %Deplacement ç o
  C=DAT1.X R2=C.X
  D1+3 C=DAT1.X
  ?ST=0.6 ç
  {
   C-7.X
  }
  SKELSE
  {
   C-1.X
  }
  D=C.X
 }
 SKELSE
 {
  P=15
  LC 2
  ?A=C.S ç
  {
   %Deplacement ç b
   C=DAT1.X R2=C.X
   D1+3 C=DAT1.X
   ?ST=0.6 ç
   {
    C+7.X
   }
   SKELSE
   {
    C+1.X
   }
   D=C.X
  }
 }
 P=0
 %Test collision d'un bot avec
 %les autres joueurs
 ?B=0.X ç
 {
  GOSUBL BclTstD
  SKIPNC
  {
   GOTO affbotsamecoordonly
  }
 }
 SKELSE
 {
  ?D=0.X ç
  {
   GOSUBL BclTstB
   SKIPNC
   {
    GOTO affbotsamecoordonly
   }
  }
  SKELSE
  {
   GOSUBL BclTstBD
   SKIPNC
   {
    GOTO affbotsamecoordonly
   }
  }
 }
 %On efface la derniere position
 %du bot
 A=R1 A
 D0=A
 A=DAT0 X D0+3
 C=DAT0 X R2=C X
 %On test si on est en jeu OU
 %menutalk
 D0=(5)YNAffBots
 C=DAT0.P
 ?C=0.P SKIPYES
 {
  %On test si le bot est dans le
  %scr. Si oui on l'efface
  %Dans A.x on a les coords du bot
  %X
  %Dans R2.x on a les coords du bot
  %Y
  GOSUBL tstobj2jinscr
  SKIPNC
  {
   GOSUBL effacebot
  }
 }
 %On modifies les coords
 %X
 A=R1 A  D0=A
 A=DAT0 X
 C=0 X
 C=R1 S
 P=C 15 C=P 0 P=0
 A+C X A-1 X
 DAT0=A X
 %Y
 A=R1 A  A+3 A D0=A
 A=DAT0 X
 C=0 X
 C=R3 S
 P=C 15 C=P 0 P=0
 A+C X A-1 X
 DAT0=A X
 *affbotsamecoordonly
 %On reeafiche le bot
 A=R1 A
 D0=A
 A=DAT0 X D0+3
 C=DAT0 X R2=C X
 %On test si on est en jeu
 D0=(5)YNAffBots
 C=DAT0.P
 ?C=0.P SKIPYES
 {
  %On test si le bot est dans le
  %scr. Si oui on l'affiche 
  %Dans A.x on a les coords du bot
  %X
  %Dans R2.x on a les coords du bot
  %Y
  GOSUBL tstobj2jinscr
  SKIPNC
  {
   GOSUB affichebot
  }
 }
 %Stoquage de la direction du bot
 %EC qui est dans R4.s
 LC(5)directbots
 A=0.A A=R4.P
 C+A.A
 D0=C A=R4.S DAT0=A.S

 C=R4 P
 C+1 P
 D0=(5)nbbots
 A=DAT0 P
 ?CäA P ç
 {
  RTN
 }
 R4=C P
 
GOTO bcltraitementdeplacbots

RTN %Ne sert a rien

%Le bot va dans une zone spÈcifiÈ
%e
*botgozone

C=0 A
C=R4 P C+C B
D1=(5)adrtabnbzonebots
A=DAT1 A
A+C A
D1=A
A=0 A A=DAT1 B %Ab:Nb zone du
%bot EC
R2=A A %Sav for futur use
A-1.A B=A A
ASL X A+A A C=A A A+A A A+C A%*96
C=B A B+B A B+B A C+C X B+C A%*6
A+B A %*96 + *6 = *108
D1=(5)adrItinerairezones
C=DAT1 A
C+A A
D1=C
D0+1 A=DAT0 B %Ab:Nb zone de dest
%ination du bot
  %DEBUG OK
B=0.A
{
 C=DAT1 B
 ?C=0 B ç
 {
  %Fin d'itinÈraire, on recommenc
  %e a chercher dans le suivant
  B=0 A
  D1+2
  UP2
 }
 ?C=A B ç
 {
  %On a trouvÈ notre zone de dest
  %ination
  EXIT2
 }
 B+2 B
 D1+2
 UP
}
CD1EX C-B A %C pointe o de
%but de l'itinÈraire qui nous int
%eresse
  %DEBUG OK:
  %D0=C C=0.W C=DAT0.B B=C.W
  %C=DAT0.W D=C.W
  %GOTOL debugdk
RSTK=C %Save D1
B+2 B
 A=0 A
 A=R4 P
 A+A B
 D1=(5)adrtabnbmouvbots
 C=DAT1 A
 C+A A
 D1=C
 A=0 A
 A=DAT1 B
   %DEBUG OK:
   %verif nb mouvs
   %C=A.B D=C.B
   %GOTOL debugdk
 A+B B%2 mouvs pour aller a chaqu
 %e zone
 A-1 B%On ecrit sur le dernier
 %mouv (celui qui a dit d'aller d
 %ans la zone de destination)
   %DEBUG OK: Check nb mouvs
   %B=A.B
   %GOTOL debugdk
 DAT1=A B
C=RSTK CD1EX %Restaure D1
D0-1 %Pointe sur le mouv qui dit
%d'aller a la zone cherchÈe
  %DEBUG OK: ici D0 est bon
  %Fo check B.b
  %A=D0 R3=A.A
  %D0=(5)adrtabmouvbots C=DAT0.A
  %D=C.A
  %GOTOL debugdk
A=0 A A=B B
A-1.B
A+A X A+A A A+A A%*8
CD0EX C+A A CD0EX %D0 pointe sur
%le premier mouv a faire, et a
%chaque new mouv, on remonte dans
%la liste des mouvs a faire
 BSRB B %B/2
B-1 B%Bb:Nb zones a parcourir - 1
  %DEBUG OK: On verif les valeurs
  %des regs a lentree de la bcl
  %A=D0 B=A.A
  %D0=(5)adrtabmouvbots C=DAT0.A
  %D=C.A
  %GOTOL debugdk
*.bclwritemouvsgozone
 %On va rechercher a quel WP de
 %la zone o˙ on se trouve il faut
 %aller pour acceder a la next
 %zone
 C=0 A
 C=DAT1 B
   %DEBUG:
   %On test on est dja dans la
   %zone ou on va
   A=R2.A
   ?A=C.B ç
   {
    D=C.B
    GOSUBL GREY_OFF
    %Restaure marge droite
    LC 000
    D0=00125
    DAT0=C X
    GOSBVL DISP
   }
 RSTK=C %RSTK:Nb next zone
 CD1EX D=C A %On sav D1
 C=R2 A %Nb zone o˙ est le bot
 C-1 B
 CSL X A=C A C+C A C+A A %*48
 D1=(5)adrListeWPparZones
 A=DAT1 A
 A+C A
 D1=A
 C=RSTK %Cb:zone recherche
 RSTK=C %Resave 4 futur use
   %DEBUG OK: check valeur C.b
   %B=C.W
   %GOTOL debugdk
 {
  A=DAT1 B
  ?A=C B ç
  {
   %On a trouvÈ le WP qui menera
   %a la zone cherchÈe
   EXIT2
  }
    %DEBUG:
    %On verifie si tout de meme
    %il ne passerait pas a la
    %zone suivante ...
    %?A=0.B ç
    %{
    % A=D1 B=A.A
    % GOSBVL DISP
    %}
  D1+4 %On passe au next Wp
  UP
 }
 A=0 A
 D1+2 A=DAT1 B %Ab:Wp o˙ le bot
 %doit aller pour aller a la zone
 %voulue
   %DEBUG OK: check bon wp
   %D1-2 C=DAT1.B D=C.B
   %B=A.B
   %GOTOL debugdk

 A-1 B
 C=A.A C+C.X A+A.X A+A.X A+C.A%*6
 D1=(5)adrListeWP
 C=DAT1 A
 C+A A
 D1=C
 LC 1 %On indique que le bot doit
 %aller a un endroit dont les coo
 %rds sont indiquÈs sur les 6q
 %qui suivent
 DAT0=C P D0+1
 A=DAT1 X DAT0=A X
 D1+3 D0+3
 A=DAT1 X DAT0=A X
 D0-12 %On se met au nextmouv

 C=RSTK %Nb zone o˙ va le bot
 RSTK=C %Resave car on sen sert
 %a la fin de la bcl
 C-1 B
 CSL X A=C A C+C A C+A A %*48
 D1=(5)adrListeWPparZones
 A=DAT1 A
 A+C A
 D1=A
 C=R2 A %Cb:zone recherche
 {
  A=DAT1 B
  ?A=C B ç
  {
   %On a trouvÈ le WP qui menera
   %a la zone cherchÈe
   EXIT2
  }
    %DEBUG:
    %On verifie si tout de meme
    %il ne passerait pas a la
    %zone suivante ...
    %?A=0.B ç
    %{
    % GOTOL debugdk
    %}
  D1+4 %On passe au next Wp
  UP
 }
 A=0 A
 D1+2 A=DAT1 B %Ab:Wp o˙ le bot
 %doit aller pour aller a la zone
 %voulue
 A-1 B
 C=A A C+C.X A+A X A+A X A+C A%*6
 D1=(5)adrListeWP
 C=DAT1 A
 C+A A
 D1=C
 LC 1 %On indique que le bot doit
 %aller a un endroit dont les coo
 %rds sont indiquÈs sur les 6q
 %qui suivent
 DAT0=C P D0+1
 A=DAT1 X DAT0=A X
 D1+3 D0+3
 A=DAT1 X DAT0=A X
 D0-12 %On se met au nextmouv
 
 C=D A C+2 A CD1EX %On restaure
 %D1 qui pointe maintenant sur
 %le nb de la future zone o˙ doit
 %aller le bot
 C=RSTK R2=C.A %Le bot change de
 %zone
 B-1 B %On decrem le nombre de zo
 %nes a parcourir pour arriver
 %a destination
   %DEBUG CA A LAIR OK:
   %On suit levolution
   %de ski spass en ram a chaque
   %boucle
   %GOSBVL DISP
SKIPC
{
 GOTO .bclwritemouvsgozone
}

  %DEBUG OK: Verif position D0
  %A=D0 B=A.A
  %D0=(5)adrtabmouvbots C=DAT0.A
  %D=C.A
  %GOTOL debugdk

  %DEBUG: Verif du tab des mouvs
  %A=D0 C=A.A
  %B=C.A D=C.A
  %GOSBVL DISP

RTN

%Le bot va dans un endroit spÈcif
%ique
*botgospecialplace

%Mouv a faire +1 car 2 au total
%(Go ds 1 zone + go exact place)
 A=0 A
 A=R4 P
 A+A B
 D1=(5)adrtabnbmouvbots
 C=DAT1 A
 C+A A
 D1=C
 A=DAT1 B
 A+1 B
 DAT1=A B

D0+1
A=DAT0 P
?A=0 P ç
{
 %L'initpoint T
 D1=(5)nbzoneinitpointT
 A=DAT1 B
 D0+7
 LC 5 %On demande au bot de se
 %rendre dans une zone
 DAT0=C P
 D0+1 DAT0=A B
 D0-9
 D1=(5)nbcaseinipointTx
 A=0 X
 A=DAT1 B
 A+A X A+A X A+A X %caseçpix
 LC 1
 DAT0=C P %Voir aux ref tab mouv
 D0+1
 DAT0=A X %On ecrit initpointX
 D1=(5)nbcaseinipointTy
 A=0 X
 A=DAT1 B
 A+A X A+A X A+A X %caseçpix
 D0+3
 DAT0=A X %On ecrit initpointY
}
SKELSE
{
 LC 1
 ?A=C P ç
 {
  %L'initpoint CT
  D1=(5)nbzoneinitpointCT
  A=DAT1 B
  D0+7
  LC 5 %On demande au bot de se
  %rendre dans un zone
  DAT0=C P
  D0+1 DAT0=A B
  D0-9
  D1=(5)nbcaseinipointCTx
  A=0 X
  A=DAT1 B
  A+A X A+A X A+A X %caseçpix
  LC 1
  DAT0=C P %Voir aux ref tab mouv
  D0+1
  DAT0=A X %On ecrit initpointX
  D1=(5)nbcaseinipointCTy
  A=0 X
  A=DAT1 B
  A+A X A+A X A+A X %caseçpix
  D0+3
  DAT0=A X %On ecrit initpointY
 }
 SKELSE
 {
  %La zone C4
  D1=(5)nbzoneC4
  A=DAT1 B
  D0+7
  LC 5 %On demande au bot de se
  %rendre dans un zone
  DAT0=C P
  D0+1 DAT0=A B
  D0-9
  D1=(5)coordsXposebombe
  A=DAT1 X
  LC 1
  DAT0=C P %Voir aux ref tab mouv
  D0+1
  DAT0=A X %On ecrit coordsXposebombe
  D1=(5)coordsYposebombe
  A=DAT1 X
  D0+3
  DAT0=A X %On ecrit coordsYposebombe
 }
}

RTN

@