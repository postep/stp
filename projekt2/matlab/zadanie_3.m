function zadanie_3()
clear all;
[Gs, Gz] = transmitancja();
[Y_ciagly, U_ciagly] = pid_ciagly();
[Y_dysk, U_dysk] = pid_dyskretny();
plot(Y_ciagly);
hold on;
plot(Y_dysk);
legend('Regulator ciagly', 'Regulator dyskretny', 'Location','southeast');
title('Porównanie regulatorów PID ciaglego i dyskretnego');
xlabel('t');
ylabel('y');
hold off;
print('-dpng', '../images/z3_pid_ciagly_dyskretny.png');
end