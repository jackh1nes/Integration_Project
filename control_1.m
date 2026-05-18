function uk = control_1(xref,phi,theta,dtheta)
xk = [phi; theta; dtheta];
K = [0.0481 -271.2109  -56.0828]; % found in sim
g_eff = 26.8000;

E_ref = 2 * g_eff; % change this constant to adjust aggressiveness
k_e = 0.5;

    if ((pi-0.2)<xk(2))&&(xk(2)<(pi+0.2))
    %LQR
        e = xk - xref;
        uk = -K * e;
    else
    % Swing up
    theta  = xk(2);
    dtheta = xk(3);

    E = 0.5 * dtheta^2 + g_eff * (1 - cos(theta));

    uk = k_e * (E - E_ref) * sign(dtheta);
    uk = max(-1, min(1, uk));  

    end

    % xk = A_nl * xk + B * uk + A_sin * sin(xk); % sim
end