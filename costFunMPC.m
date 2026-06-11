function cost = costFunMPC(x0, xRef, u, A, B, N, bigQ, bigR, P)
    n = size(A,1);
    xVec = zeros(n*N,1);
    xVec(1:n,1) = x0;

    for k = 1:N-1
        xk = xVec(k*(n-1)+1:k*n);
        
        xVec(k*n+1:(k+1)*n) = A*xk + B*u(k);
    end
    
    %stage cost
    jStage = (xVec - xRef)' * bigQ * (xVec - xRef) + u' * bigR * u;
    
    %terminal cost
    xN = xVec(end-(n-1):end);
    xRefN = xRef(end-(n-1):end);

    jTerminal = (xN - xRefN)' * P * (xN - xRefN);
end