function [Gs, Gz] = zadanie_1

K0 = 2.9;
T0 = 5;
T1 = 2.4;
T2 = 5.5;
Tp = 0.5
s = tf('s');
Gs = K0*exp(-T0*s)/((T1*s+1)*(T2*s+1));
Gz = c2d(Gs, Tp, 'zoh');
disp(Gs);
disp(Gz);

%% odpowiedz skokowa
T_sim = 60;

ys = step(Gs, T_sim);
yz = step(Gz, T_sim);

[Ys, Ts] = step(Gs, T_sim);
[Yz, Tz] = step(Gz, T_sim);

stairs(Tz, Yz);
hold on;
plot(Ts, Ys);
legend('Odpowiedz modelu dyskretnego', 'Odpowiedz modelu ciaglego', 'Location','southeast');
title('Porównanie odpowiedzi skokowej modeli');
xlabel('t');
ylabel('y');
print('-dpng', '../images/z1_skok.png');
hold off;

%% wzmocnienie statyczne
syms s;
k_s = limit((K0*exp(-T0*s))/((T1*s+1)*(T2*s+1)), s, 0);
disp(['Wzmocnienie statyczne modelu ciaglego:', num2str(dcgain(Gs))]);
disp(['Wzmocnienie statyczne modelu dynamicznego:', num2str(dcgain(Gz))]);

end