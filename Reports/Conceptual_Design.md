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

The fully formulated problem is the overall objective and scope complete with the set of shall statements. This was part of the project proposal. However, it may be that the scope has changed. So, state the fully formulated problem in the introduction of the conceptual design and planning document. For each of the constraints, explain the origin of the constraint (customer specification, standards, ethical concern, broader implication concern, etc).


## Comparative Analysis of Potential Solutions

In this section, various potential solutions are hypothesized, design considerations are discussed, and factors influencing the selection of a solution are outlined. The chosen solution is then identified with justifications for its selection.


## High-Level Solution

This section presents a comprehensive, high-level solution aimed at efficiently fulfilling all specified requirements and constraints. The solution is designed to maximize stakeholder goal attainment, adhere to established constraints, minimize risks, and optimize resource utilization. Please elaborate on how your design accomplishes these objectives.


### Hardware Block Diagram

Block diagrams are an excellent way to provide an overarching understanding of a system and the relationships among its individual components. Generally, block diagrams draw from visual modeling languages like the Universal Modeling Language (UML). Each block represents a subsystem, and each connection indicates a relationship between the connected blocks. Typically, the relationship in a system diagram denotes an input-output interaction.

In the block diagram, each subsystem should be depicted by a single block. For each block, there should be a brief explanation of its functional expectations and associated constraints. Similarly, each connection should have a concise description of the relationship it represents, including the nature of the connection (such as power, analog signal, serial communication, or wireless communication) and any relevant constraints.

The end result should present a comprehensive view of a well-defined system, delegating all atomic responsibilities necessary to accomplish the project scope to their respective subsystems.

#### Bias Tee

The bias tee is the primary focus of this project and what brings every other subsection together. The bias tee will use an inductor to pass the DC power and capacitors to pass the RF clock and communications on the input side allowing all three to travel on the single cable. Then the bias tee will separate the signals again using an inductor for the DC and capacitors for the RF clock and communications.

#### Power

The power will be provided to the system in the form of a 48 V DC signal. The power must also output the system as a 48 V DC signal with minimal deviance. This is not being considered as an assigned subsystem due to it's simplicity and the bias tee subsystem handling it. However, it is important to represent it in the block diagram.

#### Clock

The reference clock will also be provided to the system. It will enter and leave the system as a 2.5 MHz RF signal. For the output of the clock from the system, a jitter cleaning clock synthesizer is used (Si5345B). There will also be a second clock output from the system of the reference clock scaled to 25 MHz to measure the cycle-to-cycle jitter.

#### Communications

The back channel communications will also be provided to the system as a not yet specified RF signal. The communications will be used to interact with the PET scanner. The team has freedom to approach this in many different ways, although this is considered a reach goal by the customer.

#### Cable

The cable will transport the combined signal produced by the bias tee. The cable will be up ten meters long and be capable of transporting both DC and RF. Currently, coaxial and twisted pair are being considered for the cable used.

### Operational Flow Chart

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

### Cable


## Ethical, Professional, and Standards Considerations

<!--In the project proposal, each team must evaluate the broader impacts of the project on culture, society, the environment, public health, public safety, and the economy. Additionally, teams must consider relevant standards organizations that will inform the design process. A comprehensive discussion should be included on how these considerations have influenced the design. This includes detailing constraints, specifications, and practices implemented as a result, and how these address the identified considerations.-->

### Ethical Considerations

The ComCaP device will impact both doctors and patients. For doctors, the device will be smaller than Siemens Healthineers' existing solution, providing more space for them to use for other medical equipment or devices. The PET system will also become more reliable as we are minimizing the points of failure as well as adding communications to help diagnose issues. Added reliability will decrease both the number of times the PET system will be down, and decrease the amount of time it takes for the PET system to return back online. Because of that, the PET system can be used more often, and will help diagnose more people with medical conditions. The benefits to both doctors and patients will hopefully lead to more diagnoses and save more lives.

The implications of the product failing must be taken into account. In this case, if the project fails, that means that there will be more downtime on life saving medical equipment which could lead to a delay medical emergencies being detected. In extreme cases, that extra time could be the difference in life or death. While it is unrealistic to build a perfect product, the team will minimize points of failure to the best of its ability. The team will be truthful in all of the things that it does, even if that means failure of the project. An unsuccessful product is much better than an unsafe one. 

As engineers, the team upholds values such as those outlined in the National Society of Professional Engineers (NSPE) code of ethics [7]. The team will emphasize the health and safety of the public and conduct itself in an honest matter. The team will be transparent in all its actions, because an NDA was not signed. The team will meticulously document everything it does, so the customer can build upon the solution after the team is removed from the project.

### Professional Considerations

### Standards Considerations

The primary standards that we will need to follow is the IEC 60601. These are the standards outlining the electrical requirements for medical devices. Per Siemens, the scope of the project does not have a requirement to follow these standards directly. However, by adhering to an older version of these standards, the project can be more easily implemented into the greater PET system. Older standards must be used because purchasing the license for the updated standards is not in the budget.

## Resources

This project will include primarily hardware components to implement the design: the Bias Tee circuits (Rx and Tx), the Si5345B Jitter-Cleaning Clock Synthesizer, ST7540 FSK Power Line Transceiver, various SMD components to support those circuits, the PCB, a power supply, and cables for the I/O. Additionally, LTSpice will be used primarily for simulation files to deliver to the customer.

### Hardware Components

1. Bias Tee Circuitry: Specific Capacitors, Inductors, and Resistors will need to be selected to create the bias tee with certain characteristics to operate at ideal functionality.
2. Jitter Cleaning Clock Synthesizer: Si5345B. This chip is used for generating a reference clock. This chip was selected by the customer for its ability to maintain a clean signal and reduce jitter [2].
3. FSK Power Line Transceiver: ST7540. This chip is used as a modem for the back-channel communications as detailed in Focus 3.
4. PCB: Two boards will be designed and laid out. One board shall be in charge of producing the clock signal and biasing it to be fed over a cable to the receiver. The other board shall function as the test board to check the jitter measurements and ensure that the design falls within the specifications outlined by the customer.
5. Power Supply: Provides power to the board which will then be stepped down to power the the various components and then sent over the cable from the transmitter to the receiver. Power supply will be provided by the customer.
6. Cables: Cables will be procured or fabricated to carry the power and signal from the transmitter to the receiver. Present options for the cable are Ethernet or Coaxial cables.

### Budget

Develop a budget proposal with justifications for expenses associated with each subsystem. Note that the total of this budget proposal can also serve as a specification for each subsystem. After creating the budgets for individual subsystems, merge them to create a comprehensive budget for the entire solution.

### Division of Labor

First, conduct a thorough analysis of the skills currently available within the team, and then compare these skills to the specific requirements of each subsystem. Based on this analysis, appoint a team member to take the specifications for each subsystem and generate a corresponding solution (i.e. detailed design). If there are more team members than subsystems, consider further subdividing the solutions into smaller tasks or components, thereby allowing each team member the opportunity to design a subsystem.

### Timeline

Revise the detailed timeline (Gantt chart) you created in the project proposal. Ensure that the timeline is optimized for detailed design. Address critical unknowns early and determine if a prototype needs to be constructed before the final build to validate a subsystem. Additionally, if subsystem $A$ imposes constraints on subsystem $B$, generally, subsystem $A$ should be designed first.


## References

All sources utilized in the conceptual design that are not considered common knowledge must be properly cited. Multiple references should be included.

[1] J. Kolb, "Combined Power and Signal Delivery: A 48-V Clock and Communication Link," unpublished, Siemens Healthineers, Dec. 2025.

[2] A. Grob, "Setting Standards: The IEC 60601 Series: Quick-Use Guide," Biomedical Instrumentation & Technology, vol. 54, (3), pp. 220-222, 2020. Available: https://ezproxy.tntech.edu/login?url=https://www.proquest.com/scholarly-journals/i-setting-standards-iec-60601-series-quick-use/docview/2414388374/se-2. DOI: https://doi.org/10.2345/0899-8205-54.3.220. 

[7] “NSPE code of Ethics for Engineers: National Society of Professional Engineers,” NSPE Code of Ethics for Engineers | National Society of Professional Engineers, https://www.nspe.org/career-growth/nspe-code-ethics-engineers (accessed Feb. 22, 2026).

## Statement of Contributions

Each team member is required to make a meaningful contribution to the project proposal. In this section, each team member is required to document their individual contributions to the report. One team member may not record another member's contributions on their behalf. By submitting, the team certifies that each member's statement of contributions is accurate.

