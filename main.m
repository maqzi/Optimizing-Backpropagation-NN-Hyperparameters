%%
%TODO: 
% a. Quadratic: various Ns
% b. Quadratic: N = 1
% c. Cross-Entropy: various Ns
% d. Cross-Entropy: N = 1
%%

clear;
clc;

%% Input
s = [1, 1;
    1, -1;
    -1, 1;
    -1, -1];

t = [-1; 1; 1; -1];

%% Parameters:
n0 = 2; % in
n2 = 1; % out
eta = 1;
iters = 100; % how many runs of each nn

% alpha = [.1,.2,.3].* eta; % LR
% I = 7500; % I
% % n1 = [2,4,6,8,10]; % hidden Neurons
% zeta = [.5,1,1.5];
% tf_x0 = [.5,1,1.5];

% % Default Values for single run
alpha = .2* eta; % LR
I = 1500; % I
n1 = 4; % hidden Neurons (4 - cross, 4 - quad)
zeta = 1;
tf_x0 = 1;

labels = {'convergence', 'epochs_taken', 'errors', 'initial_wih', 'initial_who', 'initial_bih', 'initial_bho', 'final_wih', 'final_who', 'final_bih', 'final_bho'};
row_names = {};
results = {};

tic % start timer
for nn = n1
    for alph = alpha
       for z = zeta
          for x0 = tf_x0
             this_nn = sprintf('nn_%d_%.1f_%.1f_%.1f', nn, alph, z, x0);
             disp(this_nn)
             [convergence, epochs_taken, errors, initial_wih, initial_who, initial_bih, initial_bho, final_wih, final_who, final_bih, final_bho] = run_nn(s, t, n0, n2, iters, alph, I,nn, z, x0);
             
             row = {convergence, epochs_taken, errors, initial_wih, initial_who, initial_bih, initial_bho, final_wih, final_who, final_bih, final_bho};
             
             row_names = {row_names{:}, this_nn};
             results(end+1,:)=row;
          end
       end
    end
end
disp(toc)

disp('now reading/writing')

tabular = cell2table(results,'VariableNames',labels,'RowNames',row_names);
save results/quadratic_N1_I-7p5k.mat tabular

disp('finished in')
disp(toc)

