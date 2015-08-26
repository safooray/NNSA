clear all;
close all;
%load('sae-1-0.001-ci-tst.mat');
% load('sae-1-0.001-ci-trn.mat');
 load('sae-1-0.0001-ci-tst.mat');
% load('sae-1-0.0001-ci-trn.mat');
hlines(1) = plot(1:300, cindex_test);
set(hlines(1), 'color', [51/255 0 0]);
hold on

%load('sae-2-0.001-ci-tst.mat');
% load('sae-2-0.001-ci-trn.mat');
 load('sae-2-0.0001-ci-tst.mat');
% load('sae-2-0.0001-ci-trn.mat');
hlines(2) = plot(1:300, cindex_test);
set(hlines(2), 'color', [102/255 51/255 0]);
hold on

%load('sae-3-0.001-ci-tst.mat');
% load('sae-3-0.001-ci-trn.mat');
 load('sae-3-0.0001-ci-tst.mat');
% load('sae-3-0.0001-ci-trn.mat');
hlines(3) = plot(1:300, cindex_test);
set(hlines(3), 'color', [153/255 153/255 0]);
hold on

%load('sae-4-0.001-ci-tst.mat');
% load('sae-4-0.001-ci-trn.mat');
 load('sae-4-0.0001-ci-tst.mat');
% load('sae-4-0.0001-ci-trn.mat');
hlines(4) = plot(1:300, cindex_test);
set(hlines(4), 'color', [102 204 0] ./ 255);
hold on

%load('sae-5-0.001-ci-tst.mat');
% load('sae-5-0.001-ci-trn.mat');
 load('sae-5-0.0001-ci-tst.mat');
% load('sae-5-0.0001-ci-trn.mat');
hlines(5) = plot(1:300, cindex_test);
set(hlines(5), 'color', [51 255 153] ./ 255);
hold on

%load('sae-6-0.001-ci-tst.mat');
% load('sae-6-0.001-ci-trn.mat');
 load('sae-6-0.0001-ci-tst.mat');
% load('sae-6-0.0001-ci-trn.mat');
hlines(6) = plot(1:300, cindex_test);
set(hlines(6), 'color', [102 255 255] ./ 255);
hold on

%load('sae-7-0.001-ci-tst.mat');
% load('sae-7-0.001-ci-trn.mat');
 load('sae-7-0.0001-ci-tst.mat');
% load('sae-7-0.0001-ci-trn.mat');
hlines(7) = plot(1:300, cindex_test);
set(hlines(7), 'color', [255 0 0] ./ 255);
hold on

%load('sae-8-0.001-ci-tst.mat');
% load('sae-8-0.001-ci-trn.mat');
 load('sae-8-0.0001-ci-tst.mat');
% load('sae-8-0.0001-ci-trn.mat');
hlines(8) = plot(1:300, cindex_test);
set(hlines(8), 'color', [0 0 204] ./ 255);
hold on

%load('sae-9-0.001-ci-tst.mat');
% load('sae-9-0.001-ci-trn.mat');
 load('sae-9-0.0001-ci-tst.mat');
% load('sae-9-0.0001-ci-trn.mat');
hlines(9) = plot(1:300, cindex_test);
set(hlines(9), 'color', [255 51 153] ./ 255);
hold on

%load('sae-10-0.001-ci-tst.mat');
% load('sae-10-0.001-ci-trn.mat');
 load('sae-10-0.0001-ci-tst.mat');
% load('sae-10-0.0001-ci-trn.mat');
hlines(10) = plot(1:300, cindex_test);
set(hlines(10), 'color', [153 51 255] ./ 255);

legend([hlines], '1', '2', '3', '4', '5', '6', '7', '8', '9', '10');