function [dz] = stateDeriv(z,t,h)

%Projectile 
%Inputs: 
% z = state vector in form [x y v_x v_y]

v_0  =   900;    % Inital Velocity of projectile (m/s)
m    =   600;    % Mass of Projectile (kg)
A_pr =   0.25;   % Frontal Area of Projectile (m^2)
C_pr =   0.38;   % Drag Coefficient of Projectile 
A_pa =   1.1;    % Frontal Area of Parachute (m^2)
C_pa =   0.9;    % Drag Coefficient of Parachute
rho  =   1.207;  % Air Density at sea level (kg/m^3)
g    =   9.81;   % Gravitational Constant

%Extracting Displacement and Velocity Values from the state vector to make
%code more readable
x   = z(1);
y   = z(2);
v_x = z(3);
v_y = z(4);

%Work out the angle of the rocket at a given point based on the velocity
%values
theta = atan2(v_y,v_x);


%Work out the drag coefficient of the projectile and the parachute

d_nopara     = (C_pr * rho * A_pr)/(2*m);
d_para       = (C_pa * rho * A_pa)/(2*m);

%Choose which drag coefficient to use knowing that the parachute opens after 15s
if t<15
d= d_nopara;
else
    d=d_para+d_nopara;
end

%Generates the state's absolute velocity for use in drag calculations
v = sqrt((v_x^2) + (v_y^2));

%Generate the differential state vector in the form [v_x v_y dv_x dv_y]
%Using the derived projectile ODES
dv_x= (-1)*d*(v^2)* cos(theta);
dv_y= -g -(d*(v^2)* sin(theta));
dz = [v_x v_y dv_x dv_y];