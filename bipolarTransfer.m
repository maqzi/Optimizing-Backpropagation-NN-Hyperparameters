function [t] = bipolarTransfer(t,x0)
% t = tanh(t);

% t = 2./(1+exp(-t)) - 1;

t = tanh(t./(2*x0));

% theta = 0.8; %threshold for modified XOR
% t(t>=theta) = 1;
% t(t<-theta) = -1;
end