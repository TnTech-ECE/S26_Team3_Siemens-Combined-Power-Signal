clear

% Define the input values that will be passed
f = 2.5e6; % Clock frequency
%f = 250e3;
%f = 0.00001;
IDC = 2; % Input DC current

% Define the physical parameters of the twisted pair line
RDC = 36.7/1000; % Total DC resistance with conversion [ohm/m]
Ccc = 46e-12; % Conductor to conductor capicatance [pF/m]
Ccs = 82e-12; % Conductor to shield capicatance [pF/m]
Cap = Ccc + Ccs; % C value is Ccc + Ccs in current config
L = 1e-6; % Inductance value [uH/m]
LRRatio = 25e-6; % L/R ratio at high frequencies [uH/ohm]
R = L/LRRatio; % Nominal resistance calculated using ratio
Z_0 = 120; % Characteristic impedance is 120 ohms
Z_l = 69.63*exp(1j*deg2rad(-44.11)); % Load impedance of the clock
G = R/((Z_0)^2); % Use R and Z_0 relationship to find G

% Calculate the propagation constant from RLGC values
propConst = (R+2*pi*f*L*1j)/Z_0;

% Create a linspace variable for length
len = linspace(0.01, 10, 1000);

% Calculate ABCD parameters as a function of cable length
A = cosh(len.*propConst);
B = Z_0.*sinh(len.*propConst);
C = sinh(len.*propConst)./Z_0;
D = cosh(len.*propConst);

% Separate out the magnitude and angle elements to display
A_mag = abs(A);
A_angle = angle(A);
A_angle_deg = rad2deg(A_angle);

B_mag = abs(B);
B_angle = angle(B);
B_angle_deg = rad2deg(B_angle);

C_mag = abs(C);
C_angle = angle(C);
C_angle_deg = rad2deg(C_angle);

D_mag = abs(D);
D_angle = angle(D);
D_angle_deg = rad2deg(D_angle);

% Display the magnitude of the ABCD parameters
figure(1);
subplot(2,2,1);
plot(len, A_mag)
title('|A|')
xlabel('Cable Length [m]')
ylabel('Voltage Ratio')


subplot(2,2,2);
plot(len, B_mag)
title('|B|')
xlabel('Cable Length [m]')
ylabel('Short Circuit Resistance [\Omega]')

subplot(2,2,3);
plot(len, C_mag)
title('|C|')
xlabel('Cable Length [m]')
ylabel('Open Circuit Conductance [S]')

subplot(2,2,4);
plot(len, D_mag)
title('|D|')
xlabel('Cable Length [m]')
ylabel('Current Ratio')

sgtitle('ABCD Parameter Magnitudes')


% Display the angle of the ABCD parameters
figure(2);
subplot(2,2,1);
plot(len, A_angle_deg)
title('\angle A')
xlabel('Cable Length [m]')
ylabel('Voltage Ratio Angle [\circ]')


subplot(2,2,2);
plot(len, B_angle_deg)
title('\angle B')
xlabel('Cable Length [m]')
ylabel('Short Circuit Resistance Angle [\circ]')

subplot(2,2,3);
plot(len, C_angle_deg)
title('\angle C')
xlabel('Cable Length [m]')
ylabel('Open Circuit Conductance Angle [\circ]')

subplot(2,2,4);
plot(len, D_angle_deg)
title('\angle D')
xlabel('Cable Length [m]')
ylabel('Current Ratio Angle [\circ]')

sgtitle('ABCD Parameter Angles')

% Calculate S parameters using ABCD parameters and arbitrary load
s11 = (B-Z_l.*(D-A+Z_l.*C))./(B+Z_l.*(D+A+Z_l.*C));
s12 = (2.*Z_l.*(A.*D-B.*C))./(B+Z_l.*(D+A+Z_l.*C));
s21 = 2.*Z_l./(B+Z_l.*(D+A+Z_l.*C));
s22 = (B-Z_l.*(A-D+Z_l.*C))./(B+Z_l.*(D+A+Z_l.*C));

% Separate out the magnitude and angle elements to display
s11_mag = abs(s11);
s11_angle = angle(s11);
s11_angle_deg = wrapTo360(rad2deg(s11_angle));

s12_mag = abs(s12);
s12_angle = angle(s12);
s12_angle_deg = wrapTo180(rad2deg(s12_angle));

s21_mag = abs(s21);
s21_angle = angle(s21);
s21_angle_deg = wrapTo180(rad2deg(s21_angle));

s22_mag = abs(s22);
s22_angle = angle(s22);
s22_angle_deg = wrapTo360(rad2deg(s22_angle));

% Display the magnitude of the s parameters
figure(3);
subplot(2,2,1);
plot(len, s11_mag)
title('|s_{11}|')
xlabel('Cable Length [m]')
ylabel('Input Reflection Coefficient')

subplot(2,2,2);
plot(len, s12_mag)
title('|s_{12}|')
xlabel('Cable Length [m]')
ylabel('Forward Transmission Coefficient')

subplot(2,2,3);
plot(len, s21_mag)
title('|s_{21}|')
xlabel('Cable Length [m]')
ylabel('Reverse Transmission Coefficient')

subplot(2,2,4);
plot(len, s22_mag)
title('|s_{22}|')
xlabel('Cable Length [m]')
ylabel('Output Reflection Coefficient')

sgtitle('s Parameter Magnitudes')

% Display the angle of the s parameters
figure(4);
subplot(2,2,1);
plot(len, s11_angle_deg)
title('\angle s_{11}')
xlabel('Cable Length [m]')
ylabel('Input Reflection Coefficient [\circ]')

subplot(2,2,2);
plot(len, s12_angle_deg)
title('\angle s_{12}')
xlabel('Cable Length [m]')
ylabel('Forward Transmission Coefficient [\circ]')

subplot(2,2,3);
plot(len, s21_angle_deg)
title('\angle s_{21}')
xlabel('Cable Length [m]')
ylabel('Reverse Transmission Coefficient [\circ]')

subplot(2,2,4);
plot(len, s22_angle_deg)
title('\angle s_{22}')
xlabel('Cable Length [m]')
ylabel('Output Reflection Coefficient [\circ]')

sgtitle('s Parameter Angles')

% Calculate the DC voltage drop and power loss and plot them as a function of cable length
VDC_loss = IDC.*RDC.*len;
PDC_loss = IDC.^2.*RDC.*len;

figure(5);
yyaxis left
plot(len, VDC_loss)
ylabel('DC Voltage Loss [V]')

yyaxis right
plot(len, PDC_loss)
ylabel('DC Power Loss [W]')

title('DC Voltage [V] and Power [W] Loss vs Cable Length [m]')
xlabel('Cable Length [m]')
