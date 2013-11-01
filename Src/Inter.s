%-------------------------------
% Gestionnaire de detournement
% d'interuption de Denis Martinez
%--------------------------------
% + IntGreyOn.s

%-------  
*MYINT
%-------
% Routine de gestion
% des interruptions

% Teste Si l'inter est due á
%  l'Horloge 2

  D1=0012F
  C=DAT1.B
  ?CBIT=1.3   % IT ?
  GOYES SUITE
  GOTO FIN.INT

  *SUITE
  LC 7
  DAT1=C.B

  CD0EX
  RSTK=C
  % ROTATION DES ECRANS
  D0=(5)IGreyScr1
  D1=(5)IGreyScr2
  A=DAT0.10
  C=DAT1.10
  DAT0=C.10  % SCR1=2
  D0+10      
  D1+10      
  C=DAT1.10  
  DAT0=C.10  % SCR2=3
  DAT1=A.10  % SCR3=1
  D0=00120
  DAT0=A.A 
  D0=30
  D1+5
  A=DAT1.A 
  DAT0=A.A 

  C=RSTK
  D0=C

  % RECHARCHE HORLOGE 2
  D1=00138
  LC 0000007C
  DAT1=C.8
      
  % COMPTE UNE IT EN PLUS
  D1=(5)COUNT_IT
  C=DAT1.W
  C+1.W
  DAT1=C.W
    
  %Recuperation des
  %registres et fin
*FIN.INT
  D1=805F5
  A=DAT1.W
  D1-5
  C=DAT1.A
  RSTK=C
  D1-5
  C=DAT1 A
  HST=02
  CSR.A
  P=0
  C+1.P
  SKIPC { SETDEC }
  P=1
  C-1.P
  P=C.2
  D1=05DB
  C=DAT1.W
  D1=C
  C=RSTK
  ST=0.14
  RTI


%---------
*GREY_OFF
%--------
  % RESTAURE HORLOGE
  LC 10 D0=0012E DAT0=C B

  % RESTAURE IT
  D0=(5)SAV_IT
  A=DAT0 16
  D1=8600D
  DAT1=A 16

  % RESTORE HORLOGE
  D1=(5)SAV_TIMER
  C=DAT1.8
  D1+8

  % COMPTEUR IT
  A=DAT1.W
  ASLC    % *16
  A+A.W   % *32
  A+A.W   % *64
  C+A.W
  D1=00138
  DAT1=C.8

  RTN

@