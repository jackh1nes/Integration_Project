% function [H, Aineq, bineq, Aeq, beq, lb, ub] = Manual_MPC_Companion(Np, A,B, Q, R)
% 
%     n = size(A,1);
%     m = size(B,2);
% 
%     nx_total = n*Np;
%     n_total = (n+m)*Np;
% 
%     %H = diag([kron(ones(1,Np), Q) kron(ones(1,Np), R)]);
%     Qbar = kron(eye(Np), Q);
%     Rbar = kron(eye(Np), R);
%     H = blkdiag(Qbar, Rbar);
% 
%     Aeq = zeros(nx_total, n_total);
%     beq = zeros(nx_total,1);
%     for i = 1:Np-1
%         Aeq((i-1)*n+1:i*n, (i-1)*n+1:i*n) = A;
%         Aeq((i-1)*n+1:i*n, nx_total + (i*m+1:(i+1)*m)) = B;
%         Aeq((i-1)*n+1:i*n, i*n+1:(i+1)*n) = -eye(n);
%     end
% 
%     % x0 state space constraint - can't be implemented here
%     Ax0 = zeros(n, n_total); % just conveniently there already
%     Ax0(:, 1:n) = eye(n); Ax0(:, nx_total+1) = -B; 
%     disp(size(Aeq))
%     disp(size(Ax0))
%     %bx0 = A*x0; % <<<<<==========================  x0
%     Aeq = [Aeq; Ax0]; % beq = [beq; zeros(n,1)]; ===== we concatenate within simulink
% 
%     lb = [-1e6*ones(nx_total,1); -ones(m*Np,1)];
%     ub = [1e6*ones(nx_total,1); ones(m*Np,1)];
% 
%     Aineq = [];
%     bineq = [];
% end


function [H, Aineq, bineq, Aeq, beq, lb, ub] = Manual_MPC_Companion(Np, A, B, Q, R)
    [~, P, ~] = dlqr(A,B,Q,R,[]);
    n = size(A, 1);
    m = size(B, 2);
    nx_total = n * Np;
    nu_total = m * Np;
    n_total  = nx_total + nu_total;

    % Cost matrices
    Qbar = blkdiag(kron(eye(Np-1), Q), P);
    Rbar = kron(eye(Np), R);
    H    = blkdiag(Qbar, Rbar);

    % Equality constraints: dynamics
    % Decision vector layout: [x_1, x_2, ..., x_Np, u_1, u_2, ..., u_Np]
    % For i = 1..Np-1:  A*x_i + B*u_i - x_{i+1} = 0
    Aeq  = zeros(n * Np, n_total);
    beq  = zeros(n * Np, 1);

    for i = 1:Np-1
        row_idx = (i-1)*n + 1 : i*n;
        x_i_cols   = (i-1)*n + 1 : i*n;
        x_ip1_cols = i*n     + 1 : (i+1)*n;
        u_i_cols   = nx_total + (i-1)*m + 1 : nx_total + i*m;  % FIXED

        Aeq(row_idx, x_i_cols)   =  A;
        Aeq(row_idx, u_i_cols)   =  B;   % FIXED index
        Aeq(row_idx, x_ip1_cols) = -eye(n);
    end

    % Initial state constraint: x_1 - B*u_1 = A*x_0
    % (beq rows n*(Np-1)+1 : n*Np filled externally in Simulink with A*x0)
    Ax0_row = n*(Np-1) + 1 : n*Np;
    Aeq(Ax0_row, 1:n)                        =  eye(n);
    Aeq(Ax0_row, nx_total+1 : nx_total+m)    = -B;      % x_1 = A*x0 + B*u_1

    % Bounds
    lb = [-1e6*ones(nx_total, 1); -ones(nu_total, 1)];
    ub = [ 1e6*ones(nx_total, 1);  ones(nu_total, 1)];

    Aineq = [];
    bineq = [];
end




