% close all;
% clear all;
OutputFolder = '/home/lcoop22/TorqueOut/';
Mem = '512'; %free memory
Prefix = 'Torque.';

%% TODO: SET EXPERIMENT PARAMETERS
stepSizeMax = 1e-3;
stepSizeMin = 5e-4;
maxiter = 250;
pretrainV = [1, 0];
augmentV = [1];
dropoutFractionV = [0, 0.5];
learningRateV = [1];
maxLayersInExperiment = 20;
minLayersInExperiment = 2;
hSize = 40 ;
jumpLayers = 1;
inputZeroMaskedFraction = 0;
K = 3;
testApproach = 0; % do not do k-fold cv
randLastLayerV = [0];
randAllLayersV = [0];
removeBiasInCindex = 0;



for id = minLayersInExperiment:jumpLayers:maxLayersInExperiment
    for pretrain = pretrainV
        for augment = augmentV
            for dropoutFraction = dropoutFractionV
                for learningRate = learningRateV
                    for randLastLayer = randLastLayerV
                        for randAllLayers = randAllLayersV
                            idstr = ['-do' num2str(dropoutFraction) '-au' num2str(augment) '-ae' num2str(pretrain)];
                            mkdir(['/home/syouse3/git/survivalnet/survivalnet/NNSA-master/results/' idstr]);    
                            path = ['/home/syouse3/git/survivalnet/survivalnet/NNSA-master/results/' idstr '/'];


                            %generate job string            
%                             JobGen(0, hSize, augment, id, stepSizeMax, stepSizeMin, maxiter, learningRate, dropoutFraction, inputZeroMaskedFraction, K, testApproach, randLastLayer, randAllLayers, removeBiasInCindex, path);
                            Job = sprintf('matlab -nojvm -nodesktop -nosplash -logfile "%s" -r "addpath(genpath(''/home/syouse3/git/survivalnet/survivalnet/NNSA-master/'')); JobGen(%d, %d, %d, %d, %f, %f, %d, %f, %f, %f, %d, %d, %d, %d, %d, ''%s''); exit;"',...
                            [OutputFolder Prefix idstr '-' num2str(id) '.txt'],...
                            pretrain, hSize, augment, id, stepSizeMax, stepSizeMin, maxiter, learningRate, dropoutFraction, inputZeroMaskedFraction, K, testApproach, randLastLayer, randAllLayers, removeBiasInCindex, path);

                           %submit job
                           [status, result] = SubmitTorqueJob(Job, [Prefix idstr '-' num2str(id)], Mem);

                           %update console
                           fprintf('job %d, folder: %s, status: %s.', id, num2str(id), result);
                        end
                    end
                end
            end
        end
    end
end