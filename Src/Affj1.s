%Routine daff d1 grob 4grs + msq
%En entrelace pour aff le j1

*affichej1

%On teste si laff j1 active
D0=(5)YNAffJ1 A=DAT0.P
?A=0.P RTNYES

%On choisi le grob a aff suivant
%l'equipe du joueur (T ou CT),
%la direction du joueur qui est
%dans directj1,suivant qu'on soit
%en flag de pas a 0 ou 1,que l'on
%inverse en passant
D0=(5)stj1
C=DAT0 P
?CBIT=1 2 ç
{
 GOTO affj1ct
}
%Le joueur est Terro
?ST=1 10 ç
{
 %On inv que si le flag detat est
 %a 0, de facon a pas changer tt
 %le tps de position car c trop
 %rapide
 ?ST=0 1 ç
 {
  ST=0 10
 }
 D0=(5)directj1
 A=DAT0 1
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
 ?ST=0 1 ç
 {
  ST=1 10
 }
 D0=(5)directj1
 A=DAT0 1
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
GOTO finselectgrobaffj1
*affj1ct
 %Le joueur est Counter
 ?ST=1 10 ç
 {
  %On inv que si le flag detat est
  %a 0, de facon a pas changer tt
  %le tps de position car c trop
  %rapide
  ?ST=0 1 ç
  {
   ST=0 10
  }
  D0=(5)directj1
  A=DAT0 1
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
  %Voir plus haut
  ?ST=0 1 ç
  {
   ST=1 10
  }
  D0=(5)directj1
  A=DAT0 1
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

*finselectgrobaffj1

%Je mets le decalage ds B.15
D0=(5)coordpixj1x
A=DAT0 3
LC 3
C&A P
P=C 0  %On fait passer C.0 en
C=P 15 %C.15 par l'intermed de P
P=15
B=C P %Le decal est stocke en B15
P=0
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
A+C A
D0=A %D0 pointe la ou on va aff
%le grob sur lecran

%Init compteur bcl dans As
P=15
LC 7

%bcl
*raffj1
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
 %Decalage (oo fait pas de gosub,
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
GOTONC raffj1
P=0
%affichage du viseur
GOSUBL afficheonlyviseur
RTN

@