function [A, B, C, D] = flywheel_dynamics(bphi, Jphi, k, h)

Ac = -bphi/Jphi;

Bc = -k/Jphi;

Cc = 1;

Dc = 0;

sys = ss(Ac,Bc,Cc,Dc);
dsys = c2d(sys, h, 'zoh');

A = dsys.A;
B = dsys.B;
C = dsys.C;
D = dsys.D;
end