% Parametros Simulacao

passo=1;
Tsimu=100e3;
h=0.1;

% Parametros Planta

M = 0.0289;
R = 8.314;
g = 9.81;
Ta = 293;
La = 230.87;
Va = 29.012;
po = 923.9;
ps = 3.704669e6;
pr = 2.5497295e7;
Tw = 293;
Lw = 1217;
Lr = 132;
Aw = 0.203;
Ar = 0.203;
Civ = 15e-5;
Cpc = 1.655e-3;
Cr = 2.623e-4;
Wpomax = 31.51;
Wgcmax = 2.66;
Cwro2 = -3.7456e-4;
Cwro3 = -6.0465e-5;
Cwro4 = 41.5342;
x2ponto = 12e3;
x3ponto = 76e3;
Cwpo2 = 3.8e-3;
Cwpo3 = 5.595e-4;
Cwpo4 = 30.2054;
Cwpg2 = 0.3158;
Cwpg3 = -0.0249;
Cwpg4 = 0;
rgo = 0.08181818;

% Espaco de estados

A = [(rgo*Cwro2 - Cwpg2) (rgo*Cwro3 - Cwpg3); (Cwro2 - Cwpo2) (Cwro3 - Cwpo3)];
B = [1 0]';
C = g/Aw*[1 1];

% Controle Proporcional com Feedforward
r0 = (rgo*Cwro4 - Cwpg4) - (rgo*Cwro3 - Cwpg3)*(Cwro4 - Cwpo4)/(Cwro3 - Cwpo3); %baseando-se em C, ou seja uma mudanca de aproximadamente 100%
x0 = [-12 4]';
K0 = place(A, B, [-1 -0.002]);
N0 = 1/(C*inv(-1*(A - B*K0))*B);