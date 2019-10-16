function k = ganhoObs(n,phi,s,gama,Q)
    k = phi*gama*s(n + 1)/(Q(2,2) + gama^2*s(n+1));
end