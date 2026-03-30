# Conceptual Design

This document outlines the objectives of a conceptual design. After reading your conceptual design, the reader should understand:

- The fully formulated problem.
- The fully decomposed conceptual solution.
- Specifications for each of the atomic pieces of the solution.
- Any additional constraints and their origins.
- How the team will accomplish their goals given the available resources.

With these guidelines, each team is expected to create a suitable document to achieve the intended objectives and effectively inform their stakeholders.


## General Requirements for the Document
- Submissions must be composed in Markdown format. Submitting PDFs or Word documents is not permitted.
- All information that is not considered common knowledge among the audience must be properly cited.
- The document should be written in the third person.
- An introduction section should be included.
- The latest fully formulated problem must be clearly articulated using explicit "shall" statements.
- A comparative analysis of potential solutions must be performed
- The document must present a comprehensive, well-specified high-level solution.
- The solution must contain a hardware block diagram.
- The solution must contain an operational flowchart.
- For every atomic subsystem, a detailed functional description, inputs, outputs, and specifications must be provided.
- The document should include an acknowledgment of ethical, professional, and standards considerations, explaining the specific constraints imposed.
- The solution must include a refined estimate of the resources needed, including: costs, allocation of responsibilities for each subsystem, and a Gantt chart.


## Introduction

Siemens Healthineers is a company that develops medical technologies, PET scanners being one of those technologies. Currently, their PET scanners incorporate separate cabling for the power and synchronization clock that are provided to the PET scanner, along with separate back channel communication. Siemens has requested for this team to consolidate these by feeding the clock and back channel communications through the power cabling.[1] This will reduce the volume of cables used as well as the number of points of failure decreasing overall system complexity. This proposal will cover the details of Siemens Healthineers' problem, the constraints and specifications they provided, already existing technology that could be used in the solution, what Siemens expects for the team to deliver, the resources required, the team members and stakeholders, and the potential implications of this new system.

## Restating the Fully Formulated Problem

Traditionally, PET scanners are made up rings of many detectors that need to be precisely synchronized. A separate piece of hardware is necessary to generate the clock and its own cabling to provide the clock to the detectors. Separate cabling is also needed for providing power to the detectors and back channel communication for trouble shooting. With the large number of detectors and the individual cabling for each of these, cabling complexity has become a problem especially with connections points being a common point of failure. The team's goal, set by Siemens, is to reduce complexity by running both the synchronization clock and back channel communications through the power cabling.[1] This solution will lead to a decrease in space usage by combining the different systems into one unit and greatly reduce the volume of cables used. This solution will also reduce the points of failure with the reduction of connection points. The primary challenges will be determining how the separate signals will be delivered and processed to stay within provided constraints and determining the best cables to support the transfer of these combined signals at the required power.

### Specifications

- The system shall utilize two Bias-Tee circuits, used for both coupling and decoupling the AC information with DC power at the transmitter (TX) and receiver (RX) respectively.
- The line voltage shall be 48 V<sub>DC</sub>.
- The system shall be capable of supporting up to 100 W of power.
- The ripple voltage observed at the receiving unit (RX) shall have a soft maximum of 200 mV.
- The total ripple current after voltage DC-DC conversion shall not exceed ~ 30 mV.
- The system shall utilize a reference clock with a frequency of 2.5 MHz.
- Band-pass filtering for reference clock recovery shall be fixed at 2.5 MHz.
- The receiver (RX) shall be equipped with a Skyworks model Si5345B jitter attenuator.
- Jitter measurement shall be high-fidelity.
- A 25 MHz output clock shall be synthesized via PLL for jitter measurements.
- The system may incorporate back-channel communications to assist with debugging and troubleshooting.
- PCB design files for the Transmitter (TX) and Receiver (RX) systems shall be provided to Siemens Healthineers for manufacturing.

### Constraints

- 

## Comparative Analysis of Potential Solutions

In this section, various potential solutions are hypothesized, design considerations are discussed, and factors influencing the selection of a solution are outlined. The chosen solution is then identified with justifications for its selection.

### Bias Tee

The bias tee is the main approach to problem, being specifically required by the customer. A bias tee can combine or separate an RF and DC signal allowing the two signals to be transported on a single cable. Generally, an inductor is used to pass the DC signal, and a capacitor is used to pass the RF signal. <!--T-->

Another important aspect of the bias tee to consider is the filtering to ensure that the ac signal does not leak into the DC signal and create fluctuations in the voltage supplied. This can be done by including a bypass capacitor to ground from the DC source to remove some of the fluctuation. However, this can result in resonant frequencies that cause a drop in the impedance. The capacitor values can be shifted to change the point of resonance to a frequency that is not within the useful range. Additionally, a series resistor can be added in series to remove this drop. However, this would affect the DC component of the signal and consequently the power transferred. This results in the best option likely using a DC decoupling capacitor shifted where the resonance point is outside of the useful frequency range at 2.5 MHz.

An additional point to consider when selecting passive components, inductors and capacitors, is the parasitic qualities of each. Capacitors have inductance, and inductors have capacitance. Looking through basic simulations with parasitic capacitance on an inductor, at a high enough frequency, the impedance starts to decrease. For the parasitic inductance of capacitors, another resonance frequency will appear that will cause another impedance dip. The values of the capacitors and inductors will need to be chosen to place the resonance frequencies in a range where that will not affect the functionality of the bias tee regarding power and signal integrity. [66]

## High-Level Solution

To fulfill the goal of reducing complexity of the clock, power, and communication systems, each system needs to be atomically considered along with systems to integrate these together. Following the focuses of the problem introduction presentation from Siemens Healthineers [1], the most integral system for the solution is a bias tee to transmit the frequencies over the transmission line. This is the system that will have the atomized systems built upon it. The atomized systems are as follows:

- The power system takes power from outside and prepares it to be transmitted. The clock system
- The clock system generates a clock and transmits it on one end, and it receives and filters jitter on the other end. This system will have accessible measurement to measure the jitter.
- The communication system takes data input and packages it to be transmitted on one end, then unpackages and outputs the communications on the other end.  


### Hardware Block Diagram

<img width="1291" height="671" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Final%20Block%20Diagram.png"/>

#### Bias Tee

The bias tee is the primary focus of this project and what brings every other subsection together. The bias tee will use an inductor to pass the DC power and capacitors to pass the RF clock and communications on the input side allowing all three to travel on the single cable. Then the bias tee will separate the signals again using an inductor for the DC and capacitors for the RF clock and communications.

#### Power

The power will be provided to the system in the form of a 48 V DC signal. The power must also output the system as a 48 V DC signal with minimal deviance. This is not being considered as an assigned subsystem due to it's simplicity and the bias tee subsystem handling it. However, it is important to represent it in the block diagram.

#### Clock Generation & Jitter Measurement

The reference clock will also be provided to the system. It will enter and leave the system as a 2.5 MHz RF signal. For the output of the clock from the system, a jitter cleaning clock synthesizer is used (Si5345B). There will also be a second clock output from the system of the reference clock scaled to 25 MHz to measure the cycle-to-cycle jitter.

#### Communications

The back channel communications will also be provided to the system as a not yet specified frequency RF signal. The communications will be used to interact with the PET scanner. The communications will be able to be transmitted and received from both ends of the system feeding through the ST7580 chip. The team has freedom to approach this in many different ways, although this is considered a reach goal by the customer.

#### Cable

The cable will transport the combined signal produced by the bias tee. The cable will be up ten meters long and be capable of transporting both DC and RF. Currently, coaxial and twisted pair are being considered for the cable used.

### Operational Flow Chart

<img width="1307" height="448" alt="image" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Flow%20Chart%201.png" />

This system has minimal user input since it is an automatic system that receives inputs when the PET scanner is turned on. So, the user involvement for this system is simply turning on the system causing the power and reference clock to pass through the system and allowing for any back channel communications to pass. If the user decides to use the back channel communications, they will be sent through the open channel.


## Atomic Subsystem Specifications

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

### Bias Tee

The bias tee is the main approach to problem, being specifically required by the customer. A bias tee can combine or separate an RF and DC signal allowing the two signals to be transported on a single cable. Generally, an inductor is used to pass the DC signal, and a capacitor is used to pass the RF signal. For this design, a bias tee will be used to combine a DC power supply, RF clock signal and RF communications signal then send this combined signal across a cable to another bias tee that will be used to separate the three signals back out.

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

### Clock Generation & Jitter Measurement

The Clock Generation and Jitter Measurement subsystem is responsible for conditioning the reference clock frequency of 2.5 MHz, extracted from the high-voltage line by the Bias-T subsystem, into a usable digital signal. The subsystem also generates a low jitter 25 MHz Low-Voltage Differential Signaling (LVDS) output clock utilizing the Skyworks Si5345B jitter cleaner/clock synthesizer via an internal Phase-Locked Loop (PLL) [2]. The subsystem allows for two types of jitter measurements to confirm reference clock integrity. The first measurements, cycle-to-cycle jitter, shall be taken directly from probing the 25 Mhz output signal of the Si5345B via oscilloscope and measuring time between consecutive rising edges of the clock. The second measurements, output clock jitter relative to reference clock, shall be taken in a similar fashion by comparing synchronized oscilloscope readings for the respective signals. The Si5345B chip shall ultimately utilize programmed onboard Non-Volatile Memory (NVM) that determines functionality of the chip and controls clock generation. However, a microcontroller shall be used during development to load registers for this chip manually via I2C due to a constraint of the chip allowing two total alloted NVM writes by the user [3]. A reset input and two additional outputs of the Si5345B, Interrupt and LoLb, may be included during development for monitoring purposes. Interrupt is asserted when a change in the device is detected and LOLb (Loss of Lock) is asserted when phase locking is achieved. The Clock Generation and Jitter Measurement subsystem allows determination for the overall success of the ComCaP system to carry the reference clock over the 40 V power cable.

Functions:
- Clean clock signal provided by Bias-T circuit on receiving end of ComCaP system.
- Generate 10x scaler multiple of reference signal for jitter measurements.

Inputs:
- 2.5 MHz LVDS Clock Signal
- I2C serial communication interface Chip Configuration
- Active Low Reset

Output:
- 25 MHz LVDS Clock Signal
- Interrupt Status Signal
- Loss of Lock Status Signal

Interface:
- No direct user interface is required beyond initial configuration.
- Microcontroller with usb connectivity shall be used to interface with the Si5345B chip during development.

#### Si5345B Reference Schematic
<img width="951" height="747" alt="Si5345B Schematic" src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/Conceptual_Design/Documentation/Images/Si5345B_config_3-29-26.png" />

### Cable

The cable is the physical connection between the transmission and reception side of the ComCaP. It is responsible for carrying the power, clock, and back channel communications over a distance of two to ten meters. Because of the complexity of the system, the transmission line characteristics and the electromagnetic characteristics of the cable must be simulated and taken into account. As of now, a specific type of cable has not been selected. However, a twisted pair or a coaxial cable seem to be the most promising. 

Function:
- Transmit signals from the Tx to the Rx side of the ComCaP

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

The ComCaP device will impact both doctors and patients. For doctors, the device will be smaller than Siemens Healthineers' existing solution, providing more space for them to use for other medical equipment or devices. The PET system will also become more reliable as we are minimizing the points of failure as well as adding communications to help diagnose issues. Added reliability will decrease both the number of times the PET system will be down, and decrease the amount of time it takes for the PET system to return back online. Because of that, the PET system can be used more often, and will help diagnose more people with medical conditions. The benefits to both doctors and patients will hopefully lead to more diagnoses and save more lives.

The implications of the product failing must be taken into account. In this case, if the project fails, that means that there will be more downtime on life saving medical equipment which could lead to a delay medical emergencies being detected. In extreme cases, that extra time could be the difference in life or death. While it is unrealistic to build a perfect product, the team will minimize points of failure to the best of its ability. The team will be truthful in all of the things that it does, even if that means failure of the project. An unsuccessful product is much better than an unsafe one. 

### Professional Considerations

As engineers, the team upholds values such as those outlined in the National Society of Professional Engineers (NSPE) code of ethics [7]. The team will emphasize the health and safety of the public and conduct itself in an honest matter. The team will be transparent in all its actions, because an NDA was not signed. The team will meticulously document everything it does, so the customer can build upon the solution after the team is removed from the project.

### Standards Considerations

The primary standards that we will need to follow is the IEC 60601 [4]. These are the standards outlining the electrical requirements for medical devices. Per Siemens, the scope of the project does not have a requirement to follow these standards directly. However, by adhering to an older version of these standards, the project can be more easily implemented into the greater PET system. Older standards must be used because purchasing the license for the updated standards is not in the budget.

## Resources

This project will include primarily hardware components to implement the design: the Bias Tee circuits (Rx and Tx), the Si5345B Jitter-Cleaning Clock Synthesizer, the ST7540 FSK Power Line Transceiver, various SMD components to support those circuits, the PCB, a power supply, and cables for the I/O. Additionally, LTSpice will be used primarily for simulation files to deliver to the customer.

#### Hardware Components

1. Bias Tee Circuitry: Specific Capacitors, Inductors, and Resistors will need to be selected to create the bias tee with certain characteristics to operate at ideal functionality.
2. Jitter Cleaning Clock Synthesizer: Si5345B. This chip is used for generating a reference clock. This chip was selected by the customer for its ability to maintain a clean signal and reduce jitter [4].
3. FSK Power Line Transceiver: ST7580. This chip is a flexible power line networking system-on-chip combining a high performing PHY processor core and a protocol controller with a fully integrated analog front-end (AFE) and line driver for a scalable future-proof, cost effective, single chip, narrow-band power line communication solution [5].
4. PCB: Two boards will be designed and laid out. One board shall be in charge of producing the clock signal and biasing it to be fed over a cable to the receiver. The other board shall function as the test board to check the jitter measurements and ensure that the design falls within the specifications outlined by the customer.
5. Power Supply: Provides power to the board which will then be stepped down to power the the various components and then sent over the cable from the transmitter to the receiver. Power supply will be provided by the customer.
6. Cables: Cables will be procured or fabricated to carry the power and signal from the transmitter to the receiver. Present options for the cable are Ethernet or Coaxial cables.

### Budget

Develop a budget proposal with justifications for expenses associated with each subsystem. Note that the total of this budget proposal can also serve as a specification for each subsystem. After creating the budgets for individual subsystems, merge them to create a comprehensive budget for the entire solution.

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
| Prototyping Cost                     | Extra material, spares, test components    |          | $150                        |

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


<!-- Revise the detailed timeline (Gantt chart) you created in the project proposal. Ensure that the timeline is optimized for detailed design. Address critical unknowns early and determine if a prototype needs to be constructed before the final build to validate a subsystem. Additionally, if subsystem $A$ imposes constraints on subsystem $B$, generally, subsystem $A$ should be designed first. -->

## References

All sources utilized in the conceptual design that are not considered common knowledge must be properly cited. Multiple references should be included.

[1] J. Kolb, "Combined Power and Signal Delivery: A 48-V Clock and Communication Link," unpublished, Siemens Healthineers, Dec. 2025.

[2] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].

[3] Skyworks, "Any-frequency, Any-output Jitter-Attenuators/Clock Multipliers Si5345, Si5344, Si5342 Family Reference Manual," Si5345, Si5344, Si5342 Rev. D Family
Reference Manual, July 2016 Revised [September 2018]

[4] A. Grob, "Setting Standards: The IEC 60601 Series: Quick-Use Guide," Biomedical Instrumentation & Technology, vol. 54, (3), pp. 220-222, 2020. Available: https://ezproxy.tntech.edu/login?url=https://www.proquest.com/scholarly-journals/i-setting-standards-iec-60601-series-quick-use/docview/2414388374/se-2. DOI: https://doi.org/10.2345/0899-8205-54.3.220. 

[5] STMicroelectronics, "FSK, PSK multi-mode power line networking system-on-chip," ST7580 Rev 2 Data Sheet, Jan. 2012 Revised [May 2016].

[7] “NSPE code of Ethics for Engineers: National Society of Professional Engineers,” NSPE Code of Ethics for Engineers | National Society of Professional Engineers, https://www.nspe.org/career-growth/nspe-code-ethics-engineers (accessed Feb. 22, 2026).

[66] FesZ Electronics, “Bias Tee Basics (1/2),” YouTube, Jun. 07, 2025. https://www.youtube.com/watch?v=2nusy07ljPk&list=PLT84nve2j1g_s3Lu1JEki9eVB9_nb9qNf&index=2 (accessed Mar. 30, 2026).
‌

## Statement of Contributions

Each team member is required to make a meaningful contribution to the project proposal. In this section, each team member is required to document their individual contributions to the report. One team member may not record another member's contributions on their behalf. By submitting, the team certifies that each member's statement of contributions is accurate.

