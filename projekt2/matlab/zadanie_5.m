function zadanie_5()
    figure;
    hold on;
    for i=[1, 2, 3, 5, 10, 20, 30, 40, 50, 60]
        [Y_sim, T_sim, U_sim] = dmc(1, 100, 60, 60, i, 1);
        stairs(T_sim, U_sim);
    end
    hold off;
    print('-dpng', '../images/z5_c.png');
end

function [Y_sim, T_sim, U_sim]=dmc(y_step, T_sim, D, N, Nu, l)
%%REGULATOR DMC

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

Y_sim = [0 y_step*ones(1,T_sim)];
disp(Y_sim);
U_sim = [0 U];
T_sim = 0:T_sim;
end
