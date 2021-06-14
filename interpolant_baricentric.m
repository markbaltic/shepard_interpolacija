function lq = interpolant_baricentric(xq,yq,Tx,Ty,Tv)
% Opis:
%  izračuna vrednosti linearnega interpolanta nad trikotnikom, dobljenjega
%  iz vrednosti oglišč trikotnika in pretvorbo v baricentrične koordinate.
%
% Definicija:
%  lq = interpolant_baricentric(xq,yq,Tx,Ty,Tv)
%
% Vhodni podatki:
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  Tx           vrednosti x koordinat oglišč trikotnika,
%  Ty           vrednosti y koordinat oglišč trikotnika,
%  Tv           vrednosti točk, ki tvorijo oglišča trikotnika.
%
% Izhodna podatka:
%  lq           matrika vrednosti linearnega interpolanta za točke domene
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar1 = ((Ty(2)-Ty(3))*(xq-Tx(3))+(Tx(3)-Tx(2))*(yq-Ty(3)))/((Ty(2)-Ty(3))*(Tx(1)-Tx(3))+(Tx(3)-Tx(2))*(Ty(1)-Ty(3)));
bar2 = ((Ty(3)-Ty(1))*(xq-Tx(3))+(Tx(1)-Tx(3))*(yq-Ty(3)))/((Ty(2)-Ty(3))*(Tx(1)-Tx(3))+(Tx(3)-Tx(2))*(Ty(1)-Ty(3)));
lq = Tv(1)*bar1 + Tv(2)*bar2 + Tv(3)*(1-bar1-bar2);
end

