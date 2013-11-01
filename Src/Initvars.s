%Init vars
*initvars

%On va regarder cbien mesure le
%nivo en x et y,stoker les
%mesures,et calc la mdroite
%On va aussi reperer les initpoin
%ts, l'endroit o˙ poser la bombe,
%et le nb de zones et waypoints
%que comporte le niveau, ainsi
%que combien de quartets faut il
%sauter pour passer d'une zone a
%une autre dans le fichier
%d'itinÈraire inter-zones
%ATTENTION : les donnees etant
%stoke a la base a lenvers, elle
%sont dja a lendroit qd on lÈ li
D0=(5)adrinfonivo
A=DAT0 A
D0=A
A=DAT0 B
D1=(5)nbcasebddnivx
DAT1=A B
C=0 X
C=A B
D1=(5)nbpixbddnivx
C+C X
C+C X
C+C X
DAT1=C X
A-16 B
D1=(5)nbcasebddmdroite
DAT1=A B
D0+2
A=DAT0 B
D1=(5)nbcasebddnivy
DAT1=A B
C=0 X
C=A B
D1=(5)nbpixbddnivy
C+C X
C+C X
C+C X
DAT1=C B
%Maintenant on va recuperer les
%coords des initpoints T et CT xy
D0+2
A=DAT0 B
D1=(5)nbcaseinipointTx
DAT1=A B
D0+2
A=DAT0 B
D1=(5)nbcaseinipointTy
DAT1=A B
D0+2
A=DAT0 B
D1=(5)nbcaseinipointCTx
DAT1=A B
D0+2
A=DAT0 B
D1=(5)nbcaseinipointCTy
DAT1=A B
%On recupere les coords de l'endr
%oit o˙ on doit poser la bombe
D0+2 A=DAT0 X
D1=(5)coordsXposebombe
DAT1=A X
D0+3 A=DAT0 X
D1=(5)coordsYposebombe
DAT1=A X
%Le nombre de zones dont est comp
%osÈ le niveau
D0+3 A=DAT0 B
D1=(5)Nbzoneslevel
DAT1=A B
%Le nb de WayPoints dont est comp
%osÈ le niveau
D0+2 A=DAT0 B
D1=(5)Nbwplevel
DAT1=A B
%Combien de q faut il sauter pour
%aller de zones en zones dans la
%liste des itinÈraires inter-zone
%s
D0+2 A=DAT0 X
D1=(5)mdroiteitineraireinterzone
DAT1=A X
%Zone de l'initpoint T
D0+3 A=DAT0 B
D1=(5)nbzoneinitpointT
DAT1=A B
%Zone de l'initpoint CT
D0+2 A=DAT0 B
D1=(5)nbzoneinitpointCT
DAT1=A B
%Zone du C4
D0+2 A=DAT0 B
D1=(5)nbzoneC4
DAT1=A B

%Coords init du j1 et de l'ecran
%Les coords du j1 st initialisÈs
%suivant les initpoints
D0=(5)stj1
C=DAT0 P
?CBIT=0 2 ç
{
 %C'est un Terro
 %On init les X
 D0=(5)nbcaseinipointTx
 C=0 X
 C=DAT0 B
 C+C X C+C X C+C X % caseçpix
 D0=(5)coordpixj1x
 DAT0=C X
 %On init les Y
 D0=(5)nbcaseinipointTy
 C=0 X
 C=DAT0 B
 C+C X C+C X C+C X % caseçpix
 D0=(5)coordpixj1y
 DAT0=C X
}
SKELSE
{
 %C'est un Counter
 %On init les X
 D0=(5)nbcaseinipointCTx
 C=0 X
 C=DAT0 B
 C+C X C+C X C+C X % caseçpix
 D0=(5)coordpixj1x
 DAT0=C X
 %On init les Y
 D0=(5)nbcaseinipointCTy
 C=0 X
 C=DAT0 B
 C+C X C+C X C+C X % caseçpix
 D0=(5)coordpixj1y
 DAT0=C X
}
%Les coords de l'ecran sont chois
%is en centrant le perso au centr
%e du scr, puis en regardant si
%l'ecran sort du niveau.
%On fait les X
D0=(5)coordpixj1x
A=DAT0 X
ASRB X ASRB X ASRB X %pixçcase
LC 07
A-C B
SKIPNC
{
 %Si l'ecran depasse a gauche
 %on le met sur le bord du niveau
 A=0 B
 GOTO aftinitscrx %On passe le te
 %st de depassement a droite, car
 %on ne peut pas depasser a gauch
 %e ET a droite
}
D0=(5)nbcasebddnivx
C=DAT0 B
C-15 B
?A>C B ç
{
 %Si l'ecran depasse a droite, on
 %l'aligne avec le bord du niveau
 A=C B
}
*aftinitscrx
%Finalement on a dans A.b la posi
%tion de l'ecran X
D0=(5)nbcasescrx
DAT0=A B %On l'ecrit
%On fait les Y
D0=(5)coordpixj1y
A=DAT0 X
ASRB X ASRB X ASRB X %pixçcase
LC 03
A-C B
SKIPNC
{
 %Si l'ecran depasse a gauche
 %on le met sur le bord du niveau
 A=0 B
 GOTO aftinitscry %On passe le te
 %st de depassement a droite, car
 %on ne peut pas depasser a gauch
 %e ET a droite
}
D0=(5)nbcasebddnivy
C=DAT0 B
C-8 B
?A>C B ç
{
 %Si l'ecran depasse a droite, on
 %l'aligne avec le bord du niveau
 A=C B
}
*aftinitscry
%Finalement on a dans A.b la posi
%tion de l'ecran Y
D0=(5)nbcasescry
DAT0=A B %On l'ecrit
%On ecrit le nombre de cases tota
%les depuis le haut a gauche du
%niveau jusqu'a l'endroit o˙ se
%trouve l'ecran (scrY*nivx +scrX)
%scrY est encore dans A.b
C=0 A
C=A B
D0=(5)nbcasebddnivx
A=0 A
A=DAT0 B
GOSBVL 03991 %scrY*nivx
C=0 A
D0=(5)nbcasescrx
C=DAT0 B
C+B A %scrY*nivx +scrX
D0=(5)nbcasescr
DAT0=C A %On l'ecrit

D0=(5)directj1
LC 3
DAT0=C P
D0=(5)directbots
LC 11111111111
DAT0=C 11

D1=(5)posviseur
LC 01
DAT1=C B

%On active laff bots
D0=(5)YNAffBots LC 1 DAT0=C.P
%On active laff J1
D0=(5)YNAffJ1 LC 1 DAT0=C.P
%On active laff level
D0=(5)YNAffLevel LC 1 DAT0=C.P
%On active laff impacts
D0=(5)YNAffImpacts LC 1 DAT0=C.P
%On met le tstt use a 0
D0=(5)NBTsttUse C=0.P DAT0=C.P

%Oo met a 0 le nb de bots ds la
%partie
D0=(5)nbbots
C=0 P
DAT0=C P

%On met les vies du j1 a 99
LC 99
D0=(5)Lifej1
DAT0=C B
%On met l'armure du j1 a 00
LC 00
D0=(5)Armuj1
DAT0=C B
%On dis que le j1 a son arme
%secondaire au debut
D0=(5)weapselectj1
LC 1
DAT0=C P
%On dis que le j1 n'a pas d'arme
%primaire au debut
D0=(5)typeweapprimj1
LC 0
DAT0=C P
%On mets les balles de larme seco
%ndaire du j1 a 24
D0=(5)amoj1second
LC 24
DAT0=C B
%On mets les balles de larme seco
%ndaire du j1 qui st ds le
%chargeur a 11
D0=(5)amochargj1second
LC 11
DAT0=C B
%Nombre d'armes tertiaires que
%le j1 possede
D0=(5)nbweapon3
LC 01
DAT0=C B
%On met l'argent du j1 a 4000$
D0=(5)argentj1
LC 04000
DAT0=C A
%On met l'etat du rechargement
%des armes du j1 a 0 (le j1 ne
%recharges pas pour le moment)
D0=(5)rechargeweapj1
C=0 B
DAT0=C B
%On met l'etat des tirs a 0
D0=(5)etattirsj1
C=0 W
DAT0=C W
%On desactive l'aff de l'impact
%des balles
D0=(5)compteurtabimpactsballe0j1
C=0 B
DAT0=C B
D0=(5)compteurtabimpactsballe1j1
C=0 B
DAT0=C B
%On met le nb de tirsEC du j1 a 0
D0=(5)nbtirecj1
C=0 P
DAT0=C P
%On met la derniere place liberee
%dans le tableau des tirs a 00
D0=(5)tbtirj1lastfree
C=0 B
DAT0=C B

%On init le buffer de la console
D0=(5)CslAdrBuffer A=DAT0.A D0=A
LC 0000303730307343 DAT0=C.16
%...
%On met le no de la derniere
%ligne du buffer a 3
D0=(5)CslLastLigneBuffer
LC 02 DAT0=C.B
%Nb de ligne use ds le buf = 3
D0=(5)CslNbLigneBuffer
LC 03 DAT0=C.B
%Position du curseur a 0
D0=(5)CslPositCurs
C=0.P DAT0=C.P
%Touche Appuyee ? Oui
D0=(5)CslToucheAlphP LC 1 DAT0=C.P
%Buffer ligne de commande = vide,
%avec curseus au debut
D0=(5)CslAdrBufferCmd A=DAT0.A D0=A
A=0.W DAT0=A.16 LC 01 DAT0=C.B
D0+16 DAT0=A.16
%Init adr a partir de laquelle
%on sort du buffer
D0=(5)CslAdrBuffer A=DAT0.A
LC 00708 %60q * 30lignes
A+C.A
D0=(5)CslOutBuffer DAT0=A.A

%Mise a zero des flags
%0 a 11
CLRST

%Mise a 0 du timer C4
D0=(5)TimerC4
C=0 B
DAT0=C B

%Objet de la case ou se trouvent
%les playeurs dans
%R0.11 = 12 joueurs maxi (j1 inc
%lu).Les 4 autres q sont utilisee
%s par le nombre de case restant
%a decaler dans les 4 directions
P=11
C=0 WP
R0=C WP
P=0

%Mise a 0 des cases a decaler
%(bien que ca ne serve a rien
%car de tte facon les flags de
%decal ne st pas activÈs)
P=12
{
 C=0 P
 R0=C P
 P+1
 UPNC
}

%On met des 0 dans le tableau des
%mouvements des bots
%(taille: #006E0q )
D0=(5)adrtabmouvbots
C=DAT0.A D0=C
LC 6D
A=0.W
{
 DAT0=A.W
 D0+16
 C-1.B
 UPNC
}

%On precalcule le grob du menu
%talk, quon affichera ensuite
%sur lecran de jeu
%Choix:
% 1- GoGoGo
% 2- Regroup Team
% 3- Fall Back
% 4- Report In
% 5- Need Backup
% 6- Follow me

%Dabord on remplie le grob de
%gris clair
D0=(5)adrgmenutalk C=DAT0.A D0=C
LC 23 B=C.B
A=0.W C=0.W C-1.W
{
 DAT0=A.16 D0+16 DAT0=A.B D0+2
 DAT0=C.16 D0+16 DAT0=C.B D0+2
 B-1.B UPNC
}


D0=(5)adrgmenutalk
C=DAT0.A R1=C.A

%On va marquer 'Go Go Go'
D1=C
LC 6F47206F47206F47
B=C.W
LC 00012 R4=C.A
GOSUBL affchargrob1font6

%+ 6 lignes
A=R1.A LC 000D8 A+C.A R1=A.A

%On va marquer 'Regroup Team'
D1=A
LC 2070756F72676552
B=C.W
GOSUBL affchargrob1font6
A=R1.A A+12.A D1=A %+8 char
LC 000000006D616554
B=C.W
GOSUBL affchargrob1font6

%+ 6 lignes
A=R1.A LC 000D8 A+C.A R1=A.A

%On va marquer 'Fall Back'
D1=A
LC 636142206C6C6146
B=C.W
GOSUBL affchargrob1font6
A=R1.A A+12.A D1=A %+8 char
LC 000000000000006B
B=C.W
GOSUBL affchargrob1font6

%+ 6 lignes
A=R1.A LC 000D8 A+C.A R1=A.A

%On va marquer 'Report In'
D1=A
LC 492074726F706552
B=C.W
GOSUBL affchargrob1font6
A=R1.A A+12.A D1=A %+8 char
LC 000000000000006E
B=C.W
GOSUBL affchargrob1font6

%+ 6 lignes
A=R1.A LC 000D8 A+C.A R1=A.A

%On va marquer 'Need Backup'
D1=A
LC 636142206465654E
B=C.W
GOSUBL affchargrob1font6
A=R1.A A+12.A D1=A %+8 char
LC 000000000070756B
B=C.W
GOSUBL affchargrob1font6

%+ 6 lignes
A=R1.A LC 000D8 A+C.A R1=A.A

%On va marquer 'Follow me'
D1=A
LC 6D20776F6C6C6F46
B=C.W
GOSUBL affchargrob1font6
A=R1.A A+12.A D1=A %+8 char
LC 0000000000000065
B=C.W
GOSUBL affchargrob1font6

RTN

@