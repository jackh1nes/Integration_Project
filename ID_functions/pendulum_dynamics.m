function [A, B, C, D] = pendulum_dynamics(m,l,btheta,Jtheta, h)
g = 9.81;
Ac = [0 1; -m*g*l/Jtheta -btheta/Jtheta];

Bc = zeros(2,0); % Unforced for now

Cc = [1 0];

Dc = zeros(1,0);

sys = ss(Ac,Bc,Cc,Dc);
dsys = c2d(sys, h, 'zoh');

A = dsys.A;
B = dsys.B;
C = dsys.C;
D = dsys.D;
end