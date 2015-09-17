
addpath(genpath('/home/syouse3/git/survivalnet/survivalnet/NNSA-master/'));

%% TODO: SET EXPERIMENT PARAMETERS
stepSizeMax = 1e-3;
stepSizeMin = 5e-5;
maxiter = 100;
pretrain = 1;
augment = 0;
dropoutFraction = 0;
maxLayersInExperiment = 1;
minLayersInExperiment = 1;
jumpLayers = 1;
inputZeroMaskedFraction = 0;
hSize = 5;
K = 3;
testApproach = 0; % do not do k-fold cv
idstr = [num2str(stepSizeMax) '-do' num2str(dropoutFraction) '-au' num2str(augment) '-ae' num2str(pretrain)];
mkdir(['/Users/Ayine/Documents/MATLAB/SurvivalNet/NNSA-master/results/' idstr]);
path = ['/Users/Ayine/Documents/MATLAB/SurvivalNet/NNSA-master/results/' idstr '/'];


%% TODO make sure about iteration
for id = minLayersInExperiment:jumpLayers:maxLayersInExperiment
 
   JobGen(pretrain, hSize, augment, id, stepSizeMax, stepSizeMin, maxiter, learningRate, dropoutFraction, inputZeroMaskedFraction, K, testApproach, randLastLayer, randAllLayers, removeBiasInCindex, path);

end