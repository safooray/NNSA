function JobGen(pretrain, augment, id, stepSizeMax, stepSizeMin, maxiter, dropoutFraction, inputZeroMaskedFraction, K, testApproach, path )

    prepareData;
    if (augment == 0)
    else
        augmentData;
    end
    
    archs = cell(40, 1);

    %% initialize archs
    archs{1} = 20;% .* ones(1, 20);
    for i = 2:size(archs, 1)
        archs{i} = [archs{i - 1}, 20];
    end
    architecture = archs{id};
    if(pretrain == 1)
        superDeepSAE(id, Xall, X, T, C, architecture, stepSizeMax, stepSizeMin, ...
                        maxiter, dropoutFraction, inputZeroMaskedFraction, augment, K, testApproach, path);
   else
        superDeepNN(id, Xall, X, T, C, architecture, stepSizeMax, stepSizeMin, ...
                        maxiter, dropoutFraction, inputZeroMaskedFraction, K, testApproach, path);
   end
end

