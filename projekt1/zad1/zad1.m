Tp=0.1;
licznik_s=[0 0.5 3.25 5.25];
mianownik_s=[1 7 -14 -120];

%transmitancje
G_s=tf(licznik_s, mianownik_s);
G_z=c2d(G_s,Tp,'zoh');
[licznik_z mianownik_z]=tfdata(G_z,'v');
display(licznik_z);
display(mianownik_z);

%zera i bieguny 
[z_s p_s k]=tf2zp(licznik_s,mianownik_s);
[z_z p_z k]=tf2zp(licznik_z,mianownik_z);

%wykresy
figure;
hold on;
zplane(licznik_s, mianownik_s);
grid on;
title('Zera i bieguny G(s)');
legend('zero','biegun');
hold off;
print('G_s','-dpng','-r900');

figure;
hold on;
zplane(licznik_z, mianownik_z);
grid on;
title('Zera i bieguny G(z)');
legend('zero','biegun');
hold off;
print('G_z','-dpng','-r900');

