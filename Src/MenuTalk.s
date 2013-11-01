
%Tout ce qui concerne le dialogue
%Permet de donner des ordres aux
%bots, de leur 'parler'
%Les messages seront aussi visibl
%es sur les autres caltos connect
%ees si le mode reseau voit le
%jour

%Affichage du menu de dialogue
%avec son equipe

*Aff1MenuTalk2Team

GOSBVL Flush

%On dit dexec le tstt menutalk
D0=(5)NBTsttUse LC 1 DAT0=C.P

*AffMenuTalk2Team

%On affiche les choix noir sur
%gris clair en font6
%Choix:
% 1- GoGoGo
% 2- Regroup Team
% 3- Fall Back
% 4- Report In
% 5- Need Backup
% 6- Follow me

%On decremente le ralentissement
LC 00100
GOSUBL Decrralentissement

%On affiche le grob quon a precal
%c
?ST=1 0 SKIPYES
{
 D0=(5)AdrSCREEN1 C=DAT0.A D0=C
}
SKELSE
{
 D0=(5)AdrSCREEN2 C=DAT0.A D0=C
}

D1=(5)adrgmenutalk C=DAT1.A D1=C
LC 23 D=C.B
{
 A=DAT1.16 B=A.W
 DAT0=A.16
 D1+16 D0+16
 A=DAT1.B R1=A.B
 DAT0=A.B
 D1+2 D0+18
 
 A=DAT1.16 C=DAT0.16 C!B.W
 A&C.W
 DAT0=A.16
 D1+16 D0+16
 C=DAT0.B A=R1.B C!A.B
 A=DAT1.B A&C.B
 DAT0=A.B
 D1+2 D0+18
 
 D-1.B UPNC
}

RTN

%Tstt du menutalk
*tsttmenutalk

%On rafraichit le menutalk
GOSUB AffMenuTalk2Team

%Test msg 1 (F1)
LC 020
OUT=C
C=IN2
?CBIT=1 0 ç
{
 GOTOL mna2game
}

%Test msg 2 (F2)
LC 020
OUT=C
C=IN2
?CBIT=1 1 ç
{
 GOTOL mna2game
}

%Test msg 3 (F3)
LC 020
OUT=C
C=IN2
?CBIT=1 2 ç
{
 GOTOL mna2game
}

%Test msg 4 (F4)
LC 020
OUT=C
C=IN2
?CBIT=1 3 ç
{
 GOTOL mna2game
}

%Test msg 5 (F5)
LC 020
OUT=C
C=IN2
?CBIT=1 4 ç
{
 GOTOL mna2game
}

%Test msg 6 (F6)
LC 020
OUT=C
C=IN2
?CBIT=1 5 ç
{
 GOTOL mna2game
}

%Test annul
LC 020
OUT=C
C=IN2
?CBIT=1 7 ç
{
 GOTOL mna2game
}

RTN

@