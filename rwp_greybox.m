function [dx, y] = rwp_greybox(t, x, u, d22, d12, d21, d11, varargin)

theta     = x(1); 
theta_dot = x(2); 
phi_dot   = x(3);

i = u(1);

dx = zeros(3,1);

dx(1) = theta_dot;
dx(2) = d22*sin(theta) - d12*i;
dx(3) = -d21*sin(theta) + d11*i;

y = [phi_dot; theta];

end