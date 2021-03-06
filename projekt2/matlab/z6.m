%%REGULATOR DMC
D=70; %horyzont dynamiki
N=20; %horyzont predykcji
Nu=6; %horyzont sterowania
l=3; %wsp kary
y_zad=5;
T_sim=100;
offset = 5;

S = y_mod_step(1:300);

M_p = zeros(N, D-1);
for i=1:N
    for j = 1:D-1
        M_p(i, j) = S(min(i+j, D))-S(j);
    end
end

M = zeros(N, Nu);

for i=1:N
    for j = 0:Nu-1
        if i-j >= 1
            M(i,j+1) = S(i-j);
        end
    end
end


K=((M'*M+l*eye(Nu))^(-1))*M';

Y_zad = y_zad*ones(N, 1);
Y = zeros(T_sim, 1);
U = zeros(T_sim, 1);
dU_prev = zeros(D-1, 1);
for k = 7-offset:T_sim-1
    Y_k = Y(k)*ones(N, 1);
    Y_0 = Y_k + M_p*dU_prev;
    dU = K*(Y_zad-Y_0);
    U(k+1) = dU(1) + U(k);
    Y(k+1) = W_kon(1)*U(k-5+offset) + W_kon(2)*U(k-6+offset) + W_kon(3)*Y(k) + W_kon(4)*Y(k-1);
    dU_prev = [dU(1); dU_prev(1:end-1)];
end

Jy = zeros(T_sim, 1);
for i=8:T_sim
    Jy(i) = (y_zad-Y(i))^2;
end

Ju = zeros(T_sim-1, 1);
for i=9:T_sim
    Ju(i-1) = (U(i)-U(i-1))^2;
end

disp('blad sterowania')
disp(sum(Ju))
disp('wydatek energetyczny')
disp(sum(Jy))

figure;
subplot(221);
hold on;
plot(Y);
zad = y_zad*ones(T_sim, 1);
zad(1:7) = [0 0 0 0 0 0 0];
plot(zad, '--');
hold off;
legend('Y', 'Y_z_a_d', 'Location', 'southeast');
xlabel('t');
ylabel('Wyjscie modelu');

subplot(222);
hold on;
plot(U);
xlabel('t');
ylabel('Sterowanie');
legend('U', 'Location', 'southeast');
hold off;

subplot(223);
hold on;
plot(8:T_sim, Jy(8:end));
xlabel('t');
ylabel('Blad regulacji');
legend('J_y', 'Location','northeast');
hold off;

subplot(224);
hold on;
plot(9:T_sim-1, Ju(9:T_sim-1));
xlabel('t');
ylabel('Wydatek energetyczny');
legend('J_u', 'Location','northeast');
hold off;


t = ['../images/z6_', num2str(offset), '.png'];
print('-dpng', t);
disp(t);

