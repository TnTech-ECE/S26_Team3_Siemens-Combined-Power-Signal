# Author: Harry Rudd
# Date Started: 4/21/26

# Add dependencies
import numpy as np
import matplotlib.pyplot as plt

# Define cable class so multiple cables can be tested
class Cable():
    def __init__(self, name, delay, ):
        # All numerical values are in base SI units
        self.name = name
        self.delay = delay # Delay found in datasheet
        self.propagationSpeed = 1/delay # Propagation speed needed to find wavelength