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

<!--This section should provide a list of constraints applicable to the subsystem, along with the rationale behind these limitations. For instance, constraints can stem from physics-based limitations or requirements, subsystem prerequisites, standards, ethical considerations, or socio-economic factors.

The team should set specifications for each subsystem. These specifications may require modifications, which must be authorized by the team. It could be necessary to impose additional constraints as further information becomes available.

Every subsystem must incorporate at least one constraint stemming from standards, ethics, or socio-economic factors.-->

### Customer Specifications:

As specified by Siemens Healthineers, the Bias Tee shall receive and operate with a line voltage of 48V DC. With that 48 V DC, the Bias Tee shall be capable of supporting and supplying 100 watts of power requiring parts to sustain a current of 2A. The Bias Tee shall produce the power signal with a ripple voltage of less than 30mV using proper filter to minimize drops and rises after decoupling. The Bias Tee shall receive and produce a clock signal at 2.5 MHz after coupling and decoupling. The Bias Tee shall have a two function to allow for back channel communications to be able to communicate with and trouble shoot the external system.[1]

- Shall operate with a line voltage of 48V DC
- Shall supply up to 100 watts of power
- Shall produce a ripple voltage of less than 30mV 
- Shall produce a clock signal at 2.5 MHz
- Shall allow for two way back channel communications

### Component Constraints

The Bias Tee shall prevent AC leakage onto the DC power source and between the two RF signals to any perceivable degree by considering how the low-pass and high-pass filters can be adjusted to cutoff different frequencies from undesired paths. The Bias Tee shall account for parasitic inductance in capacitors and parasitic capacitance in inductors in the filtering to keep signals clean before being delivered to other subsystems. The Bias Tee shall use resistors to account for the characteristic impedance preventing reflections in cabling.[2]



## Overview of Proposed Solution

Describe the solution and how it will fulfill the specifications and constraints of this subsystem.


## Interface with Other Subsystems

Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted.


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