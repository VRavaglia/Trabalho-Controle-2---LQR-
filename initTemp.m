
%Sistema

syms s

N = 1;
D = [1 3 2];
G = tf(N, D);

[A, B, C, D] = tf2ss(N,D);

h = 0.01;

Gd = c2d(G, h, 'zoh');
[num, den] = tfdata(Gd, 'v');
[phi, gama, Cd, Dd] = tf2ss(num, den);

Q = {1 [-1;-1];[-1 -1] 1};
q0 = eye(length(phi));
N = 100;
s = cell(1,N+1);
l = cell(1,N);
% Riccati
s{N+1} = q0;
for k = N:-1:1
    s{k} = phi'*s{k + 1}*phi + Q{1,1} - (phi'*s{k + 1}*gama + Q{1,2})*(gama'*s{k + 1}*gama + Q{2,2})^(-1)*(gama'*s{k + 1}*phi + Q{1,2}');
    l{k} = (Q{2,2} + gama'*s{k + 1}*gama)^(-1)*(gama'*s{k + 1}*phi - Q{1,2}'); % tinha um trasnposto a mais
end

% Riccati estatico
[H, S, e] = dlqr(phi, gama, Q{1,1}, Q{2,2},Q{1,2});


