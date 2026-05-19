function xnext = dynamicUpdateModel(xk,uk)
% dynamic model update 
% process noise is automatically added by the simulink function block

% current identified parameters
A = [0.9896 0 0; 0 1 0.01; -0.0001 -0.268 0.9989];
B = [4.2052; 0; 0];
% note: sampling time is baked into state matrices
% h = 0.01;

A_nl      = A;
A_nl(3,2) = 0;
A_sin = [0 0 0; 0 0 0; 0 A(3,2) 0];

%xk = [phik; thetak; dthetak]; % vector form

xnext = A_nl * xk + B * uk + A_sin * sin(xk);

end