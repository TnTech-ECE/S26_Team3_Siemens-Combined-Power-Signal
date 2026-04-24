# Detailed Design - Clock Generation & Jitter Measurement

## Function of the Subsystem

The Clock Generation and Jitter Measurement subsystem is responsible for conditioning the reference clock, a 2.5 MHz sinusoidal input to the transceiver Bias-T circuit which is sent along the 48 V power cable subsystem to the receiver Bias-T circuit before being passed to this subsystem. The signal must be conditioned into a digital clock signal that can be utilized in synchronizing gamma ray detection units throughout the PET scanner assembly. Because the units must be synchronized well to produce accurate measurements, this subsystem shall also utilize the Skyworks Si5345B jitter cleaner/clock synthesizer[1] to both clean the clock signal and produce a 25 MHz clock signal to be used in system level validation via jitter measurements. The Si5345B Integrated Circuit (IC) uses an internal Phase-Locked Loop (PLL) control system that compares the phase of any input clocks to the phase of an adjustable feedback clock signal generated via an external crystal oscillator. The IC then uses a loop filter to eliminate high frequency jitter before controlling a Voltage Controlled oscillator (VCO) that produces the desired output clock. A feedback divider is used to adjust the frequency of the clock signal while maintaining phase alignment [2]. While IC generates the 2.5 MHz clock signal for use within PET scanner units, the scaled 25 MHz clock is produced with the goal of performing two types of jitter measurements: Cycle-to-cycle measurements and relative jitter measurements across the 25 MHz clock signal and the originally inserted 2.5 MHz clock on the transceiver side. Cycle to cycle jitter is defined as the variation in cycle time of a signal between adjacent cycles over a random sample of adjacent cycle pairs, meaning the measurement is relative to any independent signal [3]. Meanwhile the relative jitter between the 2.5 MHz and 25 MHz clocks characterizes how consistently the output clock maintains its expected phase relationship to the input over time (i.e. for every 10 of the 2.5 MHz clock cycles, 1 of the 25 MHz cycles aligns). The Clock Generation and Jitter Measurement subsystem allows determination for the overall success of the ComCaP system to carry the reference clock over the 48 V power cable.


## Specifications and Constraints

### Customer Specifications [4]:

The Clock Generation and Jitter Measurement subsystem shall utilize the Skyworks Si5345B jitter cleaner as specified by Siemens Healthineers due to the ongoing utilization of the IC by the company. Additionally, jitter measurement targets have been specified for the ComCaP system to achieve a sub 1 ps cycle to cycle jitter for the 25 MHz output clock. The measurement for relative jitter measurements will initially be contained within the ComCap system (i.e. one set of transceiver, cable, and receiver) between the introduced reference clock on the transceiver and the 25 MHZ output clock from this subsystem. Of greater interest to the customer are relative measurements between two separate but identical systems, which will require construction of at least one copy of the ComCap system. If this type of measurement is available, it shall replace the other. In either case, the goal is to obtain a 20-30 ps jitter obtained from the histogram of data generated during testing.

- Shall use the Skyworks Si5345B jitter cleaner/clock synthesizer.

- Shall produce a 25 MHz output clock signal with sub 1 ps cycle to cycle jitter.

- Shall produce a 25 MHz reference clock with 20-30ps jitter measurement relative to either the initial reference clock or another clock generated via a copy of the ComCaP system. 

### Component Constraints:

The subsystem shall ensure clock signal integrity by conditioning the reference clock signal provided by the Bias-T subsystem prior to reaching the Si5345B IC. The input to the IC shall meet the over 300 V/μs slew rate requirement provided by the manufacturer [5] in order to minimize jitter and be recognizable for use with LVDS signal formatting to minimize noise associated with single ended formats [6]. Sizing constraints are also considered for the ICs involved in the formatting of the subsystem onto a Printed Circuit Board (PCB). Additionally, the configuration of the Si5345B IC via its onboard Non-Volatile Memory (NVM) is limited to two total alloted writes to program the chip into a set configuration determined by the volatile memory registers the chip uses to operate [5]. 

- Shall convert the clock signal introduced to the system into a usable LVDS formatted digital clock signal with an over 300 V/μs slew rate as determined by the figure below, provided by the IC manufacturer Skyworks.

    <img width="669" height="484" alt="Si5345B slew rate requirements" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SlewRate.png" />
    [5]

    Slew rate shall be determined via the following formula:

    $SR = \frac{\Delta V}{\Delta t}$

- Shall take into account sizing constraints of hardware used in construction of the PCB housing the subsystem.

    |    Component     |       Package Type      | Pin Count |    Body Size (mm)     |               Notes                            |
    |------------------|-------------------------|-----------|-----------------------|----------------------------------------------- |
    | ADA4899-1 [7]    | SOIC-8 / MSOP-8         | 8         | SOIC: 5 × 4 × ~1.5    | Available in multiple packages (MSOP smaller)  |
    | ADCMP605 [8]     | LFCSP (QFN-style)       | 16        | 3 × 3 × ~0.75         | High-speed layout critical; exposed pad        |
    | Si5345B [1]      | QFN (No-lead)           | 64        | 9 × 9 × ~0.85         | Exposed pad; requires good thermal grounding   |
    | STM32G030K8T6 [9]| LQFP                    | 32        | 7 × 7 × ~1.4          | Standard leaded package; easier to hand solder |


- Shall use alternative methods to write configuration settings onto the Si5345B volatile memory during development to avoid using the finite amount of NVM aboard the IC.

### Standards

JEDEC Standard 65B [3]: This standard specifies that sample sizes pertaining to cycle to cycle jitter measurements shall be greater than or equal to 1,000. 

IEC 60601 [10]: The considerations for this subsystem pertaining to this set of medical equipment standards involve ensuring electrical isolation at the Bias-T interface, limiting leakage currents, maintaining safe operation under single fault conditions, and ensuring electromagnetic compatibility so that the clock generation does not interfere with or degrade the performance of other medical system components. However, Siemens Healthineers has maintained that the ComCaP team does not need to design the system in strict compliance with these standards as the system merely serves as a proof of concept for the company to expand on and the team has no access to the standards other than brief overviews. These standards will still be considered in the construction of the PCB the Clock Generation and Jitter Measurement subsystem resides on.

## Overview of Proposed Solution
<finish>
As mentioned in the Specifications and Constraints section of this document, the reference clock signal entering the subsystem will require alteration before insertion into the Si5345B IC. The IC expects the input signal to meet the over 300 V/μs slew rate requirement, but the maximum slew rate for the 2.5 MHz 0.1 V sine wave clock initially is found via the following equation:

SR<sub>max</sub> = 2πfV<sub>p</sub> = 2π(2.5 x 10<sup>6</sup>)(0.1) $\approx$ 1.57 V/μs

The Si5345B chip shall ultimately utilize programmed onboard Non-Volatile Memory (NVM) that determines functionality of the chip and controls clock generation. However, a microcontroller shall be used during development to load registers for this chip manually via I2C due to a constraint of the chip allowing two total alloted NVM writes by the user [5]. A reset input and two additional outputs of the Si5345B, Interrupt and LoLb, shall be included during development for monitoring purposes. Interrupt is asserted when a change in the device is detected and LOLb (Loss of Lock) is asserted when phase locking is achieved.

The cycle to cycle jitter measurements for the subsystem shall utilize the following methodology []:

1) Turn on the histogram feature for the oscilloscope, if available.

2) Turn on the C2C (cycle to cycle) feature for the oscilloscope, if available. If not, configure the scope to capture two consecutive clock cycles on the screen; subtract the period of the second clock from the period of the first clock and record the absolute value of the difference.

3) Repeat the above step at least 1,000 times.

4) If the oscilloscope has the histogram feature, record the standard deviation and the peak value. If the feature is not available, compute the standard deviation and the peak value from the 1000+ data sets. The peak value is the biggest difference between any two consecutive clock cycles in the data set.

## Interface with Other Subsystems

The Clock Generation and Jitter Measurement subsystem interfaces with two other subsystems: IC Power Distribution and Bias-T.

### IC Power Distribution Interfacing

The IC Power Distribution subsystem interfaces with the Clock Generation and Jitter Measurement subsystem via multiple power signals at 1.8 V, 3.3 V, and 5 V levels. These are intended to both enable the operation of relevant ICs and to bias inputs for both the OpAmp and comparator.

#### 1.8 V:
- Si5345B: VDD1-3

#### 3.3 V:
- ADCMP605: VCCO, LE/HYS (sets hysteresis level)
- Si5345B: VDDO0, VDDO3, VDDA, I<sup>2</sup>C (held high for selection of format)
- STM32G030: VDD/VDDA, RST (deactivates device reset)

#### 5 V:
- ADA4899-1: +VS, Input biasing
- ADCMP605: VCCI/VCCO, Input biasing
- Si5345B: VDD_1-3

### Bias-T Interfacing

The Bias-T subsystem interfaces with the Clock Generation and Jitter Measurement subsystem by sending the extracted AC sinusoidal reference clock signal for use in the Si5345B after signal conditioning. The expectation for this project is that there will be considerable noise introduced to this signal that justifies the use of the IC. There are no other interconnected signals or operations.

## Buildable Schematic 

### Signal Conditioning Circuit

The below circuit is designed to perform the signal conditioning required to introduce the reference clock signal into the Si5345B. First, the signal is biased to 2.5 V to ensure proper operation of the ADA4899-1 amplifier operating via a single 5 V source. The resistors Rf and Rg are gain control resistors and their values may change as needed during development. Once the signal has been amplified, it is introduced into the ADCMP560 comparator whose threshold is biased to the same 2.5 V. The Rh resistor above the comparator is used to control its hysteresis levels and is subject to adjustment as well. Finally, the comparator emits the LVDS formatted, differential, digital clock signal into the Si5345B input. 

<img width="1045" height="820" alt="Signal Conditioning Circuit Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigCon(update2).png" />

### Si5345B Connections



<img width="1045" height="820" alt="Si5345B Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/Si5345B_config_2_4-23-26.png" />

<img width="1045" height="820" alt="Micro Control Unit Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/MCU(update2).png" />

## Printed Circuit Board Layout



<!-- ## Flowchart while a flowchart for the MCU blasting register info to the Si5345B might be available upon construction of the circuit, it is too early to determine all required functionality needed to produce the flowchart -->



## BOM

<!--Provide a comprehensive list of all necessary components along with their prices and the total cost of the subsystem. This information should be presented in a tabular format, complete with the manufacturer, part number, distributor, distributor part number, quantity, price, and purchasing website URL. If the component is included in your schematic diagram, ensure inclusion of the component name on the BOM (i.e R1, C45, U4).-->

## Analysis

<img width="1900" height="880" alt="Simulation of signal conditioning from start to amplification" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigConSim.png" />

<img width="1900" height="880" alt="Simulation of signal conditioning from amplification to comparator" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigConSim(amptocomp).png" />

<img width="1900" height="880" alt="Simulation of signal conditioning from start to finish" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigConSim(intoout).png" />


## References

[1] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].

[2] I. Collins, “Phase-Locked Loop (PLL) Fundamentals,” Analog Dialogue, vol. 52, no. 3, Analog Devices, 2018. https://www.analog.com/media/en/analog-dialogue/volume-52/number-3/phase-locked-loop-pll-fundamentals.pdf

[3] SiTime Corporation, “Clock Jitter Definitions and Measurement Methods,” Application Note AN10007, Rev. 1.2, Jan. 2014. https://www.sitime.com/sites/default/files/hiddenresources/AN10007-Jitter-and-measurement-methods_SIT.pdf

[4] J. Kolb, “Combined power and signal delivery: A 48-v clock and communication link,” Siemens Healthineers, Dec. 01, 2025.

[5] Skyworks, "Any-frequency, Any-output Jitter-Attenuators/Clock Multipliers Si5345, Si5344, Si5342 Family Reference Manual," Si5345, Si5344, Si5342 Rev. D Family Reference Manual, July 2016 Revised [September 2018] https://www.skyworksinc.com/-/media/Skyworks/SL/documents/public/reference-manuals/Si5345-44-42-D-RM.pdf

[6] "LVDS: Interface technology of choice," EEtimes, https://www.eetimes.com/lvds-interface-technology-of-choice/ (accessed Apr. 11, 2026).

[7] Analog Devices, "Unity-Gain Stable, Ultralow Distortion, 1 nV/√Hz Voltage Noise, High Speed Op Amp," ADA4899-1 Data Sheet, Oct. 2005 Revised [May 2016].

[8] Analog Devices, "Rail-to-Rail, Very Fast, 2.5 V to 5.5 V,  Single-Supply LVDS Comparators," ADCMP604/ADCMP605 Data Sheet, Oct. 2006 Revised [Jan. 2015].

[9] STMicroelectronics, "Arm® Cortex®-M0+ 32-bit MCU, up to 64 KB Flash, 8 KB RAM,  2x USART, timers, ADC, comm. I/Fs, 2.0-3.6 V," STM32G030x6/x8 Data Sheet, June 2019 Revised [June 2025].

[10] A. Grob, "Setting Standards: The IEC 60601 Series: Quick-Use Guide," Biomedical Instrumentation & Technology, vol. 54, (3), pp. 220-222, 2020. Available: https://ezproxy.tntech.edu/login?url=https://www.proquest.com/scholarly-journals/i-setting-standards-iec-60601-series-quick-use/docview/2414388374/se-2. DOI: https://doi.org/10.2345/0899-8205-54.3.220.

