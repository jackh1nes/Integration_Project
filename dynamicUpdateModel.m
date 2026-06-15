function xnext = dynamicUpdateModel(xk,uk)
% dynamic model update 
% process noise is automatically added by the simulink function block

A = [1.000494318995348 0.010001647563961 2.391143629140888e-07;
     0.098871942938748 1.000494296646935 4.774374756522470e-05;
     0 0 0.989613619965214];
B = [-1.828407620987413e-04;
     0.036537646266096;
     4.191148505176509];

A_nl      = A;
A_nl(2,1) = 0;
A_sin = [0 0 0; A(2,1) 0 0; 0 0 0];

%xk = [thetak; dthetak; phik]; % vector form

xnext = A_nl * xk + B * uk + A_sin * sin(xk);

end