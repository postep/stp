function [Y, U] = pid_ciagly()
    [Gs, Gz] = transmitancja();
    Kk = 0.81;
    Tk = 21;
    Kr = 0.6*Kk; Ti = 0.5*Tk; Td = 0.12*Tk;
    disp(Kr);
    disp(Ti);
    disp(Td);
    s = tf('s');
    Rs = Kr*(1+(1/(Ti*s))+Td*s);
    Gu = feedback(Rs*Gs, 1);
    hold on;
    Y = step(Gu, 140);
    U = 0;
end