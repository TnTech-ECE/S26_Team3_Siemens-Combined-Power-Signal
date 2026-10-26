clear

% Define the input values that will be passed
f = 2.5e6; % Clock frequency
%f = 250e3;
%f = 0.00001;
IDC = 2; % Input DC current

% Define the physical parameters of the coaxial line
rIn = 0.111; % Inner radius of the conductor [in]
rOut = 0.403; % Outer radius of the conductor [in]
RDCIn = 1.3; % Inner conductor DC resistance [ohm/1000ft]
RDCOut = 2.0; % Outer conductor DC resistance [ohm/1000ft]
RDC = (RDCIn+RDCOut)/304.8; % Total DC resistance with conversion [ohm/m]
C = 75e-12; % C value is 75 pF/m
Z_0 = 50; % Characteristic impedance is 50 ohms
Z_l = 69.63*exp(1j*deg2rad(-44.11)); % Load impedance of the clock

% This is the table of attenuation constant variables at given frequencies
% as provided by the datasheet (frequency [MHz], attenuation [dB/100ft])
aFreqDataRaw = [30, 50, 150, 220, 450, 900, 1500, 1800, 2000, 2500, 3000, 3500, 4500, 5800, 6000];
aAttenDataRaw = [0.7, 0.9, 1.5, 1.8, 2.7, 3.8, 5.1, 5.6, 6, 6.7, 7.5, 8.2, 9.5, 11.1, 11.4];

% Convert the raw data into the corret measurements for our calculations
% (frequency [Hz], attenuation [dB/m])
aFreqData = aFreqDataRaw.*1e6;
aAttenData = aAttenDataRaw./30.48;

% The fittype for the line of best fit is k1*sqrt(x) + k2*x from the
% attenuation function
attenFittype = fittype({'sqrt(x)', 'x'});

% Prepare the attenuation data for fitting
[xAttenFit, yAttenFit] = prepareCurveData(aFreqData, aAttenData);

% Perform the fit
[attenFitResult, attenGOF] = fit(xAttenFit, yAttenFit, attenFittype);

% Attenuation data with line of best fit
figure(1);
plot(attenFitResult, aFreqData, aAttenData);
xlabel('Frequency [Hz]');
ylabel('Attenuation [dB/m]');
title('Attenuation Data with Line of Best Fit')

% Predict the attenuation at our given frequency with a prediction interval
attenPred = feval(attenFitResult, f);
attenPI = predint(attenFitResult, f, 0.95, 'observation');
attenPI_Neper = attenPI.*0.11513;

% Use the 95% prediction interval to calculate a range of possible
% attenuation values
atten = linspace(attenPI_Neper(1), attenPI_Neper(2), 250);

% Calculate the phase constant
phaseConst = 2*pi*Z_0*C*f;

% Create a linspace variable for length
len = linspace(0, 10, 250);

% Create a length and propagation constant meshgrid
[LEN, ATTEN] = meshgrid(len, atten);

% Calculate ABCD parameters
A = cosh(LEN.*(ATTEN+1j.*phaseConst));
B = Z_0.*sinh(LEN.*(ATTEN+1j.*phaseConst));
C = sinh(LEN.*(ATTEN+1j.*phaseConst))./Z_0;
D = cosh(LEN.*(ATTEN+1j.*phaseConst));

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
nLevels = 100;

figure(2);
subplot(2,2,1);
contourf(LEN, ATTEN, A_mag, nLevels, 'LineStyle', 'none')
title('|A|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cAmag = colorbar;
cAmag.Label.String = 'Voltage Ratio';

subplot(2,2,2);
contourf(LEN, ATTEN, B_mag, nLevels, 'LineStyle', 'none')
title('|B|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cBmag = colorbar;
cBmag.Label.String = 'Short Circuit Resistance [\Omega]';

subplot(2,2,3);
contourf(LEN, ATTEN, C_mag, nLevels, 'LineStyle', 'none')
title('|C|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cCmag = colorbar;
cCmag.Label.String = 'Open Circuit Conductance [S]';

subplot(2,2,4);
contourf(LEN, ATTEN, D_mag, nLevels, 'LineStyle', 'none')
title('|D|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cDmag = colorbar;
cDmag.Label.String = 'Current Ratio';

sgtitle('ABCD Parameter Magnitudes')

% Display the angle of the ABCD parameters
figure(3);
subplot(2,2,1);
contourf(LEN, ATTEN, A_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle A')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cAmag = colorbar;
cAmag.Label.String = 'Voltage Ratio Angle [\circ]';

subplot(2,2,2);
contourf(LEN, ATTEN, B_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle B')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cBmag = colorbar;
cBmag.Label.String = 'Short Circuit Resistance Angle [\circ]';

subplot(2,2,3);
contourf(LEN, ATTEN, C_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle C')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cCmag = colorbar;
cCmag.Label.String = 'Open Circuit Conductance Angle [\circ]';

subplot(2,2,4);
contourf(LEN, ATTEN, D_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle D')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cDmag = colorbar;
cDmag.Label.String = 'Current Ratio Angle [\circ]';

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
figure(4);
subplot(2,2,1);
contourf(LEN, ATTEN, s11_mag, nLevels, 'LineStyle', 'none')
title('|s_{11}|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cAmag = colorbar;
cAmag.Label.String = 'Input Reflection Coefficient';

subplot(2,2,2);
contourf(LEN, ATTEN, s12_mag, nLevels, 'LineStyle', 'none')
title('|s_{12}|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cBmag = colorbar;
cBmag.Label.String = 'Forward Transmission Coefficient';

subplot(2,2,3);
contourf(LEN, ATTEN, s21_mag, nLevels, 'LineStyle', 'none')
title('|s_{21}|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cCmag = colorbar;
cCmag.Label.String = 'Reverse Transmission Coefficient';

subplot(2,2,4);
contourf(LEN, ATTEN, s22_mag, nLevels, 'LineStyle', 'none')
title('|s_{22}|')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cDmag = colorbar;
cDmag.Label.String = 'Output Reflection Coefficient';

sgtitle('s Parameter Magnitudes')

% Display the angle of the s parameters
figure(5);
subplot(2,2,1);
contourf(LEN, ATTEN, s11_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle s_{11}')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cAmag = colorbar;
cAmag.Label.String = 'Input Reflection Coefficient [\circ]';

subplot(2,2,2);
contourf(LEN, ATTEN, s12_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle s_{12}')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cBmag = colorbar;
cBmag.Label.String = 'Forward Transmission Coefficient [\circ]';

subplot(2,2,3);
contourf(LEN, ATTEN, s21_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle s_{21}')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cCmag = colorbar;
cCmag.Label.String = 'Reverse Transmission Coefficient [\circ]';

subplot(2,2,4);
contourf(LEN, ATTEN, s22_angle_deg, nLevels, 'LineStyle', 'none')
title('\angle s_{22}')
xlabel('Cable Length [m]')
ylabel('Attenuation Constant [Np/m]')
cDmag = colorbar;
cDmag.Label.String = 'Output Reflection Coefficient [\circ]';

sgtitle('s Parameter Angles')

% Calculate the DC voltage drop and power loss and plot them as a function of cable length
VDC_loss = IDC.*RDC.*len;
PDC_loss = IDC.^2.*RDC.*len;

figure(6);
yyaxis left
plot(len, VDC_loss)
ylabel('DC Voltage Loss [V]')

yyaxis right
plot(len, PDC_loss)
ylabel('DC Power Loss [W]')

title('DC Voltage [V] and Power [W] Loss vs Cable Length [m]')
xlabel('Cable Length [m]')