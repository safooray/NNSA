%vars = var(X);
Xa = zeros(size(Xall, 1)* 2, size(Xall, 2));
for j = 1:size(Xall, 2)
    if (length(unique(Xall(:, j))) > 3)
        Xa(:, j) = [Xall(:, j); Xall(:, j) + ((rand(size(Xall(:, j))) .* 2 - 1)) .* .2];
    else
        Xa(:, j) =[Xall(:, j); Xall(:, j)];
    end
end
Xall = Xa;
X = [Xall(1:190, :); Xall(291:480, :)];
T = [T;T];
C = [C;C];