%% wczytywanie
dane = dlmread('dane24.txt');

u = dane(:, 1);
y = dane(:, 2);


%% obliczanie modelu
for thau=1:10
    first = max(2+thau, 3);
    M = zeros(100, 4);
    for i=first:numel(u)
        M(i, 1) = u(i-thau);
        M(i, 2) = u(i-thau-1);
        M(i, 3) = y(i-1);
        M(i, 4) = y(i-2);
    end

    W = M\y;
    y_mod = zeros(numel(u), 1);

    for i=first:numel(u)
        y_mod(i) = W(1)*u(i-thau) + W(2)*u(i-thau-1) + W(3)*y_mod(i-1) + W(4)*y_mod(i-2);
    end

    blad = (y-y_mod)'*(y-y_mod);
    disp('~~~~~~');
    disp(thau);
    disp(blad);
    disp(W);

    clf;
    hold on;
    plot(y);
    plot(y_mod);
    xlabel('u');
    ylabel('y');
    legend('y', 'y_{mod}');
    print('-dpng', ['../images/z1_', num2str(thau), '.png']);
    hold off;
end
