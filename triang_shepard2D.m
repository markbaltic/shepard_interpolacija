function vq = triang_shepard2D(x,y,v,xq,yq,p,T)
% Opis:
%  Izračuna interpolacijo dvodimenzionalnih točk v prostoru s pomočjo 
%  trikotniške Shepardove interploacije.
%
% Definicija:
%  vq = shep1(x,y,v,xq,yq,p)
%
% Vhodni podatki:
%  x, y, v      vektorji koordinat znanih točk,
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  p            parameter shepardove interpolacije (privzeta vrednost = 2),
%  T            triangulacija znanih točk.
%
% Izhodna podatka:
%  vq           mreža izračunanih vrednosti za točke z
%               interpolacijskega območja
if nargin < 7
    T = delaunayTriangulation([x y]);
end
if nargin < 6
    p = 2;
end

% Določanje števila trikotnikov
CL = T.ConnectivityList;
Nt = size(CL,1); %število trikotnikov

% Matriki za shranjevanje rezultata
vq = zeros(size(xq)); %matrika vrednsti interpolacijskih točk
distances_all = zeros(size(xq)); %matrika za sprotno seštevanje razdalj

for j=1:Nt
    distances = sqrt((xq-x(CL(j,1))).^2 + (yq-y(CL(j,1))).^2).^(-p) ...
        .* sqrt((xq-x(CL(j,2))).^2 + (yq-y(CL(j,2))).^2).^(-p) ...
        .* sqrt((xq-x(CL(j,3))).^2 + (yq-y(CL(j,3))).^2).^(-p);
    
    distances_all = distances_all + distances;    
    vq = vq + distances.*interpolant_baricentric(xq,yq,x(CL(j,:)'),y(CL(j,:)'),v(CL(j,:)));
end
vq = vq./distances_all;
end
