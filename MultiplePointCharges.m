clear all
close all
x = linspace(-10,10,101); %Create vectors with desired spacing
y = linspace(-10,10,101);
[X,Y] = meshgrid(x,y);

x0 = -8;
y0 = 3;
x1 = 6;
y1 = -6;
x2 = 3;
y2 = 9;
R = sqrt((X-x0).^2+(Y-y0).^2);
R1 = sqrt((X-x1).^2+(Y-y1).^2);
R2 = sqrt((X-x2).^2+(Y-y2).^2);



q0 = -3; %Charge on charge 1 at origin, 3 Coulombs
q1 = 8;
q2 = 2;
k = 9e9; %Value of constant k in SI units

%Coulomb's Law can be rewritten as kq/r^3 times r^vector. So:

Ex0 = k*q0*(X-x0)./R.^3; %Calculate field components from charge 1
Ey0 =k*q0*(Y-y0)./R.^3 ;
Emag0 = sqrt(Ex0.^2+Ey0.^2); %Get magnitude at each location

Ex1 = k*q1*(X-x1)./R1.^3; %Calculate field components from charge 2 
Ey1 =k*q1*(Y-y1)./R1.^3 ;
Emag1 = sqrt(Ex1.^2+Ey1.^2);

Ex2 = k*q1*(X-x2)./R2.^3; %Calculate field components from charge 3
Ey2 =k*q1*(Y-y2)./R2.^3 ;
Emag2 = sqrt(Ex2.^2+Ey2.^2);

magTotal = Emag0 + Emag1 + Emag2;
ExTotal = Ex0 + Ex1 + Ex2;
EyTotal = Ey0 + Ey1 + Ey2;

figure(1)
imagesc(x,y,log10(magTotal)) %Plot color plot of magnitude of vectors at each position, using logarithm for visibility
axis xy image
hc2 = colorbar;
hold on 
nSkip = 5; 
in = 1:nSkip:101; 
quiver(x(in),y(in),ExTotal(in,in)./magTotal(in,in),EyTotal(in,in)./magTotal(in,in),'k') %New quiver command that only plots every fifth index value
%to fix arrow scaling
%Also, each vector is plotted as unit vector so they're visible. We have
%magnitude from color plot, at least the logarithm of it
axis xy image
axis([-10,10,-10,10]) %Fix weird white space at the edges of the figure
xlabel('X (m)')
ylabel('Y (m)')
title('Electric field of 3 point charges')
ylabel(hc2,'Log base 10 of Emag in N/C');
caxis([7,12]); %Change minimum and maximum of color scale


