function [x,y, idx] = izbor_tock_pravokotniki(xq,yq,h)
% Opis:
%  domeno razdeli na h x h kvadrov, nato pa iz vsakega kvadra izbere
%  naključno točko. Tako dobimo približek razpršenih podatkov.
%
% Definicija:
%  [x,y, idx] = izbor_tock_pravokotniki(xq,yq,h)
%
% Vhodni podatki:
%  xq, yq       mreži x in y koordinat točk na interpolacijskem območju,
%  h            število, na koliko pravokotnikov razdelimo območje (h x h).
%
% Izhodna podatka:
%  x, y         vektorja koordinat točk dolžine h x h. Točke predstavljajo
%               razpršene podatke,
%  idx          indeksi, kje se izbrane točke nahajajo v matrikah xq in yq.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

b_tock = size(xq,1); a_tock = size(xq,2); %število točk območja v y in x smeri
xmax = xq(1,end); xmin = xq(1,1); ymax = yq(end,1); ymin = yq(1,1);
a = xmax - xmin; b = ymax - ymin; %dolžina območja v x in y smeri
hx = a/h; hy = b/h;
xres = a/a_tock; yres = b/b_tock; %razmak med točkami v x in y smeri


x_ref = linspace(xmin,xmax,h+1); %referenčne točke delitve mreže
y_ref = linspace(ymin,ymax,h+1); %referenčne točke delitve mreže

[x,y] = meshgrid(x_ref(1:end-1),y_ref(1:end-1));
x = x + hx/4 + hx/2*(rand(size(x))<.5); %točne vrednosti naključnih točk
y = y + hy/4 + hy/2*(rand(size(y))<.5); %točne vrednosti naključnih točk


u=round((x-xmin)/xres)+1; %najbližje točke na mreži
v=round((y-ymin)/yres)+1; %najbližje točke na mreži

idx = sub2ind(size(xq),v(:),u(:));
x = xq(idx);
y = yq(idx);

end