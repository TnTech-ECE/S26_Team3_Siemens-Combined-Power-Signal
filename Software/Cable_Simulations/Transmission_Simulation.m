clear
eqtxline = txlineEquationBased('Name', 'Belden_9116SB', 'Frequency', 5e6, 'Z0', 75, 'LineLength', 10, 'PhaseVelocity', 248827740, 'LossDB', 0.2198);
net = sparameters(eqtxline, 2.5e6, 75);
smithplot(net,2,1)
