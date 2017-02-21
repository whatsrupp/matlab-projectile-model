
function []= shootingMethod (x_de, e_d, v_0)

%Dummy variables for testing purposes
%x_de = 10000; %Required delivery distance (m)
%e_d    = 100;   %DESIRED Delivery Error, ie to within 100m 
%v_0  = 900;   %Launch velocity (m/s) 
%theta_final= 1;
%Initialise the Guess angles, very inaccurate guess to cover all
%possibilities

theta_1 = 50*(pi/180); %Guess angle for undershoot
theta_2 = 15*(pi/180); %Guess angle overshoot

z_1 =odeSolver(theta_1, v_0);
z_2 =odeSolver(theta_2, v_0);

%if z_2(end,1)<x_de
%    msgbox('Package will not reach destination')
%end

x_1= z_1(end,1);
x_2= z_2(end,1);

%initialise z_3 so that code doesn't error out if the inital guess meets
%the projectile requirements
z_3 = z_2;
theta_3 = theta_2;

%Calculate the initial error 
e_c= x_de-x_2;

% While condition compares the current error to the desired error
while abs(e_c) > e_d
    
    e_c = x_de - x_2;
    
    theta_3 = theta_2 + ((theta_2 - theta_1)/(x_2- x_1));
    
    z_3=odeSolver (theta_3,v_0);
    x_3= z_3(end,1);
    
    
    x_1=x_2;
    x_2=x_3;
    theta_1=theta_2;
    theta_2=theta_3;
    
end

x= z_3(:,1);
y= z_3(:,2);
theta_final= theta_3 * (180/pi);

plot(x,y);
title(theta_final);

    
    

