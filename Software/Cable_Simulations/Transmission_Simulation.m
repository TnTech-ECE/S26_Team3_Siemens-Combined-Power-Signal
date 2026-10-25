clear

% Define the physical parameters of the coaxial line
r_in = 0.111; % Inner radius of the conductor
r_out = 0.403; % Outer radius of the conductor
C = 23e-12; % C value is 23 pF/m

% This is the table of attenuation constant variables at given frequencies
% as provided by the datasheet (frequency [MHz], attenuation [dB/1000ft])
a_freq_data = [30, 50, 150, 220, 450, 900, 1500, 1800, 2000, 2500, 3000, 3500, 4500, 5800, 6000];
a_atten_data = [0.7, 0.9, 1.5, 1.8, 2.7, 3.8, 5.1, 5.6, 6, 6.7, 7.5, 8.2, 9.5, 11.1, 11.4];

a_fit = fittype('poly3');

plot(a_freq_data, a_atten_data);
xlabel('Frequency');
ylabel('Attenuation');