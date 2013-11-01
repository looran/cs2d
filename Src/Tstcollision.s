%Tests de collision
%Sortie : Ds A.p, le type de la
%case ou se trouvera le joueur
%si le delacement est acceptÈ

%Test de collision vers le haut

*tstcolo

A=0 A
D0=(5)coordpixj1y
A=DAT0 3
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
A+4 X %Ajustage x
ASRB X
ASRB X
ASRB X %A/8 pque c d cases
A+B X
%On a la position du j1
%ds la bdd dans le cas ou le depl
%acement vers la d est acceptÈ ds
%Ax
D0=(5)adrbddzones
C=DAT0 A
B=A A
B+B A
C+B A
D0=C
C=DAT0 B
D0=(5)nbzonej1
DAT0=C B
D0=(5)adrbddobj
C=DAT0 A
C=C+A A
D0=C
A=DAT0 1
RTN


%Test de collision vers le bas

*tstcolb

A=0 A
D0=(5)coordpixj1y
A=DAT0 3
A+7 X %Ajustage y
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
A+4 X %Ajustage x
ASRB X
ASRB X
ASRB X %A/8 pque c d cases
A+B X
%On a la position du j1
%ds la bdd dans le cas ou le depl
%acement vers la d est acceptÈ ds
%Ax
D0=(5)adrbddzones
C=DAT0 A
B=A A
B+B A
C+B A
D0=C
C=DAT0 B
D0=(5)nbzonej1
DAT0=C B
D0=(5)adrbddobj
C=DAT0 A
C=C+A A
D0=C
A=DAT0 1
RTN

%Test de collision vers la gauche

*tstcolg

A=0 A
D0=(5)coordpixj1y
A=DAT0 3
A+4 X %Ajustage y
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
ASRB X
ASRB X
ASRB X %A/8 pque c d cases
A+B X
%On a la position du j1
%ds la bdd dans le cas ou le depl
%acement vers la d est acceptÈ ds
%Ax
D0=(5)adrbddzones
C=DAT0 A
B=A A
B+B A
C+B A
D0=C
C=DAT0 B
D0=(5)nbzonej1
DAT0=C B
D0=(5)adrbddobj
C=DAT0 A
C=C+A A
D0=C
A=DAT0 1
RTN

%Test de collision vers la droite

*tstcold

A=0 A
D0=(5)coordpixj1y
A=DAT0 3
A+4 X %Ajustage y
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
A+7 X %Ajustage x
ASRB X
ASRB X
ASRB X %A/8 pque c d cases
A+B X
%On a la position du j1
%ds la bdd dans le cas ou le depl
%acement vers la d est acceptÈ ds
%Ax
D0=(5)adrbddzones
C=DAT0 A
B=A A
B+B A
C+B A
D0=C
C=DAT0 B
D0=(5)nbzonej1
DAT0=C B
D0=(5)adrbddobj
C=DAT0 A
C=C+A A
D0=C
A=DAT0 1
RTN

%Test collision d'un bot avec
%les autres joueurs. coords X
%METHODE:
%Si coordX lui = coordX moi
%=> Test si coordYlui compri entr
%   +-8 mes coordsY
%ENTREES
%B.x: Coords X
%R2.x: Coords Y
%R4.p: Nb bot testeur
%SORTIE
%Carry=1: Deplacement impossible
%Carry=0: Deplacement OK

%Test collision d'un bot avec
%les autres joueurs. coords X
%METHODE:
%Si coordX lui = coordX moi
%=> Test si coordYlui compri entr
%   +-8 mes coordsY
%ENTREES
%B.x: Coords X
%R2.x: Coords Y
%R4.p: Nb bot testeur
%SORTIE
%Carry=1: Deplacement impossible
%Carry=0: Deplacement OK

*BclTstB
%Test collision bots
D1=(5)nbbots A=0.B A=DAT1.P
C=0.A
C=A B C+C B C+C B C+A B C+A B%*6
D1=(5)adrtabcoordsbots A=DAT1.A
D1=A
C+A.A D=C.A
{
 C=DAT1.X
 ?B=C.X ç
 {
  D1+3 A=DAT1.X
  C=R2.X
  A-C.X
  SKIPNC
  {
   A=-A.X
  }
  LC 007
  ?A<C.X ç
  {
   RTNSC
  }
  D1-3
 }
 D1+6
 A=D1 C=A.A
   %DEBUG:
   %Check D1 et D.a
   %B=A.A
   %GOSBVL DISP
 ?C=D.A ç
 {
  %On passe au tst col j1
  D1=(5)coordpixj1x A=DAT1.X
  ?B=A.X ç
  {
   D1=(5)coordpixj1y A=DAT1.X
   C=R2.X
   A-C.X
   SKIPNC
   {
    A=-A.X
   }
   LC 007
   ?A<C.X ç
   {
    RTNSC
   }
  }
  RTNCC
 }
 UP
}

%Test collision d'un bot avec
%les autres joueurs. coords Y
%METHODE:
%Si coordY lui = coordY moi
%=> Test si coordXlui compri entr
%   +-8 mes coordsX
%ENTREES
%D.x: Coords Y
%R2.x: Coords X
%R4.p: Nb bot testeur
%SORTIE
%Carry=1: Deplacement impossible
%Carry=0: Deplacement OK

*BclTstD
%Test collision bots
D1=(5)nbbots A=0.B A=DAT1.P
C=0.A
C=A B C+C B C+C B C+A B C+A B%*6
D1=(5)adrtabcoordsbots A=DAT1.A
A+3.A D1=A
C+A.A B=C.A
{
 C=DAT1.X
 ?D=C.X ç
 {
  D1-3 A=DAT1.X
  C=R2.X
  A-C.X
  SKIPNC
  {
   A=-A.X
  }
  LC 007
  ?A<C.X ç
  {
   RTNSC
  }
  D1+3
 }
 D1+6
 A=D1
   %DEBUG:
   %Check D1 et B.a
   %C=A.A D=C.A
   %GOSBVL DISP
 ?A=B.A ç
 {
  %On passe au tst col j1
  D1=(5)coordpixj1y C=DAT1.X
  ?D=C.X ç
  {
   D1=(5)coordpixj1x A=DAT1.X
   C=R2.X
   A-C.X
   SKIPNC
   {
    A=-A.X
   }
   LC 007
   ?A<C.X ç
   {
    RTNSC
   }
  }
  RTNCC
 }
 UP
}

%Test collision d'un bot avec
%les autres joueurs. coords X
%et coords Y
%METHODE:
%Si coordX lui +-8 coordX moi
%=> Test si coordYlui +-8 mes
%coordsY
%ENTREES
%B.x: Coords X
%D.x: Coords Y
%R4.p: Nb bot testeur
%SORTIE
%Carry=1: Deplacement impossible
%Carry=0: Deplacement OK

*BclTstBD
%Test collision bots
D1=(5)nbbots A=0.B A=DAT1.P
%On est oblige de test si ya
%0 bots pque la routine sert
%aussi a detect presence a 1
%endroit
?A=0.P ç
{
 GOTO .tstcolBDj1
}
C=0.A
C=A B C+C B C+C B C+A B C+A B%*6
D1=(5)adrtabcoordsbots A=DAT1.A
D1=A
  %DEBUG:
  %Check D1 et R2.a
  %B=A.A D=C.A
  %GOSBVL DISP
C+A.A R2=C.A
C=0.S %Compteur nb bot EC
{
 A=DAT1.X D1+3
 A-B.X
 SKIPNC
 {
  A=-A.X
 }
 LC 007
 ?A<C.X ç
 {
  P=C.15 C=P.0 P=0
  A=R4.P
  %test si oto-test
  ?A=C.P ç
  {
   EXIT2
  }
  C=DAT1.X
  C-D.X
  SKIPNC
  {
   C=-C.X
  }
  LA 007
  ?C<A.X ç
  {
   RTNSC
  }
 }
 C+1.S
 D1+3
 A=D1 C=R2.A
 ?C=A.A ç
 {
  %On passe au tst col j1
  *.tstcolBDj1
    %DEBUG:
    %Check deroul pour tstinitp
    %GOSBVL DISP
  D1=(5)coordpixj1x A=DAT1.X
  A-B.X
  SKIPNC
  {
   A=-A.X
  }
  LC 007
  ?A<C.X ç
  {
   D1=(5)coordpixj1y C=DAT1.X
   C-D.X
   SKIPNC
   {
    C=-C.X
   }
   LA 007
   ?C<A.X ç
   {
    RTNSC
   }
  }
  RTNCC
 }
 UP
}

%Test de collision du j1 dans les
%bots
%METHODE:
%Si coordX lui +-8 coordX moi
%=> Test si coordYlui +-8 mes
%coordsY
%ENTREES:
%B.x: CoordX - 8
%D.x: CoordY - 8
%SORTIE
%Carry=1: Deplacement impossible
%Carry=0: Deplacement OK

*TstColJ1Bot
D1=(5)nbbots A=0.B A=DAT1.P
?A=0.P ç
{
 RTNCC
}
C=0.A
C=A B C+C B C+C B C+A B C+A B%*6
D1=(5)adrtabcoordsbots A=DAT1.A
D1=A
  %DEBUG:
  %Check D1 et R2.a
  %B=A.A D=C.A
  %GOSBVL DISP
C+A.A R2=C.A
{
   %DEBUG:
   %On suit
   %GOSBVL DISP
 A=DAT1.X D1+3
 A-B.X
 SKIPNC
 {
  A=-A.X
 }
 LC 007
 ?A<C.X ç
 {
  C=DAT1.X
  C-D.X
  SKIPNC
  {
   C=-C.X
  }
  LA 007
  ?C<A.X ç
  {
   RTNSC
  }
 }
 D1+3
 A=D1 C=R2.A
 ?C=A.A ç
 {
  RTNCC
 }
 UP
}

@