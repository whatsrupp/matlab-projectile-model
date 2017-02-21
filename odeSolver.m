function [z] = odeSolver(theta, v_0)
%NB^tlim used to be the first input
% Solve the inital value ODE surrounding the motion of a projectile 
% 
% Inputs:
% tlim  = time vector in the form [1 tend] where tend is the end time
% theta = angle of projectile launch (radians)
% v_0   = Absolute launch speed (m/s)
% h     = Time step used for calculations

%Values to be used for Shooting Method Function
h       = 0.1;
tlim    = [1 200];

%Set Initial Launch conditions
x   = 0;                 % x displacement
y   = 0;                 % y displacement
v_x = v_0*cos(theta);    % x velocity
v_y = v_0*sin(theta);    % y velocity

%Enter Launch Conditions into an initial state vector z
z(1,:)=[x y v_x v_y];

% Set initial conditions
t(1) = tlim(1);

% Continue stepping until the end time is exceeded OR the projectile hits
% the ground
n=1;
while t(n) <= tlim(2)&& z(n,2)>=0
    % Increment the time vector by one time step
    t(n+1) = t(n) + h;
    
    % Apply Runge Kutta's method for one time step to find the next values
    % and append to the updated state vector to a value matrix
    
    [z(n+1,:)] = oneStepRK(z(n,:), t(n), h);
    
    %increment the while loop
    n = n+1;
    
end

%Graphs are Commented out for use with shooting Method
%Extract the x and y values from the final state vector
%x = z(:,1);
%y = z(:,2);

%Plot graph
%plot (x,y);
%xlabel ('x displacement, v_x(m)');
%ylabel ('y displacement, v_y(m)');


