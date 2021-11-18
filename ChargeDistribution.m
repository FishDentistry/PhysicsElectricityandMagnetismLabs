clear all
close all



xlambda = linspace(-2,2,200);
dxlambda = xlambda(2)-xlambda(1);
k = 9e9; %Value of constant k in SI units


x = linspace(-2.5,2.5,1000); %Create vectors with desired spacing
y = linspace(-2.5,2.5,1000);
[X,Y] = meshgrid(x,y);
fxn = sin(x);

ExTotal =  zeros(size(X));
EyTotal =  zeros(size(Y));

for j=1:200
    if xlambda(j) < 0
        locallambda = -1;
    else
        locallambda = 1;
    end
    %locallambda = G(xlambda(j));
    dlambday = dxlambda * cos(xlambda(j));
    dlength = sqrt(dxlambda^2+dlambday^2);
    Ex = k*locallambda*dlength*(X-xlambda(j))./((X-xlambda(j)).^2+(Y-sin(xlambda(j))).^2).^(3/2);
    Ey = k*locallambda*dlength*(Y-sin(xlambda(j)))./((X-xlambda(j)).^2+(Y-sin(xlambda(j))).^2).^(3/2);
    ExTotal = ExTotal + Ex;
    EyTotal = EyTotal + Ey; 
    
end

EmagTotal = sqrt(ExTotal.^2+EyTotal.^2);

figure(1)
imagesc(x,y,log10(EmagTotal)) %Plot color plot of magnitude of vectors at each position, using logarithm for visibility
axis xy image
hc2 = colorbar;
hold on 
nSkip = 50; 
in = 1:nSkip:1000; 
quiver(x(in),y(in),ExTotal(in,in)./EmagTotal(in,in),EyTotal(in,in)./EmagTotal(in,in),'k')
%quiver(x,y,ExTotal./EmagTotal,EyTotal./EmagTotal,'k')
%to fix arrow scaling
%Also, each vector is plotted as unit vector so they're visible. We have
%magnitude from color plot, at least the logarithm of it
axis xy image
axis([-2.5,2.5,-2.5,2.5])
caxis([10,12]);
