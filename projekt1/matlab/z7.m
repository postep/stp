%%wyliczanie Nx i Ny
a = -2; b = 0.1;
p = [-2 -2 -2];
K = acker(A, B, p)

N = inv([A B; C D]) * [0 0 0 1]'
Nx = N(1:3)
Nu = N(4)

x0 = [0 0 0];


%% drukowanie wykresu
hold on;
plot(x1);
plot(x2);
plot(x3);
plot(Y);
plot(yzad);
plot(x);
legend('x1', 'x2', 'x3', 'y', 'yzad', 'u');
xlabel('t') ;
print('-dpng', 'z71.png');
hold off;
