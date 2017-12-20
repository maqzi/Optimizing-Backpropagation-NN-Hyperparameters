clc;
clear;

% NOTE: Change 'I' here if main changed
I = 7500; % Epoch Limit


% a = load('results/quadratic_I-5k.mat');
a = load('results/cross_I-7p5k.mat');

% Get NNs with atleast 1 epoch > I - 500
% a.tabular(sum((a.tabular(:,:).epochs_taken>(I-5000) & a.tabular(:,:).epochs_taken<I),2)>0,:)

% Getting stats
converge = sum(a.tabular(:,1).convergence,2);
didnt_converge = 100 - sum(a.tabular(:,1).convergence,2);

nn = a.tabular.Properties.RowNames;

for i = 1:size(a.tabular,1)
    epochs_converged{i} = a.tabular.epochs_taken(i,a.tabular.epochs_taken(i,:)<I);
    params = strsplit(nn{i},'_');
    if(~isempty(epochs_converged{i}))
        mean_epo(i,1) = mean(epochs_converged{i});
        std_epo(i,1) = std(epochs_converged{i});
        med_epo(i,1) = median(epochs_converged{i});
        min_epo(i,1) = min(epochs_converged{i});
        max_epo(i,1) = max(epochs_converged{i});
    else
        mean_epo(i,1) = 0;
        std_epo(i,1) = 0;
        med_epo(i,1) = 0;
        min_epo(i,1) = 0;
        max_epo(i,1) = 0;
    end
    N1(i,1) = str2num(params{2});
    alpha(i,1) = str2num(params{3});
    zeta(i,1) = str2num(params{4});
    tf_x0(i,1) = str2num(params{5});
    p_naz{i,1} = strcat('nn_',params{2},'_',params{3},'_',params{4});
    p_nat{i,1} = strcat('nn_',params{2},'_',params{3},'_',params{5});
    p_nzt{i,1} = strcat('nn_',params{2},'_',params{4},'_',params{5});
end
labels = {'N1','alpha','zeta','x0','converged','didnt_converge','mean','st_dev','median','min','max','naz','nat','nzt'};
T = table(N1,alpha,zeta,tf_x0,converge,didnt_converge,mean_epo,std_epo,med_epo,min_epo,max_epo,p_naz,p_nat,p_nzt,'RowNames',nn,'VariableNames',labels);

% % 1 that didnt converge
%dc = a.tabular(129,:)

% writetable(T,'cross.xls')