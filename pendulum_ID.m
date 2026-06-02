function [m, l, btheta, Jtheta] = pendulum_ID(u, y, h)
    
data = iddata(y,[],h);

initial_vals = {'m', 1; ...
                'l', 0.3; ...
                'btheta', 0.5; ...
                'Jtheta', 0.2;};

setup_ID = idgrey(@pendulum_dynamics, initial_vals, 'd', 'Ts', h); % d for discrete

opt = greyestOptions;
[sys_est, x0] = greyest(data, setup_ID, opt);


% Add fancy stuff to compare 
% i.e.:
% opt = compareOptions('InitialCondition', 'e');
% compare(data, sysEst_dGrey, opt);

m = sys_est.Structure.Parameters(1).Value;
l = sys_est.Structure.Parameters(2).Value;
btheta = sys_est.Structure.Parameters(3).Value;
Jtheta = sys_est.Structure.Parameters(4).Value;
    
end