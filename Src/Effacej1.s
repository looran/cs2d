%Effacage de lecran a lendroit
%ou etait le joueur en y aff
%le fond sauvegardé

*effacej1

%On teste si laff j1 active
D0=(5)YNAffJ1 A=DAT0.P
?A=0.P RTNYES

D0=(5)coordpixj1scr
A=DAT0 A
?ST=1 0 SKIPYES
{
 D0=(5)AdrSCREEN1 C=DAT0.A
}
SKELSE
{
 D0=(5)AdrSCREEN2 C=DAT0.A
}
C+A A
D0=C
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

%Efface le viseur
GOSUBL effacevis

RTN

@