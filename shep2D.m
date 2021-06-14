function vq = shep2D(x,y,v,xq,yq,p)
% Opis:
%  Izračuna interpolacijo dvodimenzionalnih točk v prostoru s pomočjo 
%  shepardove metode.
%
% Definicija:
%  vq = shep1(x,y,v,xq,yq,p)
%
% Vhodni podatki:
%  x, y, v      vektorji koordinat znanih točk,
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  p            parameter shepardove interpolacije (privzeta vrednost = 2),
%
% Izhodna podatka:
%  vq           mreža izračunanih vrednosti za točke z
%               interpolacijskega območja
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% določanje privzete vrednosti parametra, če ta ni podan
if nargin < 6
    p = 2;
end

% Določitev konstant
n = length(x); %število znanih točk
vq = zeros(size(xq)); %matrika vrednsti interpolacijskih točk
distances_all = zeros(size(xq));

%Računanje vrednosti interpolacije
for j=1:n
    distances = sqrt((xq-x(j)).^2 +(yq-y(j)).^2).^(-p);
    vq = vq + distances*v(j);
    distances_all = distances_all + distances;
end
vq = vq./distances_all;
end