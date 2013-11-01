%Calcul des coordonnés du j1
%sur lecran de jeu

*calccoordj1scrjeu

%On calcul les coord du joueur 1
%sur lecran de jeu

A=0 A
D0=(5)coordpixj1y
A=DAT0 3
C=0 X
D0=(5)nbcasescry
C=DAT0 B
C+C X
C+C X
C+C X % *8 pour mettre en pix
A-C X
A+A B %*2 car 2 ecrans
B=A A
ASL A
A+A A %*32
B+B X %*2
B+A A %*32 + *2 => *34
A=0 A
D0=(5)coordpixj1x
A=DAT0 3
C=0 X
D0=(5)nbcasescrx
C=DAT0 B
C+C X
C+C X
C+C X % *8 pour mettre en pix
A-C X
ASRB X
ASRB X % /4 pour mettre en q
A+B A % on + x et y
D0=(5)coordpixj1scr
DAT0=A A %Et on stok tt ca :)

RTN

@