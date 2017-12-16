%% wyliczanie wektora L
x0 = [-1 2 1];
a = -2; b = 0.1;
p = [-2 -2 -2];
K = acker(A, B, p)

N = inv([A B; C D]) * [0 0 0 1]'
Nx = N(1:3)
Nu = N(4)

L = acker(A', C', [-1 -1 -1])



%% drukowanie wykresu
hold on;
plot(x1);
plot(x2);
plot(x3);
plot(xhat1);
plot(xhat2);
plot(xhat3);
legend('x1', 'x2', 'x3', 'xhat1', 'xhat2', 'xhat3');
xlabel('t');
print('-dpng', 'z8_-1.png');

hold off;