%Equivalencia de funcoes:
%k[n] - ganhoObs()
%s[n] - riccati()
%pbarra[n+1] - pbarra()
%p - pnaobarra()

N = 5;
q0 = 1;
Q = [1 1;1 1];
phi = 1;
gama = 1;
s = zeros(1,N);

%Nao eficiente
for i = 1:N
    s(i) = riccati(q0, Q ,phi, gama, i, N);
end