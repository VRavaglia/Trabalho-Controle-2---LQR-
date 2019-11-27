

%% Controle Proporcional degrau
close all;
plot(saida, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabiliza��o")
grid on;
ylabel('Saida (...)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_step_saida','-depsc','-tiff')

close all;
plot(estados, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabiliza��o")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');

%legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_step_estados','-depsc','-tiff')


%% Controle Proporcional senoide
close all;
plot(saida, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Senoide e Estabiliza��o")
grid on;
ylabel('Saida (...)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_sin_saida','-depsc','-tiff')

close all;
plot(estados, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Senoide e Estabiliza��o")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');

%legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_sin_estados','-depsc','-tiff')

%% Controle Proporcional Discreto Senoide

close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;
yd=plantoutputdiscreto;

t=tempodiscreto;

u=controlediscreto;
p = plot(t,referenciadiscreto,'-',t,yd, '.');
p(1).LineWidth = 0.1;
p(2).LineWidth = 0.1;
grid on
xlim([0 Tsimu])
title("Respota a Senoide e Estabiliza��o")
grid on;
ylabel('Sa�da (...)');
xlabel('Tempo (s)');
print('discreto_sin_saida_2f0','-depsc','-tiff')
xlim([100 10000])
print('discreto_sin_saida_zoom_2f0','-depsc','-tiff')

%% Controle Proporcional Discreto Degrau

close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;
yd=plantoutputdiscreto;
t=tempodiscreto;

u=controlediscreto;
p = plot(t,referenciadiscreto,'-',t,yd, '.');
%p(1).LineWidth = 0.1;
%p(2).LineWidth = 0.1;
grid on
%xlim([0 Tsimu])
title("Respota a Degrau e Estabiliza��o")
grid on;
ylabel('Sa�da (...)');
xlabel('Tempo (s)');
print('discreto_degrau_saida_h0','-depsc','-tiff')
xlim([Tsimu/2-100 Tsimu/2+3000])
print('discreto_degrau_saida_zoom_h0','-depsc','-tiff')

%% Riccati

aux = size(sx);
hold on;
title("Solu��o de Riccati")
grid on;
j = 1;
for k = 1:aux(1)
    plot(sx(k,:),'-', 'LineWidth', 2);
    legenda(j) = "Din�mico";
    j = j+1;
end
for k = 1:aux(1)
    plot(S(k)*ones(aux(2)), '--', 'LineWidth', 2);
    legenda(j) = "Est�tico";
    j = j+1;
end
legend(legenda)
print('ganhoS','-depsc','-tiff')
hold off;

close
aux = size(lx);
hold on;
title("Ganhos Riccati")
grid on;
j = 1;
for k = 1:aux(1)
    plot(lx(k,:),'-', 'LineWidth', 2);
    legenda(j) = "Din�mico";
    j = j+1;
end
for k = 1:aux(1)
    plot(H(k)*ones(aux(2)), '--', 'LineWidth', 2);
    legenda(j) = "Est�tico";
    j = j+1;
end
legend(legenda)
print('ganhoH','-depsc','-tiff')
hold off;
close

%% Deadbeat

close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;
yd=plantoutputdiscreto;
t=tempodiscreto;

u=controlediscreto;
hold on
p = plot(estadoscontinuo, '.');
plot(estadosdiscreto, 'o');
hold off
xlim([0 300])
%p(1).LineWidth = 0.1;
%p(2).LineWidth = 0.1;
grid on
%xlim([0 Tsimu])
title("Estados Deadbeat")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');
legend('Continuo','Continuo', 'Discreto', 'Discreto')
print('deadbeat','-depsc','-tiff')
%xlim([Tsimu/2-100 Tsimu/2+3000])
%print('deadbeat','-depsc','-tiff')

%% Riccati Deadbeat

aux = size(lx);
hold on;
title("Ganhos Riccati")
grid on;
j = 1;
for k = 1:aux(1)
    plot(lx(k,:),'-', 'LineWidth', 2);
    j = j+1;
end
%legend(legenda)
print('ganho_deadbeat','-depsc','-tiff')
xlim([0 10])
hold off;
%close

%% Comparacao LQR Estados


close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;
yd=plantoutputdiscreto;
t=tempodiscreto;

u=controlediscreto;
hold on
p = plot(eprop);
plot(elqr, '--');
hold off
xlim([0 500])
%p(1).LineWidth = 0.1;
%p(2).LineWidth = 0.1;
grid on
%xlim([0 Tsimu])
title("Comparação Estados")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');
legend('Proporcional','Proporcional', 'LQR', 'LQR')
print('comparacao_lqr_estados','-depsc','-tiff')
%xlim([Tsimu/2-100 Tsimu/2+3000])

%% Comparacao LQR controle


close all;

tc=tempocontinuo;
uc=plantinputcontinuo;
yc=plantoutputcontinuo;
yd=plantoutputdiscreto;
t=tempodiscreto;

u=controlediscreto;
hold on
p = plot(cprop);
plot(clqr);
hold off
xlim([0 300])
%p(1).LineWidth = 0.1;
%p(2).LineWidth = 0.1;
grid on
%xlim([0 Tsimu])
title("Controle")
grid on;
ylabel('Controle (..)');
xlabel('Tempo (s)');
legend('Proporcional','LQR')
print('comparacao_lqr_controle','-depsc','-tiff')
