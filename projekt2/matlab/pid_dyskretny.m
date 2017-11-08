function [Y, U] = pid_dyskretny()
[Gs, Gz] = transmitancja();

Kk = 0.81;
Tk = 21;
Kr = 0.6*Kk; Ti = 0.5*Tk; Td = 0.12*Tk;
disp(Kr);
disp(Ti);
disp(Td);
T = 0.5;

r2 = Kr*(Td/T);
r1 = Kr*(T/(2*Ti)-2*Td/T-1);
r0 = Kr*(1+T/(2*Ti)+Td/T);

disp('regulator dyskretny');
disp(r2);
disp(r1);
disp(r0);
z = tf('z');
Rz = (r2*z^(-2)+r1*z^(-1)+r0)/(1-z^(-1));
Gz = feedback(Rz*Gz, 1);
Y = step(Gz, 140);
U = 0;
end