close all;
clear all;
N = 10;
D = 100;
InputFolder = '/home/lcoop22/TorqueOut/';
OutputFolder = '/home/lcoop22/TorqueOut/';
Mem = '512'; %free memory
Prefix = 'Torque.';

%% TODO: SET EXPERIMENT PARAMETERS
stepSizeMax = 1e-4;
stepSizeMin = 5e-6;
maxiter = 300;
dropoutFraction = 0;
augment = 1;
pretrain = 0;
maxLayersInExperiment = 10;
minLayersInExperiment = 1;
jumpLayers = 1;
inputZeroMaskedFraction = 0;
K = 3;
testApproach = 0; % do not do k-fold cv
idstr = [num2str(stepSizeMax) '-do' num2str(dropoutFraction) '-au' num2str(augment) '-ae' num2str(pretrain)];
mkdir(['../results/' idstr]);
path = ['/home/syouse3/git/survivalnet/survivalnet/NNSA-master/results/' idstr '/'];



archs = cell(40, 1);

%% initialize archs
archs{1} = 20;% .* ones(1, 20);
for id = 2:size(archs, 1)
    archs{id} = [archs{id - 1}, 20];
end

%% TODO make sure about iteration
for id = minLayersInExperiment:jumpLayers:maxLayersInExperiment %+ 1
%     id = id - 1;
%     if (id == 0) 
%         id = 1 
%     end;
   fprintf('%d', id);
   %id, Xall, X, T, C, hiddenSize, stepSizeMax, stepSizeMin, maxiter, ...
    %dropoutFraction, inputZeroMaskedFraction, K, testApproach, path
   
    %generate job string
    
    %%update function name and call to augmentData\
    if(pretrain == 1)
        funcName = 'superDeepSAE';
    else
        funcName = 'superDeepNN';
    end
    
    if (augment == 0)
        augstr = '';
    else
        augstr = 'augmentData;';
    end
            
    
   Job = sprintf(['matlab -nojvm -nodesktop -nosplash -logfile "%s" -r ' ...
       '"addpath(genpath(''../../''));'... 
       'prepareData;'...
       augstr...
       'architecture = archs{%d};'...
       funcName '(%d, Xall, X, T, C, architecture, %f, %f,' ...
       '%d, %f, %f, %d, %d, ''%s''); exit;"'],...
       [OutputFolder Prefix idstr '-' num2str(id) '.txt'],...
       id,...
       id, stepSizeMax, stepSizeMin, maxiter, dropoutFraction, inputZeroMaskedFraction, K, testApproach, path);
%       D,...
%       [OutputFolder num2str(id) '.mat']);
   
   %submit job
   [status, result] = SubmitTorqueJob(Job, [Prefix idstr '-' num2str(id)], Mem);
   
   %update console
   fprintf('job %d, folder: %s, status: %s.', id, num2str(id), result);
    
end