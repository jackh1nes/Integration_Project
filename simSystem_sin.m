function [y,x] = simSystem_sin(A,B,C,D,x0,u)

N = length(u);
n = length(x0);
l = size(C,1);
x = zeros(n, N);
y = zeros(l*N,1);

x(:,1) = x0;
y(1:2) = C * x(:,1) + D * u(1);

% Convert from linearised
A_sin = [0 0 0; 0 0 0; 0 A(3,2) 0];
A(3,2) = 0;

for k = 2:N
    x(:,k) = A * x(:,k-1) + B * u(k-1) + A_sin * sin(x(:,k-1));
    y((k-1)*l+1:k*l) = C * x(:,k) + D * u(k);
end

x = x';
end