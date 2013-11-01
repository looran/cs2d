%Routine concernant certaines
%fct des bots (ajout, suppression
%)

%Routine de creation d'1 bot
%EntrÈe: ST.6 = 0 => T
%             = 1 => CT
*newbot

%On regarde si le nb de bots maxi
%est atteint (11)
D0=(5)nbbots
A=DAT0 P
R4=A P %On sav pour futur uses
R3=A.P %Sav pque routine tstcolBD
%utilise R4.p
LC B
?AäC P
RTNYES

%Test si ya qqun sur l'initpoint
%de l'equipe du futur bot
?ST=0 6 ç
{
 %Ca sera un Terro, on test l'ini
 %tpoint Terro
 %On utilise 1routine de tst col
 %entre bots
 %Pecho coord X
 D0=(5)nbcaseinipointTx
 A=0 X A=DAT0 B
 A+A X A+A X A+A X % caseçpix
 B=A.X
 %Pecho coord Y
 D0=(5)nbcaseinipointTy
 C=0.X C=DAT0.B
 C+C X C+C X C+C X % caseçpix
 D=C.X
 %On met nbbot EC bidon
 LC F R4=C.P
   %DEBUG:
   %Check B.x et D.x
   %GOSBVL DISP
 GOSUBL BclTstBD
 RTNC %Si impos ç return
}
SKELSE
{
 %Ca sera un Couter, on test l'in
 %itpoint Counter
 %On utilise 1routine de tst col
 %entre bots
 %Pecho coord X
 D0=(5)nbcaseinipointCTx
 A=0 X A=DAT0 B
 A+A X A+A X A+A X % caseçpix
 B=A.X
 %Pecho coord Y
 D0=(5)nbcaseinipointCTy
 C=0.X C=DAT0.B
 C+C X C+C X C+C X % caseçpix
 D=C.X
 %On met nbbot EC bidon
 LC F R4=C.P
 GOSUBL BclTstBD
 RTNC %Si impos ç return
}

A=R3.P R4=A.P %Restaure R4.p

%On rajoute 1 joueur ds l'equipe
%du new bot
?ST=0 6 ç
{
 %On crÈe un bot T
 D0=(5)nbT
}
SKELSE
{
 %On crÈe un bot CT
 D0=(5)nbCT
}
A=DAT0 P
A+1 P
DAT0=A P %On ecrit le new nb

%Activation d'un nouveau bot
A=0 A
A=R4 P
B=A A
B+B B
B+B B
B+A B
B+A B %On mets ds B.a le nbbots*6
%pour la prochaine routine qui
%va init les coords qui sont
%de 6q par coords
LC(5)stbots
A+C A
D0=A
?ST=0 6 ç
{
 %Activation vivant T
 %On regarde c'est le 1er T de la
 %partie
 D1=(5)nbT
 A=DAT1 P
 A-1 P %On a deja increm, alors
 %il faut decrem pour revenir
 %a l'origine
 ?A=0 P ç
 {
  %Si oui on lui donne la bombe
  LC B
 }
 SKELSE
 {
  %Si non on fait un T normal
  LC 3
 }
}
SKELSE
{
 %Activation vivant CT
 LC 7
}
DAT0=C P
D=C P %Save pour routine qui vien
%t

%Initialisation des mouvements a
%faire, et ecriture de ceux ci da
%ns le tableau

A=0 A
A=R4 P
ASL B
A+A X
C=A X A+A X A+A X%*16*8=*128
A+C X%*128+*32 = *160
D0=(5)adrtabmouvbots
C=DAT0 A
A+C A
D0=A %Pointe la ou on doit ecrire
%les mouvements que doit faire le
%bot
LC B
?DãC P ç
{
 GOTO .pasTporteurC4
}
 %C'est un terro porteur de C4
 %On dit au bot de camper
 C=0 P
 DAT0=C P
 D0+8 %Next mouv
   %On dit au joueur d'aller a son
   %initpoint de T
   %LC 6
   %DAT0=C P %Voir aux ref tab mouv
   %D0+1
   %C=0 P %InitPoint T
   %DAT0=C P
   %D0+7 %Mouvement suivant
   
   %DEBUG:
   %On dit au joueur d'aller a
   %la zone 0F
   LC 5
   DAT0=C P %Voir aux ref tab mouv
   D0+1
   LC 0F
   DAT0=C B
   D0+7 %Mouvement suivant
 %On dit au bot de poser la bombe
 LC 3
 DAT0=C P
 D0+8 %Mouvement suivant
 %On dit au bot d'aller au point
 %C4
 LC 6
 DAT0=C P %Voir aux ref tab mouv
 D0+1
 LC 2 %C4
 DAT0=C P
 D0+7 %Mouvement suivant
 %On fait acheter des armes au
 %bot
 %...
 %On indique que le bot a 4 chose
 %s a faire
 A=0 A
 A=R4 P
 A+A B
 D0=(5)adrtabnbmouvbots
 C=DAT0 A
 C+A A
 D0=C
 LC 04
 DAT0=C B
 %On init la zone ds laquelle
 %se trouve le bot
 C=0 A
 C=R4 P C+C B
 D1=(5)adrtabnbzonebots
 A=DAT1 A
 A+C A
 D1=A
 D0=(5)nbzoneinitpointT
 A=DAT0 B
 DAT1=A B
GOTO fininitmouvbot

*.pasTporteurC4
 LC 3
 ?C=D P ç
 {
  %C'est un terro normal
  %On dit au bot de camper
  C=0 P
  DAT0=C P
  D0+8 %Next mouv
    %On dit au bot d'aller au point
    %C4
    LC 6
    DAT0=C P %Voir aux ref tab mouv
    D0+1
    LC 2 %C4
    DAT0=C P
    D0+7 %Mouvement suivant

    %DEBUG
    %On dit au joueur d'aller a
    %la zone 13
    %LC 5
    %DAT0=C P Voir ref tab mouv
    %D0+1
    %LC 13 Zone 13
    %DAT0=C B
    %D0+7 Mouvement suivant
  %On fait acheter des armes au
  %bot
  %...
  %On indique que le bot a 2 chos
  %e a faire
  A=0 A
  A=R4 P
  A+A B
  D0=(5)adrtabnbmouvbots
  C=DAT0 A
  C+A A
  D0=C
  LC 02
  DAT0=C B
  %On init la zone ds laquelle
  %se trouve le bot
  C=0 A
  C=R4 P C+C B
  D1=(5)adrtabnbzonebots
  A=DAT1 A
  A+C A
  D1=A
  D0=(5)nbzoneinitpointT
  A=DAT0 B
  DAT1=A B
 }
 SKELSE
 {
  %C'est un Counter
  %On lui demande de camper
  C=0 P
  DAT0=C P
  D0+8 %Next mouv
  %On dit au joueur d'aller a
  %la zone 0F
  LC 5
  DAT0=C P %Voir aux ref tab mouv
  D0+1
  LC 0F %Zone 0F
  DAT0=C B
  %On indique que le bot a 2 chos
  %e a faire
  A=0 A
  A=R4 P
  A+A B
  D0=(5)adrtabnbmouvbots
  C=DAT0 A
  C+A A
  D0=C
  LC 02
  DAT0=C B
  %On init la zone ds laquelle
  %se trouve le bot
  C=0 A
  C=R4 P C+C B
  D1=(5)adrtabnbzonebots
  A=DAT1 A
  A+C A
  D1=A
  D0=(5)nbzoneinitpointCT
  A=DAT0 B
  DAT1=A B
 }

*fininitmouvbot

%Initialisation de ses coords
%(suivant les initpoints)
C=D P
%Dans C.p on a deja le statut du
%bot EC
?CBIT=0 2 ç
{
 %C'est un Terro
 %On init les X
 D0=(5)nbcaseinipointTx
 A=0 X
 A=DAT0 B
 A+A X A+A X A+A X % caseçpix
 D0=(5)adrtabcoordsbots
 C=DAT0 A
 C+B A %On add nbbots*6
 D0=C %Pointe sur la partie X
 DAT0=A X
 %On init les Y
 D1=(5)nbcaseinipointTy
 A=0 X
 A=DAT1 B
 A+A X A+A X A+A X % caseçpix
 D0+3 %On passe a la partie Y
 DAT0=A X
}
SKELSE
{
 %C'est un Counter
 %On init les X
 D0=(5)nbcaseinipointCTx
 A=0 X
 A=DAT0 B
 A+A X A+A X A+A X % caseçpix
 D0=(5)adrtabcoordsbots
 C=DAT0 A
 C+B A %On add nbbots*6
 D0=C %Pointe sur la partie X
 DAT0=A X
 %On init les Y
 D1=(5)nbcaseinipointCTy
 A=0 X
 A=DAT1 B
 A+A X A+A X A+A X % caseçpix
 D0+3 %On passe a la partie Y
 DAT0=A X
}

%On incremente le nb de bots
D0=(5)nbbots
A=DAT0 P
A+1 P
DAT0=A P

RTN

%Routine daff d1 grob 4grs + msq
%En entrelace pour aff un bot
*affichebot

%On choisi le grob a aff suivant
%l'equipe du bot (T ou CT),
%la direction du bot qui est
%dans direcbot,suivant qu'on soit
%en flag d'etat a 0 ou 1
C=R3 P
?CBIT=1 2 ç
{
 GOTO affbotct
}
%Le bot est Terro
P=15
?ST=1 1 ç
{
 A=R4 P %On recup la direct botEC
 ?Aã0 P SKIPYES
{
 D1=(5)adrgp1T
 C=DAT1 A
 D1=C
}
SKELSE
{
 LC 1
 ?AãC P SKIPYES
 {
  D1=(5)adrgp2T
  C=DAT1 A
  D1=C
 }
 SKELSE
 {
  LC 2
  ?AãC P SKIPYES
  {
   D1=(5)adrgp3T
   C=DAT1 A
   D1=C
  }
  SKELSE
  {
  %C'est forcement le grob4
   D1=(5)adrgp4T
   C=DAT1 A
   D1=C
  }
 }
}
}
SKELSE
{
 %Voir plus haut
 %C un ct
 P=15
 A=R4 P %On recup la direct botEC
 ?Aã0 P SKIPYES
 {
  D1=(5)adrgp12T
  C=DAT1 A
  D1=C
 }
 SKELSE
 {
  LC 1
  ?AãC P SKIPYES
  {
   D1=(5)adrgp22T
   C=DAT1 A
   D1=C
  }
  SKELSE
  {
   LC 2
   ?AãC P SKIPYES
   {
    D1=(5)adrgp32T
    C=DAT1 A
    D1=C
   }
   SKELSE
   {
   %C'est forcement le grob4
    D1=(5)adrgp42T
    C=DAT1 A
    D1=C
   }
  }
 }
}
GOTO finselectgrobaffbot
*affbotct
 %Le joueur est Counter
 P=15
 ?ST=1 1 ç
 {
  A=R4 P %On recup la direct bot
  ?Aã0 P SKIPYES
  {
  D1=(5)adrgp1CT
  C=DAT1 A
  D1=C
 }
 SKELSE
 {
  LC 1
  ?AãC P SKIPYES
  {
   D1=(5)adrgp2CT
   C=DAT1 A
   D1=C
  }
  SKELSE
  {
   LC 2
   ?AãC P SKIPYES
   {
    D1=(5)adrgp3CT
    C=DAT1 A
    D1=C
   }
   SKELSE
   {
   %C'est forcement le grob4
    D1=(5)adrgp4CT
    C=DAT1 A
    D1=C
   }
  }
 }
 }
 SKELSE
 {
  A=R4 P %On recup la direct bot
  ?Aã0 P SKIPYES
  {
   D1=(5)adrgp12CT
   C=DAT1 A
   D1=C
  }
  SKELSE
  {
   LC 1
   ?AãC P SKIPYES
   {
    D1=(5)adrgp22CT
    C=DAT1 A
    D1=C
   }
   SKELSE
   {
    LC 2
    ?AãC P SKIPYES
    {
     D1=(5)adrgp32CT
     C=DAT1 A
     D1=C
    }
    SKELSE
    {
    %C'est forcement le grob4
     D1=(5)adrgp42CT
     C=DAT1 A
     D1=C
    }
   }
  }
 }

*finselectgrobaffbot

P=0

%Je mets le decalage ds B.15
A=R1 A
D0=A
A=DAT0 X
LC 3
C&A P
P=C 0  %On fait passer C.0 en
C=P 15 %C.15 par l'intermed de P
P=15
B=C P %Le decal est stocke en B15
P=0
A=R2 A
D0=A %D0 pointe la ou on va aff
%le grob sur lecran

%Init compteur bcl dans As
P=15
LC 7

%bcl
*raffbots
C=0 X
C=DAT1 B
{
 %Decalage (on fait pas de gosub,
 %ca fait perdre trop de tps)
 A=B P A-1 P
 EXITC
 C=C+C X
 A-1 P
 EXITC
 C=C+C X
 A-1 P
 EXITC
 C=C+C X
 %Fin decal
}
B=C X
D1+ 2
C=0 X
C=DAT1 B
{
 %Decalage (on fait pas de gosub,
 %ca fait perdre trop de tps)
 A=B P A-1 P
 EXITC
 C=C+C X
 A-1 P
 EXITC
 C=C+C X
 A-1 P
 EXITC
 C=C+C X
 %Fin decal
}
A=DAT0 3
A=A!B X
A=A-C X
DAT0=A 3
D1+ 2
%fin
C=0 X
C=DAT1 B
{
 %Decalage (on fait pas de gosub,
 %ca fait perdre trop de tps)
 A=B P A-1 P
 EXITC
 C=C+C X
 A-1 P
 EXITC
 C=C+C X
 A-1 P
 EXITC
 C=C+C X
 %Fin decal
}
D0+ 34
A=DAT0 3
A=A!B X
A=A-C X
DAT0=A 3
D1+ 2 D0+ 34
%fin
C-1 S
GOTONC raffbots
P=0

RTN

%Effacage de lecran a lendroit
%ou etait le bot en y aff
%le fond sauvegardÈ

*effacebot

A=R2 A
D0=A
?ST=1 0 SKIPYES
{
  D0=(5)AdrSCREEN1 C=DAT0.A
}
SKELSE
{
 D0=(5)AdrSCREEN2 C=DAT0.A
}
A-C A
D1=(5)adrsavfondecran
C=DAT1 A C+A A D1=C
{
 A=DAT1 3
 DAT0=A 3
 D0+ 34
 D1+ 34
 P+1
 UPNC
}

RTN

%Test de collision du bot
%Entrees: A.x: CoordsY
%         R2.x: CoordsX
%Sorties: A.p:øÔpe de la case o˙
%              sera le bot si il
%              va sur cette case

*tstcolbot

ASRB X
ASRB X
ASRB X %/8 pque c des cases
C=0 A
D0=(5)nbcasebddnivx
C=DAT0 B
GOSBVL 03991
A=0 A
A=R2 X
ASRB X
ASRB X
ASRB X %A/8 pque c d cases
A+B X
%On a la position du bot
%ds la bdd dans le cas ou le depl
%acement vers la d est acceptÈ ds
%Ax
D0=(5)adrbddobj
C=DAT0 A
C=C+A A
D0=C
A=DAT0 1
RTN

%Test de collision bot avec les
%autres bots et le j1
%Entrees: B.x: CoordsX
%         D.x: CoordsY
%         B.s: Nbbot EC
%Sorties: Carry0: C bon
%         Carry1: Bot ou j1 qui
%                 gene

*tstcolbotothers

%Test de collision avec le j1
D0=(5)coordpixj1x
C=DAT0 X
C+7 X
C-B X
LA 00F
?C<A X ç
{
 D0=(5)coordpixj1y
 C=DAT0 X
 C+7 X
 C-D X
 ?C<A X ç
 {
  RTNSC
 }
}

%Le bot n'entre pas en collision
%avec le j1

%Le test de collition avec les au
%tres bots est buggÈ, on ne l'exe
%cute pas
%On retourne en passant la cary a
%0
RTNCC

%Test de collision avec les autre
%s bots

D0=(5)nbbots
A=DAT0 S
A-1 S %As: nbbots a tester
D0=(5)adrtabcoordsbots
A=DAT0 A
D0=A
D=0 S

{
 C=DAT0 X
 C+7 X
 C-B X
 LA 00F
 ?C<A X ç
 {
  D0+3
  C=DAT0 X
  C+7 X
  C-D X
  ?C<A X ç
  {
   %On teste si c'est le bot
   %qui rentre en collision
   %avec lui meme
   C=D S
   ?CãB S ç
   {
    %On rentre en collision
    %avec un autre bot
    RTNSC
   }
   %Sinon c'est qu'on rentre
   %en collision avec nous meme
  }
 }
 D0+3
 D+1 S
 C=D S
 ?CäA S ç
 {
  EXIT2
 }
 UP
 %C-A S
 %UPC
 %C-1 S %Pour le dernier bot
 %UPC
}

%On retourne en passant la cary a
%0
RTNCC

@