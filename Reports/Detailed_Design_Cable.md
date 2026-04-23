
# Detailed Design

<!--This document delineates the objectives of a comprehensive system design. Upon reviewing this design, the reader should have a clear understanding of:
&#10;- How the specific subsystem integrates within the broader solution
- The constraints and specifications relevant to the subsystem
- The rationale behind each crucial design decision
- The procedure for constructing the solution
&#10;
## General Requirements for the Document
&#10;The document should include:
&#10;- Explanation of the subsystem’s integration within the overall solution
- Detailed specifications and constraints specific to the subsystem
- Synopsis of the suggested solution
- Interfaces to other subsystems
- 3D models of customized mechanical elements*
- A buildable diagram*
- A Printed Circuit Board (PCB) design layout*
- An operational flowchart*
- A comprehensive Bill of Materials (BOM)
- Analysis of crucial design decisions
&#10;*Note: These technical documentation elements are mandatory only when relevant to the particular subsystem.-->

## Function of the Subsystem

<!--This segment should elucidate the role of the subsystem within the entire system, detailing its intended function, aligned with the conceptual design.-->

The cable subsystem is responsible for transmitting the output of the
Bias Tee on the transmitting side of the ComCaP to the input of the Bias
Tee on the recieving side of the ComCap. Since the clock is expected to
be 2.5 MHz, and the maximum cable length is 10 m \[1\], transmission
line characteristics will have an appreciable impact on the system as a
whole. Therefore, the subsystem will deliver simulation data to
accurately model the inputs for the recieving Bias Tee as well as test
and model the cable in a real world scenario once the prototype is
built. This will need to be done for multiple lengths of cable up to 10
m. All of the data will then be sent to Siemens alongside the data for
the other subsystems. Siemens will then use that data in their actual
implementation for the PET system.

## Specifications and Constraints

<!--This section should provide a list of constraints applicable to the subsystem, along with the rationale behind these limitations. For instance, constraints can stem from physics-based limitations or requirements, subsystem prerequisites, standards, ethical considerations, or socio-economic factors.
&#10;The team should set specifications for each subsystem. These specifications may require modifications, which must be authorized by the team. It could be necessary to impose additional constraints as further information becomes available.
&#10;Every subsystem must incorporate at least one constraint stemming from standards, ethics, or socio-economic factors.-->

### Transmission Line Calculation

The cable subsystem will transmit the clock, power, and back channel
communications to the best of its ability. In order to do so,
transmission line calculations will need to be factored in. According to
Dr. Van Neste, transmission line calculations will have an appreciable
impact when the length of the cable is at least 10 % of the wavelength.
This is calculated as

$$\frac{l}{\lambda}*(100) \ge 10\%$$

In the function $l$ is the length of the cable and $\lambda$ is the
wavelength. The wavelength is calculated as $\lambda = \frac{v}{f}$
where $v$ is the propogation speed and $f$ is the clock frequency.

### Voltage Loss

According to Siemens Healthineers, the ripple at the output of the Bias
Tee cannot exceed 30 mV \[1\]. Since no specific guidelines were given
for the cable, a loss of 15 mV will be acceptable for the transmission
line. According to \[2\], the voltage at any point $z$ along the cable
can be shown as

$$V(z) = V_0[e^{jk(l-z)} + \Gamma _le^{-jk(l-z)}]$$

where the reflection coefficient $\Gamma_ l$ is determined by

$$\Gamma _l = \frac{Z_l - Z_0}{Z_l + Z_0}$$

### Impact to Greater system

Since the loss of the cable is directly tied to the

## Overview of Proposed Solution

<!--Describe the solution and how it will fulfill the specifications and constraints of this subsystem.-->

## Interface with Other Subsystems

<!--Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted.-->

The cable transmits the signal between both sides of the ComCaP. Because
of this, it interfaces with the bias T and the power subsystems
primarily. It interfaces with the bias T as the bias T is both the last
point of contact with the input side and the first point of contact for
the output side of the system. Therefore, the output of the first bias T
is the input of the cable and the output of the cable is the input of
the second bias T.

## 3D Model of Custom Mechanical Components

<!--Should there be mechanical elements, display diverse views of the necessary 3D models within the document. Ensure the image's readability and appropriate scaling. Offer explanations as required.-->

## Buildable Schematic

<!--Integrate a buildable electrical schematic directly into the document. If the diagram is unreadable or improperly scaled, the supervisor will deny approval. Divide the diagram into sections if the text and components seem too small.
&#10;The schematic should be relevant to the design and provide ample details necessary for constructing the model. It must be comprehensive so that someone, with no prior knowledge of the design, can easily understand it. Each related component's value and measurement should be clearly mentioned.-->

Siemens wants detailed simulation data delivered to them for the cable,
rather than a constructed cable. Since there is no construction element
to the cable design, a breakdown of the relevant elements of the cable
has been included instead.

## Flowchart

<!--For sections including a software component, produce a chart that demonstrates the decision-making process of the microcontroller. It should provide an overview of the device's function without exhaustive detail.-->

## BOM

<!--Provide a comprehensive list of all necessary components along with their prices and the total cost of the subsystem. This information should be presented in a tabular format, complete with the manufacturer, part number, distributor, distributor part number, quantity, price, and purchasing website URL. If the component is included in your schematic diagram, ensure inclusion of the component name on the BOM (i.e R1, C45, U4).-->

## Analysis

<!--Deliver a full and relevant analysis of the design demonstrating that it should meet the constraints and accomplish the intended function. This analysis should be comprehensive and well articulated for persuasiveness.-->

## References

<!--All sources that have contributed to the detailed design and are not considered common knowledge should be duly cited, incorporating multiple references.-->

<div id="refs" class="references csl-bib-body" entry-spacing="0">

<div id="ref-Siemens_Presentation" class="csl-entry">

<span class="csl-left-margin">\[1\]
</span><span class="csl-right-inline">J. Kolb, “Combined power and
signal delivery: A 48-v clock and communication link,” Siemens
Healthineers, Dec. 01, 2025.</span>

</div>

<div id="ref-Diament1990" class="csl-entry">

<span class="csl-left-margin">\[2\]
</span><span class="csl-right-inline">P. Diament, *Wave transmission and
fiber optics*. London, England: Macmillan, 1990.</span>

</div>

</div>
