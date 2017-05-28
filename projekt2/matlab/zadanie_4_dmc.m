clear all;
%%REGULATOR DMC
y_step=1;        %skok
T_sim=100;       %czas symulacji
D=60;           %horyzont dynamiki
N=D;           %horyzont predykcji
Nu=10;          %horyzont sterowania
l=100;           %wsp kary

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
   
   du = K(1,:)*(y_step*ones(N,1) - yk*ones(N,1) - Mp*du_hist);
   du_hist = [du; du_hist(1:end-1)];
   uk = uk + du_hist(1);
   
   U(i) = uk;
   Y(i) = yk;
end

figure;
subplot(211);
plot(Y, 'b');
hold on;
stairs(0:T_sim, [0 y_step*ones(1,T_sim)], 'c:');
ylabel('y, yzad');
xlabel('Tp');
ylim([0 y_step*2]);
hold off;

subplot(212);
hold on;
stairs(0:T_sim, [0 U], 'm');
xlabel('Tp');
ylabel('u');
ylim([0 y_step*2]);
xlim([0 T_sim]);
hold off;
title = ['../images/z5_', num2str(D), '_', num2str(N), '_', num2str(Nu), '_', num2str(l), '.png'];
print('-dpng', title);
disp(title);