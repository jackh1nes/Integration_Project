function [A, B, C,x0] = theta2matrices_phi(theta, h)
a1 = theta(1); a2 = theta(2);
x0 = theta(3);

A = 1 + h*a1;
B = a2*h;
C = 1;
end