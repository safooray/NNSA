close all;
clear all;
prepareData
augmentData
stepSizeMax = 1e-4;
stepSizeMin = 5e-6;
maxiter = 200;
dropoutFraction = .5;
inputZeroMaskedFraction = 0;
K = 3;
testApproach = 0; % do not do k-fold cv

archs = cell(1, 1);
%% initialize archs
archs{1} = [20];
for id = 2:size(archs, 1)
    archs{id} = [archs{id - 1}, 20];
end

for id = 1:size(archs, 1)
   architecture = archs{id};
   superDeepSAE (id, X, T, C, architecture, stepSizeMax, stepSizeMin, maxiter, dropoutFraction, inputZeroMaskedFraction, K, testApproach)
end