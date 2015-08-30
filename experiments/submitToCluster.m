close all;
clear all;
OutputFolder = '/home/lcoop22/TorqueOut/';
Mem = '512'; %free memory
Prefix = 'Torque.';

%% TODO: SET EXPERIMENT PARAMETERS
stepSizeMax = 1e-4;
stepSizeMin = 5e-6;
maxiter = 600;
pretrain = 1;
augment = 0;
dropoutFraction = 0;
maxLayersInExperiment = 20;
minLayersInExperiment = 1;
jumpLayers = 1;
inputZeroMaskedFraction = 0;
K = 3;
testApproach = 0; % do not do k-fold cv
idstr = [num2str(stepSizeMax) '-do' num2str(dropoutFraction) '-au' num2str(augment) '-ae' num2str(pretrain)];
mkdir(['/home/syouse3/git/survivalnet/survivalnet/NNSA-master/results/' idstr]);
path = ['/home/syouse3/git/survivalnet/survivalnet/NNSA-master/results/' idstr '/'];



%% TODO make sure about iteration
for id = minLayersInExperiment:jumpLayers:maxLayersInExperiment
%     id = id - 1;
%     if (id == 0) 
%         id = 1; 
%     end;
   fprintf('%d', id);

    %generate job string            
   %JobGen(pretrain, augment, id, stepSizeMax, stepSizeMin, maxiter, dropoutFraction, inputZeroMaskedFraction, K, testApproach, path )
       
   Job = sprintf('matlab -nojvm -nodesktop -nosplash -logfile "%s" -r "addpath(genpath(''/home/syouse3/git/survivalnet/survivalnet/NNSA-master/'')); JobGen(%d, %d, %d, %f, %f, %d, %f, %f, %d, %d, ''%s''); exit;"',...
       [OutputFolder Prefix idstr '-' num2str(id) '.txt'],...
       pretrain, augment, id, stepSizeMax, stepSizeMin, maxiter, dropoutFraction, inputZeroMaskedFraction, K, testApproach, path);
%       D,...
%       [OutputFolder num2str(id) '.mat']);
   
   %submit job
   [status, result] = SubmitTorqueJob(Job, [Prefix idstr '-' num2str(id)], Mem);
   
   %update console
   fprintf('job %d, folder: %s, status: %s.', id, num2str(id), result);
    
end