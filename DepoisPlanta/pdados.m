

%% Controle Proporcional degrau
close all;
hold on
plot(referenciacontinuo, 'LineWidth', 2)
plot(plantoutputcontinuo, 'LineWidth', 2)
hold off
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Saida (Pa)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_step_saida','-depsc','-tiff')
%% Estados
ec = zeros(Tsimu + 1,2);
ec(:,1) = estadoscontinuo(1,1,:);
ec(:,2) = estadoscontinuo(2,1,:);
plot(ec, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');

%legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_step_estados','-depsc','-tiff')


%% Controle Proporcional senoide
close all;
hold on
t = 1:Tsimu;
plot(a0*sin(f0*t/h/6.28/5 - pi), 'LineWidth', 2)
plot(plantoutputcontinuo, 'LineWidth', 2)
hold off
xlim([0 Tsimu])
title("Respota a Senoide e Estabilização")
grid on;
ylabel('Saida (Pa)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('proporcional_sin_saida','-depsc','-tiff')
%% Estados
close all;
ec = zeros(Tsimu + 1,2);
ec(:,1) = estadoscontinuo(1,1,:);
ec(:,2) = estadoscontinuo(2,1,:);
plot(ec, 'LineWidth', 2)
xlim([0 Tsimu])
title("Respota a Senoide e Estabilização")
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
title("Respota a Senoide e Estabilização")
grid on;
ylabel('Saída (Pa)');
xlabel('Tempo (s)');
print('discreto_sin_saida_2f0','-depsc','-tiff')

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
legend({'Entrada', 'Saida'}, 'Location','southeast');
title("Respota a Degrau e Estabilização")
grid on;
ylabel('Saída (Pa)');
xlabel('Tempo (s)');
print('discreto_degrau_saida_h010','-depsc','-tiff')

%% Riccati

aux = size(sx);
hold on;
title("Solução de Riccati")
grid on;
j = 1;
for k = 1:aux(1)
    plot(sx(k,:),'-', 'LineWidth', 2);
    legenda(j) = "Dinâmico";
    j = j+1;
end
for k = 1:aux(1)
    plot(S(k)*ones(aux(2)), '--', 'LineWidth', 2);
    legenda(j) = "Estático";
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
    legenda2(j) = "Dinâmico";
    j = j+1;
end
for k = 1:aux(1)
    plot(H(k)*ones(aux(2)), '--', 'LineWidth', 2);
    legenda2(j) = "Estático";
    j = j+1;
end
legend(legenda2)
print('ganhoH','-depsc','-tiff')
hold off;
%close

%% Deadbeat

close all;

ec = zeros(Tsimu + 1,2);
ec(:,1) = estadoscontinuo(1,1,:);
ec(:,2) = estadoscontinuo(2,1,:);

ed = zeros(Tsimu/h + 1,2);
ed(:,1) = estadosdiscreto(1,1,:);
ed(:,2) = estadosdiscreto(2,1,:);

hold on
plot(ec, '.');
plot(tempodiscreto, ed, 'o');
hold off
xlim([0 Tsimu])
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

xlim([1 10])
print('ganho_deadbeat','-depsc','-tiff')
hold off;
%close

%% Comparacao LQR Transitorio


close all;

%eprop = plantoutputcontinuo;
elqr = plantoutputcontinuo;

% elqr = zeros(Tsimu + 1,2);
% elqr(:,1) = estadoscontinuo(1,1,:);
% elqr(:,2) = estadoscontinuo(2,1,:);

hold on
plot(eprop);
plot(elqr, '--');
hold off
xlim([1 Tsimu])
%p(1).LineWidth = 0.1;
%p(2).LineWidth = 0.1;
grid on
xlim([0 1000])
title("Comparação Entre Estados")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');
legend('Proporcional', 'LQR')
print('comparacao_lqr_estados','-depsc','-tiff')
%xlim([Tsimu/2-100 Tsimu/2+3000])

%% Comparacao LQR controle


close all;

%cprop = zeros(Tsimu/h + 1,1);
%cprop(:,1) = controlediscreto(1,1,:);

%clqr = zeros(Tsimu/h + 1,1);
%clqr(:,1) = controlediscreto(1,1,:);



hold on
p = plot(tempodiscreto(:,1), cprop, 'LineWidth', 2);
plot(tempodiscreto, clqr, 'LineWidth', 2);
hold off
xlim([0 5000])
%p(1).LineWidth = 0.1;
%p(2).LineWidth = 0.1;
grid on
%xlim([0 Tsimu])
title("Comparação Entre o Controle LQR e Proporcional")
grid on;
ylabel('Controle');
xlabel('Tempo (s)');
legend('Proporcional','LQR')
print('comparacao_lqr_controle','-depsc','-tiff')
ylim([-500 500])
xlim([0 1000])
print('comparacao_lqr_controle_zoom','-depsc','-tiff')

%% Observador
plot(Observador, 'LineWidth', 2);
title("Observação dos Estados")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');
legend('Planta','Planta','Observador','Observador')
print('observador_luenberger','-depsc','-tiff')

%% Obs Resp Degrau proporcional

close all;
hold on
plot(referenciacontinuo, 'LineWidth', 2)
plot(plantoutputcontinuo, 'LineWidth', 2)
hold off
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização Controle Proporcional")
grid on;
ylabel('Saida (Pa)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('observador_step_proporcional','-depsc','-tiff')

%% Obs Resp Degrau lqr

close all;
hold on
plot(referenciacontinuo, 'LineWidth', 2)
plot(plantoutputcontinuo, 'LineWidth', 2)
hold off
xlim([0 Tsimu])
title("Respota a Degrau e Estabilização Controle Proporcional")
grid on;
ylabel('Saida (Pa)');
xlabel('Tempo (s)');

legend({'Entrada', 'Saida'}, 'Location','southeast');
print('observador_step_lqr','-depsc','-tiff')

%% Kalman

plot(Kalman, 'LineWidth', 2);
title("Observação dos Estados")
grid on;
ylabel('Estados (Kg)');
xlabel('Tempo (s)');
legend('Planta','Planta','Observador','Observador')
print('observador_kalman','-depsc','-tiff')




