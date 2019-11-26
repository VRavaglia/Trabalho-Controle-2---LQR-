

%% Controle Proporcional degrau
close all;
plot(saida, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Saida (...)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_step_saida','-depsc','-tiff')

close all;
plot(estados, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');

%legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_step_estados','-depsc','-tiff')


%% Controle Proporcional senoide
close all;
plot(saida, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Saida (...)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_sin_saida','-depsc','-tiff')

close all;
plot(estados, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');

%legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_sin_estados','-depsc','-tiff')

%% Controle Proporcional Discreto

close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;

t=tempodiscreto;

u=controlediscreto;
plot(tc,uc,'.',t,u, 'o')