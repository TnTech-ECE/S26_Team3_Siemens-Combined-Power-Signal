# Author: Harry Rudd
# Date Started: 4/21/26

# Add dependencies
import numpy as np
import matplotlib.pyplot as plt

# Define constants found in Siemens sheet
CLOCK_FREQUENCY = 2.5*np.power(10,6)
CLOCK_AMPLITUDE = 0.1
DC_VOLTAGE = 48
MAX_RIPPLE = 0.2
DC_POWER = 100
LOAD_IMPEDANCE = 4
DC_CURRENT = DC_POWER/DC_VOLTAGE

# Define cable class so multiple cables can be tested
class Cable():
    def __init__(self, name, delay, characteristicImpedance, DCR, inductance, capacitanceCC, capacitanceCS, LRRatio):
        # All numerical values are in base SI units
        self.name = name
        self.delay = delay # Delay found in datasheet [seconds per meter]
        self.propagationSpeed = 1/delay # Propagation speed needed to find wavelength [meters per second]
        self.characteristicImpedance = characteristicImpedance
        self.DCR = DCR # Direct Current Resistance (DCR) is the resistance at 0 Hz
        self.inductance = inductance # Inductance per meter
        self.capacitanceCC = capacitanceCC # Conductor to conductor capacitance per meter
        self.capacitanceCS = capacitanceCS # Conductor to shield capacitance per meter
        self.LRRatio = LRRatio # Inductance to resistance ratio
        self.waveNumber = 2*np.pi*CLOCK_FREQUENCY*delay # k value in textbook

cblArr = np.array([Cable('50021L', 5.2/np.power(10,9), 120, 36.7/np.power(10,3), 1/np.power(10,6), 46/np.power(10,9), 82/np.power(10,9), 25/np.power(10,6))])

length = np.linspace(1,10,50) # Linspace to check length from 1 m to 10 m cable length (min and max from Siemens)

def Vin(t):
    return np.cos(2*np.pi*CLOCK_FREQUENCY*t)

for i, cable in enumerate(cblArr):
    DCLoss = DC_CURRENT*length*cable.DCR
    plt.plot(length,DCLoss,label=cable.name)

plt.title('Cable Length vs Voltage Loss')
plt.xlabel('Cable Length [m]')
plt.ylabel('Voltage Loss [V]')
plt.legend()
plt.show()

