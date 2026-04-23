# Communications Detailed Design

**NOTE:** Other subsystems call the two parts "transmitter" and receiver, but since both parts transmit and receive, in this document, they will be called "server" and "client" respectively.

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


## Function of the Subsystem

Siemens, the customer, will need to get status updates from the detectors, and ideally, this can be incorporated with the power and clock in the single transmission line. The communications subsystem has two identical parts, the server and client. Both parts work in tandem to transmit and receive a debug signal across the line. This system must be able to take any data input and transform it into a modulated packet to receive that data input on the opposite end. [1] 

## Specifications and Constraints

This section should provide a list of constraints applicable to the subsystem, along with the rationale behind these limitations. For instance, constraints can stem from physics-based limitations or requirements, subsystem prerequisites, standards, ethical considerations, or socio-economic factors.

The team should set specifications for each subsystem. These specifications may require modifications, which must be authorized by the team. It could be necessary to impose additional constraints as further information becomes available.

Every subsystem must incorporate at least one constraint stemming from standards, ethics, or socio-economic factors.

------

### Specifications Requested by Siemens
The most basic requirements of this system are as follows: The system must take in a generic data signal, modulate it, transmit it, then the other part must do the reverse steps to extract the data signal again. Both parts must serve transmitter and receiver roles. Since integration into the coincidence unit and detectors is not within our responsibility, the subsystem must be able to modulate any generic bit stream. [1]

### FCC Part 15

FCC part 15 Section 113 states that "signals from this operation shall be contained within the frequency band 9 kHz to 490 kHz" [2]. The document provided by Siemens suggests a bitrate of 500kbps to 1Mbps, but the theoretical (but feasibly impossible) maximum for data transfer on 490 kHz is 490 kbps. [1]

Also, 

### Other Specifications
From the conceptual design comparative analysis, turnkey embedded firmware was deemed necessary for the scale of this project. This modem also must be a power line communication modem since the transmission line will have power transmitted across it.




## Overview of Proposed Solution

Describe the solution and how it will fulfill the specifications and constraints of this subsystem.


## Interface with Other Subsystems

Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted.


## 3D Model of Custom Mechanical Components

Should there be mechanical elements, display diverse views of the necessary 3D models within the document. Ensure the image's readability and appropriate scaling. Offer explanations as required.


## Buildable Schematic 

Integrate a buildable electrical schematic directly into the document. If the diagram is unreadable or improperly scaled, the supervisor will deny approval. Divide the diagram into sections if the text and components seem too small.

The schematic should be relevant to the design and provide ample details necessary for constructing the model. It must be comprehensive so that someone, with no prior knowledge of the design, can easily understand it. Each related component's value and measurement should be clearly mentioned.


## Printed Circuit Board Layout

Include a manufacturable printed circuit board layout.


## Flowchart

For sections including a software component, produce a chart that demonstrates the decision-making process of the microcontroller. It should provide an overview of the device's function without exhaustive detail.


## BOM

Provide a comprehensive list of all necessary components along with their prices and the total cost of the subsystem. This information should be presented in a tabular format, complete with the manufacturer, part number, distributor, distributor part number, quantity, price, and purchasing website URL. If the component is included in your schematic diagram, ensure inclusion of the component name on the BOM (i.e R1, C45, U4).

## Analysis

Deliver a full and relevant analysis of the design demonstrating that it should meet the constraints and accomplish the intended function. This analysis should be comprehensive and well articulated for persuasiveness.

## References

All sources that have contributed to the detailed design and are not considered common knowledge should be duly cited, incorporating multiple references.

[1] J. Kolb, "Combined Power and Signal Delivery: A 48-V Clock and Communication Link," unpublished, Siemens Healthineers, Dec. 2025.

[2] “FCC Part 15.” Federal Communications Commission, Washington, DC, Apr. 25, 1989 