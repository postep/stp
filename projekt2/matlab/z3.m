%%regulator pid
Kk = -0.985;
Tk = 23;
Kr = 0.6*Kk; Ti = 0.005*Tk; Td = 0.0012*Tk;
Kr = -0; Ti = 100000; Td = 0.0003;
disp(Kr);
disp(Ti);
disp(Td);
T = 0.01;

r2 = Kr*(Td/T);
r1 = Kr*(T/(2*Ti)-2*Td/T-1);
r0 = Kr*(1+T/(2*Ti)+Td/T);

z = tf('z');
Rz = (r2*z^(-2)+r1*z^(-1)+r0)/(1-z^(-1));
Gz = (W_kon(1)*z^(-6)+W_kon(2)*z^(-7))/(1-W_kon(3)*z^(-1)-W_kon(4)*z^(-2));
G = feedback(Gz, Rz);

clf;
hold on;
plot(step(G, 200));
xlabel('t');
legend('y_{step}');
print('-dpng', '../images/z3_r.png');
hold off;