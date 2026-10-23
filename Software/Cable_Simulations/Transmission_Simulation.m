clear

% Define the physical parameters of the coaxial line
r_in = 0.111; % Inner radius of the conductor
r_out = 0.403; % Outer radius of the conductor
C = 23e-12; % C value is 23 pF/m

% This is the table of attenuation constant variables at given frequencies
% as provided by the datasheet (frequency [Hz], attenuation [dB/1000ft])
a_table = [30e6, 0.7;
           50e6, 0.9;
           150e6, 1.5;
           220e6, 1.8;
           450e6, 2.7;
           900e6, 3.8;
           1500e6, 5.1;
           1800e6, 5.6;
           2000e6, 6;
           2500e6, 6.7;
           3000e6, 7.5;
           3500e6, 8.2;
           4500e6, 9.5;
           5800e6, 11.1;
           6000e6, 11.4];

% Assuming your matrix or table is stored in variable 'data'
x = a_table(:, 1);  % Extract all rows of column 1
y = a_table(:, 2);  % Extract all rows of column 2

plot(x, y);
xlabel('Frequency');
ylabel('Attenuation');