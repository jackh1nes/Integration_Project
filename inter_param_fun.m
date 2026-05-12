function [dx, y] = inter_param_fun(t,x,u,a1,a2,a3, a4, a5, varargin)

phi_dot = x(1);
theta = x(2);
theta_dot = x(3);

i = u(1);

dx = zeros(3,1);

dx(1) = -a1 * phi_dot + a5 * i;
dx(2) = theta_dot;
dx(3) = a2*phi_dot - a3 * sin(theta) - a4 * theta_dot;

y = [phi_dot; theta];
end