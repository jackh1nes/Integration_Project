function [dx, y] = inter_param_fun(t,x,u,a2, varargin)

phi_dot = x(1);
theta = x(2);
theta_dot = x(3);

i = u(1);

dx = zeros(3,1);

dx(1) = (0.9904-1)/0.01 * phi_dot + 413.34 * i;
dx(2) = theta_dot;
dx(3) = a2*phi_dot - 0.033262024/0.01 * sin(theta) + (0.99812133-1)/0.01 * theta_dot;

y = [phi_dot; theta];
end