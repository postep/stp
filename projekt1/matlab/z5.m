%% sprawdzenie sterowalno�ci i obserwowalno�ci
S = [B A*B A*A*B]
det(S)

O = [C; C*A; C*A*A]'
det(O)

latex(sym(S))
latex(sym(O))