%%odpowiedz skokowa
kon = 80;
y_mod_step = zeros(kon, 1);
for i = 8:kon
    y_mod_step(i) = W_kon(1)*1 + W_kon(2)*1 + W_kon(3)*y_mod_step(i-1) + W_kon(4)*y_mod_step(i-2);
end

clf;
hold on;
plot(y_mod_step);
xlabel('k');
legend('y_{step}');
print('-dpng', '../images/z2.png');
hold off;