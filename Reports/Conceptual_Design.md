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

The introduction is intended to reintroduce the fully formulated problem. 


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


### Operational Flow Chart

Similar to a block diagram, the flow chart aims to specify the system, but from the user's point of view rather than illustrating the arrangement of each subsystem. It outlines the steps a user needs to perform to use the device and the screens/interfaces they will encounter. A diagram should be drawn to represent this process. Each step should be represented in the diagram to visually depict the sequence of actions and corresponding screens/interfaces the user will encounter while using the device.


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

In the project proposal, each team must evaluate the broader impacts of the project on culture, society, the environment, public health, public safety, and the economy. Additionally, teams must consider relevant standards organizations that will inform the design process. A comprehensive discussion should be included on how these considerations have influenced the design. This includes detailing constraints, specifications, and practices implemented as a result, and how these address the identified considerations.

## Broader Implications, Ethics, and Responsibility as Engineers

The project is tailor made for Siemens Healthineers and their proprietary PET system, however that does not entirely mean that there are not broader impacts that the ComCaP solution will have. While the ComCaP is not going to come into contact with any patients or the general public, the team is still designing it for use in the medical field. Therefore, the solution will have an impact on public health. There will also need to be special care taken, due to the impact that this will have on the medical well being of the patients using the PET machine. This section will discuss those impacts in greater detail as well as discussing the general ethical responsibilities the team will face in this project.

1. Public Health Impacts

The ComCaP device will impact both doctors and patients. For doctors, the device will be smaller than Siemens Healthineers' existing solution, providing more space for them to use for other medical equipment or devices. For patients, the device will make the PET system more reliable. This will decrease both the number of times the PET system will be down, and decrease the amount of time it takes for the PET system to return back online. Because of that, the PET system can be used more often, and will help diagnose more people with medical conditions. The benefits to both doctors and patients will hopefully lead to more diagnoses and save more lives.

2. Considerations for the Medical Field:

Per Siemens Healthineers, this project will not need to follow any specific codes or regulations for the medical field. However, extra care must be taken, as this project is an integral part of life saving medical equipment. As engineers, the team must take into account the implications of the product failing. In this case, if the project fails, that means that there will be more downtime on life saving medical equipment which could lead to a delay medical emergencies being detected. In extreme cases, that extra time could be the difference in life or death. The team can't expect the system to be without failure, but the team will need to take extra care and consideration in the reliability of the product. Even though it does not come into direct contact with patients, the consequences of failing will still impact them.

3. Ethical Responsibilities:

As engineers, the team upholds values such as those outlined in the National Society of Professional Engineers (NSPE) code of ethics [7]. The team will emphasize the health and safety of the public and conduct itself in an honest matter. The team will use all of its gained knowledge and skills to produce the most effective product possible, without compromising the safety of others. The team will be truthful in all of the things that it does, even if that means failure of the project. An unsuccessful product is much better than an unsafe one. The team will be transparent in all its actions, as an NDA was not signed. The team will meticulously document everything it does, so the customer can build upon the solution after the team is removed from the project.

In summary, this project has the ability to greatly improve the care provided to patients and improve the lives of doctors performing their duties. By bearing in mind the severity of the team's work and conducting itself in an ethical manner, the team will fulfil its duty to create this project without any harm or deception.

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


## Statement of Contributions

Each team member is required to make a meaningful contribution to the project proposal. In this section, each team member is required to document their individual contributions to the report. One team member may not record another member's contributions on their behalf. By submitting, the team certifies that each member's statement of contributions is accurate.

