function s = riccati1(q0, Q ,phi, gama, k, N)
    if k == N
        s = q0;
        return
    end
    s1 = riccati(q0, Q, phi, gama, k+1, N);
    s = phi'*s1*phi + Q(1,1) - (phi'*s1*gama + Q(1,2))*(gama'*s1*gama+Q(2,2))^(-1)*(gama'*s1*phi+Q(1,2)');
end