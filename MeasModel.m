function yk = MeasModel(xk)
% Measurement update: measurement noise is added in thje simulink function
% block
C = [1 0 0; 0 1 0];

yk = C*xk;

end