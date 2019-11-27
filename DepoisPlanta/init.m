% Parametros Simulacao

Tsimu=10e3;
p = 1;
h = 50;

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
Cte = (rgo*Cwro4 - Cwpg4) - (rgo*Cwpg3 - Cwpg3)*(Cwro4 - Cwpo4)/(Cwro3 - Cwpo3);

% Espaco de estados

A = [(rgo*Cwro2 - Cwpg2) (rgo*Cwro3 - Cwpg3); (Cwro2 - Cwpo2) (Cwro3 - Cwpo3)];
B = [1 0]';
C = g/Aw*[1 1];

% Controle Proporcional com Feedforward
r0 = 20*101325; %baseando-se em C (nao eh o do espaco de estados)
x0 = [12000 80000]';
f0 = 62.8;
a0 = r0; %Nao demonstrou alterar o erro percentual
K0 = place(A, B, [-0.5 -0.005]);
N0 = 1/(C*inv(-1*(A - B*K0))*B);


%% LQR

%Planta discreta
[b,a] = ss2tf(A,B,C,0);
func_transferencia = tf(b, a);
Gd = c2d(func_transferencia, h, 'zoh');
[num, den] = tfdata(Gd, 'v');
[phi, gama, Cd, Dd] = tf2ss(num, den);

%Inicializando Q, S e L
Q1 = [ 1 0 ; 0 1];
Q12 = [ 0 ; 0];
Q2 = 1e6;
Q = [Q1 Q12 ; Q12' Q2];
q0 = eye(length(phi));
N = 100;
s = cell(1,N+1);
l = cell(1,N);

% Inicializando Vetores
s{N+1} = q0;
j = 0;

% S e L pelo Riccati com Loop
for k = N:-1:1
    s{k} = phi'*s{k + 1}*phi + Q1 - (phi'*s{k + 1}*gama + Q12)*(gama'*s{k + 1}*gama + Q2)^(-1)*(gama'*s{k + 1}*phi + Q12');
    l{k} = (Q2 + gama'*s{k + 1}*gama)^(-1)*(gama'*s{k + 1}*phi - Q12'); % tinha um transposto a mais
    aux = reshape(s{k}, [], 1);
    sx(:, k) = aux;
    aux = reshape(l{k}, [], 1);
    lx(:, k) = aux;
end

%Revertendo a ordem
sx(:,:) = sx(:,end:-1:1);
lx(:,:) = lx(:,end:-1:1);

% Riccati estatico
[H, S, e] = dlqr(phi, gama, Q1, Q2, Q12);
NLQR = 1/(C*inv(-1*(A - B*H))*B);


%% Observadores
xHatInit = x0 + (randn(2)*[1 0]')*10e3;
[pz,z] = pzmap(func_transferencia);
Lp = 2*pz;
L = (place(A',C',Lp))';
vk = r0*1000;

x0hat = xHatInit;
G = eye(2);
Qn = vk*eye(2);
P0 = eye(2)*400^2;