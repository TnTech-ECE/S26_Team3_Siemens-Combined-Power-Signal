# Project Proposal

This document provides a comprehensive explanation of what a project proposal should encompass. The content here is detailed and is intended to highlight the guiding principles rather than merely listing expectations. The sections that follow contain all the necessary information to understand the requirements for creating a project proposal.


## General Requirements for the Document
- All submissions must be composed in markdown format.
- All sources must be cited unless the information is common knowledge for the target audience.
- The document must be written in third person.
- The document must identify all stakeholders including the instuctor, supervisor, and customer.
- The problem must be clearly defined using "shall" statements.
- Existing solutions or technologies that enable novel solutions must be identified.
- Success criteria must be explicitly stated.
- An estimate of required skills, costs, and time to implement the solution must be provided.
- The document must explain how the customer will benefit from the solution.
- Broader implications, including ethical considerations and responsibilities as engineers, must be explored.
- A list of references must be included.
- A statement detailing the contributions of each team member must be provided.


## Introduction

The introduction must be the opening section of the proposal. It acts as the "elevator pitch" of the project, briefly introducing the objective, its importance, and the proposed solution. Because readers may only read this section, it should effectively capture their attention and encourage them to read further.

Toward the end of the introduction, include a subsection that outlines what the proposal will cover. This helps set reader expectations for the ensuing sections.

Siemens Healthineers is a company that develops medical technologies. PET scanners are one of the technologies they develop. Currently, their PET scanners incorporate separate cabling for the power and synchronization clock that are provided to the PET scanner, along with separate back channel communication. Siemens has requested for this team to consolidate these by feeding the clock and back channel communications through the power cabling. This will reduce the volume of cables used as well as the number of points of failure decreasing overall system complexity. This proposal will cover the details of Siemens Healthineers' problem, the constraints and specifications they provided, already existing technology that could be used in the solution, what Siemens expects for the team to deliver, the resources required, the team members and stakeholders, and the potential implications of this new system.

## Formulating the Problem

Formulating the problem or objective involves clearly defining it through background information, specifications, and constraints. Think of it as "fencing in" the objective to make it unambiguously clear what is and is not being addressed and why.

Questions to consider:
- Who does the problem affect (i.e. who is your customer)?
- Why do we need this solution?
- What challenges necessitate a dedicated, multi-person engineering team?
- Why aren’t off-the-shelf solutions sufficient?

Traditionally, PET scanners are made up rings of many detectors that need to be precisely synchronized. A separate piece of hardware is necessary to generate the clock and its own cabling to provide the clock to the detectors. Separate cabling is also needed for providing power to the detectors and back channel communication for trouble shooting. With the large number of detectors and the individual cabling for each of these, cabling complexity has become a problem especially with connections points being a common point of failure. The team's goal, set by Siemens, is to reduce complexity by running both the synchronization clock and back channel communications through the power cabling. This solution will lead to a decrease in space usage by combining the different systems into one unit and greatly reduce the volume of cables used. This solution will also reduce the points of failure with the reduction of connection points. The primary challenges will be determining how the separate signals will be delivered and processed to stay within provided constraints and determining the best cables to support the transfer of these combined signals at the required power.

### Background

Provide context and details necessary to define the problem clearly and delineate its boundaries.

### Specifications and Constraints

Specifications and constraints define the system's requirements. They can be positive (do this) or negative (don't do that). They can be mandatory (shall or must) or optional (may). They can cover performance, accuracy, interfaces, or limitations. Regardless of their origin, they must be unambiguous and impose measurable requirements.

### Specifications

Specifications are requirements imposed by **stakeholders** to meet their needs. If a specification seems unattainable, it is necessary to discuss and negotiate with the stakeholders.

The ComCap system shall meet the following specifications outlined by Siemens Healthineers:

#### Bias-Tee: Primary Focus

The system shall utelize two Bias-Tee circuits, used for both coupling and decoupling the AC information with DC power at the transmitter (TX) and receiver (RX) respectively.
- The line voltage shall be 48 V DC. (subscripting in markdown?)
- The system shall be capable of supporting up to 100 W of power.
    - A switching power supply(s) shall be provided by Siemens Healthineers.
- The ripple voltage observed at the receiving unit (RX) shall a soft maximum of 200 mV.
- The total ripple current after current DC-DC conversion shall not exceed ~ 30 mV.
- External connections for the system are unrestricted, however the following are suggested:
    - Clock input/output: SMA (SubMiniature version A) connectors.
    - A dedicated header for GUI connection.

#### Synchronization Path: Secondary Focus

- The system shall utelize a reference clock with a frequency of 2.5 MHz that is currently used by Siemens Healthineers.
    - Bandpass filtering for reference clock recovery shall be fixed at 2.5 MHz, with no requirement for tuneable filtering.
- The receiver (RX) shall be equiped with a Silicon Labs PLL (Si5345B) for jitter attenuation, currently used by Siemens Healthineers.
    - Jitter measurement shall be high-fidelity (> 1 ps?).
- A 25 MHz output clock shall be synthesized via PLL for the following jitter measurements:
    - Cycle-to-Cycle
    - Output clock relative to reference clock

#### Back-Channel Communications Path: Tertiary Focus (Time Permitting)

The system may incorperate back-channel communications to assist with debugging, troubleshooting, and lower-level system synchronization messages. (???)
- There is no definite required buad rate for communications, however the suggested range is 500 kbps to 1 Mbps.
- There is no definite requirement for the type of modulation used, however FSK (Frequency-Shift Keying) is recommended.
- There is no definite requirement for modulation hardware, however a PLC (Power Line Communitcation) modem similar to the ST7540 model is recommended for the following reasons:
    - This modem allows easy interfacing into a microcontroler via UART or SPI interfacing.
    - This modem provides bi-directional (half-duplex) capabilities.
- Siemens Healthineers expresses extensive freedom for the implementation of back-channel communications.

#### Analysis & Simulations

Files for measurements obtained via analysis and simulations shall be provided to Seimens Healthineers for the following:
- Bias-Tee and Line Interface Simulations
    - AC insertion loss
    - Behavior under load transients
    - Ripple and noise analysis of filtered DC output
- Filtering and Signal-Integrity (via LTSpice)
    - 2.5 Mhz reference transport
    - Optional 1 Mhz back-channel carrier path

#### Additional Specifications

- The size of the ComCap system shall not be constricted, however ... (fill in?)
- PCB design files for the Transmitter (TX) and Receiver (RX) systems shall be provided to Siemens Healthineers for manufacturing.


### Constraints

Constraints often stem from governing bodies, standards organizations, and broader considerations beyond the requirements set by stakeholders.

Questions to consider:
- Do governing bodies regulate the solution in any way?
- Are there industrial standards that need to be considered and followed?
- What impact will the engineering, manufacturing, or final product have on public health, safety, and welfare?
- Are there global, cultural, social, environmental, or economic factors that must be considered?

#### Industrial Standards and Regulations

An outline of standards and regulations pertaining to the project shall be provided to the team by Siemens Healthineers.

#### EMC (Electromagnetic Compatibility)

Electromagnetic Interference shall be an optional consideration in the design of the ComCap system.

## Survey of Existing Solutions

Research existing solutions, whether in literature, on the market, or within the industry. Present these findings in a coherent, organized manner. Remember to cite all information that is not common knowledge.


## Measures of Success

Define how the project’s success will be measured. This involves explaining the experiments and methodologies to verify that the system meets its specifications and constraints.

Siemens will be measuring the success of this project by the completion of the three focuses that have been provided, the first two focuses being required completions while the third is an extra stretch gaol to be approached once the first two are complete. Each focus has its own measure of success determined by PCB designs and simulation analysis. While production of PCBs and physical testing of components is an option, the simulation results will be the primary measurement of functionality of the system.

### Focus 1: Bias-T

For the primary focus, a Bias-T design will be created that will allow for the combining and separating of the power, clock, and potentially back channel communications. The circuit design, components selected, and simulations including a simulated reference clock will represent a completion of focus 1. The design must be cable of supplying the minimum power, operating with the correct voltage with minimal ripple, and providing the correct clock frequency to be successful.

### Focus 2: Reference Clock and Jitter Measurement

For the secondary focus, the path for the clock will be implemented. Simulations and designs will be used to determine the completion of focus 2. The simulations will look at the recovery of the reference clock after decoupling from power. This will require the usage of the given jitter cleaning clock synthesizer, ten times output for jitter measurement, cycle-to-cycle jitter measurement of clock output, and relative jitter measurements of output clock and reference clock all simulated at the correct frequencies to be successful.

### Focus 3: Back-Channel Communications

For the tertiary focus, the back channel communication path will be incorporated in to the design. Similar to the first two focuses, simulations and designs will be used for the measurement of success, However, there is no requirement of completion for overall project, and the focus itself has a large amount of freedom in approach and specifications. 

## Resources

This project will include primarily hardware components to implement the design: a Bias Tee circuit, the Si5345B Jitter-Cleaning Clock Synthesizer, various SMD components to support those circuits, the PCB, a power supply, and cables for the I/O. Additionally, LTSpice will be used primarily for simulation files to deliver to the customer.

#### Hardware Components

1. Capacitors an Inductors: Specific Capacitors and Inductors will need to be selected to create the bias tee with certain characteristics to operate at ideal functionality.
2. Jitter Cleaning Clock Synthesizer: Si5345B. This chip is used for generating a clock that will be passed over the cable with the power signal. This chip was selected for its ability to maintain a clean signal and reduce jitter [2].
3. PCB: Two boards will be designed and laid out. One board shall be in charge of producing the clock signal and biasing it to be fed over a cable to the receiver. The other board shall function as the test board to check the jitter measurements and ensure that the design falls within the specifications outlined by the customer.
4. Power Supply: Provides power to the board which will then be stepped down to power the the various components and then sent over the cable from the transmitter to the receiver. Power supply will be provided by the customer.
5. Cables: Cables will be procured or fabricated to carry the power and signal from the transmitter to the receiver. Present options for the cable are Ethernet or Coaxial cables.

### Budget
<!-- This chart will likely change over time as the project progresses, as the exact materials needed is not certain yet -->
Estimate of the cost for major materials needed:

| Item                      | Description / Notes                        | Quantity | Approx. Cost per unit (USD) |
|---------------------------|--------------------------------------------|----------|-----------------------------|
| Si53245B Clock Synth      | Generates and cleans clock signal          | 2        | $34.46                      |
| Cables                    | Cables for I/O                             | 3        | $20–$30                     |
| Main PCB                  | Generates clock and regulates power        | 1        | $20-$30                     |
| Jitter Measurement PCB    | Measures jitter and analyzes power signal  | 1        | $20-$30                     |
| Passive SMD Components    | Various components for circuits on PCBs    | 1 set    | $40-$50                     |
| Prototyping Cost          | Extra material, spares, test components    |          | $150                        |

### Personnel

#### Required Skills
- **Hardware and Circuit Design:** Circuit design knowledge, Power Systems, Cable Design, PCB Design, Component Sourcing
- **Design and Simulations Tools:** LTspice, Matlab, Altium, LT Powercad
- **Theory and Analysis:** Signal Processing and Filtering, Power Systems

#### Team Skills

**Levi Cantrell**  
- *Current Skills:* [Add Skills Here]
- *Skills to Learn:* [Add Skills Here]

**Tyler Chan**  
- *Current Skills:* PCB Design, Component Sourcing, LTspice, Python, Matlab
- *Skills to Learn:* Circuit Design Knowledge, Altium

**Jonas Cross**  
- *Current Skills:* [Add Skills Here]
- *Skills to Learn:* [Add Skills Here]

**Harry Rudd**  
- *Current Skills:* [Add Skills Here]
- *Skills to Learn:* [Add Skills Here]

**Ryan Shipwash**  
- *Current Skills:* [Add Skills Here]
- *Skills to Learn:* [Add Skills Here]

*Note:* This list emphasizes the members' strongest skills. Depending on the progress and project, required skills or assignments may change.

During the conceptual design phase, group members will determine further what to focus on. Each group member is primarily responsible for their expertise when working on their part of the project. If assistance is needed, the group member may seek advice from the supervisor, technical expert consultant, another group member, or external resource.

#### Supervisor
- **Professor Van Neste:** He was chosen because he has expertise in some signal processing and hardware aspects of the project.

#### Instructor
- **Professor Storm:** He will provide guidance as needed when the team goes to him for help. He will also approve of various aspects of the project as they progress.

#### Technical Expert Consultant
- **Dr. Jeffrey Austen** He was chosen because he is knowledgeable in signal processing and has experience and guidance to provide, particularly in resources and general direction for the project.

#### Customer
- **Siemens Healthineers**

### Timeline

#### Gantt Chart (The chart may be subject to modification during project progression)
<img width="1324" height="321" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Project_Proposal/images/Capstone_1_Team_3_Gantt_Chart.png" />

## Specific Implications

By developing a combined clock and power module, this project aims to address the challenges associated with having multiple modules for clock, power, and communication. Those challenges include size constraints as well as simplifying the previous design to include only one cable connecting the PET (Positron Emission Tomography) system to the clock and power supply. Outlined below are the benefits for Siemens (our customer). The project has value in simplifying and minimizing the size of Siemens' existing solution for their PET system as well as removing common points of error.

1. Minimizing Size:

Combining the clock and power into one module minimizes the space needed for those components. Instead of needing two boxes for clock and power individually, the combination will fit in a single box. In a medical environment minimizing space is important as every bit of space saved gives medical professionals more space to use for other things. For our customer, the space saved can help them more effectively sell their PET system. Tangibly, as stated above, the solution will condense two systems into one. This will greatly decrease the space needed for clock and power in the final product. This is worthwhile because space is a great concern in the medical field, and lessening space restrictions can improve the efficiency of the space in the hospital or clinic that is using Siemens' PET system.

2. Simplifying the Existing Solution:

Combining the clock and power systems also simplifies the overall PET system by reducing the total number of subsystems. This means removing the extra components required for both a clock and power to be sent to the PET system, and combining it into one box. Tangibly, this means less materials to manufacture and maintain. This also means less cabling to and from subsystems. This is worthwhile to Siemens, because it is potentially cheaper. There will be less cabling and hardware to manufacture, and Siemens will not have to spend as much time troubleshooting PET Systems.

3. Removing Common Points of Error:

A common point of error in the PET system are the connections on the cables themselves. By combining the clock and power onto one cable, the number of connections needed are cut in half. Tangibly, this is self explanatory. Less connections means less points of failure and, in the event of a failure, less connections to test. This is worthwhile because it simultaneously reduces the number of places a cable failure can take place and it reduces the time it takes to narrow down where that failure is. Thus, letting a technician fix it in a more timely manner, and reducing the overall downtime of the machine when it fails.

Overall, this solution streamlines Siemens' existing product without sacrificing any of its existing functionality. It's worthiness lies in its ability to reduce the space required, simplify two separate subsystems into one, and remove common points of error. This senior design projects improves real-world medical equipment, and brings a sleek innovation to an existing product.

## Broader Implications, Ethics, and Responsibility as Engineers

Our project is tailor made for Siemens and their proprietary PET system, however that does not entirely mean that there are not broader impacts that our combined clock and power solution will have. While the combined clock and power is not going to come into contact with any patients or the general public, we are still designing it for use in the medical field. Therefore, our solution will have an impact on public health. There will also need to be special care taken, due to the impact that this will have on the medical well being of the patients using the PET machine. This section will discuss those impacts in greater detail as well as discussing the general ethical responsibilities we will face in this project.

1. Public Health Impacts

2. Considerations for the Medical Field:

Per Siemens, this project will not need to follow any specific codes or regulations for the medical field. 

3. Ethical Responsibilities:


## References

[1] "RF/Microwave Bias Tees from Theory to Practice," *blog.minicircuits.com*, July 31, 2023. [Online]. Available: https://blog.minicircuits.com/rf-microwave-bias-tee-basics/. [Accessed Feb. 12, 2026].

[2] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].


## Statement of Contributions

Each team member must contribute meaningfully to the project proposal. In this section, each team member is required to document their individual contributions to the report. One team member may not record another member's contributions on their behalf. By submitting, the team certifies that each member's statement of contributions is accurate.
