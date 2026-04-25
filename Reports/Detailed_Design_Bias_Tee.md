# Detailed Design

<!--This document delineates the objectives of a comprehensive system design. Upon reviewing this design, the reader should have a clear understanding of:

- How the specific subsystem integrates within the broader solution
- The constraints and specifications relevant to the subsystem
- The rationale behind each crucial design decision
- The procedure for constructing the solution-->

<!--## General Requirements for the Document

The document should include:

- Explanation of the subsystem’s integration within the overall solution
- Detailed specifications and constraints specific to the subsystem
- Synopsis of the suggested solution
- Interfaces to other subsystems
- 3D models of customized mechanical elements*
- A buildable diagram*
- A Printed Circuit Board (PCB) design layout*
- An operational flowchart*
- A comprehensive Bill of Materials (BOM)
- Analysis of crucial design decisions

*Note: These technical documentation elements are mandatory only when relevant to the particular subsystem.-->


## Function of the Subsystem

The Bias Tee is the center and primary focus of the overall design. The Bias Tee is a combined approach to delivering the power, clock, and back channel communications. The Bias Tee subsystem is split into two sides, both being separate bias tees. One side couples the RF signals of the clock and communications with the DC signal of the power onto one cable to then be decoupled cleanly back into the three original signals by the other bias tee, and they are both capable of performing this coupling or decoupling allowing for two way usage of the communications.

As a result of the Bias Tee combining the power, clock, and communications onto the cable then delivering them, this subsystem directly interacts with and relies on the all four other subsystems of the same names. The signals delivered from the Bias Tee must be usable by each subsystem to for each one to succeed.

## Specifications and Constraints

### Customer Specifications:

As specified by Siemens Healthineers, the Bias Tee shall receive and operate with a line voltage of 48V DC. With that 48 V DC, the Bias Tee shall be capable of supporting and supplying 100 watts of power requiring parts to sustain a current of 2A. The Bias Tee shall produce the power signal with a ripple voltage of less than 30mV using proper filter to minimize drops and rises after decoupling. The Bias Tee shall receive and produce a clock signal at 2.5 MHz after coupling and decoupling. The Bias Tee shall have a two function to allow for back channel communications to be able to communicate with and trouble shoot the external system.[1]

- Shall operate with a line voltage of 48V DC
- Shall supply up to 100 watts of power
- Shall produce a ripple voltage of less than 30mV
- Shall produce a clock signal at 2.5 MHz
- Shall allow for two way back channel communications

### Component Constraints

The Bias Tee shall prevent AC leakage onto the DC power source and between the two RF signals to any perceivable degree by considering how the low-pass and high-pass filters can be adjusted to cutoff different frequencies from undesired paths. The Bias Tee shall account for parasitic inductance in capacitors and parasitic capacitance in inductors in the filtering along with series resistances to keep signals clean before being delivered to other subsystems.[2] The Bias Tee shall use resistors to account for the characteristic impedance preventing reflections in cabling.

- Shall prevent AC leakage. Here, the comms signal has almost completely leaked  into the clock signal causing it to adopt the 200kHz frequency only sustaining the 2.5MHz frequency partially in the jaggedness of the wave.

<img width="900" height="200" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Bias_Tee/Documentation/Bias_Tee_Images/Leakage%20example.png"/>

### Standards

Shall work to abide by the IEC 60601 standards since the outputs of this system regulate a piece of medical equipment, a PET scanner. This will be achieved by focusing on making sure the Bias Tee subsystem limits current and AC leakage, keeps consistent smooth operation, and limits electromagnetic interference of other parts of the system and of other medical equipment. Although, within the scope of this design, as stated by Siemens Healthineers, the design does not need to have in depth approaches to following these constraints outside of what is needed to fit within the specifications of the project.

## Overview of Proposed Solution

The Bias Tee subsystem will use a combination of low-pass and high-pass filters to couple and decouple the three provided signals. The main requirement of this subsystem is to successfully combine and separate the power, clock, and back channel communications outputting each signal within the given specifications. For the power signal, the components used will need to be able to handle the 48V DC therefore capacitors, inductors, and resistors with voltage ratings of 100V should be used to safely cover the range. To pass this DC signal, a strict low-pass filter with a higher value inductor will be used to prevent any high frequency RF signals from leaking through. The power signal also has the requirement of having less than 30V of ripple voltage. Along with the low-pass filter, a capacitor will be used connected between the output power and ground to reduce the ripple below the 30 mV cutoff.[3]

To combine to the DC power signal, a capacitor will be used to high-pass filter the two RF signals, preventing the DC signal from influencing them. However, before combining with the DC signal, the clock and communications signals must first be combined through their own low-pass and high-pass filters. A 3rd order Butterworth filter will be used which involves two capacitors in series and a shunt inductor for high-pass and two inductors in series with a shunt capacitor for low-pass.[4] The low-pass filter will pass the lower frequency 5V 200kHz communications signal, and the high-pass filter will pass the higher frequency 100mV 2.5MHz clock signal. Due to the large difference in amplitude, s band-stop filter, inductor and capacitor in series, will be connected between the clock signal and ground external from the other filters to completely block the communications signal from leaking into the clock as shown earlier.[5]

The entirety of the filtering will be mirrored from one bias tee to the other allowing for clean two way travel of communication signals. Also, all inductors and capacitors will have their parasitic elements incorporated in any simulations. The use of precise filtering will also help limit EMI.

## Interface with Other Subsystems

Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted. 

The Bias Tee subsystem directly interfaces with the Clock Generation & Jitter Measurement subsystem, the Cable subsystem, and the Communications subsystem and indirectly interfaces with the IC Power subsystem.

### Clock Generation & Jitter Measurement

The Bias Tee subsystem interacts with the Clock Generation & Jitter Measurement by delivering the decoupled, filtered clock signal to be conditioned for the jitter cleaning clock synthesizer. The clock signal must have a 2.5MHz signal that is as perceivably smooth when delivered to this subsystem.

### Cable

The Bias Tee subsystem interacts with the Cable subsystem by delivering and receiving the combined signal. The first bias tee combines the three signals then feeds this combined 

### Communications



### IC Power



## Buildable Schematic 

Integrate a buildable electrical schematic directly into the document. If the diagram is unreadable or improperly scaled, the supervisor will deny approval. Divide the diagram into sections if the text and components seem too small.

The schematic should be relevant to the design and provide ample details necessary for constructing the model. It must be comprehensive so that someone, with no prior knowledge of the design, can easily understand it. Each related component's value and measurement should be clearly mentioned.

<img width="825" height="383" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Bias_Tee/Documentation/Bias_Tee_Images/Bias%20Tee%20First%20Version.png"/>


## Printed Circuit Board Layout

Individual PCBs for each subsystem cannot be created for this design because the board used will include every subsystem which will require the team to bring the completed design of every subsystem together. Therefore, the PCB will not be completed until after capstone 1.

## BOM

| Part | Description | Quantity |
|----|----|----|
| Capacitor |   |   |


## Analysis

Deliver a full and relevant analysis of the design demonstrating that it should meet the constraints and accomplish the intended function. This analysis should be comprehensive and well articulated for persuasiveness.

## References

[1] J. Kolb, "Combined Power and Signal Delivery: A 48-V Clock and Communication Link," unpublished, Siemens Healthineers, Dec. 2025.

[2] FesZ Electronics, “Bias Tee Basics (1/2),” YouTube, Jun. 07, 2025. https://www.youtube.com/watch?v=2nusy07ljPk&list=PLT84nve2j1g_s3Lu1JEki9eVB9_nb9qNf&index=2 (accessed Mar. 30, 2026).

[3] A. Grob, "Setting Standards: The IEC 60601 Series: Quick-Use Guide," Biomedical Instrumentation & Technology, vol. 54, (3), pp. 220-222, 2020. Available: https://ezproxy.tntech.edu/login?url=https://www.proquest.com/scholarly-journals/i-setting-standards-iec-60601-series-quick-use/docview/2414388374/se-2. DOI: https://doi.org/10.2345/0899-8205-54.3.220.

[4]“EE133 -Winter 2002 Cookbook Filter Guide Welcome to the Cookbook Filter Guide!” Available: https://web.stanford.edu/class/ee133/handouts/labs/EE133filterCookbook.pdf
‌
[5]“Electric Circuits II Frequency Selective Circuits (Filters) Bandstop Filters Lecture #39.” Available: https://faculty.kfupm.edu.sa/ee/malek/EE205/pdfslides-205/Lecture%2031_ee205.pdf
‌