%On recupere l'adresse des fichie
%rs que le jeu va utiliser
*includefiles

%Recup de l'adr du
%grob p1T
GOSUB lap1T
/p1T
*lap1T
C=RSTK
D0=(5)adrgp1T
DAT0=C A

%Recup de l'adr du
%grob p2T
GOSUB lap2T
/p2T
*lap2T
C=RSTK
D0=(5)adrgp2T
DAT0=C A

%Recup de l'adr du
%grob p3
GOSUB lap3T
/p3T
*lap3T
C=RSTK
D0=(5)adrgp3T
DAT0=C A

%Recup de l'adr du
%grob p4T
GOSUB lap4T
/p4T
*lap4T
C=RSTK
D0=(5)adrgp4T
DAT0=C A

%Recup de l'adr du
%grob p12T
GOSUB lap12T
/p12T
*lap12T
C=RSTK
D0=(5)adrgp12T
DAT0=C A

%Recup de l'adr du
%grob p22T
GOSUB lap22T
/p22T
*lap22T
C=RSTK
D0=(5)adrgp22T
DAT0=C A

%Recup de l'adr du
%grob p32T
GOSUB lap32T
/p32T
*lap32T
C=RSTK
D0=(5)adrgp32T
DAT0=C A

%Recup de l'adr du
%grob p42T
GOSUB lap42T
/p42T
*lap42T
C=RSTK
D0=(5)adrgp42T
DAT0=C A

%Recup de l'adr du
%grob p1CT
GOSUB lap1CT
/p1CT
*lap1CT
C=RSTK
D0=(5)adrgp1CT
DAT0=C A

%Recup de l'adr du
%grob p2CT
GOSUB lap2CT
/p2CT
*lap2CT
C=RSTK
D0=(5)adrgp2CT
DAT0=C A

%Recup de l'adr du
%grob p3CT
GOSUB lap3CT
/p3CT
*lap3CT
C=RSTK
D0=(5)adrgp3CT
DAT0=C A

%Recup de l'adr du
%grob p4CT
GOSUB lap4CT
/p4CT
*lap4CT
C=RSTK
D0=(5)adrgp4CT
DAT0=C A

%Recup de l'adr du
%grob p12CT
GOSUB lap12CT
/p12CT
*lap12CT
C=RSTK
D0=(5)adrgp12CT
DAT0=C A

%Recup de l'adr du
%grob p22CT
GOSUB lap22CT
/p22CT
*lap22CT
C=RSTK
D0=(5)adrgp22CT
DAT0=C A

%Recup de l'adr du
%grob p32CT
GOSUB lap32CT
/p32CT
*lap32CT
C=RSTK
D0=(5)adrgp32CT
DAT0=C A

%Recup de l'adr du
%grob p42CT
GOSUB lap42CT
/p42CT
*lap42CT
C=RSTK
D0=(5)adrgp42CT
DAT0=C A

%Recup de l'adresse du fichier
%des coord precalcs du viseur
SKUBL { /tablcoordvise }
C=RSTK
D0=(5)tablcoordvise
DAT0=C A

%Recup de l'adresse du fichier
%des coord precalcs du viseur
SKUBL { /tablcoordballes }
C=RSTK
D0=(5)tablcoordballes
DAT0=C A

%Recup de l'adresse du grob du
%logo du jeu
A=PC GOINC lalogocs A+C.A
D0=(5)adrLogoCs
DAT0=A A

%On recupere la font6 qui est sur
%la pile
D0=(5)adrpile C=DAT0.A D0=C
A=DAT0.A LC 00020 A+C.A
D0=(5)adrfont6
DAT0=A.A

%Recup de l'adr du
%grob menu d'achat
GOSUBL lamna
/imgmenuachat
*lamna
C=RSTK
D0=(5)adrMnAchat
DAT0=C A

%Recup de l'adr du
%grob du decor autour des prix pd
%t l'achat
GOSUBL lamnaentourprix
/imgmnaentourprix
*lamnaentourprix
C=RSTK
D0=(5)adrgmnaentourprix
DAT0=C A

%Recup de l'adr du
%grob de confirmation de l'achat
GOSUBL lamnaconfirm
/imgmnaconfirm
*lamnaconfirm
C=RSTK
D0=(5)adrgmnaconfirm
DAT0=C A

%Recup de l'adr du
%grob ico vies
GOSUB laicovies
/icovies
*laicovies
C=RSTK
D0=(5)adrgicovies
DAT0=C A

%Recup de l'adr du
%grob ico armu
GOSUB laicoarmu
/icoarmu
*laicoarmu
C=RSTK
D0=(5)adrgicoarmu
DAT0=C A

%Recup de l'adr du
%grob ico mp5
GOSUB laicomp5
/icomp5
*laicomp5
C=RSTK
D0=(5)adrgicomp5
DAT0=C A

%Recup de l'adr du
%grob ico gun
GOSUB laicogun
/icogun
*laicogun
C=RSTK
D0=(5)adrgicogun
DAT0=C A

%Recup de l'adr du
%grob ico couteau
GOSUB laicocouteau
/icocouteau
*laicocouteau
C=RSTK
D0=(5)adrgicocouteau
DAT0=C A

%Recup de l'adr du
%grob ico pompe
GOSUB laicopompe
/icopompe
*laicopompe
C=RSTK
D0=(5)adrgicopompe
DAT0=C A

RTN

*recupniveaudemo001

%Recuperation de l'adresse du
%niveau situé dans la pile
%D1=806F8 C=DAT1.A D1=C
%D0=(5)DEBMONSTRE
%A=DAT1.A
%A+10.A DAT0=A.A
%D1+5
%A=DAT1.A A+10.A D1=A
%LC 0002E A+C.A
%D0=(5)@NIV DAT0=A.A

%Recup de l'adr du grob des
%textures
GOSUB lawad.demo001
/wad.demo001
*lawad.demo001
C=RSTK
D0=(5)adrgwad
DAT0=C A

%Recup de l'adresse de la bdd
%du niveau pour les wad
GOSUB labddwad1.demo001
/bddwad1.demo001
*labddwad1.demo001
C=RSTK
D0=(5)adrbddwad1
DAT0=C A

%Recup de l'adresse de la bdd
%du niveau pour les wad
GOSUB labddwad2.demo001
/bddwad2.demo001
*labddwad2.demo001
C=RSTK
D0=(5)adrbddwad2
DAT0=C A

%Recup de l'adresse de la bdd
%du nivo des objets
GOSUB labddobj.demo001
/bddobj.demo001
*labddobj.demo001
C=RSTK
D0=(5)adrbddobj
DAT0=C A

%Recup de l'adresse de la bdd
%du nivo découpé en zones
GOSUB labddzones.demo001
/bddzones.demo001
*labddzones.demo001
C=RSTK
D0=(5)adrbddzones
DAT0=C A

%Recup de l'adresse du file
%dinfos du nivo
GOSUB lainfonivo.demo001
/infonivo.demo001
*lainfonivo.demo001
C=RSTK
D0=(5)adrinfonivo
DAT0=C A

%Recup de l'adresse du file
%d'itinéraire inter-zones
GOSUBL laItinerairezones.demo001
/Itinerairezones.demo001
*laItinerairezones.demo001
C=RSTK
D0=(5)adrItinerairezones
DAT0=C A

%Recup de l'adresse du file
%de la liste des coords des WP
%du level
GOSUB laListeWP.demo001
/ListeWP.demo001
*laListeWP.demo001
C=RSTK
D0=(5)adrListeWP
DAT0=C A

%Recup de l'adresse du file
%de la liste des WP par zones du
%level
GOSUB laListeWPparZones.demo001
/ListeWPparZones.demo001
*laListeWPparZones.demo001
C=RSTK
D0=(5)adrListeWPparZones
DAT0=C A

RTN

@