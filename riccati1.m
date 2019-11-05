%% Riccati
% Inicializando Vetores
s{N+1} = q0;

% S e L pelo Riccati com Loop
for k = N:-1:1
    s{k} = phi'*s{k + 1}*phi + Q1 - (phi'*s{k + 1}*gama + Q12)*(gama'*s{k + 1}*gama + Q2)^(-1)*(gama'*s{k + 1}*phi + Q12');
    l{k} = (Q2 + gama'*s{k + 1}*gama)^(-1)*(gama'*s{k + 1}*phi - Q12'); % tinha um transposto a mais
    lx(1,k) = l{k}(1);
    lx(2,k) = l{k}(2);
    sx(1,k) = s{k}(1,1);
    sx(2,k) = s{k}(1,2);
    sx(3,k) = s{k}(2,1);
    sx(4,k) = s{k}(2,2);
end
sx(1,:) = sx(1,end:-1:1);
sx(2,:) = sx(2,end:-1:1);
sx(3,:) = sx(3,end:-1:1);
sx(4,:) = sx(4,end:-1:1);
% Grafico dos S
plot(sx(1,:)); hold on;
plot(sx(2,:)); hold on;
plot(sx(3,:)); hold on;
plot(sx(4,:)); hold on;


lx(1,:) = lx(1,end:-1:1);
lx(2,:) = lx(2,end:-1:1);

% plot(lx(1,:)); hold on;
% plot(lx(2,:)); hold on;
% Riccati estatico
[H, S, e] = dlqr(phi, gama, Q1, Q2, Q12);
