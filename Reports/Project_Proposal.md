# ComCaP: Combined Clock and Power

## Introduction

Siemens Healthineers is a company that develops medical technologies, PET scanners being one of those technologies. Currently, their PET scanners incorporate separate cabling for the power and synchronization clock that are provided to the PET scanner, along with separate back channel communication. Siemens has requested for this team to consolidate these by feeding the clock and back channel communications through the power cabling.[3] This will reduce the volume of cables used as well as the number of points of failure decreasing overall system complexity. This proposal will cover the details of Siemens Healthineers' problem, the constraints and specifications they provided, already existing technology that could be used in the solution, what Siemens expects for the team to deliver, the resources required, the team members and stakeholders, and the potential implications of this new system.

## Formulating the Problem

Traditionally, PET scanners are made up rings of many detectors that need to be precisely synchronized. A separate piece of hardware is necessary to generate the clock and its own cabling to provide the clock to the detectors. Separate cabling is also needed for providing power to the detectors and back channel communication for trouble shooting. With the large number of detectors and the individual cabling for each of these, cabling complexity has become a problem especially with connections points being a common point of failure. The team's goal, set by Siemens, is to reduce complexity by running both the synchronization clock and back channel communications through the power cabling.[3] This solution will lead to a decrease in space usage by combining the different systems into one unit and greatly reduce the volume of cables used. This solution will also reduce the points of failure with the reduction of connection points. The primary challenges will be determining how the separate signals will be delivered and processed to stay within provided constraints and determining the best cables to support the transfer of these combined signals at the required power.

### Background

PET Scanners are complicated machines with many components. To start, a patient has a tracer that emits positrons injected into their body. Different tracers can work to image different organs. The patient is then placed on a gantry and moved into a detector ring. Positrons annihilate with electrons and produce two gamma rays approximately 180 degrees out of phase, so with proper timing and position, these detectors can use two detections and that 180 degree angle to triangulate the position of the coincidence events. A plot of these coincidence events will image the desired organs.

Their system for managing the clocks, power, and communications are all separate units within the coincidence processing unit. This takes up a lot of space and has many points of failure, since all three need their own cabling. Our proposed solution involves combining as many of these as we can in order to provide for a more efficient scanner. 

## Specifications

The ComCaP system shall meet the following specifications outlined by Siemens Healthineers [3]:

### Bias-Tee: Primary Focus

The system shall utilize two Bias-Tee circuits, used for both coupling and decoupling the AC information with DC power at the transmitter (TX) and receiver (RX) respectively.
- The line voltage shall be 48 V<sub>DC</sub>.
- The system shall be capable of supporting up to 100 W of power.
    - A switching power supply(s) shall be provided by Siemens Healthineers.
- The ripple voltage observed at the receiving unit (RX) shall have a soft maximum of 200 mV.
- The total ripple current after voltage DC-DC conversion shall not exceed ~ 30 mV.
- External connections for the system are unrestricted, however the following are suggested:
    - Clock input/output: SMA (SubMiniature version A) connectors.
    - A dedicated header for GUI connection.

### Synchronization Path: Secondary Focus

- The system shall utilize a reference clock with a frequency of 2.5 MHz that is currently used by Siemens Healthineers.
    - Bandpass filtering for reference clock recovery shall be fixed at 2.5 MHz, with no requirement for tuneable filtering.
- The receiver (RX) shall be equipped with a Skyworks model Si5345B PLL (Phase Lock Loop) for jitter attenuation, currently used by Siemens Healthineers.
    - Jitter measurement shall be high-fidelity.
- A 25 MHz output clock shall be synthesized via PLL for the following jitter measurements:
    - Cycle-to-Cycle
    - Output clock relative to reference clock

### Back-Channel Communications Path: Tertiary Focus (Time Permitting)

The system may incorporate back-channel communications to assist with debugging and troubleshooting.
- There is no definite required baud rate for communications, however the suggested range is 500 kbps to 1 Mbps.
- There is no definite requirement for the type of modulation used, however FSK (Frequency-Shift Keying) is recommended.
- There is no definite requirement for modulation hardware, however a PLC (Power Line Communication) modem similar to the ST7540 model [5] is recommended for the following reasons:
    - This modem allows easy interfacing into a microcontroller via UART or SPI interfacing.
    - This modem provides bi-directional (half-duplex) capabilities.
- Siemens Healthineers expresses extensive freedom for the implementation of back-channel communications.

### Analysis & Simulations

Files for measurements obtained via analysis and simulations shall be provided to Siemens Healthineers for the following:
- Bias-Tee and Line Interface Simulations
    - AC insertion loss
    - Behavior under load transients
    - Ripple and noise analysis of filtered DC output
- Filtering and Signal-Integrity
    - 2.5 Mhz reference transport
    - Optional 1 Mhz back-channel carrier path

### Additional Specifications

- The size of the ComCaP system shall not be constricted.
- PCB design files for the Transmitter (TX) and Receiver (RX) systems shall be provided to Siemens Healthineers for manufacturing.

## Constraints

### Industrial Standards and Regulations

An outline of standards and regulations pertaining to the project shall be provided to the team by Siemens Healthineers.

### EMI (Electromagnetic Interference)

EMI shall be an optional consideration in the design of the ComCaP system. Siemens Healthineers shall make modifications with the project in order to maintaince compliance with EMI standards.

## Survey of Existing Solutions

Solutions to this problems exist in many forms. 

Siemens already has an existing solution to this problem that we are iterating upon. Their solution is to send separate power and signal lines, which takes up more physical space in the Coincidence Processing Unit and has more points of failure. This solution does function for the needs of Siemens, but it takes up more space and has more points of failure than our proposed solution [3].

An existing solution is Power over Ethernet. Ethernet has a limited number of lanes since it needs to be backwards compatible, so it runs power and signal over the same lanes [4]. While this transfers both Data and Communication, it cannot transmit a clock signal, so our solution cannot be replaced by PoE.

Bias Tee modules do exist and could be used, but will not be custom made for the specific frequencies that Siemens will be using in their scanners. In addition to that, any medical machinery requires utmost precision, and a custom-built solution is necessary in this situation. 

<mentionSpecificSolutions>

The Jitter cleaning will mostly be done in the Si5345B chip, so no solutions exist for this focus as we would need a custom solution to be compatible with that IC.

For the back channel communications, we will likely use a pre-existing protocol for digital communication and fit it to our current solution. Like the second focus, this would be a custom solution to make it compatible with the apparatus.

<products>
<CiteSources>

## Measures of Success

Siemens will be measuring the success of this project by the completion of the three focuses that have been provided, the first two focuses being required completions while the third is an extra stretch goal to be approached once the first two are complete. Each focus has its own measure of success determined by PCB designs and simulation analysis. While production of PCBs and physical testing of components is an option, the simulation results will be the primary measurement of functionality of the system determined by the specifications provided.

### Focus 1: Bias-T

For the primary focus, a Bias-T design will be created that will allow for the combining and separating of the power, clock, and potentially back channel communications. The circuit design, components selected, and simulations including a simulated reference clock will represent a completion of focus 1. The design must be cable of supplying the minimum power, operating with the correct voltage with minimal ripple, and providing the correct clock frequency to be successful.

### Focus 2: Reference Clock and Jitter Measurement

For the secondary focus, the path for the clock will be implemented. Simulations and designs will be used to determine the completion of focus 2. The simulations will look at the recovery of the reference clock after decoupling from power. This will require the usage of the given jitter cleaning clock synthesizer, ten times output for jitter measurement, cycle-to-cycle jitter measurement of clock output, and relative jitter measurements of output clock and reference clock all simulated at the correct frequencies to be successful.

### Focus 3: Back-Channel Communications

For the tertiary focus, the back channel communication path will be incorporated in to the design. Similar to the first two focuses, simulations and designs will be used for the measurement of success, However, there is no requirement of completion for overall project, and the focus itself has a large amount of freedom in approach and specifications. 

## Resources

This project will include primarily hardware components to implement the design: the Bias Tee circuits (Rx and Tx), the Si5345B Jitter-Cleaning Clock Synthesizer, various SMD components to support those circuits, the PCB, a power supply, and cables for the I/O. Additionally, LTSpice will be used primarily for simulation files to deliver to the customer.

#### Hardware Components

1. Bias Tee Circuitry: Specific Capacitors, Inductors, and Resistors will need to be selected to create the bias tee with certain characteristics to operate at ideal functionality.
2. Jitter Cleaning Clock Synthesizer: Si5345B. This chip is used for generating a reference clock. This chip was selected by the customer for its ability to maintain a clean signal and reduce jitter [2].
3. PCB: Two boards will be designed and laid out. One board shall be in charge of producing the clock signal and biasing it to be fed over a cable to the receiver. The other board shall function as the test board to check the jitter measurements and ensure that the design falls within the specifications outlined by the customer.
4. Power Supply: Provides power to the board which will then be stepped down to power the the various components and then sent over the cable from the transmitter to the receiver. Power supply will be provided by the customer.
5. Cables: Cables will be procured or fabricated to carry the power and signal from the transmitter to the receiver. Present options for the cable are Ethernet or Coaxial cables.

### Budget
<!-- This chart will likely change over time as the project progresses, as the exact materials needed is not certain yet -->
Estimate of the cost for major materials needed:

| Item                        | Description / Notes                        | Quantity | Approx. Cost per unit (USD) |
|-----------------------------|--------------------------------------------|----------|-----------------------------|
| Si5345B Clock Synth         | Generates and cleans clock signal          | 2        | $34.46                      |
| Cables                      | Cables for I/O                             | 3        | $20–$30                     |
| Main PCB                    | Generates clock and regulates power        | 1        | $20-$30                     |
| Jitter Measurement PCB      | Measures jitter and analyzes power signal  | 1        | $20-$30                     |
| Passive SMD Components      | Various components for circuits on PCBs    | 1 set    | $40-$50                     |
| Cable Ports                 | Ports for the cabling I/O on the PCB       | 2        | $5-$10                      |
| FSK Power Line Transceiver  | Transceiver for FSK Functionality          | 1        | $5-$10                      |
| Prototyping Cost            | Extra material, spares, test components    |          | $150                        |

### Personnel

#### Required Skills

- **Hardware and Circuit Design:** Circuit design knowledge, Power Systems, Cable Design, PCB Design, Component Sourcing
- **Design and Simulations Tools:** LTspice, Matlab, Altium, LT Powercad
- **Theory and Analysis:** Signal Processing and Filtering, Power Systems

#### Team Skills

**Levi Cantrell**  

- *Current Skills:* LTSpice, VHDL, Hardware Analysis and Troubleshooting, Hand Soldering (Rework/Repair), Microcontrollers
- *Skills to Learn:* Altium,  Signal Processing

**Tyler Chan**  

- *Current Skills:* PCB Design, Component Sourcing, LTspice, Python, Matlab, VHDL, SystemVerilog
- *Skills to Learn:* Circuit Design Knowledge, Altium

**Jonas Cross**  

- *Current Skills:* Analog and Digital Telecommunications, Computer Design, LTSpice, Python, Matlab, C, VHDL, Soldering (SMD and THT),
- *Skills to Learn:* DSP, Transmission Lines, Altium, Power

**Harry Rudd**  

- *Current Skills:* LTSpice, MATLAB, Python
- *Skills to Learn:* Cable Design, Signal Processing and Filtering, Power Systems

**Ryan Shipwash**

- *Current Skills:* LTspice, Signal Processing, C/C++, Matlab, Circuit Design
- *Skills to Learn:* Altium, PCB Design

*Note:* This list emphasizes the members' strongest skills. Depending on the progress and project, required skills or assignments may change.

During the conceptual design phase, group members will determine further what to focus on. Each group member is primarily responsible for their expertise when working on their part of the project. If assistance is needed, the group member may seek advice from the supervisor, technical expert consultant, another group member, or external resource.

#### Supervisor

- **Dr. Charles Van Neste:** He was chosen because he has expertise in some signal processing and hardware aspects of the project.

#### Instructor

- **Dr. Christopher Storm Johnson:** He will provide guidance as needed when the team goes to him for help. He will also approve of various aspects of the project as they progress.

#### Technical Expert Consultant

- **Dr. Jeffrey Austen** He was chosen because he is knowledgeable in signal processing and has experience and guidance to provide, particularly in resources and general direction for the project.

#### Customer

- **Siemens Healthineers**

### Timeline

#### Gantt Chart (The chart may be subject to modification during project progression)

<img width="1324" height="321" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Project_Proposal/images/Capstone_1_Team_3_Gantt_Chart.png" />

## Specific Implications

By developing a ComCaP system, this project aims to address the challenges associated with having multiple systems for clock, power, and communication. Those challenges include size constraints as well as simplifying the previous design to include only one cable connecting the PET system to the clock and power supply. Outlined below are the benefits for Siemens Healthineers. The project has value in simplifying and minimizing the size of Siemens Healthineers' existing solution for their PET system as well as removing common points of error.

1. Minimizing Size:

Combining the clock and power into one system minimizes the space needed for those components. Instead of needing two boxes for clock and power individually, the combination will fit in a single box. In a medical environment minimizing space is important as every bit of space saved gives medical professionals more space to use for other things. For our customer, the space saved can help them more effectively sell their PET system. Tangibly, as stated above, the solution will condense two systems into one. This is worthwhile because space is a great concern in the medical field, and lessening space restrictions can improve the efficiency of the space in the hospital or clinic that is using Siemens Healthineers' PET system.

2. Simplifying the Existing Solution:

The ComCaP system also simplifies the overall PET system by reducing the total number of subsystems. This means removing the extra components required for both a clock and power to be sent to the PET system, and combining it into one box. Tangibly, this means less materials to manufacture and maintain. This also means less cabling to and from subsystems. This is worthwhile to Siemens Healthineers, because it is potentially cheaper. There will be less cabling and hardware to manufacture, and Siemens Healthineers will not have to spend as much time troubleshooting PET Systems.

3. Removing Common Points of Error:

A common point of error in the PET system are the connections on the cables themselves. By combining the clock and power onto one cable, the number of connections needed are cut in half. Tangibly, this is self explanatory. Less connections means less points of failure and, in the event of a failure, less connections to test. This is worthwhile because it simultaneously reduces the number of places a cable failure can take place and it reduces the time it takes to narrow down where that failure is. This lets a technician fix it in a more timely manner, and reduces the overall downtime of the machine when it fails.

Overall, this solution streamlines Siemens Healthineers' existing product without sacrificing any of its existing functionality. It's worthiness lies in its ability to reduce the space required, simplify two separate subsystems into one, and remove common points of error. This senior design projects improves real-world medical equipment, and brings a sleek innovation to an existing product.

## Broader Implications, Ethics, and Responsibility as Engineers

Our project is tailor made for Siemens Healthineers and their proprietary PET system, however that does not entirely mean that there are not broader impacts that the ComCaP solution will have. While the ComCaP is not going to come into contact with any patients or the general public, the team is still designing it for use in the medical field. Therefore, the solution will have an impact on public health. There will also need to be special care taken, due to the impact that this will have on the medical well being of the patients using the PET machine. This section will discuss those impacts in greater detail as well as discussing the general ethical responsibilities the team will face in this project.

1. Public Health Impacts

The ComCaP device will impact both doctors and patients. For doctors, the device will be smaller than Siemens Healthineers' existing solution, providing more space for them to use for other medical equipment or devices. For patients, the device will make the PET system more reliable. This will decrease both the number of times the PET system will be down, and decrease the amount of time it takes for the PET system to return back online. Because of that, the PET system can be used more often, and will help diagnose more people with medical conditions. The benefits to both doctors and patients will hopefully lead to more diagnoses and save more lives.

2. Considerations for the Medical Field:

Per Siemens Healthineers, this project will not need to follow any specific codes or regulations for the medical field. However, extra care must be taken, as this project is an integral part of life saving medical equipment. As engineers, the team must take into account the implications of the product failing. In this case, if the project fails, that means that there will be more downtime on life saving medical equipment which could lead to a delay medical emergencies being detected. In extreme cases, that extra time could be the difference in life or death. The team can't expect the system to be without failure, but the team will need to take extra care and consideration in the reliability of the product. Even though it does not come into direct contact with patients, the consequences of failing will still impact them.

3. Ethical Responsibilities:

As engineers, the team upholds values such as those outlined in the National Society of Professional Engineers (NSPE) code of ethics [1]. The team will emphasize the health and safety of the public and conduct itself in an honest matter. The team will use all of its gained knowledge and skills to produce the most effective product possible, without compromising the safety of others. The team will be truthful in all of the things that it does, even if that means failure of the project. An unsuccessful product is much better than an unsafe one. The team will be transparent in all its actions, as an NDA was not signed. The team will meticulously document everything it does, so the customer can build upon the solution after the team is removed from the project.

In summary, this project has the ability to greatly improve the care provided to patients and improve the lives of doctors performing their duties. By bearing in mind the severity of the team's work and conducting itself in an ethical manner, the team will fulfil its duty to create this project without any harm or deception.

## References

[1] “NSPE code of Ethics for Engineers: National Society of Professional Engineers,” NSPE Code of Ethics for Engineers | National Society of Professional Engineers, https://www.nspe.org/career-growth/nspe-code-ethics-engineers (accessed Feb. 22, 2026).

[2] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].

[3] J. Kolb, "Combined Power and Signal Delivery: A 48-V Clock and Communication Link," unpublished, Siemens Healthineers, Dec. 2025.

[4] "IEEE Standard for Ethernet," in IEEE Std 802.3-2022 (Revision of IEEE Std 802.3-2018) , vol., no., pp.1-7025, 29 July 2022, doi: 10.1109/IEEESTD.2022.9844436.

[5] STMicroelectronics, "FSK power line transceiver," ST7540 Data Sheet, 15 Mar 2006 Revised [25 Sep 2006].

## Statement of Contributions

Levi Cantrell - Specifications, Constraints

Tyler Chan - Resources, Budget, Personnel

Jonas Cross - [Add contributions]

Harry Rudd - Specific Implications, Broader Implications

Ryan Shipwash - Introduction, Formulating the Problem, Measures of Success

All - Proofreading and Editing