%% Riccati
% Inicializando Vetores
s{N+1} = q0;
l{N+1} = (Q(2,2) + gama'*s{N + 1}*gama)^(-1)*(gama'*s{N + 1}*phi - Q(2,1));

% S e L pelo Riccati com Loop
for k = N:-1:1
    s{k} = phi'*s{k + 1}*phi + Q(1,1) - (phi'*s{k + 1}*gama + Q(1,2))*(gama'*s{k + 1}*gama + Q(2,2))^(-1)*(gama'*s{k + 1}*phi + Q(2,1));
    l{k} = (Q(2,2) + gama'*s{k + 1}*gama)^(-1)*(gama'*s{k + 1}*phi - Q(2,1)); % tinha um transposto a mais
end

% Riccati estatico
[H, S, e] = dlqr(phi, gama, Q(1,1), Q(2,2), Q(1,2));
