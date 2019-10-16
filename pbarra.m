function p = pbarra(n1, phi, c, r, q, p0)
    if n1 == 0
        p = p0;
        return
    end
    pn = pbarra(n1 - 1, phi, c, r ,q, p0);
    p = phi^2*(pn - pn^2*c^2/(c^2*pn + r));
end