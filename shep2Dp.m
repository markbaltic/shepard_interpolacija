function vq = shep2Dp(x,y,v,xq,yq,p,p2,I)
% Opis:
%  Izračuna interpolacijo dvodimenzionalnih točk v prostoru s pomočjo 
%  shepardove metode, kjer je ena utež potencirana na potenco p2.
%
% Definicija:
%  vq = shep1(x,y,v,xq,yq,p,p2,I)
%
% Vhodni podatki:
%  x, y, v      vektorji koordinat znanih točk,
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  p            parameter shepardove interpolacije (privzeta vrednost = 2),
%  p2           posebna potenca ene uteži,
%  I            indeks točke, pri kateri je utež potencirana s p2
%
% Izhodna podatka:
%  vq           mreža izračunanih vrednosti za točke z
%               interpolacijskega območja
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% določanje privzete vrednosti parametra, če ta ni podan
if nargin < 8
    I = 1;
end

if nargin < 7
    p2 = 6;
end

if nargin < 6
    p = 2;
end

% Določanje konstant
n = length(x); %število znanih točk
vq = zeros(size(xq)); %vektor vrednsti interpolacijskih točk

%določimo drugačno potenco za posebno utež
p = p*ones(n,1);
p(I) = p2;

%računanje vrednosti interpolacije
for j=1:n
    distances = sqrt((xq-x(j)).^2 +(yq-y(j)).^2).^(-p(j));
    vq = vq + distances*v(j);
    distances_all = distances_all + distances;
end
vq = vq./distances_all;
end
