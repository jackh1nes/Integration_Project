function [dx,y] = theta_greybox(t,x,u,a3,a4, varargin)

    theta = x(1);
    theta_dot = x(2);
    
    dx = zeros(2,1);
    
    dx(1) = theta_dot;
    dx(2) = -a3*sin(theta) - a4 * theta_dot;
    y = theta;

end

%[appendix]{"version":"1.0"}
%---
