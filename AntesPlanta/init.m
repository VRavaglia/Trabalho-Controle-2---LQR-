%%Sistema
syms s real

%Ruidos
R = 0.01;
Qn = 0.01;
G = [1; 1];



%Definindo os polos
Zeros = 1;
Polos = [1 3 2];
func_transferencia = tf(Zeros, Polos);

[A, B, C, D] = tf2ss(Zeros,Polos);

x0barra = [-20;10];
epsilon = 0;
x0 = x0barra + epsilon;
x0hat = x0barra;
P0 = eye(2)*1e-4*100;


%Discretizando
% h = 0.01;
h = 0.01;
tmax = 20;

Gd = c2d(func_transferencia, h, 'zoh');% metodo ZOH de discretizacao
[num, den] = tfdata(Gd, 'v');
[phi, gama, Cd, Dd] = tf2ss(num, den);


%Inicializando Q, S e L
% Q1 = [ 1 1 ; 1 1]
% Q12 = [ 1 ; 1]
% Q2 = [1]
Q1 = [ 1 0 ; 0 1]*10;
Q12 = [ 0 ; 0];
Q2 = [1];
Q = [Q1 Q12 ; Q12' Q2]; % Q agora é 3x3
q0 = eye(length(phi));
N = 100;
s = cell(1,N+1);% troquei os zeros por celulas
l = cell(1,N);

riccati1;