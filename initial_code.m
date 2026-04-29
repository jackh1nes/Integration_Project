tend = 40;
t = 0:h:tend;

stim_input_1 = (1/3)*sin(3*t) + 0.25 * sin(t/4) + 0.25*sin(t+0.25) + 0.4 * sin(t/10);
%plot(t,stim_input_1);
input_1 = timeseries(stim_input_1, t);

stim_step = 0.5*ones(1,size(t,2)-200);
stim_step = [zeros(1,200) stim_step];
step = timeseries(stim_step, t);
