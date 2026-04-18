# Conceptual Design

## Introduction

Siemens Healthineers is a company that develops medical technologies, Positron Emission Tomography(PET) scanners being one of those technologies. Currently, their PET scanners incorporate separate cabling for the power and synchronization clock that are provided to the PET scanner, along with separate back channel communication. Siemens has requested for this team to consolidate these by feeding the clock and back channel communications through the power cabling.[1] This will reduce the volume of cables used as well as the number of points of failure decreasing overall system complexity. This proposal will cover the details of Siemens Healthineers' problem, the constraints and specifications they provided, already existing technology that could be used in the solution, what Siemens expects for the team to deliver, the resources required, the team members and stakeholders, and the potential implications of this new system.

## Fully Formulated Problem

Traditionally, PET scanners are made up rings of many detectors that need to be precisely synchronized. A separate piece of hardware is necessary to generate the clock and its own cabling to provide the clock to the detectors. Separate cabling is also needed for providing power to the detectors and back channel communication for trouble shooting. With the large number of detectors and the individual cabling for each of these, cabling complexity has become a problem especially with connections points being a common point of failure. The team's goal, set by Siemens, is to reduce complexity by running both the synchronization clock and back channel communications through the power cabling.[1] This solution will lead to a decrease in space usage by combining the different systems into one unit and greatly reduce the volume of cables used. This solution will also reduce the points of failure with the reduction of connection points. The primary challenges will be determining how the separate signals will be delivered and processed to stay within provided constraints and determining the best cables to support the transfer of these combined signals at the required power.

### Specifications

- The system shall utilize two Bias-Tee circuits, used for both coupling and decoupling the AC information with DC power at the transmitter (TX) and receiver (RX) respectively.
- The line voltage shall be 48 V<sub>DC</sub>.
- The system shall be capable of supporting up to 100 W of power.
- The ripple voltage observed at the receiving unit (RX) shall have a soft maximum of 200 mV.
- The total ripple voltage after voltage DC-DC conversion shall not exceed ~ 30 mV.
- The system shall utilize a reference clock with a frequency of 2.5 MHz.
- Band-pass filtering for reference clock recovery shall be fixed at 2.5 MHz.
- The receiver (RX) shall be equipped with a Skyworks model Si5345B jitter attenuator.
- Jitter measurement shall be high-fidelity.
- The slew rate for signal entering the Si5345B shall be greater than 300 V/$\mu s$.
- A 25 MHz output clock shall be synthesized via PLL for jitter measurements.
- The system may incorporate back-channel communications to assist with debugging and troubleshooting.
- PCB design files for the Transmitter (TX) and Receiver (RX) systems shall be provided to Siemens Healthineers for manufacturing.

### Constraints

- The system shall adhere to the standards set in IEC 60601. [See Standards Considerations for more information]

## Comparative Analysis of Potential Solutions

In this section, various potential solutions are hypothesized, design considerations are discussed, and factors influencing the selection of a solution are outlined. The chosen solution is then identified with justifications for its selection.

### IC Power
In the specifications of the project, the system is required to provide 100 W at 48 V from the power supply to the receiving end. In addition to providing power to the system, some power is required to power the ICs that run on both ends of the system. On the transmitting side, there will need to be power available for the PLC Modem, which operates at 11 V and 5 V, requiring less than 150 mA per plane, which falls within the specification of the MAX6793. On the receiving side, there will need to be power available for the receiving end PLC Modem, as well as the Si5345b PLC. The receiving side requires 11 V, 5 V, 3.3 V, and 1.8 V. A combination of two MAX6795  and two MAX6793 chips will supply the power to these planes to operate the ICs.

An important aspect to consider when selecting the voltage regulators is whether the outputs can supply enough current to power the ICs, as well as minimizing hardware to reduce cost and space taken on the PCB. A previous choice that was considered when selecting an LDO was the MAX5092 [2] which is only able to deliver a maximum of 250 mA. However, this chip only had one output, whereas the MAX6793 has two outputs that can be adjusted to a desired voltage between 1.5 V and 11 V, each at 150 mA. Additionally, the MAX6795 [3] was selected to handle the higher current requirements for the 3.3 V and 1.8 V power rails since they can provide 300 mA of output current. This is optimal for the proposed design as these chips reduce the number of required LDOs by two, minimizing the hardware.

#### **Consideration Individual Single-Output Vs. Dual Output LDO**
**MAX5092A/MAX5092B - Single Output Lower Power LDO**

<img width="1015" height="395" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Power_Diagram_MAX5092_.png"/>

The MAX5092A/MAX5092B low quiescent-current, low-dropout (LDO) regulators contain simple boost preregulators operating at a high frequency. The devices seamlessly provide a preset 3.3V (MAX5092A) or 5V (MAX5092B) LDO output voltage from a cold-crank through load-dump (3.5V to 80V) input voltage conditions. The MAX5092_/ MAX5093_ deliver up to 250mA with excellent load and line regulation. During normal operation, when the battery is healthy, the boost preregulator is completely turned off, reducing quiescent current to 65μA (typ). This makes the devices suitable for always-on power supplies.
* _Pros:_

    * Sufficient current output capabilities

    * Wide input range.

    * Low quiescent current consumption

    * Adjustable voltage output

    * Simpler hardware implementation

* _Cons:_

    * Only available in single output

    * Requires more units to fulfill needs of the project

**MAX6793 - Dual Output Lower Power LDO**

<img width="1075" height="414" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Power_Diagram_MAX679__.png"/>

The MAX6793 ultra-low-quiescent current, dual-output linear regulator that offers a wide 5V to 72V operating input range, allowing them to withstand demanding power draws while consuming only 68μA. The MAX6793 is dual-output regulator capable of supplying up to 150mA per output. This device offers standard output-voltage options (5V, 3.3V, 2.5V, or 1.8V) and can be adjusted to any voltage from 1.8V to 11V. The MAX6793 also offers a fixed 5V output.

* _Pros:_

    * Sufficient current output capabilities for 5 V and 11 V power system requirements

    * Wide input range

    * Low current consumption

    * Adjust able voltage output

* _Cons:_

    * Dual output current is not sufficient for 3 V and 1.8 V power system requirements

    * More complex hardware implementation.

**MAX6795 - Single Output Higher Power LDO**

The MAX6795 is an LDO similar to the MAX6793 as described above. The primary difference is that there is only a single output option. However, this LDO is capable of delivering up to 300 mA of current, which the current draw requirement for the 3.3 V and 1.8 V power requirements for the system will need. These planes will likely exceed a 150 mA draw making this more suitable for the required supply.

* _Pros:_

    * Sufficient current output capabilities for more demanding 3.3 V and 1.8 V power system requirements (up to 300 mA)

    * Wide input range

    * Adjustable voltage output

    * Similar price to MAX5092_

* _Cons:_

    * More complex Hardware implementation

### Delivery of Power, Clock, and Back Channel Communications

Consolidating how the power, clock, and back channel communications are delivered is the overall goal of the project. Although a bias tee will be used as the final approach since it is specifically requested by the customer, it is important to analyze other potential approaches including Siemens' current set up for delivery.

#### **Consideration of Separate, Combined, or Wireless Delivery**

**Separate Delivery (Current)**

The current method employed by Siemens is to deliver the power and clock separately across different cables to every detector. This is the simplest solution conceptually as there is no combining or separating of wiring or signals. However, the cabling into and through the PET scanner can get complex and this takes up much more space and has more points of failure. This also does not currently provide Siemens with any form of back channel communication.

* _Pros:_

    * No changing of current system

    * Simplest delivery of power and clock

* _Cons:_

    * High cabling complexity throughout PET scanner

    * High volume of cables with power and clock separately delivering to each detector

	* More points of failures due to more connections

	* No back channel communications

**Combined Delivery (Bias Tee)**

<img width="438" height="306" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Siemens%20Clock.png"/>

Combined Delivery is the approach that Siemens has requested for the team to use, specifically using a bias tee. Combined delivery will combine the power, clock, and back channel communications onto one cable to send to the PET scanner detectors allowing for consolidation of cabling and addition of bach channel communications. A bias tee can be used to combine or separate an RF and DC signal allowing the two signals to be transported on a single cable. Generally, an inductor is used to pass the DC signal, and a capacitor is used to pass the RF signal. The capacitors and inductors used for the filtering of the signals needs to be considered greatly as they have parasitic qualities, parasitic impedance in capacitors and parasitic capacitance in inductors, and could have AC signal leakage onto the DC signal if not properly designed leading to output signals outside of allowed tolerances. [4]

* _Pros:_

    * Lower cabling complexity

    * Lower volume of cables

	* Less points of failure due to less connections

	* Addition of back channel communications

* _Cons:_

    * AC signal leakage on DC power

    * Parasitic capacitance and impedance

	* Less commonly used for more than one RF signal and one DC signal

**Wireless Delivery (Near Field Power Transfer)**

Wireless delivery of RF signals is an extremely common way to deliver information over any distance, and wireless delivery of power over short distances is a growing approach to transferring power. While, wireless delivery of the power, clock, and back channel communications would solve all of the current problems siemens presented removing cabling issues and connection points of failure, these uses of wireless delivery use electromagnetic fields to deliver their signals. Electromagnetic interference (EMI) is a major concern for PET scanners causing noise and interference on an already noise filled system and is strictly constrained under EMI standards. Also, the PET scanners need extremely high precision, steady delivery with minimal jitter requiring wired connections. [5]

* _Pros:_

    * No cables

    * No connection points of failure

	* Addition of back channel communications

* _Cons:_

    * Electromagnetic interference

    * High jitter

	* Low timing precision

	* Potentially unstable delivery of signals

While the +

### Clock Generation & Jitter Measurement
 
While this subsystem shall ultimately utilize the Skyworks Si5345B Integrated Circuit (IC), as this component is specified by the client, the Si5395P IC is considered as a higher performance alternative  that utilizes the same configurability and ease of use. Additionally, two approaches to introducing the sinusoidal clock signal provided by the Bias-T circuit are considered. The Si5345B IC does not support direct interfacing with analog signals, as such the subsystem shall be required to convert the analog signal into a Low-voltage differential signaling (LVDS). The input and outputs of this subsystem were chosen to be LVDS formatted due to advantages in noise immunity compared to single-ended Low-voltage CMOS (LVCMOS) signals, derived from the format's differential nature [6]. This advantage in noise reduction is vital for the intended operation of the subsystem, as it reduces additive jitter caused by such noise. 

#### **Consideration for Higher Performance PLL IC**
**Si5345B**[7]

The Si5345B is a high-performance, general purpose jitter attenuator and clock synthesizer built around a single digital PLL architecture. It supports an extremely wide range of input frequencies (8 kHz to 750 MHz) making it highly adaptable. This IC can generate virtually any output frequency using fractional synthesis while providing strong jitter attenuation typically between 90 and 170 fs RMS. It also offers up to 10 differential outputs or up to 20 single-ended outputs and flexible input/output format support. The IC can tolerate poor input quality, applying narrow loop bandwidth filtering (down to 0.1 Hz) and generating a low jitter clock.

* _Pros:_

    * Good jitter performance.

    * Wide input range.

    * Lower power consumption.

    * Simple integration.

    * Exceeds the needs of the project.

    * Extensive tunability.

* _Cons:_

    * Has a higher jitter floor relative to newer IC's.

**Si5395P - Upgraded IC**[8]

The Si5395P is a newer, higher performance jitter attenuator in the same family but optimized for ultra-low jitter and high end communications systems. It also uses a single PLL architecture but achieves significantly lower output jitter typically between 69 and 100 fs RMS. This model supports the same input frequency range as the Si5345B, but offers more outputs at 12. This IC is designed for demanding applications requiring precision synchronization. The Si5395P incurs a roughly 100% increase in power usage (dependent on configuration and usage) compared to the Si5345B as well as a nearly 30% increase in cost.

* _Pros:_

    * Better jitter performance.

    * Wide input range.

    * Extensive tunability.

* _Cons:_

    * Significant cost increase.

    * Significantly greater power consumption.

    * Greatly exceeds the need of the project.

    * More complex features than necessary.

For either chip consideration, the manufacturer warns that the effect of low enough slew rates could greatly affect jitter performance, as seen in the figure below provided by the Skyworks' reference manual. This is the basis for the new specification requiring a >300 V/$\mu s$ slew rate within this document.

<img width="668" height="484" alt="Effect of Low Slew Rate on RMS Jitter" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/SlewRate.png"/> [9]

#### **Considerations for Clock Signal Conditioning Prior to Si5345B**

**Approach A: Limiting Amplifier**

<img width="761" height="354" alt="Limiting Amplifier Flow Chart" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/LimitAmp.png"/>

This approach utilizes a band-pass filter initially to minimize noise introduced by other frequencies present within the system, which would be amplified and affect jitter measurements significantly. A limiting amplifier would condition the signal by applying very high gain through multiple stages internal the the IC, which would ultimately drive the input signal into controlled saturation. As the 2.5 MHz sine wave from the Bias-T propagates through the amplifier, even small voltage differences are rapidly amplified until the output reaches a fixed amplitude independent of the input level. This process removes amplitude variations and produces a constant envelope of the resulting waveform with very steep rising and falling edges, resulting in a significantly increased slew rate. The resulting waveform would require a LVDS driver/buffer to finalize conditioning before entering the Skyworks PLL IC. Commercially available limiting amplifiers are generally designed for high data rate applications. While they remain functionally compatible at 2.5 MHz, their use in this system requires additional input conditioning and output interfacing to ensure proper biasing, signal levels, and compatibility with the jitter cleaner.

* _Pros:_

    * Very high effective slew rate.

    * Lowest additive jitter.

    * Consistent edge quality.

    * Removes amplitude variations.

* _Cons:_

    * Low flexibility for tuning.

    * Higher interfacing complexity.

    * Designed for higher frequencies.

**Approach B: High-Speed Comparator with LVDS output capability**

<img width="744" height="397" alt="High-Speed Comparator Flow Chart" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Comp.png"/>

 This approach also utilizes a band-pass filter initially for the same purpose. The signal is then amplified in order to increase the slope of the voltage waveform, particularly affecting the slew rate at its zero-crossing point, before applying a well defined threshold crossing via high-speed comparator for a defined digital timing signal. For ease of design, a comparator with innate LVDS output capabilities shall be considered. The timing accuracy of this approach is governed by the ratio of input noise to signal slope at the comparator threshold, meaning that higher slew rates directly reduce jitter. Unlike the limiting amplifier, this approach allows explicit control over gain and threshold, enabling optimization for specific input conditions. However, because the comparator makes a single threshold decision, it remains sensitive to noise and amplitude variations at the crossing point. When properly designed, the LVDS signal resulting from this approach provides sufficiently fast edges and low jitter for reliable input into either Skyworks PLL IC.

 * _Pros:_

    * High flexibility and control.

    * Sufficient slew rate with proper amplification.

    * Sufficient additive jitter.

    * Direct LVDS out capability.

* _Cons:_

    * Higher sensitivity to noise at threshold.

#### **Evaluation Criteria**

The overall evaluation of this subsystem is centered around reducing jitter measured via the outputs of the subsystem. For selection of PLL IC, the criteria are: Output Jitter Performance, Cost, Power Consumption, and Appropriateness pertaining to the project's scope. The criteria used to evaluate each input signal approach are: Additive Jitter, PLL IC Input Slew Rate, Sensitivity to Input Noise, and Flexibility. 

#### **Evaluation & Selection**

| | **Si5345B** | **Si5395P** | 
|:--|:--|:--|
| **Output Jitter** | Low: 90-170 fs RMS | Lowest: 69-100 fs RMS |
| **Cost** | $35.84 | $46.10 |
| **Power Consumption** | Lowest: $\approx$ 0.4-0.6 W | Higher: $\approx$ 0.8-1.0 W |
| **Appropriateness** | Exceeds Needs | Greatly Exceeds Needs |

| | **Limiting Amplifier** | **Comparator** | 
|:--|:--|:--|
| **Additive Jitter** | Very Low: $\approx$ 1-5 ps RMS | Low: $\approx$ 5-10 ps RMS |
| **Input Slew Rate** | Great: $\approx$ 1000 V/$\mu s$ plus | Good: $\approx$ 300-500 V/$\mu s$ Dependent on Amplifier |
| **Noise Immunity** | High: Saturation | Moderate: Single Threshold Decision |
| **Flexibility** | Low: No Adjustable Gain or Logic Threshold | High: Adjustable Gain & Logic Threshold |

As previously stated, Siemens Healthineers specifically requires the use of the Si5345B IC within this project, as this chip is currently used. This IC exceeds the jitter needs of the ComCaP project and as such higher performance, more expensive, and higher power consumption models are not necessary or warranted. For these reasons, there is insufficient justification to use the Si5395P IC.

In selecting the appropriate signal conditioning approach for the ComCaP project, jitter considerations are of high importance. While the limiting amplifier approach technically achieves better theoretical jitter performances, the comparator approach also performs sufficiently with acceptable jitter. Flexibility of this subsystem during development is highly important. While simulations may provide estimates for the integrity of the signal after extraction from the Bias-T circuitry, the expectation is that noise introduced throughout the system will affect the signal unpredictably. As such, the highly adjustable configuration of the comparator approach is preferable for this project.

### Communication 
For the communication subsystem, Power Line Communications modems on either side of the transmission line have UART signals to communicate to the User and Client, and modulated packets for the intermediate signal sent over the transmission line. There are two system-level approaches to consider for the communications for the product. One approach uses a Power Line Communications modem (PLC modem) with a programmable ARM processor to process input data and through a program to then send to the data link and physical layers. These layers create a modulated packet signal to send over the transmission line. The other approach would be to use a PLC modem without an SoC to allow inputs to interface with the data link and physical layers directly.

The document provided by Siemens suggests the the ST7540, which is a PLC modem without an ARM processor. This model is deprecated, and the current supported model in that series is the ST7580. To consider an IC with similar features and a more advanced ARM processor, the ST8500 would use that same system level approach.

#### **Integrated Circuit Consideration**
**ST7580 - Turnkey Modem**[7]

The ST7580 has several features to consider. The networking layers have "turnkey embedded software" and the analog front-end is fully integrated. This IC requires no programming to function, but thus is limited in its function. It comes programmed with seven modulation modes. This approach has fewer features, but the turnkey software allows simple UART interfacing with the IC that is more easily made compatible with the data inputs. On the other hand, The ST7580 is less flexible than the ST8500 because its firmware cannot be flashed. The ST7580 only runs the way it comes, save for limited interfacing through pins. The ST7580 also uses a very simple packet design, which while more efficient, can be difficult to network with at scale. This would limit usage in a larger application.

* _Pros:_

    * Functional out-of-the-box

    * Small, efficient packets

    * UART-compatible data input

    * Little development risk

* _Cons:_

    * Little flexibility in modulation and data structure
    
    * Difficult to network with simple packets at scale 

#### **ST8500 - ARM-core modem**[8]

The ST8500 has more features, but this IC is significantly more difficult to intialize and interface with due to having a more complex processor. It comes with only a bootloader and would need a fully programmed physical and data link layer. The IC is compatible with STM32CubeProg, a free programmer application. This may be an alternative if a more advanced protocol is necessary. The ST8500 has a lot of flexibility in its firmware, but that has risks in developing for it. Programming the processor incorrectly could brick the system or cause the chip to malfunction. This is a risk on the development side, but there are some limitations on the user side. The networking system uses MAC, which has more overhead. This could allow for scaling, but for a single node application like this, MAC addressing is not necessary. 

* _Pros:_

    * More robust packets
    
    * Programmable firmware allows flexibility

* _Cons:_

    * Programmable firmware has development risks

    * Adds scale needing network layers to be programmed



#### **Evaluation Criteria**

This system must allow the user to send data over the transmission line for the purpose of debugging. In order to work with the rest of the system, other criteria must be met. This must be compatible with the systems that will be developed by Siemens. In addition to this, increased complexity will increase the scale of this project, so such complexity must be necessary. 

#### **Evaluation & Selection**

The simplicity and ease of development on the ST7580 platform justifies what limitations it may have. The development challenges of the ST8500 are not worth it when this application is basic debugging. The turnkey firmware of the ST7580 would make interfacing from the other systems in the coincidence unit simple for Siemens to use.

### Cable
The cable is the method by which the power, data, and clock is transmitted and received by both ends of the system. The customer has allowed a lot of freedom on how the cable is selected, so this lends itself to a wide range of possibilities. The two cables that seem to be the most promising are the twisted strand and the coaxial cable [12]. Twisted strand cables are two cables twisted around one another to minimize interference. Coaxial cables are cables in which a metallic shield surrounds a core conductor. The primary considerations for the cable is the electromagnetic interference, data transmission capabilities,price, and the transmission line characteristics of the cable. Although, the electromagnetic interference is a secondary consideration compared to the others.

#### Twisted Pair

 * _Pros:_
   * Siemens suggested that the team use the twisted pair in their initial analysis. Siemens never specified that the team must to use it, but it is a consideration that needs to be taken into account.
   * Twisted pair cable is less expensive than coaxial cable.

* _Cons:_
   * Twisted pair cables are physically longer, therefore there is a greater chance to have issues with reflection.
   * Twisted pair cable generate more electromagnetic interference.

#### Coaxial

 * _Pros:_
   * Greater shielding means there is less electromagnetic interference with the coaxial cable.
   * Coaxial cable is optimized for data transmission.

* _Cons:_
   * Given current use cases for power over coaxial systems, none have been designed to handle the current that the team is expected to use [13].
   * Coaxial cable is more expensive than twisted pair.

Given the above considerations, the team will use the twisted pair cables in their design. While coaxial cables have better data transmission characteristics and electromagnetic shielding, those characteristics are secondary. The twisted pair cables better fit the team's need since those are cheaper and can handle more power. If the team were to use the coaxial cable, there is a large chance that there will be issues with power. The team can correct any reflections and can design around any bandwidth restrictions, but the risk of overloading the cable is too great and any workarounds will be much more difficult.

## High-Level Solution

To fulfill the goal of reducing complexity of the clock, power, and communication systems, each system needs to be atomically considered along with systems to integrate these together. Following the focuses of the problem introduction presentation from Siemens Healthineers [1], the most integral system for the solution is a bias tee to transmit the frequencies over the transmission line. This is the system that will have the atomized systems built upon it. The atomized systems are as follows:

- The power system takes power from outside and prepares it to be transmitted. The clock system
- The clock system generates a clock and transmits it on one end, and it receives and filters jitter on the other end. This system will have accessible measurement to measure the jitter.
- The communication system takes data input and packages it to be transmitted on one end, then unpackages and outputs the communications on the other end.  


### Hardware Block Diagram

<img width="1052" height="569" alt="Hardware block diagram showing the flow of the power, clock, and back channel communications" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Hardware%20Block%20Diagram.png"/>

#### Bias Tee

The bias tee is the primary focus of this project and what brings every other subsection together. The bias tee will use an inductor to pass the DC power and capacitors to pass the RF clock and communications on the input side allowing all three to travel on the single cable. Then the bias tee will separate the signals again using an inductor for the DC and capacitors for the RF clock and communications.

#### Power

The 100 W power will be provided to the system in the form of a 48 V DC signal. The power must also output the system as a 48 V DC signal with minimal deviance. This input power will be used to power the chips of the system. Required voltage and current for the ST7580 is 13 V and 30 mA. Required voltages for the Si5345b are 3.3 V and 1.8 V and 150 mA.

#### Clock Generation & Jitter Measurement

The reference clock will also be provided to the system. It will enter and leave the system as a 2.5 MHz RF signal. For the output of the clock from the system, a jitter cleaning clock synthesizer is used (Si5345B). There will also be a second clock output from the system of the reference clock scaled to 25 MHz to measure the cycle-to-cycle jitter.

#### Communications

The back channel communications will also be provided to the system as a not yet specified frequency RF signal. The communications will be used to interact with the PET scanner. The communications will be able to be transmitted and received from both ends of the system feeding through the ST7580 chip. The team has freedom to approach this in many different ways, although this is considered a reach goal by the customer.

#### Cable

The cable will transport the combined signal produced by the bias tee. The cable will be up ten meters long and be capable of transporting both DC and RF. Currently, coaxial and twisted pair are being considered for the cable used.

### Operational Flow Chart

This system has minimal user input since it is an automatic system that receives inputs when the PET scanner is turned on. There is also no software in the system. Therefore, an operational flowchart is not applicable.


## Atomic Subsystem Specifications
<!--
Based on the high-level design, provide a comprehensive description of the functions each subsection will perform.

Inclued a description of the interfaces between this subsystem and other subsystems:
- Give the type of signal (e.g. power, analog signal, serial communication, wireless communication, etc).
- Clearly define the direction of the signal (input or output).
- Document the communication protocols used.
- Specifying what data will be sent and what will be received.

Detail the operation of the subsystem:
- Illustrate the expected user interface, if applicable.
- Include functional flowcharts that capture the major sequential steps needed to achieve the desired functionalities.

For all subsystems, formulate detailed "shall" statements. Ensure these statements are comprehensive enough so that an engineer who is unfamiliar with your project can design the subsystem based on your specifications. Assume the role of the customer in this context to provide clear and precise requirements.
-->

### Bias Tee

The bias tee is the main approach to the problem, being specifically required by the customer. A bias tee can combine or separate an RF and DC signal allowing the two signals to be transported on a single cable. Generally, an inductor is used to pass the DC signal, and a capacitor is used to pass the RF signal. For this design, a bias tee will be used to combine a DC power supply, RF clock signal and RF communications signal then send this combined signal across a cable to another bias tee that will be used to separate the three signals back out.

Function:
- Combine signals and separate signals.

Inputs:
- 48 V DC power signal.
- 2.5 MHz RF reference clock signal.
- RF back channel communications signal.

Outputs:
- 48 V DC power signal.
- 2.5 MHz RF reference clock signal.
- RF back channel communications signal.

Requirements:
- Shall pass DC power through inductor.
- Shall pass RF signals through capacitors.
- Shall combine all three signals and send across cable.
- Shall receive and separate all three signals.

### IC Power

Power is required to be passed to the ICs that run specific circuitry in the system. The voltage and current will be tapped off of the main power passed over (100 W at 48 V). The MAX6793 was selected to supply 11 V and 5 V for the ST7580 on the transmitting and receiving ends at 150 mA per output, and two MAX6795 chips shall supply 3.3 V and 1.8 V for the Si5345b at 300 mA on the receiving end of the system.

Function:
- Supply power to the IC components in the system.

Inputs:
- 48 V DC power signal.

Outputs:
- 11 V, 5 V, 3.3 V, 1.8 V DC.
- 150 mA, 150 mA, 300 mA, 300 mA for each power rail respectively.

Requirements:
- Shall supply 150 mA at 11 V and 5 V for the ST7580 and related circuitry.
- Shall supply 300 mA at 3.3 V and 1.8 V for the Si5345 and related circuitry.

### Clock Generation & Jitter Measurement

The Clock Generation and Jitter Measurement subsystem is responsible for conditioning the reference clock frequency of 2.5 MHz, extracted from the high-voltage line by the Bias-T subsystem, into a usable digital signal. The subsystem also generates a low jitter 25 MHz Low-Voltage Differential Signaling (LVDS) output clock utilizing the Skyworks Si5345B jitter cleaner/clock synthesizer via an internal Phase-Locked Loop (PLL)[7]. The subsystem allows for two types of jitter measurements to confirm reference clock integrity. The first measurements, cycle-to-cycle jitter, shall be taken directly from probing the 25 Mhz output signal of the Si5345B via oscilloscope and measuring time between consecutive rising edges of the clock. The second measurements, output clock jitter relative to reference clock, shall be taken in a similar fashion by comparing synchronized oscilloscope readings for the respective signals. The Si5345B chip shall ultimately utilize programmed onboard Non-Volatile Memory (NVM) that determines functionality of the chip and controls clock generation. However, a microcontroller shall be used during development to load registers for this chip manually via I2C due to a constraint of the chip allowing two total alloted NVM writes by the user [9]. A reset input and two additional outputs of the Si5345B, Interrupt and LoLb, may be included during development for monitoring purposes. Interrupt is asserted when a change in the device is detected and LOLb (Loss of Lock) is asserted when phase locking is achieved. The Clock Generation and Jitter Measurement subsystem allows determination for the overall success of the ComCaP system to carry the reference clock over the 48 V power cable.

Functions:
- Clean clock signal provided by Bias-T circuit on receiving end of ComCaP system.
- Generate 10x scaler multiple of reference signal for jitter measurements.

Inputs:
- 2.5 MHz LVDS Clock Signal
- I2C serial communication interface Chip Configuration
- Active Low Reset

Outputs:
- 2.5 MHz LVDS Clock Signal
- 25 MHz LVDS Clock Signal
- Interrupt Status Signal
- Loss of Lock Status Signal

Interface:
- No direct user interface is required beyond initial configuration.
- Microcontroller with usb connectivity shall be used to interface with the Si5345B chip during development.

Requirements:
- Shall receive an input with a >300 V/$\mu s$ slew rate.
- Shall be equipped with the Skyworks Si5345B IC.
- Shall produce a low jitter clock signal observed from high-fidelity measurements.
- Shall synthesize a 25 MHz output clock for measurements.

#### Si5345B Reference Schematic
<img width="951" height="747" alt="Si5345B Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Si5345B_config_4-16-26.png" />


### Communications

The communications of the ComCaP are the tertiary focus of this project [1]. This system must offer an ability to send debugging signals across the transmission line and receive a response back. The ST7580 will be the Power Line Communications (PLC) Modem, which offers several options for modulation. More options for modulation allows for the paradigm with the cleanest output to be chosen. Built-in error correction will be useful in keeping the packet data manageable. 

Function:
- Transmit/receive debug communications between both boards 

Inputs:
*Transmit Mode:*
- UART Debug Commands
- Digital and Analog Power Sources (modified by buck converters)

*Receive Mode:*
- Modulated Analog Response signal

Outputs:
*Transmit Mode:*
- Modulated communications on a frequency between 9-250 kHz

*Receive Mode:*
- Demodulated response data

Requirements:
- Needs to be able to modulate data to output an analog signal. 
- Must be controllable by an outside system that manages debugging


### Cable

The cable is the physical connection between the transmission and reception side of the ComCaP. It is responsible for carrying the power, clock, and back channel communications over a distance of two to ten meters. Because of the complexity of the system, the transmission line characteristics and the electromagnetic characteristics of the cable must be simulated and taken into account. From the comparative analysis, the twisted pair cable seems to be the most suitable for the team's design.

Function:
- Carry signals from the Tx to the Rx side of the ComCaP

Inputs:
- 48 V DC power signal.
- 2.5 MHz RF reference clock signal.
- RF back channel communications signal.

Outputs:
- 48 V DC power signal.
- 2.5 MHz RF reference clock signal.
- RF back channel communications signal.

Requirements:
- Shall be able to connect and disconnect easily.
- Shall minimize electromagnetic interference with the rest of the system.
- Shall preserve the inputs and outputs during transmission to the best of its ability.


## Ethical, Professional, and Standards Considerations

<!--In the project proposal, each team must evaluate the broader impacts of the project on culture, society, the environment, public health, public safety, and the economy. Additionally, teams must consider relevant standards organizations that will inform the design process. A comprehensive discussion should be included on how these considerations have influenced the design. This includes detailing constraints, specifications, and practices implemented as a result, and how these address the identified considerations.-->

### Ethical Considerations

The ComCaP device will impact both doctors and patients. For doctors, the device will be smaller than Siemens Healthineers' existing solution, providing more space for them to use for other medical equipment or devices. The PET system will also become more reliable as the team is minimizing the points of failure as well as adding communications to help diagnose issues. Added reliability will decrease both the number of times the PET system will be down, and decrease the amount of time it takes for the PET system to return back online. Because of that, the PET system can be used more often, and will help diagnose more people with medical conditions. The benefits to both doctors and patients will hopefully lead to more diagnoses and save more lives.

The implications of the product failing must be taken into account. In this case, if the project fails, that means that there will be more downtime on life saving medical equipment which could lead to a delay medical emergencies being detected. In extreme cases, that extra time could be the difference in life or death. While it is unrealistic to build a perfect product, the team will minimize points of failure to the best of its ability. The team will be truthful in all of the things that it does, even if that means failure of the project. An unsuccessful product is much better than an unsafe one. 

### Professional Considerations

As engineers, the team upholds values such as those outlined in the National Society of Professional Engineers (NSPE) code of ethics [14]. The team will emphasize the health and safety of the public and conduct itself in an honest matter. The team will be transparent in all its actions, because an NDA was not signed. The team will meticulously document everything it does, so the customer can build upon the solution after the team is removed from the project.

### Standards Considerations

Since the customer will be making changes to our final design before implementing it, the customer has accepted responsibility for the adherence of standards for the project. However, that does not mean that the team will ignore the standards. It just means that if there is a set of standards that the team knows about but cannot access through legitimate means those standards cannot be considered. This includes IEC 60601 [15], the standards outlining electrical requirements for medical devices. It also includes BS EN 50065 [16], signalling restrictions on low voltage devices. The latter is a European standard, which the team is not held to in the United States, but was included as Siemens Healthineers is an international company.

As for standards that the team is able to follow, one is 47 CFR Part 15 Subpart A [17]. These are the federal regulations surrounding radio frequency devices. Under &sect; 15.103(e), since the ComCaP is part of a specialized medical device, it is exempt from 47 CFR Part 15 Subpart B. Subpart B is the regulations surrounding unintentional radiators, which is what the ComCaP would have been otherwise. Subpart A, however, is the general regulations. Therefore the ComCaP still must be upheld to those standards. The standards that pertain to the teams scope of the project are &sect; 15.5(b), &sect; 15.13, and &sect; 15.15(a). &sect; 15.5(b) states that the operation of the device "is subject to the conditions that no harmful interference is caused and that interference must be accepted that may be caused by the operation of an authorized radio station, by another intentional or unintentional radiator, by industrial, scientific and medical (ISM) equipment, or by an incidental radiator". This means that our device must operate within a safe range of interference and that the device must be capable of withstanding any standard interference that it may come into contact with. &sect; 15.13 states that the manufacturers of incidental radiators shall minimize the risk of harmful interference. &sect; 15.15(a) states that the team must construct the device with a sound engineering design. It also states that the device should minimize emanations and it cannot be harmful. &sect; 15.13 and &sect; 15.15(a) are redundant, but &sect; 15.13 refers specifically to incidental radiators, which is what the device will be. All this means for the team is that it shall minimize interference wherever is practical, and the team shall ensure that the device will not generate any harmful interference. Harmful interference is defined in &sect; 15.3(m) as "Any emission, radiation or induction that endangers the functioning of a radio navigation service or of other safety services or seriously degrades, obstructs or repeatedly interrupts a radiocommunications service operating in accordance with this chapter." Most of the incidental radiance will come from the cable, therefore the cable needs to be constructed in a way that minimizes EMI, and measurements must be taken from the cable to ensure that the emanations are not harmful.

Another set of standards that the team is expected to follow is 29 CFR Part 1910 Subpart S - Design Safety Standards for Electrical Systems [18]. Since much of this document is related to worker safety and our project is an internal subsystem for Siemens Healthineers' PET scanner, not much of this document pertains to the ComCaP team in particular. However, &sect; 1910.303(b)(1) pertains to the team in that it states that "Electric equipment shall be free from recognized hazards that are likely to cause death or serious physical harm to employees." For the team, that means that anywhere there is 48V DC the team needs to ensure that it is properly insulated and not at risk of overheating. Also, &sect; 1910.303(b)(3) states that the team needs to ensure that the wiring is free from short circuits. The rest of the standard pertains to external connections to the PET scanner, of which the team has no bearing on. At a high level this standard is ensuring that the team constructs the ComCaP safely, and that the 48 V is dealt with in a safe manner. That means the team needs to make sure that the cables are properly insulated, the connectors are properly fitted and installed, and the pcb is designed to best practices.

## Resources

This project will include primarily hardware components to implement the design: the Bias Tee circuits (Rx and Tx), the Si5345B Jitter-Cleaning Clock Synthesizer, the ST7580 FSK Power Line Transceiver, various SMD components to support those circuits, the PCB, a power supply, and cables for the I/O. Additionally, LTSpice will be used primarily for simulation files to deliver to the customer.

#### Hardware Components

1. Bias Tee Circuitry: Specific Capacitors, Inductors, and Resistors will need to be selected to create the bias tee with certain characteristics to operate at ideal functionality.
2. Jitter Cleaning Clock Synthesizer: Si5345B. This chip is used for generating a reference clock. This chip was selected by the customer for its ability to maintain a clean signal and reduce jitter [7]. Circuitry associated with this is a high speed op-amp (ADA4899-1) and a single supply LVDS comparator (ADCMP605).
3. FSK Power Line Transceiver: ST7580. This chip is a flexible power line networking system-on-chip combining a high performing PHY processor core and a protocol controller with a fully integrated analog front-end (AFE) and line driver for a scalable future-proof, cost effective, single chip, narrow-band power line communication solution [10].
4. PCB: Two boards will be designed and laid out. One board shall be in charge of producing the clock signal and biasing it to be fed over a cable to the receiver. The other board shall function as the test board to check the jitter measurements and ensure that the design falls within the specifications outlined by the customer.
5. Power Supply: Provides power to the board which will then be stepped down to power the the various components and then sent over the cable from the transmitter to the receiver. Power supply will be provided by the customer. For the LDO chips that will convert the 48 V down to the required voltages (11 V, 5 V, 3.3 V, 1.8 V), they are the MAX6793 and MAX6795.
6. Cables: Cables will be procured or fabricated to carry the power and signal from the transmitter to the receiver. Present options for the cable are Ethernet or Coaxial cables.

### Budget

<!--Develop a budget proposal with justifications for expenses associated with each subsystem. Note that the total of this budget proposal can also serve as a specification for each subsystem. After creating the budgets for individual subsystems, merge them to create a comprehensive budget for the entire solution.-->

<!-- This chart will likely change over time as the project progresses, as the exact materials needed is not certain yet -->
Estimate of the cost for major materials needed:

| Item                                 | Description / Notes                        | Quantity | Approx. Cost per unit (USD) |
|--------------------------------------|--------------------------------------------|----------|-----------------------------|
| Si5345B Clock Synth                  | Generates and cleans clock signal          | 2        | $34.46                      |
| Cables                               | Cables for I/O                             | 3        | $20–$30                     |
| Main PCB                             | Generates clock and regulates power        | 1        | $20-$30                     |
| Jitter Measurement PCB               | Measures jitter and analyzes power signal  | 1        | $20-$30                     |
| Passive SMD Components               | Various components for circuits on PCBs    | 1 set    | $70-$80                     |
| Cable Ports                          | Ports for the cabling I/O on the PCB       | 2        | $5-$10                      |
| ST7580 FSK Power Line Transceiver    | Transceiver for FSK Functionality          | 1        | $5-$10                      |
| X-NUCLEO-PLM01A1                     | Eval board for Power Line Modulator        | 2        | $15.88                      |
| NUCLEO-L476RG                        | MCU compatible with eval board             | 2        | $21.75                      |
| Si5345 Eval Board                    | Evaluation board for clock synthesizer     | 1        | $388.12                     |
| ADA4899-1                            | High Speed Op-Amp                          | 1        | $2.59                       |
| ADCMP605                             | Single-Supply LVDS Comparator              | 1        | $3.22                       |
| MAX6793                              | High-Votlage Single Linear Regulator       | 1        | $2.91                       |
| MAX6795                              | High Voltage Dual Linear Regulator         | 1        | $3.22                       |
| Prototyping Cost                     | Extra material, spares, test components    |          | $200                        |

### Division of Labor

The team allowed its members to bid for assignment to subsystems such that each member felt comfortable that all technical strengths were utilized efficiently and the workload of each member was reasonable, both in the context of learning new skills and applying current knowledge to the design process. Each member's role within the design process and the relevant skills to accommodate respective subsystems are as follows:

**Levi Cantrell - Clock Generation & Jitter Measurement**  
Levi's experience and interest in signal processing cater to Rx side clock processing, both filtering and jitter attenuation. Additionally, Levi's background in hardware analysis paired with research conducted on the Si5345B chip make this subsystem well fitted. 

**Tyler Chan - PCB Design, Bias T, Coordination**  
With experience in PCB design and interest in circuit design pertaining to the bias T circuit, Tyler is well suited to oversee multiple subsystems and coordinate integration with each of them. Additionally, as the project lead, Tyler will oversee the coordinated development of each subsystem within the context of the overall project.

**Jonas Cross - Back-Channel Communications**  
Having diverse telecommunications skills and a computer design background, Jonas complements the back-channel communications subsystem. Jonas's skills and interest involving the back-channel communications will be vital to the proper selection of hardware and software implementation for this subsystem.

**Harry Rudd - Data & Power Transmission Cable**  
Harry's skills in circuit simulations and desire to research cable design give him useful agency in designing the cable subsystem. With multiple tools to analyze characteristic differences between available cable options, Harry will ensure optimal performance for transmission. 

**Ryan Shipwash - Bias T**  
Ryan's knowledge in circuit design and pragmatism in component selection will be useful in his role on the central bias T circuitry. Additionally, Ryan has exceptional communication skills and will benefit from a central role within the project and collaborating with the other members in this design aspect.

### Timeline
Most of the subsystems can be developed in parallel, without any specific part needing to be done before another part is completed. The Bias Tee, PLL, Communications, and Cabling subsystems along with simulation work can be completed at the same time. Once each system is done, integrating them together will be the next step. This would involve prototyping and laying out the PCBs as necessary for each system that requires it. This process is detailed in the Gantt chart as shown below.

<img width="1324" height="321" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Gannt_Chart_G3_Conceptual_Design_Updated.png" />

## References

<!--All sources utilized in the conceptual design that are not considered common knowledge must be properly cited. Multiple references should be included.-->

[1] J. Kolb, "Combined Power and Signal Delivery: A 48-V Clock and Communication Link," unpublished, Siemens Healthineers, Dec. 2025.

[2] Analog Devices, "MAX5092/MAX5093 4V to 72V Input LDOs with Boost Preregulator," MAX5093 Rev 2 Data Sheet, Oct. 2006 Revised [Oct. 2014].

[3] Analog Devices, "MAX6791–MAX6796 High-Voltage, Micropower, Single/Dual Linear Regulators with Supervisory Functions," MAX6793 Rev 3 Data Sheet, Oct. 2005 Revised [Oct. 2017].

[4] FesZ Electronics, “Bias Tee Basics (1/2),” YouTube, Jun. 07, 2025. https://www.youtube.com/watch?v=2nusy07ljPk&list=PLT84nve2j1g_s3Lu1JEki9eVB9_nb9qNf&index=2 (accessed Mar. 30, 2026).

[5] C. Fuentes et al., “Design of a Mobile and Electromagnetic Emissions-Compliant Brain Positron Emission Tomography (PET) Scanner,” Sensors, vol. 25, no. 17, p. 5344, Aug. 2025, doi: https://doi.org/10.3390/s25175344 (accessed Apr. 17, 2026).

[6] "LVDS: Interface technology of choice," EEtimes, https://www.eetimes.com/lvds-interface-technology-of-choice/ (accessed Apr. 11, 2026).

[7] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].

[8] Skyworks, "12-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier with Ultra-Low Jitter," Si5395/94/92 Data Sheet, July 2018 Revised [July 2020].

[9] Skyworks, "Any-frequency, Any-output Jitter-Attenuators/Clock Multipliers Si5345, Si5344, Si5342 Family Reference Manual," Si5345, Si5344, Si5342 Rev. D Family Reference Manual, July 2016 Revised [September 2018]

[10] STMicroelectronics, "FSK, PSK multi-mode power line networking system-on-chip," ST7580 Rev 2 Data Sheet, Jan. 2012 Revised [May 2016].

[11] “Power-line communication (PLC) ICS, socs, transceivers,” STMicroelectronics, https://www.st.com/en/interfaces-and-transceivers/power-line-transceivers.html (accessed Mar. 31, 2026). 

[12] “Difference between coaxial cable and twisted pair cable,” GeeksforGeeks, https://www.geeksforgeeks.org/computer-networks/difference-between-coaxial-cable-and-twisted-pair-cable/ (accessed Mar. 30, 2026). 

[13] C. Li, D. Merillat, and J. Phan, “FPD-Link ADAS Power-Over-Coax Design Guidelines,” Texas Instruments, Oct. 2025.

[14] “NSPE code of Ethics for Engineers: National Society of Professional Engineers,” NSPE Code of Ethics for Engineers | National Society of Professional Engineers, https://www.nspe.org/career-growth/nspe-code-ethics-engineers (accessed Feb. 22, 2026).

[15] A. Grob, "Setting Standards: The IEC 60601 Series: Quick-Use Guide," Biomedical Instrumentation & Technology, vol. 54, (3), pp. 220-222, 2020. Available: https://ezproxy.tntech.edu/login?url=https://www.proquest.com/scholarly-journals/i-setting-standards-iec-60601-series-quick-use/docview/2414388374/se-2. DOI: https://doi.org/10.2345/0899-8205-54.3.220. 

[16]“BS EN 50065 - Signalling on low-voltage electrical installations in the frequency range 3 kHz to 148,5 kHz and 1,6 MHz to 30 MHz,” Bsigroup.com, 2026. https://landingpage.bsigroup.com/LandingPage/Series?UPI=BS%20EN%2050065 (accessed Apr. 16, 2026).

[17] “47 CFR Part 15 Subpart A -- General,” Ecfr.gov, Apr. 10, 2026. https://www.ecfr.gov/current/title-47/part-15/subpart-A (accessed Apr. 17, 2026).

[18] “29 CFR Part 1910 Subpart S - Design Safety Standards for Electrical Systems,” Ecfr.gov, Apr. 03, 2026. https://www.ecfr.gov/current/title-29/part-1910/subject-group-ECFR63ab49e215d9639 (accessed Apr. 17, 2026).


## Statement of Contributions

Levi Cantrell - Restating the Fully Formulated Problem, Specifications, Comparative Analysis of Potential Solutions & Atomic Subsystem Specifications for Clock Generation & Jitter Measurement

Jonas Cross - High level solution summary, Comparative Analysis and Atomic Subsystem of Communications

Tyler Chan - Resources, Budget, Timeline, Comparative Analysis and Atomic Subsystem for IC Power

Ryan Shipwash - Introduction, Hardware Block Diagram, Operational Flow Chart, Comparative Analysis for Delivery and Atomic Subsystem Specifications for Bias Tee

Harry Rudd - Comparative Analysis of the Cable; Atomic Subsystem of the Cable; Ethical, Professional, and Standards Considerations