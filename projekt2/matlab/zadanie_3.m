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
hold on;
step(Gu, 150);
%print('-dpng', '../images/z3_kk_ciagly.png');
%print('-dpng', '../images/z3_pid_ciagly.png');

r2 = Td;
r1 = Tp/Ti - Kr - 2*Td;
r0 = Kr + Td;
Gz = c2d(Gs, Tp, 'zoh');
disp('regulator dyskretny');
disp(r2);
disp(r1);
disp(r0);
z = tf('z');
Rz = (r2*z^(-2)+r1*z^(-1)+r0)/(1-z^(-1));
Guz = feedback(Rz*Gz,1);
step(Guz, 150);
%print('-dpng', '../images/z3_pid_dyskretny.png');
legend('Regulator ciągły', 'Regulator dyskretny', 'Location','southeast');
title('Porównanie regulatorów PID ciągłego i dyskretnego');
xlabel('t');
ylabel('y');
hold off;
print('-dpng', '../images/z3_pid_ciagly_dyskretny.png');