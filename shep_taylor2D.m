function vq = shep_taylor2D(x,y,v,xq,yq,p,m)
% Opis:
%  izračuna interpolacijo ročk v prostoru s pomočjo Shepard-Taylorjeve
%  metode, ki poleg vrednosti točk uporabi tudi prve parcialne odvode.
%  Približki odvodov so izračunani na podlagi navadne shepardove
%  interpolacije.
%
% Definicija:
%  vq = shep_taylor2D(x,y,v,xq,yq,p,m)
%
% Vhodni podatki:
%  x, y, v      vektorji koordinat znanih točk,
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  p            parameter shepardove interpolacije (privzeta vrednost = 2),
%  m            število sosedov, ki določajo aproksimacijsko ravnino za
%               določanje parcialnih odvodov
%
% Izhodna podatka:
%  vq           mreža izračunanih vrednosti za točke z
%               interpolacijskega območja
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if nargin < 6
    p = 2;
end


% Izračun odvodov
tree = KDTreeSearcher([x y]);
[dx,dy] = aproksimiraj_z_ravnino(x,y,v,tree,m);

% Določanje konstant
n = length(x); %število znanih točk
vq = zeros(size(xq)); %vektor vrednsti interpolacijskih točk
distances_all = zeros(size(xq));

%računanje vrednosti interpolacije
for j=1:n
    distances = sqrt((xq-x(j)).^2 +(yq-y(j)).^2).^(-p);
    vq = vq + distances.*(v(j)+ dx(j)*(xq-x(j)) + dy(j)*(yq-y(j)));
    distances_all = distances_all + distances;
end
vq = vq./distances_all;
end


