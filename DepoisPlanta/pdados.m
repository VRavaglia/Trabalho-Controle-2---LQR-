close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;

t=tempodiscreto;

u=controlediscreto;
plot(tc,uc,'.',t,u, 'o')