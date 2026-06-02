function [parameters, A, B, C, D] = full_system_ID(u, y, h, params)

data = iddata(y,u,h);

initial_vals = {'m', params.m; ...
                'l', params.l; ...
                'btheta', params.btheta; ...
                'Jtheta', params.Jtheta;...
                'bphi', params.bphi; ...
                'Jphi', params.Jphi; ...
                'k', params.k};

setup_ID = idgrey(@full_dynamics, initial_vals, 'd', 'Ts',h); % d for discrete

%setup_ID.Structure.Parameters(1).Free = false; 
opt = greyestOptions;
[sys_est, x0] = greyest(data, setup_ID, opt);

% Add fancy stuff to compare 
% i.e.:
% opt = compareOptions('InitialCondition', 'e');
% compare(data, sysEst_dGrey, opt);

parameters.m = sys_est.Structure.Parameters(1);
parameters.l = sys_est.Structure.Parameters(2);
parameters.btheta = sys_est.Structure.Parameters(3);
parameters.Jtheta = sys_est.Structure.Parameters(4);
parameters.bphi = sys_est.Structure.Parameters(5);
parameters.Jphi = sys_est.Structure.Parameters(6);
parameters.k = sys_est.Structure.Parameters(7);

A = sys_est.A;
B = sys_est.B;
C = sys_est.C;
D = sys_est.D;

end