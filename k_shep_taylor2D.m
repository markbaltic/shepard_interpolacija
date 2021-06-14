function vq = k_shep_taylor2D(x,y,v,xq,yq,p,Nw,m)
% Opis:
%  Izračuna interpolacijo ročk v prostoru s pomočjo posodobljene
%  shepardove metode, ki vpošteva le Nw najbližjih točk pri določanju
%  vrednosti v dani točki.
%
% Definicija:
%  vq = k_shep2D(x,y,v,xq,yq,p,Nw)
%
% Vhodni podatki:
%  x, y, v      vektorji koordinat znanih točk,
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  p            parameter shepardove interpolacije (privzeta vrednost = 2),
%  Nw           število najbližjih sosedov (znanih točk), ki vplivajo na                
%               vrednost v dani točki
%  m            število sosedov, ki določajo aproksimacijsko ravnino za
%               določanje parcialnih odvodov
%
% Izhodna podatka:
%  vq           mreža izračunanih vrednosti za točke z
%               interpolacijskega območja
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 8
    m = 3;
end

if nargin < 7
    Nw = length(x);
end
    
% določanje privzete vrednosti parametra, če ta ni podan
if nargin < 6
    p = 2;
end

% Izračun odvodov
tree = KDTreeSearcher([x y]);
[dx,dy] = aproksimiraj_z_ravnino(x,y,v,tree,m);


n = length(x); %število znanih točk
vq = zeros(size(xq)); %vektor vrednsti interpolacijskih točk
distances_all = zeros(size(xq));

tree = KDTreeSearcher([x y]);
[idx, ~] = knnsearch(tree,[xq(:),yq(:)],'k',Nw);
R = reshape(sqrt(sum(([xq(:),yq(:)]-[x(idx(:,Nw)),y(idx(:,Nw))]).^2,2)),size(xq));

for j=1:n
    distances = 1./sqrt((xq-x(j)).^2 +(yq-y(j)).^2) - 1./R;
    distances(distances<0) = 0;
    distances = distances.^p;
    vq = vq + distances.*(v(j)+ dx(j)*(xq-x(j)) + dy(j)*(yq-y(j)));
    distances_all = distances_all + distances;
end
vq = vq./distances_all;
end
