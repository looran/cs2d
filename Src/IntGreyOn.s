
%--------
%GREY_ON
%--------

  % LECTURE TIMER 2
  D1=00138 C=DAT1.8

  % SAUVEGARDE
  D1=(5)SAV_TIMER
  DAT1=C.8  

  % INIT COMPTEU IT
  C=0.W D1+8 DAT1=C.W

  % INIT HORLOGE         
  D0=0012E
  LC 70
  DAT0=C.B

  % Initialise Valeur Horloge2
  D0=38
  LC 00000010
  DAT0=C.8

  % Recupere adr. routine
  A=PC
  GOINC MYINT
  C+A.A

  % Sauvegarde des 16
  % quartets en 8600D
  D0=8600D
  A=DAT0 16
  D1=(5)SAV_IT
  DAT1=A 16

  % Detournement
  DAT0=C A
  D0+10
  DAT0=C A

  % IL SERAIT BON DE VERIFIER
  % SI L'ADRESSE EN 8600D EST
  % LA MEME QUE CELLE DE NOTRE
  % INT AVANT DE FAIRE LE
  % DETOURNEMENT :)
  % CA EVITERAI DE PERDRE 
  % L'ADRESSE ORIGINALE DANS LE
  % CAS D'UN DOUBLE APPEL A GREY_ON


@