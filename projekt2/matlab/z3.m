%%regulator pid
Kr = -0.1; Ti = -0.4; Td = -0.05;

T = -0.1;
y_zad = 1;
T_sim = 80;

r2 = Kr*(Td/T);
r1 = Kr*(T/(2*Ti)-2*Td/T-1);
r0 = Kr*(1+T/(2*Ti)+Td/T);

E = zeros(T_sim, 1);
Y = zeros(T_sim, 1);
U = zeros(T_sim, 1);
Y_zad = y_zad*ones(T_sim, 1);
Y_zad(1:7) = zeros(7, 1);

for k = 8:T_sim
    Y(k) = W_kon(1)*U(k-6)+W_kon(2)*U(k-7)+W_kon(3)*Y(k-1)+W_kon(4)*Y(k-2);
    E(k) = Y_zad(k) - Y(k);
    U(k) = r2*E(k-2)+r1*E(k-2)+r0*E(k)+U(k-1);
end

figure;
subplot(211);
hold on;
plot(Y);
plot(Y_zad, '--');
hold off;
legend('Y', 'Y_z_a_d', 'Location', 'southeast');
xlabel('t');
ylabel('Wyjscie modelu');

subplot(212);
hold on;
plot(U);
xlabel('t');
ylabel('Sterowanie');
legend('U', 'Location', 'northeast');
hold off;

print('-dpng', '../images/z3.png');
