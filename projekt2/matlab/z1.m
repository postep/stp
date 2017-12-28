%% wczytywanie
dane = dlmread('dane24.txt');

u = dane(:, 1);
y = dane(:, 2);


%% obliczanie modelu
for tau=1:10
    first = max(2+tau, 3);
    M = zeros(100, 4);
    for i=first:numel(u)
        M(i, 1) = u(i-tau);
        M(i, 2) = u(i-tau-1);
        M(i, 3) = y(i-1);
        M(i, 4) = y(i-2);
    end
    W = M\y;
    if tau == 6 W_kon = W; end;
    y_mod = zeros(numel(u), 1);

    for i=first:numel(u)
        y_mod(i) = W(1)*u(i-tau) + W(2)*u(i-tau-1) + W(3)*y_mod(i-1) + W(4)*y_mod(i-2);
    end

    blad = (y-y_mod)'*(y-y_mod);
    disp('~~~~~~');
    disp(tau);
    disp(blad);
    disp(W);

    clf;
    hold on;
    plot(y);
    plot(y_mod);
    xlabel('k');
    ylabel('y');
    legend('y', 'y_{mod}');
    print('-dpng', ['../images/z1_', num2str(tau), '.png']);
    hold off;
end
