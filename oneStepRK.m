function [znext] = oneStepRK (z,t,h)
% Uses the Runge-Kutta 4 method on a state vector of the form [x y v_x v_y] to generate the next state vector.

% INPUTS:
% z = state vector input in form [x y v_x v_y]
% t = current time 
% h = time step

% Calculate the state derivative from the current state us
dz = stateDeriv(z,t,h);

% Calculate the next state vector from the previous one using Euler's
% update equation
A = h * dz;
B = h * stateDeriv(z+(A/2),t+(h/2),h);
C = h * stateDeriv(z+(B/2),t+(h/2),h);
D = h * stateDeriv(z+C,t+h,h);

%Generate the next state vector this is the function output
znext = z + ((A+(2*B)+(2*C)+D)/6);