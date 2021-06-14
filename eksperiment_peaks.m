%% splošni nastavki
rng(1)
st_metod = 5; 
h = 20; % <----- nastavi, število delitve območja na h^2 pravokotnikov. 
        %        Izbranih točk bo potem n=h^2.
m = 200;% <----- število točk območja
        
        
%% določanje točk in domene
[xq,yq,z_peaks] = peaks(m); 
[x,y, idx] = izbor_tock_pravokotniki(xq,yq,h);
v = peaks(x,y);


%% interpolacije z metodami <------- tukaj spreminjaj parametre metod!
%klasicni
vq_klasicni = shep2D(x,y,v,xq,yq,2);
vq_klasicni(idx) = v;

%shepard-taylor s 4 točkami za odvod
vq_taylor4 = shep_taylor2D(x,y,v,xq,yq,2,3);
vq_taylor4(idx) = v;

%k-shepard 8 najblizjih tock
vq_8shep = k_shep2D(x,y,v,xq,yq,2,8);
vq_8shep(idx) = v;

%k-shepard-taylor
vq_8shep_taylor4 = k_shep_taylor2D(x,y,v,xq,yq,2,8,3);
vq_8shep_taylor4(idx) = v;

%triangulacijski shepard Delaunay
vq_tri_delaunay = triang_shepard2D(x,y,v,xq,yq,2);
vq_tri_delaunay(idx) = v;
    
%% Risanje rezultatov
% velikost narisanih točk
if h < 40
    mark_size = 0;
else
    mark_size = 5;
end

% celica vseh rešitev
vq_vsi = {vq_klasicni, vq_taylor4, vq_8shep, vq_8shep_taylor4, vq_tri_delaunay};

% naslovi
naslovi = {'klasicni Shepard', 'Shepard-Taylor', 'k-Shepard', 'k-Shepard-Taylor','triangulacijski Shepard'};

% risanje originala funkcije in contour izbranih točk
figure;
hold on
grid off
mesh(xq,yq,z_peaks)    
plot3(x,y,v,'.r','MarkerSize',mark_size)
title('Peaks original');
view([-34 34])
axis off;
hold off;

figure;
hold on
grid off
contour(xq,yq,z_peaks)
plot3(x,y,v,'.r','MarkerSize',mark_size)
title('Contour izbranih točk');
axis off;
hold off;

for j=1:st_metod
    figure;
    hold on
    grid off;
    mesh(xq,yq,vq_vsi{j}) %narišemo rezultate
    if h < 80
    plot3(x,y,v,'.r','MarkerSize',mark_size) %poudarimo znane točke
    end
    axis off;
    view([-34 34])
    title(naslovi{j});
    hold off
end