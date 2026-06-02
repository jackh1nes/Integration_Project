function [A, B, C, D] = full_dynamics(m, l, btheta, Jtheta,bphi, Jphi, k, h)
g = 9.81;
    Ac = [0, 1, 0;...
        -(m*g*l)/Jtheta, -btheta/Jtheta, -bphi*Jtheta;...
        0, 0, -bphi/Jphi];

    Bc = [0; -k/Jtheta; -k/Jphi];

    Cc = [1, 0, 0;...
        0, 0, 1];

    Dc = [0; 0];
    
    sys = ss(Ac,Bc,Cc,Dc);
    dsys = c2d(sys, h, 'zoh');

    A = dsys.A;
    B = dsys.B;
    C = dsys.C;
    D = dsys.D;
end