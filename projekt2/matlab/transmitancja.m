function [Gs, Gz] = transmitancja()
K0 = 2.9;
T0 = 5;
T1 = 2.4;
T2 = 5.5;
Tp = 0.5;
s = tf('s');
Gs = K0*exp(-T0*s)/((T1*s+1)*(T2*s+1));
Gz = c2d(Gs, Tp, 'zoh');
end