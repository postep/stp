%% transmitancja ci¹g³a
numerator = [0 1 4 1.75]
denominator = [1 3 -34 -120]
Gs = tf(numerator, denominator)


%sprawdzenie czy zera i bieguny poprawne
roots(numerator)
roots(denominator)

%wyznacznie modelu w przestrzeni stanow, wariant 1

A = [-3 34 120; 1 0 0; 0 1 0]
B = [1; 0; 0]
C = [1 4 1.75]
D = 0

%sprawdzenie czy transmitancja taka jak poczatkowa
[l,m]=ss2tf(A,B,C,D)
display(l)
display(m)

%wyznacznie drugiego wariantu
A_2 = A'
B_2 = C'
C_2 = B'
D_2 = D


%eksport do latecha
display('pierwszy wariant')
latex(sym(A))
latex(sym(B))
latex(sym(C))
latex(sym(D))
display('drugi wariant')
latex(sym(A_2))
latex(sym(B_2))
latex(sym(C_2))
latex(sym(D_2))

