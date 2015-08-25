%vars = var(X);
Xa = zeros(size(X, 1)* 2, size(X, 2));
for j = 1:size(X, 2)
    if (length(unique(X(:, j))) > 3)
        Xa(:, j) = [X(:, j); X(:, j) + (rand(size(X(:, j))) .* 2 - 1)];
    else
        Xa(:, j) =[X(:, j); X(:, j)];
    end
end
X = Xa;
T = [T;T];
C = [C;C];