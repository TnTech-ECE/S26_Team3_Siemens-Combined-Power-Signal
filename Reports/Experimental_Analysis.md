# Experimental Analysis

## Experiment 1 – Signal Conditioning

### Purpose

The purpose of this experiment is to verify that the 2.5 MHz reference clock can successfully be conditioned by the receiver side signal conditioning circuitry.

The experiment will evaluate the following criteria:

- Adequate signal amplitude at the output of the ADA4899-1 amplifier.
- Successful conversion of the amplified analog clock into a digital signal by the ADCMP605.
- Consistent operation of the signal conditioning circuitry without clipping, unwanted oscillation, or missing transitions.

These criteria are important because the Si5345B requires a sufficiently clean input clock to generate the desired output frequencies and meet the system's jitter requirements.

### Procedure

**Equipment and project inventory:**
- Agilent 33220A waveform generator.
- GW Instek GPS-4303 DC power supply.
- Tektronix MSO2024 oscilloscope.
- Transmitter and receiver PCBs.
- Appropriate SMA/BNC cables, adapters, and test leads.

**Preparation and testing:**

1. Inspect the transmitter and receiver PCBs for assembly issues, incorrect component placement, and potential shorts.
2. Configure the GW Instek GPS-4303 to provide the required 48 V supply. If using two channels in series, verify that the supply supports the intended series configuration and that the outputs are appropriately isolated. Set a conservative current limit before powering the circuit.
3. Configure the Agilent 33220A to generate a 2.5 MHz sine wave with an initial amplitude of 50 mV peak and 0 V offset. Verify the generator's load setting to ensure the actual signal amplitude is correct.
4. Connect the waveform generator to the transmitter PCB's reference clock input.
5. Connect the transmitter and receiver PCBs through the intended 48 V power line connection.
6. Power the system and measure the reference signal at the receiver side Bias-T output using the Tektronix MSO2024.
7. Record the received signal's amplitude, frequency, and waveform.
8. Measure the output of the ADA4899-1 amplifier. Verify that the signal is sufficiently amplified and remains within the comparator's permitted input range.
9. Measure the ADCMP605 output to verify that the analog reference has been converted into a consistent digital clock signal.
10. Repeat the measurements after power cycling the system to evaluate startup consistency.

**Environmental conditions:** Conduct testing under stable laboratory conditions. Maintain consistent wiring, cable lengths, supply voltage, and instrument settings between trials.

### Data Collection

Record the following information for each measurement:

| Measurement | Units | Measurement method |
|---|---|---|
| Generator frequency | MHz | Waveform generator setting and oscilloscope |
| Generator amplitude | mV peak / mVpp | Oscilloscope |
| Received clock amplitude | mV peak / mVpp | Oscilloscope |
| Received clock frequency | MHz | Oscilloscope |
| Amplifier output amplitude | V peak / Vpp | Oscilloscope |
| Comparator output voltage levels | V | Oscilloscope |
| Comparator output frequency | MHz | Oscilloscope |
| Supply voltage | V | DC power supply / multimeter |
| Supply current | A | DC power supply |

Save oscilloscope screenshots for the received reference, amplifier output, and comparator output. Record numerical measurements in a spreadsheet, with one row per trial.

### Trials

Perform at least three independent trials, including a complete power cycle between trials. If multiple transmitter or receiver prototypes are available, repeat the experiment using different PCB combinations.

Three trials provide an initial assessment of repeatability. Additional testing should be performed if significant variation occurs between trials.

### Potential Biases and Error Sources

- **Generator amplitude inaccuracies:** The waveform generator's configured load impedance may cause the actual output amplitude to differ from the displayed value. Verify the signal with the oscilloscope.
- **Cable losses and impedance mismatches:** Use consistent cable lengths and appropriate terminations.
- **Oscilloscope measurement limitations:** The MSO2024 has limited bandwidth and sampling performance for very fast edges. Use it primarily to verify signal presence, frequency, and approximate amplitude.
- **Power supply variation:** Monitor the 48 V supply and current throughout testing.
- **Probe loading:** Use appropriate probe or coaxial connections to minimize loading effects on the circuit.

---

## Experiment 2 – Si5345B Clock Generation and Output Verification

### Purpose

The purpose of this experiment is to verify that the Skyworks Si5345B successfully generates the required clock outputs from the recovered 2.5 MHz reference signal.

The primary criteria are:

- Successful configuration and startup of the Si5345B.
- Generation of a 25 MHz output clock.
- Generation of the required 2.5 MHz system clock output.
- Verification that the output signals have the expected frequency, voltage levels, and waveform characteristics.
- Consistent clock generation following repeated power cycles.

The outputs are configured for 3.3 V LVCMOS operation to simplify testing and integration. Successful operation is necessary to demonstrate that the clock generation subsystem can provide the required timing signal outputs for the ComCaP system.

### Procedure

**Equipment and project inventory:**
- Agilent 33220A waveform generator.
- GW Instek GPS-4303 DC power supply.
- Tektronix MSO2024 oscilloscope.
- Transmitter and receiver PCBs.
- STM32 microcontroller configuration firmware.
- Appropriate SMA/BNC cables, adapters, and test leads.

**Preparation and testing:**

1. Verify that the Si5345B is correctly installed and that its power supplies and required configuration pins are connected.
2. Verify that the STM32 microcontroller is programmed to load the Si5345B register configuration during startup.
3. Confirm that the Si5345B configuration specifies the intended 2.5 MHz and 25 MHz output frequencies and 3.3 V LVCMOS output signaling.
4. Generate and transmit the 2.5 MHz reference signal using the procedure described in Experiment 1.
5. Connect the 25 MHz output to the Tektronix MSO2024 using an SMA to BNC cable assembly. Configure the oscilloscope for the appropriate input, DC coupling, and an appropriate vertical scale.
6. Measure the output frequency, voltage swing, duty cycle, and waveform stability.
7. Repeat the measurement for the 2.5 MHz output.
8. Power cycle the subsystem and verify that both outputs return successfully without requiring manual reconfiguration.

**Environmental conditions:** Maintain consistent supply voltages, wiring, and instrument settings. Allow the system to stabilize after startup before recording measurements.

### Data Collection

| Measurement | Units | Measurement method |
|---|---|---|
| Reference input frequency | MHz | Oscilloscope |
| 25 MHz output frequency | MHz | Oscilloscope |
| 2.5 MHz output frequency | MHz | Oscilloscope |
| Output high voltage | V | Oscilloscope |
| Output low voltage | V | Oscilloscope |
| Peak-to-peak output voltage | Vpp | Oscilloscope |
| Duty cycle | % | Oscilloscope |
| Output period | ns / µs | Oscilloscope |
| Startup success | Pass/Fail | Observation |

Save oscilloscope screenshots of both output clocks. Record the measured values and whether the subsystem successfully initializes during each trial.

### Trials

Perform at least three independent startup trials. Each trial should include powering down the subsystem, restarting it, and verifying both output clocks.

If multiple receiver PCB prototypes are available, test each prototype to evaluate consistency across hardware assemblies.

### Potential Biases and Error Sources

- **Oscilloscope bandwidth:** The MSO2024's 200 MHz bandwidth limits its ability to accurately characterize fast clock edges.
- **Configuration errors:** Incorrect register settings may result in incorrect output frequencies or voltage levels. Verify the programmed configuration before testing.
- **Power supply variation:** Changes in supply voltage may affect output performance.
- **Measurement uncertainty:** Oscilloscope frequency and voltage measurements should be treated as verification of basic operation, not proof of jitter performance.

---

## Experiment 3 – Clock Jitter and Relative Timing Characterization

### Purpose

The purpose of this experiment is to characterize the timing stability of the Si5345B generated clock outputs and evaluate whether the clock generation subsystem meets the project's jitter requirements.

The primary performance criteria are:

- Cycle-to-cycle jitter of the generated 25 MHz clock.
- Timing variation of the generated clock relative to the incoming 2.5 MHz reference.
- Relative timing variation between two identical ComCaP systems, if two prototypes are available.
- Comparison of measured timing variation against the project's 20–30 ps relative jitter target.

The customer's primary concern is reliable synchronization between ComCaP systems. Consequently, relative timing variation is particularly important.

### Procedure

**Equipment and project inventory:**
- Tektronix MSO2024 oscilloscope for preliminary jitter measurements.
- Agilent 33220A waveform generator.
- Transmitter and receiver PCBs.
- STM32 microcontroller configuration firmware.
- Appropriate SMA/BNC cables, adapters, and test leads.
- A higher performance oscilloscope if available.

**Preparation and testing:**

1. Verify that the clock generation subsystem successfully passes Experiments 1 and 2.
2. Confirm that the Si5345B is locked to the incoming reference and that the 25 MHz output is stable.
3. Connect the 25 MHz output to the oscilloscope. Use the same output connection and loading conditions throughout the experiment.
4. Configure the oscilloscope to capture rising edges and use a consistent trigger threshold, preferably near 50% of the measured output voltage swing.
5. Configure the oscilloscope's jitter or timing measurement functions, if available.
6. Capture a sufficiently large sample of consecutive clock edges. The target should be at least 10,000 measured edges per acquisition when supported by the instrument.
7. Determine the period of each consecutive clock cycle and calculate cycle-to-cycle jitter using:

   \[
   J_{CC,n}=T_{n+1}-T_n
   \]

   Record the absolute magnitude where reporting maximum cycle-to-cycle deviation.
8. Repeat the acquisition to evaluate measurement repeatability.
9. For relative timing measurements within one system, simultaneously observe the 2.5 MHz reference and 25 MHz output using two oscilloscope channels. Compare the reference edge with a consistently selected corresponding 25 MHz edge. Since the output frequency is ten times the reference frequency, the edge relationship must be defined consistently.
10. If two ComCaP systems are available, distribute a common reference to both systems and measure their 25 MHz outputs simultaneously. Compare corresponding rising edges to determine relative timing variation.
11. Calculate the standard deviation, maximum, minimum, and range of the measured timing differences.
12. Compare the results with the project's specified jitter requirements.

**Environmental conditions:** Perform measurements in a stable laboratory environment. Maintain consistent cable lengths, oscilloscope settings, triggering conditions, and power supply conditions. Minimize electrical interference and avoid changing the measurement setup between acquisitions.

### Data Collection

| Measurement | Units | Measurement method |
|---|---|---|
| Clock frequency | MHz | Oscilloscope |
| Clock period | ns | Oscilloscope |
| Individual cycle periods | ns | Edge-to-edge timing measurements |
| Cycle-to-cycle jitter | ps | Difference between consecutive periods |
| Relative timing difference | ps | Simultaneous channel timing measurement |
| RMS/standard deviation of timing variation | ps | Statistical analysis |
| Maximum timing deviation | ps | Statistical analysis |
| Minimum timing deviation | ps | Statistical analysis |
| Peak-to-peak timing variation | ps | Maximum minus minimum |
| Number of measured edges | Count | Acquisition settings |

Store the captured waveform data and measurement results in a spreadsheet. Include oscilloscope screenshots, acquisition settings, and instrument identification with each dataset.

### Trials

Perform at least three independent acquisitions for each jitter measurement condition. Each acquisition should contain at least 10,000 measured edges when supported by the instrument.

If multiple ComCaP prototypes are available, perform relative timing measurements between different prototype combinations. This will help determine whether timing performance is consistent across systems.

Three independent acquisitions are useful for assessing repeatability, but the number of edges and the statistical distribution should also be considered when evaluating jitter.

### Potential Biases and Error Sources

- **Oscilloscope timebase jitter:** The instrument's internal timebase may contribute timing uncertainty. Its jitter must be substantially lower than the expected measurement to avoid dominating the result.
- **Sampling rate:** Insufficient sampling resolution can affect edge interpolation and timing measurements. Higher sampling rates generally improve the available timing information, but do not guarantee accurate picosecond measurements.
- **Analog bandwidth:** Insufficient bandwidth can distort clock edges and affect threshold crossing measurements.
- **Trigger noise:** Trigger uncertainty can introduce additional timing variation. Use consistent trigger settings and thresholds.
- **Channel-to-channel skew:** Relative measurements using two channels may be affected by differences in channel delay and cable length.
- **Signal noise:** Electrical noise on the clock edges can shift the measured threshold crossing time.
- **Measurement sample size:** Too few measured edges may produce misleading statistical results. Use at least 10,000 edges per acquisition where possible.
- **Instrument limitations:** The existing MSO2024 is appropriate for preliminary clock verification but should not be considered sufficient evidence of sub picosecond jitter or a 20–30 ps relative jitter result without a documented measurement floor.

A higher performance oscilloscope with approximately 1–2 GHz analog bandwidth, 4 GS/s or greater sampling capability, and documented low timing jitter would be preferable for this experiment.

---

The Tektronix MSO2024 can support preliminary verification of clock operation and waveform characteristics. However, its 200 MHz bandwidth and 1 GS/s maximum sampling rate do not establish that it can reliably verify the project's picosecond level jitter requirements. A higher performance measurement instrument should therefore be used for final jitter acceptance testing.

---

## Experiment 4 - Clock and Communication Transmission Characteristics

### Purpose

The purpose of this experiment is to verify the transmission characteristcs of both of the cables at all the required lengths for both the $2.5\ MHz$ clock and the $200\ kHz$ communications signals. The communications signal needs to be able to be read by the recieving board, and the clock signal needs to transmit at least half of its peak voltage.

### Procedure

**Equipment and project inventory:**
- Reciever PCB
- Keysight E5063A ENA Vector Network Analyzer (VNA)
- Belden 7810A coaxial cables at appropriate lengths
- Belden 50021L twisted pair cables at appropriate lengths
- Appropriate SMA/BNC cables, adapters, and test leads

**Preparation and testing:**
1. Turn on the VNA and leave it for 30 minutes to warm up
2. Connect the reciever board clock output to port 2 of the VNA
3. Connect the cable from the input of the reciever board to port 1 of the VNA
4. Sweep $2.5\ MHz\ \pm 5\%$  and record the S-parameters
5. Repeat steps 2-4 with all available cables for the clock
6. Change the connection from the clock to the communications output
7. Sweep $200\ kHz\ \pm 5\%$ and record the S-parameters
8. Repeat step 7 for all available cables


### Data Collection

| Measurement | Units | Measurement method |
|---|---|---|
| Clock $S_{11}$ | dB | VNA |
| Clock $S_{12}$ | dB | VNA |
| Clock $S_{21}$ | dB | VNA |
| Clock $S_{22}$ | dB | VNA |
| Communications $S_{11}$ | dB | VNA |
| Communications $S_{12}$ | dB | VNA |
| Communications $S_{21}$ | dB | VNA |
| Communications $S_{22}$ | dB | VNA |

Load the S-parameter data into MATLAB for analysis and display.

### Trials

Perform this test before testing anything else regarding the cables in case they are damaged in subsequent DC voltage and current testing.

### Potential Biases and Error Sources

- **Output Measurement Cable** Since the output is being measured at the end of the bias tee, the cables that are being used may introduce noise and impedance mismatching. This will cause the S-parameters to record greater losses than will be actually experienced in the circuit.
- **Independent Testing** Since the clock and communications frequencies are tested separately, there may be some interferences in normal operation that are not being tested.

## Statement of Contributions

Each team member must contribute meaningfully to the experimental analysis and document their contributions clearly in this section. Contributions should be recorded individually, and one team member may not document contributions on behalf of another. Each team member must clearly outline their involvement in experiment design, execution, data analysis, and reporting. By submitting this report, the team collectively certifies the accuracy and completeness of each member's stated contributions.
