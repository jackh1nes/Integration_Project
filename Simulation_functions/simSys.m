function [x,y] = simSys(x_prev, u, A, B, C, D)    
A_sin = [0 0 0; 0 0 0; 0 A(3,2) 0];
A(3,2) = 0;

x = A * x_prev + A_sin * sin(x_prev) + B * u;
y = C * x_prev + D * u;
end