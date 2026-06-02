function [bphi, Jphi, k] = flywheel_ID(u, y, h)

data = iddata(y,u,h);

% Figure out better initial values
initial_vals = {'bphi', 1; ...
                'Jphi', 1; ...
                'k', 1;};

setup_ID = idgrey(@flywheel_dynamics, initial_vals, 'd', 'Ts',h); % d for discrete

opt = greyestOptions; %in case needed
[sys_est, x0] = greyest(data, setup_ID, opt);

% Add fancy stuff to compare 
% i.e.:
% opt = compareOptions('InitialCondition', 'e');
% compare(data, sysEst_dGrey, opt);

bphi = sys_est.Structure.Parameters(1).Value;
Jphi = sys_est.Structure.Parameters(2).Value;
k = sys_est.Structure.Parameters(3).Value;
end