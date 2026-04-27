# Detailed Design - Clock Generation & Jitter Measurement

## Function of the Subsystem

The Clock Generation and Jitter Measurement subsystem is responsible for conditioning the reference clock, a 2.5 MHz sinusoidal input to the transceiver Bias-T circuit which is sent along the 48 V power cable subsystem to the receiver Bias-T circuit before being passed to this subsystem. The signal must be conditioned into a digital clock signal that can be utilized in synchronizing gamma ray detection units throughout the PET scanner assembly. Because the units must be synchronized well to produce accurate measurements, this subsystem shall also utilize the Skyworks Si5345B jitter cleaner/clock synthesizer[1] to both clean the clock signal and produce a 25 MHz clock signal to be used in system level validation via jitter measurements. The Si5345B Integrated Circuit (IC) uses an internal Phase-Locked Loop (PLL) control system that compares the phase of any input clocks to the phase of an adjustable feedback clock signal generated via an external crystal oscillator. The IC then uses a loop filter to eliminate high frequency jitter before controlling a Voltage Controlled oscillator (VCO) that produces the desired output clock. A feedback divider is used to adjust the frequency of the clock signal while maintaining phase alignment [2]. While the IC generates the 2.5 MHz clock signal for use within PET scanner units, the scaled 25 MHz clock is produced with the goal of performing two types of jitter measurements: Cycle-to-cycle measurements and relative jitter measurements across the 25 MHz clock signal and the originally inserted 2.5 MHz clock on the transceiver side. Cycle to cycle jitter is defined as the variation in cycle time of a signal between adjacent cycles over a random sample of adjacent cycle pairs, meaning the measurement is relative to any independent signal [3]. Meanwhile the relative jitter between the 2.5 MHz and 25 MHz clocks characterizes how consistently the output clock maintains its expected phase relationship to the input over time (i.e. for every 10 of the 2.5 MHz clock cycles, 1 of the 25 MHz cycles aligns). The Clock Generation and Jitter Measurement subsystem allows determination for the overall success of the ComCaP system to carry the reference clock over the 48 V power cable.


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

As mentioned in the Specifications and Constraints section of this document, the reference clock signal entering the subsystem will require alteration before insertion into the Si5345B, which is a required IC. The IC expects the input signal to meet the over 300 V/μs slew rate requirement, but the maximum slew rate for the 2.5 MHz 0.05 V sine wave clock initially is found via the following equation:    

<br>

>SR<sub>max</sub> = 2πfV<sub>p</sub> = 2π(2.5 x 10<sup>6</sup>)(0.05) $\approx$ 0.785 V/μs 

<br>

To accommodate the requirement, the signal will pass through the ADA4899-1 OpAmp with a roughly 15x gain before entering the ADCMP605 LVDS comparator. The resulting digital signal will have a relatively high slew rate well above the requirement and be introduced to the Si5345B IC. The IC will clean jitter from the signal and produce a 25 MHz clock for measurements and a 2.5 MHz clock for the system's designed use. The cycle to cycle jitter measurements for the subsystem shall utilize the following methodology [3]:

1) Turn on the histogram feature for the oscilloscope, if available.

2) Turn on the C2C (cycle to cycle) feature for the oscilloscope, if available. If not, configure the scope to capture two consecutive clock cycles on the screen; subtract the period of the second clock from the period of the first clock and record the absolute value of the difference.

3) Repeat the above step at least 1,000 times.

4) If the oscilloscope has the histogram feature, record the standard deviation and the peak value. If the feature is not available, compute the standard deviation and the peak value from the 1000+ data sets. The peak value is the biggest difference between any two consecutive clock cycles in the data set.

The Si5345B chip shall ultimately utilize programmed onboard Non-Volatile Memory (NVM) that determines functionality of the chip and controls clock generation. However, a STM32 microcontroller shall be used during development to load registers into volatile memory for this chip manually via I2C due to a constraint of the chip allowing two total alloted NVM writes by the user [5]. A reset input and two additional outputs of the Si5345B, Interrupt and LoLb, shall be included during development for monitoring purposes. Interrupt is asserted when a change in the device is detected and LOLb (Loss of Lock) is asserted when phase locking is achieved. The register configuration for the Si5345B shall be accomplished using relevant parameters in the ClockBuilderPro (CBPro) software provided by Skyworks, which provides a .h file with all configuration incorporated. This file will be loaded onto the MCU for regular transfer to the Si5345B.


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

For the purposes of the following schematics, all power sources from the IC Power subsystem are modeled as simulated voltage sources and the input signal from the Bias-T subsystem is modeled similarly.

### Signal Conditioning Circuit

The below circuit is designed to perform the signal conditioning required to introduce the reference clock signal into the Si5345B. First, the signal is biased to 2.5 V to ensure proper operation of the ADA4899-1 amplifier operating via a single 5 V source. The resistors Rf and Rg are gain control resistors and their values may change as needed during development. Once the signal has been amplified, it is introduced into the ADCMP560 comparator whose threshold is biased to the same 2.5 V. The Rh resistor above the comparator is used to control its hysteresis levels and is subject to adjustment as well. Finally, the comparator emits the LVDS formatted, differential, digital clock signal into the Si5345B input. 

<img width="1045" height="820" alt="Signal Conditioning Circuit Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigCon(update3).png" />

### Si5345B Jitter Cleaner / Clock Synthesizer

The Si5345B IC receives its differential input signals from the previous conditioning circuit, labeled as Ref_Clk_P/N. Y1 designates the external crystal oscillator IC required for proper operation of the Si5345B IC [5]. Three outputs for the Si5345B IC are currently planned for utilization by the MCU and subsequently routed to the STM32 IC, consisting of Interrupt, Reset, and LOL detector. Additionally, the clock signal and data pins necessary for I<sup>2</sup>C interfacing with the MCU are routed into the Si5345B IC and require the biasing seen using 4.7 kΩ resistors. All outputs are terminated as described within the Si5345B data sheet, however the placement of the 100 Ω resistors seen between the differential pairs is subject to change (i.e. being placed before capacitors). The physical connections use to connect the output signals with testing equipment is undetermined, but likely to involve banana jacks.   

<img width="1045" height="820" alt="Si5345B Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/Si5345B_config_2_4-23-26.png" />

### STM32G030 MCU

The STM32G030 IC is connected to the Si5345B IC by the five signals mentioned in the above section: Interrupt, LOL Detector, Reset, Clock, and Bidirectional Data Pin. The connection for the active low reset is biases per the Si5345B data sheet [1]. P1 is a generic header that is temporarily modeling the port the team will use to interface with MCU. An appropriate cable to convert to USB will be required for this method. 

<img width="1045" height="820" alt="Micro Control Unit Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/MCU(update2).png" />

## Printed Circuit Board Layout

The PCB layout for this subsystem is required to be coordinated with multiple other subsystems and is still under development.

## Flowchart 

While a flowchart for the MCU blasting register info to the Si5345B might be available upon construction of the circuit, it is too early to determine all required functionality needed to produce the flowchart.

## BOM

Siemens Healthineers has committed to purchasing/sourcing all components for the ComCaP project and have access to better pricing than the ComCap team, as such the following table is not a true representation of the cost of the Clock Generation and Jitter Measurement but a representation of prices available through standard sourcing methods.

| Manufacturer | Part Number | Distributor | Distributor Part Number | Quantity | Price | URL |
| ------------ | ----------- | ----------- | ----------------------- | -------- | ----- | --- |
| Skyworks | Si5345 | DigiKey | SI5345B-D-GM | 1* | $35.84 | https://www.digikey.com/en/products/detail/skyworks-solutions-inc/SI5345B-D-GM/6166371 |
| TXC Corp. | 7M48072002 | DigiKey | 887-2480-1-ND | 1* | $1.00 | https://www.digikey.com/en/products/detail/txc-corporation/7M48072002/4918837 |
| Analog Devices Inc. | ADA4899-1 | DigiKey | ADA4899-1YRDZ-R7 | 1* | $6.18 | https://www.digikey.com/en/products/detail/analog-devices-inc/ADA4899-1YRDZ-R7/1199772 |
| Analog Devices Inc. | ADCMP605 | DigiKey | ADCMP605BCPZ-R7 | 1* | $7.52 | https://www.digikey.com/en/products/detail/analog-devices-inc/ADCMP605BCPZ-R7/1246082 |
| STMicroelectronics | STM32G030K8T6 | DigiKey | STM32G030K8T6 | 1* | $1.89 | https://www.digikey.com/en/products/detail/stmicroelectronics/stm32g030k8t6/10326689 |
| Samsung Electro-Mechanics | CL05A104KA5NNNC | DigiKey | 1276-1043-1-ND | 7* | $0.15 | https://www.digikey.com/en/products/detail/samsung-electro-mechanics-america-inc/CL05A104KA5NNNC/3889129 |
| KEMET | C0603C105K4RACTU | DigiKey | 399-C0603C105K4RACTUCT-ND | 2* | $0.20 | https://www.digikey.com/en/products/detail/kemet/C0603C105K4RAC7867/3471570 |
| Amphenol ICC (FCI) | 77311-462K05LF | DigiKey | 609-77311-462K05LFCT-ND | 1* | $1.11 | https://www.digikey.com/en/products/detail/amphenol-fci/77311-462K05LF/2665598 |
| Vishay Dale | CRCW040210K0FKEE | DigiKey | 541-2954-1-ND | 6* | $0.32 | https://www.digikey.com/en/products/detail/vishay-dale/CRCW040210K0FKEE/6073597 |
| Vishay Dale | CRCW04024K70FKED | DigiKey | 541-4.70KLCT-ND | 2* | $0.20 | https://www.digikey.com/en/products/detail/vishay-dale/CRCW04024K70FKED/1183199 |
| YAGEO | RC0603FR-10100RL | DigiKey | 13-RC0603FR-10100RLCT-ND | 3* | $0.30 | https://www.digikey.com/en/products/detail/yageo/RC0603FR-10100RL/12756390 |
| YAGEO | RC0402FR-0714KL | DigiKey | 311-14.0KLRCT-ND | 1* | $0.10 | https://www.digikey.com/en/products/detail/yageo/RC0402FR-0714KL/726540 |
| YAGEO | RC0603FR-131KL | DigiKey | 13-RC0603FR-131KLCT-ND | 1* | $0.10 | https://www.digikey.com/en/products/detail/yageo/RC0603FR-131KL/12756423 |
| YAGEO | RC0402FR-07324KL | DigiKey | YAG3117CT-ND | 1* | $0.10 | https://www.digikey.com/en/products/detail/yageo/RC0402FR-07324KL/5281982 |

*Prices assumed for a singular construction of the ComCaP system. Further production will alter quantity of parts accordingly.

## Analysis

The graphs below demonstrates the signal conditioning path to the Si5345B IC. The IC itself does not have a simulation model and will require laboratory testing to verify results, as the typical operating characteristics provided by Skyworks [1] use much higher frequencies than the provided input signal. 

The below graph depicts the input waveform (bottom, green) compared to the biased and amplified waveform output of the ADA4899-1 IC (top, blue). The amplification accomplishes a slew rate in the 10 V/µs range corresponding to the 15x gain. While this is not meeting the 300 V/µs requirement, it does aid in eliminating noise for the comparator circuit to complete the conditioning.

<img width="1900" height="880" alt="Simulation of signal conditioning from start to amplification" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigConSim(50mV).png" />

The below graph depicts the amplifier output (top, blue) compared to the comparator output (bottom, green), which resembles a fairly clean digital signal. It is worth noting that the simulation utilized the ADCMP580 apposed to the ADCMP605, which does not have a simulation model. The ADCMP580 model comparator achieves lower additive jitter and boasts a much lower propagation delay. While actual results from the ADCMP605 model may vary, the relatively low frequency of the reference clock aids in creating a similar performance. The slew rate for the comparator's output waveform averages in the 500 V/µs range, which is well above the requirement for the Si5345B to reduce jitter.

<img width="1900" height="880" alt="Simulation of signal conditioning from amplification to comparator" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigConSim(amptocomp50mV).png" />

The below graph depicts the input waveform (blue) compared to the final output waveform (red), highlighting the significant amplitude gain and corresponding slew rate hike.

<img width="1900" height="880" alt="Simulation of signal conditioning from start to finish" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigConSim(intoout50mV).png" />


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

