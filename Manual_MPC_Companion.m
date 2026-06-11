function [H, Aineq, bineq, Aeq, beq, lb, ub] = Manual_MPC_Companion(Np, A,B, Q, R)

    n = size(A,1);
    m = size(B,2);

    nx_total = n*Np;
    n_total = (n+m)*Np;

    H = diag([kron(ones(1,Np), Q) kron(ones(1,Np), R)]);

    Aeq = zeros(n_total);
    beq = zeros(n_total,1);
    for i = 1:Np
        Aeq((i-1)*n+1:i*n, (i-1)*n+1:i*n) = A;
        Aeq((i-1)*n+1:i*n, nx_total + (i*m+1:+(i+1)*m)) = B;
        Aeq((i-1)*n+1:i*n, i*n+1:(i+1)*n) = -eye(n);
    end

    % x0 state space constraint - can't be implemented here
    Ax0 = zeros(n, length(beq)); % just conveniently there already
    Ax0(:, 1:n) = eye(n); Ax0(:, nx_total+1) = -B; 
    %bx0 = A*x0; % <<<<<==========================  x0
    Aeq = [Aeq; Ax0]; % beq = [beq; zeros(n,1)]; ===== we concatenate within simulink

    lb = [-1e6*ones(nx_total,1); -ones(m*Np,1)];
    ub = [1e6*ones(nx_total,1); ones(m*Np,1)];

    Aineq = [];
    bineq = [];





