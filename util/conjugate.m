function nn = conjugate(X, T, C, maxiter, alpha_guess, nn)
    %objFunc  = LogPartialL(nn.a{end - 1}, Y, Censored, Beta, nn.W{end - 1});
    lpl_train = zeros(maxiter, 1);
    lpl_test = zeros(maxiter, 1);
    cindex_train = zeros(maxiter, 1);
    cindex_test = zeros(maxiter, 1);
    for j = 1 : nn.n - 1
        alpha = backtrack(alpha_guess, LogPartialL, X, T, C, nn);
        nn.W{j} = nn.W{j} + alpha * nn.deltaW{j};
    end
    for i = 1:maxiter
        dW_pre = nn.deltaW{j}; % previous steepest direction
        nn = calcGradient(nn, T, C, nn.W{nn.n - 1}); % current steepest direction
        beta = (nn.deltaW{j}' * nn.deltaW{j}) / (dW_pre' * dW_pre);
        for j = 1 : nn.n - 1
            nn.deltaW{j} = nn.deltaW{j} + beta * nn.deltaW{j};
            alpha = backtrack(alpha_guess, X, T, C, nn);
            nn.W{j} = nn.W{j} + alpha * nn.deltaW{j};
        end
        %% get performance with updated weights
            % apply updated parameters to train data
            b2 = nn.W{nn.n - 1};
            b2 = b2(2:end, :);
            nn = mynnff(nn, x_train, y_train, c_train);
            Xred_train_bias = nn.a{end - 1};
            Xred_train = Xred_train_bias(:, 2:end);
      
            lpl_train_show = LogPartialL(Xred_train, y_train, c_train, b2)
            lpl_train(iter) = lpl_train(iter) + lpl_train_show;
            cindex_train_show = cIndex(b2, Xred_train, y_train, c_train)
            cindex_train (iter) = cindex_train (iter) + cindex_train_show;
            
            %% Test
            % apply updated parameters to test data
            nn_test = nn;
            nn_test.testing = 1;
            nn_test = mynnff(nn, x_test, y_test, c_test);
            Xred_test = nn_test.a{end - 1};
            Xred_test = Xred_test(:, 2:end);
            
            cindex_test_show = cIndex(b2, Xred_test, y_test, c_test)
            cindex_test (iter) = cindex_test (iter) + cindex_test_show;
            lpl_test_show = LogPartialL(Xred_test, y_test, c_test, b2) 
            lpl_test(iter) = lpl_test(iter) + lpl_test_show;
            iter
    end
end
