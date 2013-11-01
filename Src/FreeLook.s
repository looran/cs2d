
%Tout ce qui concerne le Free
%Look Mode

%Mise en place du FreeLookMode
*SetFreeLook

%On indique que le test de touch
%doit etre celui du FreeLook
D0=(5)NBTsttUse LC 4 DAT0=C.P
%Interdiction Aff j1
C=0.P
D0=(5)YNAffJ1 DAT0=C.P

RTN

%Tstt du freelookmode
*tsttfreelook

%Tst fleche o
LC 040
OUT=C
C=IN2
?CBIT=1 3 ç
{
 %Tst bord niveau
 D0=(5)nbcasescry A=DAT0.B
 ?A=0.B ç
 {
  EXIT2 %On est en o
 }
 %Prepar decal
 P=12 LC 1 R0=C.P P=0
 ST=1.2
}

%Tst fleche bas
LC 040
OUT=C
C=IN2
?CBIT=1 1 ç
{
 %Tst bord niveau
 D0=(5)nbcasescry A=DAT0.B
 D0=(5)nbcasebddnivy
 C=DAT0 B C-8 B
 ?AäC.B ç
 {
  EXIT2 %On est en b
 }
 %Prepar decal
 P=13 LC 1 R0=C.P P=0
 ST=1.3
}

%Tst fleche gauche
LC 040
OUT=C
C=IN2
?CBIT=1 2 ç
{
 %Tst bord niveau
 D0=(5)nbcasescrx A=DAT0.B
 ?A=0.B ç
 {
  EXIT2 %On est a g
 }
 %Prepar decal
 P=14 LC 1 R0=C.P P=0
 ST=1.4
}

%Tst fleche droite
LC 040
OUT=C
C=IN2
?CBIT=1 0 ç
{
 %Tst bord niveau
 D0=(5)nbcasescrx A=DAT0.B
 D0=(5)nbcasebddnivx
 C=DAT0 B C-15 B
 ?AäC.B ç
 {
  EXIT2 %On est a d
 }
 %Prepar decal
 P=15 LC 1 R0=C.P P=0
 ST=1.5
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
 GOSUBL Alert
 %Restaure le contraste
 C=R1 P
 D0=00101
 DAT0=C 1
 C=R2 P
 D0=00102
 DAT0=C 1
}

RTN

@