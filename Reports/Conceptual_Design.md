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


## Ethical, Professional, and Standards Considerations

In the project proposal, each team must evaluate the broader impacts of the project on culture, society, the environment, public health, public safety, and the economy. Additionally, teams must consider relevant standards organizations that will inform the design process. A comprehensive discussion should be included on how these considerations have influenced the design. This includes detailing constraints, specifications, and practices implemented as a result, and how these address the identified considerations.


## Resources

You have already estimated the resources needed to complete the solution. Now, let's refine those estimates.

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
| Passive SMD Components               | Various components for circuits on PCBs    | 1 set    | $40-$50                     |
| Cable Ports                          | Ports for the cabling I/O on the PCB       | 2        | $5-$10                      |
| ST7540 FSK Power Line Transceiver    | Transceiver for FSK Functionality          | 1        | $5-$10                      |
| Prototyping Cost                     | Extra material, spares, test components    |          | $150                        |

### Division of Labor

The team allowed its members to bid for assignment to subsystems such that each member felt comfortable that all technical strengths were utilized efficiently and the workload of each member was reasonable, both in the context of learning new skills and applying current knowledge to the design process. Each member's role within the design process and the relevant skills to accommodate respective subsystems are as follows:

**Levi Cantrell - Clock Filtering & Generation, Jitter Measurement**  
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

Revise the detailed timeline (Gantt chart) you created in the project proposal. Ensure that the timeline is optimized for detailed design. Address critical unknowns early and determine if a prototype needs to be constructed before the final build to validate a subsystem. Additionally, if subsystem $A$ imposes constraints on subsystem $B$, generally, subsystem $A$ should be designed first.


## References

All sources utilized in the conceptual design that are not considered common knowledge must be properly cited. Multiple references should be included.


## Statement of Contributions

Each team member is required to make a meaningful contribution to the project proposal. In this section, each team member is required to document their individual contributions to the report. One team member may not record another member's contributions on their behalf. By submitting, the team certifies that each member's statement of contributions is accurate.

