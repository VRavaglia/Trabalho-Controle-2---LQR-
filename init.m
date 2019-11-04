%%Sistema
syms s


%Definindo os polos
Zeros = 1;
Polos = [1 3 2];
func_transferencia = tf(N, D);

[A, B, C, D] = tf2ss(Zeros,Polos);


%Discretizando
h = 0.01;

Gd = c2d(func_transferencia, h, 'zoh');% metodo ZOH de discretizacao
[num, den] = tfdata(Gd, 'v');
[phi, gama, Cd, Dd] = tf2ss(num, den);


%Inicializando Q, S e L
Q = [1 1 1; 1 1 1; 1 1 1]; % Q agora é 3x3
q0 = eye(length(phi));
N = 100;
s = cell(1,N+1);% troquei os zeros por celulas
l = cell(1,N+1);
