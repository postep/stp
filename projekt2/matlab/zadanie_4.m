

%%REGULATOR PID
Kk = 0.817;
%Kr = Kk; Ti=10000000; Td = 0; 
Tk = 21;
Kr = 0.6*Kk; Ti = 0.5*Tk; Td = 0.12*Tk;
disp(Kr);
disp(Ti);
disp(Td);

K0 = 2.9;
T0 = 5;
T1 = 2.4;
T2 = 5.5;
Tp = 0.5;
s = tf('s');
Gs = K0*exp(-T0*s)/((T1*s+1)*(T2*s+1));

Rs = Kr+(1/(Ti*s))+Td*s;

Gu = feedback(Gs*Rs, 1);

r2 = Td;
r1 = Tp/Ti - Kr - 2*Td;
r0 = Kr + Td;
Gz = c2d(Gs, Tp, 'zoh');
z = tf('z');
Rz = (r2*z^(-2)+r1*z^(-1)+r0)/(1-z^(-1));
Guz = feedback(Rz*Gz,1);
[Y_pid, T_pid, X_pid] = step(Guz, T_sim);

%%WYKRESY
figure;
subplot(211);
plot(Y, 'b');
hold on;
stairs(0:T_sim, [0 y_zad*ones(1,T_sim)], 'c:');
ylabel('y, yzad');
xlabel('Tp');
ylim([0 y_zad*2]);
hold off;

subplot(212);
hold on;
stairs(0:T_sim, [0 U], 'm');
xlabel('Tp');
ylabel('u');
ylim([0 y_zad*2]);
xlim([0 T_sim]);
hold off;
%print('-dpng', '../images/z4_pid_dyskretny.png');