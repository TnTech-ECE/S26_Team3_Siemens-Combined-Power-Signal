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

#### Specifications

Specifications are requirements imposed by **stakeholders** to meet their needs. If a specification seems unattainable, it is necessary to discuss and negotiate with the stakeholders.

#### Constraints

Constraints often stem from governing bodies, standards organizations, and broader considerations beyond the requirements set by stakeholders.

Questions to consider:
- Do governing bodies regulate the solution in any way?
- Are there industrial standards that need to be considered and followed?
- What impact will the engineering, manufacturing, or final product have on public health, safety, and welfare?
- Are there global, cultural, social, environmental, or economic factors that must be considered?


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

Each project proposal must include a comprehensive description of the necessary resources.

### Budget

Provide a budget proposal with justifications for expenses such as software, equipment, components, testing machinery, and prototyping costs. This should be an estimate, not a detailed bill of materials.

### Personnel

#### Required Skills
Hardware and Circuit Design: Circuit design knowledge, Power Systems, Cable Design, PCB Design, Component Sourcing
Design and Simulations Tools: LTspice, Matlab, Altium, LT Powercad
Theory and Analysis: Signal Processing and Filtering

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

1. **Minimizing the Size**

Combining the clock and power into one module minimizes the space needed for those components. Instead of needing two boxes for clock and power individually, the combination will fit in a single box. In a medical environment minimizing space is important as every bit of space saved gives medical professionals more space to use for other things. For our customer, the space saved can help them more effectively sell their PET system. Tangibly, as stated above, the solution will condense two systems into one. This will greatly decrease the space needed for clock and power in the final product. This is worthwhile because space is a great concern in the medical field, and lessening space restrictions can improve the efficiency of the space in the hospital or clinic that is using Siemens' PET system.

2. **Simplifying the Existing Solution**

Combining the clock and power systems also simplifies the overall PET system by reducing the total number of subsystems. Tangibly, this means removing the extra components required for both a clock and power to be sent to the PET system. This is worthwhile to Siemens, because it decreases the number of systems needed to maintain. It is also potentially cheaper, because there will be less cabling and hardware to manufacture and maintain.

3. **Removing Common Points of Error**

A common point of error in the PET system are the connections on the cables themselves. By combining the clock and power onto one cable, the number of connections needed are cut in half. Tangibly, this is self explanatory. Less connections means less points of failure and, in the event of a failure, less connections to test. This is worthwhile because it simultaneously reduces the number of places a cable failure can take place and it reduces the time it takes to narrow down where that failure is. Thus, letting a technician fix it in a more timely manner, and reducing the overall downtime of the machine when it fails.

Overall, this solution streamlines Siemens' existing product without sacrificing any of its existing functionality. It's worthiness lies in its ability to reduce the space required, simplify two separate subsystems into one, and remove common points of error. This senior design projects improves real-world medical equipment, and brings a sleek innovation to an existing product.

## Broader Implications, Ethics, and Responsibility as Engineers

Consider the project’s broader impacts in global, economic, environmental, and societal contexts. Identify potential negative impacts and propose mitigation strategies. Detail the ethical considerations and responsibilities each team member bears as an engineer.


## References

All sources used in the project proposal that are not common knowledge must be cited. Multiple references are required.


## Statement of Contributions

Each team member must contribute meaningfully to the project proposal. In this section, each team member is required to document their individual contributions to the report. One team member may not record another member's contributions on their behalf. By submitting, the team certifies that each member's statement of contributions is accurate.
