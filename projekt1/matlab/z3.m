%% wprowadzenie warunkow poczatkowych
x0 = [0.1 0.1 0.1]
%% transmitancja ci¹g³a
hold on;
xlabel('t')
plot(w1);
plot(w2);
plot(t);
plot(u);
legend('wariant 1','wariant 2', 'transmitancja', 'u(t)')

hold off;
print('-dpng', '../images/z3c.png')