# Author: Harry Rudd
# Date Started: 4/23/26

# Add dependencies
import numpy as np
import matplotlib.pyplot as plt
import pysmithchart
from pysmithchart.constants import Z_DOMAIN, NORM_Z_DOMAIN, R_DOMAIN
from pysmithchart import utils

plt.figure(figsize=(6, 6))
ax = plt.subplot(111, projection="smith", Z0=120)

ax.plot_vswr(3, ms=0, lw=2)

ax.set_title("Impedance at VSWR = 3")
plt.show()