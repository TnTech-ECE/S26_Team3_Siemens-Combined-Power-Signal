# Author: Harry Rudd
# Date Started: 4/21/26

# Add dependencies
import numpy as np
import matplotlib.pyplot as plt

# Define constants found in Siemens sheet
CLOCK_FREQUENCY = 2.5 * np.power(10,6)
DC_VOLTAGE = 48
MAX_RIPPLE = 0.2
DC_POWER = 100

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
        self.capacitanceCC - capacitanceCC # Conductor to conductor capacitance per meter
        self.capacitanceCS - capacitanceCS # Conductor to shield capacitance per meter
        self.LRRatio = LRRatio # Inductance to resistance ratio

