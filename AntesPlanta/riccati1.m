%% Riccati
% Inicializando Vetores
s{N+1} = q0;

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




