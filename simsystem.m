function [y,x] = simsystem(A, B, C, x0, u)
N = length(u);
n = length(x0);
l = size(C,1);
x = zeros(n, N);
y = zeros(l*N,1);

x(:,1) = x0;
y(1:l) = C * x(:,1);

for k = 2:N
    x(k) = A * x(k-1) + B * u(k-1);
    y((k-1)*l+1:k*l) = C * x(k);
end

x = x';
end