function psi = psi_fun_phi(xhat, x0, Abar, h, u)
C = 1;

% Dimensions
l = 1;

% Derivative Definitions
dAbar1 = h;

dBbar2 = h;

dx03 = 1;

N = size(xhat,1); 
p = 3; % 11 sub-parameters of theta
xhat = xhat'; % x coming in is Nxn, now is nxN

dy = zeros(l,p);
psi = zeros((N-1)*l,p);

% First iteration
dx1 = dAbar1 * x0;

dx=[dx1 0 dx03];
for k = 2:N % xhat is 0 - N-1, 
    % dy / psi update
    for i = 1 : p
        dy(:,i) = C * dx(i);
    end
    psi((k-l)*l+1:(k-l)*l+l,:) = -dy; % psi is relative to -dyhat

    % dx update
    % A parameters
    dx(:,1) = Abar * dx(1) + dAbar1 * xhat(k);

    % B parameter
    dx(:,2) = Abar * dx(2) + dBbar2 * u(k);

    % x0 parameters
    dx(:,3) = Abar * dx(3);

end
%psi = [zeros(l,p) ; psi]; % How to deal with dyhat0?
end