%Affichage de la presentation

*Presentation

%On se place sur le 1er ecran
D0=(5)AdrSCREEN1 C=DAT0.A
D1=(5)GreyScr1
DAT1=C A
D1=(5)GreyScr2
DAT1=C A
D1=(5)GreyScr3
D0=(5)AdrSCREEN1 C=DAT0.A C+34.A
DAT1=C A

D0=(5)Disp2Ctl
A=DAT0 A
D1=(5)GreySoft1
DAT1=A A
D1=(5)GreySoft2
DAT1=A A
D1=(5)GreySoft3
DAT1=A A
ST=0 0

%Effacage de tt lecran de jeu

D0=(5)AdrSCREEN1 A=DAT0.A D0=A
A=0 W
LC 10F
{
 DAT0=A W
 D0+ 16
 C-1 X
 UPNC
}

%Affichage de l'ecran de presenta
%tion

D0=(5)adrLogoCs
A=DAT0 A
D0=A
D1=(5)AdrSCREEN1 A=DAT1.A D1=A
P=0
LC 7F
B=C B
{
 C=DAT0 16
 DAT1=C 16
 D0+16
 D1+16
 C=DAT0 16
 DAT1=C 16
 D0+16
 D1+16
 C=DAT0 B
 DAT1=C B
 D0+2
 D1+2
 B-1 B
 UPNC
}

%On fait une jolie transition en
%mettant le contraste a #D
%Pourquoi #D ?
%Pourquoi pas :)
LC D B=C.P
B=0.S
GOSUBL transitionbaissectrste

%On met la derniere touche appuy
%ee a 0
D=0 P
%On met le flag dappuis sur 1 tch
%a 0
ST=0 11

%Atteote de ENTER et ajustage
%du contraste
{
 %Test ENTER
 LC 001
 OUT=C
 C=IN2
 ?CBIT=1 0 ç
 {
  ST=1 11
  LC 1
  ?C=D P ç
  {
   EXIT2
  }
  D=C P
  EXIT2
 }
 %Test ctrst + foncÈ
 LC 001
 OUT=C
 C=IN2
 ?CBIT=1 1 ç
 {
  ST=1 11
  LC 2
  ?C=D P ç
  {
   EXIT2
  }
  D=C P
  D0=00101
  A=DAT0 P
  A+1 P
  SKNC
  {
   D0=00102
   A=DAT0.P
   ?Aã0.P ç
   {
    EXIT2
   }
   D1=00101
   C=0.P
   DAT1=C.P
   A+1.P
   DAT0=A.P
  }
  DAT0=A P
 }
 %Test ctrst + clair
 LC 001
 OUT=C
 C=IN2
 ?CBIT=1 2 ç
 {
  ST=1 11
  LC 3
  ?C=D P ç
  {
   EXIT2
  }
  D=C P
  D0=00101
  A=DAT0 P
  A-1 P
  SKNC
  {
   D0=00102
   A=DAT0.P
   ?A=0.P ç
   {
    EXIT2
   }
   D1=00101
   LC F
   DAT1=C.P
   A-1.P
   DAT0=A.P
  }
  DAT0=A P
 }
 %Si aucune touche n'a ete appuye
 %alors on vide le cache des tch
 ?ST=1 11 SKIPYES
 {
  D=0 P
 }
 ST=0 11
 UP
}

%On sauve le contrast actuel
%comme contrast de jeu
GOSUBL SavCtrstJeu


RTN

@