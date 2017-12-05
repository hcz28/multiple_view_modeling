%Multiple-view modeling demo
clc
clear

datapath='data09\';
load([datapath 'recSurf.mat']);
[m,n]=size(recSurf);
[x, y] = meshgrid(1:n, 1:m);
h=figure(1);
surf(x,y,recSurf,'FaceColor','green','EdgeColor','none');
set(h,'Position',[500,500,400,400]);
camlight left;
lighting phong;
axis equal;
axis vis3d;M
axis off;
