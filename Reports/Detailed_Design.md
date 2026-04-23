# Detailed Design - Clock Generation & Jitter Measurement
<!--
This document delineates the objectives of a comprehensive system design. Upon reviewing this design, the reader should have a clear understanding of:

- How the specific subsystem integrates within the broader solution
- The constraints and specifications relevant to the subsystem
- The rationale behind each crucial design decision
- The procedure for constructing the solution


## General Requirements for the Document

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

*Note: These technical documentation elements are mandatory only when relevant to the particular subsystem.
-->

## Function of the Subsystem

<!--This segment should elucidate the role of the subsystem within the entire system, detailing its intended function, aligned with the conceptual design.
-->
The Clock Generation and Jitter Measurement subsystem is responsible for conditioning the reference clock with a frequency of 2.5 MHz, extracted from the 48V power line by the Bias-T subsystem, into a usable digital signal. The subsystem also generates a low jitter 25 MHz Low-Voltage Differential Signaling (LVDS) output clock utilizing the Skyworks Si5345B jitter cleaner/clock synthesizer via an internal Phase-Locked Loop (PLL)[1]. The subsystem allows for two types of jitter measurements to confirm reference clock integrity. The first measurements, cycle-to-cycle jitter, shall be taken directly from probing the 25 Mhz output signal of the Si5345B via oscilloscope and measuring time between consecutive rising edges of the clock. The second measurements, output clock jitter relative to reference clock, shall be taken in a similar fashion by comparing synchronized oscilloscope readings for the respective signals. The Si5345B chip shall ultimately utilize programmed onboard Non-Volatile Memory (NVM) that determines functionality of the chip and controls clock generation. However, a microcontroller shall be used during development to load registers for this chip manually via I2C due to a constraint of the chip allowing two total alloted NVM writes by the user [2]. A reset input and two additional outputs of the Si5345B, Interrupt and LoLb, shall be included during development for monitoring purposes. Interrupt is asserted when a change in the device is detected and LOLb (Loss of Lock) is asserted when phase locking is achieved. The Clock Generation and Jitter Measurement subsystem allows determination for the overall success of the ComCaP system to carry the reference clock over the 48 V power cable.
<!--
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
-->

## Specifications and Constraints

<!--This section should provide a list of constraints applicable to the subsystem, along with the rationale behind these limitations. For instance, constraints can stem from physics-based limitations or requirements, subsystem prerequisites, standards, ethical considerations, or socio-economic factors.

The team should set specifications for each subsystem. These specifications may require modifications, which must be authorized by the team. It could be necessary to impose additional constraints as further information becomes available.

Every subsystem must incorporate at least one constraint stemming from standards, ethics, or socio-economic factors.
-->

The Clock Generation and Jitter Measurement subsystem shall utilize the Skyworks Si5345B jitter cleaner as specified by Siemens Healthineers due to the ongoing utilization of the IC by the company. The subsystem shall ensure clock signal integrity by conditioning the reference clock signal provided by the Bias-T subsystem prior to reaching the Si5345B IC. The input to the IC shall meet slew rate requirements provided by the manufacturer in order to minimize jitter.

## Overview of Proposed Solution

<!--Describe the solution and how it will fulfill the specifications and constraints of this subsystem.-->

STM32G030K8T6 

## Interface with Other Subsystems
<!--
Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted.-->
The Clock Generation and Jitter Measurement subsystem 


## Buildable Schematic 

<!--Integrate a buildable electrical schematic directly into the document. If the diagram is unreadable or improperly scaled, the supervisor will deny approval. Divide the diagram into sections if the text and components seem too small.

The schematic should be relevant to the design and provide ample details necessary for constructing the model. It must be comprehensive so that someone, with no prior knowledge of the design, can easily understand it. Each related component's value and measurement should be clearly mentioned.-->

<!--<img width="" height="" alt="" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/.png" />-->
<img width="1045" height="820" alt="Signal Conditioning Circuit Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/SigCon(update2).png" />

<img width="1045" height="820" alt="Si5345B Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/Si5345B_config_2_4-23-26.png" />

<img width="1045" height="820" alt="Micro Control Unit Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Clock_and_Jitter/Documentation/Images/MCU(update2).png" />

## Printed Circuit Board Layout

<!--Include a manufacturable printed circuit board layout.-->


## Flowchart

<!--For sections including a software component, produce a chart that demonstrates the decision-making process of the microcontroller. It should provide an overview of the device's function without exhaustive detail.-->


## BOM

<!--Provide a comprehensive list of all necessary components along with their prices and the total cost of the subsystem. This information should be presented in a tabular format, complete with the manufacturer, part number, distributor, distributor part number, quantity, price, and purchasing website URL. If the component is included in your schematic diagram, ensure inclusion of the component name on the BOM (i.e R1, C45, U4).-->

## Analysis

<!--Deliver a full and relevant analysis of the design demonstrating that it should meet the constraints and accomplish the intended function. This analysis should be comprehensive and well articulated for persuasiveness.-->

## References
<!--
All sources that have contributed to the detailed design and are not considered common knowledge should be duly cited, incorporating multiple references.
-->
[1] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].

[2] Skyworks, "Any-frequency, Any-output Jitter-Attenuators/Clock Multipliers Si5345, Si5344, Si5342 Family Reference Manual," Si5345, Si5344, Si5342 Rev. D Family Reference Manual, July 2016 Revised [September 2018] https://www.skyworksinc.com/-/media/Skyworks/SL/documents/public/reference-manuals/Si5345-44-42-D-RM.pdf

[3] STMicroelectronics, "Arm® Cortex®-M0+ 32-bit MCU, up to 64 KB Flash, 8 KB RAM,  2x USART, timers, ADC, comm. I/Fs, 2.0-3.6 V," STM32G030x6/x8 Data Sheet, June 2019 Revised [June 2025].