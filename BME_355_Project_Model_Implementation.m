%% Crontab Test 1 Hour

%% Plot

tspan = [0 100];

% Initial conditions

x0 = [1 1 1]; % Placeholder

sol = ode45(@x_dot, tspan, x0);

x = sol.y;

t = sol.x;

figure(1)

tiledlayout(3, 1);

nexttile();

plot(t, fact); hold on;

ylabel({'Change in Dynamic';'Activation Level'; 'of Muscle'},'FontSize', 10); %fact_dot

nexttile();

plot(t, x(2,:)); hold on;

ylabel({'Absolute Rotational'; 'Velocity of the Foot'},'FontSize',10) % alphaF_dot

nexttile();

plot(t, x(3,:)); hold on;

ylabel({'Absolute Rotational'; 'Acceleration of the Foot'}, 'FontSize',10) % alphaF_dot_Dot

xlabel('Time (ms)')

%% Define x_dot(t,x)

function x_dot = x_dot(t,x)

% x1 = fact

% x2 = alphaF

% x3 = alphaF_dot

fact = x(1);

alphaF = x(2);

alphaF_dot = x(3);

% Input function

% u = [u1] = [epsilon]

u1 = input_func(t);

% External States

xext1 = xext1_func(t);

xext2 = xext2_func(t);

xext3 = xext3_func(t);

xext4 = xext4_func(t);

% make x_dot a column vector with 4 values then fill it appropriately.

x_dot = [0; 0; 0];

x_dot(1) = fact_dot(fact,u1);

x_dot(2) = alphaF_dot;

x_dot(3) = alphaF_dot_dot(fact, alphaF, alphaF_dot,u1, xext1, xext2, xext3, xext4);

end

%% Functions for input and external states wrt time (placeholders)

function u1=input_func(t)

u1 = 1*t ;

end

function xext1=xext1_func(t)

xext1 = 1*t;

end

function xext2=xext2_func(t)

xext2 = 1*t;

end

function xext3=xext3_func(t)

xext3 = 1*t;

end

function xext4=xext4_func(t)

xext4 = 1*t;

end

%% State Equations

% x1_dot

function fact_dot=fact_dot(fact,u1)

% Constants

Tact = 0.01;

Tdeact = 0.04;

fact_dot = (u1-fact)*((u1/Tact)/((1-u1)/Tdeact));

end

% x2_dot = alphaF_dot

% x3_dot

function alphaF_dot_dot = alphaF_dot_dot(fact, alphaF, alphaF_dot,u1, xext1, xext2, xext3, xext4)

% Constants

J = 0.0197;

d = 3.7;

B = 0.82;

x = [fact,alphaF, alphaF_dot];

alphaF_dot_dot = 1/J * (Fm(x,xext3,xext4)*d + Tgrav(alphaF)+Tacc(xext1,xext2,alphaF)+TEla(alphaF)+B*(xext4-alphaF_dot));

end

%% Other Equations

function Fm=Fm(x,xext3, xext4)

% Constants

lT = 22.3;

lMT0 = 32.1;

d = 3.7;

W = 0.56;

av = 1.33;

fv1 = 0.18;

fv2 = 0.023;

vmax = -0.9;

Fmax = 600;

vCE = d*(xext4 - x(3));

lMT = lMT0 + d*(xext3-x(2));

lCE = lMT - lT;

lCEopt = 1; %can't figure out how to calculate this one!!!!

% ffl(xext3 - x2)

ffl_xext3_minus_x2 = exp(-((lCE-lCEopt)/(W*lCEopt))^2);

% ffv(xext4 - x3)

if (vCE < 0) % contraction

   ffv_xext4_minus_x3 = (1-(vCE/vmax))/(1+(vCE/(vmax*fv1)));

else % extension or isometric

   ffv_xext4_minus_x3 = (1+av*(vCE/fv2))/(1+(vCE/fv2));

end

Fm = x(1)*Fmax*ffl_xext3_minus_x2*ffv_xext4_minus_x3;

end

function Tgrav=Tgrav(alphaF)

% Constants

cF = 11.45;

mF = 1.0275;

g = 9.81; % I made this one up

Tgrav = -mF*cF*cos(alphaF)*g;

end

function Tacc=Tacc(xext1, xext2, alphaF)

% Constants

cF = 11.45;

mF = 1.0275;

Tacc = mF*cF*(xext1*sin(alphaF)-xext2*cos(alphaF));

end

function TEla = TEla(alphaF)

% Constants

a1 = 2.10;

a2 = -0.08;

a3 = -7.97;

a4 = 0.19;

a5 = -1.79;

TEla = exp(a1+a2*alphaF)-exp(a3+a4*alphaF)+a5;

end



