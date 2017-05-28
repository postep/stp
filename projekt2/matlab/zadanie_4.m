clear all;
%%REGULATOR DMC
y_zad=1;        %skok
T_sim=100;       %czas symulacji
Nu=20;          %horyzont sterowania
D=50;           %horyzont dynamiki
N=50;           %horyzont predykcji
l=10;           %wsp kary

y_k_1 = 1.725;           %y(k-1)
y_k_2 = -0.7414;         %y(k-2)
u_k_11 = 0.0249;         %u(k-11)
u_k_12 = 0.0225;         %u(k-12)

y = zeros(N, 1);
u = ones(N, 1);
y(12)=y_k_1*y(11) + y_k_2*y(10) + u_k_11;
for k=13:N
   y(k)=y_k_1*y(k-1) + y_k_2*y(k-2) + u_k_11*u(k-11) + u_k_12*u(k-12);
end

yk=0; 
uk=0; 
du_hist = zeros(D-1,1); 


Mp=zeros(N, D-1);
for i=1:N
   for j=1:D-1
      if i+j <= D
         Mp(i,j)=y(i+j)-y(j);
      else
         Mp(i,j)=y(D)-y(j);
      end;      
   end;
end;

M=zeros(N, Nu);
for i=1:N
   for j=1:Nu
      if (i >= j)
         M(i, j)=y(i-j+1);
      end;
   end;
end;

I=eye(Nu);
K=((M'*M+l*I)^(-1))*M';

U = zeros(1, T_sim);
Y = zeros(1, T_sim);

for i=1:T_sim
   
   if i==12
       yk=y_k_1*yk+y_k_2*y(i-2)+u_k_11;
   end
   if i>=13
       yk=y_k_1*Y(i-1)+y_k_2*Y(i-2)+u_k_11*U(i-11)+u_k_12*U(i-12);
   end
   
   du = K(1,:)*(y_zad*ones(N,1) - yk*ones(N,1) - Mp*du_hist);
   du_hist = [du; du_hist(1:end-1)];
   uk = uk + du_hist(1);
   
   U(i) = uk;
   Y(i) = yk;
end

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