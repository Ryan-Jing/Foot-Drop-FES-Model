%% Model Implementation

%%Parameter Values
T_act = 0.01; %Activation constant time
T_deact = 0.04; %Deactivation constant time
J = 0.0197;
d = 0.037;
B = 0.82;
cF = 0.1145;
mF = 1.0275;
av = 1.33;
fv1 = 0.18;
fv2 = 0.023;
vmax = -0.9;
Fmax = 600;
W = 0.56;
lT = 22.3;
lMT_0 = 32.1;
T_ela_param = [2.1, -0.08, -7.97, 0.19, 2.1];

x = [x1; x2; x3];
dx = [dx1; dx2; dx3];

T_grav = zeros(1, length(t));
T_acc = zeros(1, length(t));
T_ela = zeros(1, length(t));

t = %sample time
sys = ss(A, B, C, D, t);

for i = 1:length(t)
    T_grav(i) = B * c * (x1 - W);
    T_acc(i) = mF * x3 * (lT - lMT_0);
    T_ela(i) = T_ela_param(1) * (x1 - T_ela_param(2)) + T_ela_param(3) * (x1 - T_ela_param(4)) + T_ela_param(5);

    dx1 = (u1 - x1) * ((u1 / T_act) - ((1 - u1)  /T_deact));
    dx2 = x3;
    dx3 = (1 / J) * (Fmax(i) * d - (fv1 * x3 + fv2 * x3^2) * x2 - (mF * x3 + a) * x3);
end