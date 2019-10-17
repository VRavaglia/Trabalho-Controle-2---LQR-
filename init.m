

N = 10;
q0 = 1;
Q = [1 1;1 1];
phi = 1;
gama = 1;
c = 1;
s = zeros(1,N+1);
k = zeros(1, N);
p0 = 1;
x0 = 0;
R = 1;

s(N + 1) = q0;
for i = N:-1:1
    s(i) = phi*s(i + 1)*phi + Q(1,1) - phi^2*gama^2*s(i + 1)^2/(gama^2*s(i + 1) + Q(2,2));
    k(i) = phi*gama*s(i + 1)/(Q(2,2) + gama^2*s(i + 1));
end

