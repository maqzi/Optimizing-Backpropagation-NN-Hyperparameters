function [ t] = bipolarDeriv( t,tf_x0)
% t = .5*(1+bipolarTransfer(t)).*(1-bipolarTransfer(t));
% t = 1 - (tanh(t)).^2;
t = .5 * (1 + bipolarTransfer(t,tf_x0)) .* (1 - bipolarTransfer(t,tf_x0));

end

