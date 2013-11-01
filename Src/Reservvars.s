%On reserve en mem les variables
%qui seront utilisees plus tard

CP=822B7 %En fait c'est 822B2 + 5
%car on a dja 5q pour enreg l'adr
%de la pile

%Adresse ecran 1
DCCP 5 AdrSCREEN1
%Adresse ecran 2
DCCP 5 AdrSCREEN2

%Contraste de l'utilisateur qd
%il lance le jeu
DCCP 1 ctrstuser101
DCCP 1 ctrstuser102
%Contraste qu'a choisi l'ulilisat
%eur pour jouer
DCCP 1 ctrstjeu101
DCCP 1 ctrstjeu102
%Variable decrementable suivant
%le nombre d'operation a faire,
%et qui determine la duree de la
%boucle de ralentissement
DCCP 5 Ralentissement
%Active ou pas:
%Rafraichissement des bots
DCCP 1 YNAffBots
%Rafraichissement du j1
DCCP 1 YNAffJ1
%Rafraichissement du niveau
DCCP 1 YNAffLevel
%Rafraichissement des impacts
DCCP 1 YNAffImpacts
%Nb du tstt a utiliser
DCCP 1 NBTsttUse


%Adresse des differents
%grobs representant le
%joueur
DCCP 5 adrgp1T
DCCP 5 adrgp2T
DCCP 5 adrgp3T
DCCP 5 adrgp4T
DCCP 5 adrgp12T
DCCP 5 adrgp22T
DCCP 5 adrgp32T
DCCP 5 adrgp42T
DCCP 5 adrgp1CT
DCCP 5 adrgp2CT
DCCP 5 adrgp3CT
DCCP 5 adrgp4CT
DCCP 5 adrgp12CT
DCCP 5 adrgp22CT
DCCP 5 adrgp32CT
DCCP 5 adrgp42CT

%Position x du joueur en pixel
%sur le niveau entier
DCCP 3 coordpixj1x
%Position y du joueur en pixel
%sur le niveau entier
DCCP 3 coordpixj1y
%Position du joueur en pixel
%sur l'ecran de jeu
DCCP 5 coordpixj1scr
%Numero de la zone o˙ se trouve
%le j1
DCCP 2 nbzonej1
%Direction du j1
DCCP 1 directj1
%Direction des bots
DCCP 11 directbots
%Adresse du tableau des coords
%des bots
DCCP 5 adrtabcoordsbots
%Adresse du tableau des mouvement
%s que le bot doit executer
DCCP 5 adrtabmouvbots
%Adresse du tableau indiquant
%combien de choses le bot a ·
%faire dans le tableau des mouv
DCCP 5 adrtabnbmouvbots

%Position de l'ecran en cases x
%sur le niveau
DCCP 2 nbcasescrx
%Position de l'ecran en cases y
%sur le niveau
DCCP 2 nbcasescry
%Numero de la case sur la bdd
%du debut de lecran ou se trouve
%le j1 en partant du haut
DCCP 5 nbcasescr

%Adresse du file dinfo sur le
%nivo
DCCP 5 adrinfonivo
%Adresse du depart des textures
DCCP 5 adrgwad
%Adr de la bdd du nivo des wad 1
%cad celle qui pointe sur le grob
%de la wad
DCCP 5 adrbddwad1
%Adr de la bdd du nivo des wad 2
%cad celle qui pointe sur la wad
DCCP 5 adrbddwad2
%Adr de la bdd du nivo des objets
%cad kel contient le numero
%symbolisant l'objet que forme
%chaque texture
DCCP 5 adrbddobj
%Adresse de la bdd du niveau deco
%upÈ en zones
DCCP 5 adrbddzones
%Adresse du fichier o˙ st stoquÈ
%les itinÈraires inter-zones pour
%l'IA
DCCP 5 adrItinerairezones
%Adresse du fichier o˙ sont stoqu
%Ès les coords des Wp
DCCP 5 adrListeWP
%Adresse du fichier o˙ sont listÈ
%les WP (par zone)
DCCP 5 adrListeWPparZones

%Nb de case que comporte le nivo
%horizontalement
DCCP 2 nbcasebddnivx
%Nb de pix  que comporte le nivo
%horizontalement
DCCP 3 nbpixbddnivx
%Nb de case a sauter dans la bdd
%pour passer a la ligne suivante
% = marge a droite de la bdd
DCCP 2 nbcasebddmdroite
%Nb de case que comporte le nivo
%verticalement
DCCP 2 nbcasebddnivy
%Nb de pix que comporte le nivo
%verticalement
DCCP 3 nbpixbddnivy
%Numero de la case X de l'initpoi
%nt Terro sur le niveau
DCCP 2 nbcaseinipointTx
%Numero de la case Y de l'initpoi
%nt Terro sur le niveau
DCCP 2 nbcaseinipointTy
%Numero de la case X de l'initpoi
%nt Counter sur le niveau
DCCP 2 nbcaseinipointCTx
%Numero de la case Y de l'initpoi
%nt Counter sur le niveau
DCCP 2 nbcaseinipointCTy
%CoordonnÈs X du point de pose
%de bombe en pix
DCCP 3 coordsXposebombe
%CoordonnÈs Y du point de pose
%de bombe en pix
DCCP 3 coordsYposebombe
%Nombre de zones que comporte le
%niveau
DCCP 2 Nbzoneslevel
%Nombre de WayPoints que comporte
%le niveau
DCCP 2 Nbwplevel
%Combien de quartets faut il saut
%er pour passer d'une zone a une
%autre dans le fichier d'itinÈrai
%re inter-zones
DCCP 3 mdroiteitineraireinterzone
%Numero de la zone de l'initpoint
%Terro
DCCP 2 nbzoneinitpointT
%Numero de la zone de l'initpoint
%Counter
DCCP 2 nbzoneinitpointCT
%Numero de la zone de la zone C4
DCCP 2 nbzoneC4

%Adresse ou est sauvegardÈ le fon
%d pur de ce qui est aff a l'ecra
%n
DCCP 5 adrsavfondecran

%Adresse du grob du logo de Cs2d
DCCP 5 adrLogoCs
%Adresse de la font6
DCCP 5 adrfont6

%Adresse du tableau des balles
%du j1
DCCP 5 adrtbtirj1
%Numero de la position du viseur
%dans le tableau de coord precalc
DCCP 2 posviseur
%Nombre de tirs du j1 En Cours
DCCP 1 nbtirecj1
%Etat de l'activation des 16 tirs
%du j1
DCCP 16 etattirsj1
%Adresse a laquelle on a aff le
%viseur (a add avec l'adresse
%en haut a gauche d'un ecran)
DCCP 5 adrsavfondvis
%Adr du tableau des coords precal
%cules du viseur
DCCP 5 tablcoordvise
%Adr du tableau des coords precal
%culÈs de l'incrementation des co
%ords des balles
DCCP 5 tablcoordballes
%Derniere position liberee dans
%le tableau des coords des
%tirs
DCCP 2 tbtirj1lastfree
%Adresse du tableau o˙ se trouven
%t les coords des impacts des
%balles ST=0.1
DCCP 5 adrtabimpactsballe0j1
%Indique a quel endroit on peut
%ecrire dans le tableau des coord
%s des impacts ST=0.1
DCCP 2 compteurtabimpactsballe0j1
%Adresse du tableau o˙ se trouven
%t les coords des impacts des
%balles ST=1.1
DCCP 5 adrtabimpactsballe1j1
%Indique a quel endroit on peut
%ecrire dans le tableau des coord
%s des impacts ST=1.1
DCCP 2 compteurtabimpactsballe1j1

%Niveau de vie du j1
DCCP 2 Lifej1
%Niveau de vie du j1
DCCP 2 Armuj1
%Le j1 a t'il selectionnÈ son arm
%e primaire ou secondaire ou autr
%e ?
DCCP 1 weapselectj1
%Quelle arme primaire  le j1 a 
%t'il ?
DCCP 1 typeweapprimj1
%Sauvegarde de l'arme primaire
%possedee par le j1
DCCP 1 savtypeweapprimj1
%Nb de balles que le j1 possede
%pour son arme primaire
DCCP 2 amoj1prim
%Nb de balles que le j1 possede
%pour son arme primaire ds le
%chargeur
DCCP 2 amochargj1prim
%Nb de balles que le j1 possede
%pour son arme secondaire
DCCP 2 amoj1second
%Nb de balles que le j1 possede
%pour son arme secondaire ds le
%chargeur
DCCP 2 amochargj1second
%Nombres d'armes tertiaire que le
%j1 possede
DCCP 2 nbweapon3
%Argent du j1 (en $)
DCCP 5 argentj1
%Etat du rechargement des armes
%du j1
DCCP 2 rechargeweapj1

%Nb de CT dans la partie
DCCP 1 nbCT
%Nb de T dans la partie
DCCP 1 nbT
%Nombre de bots dans la partie
DCCP 1 nbbots
%Statut du joueur 1
DCCP 1 stj1
%Statut des bots
DCCP 11 stbots
%Adresse du tableau des numeros
%des zone dans lesquelles se
%trouve chaque bot
DCCP 5 adrtabnbzonebots

%Sauvegarde du reg R3 dans le mna
DCCP 5 mnaR3
%Sauvegarde du reg R4 dans le mna
DCCP 5 mnaR4
%Sauvegarde du reg R1 dans le mna
DCCP 1 mnaR1

%Timer C4
DCCP 2 TimerC4

%No de la ligne du buffer qui
%correspond a ski est mark en bas
%de lecran de la console
DCCP 2 CslLigneBImgOnBuffer
%No de la plus recente ligne dans
%le buffer
DCCP 2 CslLastLigneBuffer
%Nb de lignes du buffer de la csl
DCCP 2 CslNbLigneBuffer
%Adresse a partir de laquelle
%on sort du buffer
DCCP 5 CslOutBuffer
%Adresse du buffer
DCCP 5 CslAdrBuffer
%Adresse du buffer du la ligne de
%commande
DCCP 5 CslAdrBufferCmd
%Position du curseur
DCCP 1 CslPositCurs
%Flag dappuis sur 1 touche alphab
DCCP 1 CslToucheAlphP
%Flag dindik de ouveau message
%a aff ds la csl
DCCP 1 CslNewMsg

%Adresse du grob quon cree pour
%precalculer le menutalk
DCCP 5 adrgmenutalk

%Adresse du grob du menu d'achat
DCCP 5 adrMnAchat
%Adresse du grob du decor qui
%entour les prix pdt l'achat
DCCP 5 adrgmnaentourprix
%Adresse du grob de confirmation
%de l'achat
DCCP 5 adrgmnaconfirm

%Adresse du grob de l'ico vies
DCCP 5 adrgicovies
%Adresse du grob de l'ico armure
DCCP 5 adrgicoarmu
%Adresse du grob de l'ico mp5
DCCP 5 adrgicomp5
%Adresse du grob de l'ico gun
DCCP 5 adrgicogun
%Adresse du grob de l'ico couteau
DCCP 5 adrgicocouteau
%Adresse du grob de l'ico pompe
DCCP 5 adrgicopompe

%Reserv 1 tableau pour les coord
%des balles (16q*16tirs)dec
LC 00100
RES.STR
A=D0
D0=(5)adrtbtirj1
DAT0=A A
%Reserv 1 tableau pour les coord
%des impacts des balles ST=0 1
%(6q*16tirs)dec
LC 00060
RES.STR
A=D0
D0=(5)adrtabimpactsballe0j1
DAT0=A A
%Reserv 1 tableau pour les coord
%des impacts des balles ST=1 1
%(6q*16tirs)dec
LC 00060
RES.STR
A=D0
D0=(5)adrtabimpactsballe1j1
DAT0=A A
%Reserv une zone pour sauver le
%fond pur de ce qui est aff sur
%l'ecran
%La zone fait 34q*64l*2grs=3840q
LC 01100
RES.STR
A=D0
D0=(5)adrsavfondecran
DAT0=A A

%Reserv 1 tableau pour les coords
%des bots (pixX et pixY sur le ni
%veau entier)
%6q * 11bots
LC 00042
RES.STR
A=D0
D0=(5)adrtabcoordsbots
DAT0=A A

%Tableau des mouvements que le
%bot doit executer
%(8q/mouv * 20mouv * 11bots)
% = 1760d = 6E0h
LC 006E0
RES.STR
A=D0
D0=(5)adrtabmouvbots
DAT0=A A

%Tableau qui indique combien de
%choses un bot a a faire dans le
%tableau des mouvements des bots
LC 00016
RES.STR
A=D0
D0=(5)adrtabnbmouvbots
DAT0=A A

%Tableau qui indique le numero
%de la zone dans laquelle se trou
%ve chaque bot
%2q*11bots
LC 00016
RES.STR
A=D0
D0=(5)adrtabnbzonebots
DAT0=A A

%Grob du menutalk
%18q large * 36lignes haut 4grs
%= 1296d = 510h
LC 00510
RES.STR
A=D0
D0=(5)adrgmenutalk
DAT0=A A

%Buffer console
%30q * 30 lignes
%= 900d = 384h
LC 00384
RES.STR
A=D0
D0=(5)CslAdrBuffer
DAT0=A A

%Buffer ligne de comande
%16char = 16o = 10h
LC 00010
RES.STR
A=D0
D0=(5)CslAdrBufferCmd
DAT0=A A

%Reservation du SCREEN1
%34q * 2grs * 64l + 1 = 1101h 
LC 01101
RES.STR
A=D0 C=A.A
?CBIT=1.0 ç
{
 %Adr impaire
 C+1.A
}
D0=(5)AdrSCREEN1
DAT0=C A

%Reservation du SCREEN2
%34q * 2grs * 64l + 1 = 1101h
LC 01101
RES.STR
A=D0 C=A.A
?CBIT=1.0 ç
{
 %Adr impaire
 C+1.A
}
D0=(5)AdrSCREEN2
DAT0=C A

@