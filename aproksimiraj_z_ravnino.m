function [dx,dy] = aproksimiraj_z_ravnino(x,y,v,tree,m)
% Opis:
%  Izračuna aproksimacijsko ravnino v vsaki znani točki, pri čemer upošteva
%  točko in najbližjih m sosedov. Ravnino je oblike ax + by + c = v.
%  Koeficienta a in b predstavljata ravno naklona ravnine v x in y smeri,
%  kar nato uporavimo za aproksimacijo odvodov v znanih točkah. Najbližje
%  sosede se hitro določa s pomočjo drevesne strukture.
%
% Definicija:
%  [dx,dy] = aproksimiraj_z_ravnino(x,y,v,tree,m)
%
% Vhodni podatki:
%  x, y, v      vektorji koordinat znanih točk,
%  tree         drevesna struktura (kd-drevo) znanih točk,
%  m            iskano število najbližjih sosedov za dano točko.
%
% Izhodna podatka:
%  dx, dy       vektorja aproksimacij odvodov soležnih znanih točk oz.        
%               koeficienti aproksimacijskih ravnin (glej opis).
%      


if nargin < 5
    m = 3;
end

dx = zeros(size(x));
dy = zeros(size(y));

[idx, ~] = knnsearch(tree,[x,y],'k',m+1);

for i =1:size(idx,1)
    xi = x(idx(i,:)');
    yi = y(idx(i,:)');
    vi = v(idx(i,:)');
    a = [xi, yi, ones(size(xi))];
    j=1;
    while rank(a) < 3 %v primeru, da so 4 točke linearno odvisne, dodajamo sosede
        [id2, ~] = knnsearch(tree,[x(i),y(i)],'k',m+1+j);
        xi = x(id2');
        yi = y(id2');
        vi = v(id2');
        a = [xi, yi, ones(size(xi))];
        j = j+1;
    end
    p = a\vi;
    dx(i)=p(1);
    dy(i)=p(2);
end

