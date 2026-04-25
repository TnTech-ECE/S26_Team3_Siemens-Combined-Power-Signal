# Detailed Design

<!-- This document delineates the objectives of a comprehensive system design. Upon reviewing this design, the reader should have a clear understanding of:

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

*Note: These technical documentation elements are mandatory only when relevant to the particular subsystem. -->
## Function of the Subsystem

<!--This segment should elucidate the role of the subsystem within the entire system, detailing its intended function, aligned with the conceptual design.-->
The IC Power subsystem is responsible for taking in the main power from the source that is supplied to the system of 48 V at 100 W and stepping it down with the proper current required to power the other ICs in the ComCaP on the transmitting and receiving ends. There is no simulation data for this section because there are not models that exist for either of these ICs. The schematics designed were created using the datasheet and tailored for the required functionality of the system. This subsystem interacts with the Bias Tee section, as it draws power from the transmitted power from the circuit, with the cable in the sense that the power is transmitted over it and then filtered out on the receiving ends. It is connected to the Communications and PLL subsystems in that it will be providing the power for each of the ICs: ST7580 and Si5345b, respectively.

## Specifications and Constraints

<!-- This section should provide a list of constraints applicable to the subsystem, along with the rationale behind these limitations. For instance, constraints can stem from physics-based limitations or requirements, subsystem prerequisites, standards, ethical considerations, or socio-economic factors.

The team should set specifications for each subsystem. These specifications may require modifications, which must be authorized by the team. It could be necessary to impose additional constraints as further information becomes available.

Every subsystem must incorporate at least one constraint stemming from standards, ethics, or socio-economic factors. -->
### Provided Adjustable Voltage to System

The IC Power subsystem shall provide 11 V, 5 V, 3.3 V, and 1.8 V. The MAX6793TPSD+ features two outputs, one of which is configurable at 11 V. This is set using two resistors and is calculated as 

$$V_{OUT} = V_{SET}(1+\frac{R1}{R2})$$

In the equation, 

## Overview of Proposed Solution

Describe the solution and how it will fulfill the specifications and constraints of this subsystem.


## Interface with Other Subsystems

Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted.


<!-- ## 3D Model of Custom Mechanical Components

Should there be mechanical elements, display diverse views of the necessary 3D models within the document. Ensure the image's readability and appropriate scaling. Offer explanations as required.

There are no custom mechanical components. All components are COTS; the customer will create their own custom hardware if they decide to adopt our project into a final design. -->

## Buildable Schematic 

Integrate a buildable electrical schematic directly into the document. If the diagram is unreadable or improperly scaled, the supervisor will deny approval. Divide the diagram into sections if the text and components seem too small.

The schematic should be relevant to the design and provide ample details necessary for constructing the model. It must be comprehensive so that someone, with no prior knowledge of the design, can easily understand it. Each related component's value and measurement should be clearly mentioned.


## Printed Circuit Board Layout

<!-- Include a manufacturable printed circuit board layout. -->
At this point in the design process, there is no circuit board available for manufacturing. The IC Power, Bias Tee, Communications, and PLL subsystems each contain a schematic that will have to be combined in the end and laid out on two separate PCBs. This will be done during Capstone II.

<!-- ## Flowchart

For sections including a software component, produce a chart that demonstrates the decision-making process of the microcontroller. It should provide an overview of the device's function without exhaustive detail. -->

<!-- There is no software component, and consequently, no flowchart. -->

## BOM

Provide a comprehensive list of all necessary components along with their prices and the total cost of the subsystem. This information should be presented in a tabular format, complete with the manufacturer, part number, distributor, distributor part number, quantity, price, and purchasing website URL. If the component is included in your schematic diagram, ensure inclusion of the component name on the BOM (i.e R1, C45, U4).

## Analysis

Deliver a full and relevant analysis of the design demonstrating that it should meet the constraints and accomplish the intended function. This analysis should be comprehensive and well articulated for persuasiveness.

## References

All sources that have contributed to the detailed design and are not considered common knowledge should be duly cited, incorporating multiple references.
