%%pomoc do dowodu rownosci wariantow
syms('b2', 'b1', 'b0', 'a2', 'a1', 'a0');

A_1 = [-a2 -a1 -a0; 1 0 0; 0 1 0]
B_1 = [1; 0; 0]
C_1 = [b2 b1 a0]
D = 0


s = tf('s')

