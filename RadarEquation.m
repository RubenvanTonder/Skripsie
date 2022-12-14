% Radar Simulation

% Radar Parameters
Pt = 0.05;                  % Radiated Power (W)
RCS = 100;                  % Radar Cross Section (m^2/m^2)
G = 1;                      % Antenna Gain (W)
Ae = 1 ;                    % Reflected Power (%)
Smin = 0.001;               % Minimum Detectable Signal (W)
lamda = 0.0285;             % Wavelength (m)

% Radar Equation

Rmax = ((Pt*G*(Ae)^2*RCS)/(4*pi*(lamda)^2*Smin))^(0.25); 

