function [convergence, epochs_taken, errors, initial_wih, initial_who, initial_bih, initial_bho,final_wih,final_who,final_bih,final_bho] = run_nn(s,t,n0,n2,iters,alpha,I,n1,zeta,tf_x0)

multiple = zeta/.5;
%% Start

% Program info
convergence = zeros(1,iters);
epochs_taken = ones(1,iters)*I;
errors = {};
initial_wih = {};
initial_who = {};
initial_bih = {};
initial_bho = {};
final_wih = {};
final_who = {};
final_bih = {};
final_bho = {};

for nn = 1:iters
    %% Initialization
    %     wih = multiple*(rand(n0,n1) - 0.5);
    %     who = multiple*(rand(n1,n2) - 0.5);
    %     bih = multiple*(rand(1,n1) - 0.5);
    %     bho = multiple*(rand(1,n2) - 0.5);
    
    % % Book Values
    bho = -0.1401;
    who = [0.4919;-0.2913;-0.3979;0.3581];
    bih = [-0.3378,0.2771,0.2859,-0.3329];
    wih = [0.1970,0.3191,-0.1448,0.3594;
        0.3099,0.1904,-0.0347,-0.4861];
    
    %% NN
    E = zeros(1,I);
    x = [ones(size(s,1),1), s]; % add x0
    
    for i = 1:I
        
        if i == 1
            initial_wih{nn} = wih;
            initial_who{nn} = who;
            initial_bih{nn} = bih;
            initial_bho{nn} = bho;
        end
        
        epoch_res = zeros(size(t,1),size(t,2));
        for j = 1:size(t,1)
            wihb = [bih; wih]; % add bias
            whob = [bho; who]; % add bias
            
            %% Forward Propagation
            yinh = x(j,:) * wihb;
            youth = bipolarTransfer(yinh, tf_x0);
            
            youthb = [ones(size(youth,1),1), youth];
            yino = youthb * whob;
            yout = bipolarTransfer(yino,tf_x0);
            
            epoch_res(j) = yout;
            
            %% Back Propagation
            %             delout = (yout - t(j,:)) .* bipolarDeriv(yino, tf_x0); %quad
            delout = -2./(yout + t(j,:)) .* bipolarDeriv(yino, tf_x0); %cross
            delhid = bipolarDeriv(yinh,tf_x0) .* (delout * who');
            
            %% Update
            who = who - alpha * youth' * delout;
            bho = bho - alpha * delout;
            wih = wih - alpha * x(j,2:end)' * delhid;
            bih = bih - alpha * delhid;
        end
        
        %% Check Break Condition
        err = sum((t - epoch_res).^2);
        E(i)=err;
        if(err<=0.05)
            convergence(nn) = 1;
            epochs_taken(nn) = i;
            break
        end
    end
    
    errors{nn} = E;
    final_wih{nn} = wih;
    final_who{nn} = who;
    final_bih{nn} = bih;
    final_bho{nn} = bho;
end

end
