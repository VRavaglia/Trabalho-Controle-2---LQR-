% Graficos
aux = size(sx);
hold on;
title("Ganhos Calculados Auxiliares")
grid on;
j = 1;
for k = 1:aux(1)
    plot(sx(k,:),'-', 'LineWidth', 2);
    legenda(j) = "riccati";
    j = j+1;
end
for k = 1:aux(1)
    plot(S(k)*ones(aux(2)), '--', 'LineWidth', 2);
    legenda(j) = "dlqr";
    j = j+1;
end
legend(legenda)
print('ganhoS','-depsc','-tiff')
hold off;

close
aux = size(lx);
hold on;
title("Ganhos Calculados")
grid on;
j = 1;
for k = 1:aux(1)
    plot(lx(k,:),'-', 'LineWidth', 2);
    legenda(j) = "riccati";
    j = j+1;
end
for k = 1:aux(1)
    plot(H(k)*ones(aux(2)), '--', 'LineWidth', 2);
    legenda(j) = "dlqr";
    j = j+1;
end
legend(legenda)
print('ganhoH','-depsc','-tiff')
hold off;
close