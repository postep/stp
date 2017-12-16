%% wyznacznie biegunow regulatora
a = -2; b = 0.1;
p = [-1 a+b*i a-b*i];
K = acker(A, B, p)

x0 = [-1 2 1];


%% drukowanie wykresu
hold on;
plot(x1);
plot(x2);
plot(x3);
plot(Y);
plot(x);
legend('x1', 'x2', 'x3', 'y', 'u');
%legend('y', 'u');
xlabel('t');
%print('-dpng', ['z6_', num2str(a), '.png']);
print('-dpng', ['z6_', num2str(a), ',', num2str(b), '.png']);
hold off;
