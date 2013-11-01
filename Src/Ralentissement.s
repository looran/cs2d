%Ajuste la bcl de ralentissement
%suivant les operations quon
%realise
%ENTREE : C.a : ce quil faut
%enlever a la bcl de ralentisseme
%ent

*Decrralentissement
D0=(5)Ralentissement
A=DAT0 A
A-C A
%Si la difference est neg, on
%saute a uo prog qui va gerer
%le pb
GOC carame
DAT0=A A

%Extinction de l'indicateur
%de ramure
D0=0010B
A=DAT0 1
LC 7 %Pour eteindre le bit3
A&C P
DAT0=A 1

RTN

%Si on vient ici c'est que l'on
%a voulu executer qqchose,mais
%que la bcl de ralentissement ne
%peut pas encaisser autant de
%choses... en clair ca rame.
%On va l'indiquer au joueur en
%allumant l'indicateur de piles,
%et mettre 0 a la bcl de
%ralentissement
*carame

%Mise a 0
A=0 A
DAT0=A A

%Allumage de l'indicateur
D0=0010B
A=DAT0 1
LC 8 %Pour allumer le bit3
A!C P
DAT0=A 1

RTN

@