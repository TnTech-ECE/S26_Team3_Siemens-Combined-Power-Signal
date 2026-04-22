# Author: Harry Rudd
# Date Started: 4/21/26


import numpy as np
import matplotlib.pyplot as plt

# Define cable class so multiple cables can be tested
class cable():
    def __init__(self, name, delay):
        self.name = name
        self.delay = delay