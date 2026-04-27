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
### Provided Adjustable Voltage to System and Component Constraints

The IC Power subsystem shall provide 11 V, 5 V, 3.3 V, and 1.8 V. The outputs provided from the MAX6793 and MAX6795 can be configured outside of the preset ranges [1]. The preset values for provided by the chips are 5 V and 3.3 V. The 11 V and 1.8 V outputs must be configured using an external resistor divider network selected by the designer to provide the desired voltage. The calculations and resistor value selection are further detailed in the Overview of Proposed Solution section. As for the constraints, the outputs for the 11 V and 1.8 V are not able to be perfectly generated since the exact resistor value to create this would increase the hardware requirement and cost of the overall system. In the interest of maintaining simpler hardware implementation and reduction of many resistor values to attain a very specific value, an approximation was reached so that the deviation from the expected voltage output should be within 10 mV of the desired output. Calculations resulted in the 11 V output set at 10.9932 V and the 1.8 V output set at 1.79799, which falls within the range of a 10 mV difference. The output of the 11 V rail is not as important to be precise because it is powering the ST7580, which can take an input from 8 V to 18 V [2]. 10.9932 V satisfies this requirement and falls within the functioning range of the supply. For the Si5345, the required voltage of 1.8 V is allowed to have a tolerance of ±5 % which calculates to a range between 1.71 V and 1.899 V [3]. The voltage supplied at 1.79799 falls well within this range and therefore satisfies the requirements.

There are not very many versions of this chip in production, so the component that was selected is in a QFN package and will be laid out in a way that shall reduce the size of the hardware implementation and will optimize a clean power output.

### Standards

IEC 60601 [4]: The considerations for this subsystem relating to medical equipment standards involve ensuring electrical isolation at the Bias-T interface, limiting leakage currents, maintaining safe operation under single fault conditions, and ensuring electromagnetic compatibility so that the noise generated from these chips does not interfere with or degrade the performance of other medical system components. However, Siemens Healthineers has maintained that the ComCaP team does not need to design the system in strict compliance with these standards as the system merely serves as a proof of concept for the company to expand on, and the team has no access to the standards other than brief overviews. These standards will still be considered in the construction of the two PCBs the IC Power subsystem will reside on.

## Overview of Proposed Solution

<!-- Describe the solution and how it will fulfill the specifications and constraints of this subsystem. -->

### Resistor selection for Adjusted Voltage Outputs

The IC Power subsystem shall provide 11 V, 5 V, 3.3 V, and 1.8 V. The MAX6793TPSD+ features two outputs, one of which is configurable at 11 V. This is set using two resistors and is calculated as 

$$V_{OUT} = V_{SET}(1+\frac{R1}{R2})$$

With this configuration: 

<img src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/IC_Power/Reports/Images/V_OUT_1_SET.png" width="261" height="291" alt="Select V_OUT_1 Voltage">

The value of V_SET is 1.2315 V as obtained from the datasheet [1]. Using the equation and example diagram listed above, the calculated ratio of R1 to R2 for an adjusted output of 11 V is 19537 : 2463. Additionally, the values of R1 and R2 selected must be less than 200 kΩ. This exact ratio would be difficult to obtain using commonly found resistor values, so a balance was decided on where the value of R1 would be 118.9 kΩ and the value of R2 would be 15 kΩ. This would provide a ratio that falls within a percent difference of 0.0697 % and would set the output voltage at 10.9932 as stated in the constraints section. The 15 kΩ resistor is easy to find as it is a commonly used value, but a resistance of 118.9 kΩ is fairly difficult to find, so it was split up into three separate resistors connected in series to produce this same resistance. The values are 100, 12, and 6.9 kΩ. Additionally, the tolerance of the 100 and 12 kΩ resistors is 1 %, and the tolerance of the 6.9 kΩ resistor is 0.1 %. This ensures that the total resistance would fall between the ranges of 117.7731 and 120.0269 kΩ, ensuring a further percent variation of only 0.9478 % within the expected range.

The same process was followed for selecting an output of 1.8 V. The ratio of R1 to R2 for this voltage divider was 379 : 821. An approximation was determined where the value of R1 would be 9.2 kΩ and R2 would be 20 kΩ. This produces a deviation of 0.354 % from the desired ratio, which still produces an expected output of 1.79799 V, which only deviates from the expected voltage by 0.112 %. This is within the tolerance range of the required supply inputs of the ICs that it shall be powering, as detailed in the constraints section. The values of the resistors selected to create a series resistance of 9.2 kΩ is 1 kΩ and 8.2 kΩ. Both of the resistors have a tolerance of 1 %, meaning that the maximum deviation from the expected resistor value is 1 %.

### Selection of Passives For Basic Functionality

#### Decoupling Capacitors

The decoupling capacitor values for the chips were obtained from the datasheet, where the values for decoupling the input of the system are 1 uF and 10 µF connected in parallel. This follows the recommended values for maintaining a clean input signal at 48 V to the ICs.

#### RESET Signal Resistor

A value of 100 kΩ was selected as the resistor value to pull ~RESET to ground. The value of this resistor was not critical to the design. The recommended value is 100 kΩ as this is sufficient to pull ~RESET to ground without creating a load for it.

### Selection of PFET for Reverse-Battery Protection

The MAX6791-6796 family includes an overvoltage protection circuit that is capable of driving a p-channel MOSFET to protect against reverse battery conditions. This is very unlikely to occur in the ComCaP system because the power supply will be tested and ensured to be configured with the correct polarity before being turned on. However, just to add an extra level of safety to the circuit, a p-channel FET was chosen to fulfill this role. The BSP316P was selected as it features the desired parameters to ensure a properly functioning circuit [5]. The VDS voltage is -100 V, which the 48 V input falls safely within the operating region. Additionally, the Id can handle up to 0.68 A. As the total power requirement of the IC loads in the system falls below 300 mA, this FET is sufficient for the design.

### Power-Fail Detection Resistor Network

The MAX6791-6796 family includes a power fail comparator that can check if the supply voltage falls below the functional limit. The limit for a chosen failure value is 40 V because this constitutes about 8.33 % of the expected voltage supplied. To set up this network, a voltage divider network was determined using the following diagram:

<img src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/IC_Power/Reports/Images/PFI_Diagram.png" width="256" height="257" alt="Power fail resistor network and hysteresis">

Using the same equation for the voltage divider values as detailed in the Resistor selection for Adjusted Voltage Outputs section where V_SET becomes the failure voltage of 40 V (V_IN in the diagram) and the voltage compared at the node PFI is 1.23 V as detailed in the datasheet [1]. This results in a ratio of R5 to R6 of 3877 : 123. Additionally, the requirements for R5 and R6 are that there should be a current of at least 10 µA flowing through them to ensure that the 100 nA FI input current does not shift the trip point. Therefore, the selected values of R5 and R6 were determined to be 945.6 and 30 kΩ, respectively. This ensures a small margin of difference between the expected ratio of 0.00103 %. Additionally, the current that will be flowing through the two resistors at 40 V is 41 µA, which is larger than the minimum required current. R7 and R8 add hysteresis to the system. The recommended value of R7 is at least an order of magnitude greater than R5 or R6. Since R5 is about 1 MΩ, R7 is selected as being 10 MΩ. R8 was selected as 1 MΩ as it resulted in the hysteresis voltage as being 200 mV. The following equations come from the datasheet and show how the values of R5, R6, R7, and R8 were determined.

$$V_{L\text{-}H} = V_{PFI} \left( 1 + \frac{R_5}{R_6} + \frac{R_5}{R_7} \right)$$

$$V_{H\text{-}L} = V_{PFI} \left( 1 + \frac{R_5}{R_6} \right) + \left( V_{PFI} - V_{TERM} \right) \left( \frac{R_5}{R_7 + R_8} \right)$$

$$V_{HYS} = V_{PFI} \left( \frac{R_5}{R_7} \right) - \left( V_{PFI} - V_{TERM} \right) \left( \frac{R_5}{R_7 + R_8} \right)$$

### Watchdog System

The MAX6791-6796 family features a watchdog system where a watchdog timer can be set to reset in case a chip that it is supplying fails or malfunctions. However, after talking to the customer, this functionality was determined to not be needed and has therefore been disabled in the current design.

## Interface with Other Subsystems

<!-- Provide detailed information about the inputs, outputs, and data transferred to other subsystems. Ensure specificity and thoroughness, clarifying the method of communication and the nature of the data transmitted. -->

The IC Power distribution interfaces with three other subsystems: The Clock Generation and Jitter Measurement, Bias Tee, and Communications.

### IC Power Distribution Interfacing

The IC Power Distribution subsystem interfaces with the Clock Generation and Jitter Measurement subsystem via multiple power signals at 1.8 V, 3.3 V, and 5 V levels. These are intended to both enable the operation of relevant ICs and to bias inputs for both the OpAmp and comparator.

#### 1.8 V:
- Si5345B: VDD1-3

#### 3.3 V:
- ADCMP605: VCCO, LE/HYS (sets hysteresis level)
- Si5345B: VDDO0, VDDO3, VDDA, I<sup>2</sup>C (held high for selection of format)
- STM32G030: VDD/VDDA, RST (deactivates device reset)

#### 5 V:
- ADA4899-1: +VS, Input biasing
- ADCMP605: VCCI/VCCO, Input biasing
- Si5345B: VDD_1-3

### Bias-T Interfacing

The Bias-T subsystem interfaces with the IC Power Distribution in that on the receiving end, it takes power delivered from the Bias Tee and steps it down to the desired voltages.

### Communications Interfacing

The IC Power Distribution subsystem interfaces with the Communications subsystem via multiple power signals at 5 V, and 11 V levels.

#### 5 V:
- VDDIO

#### 11 V:
- VCC

## 3D Model of Custom Mechanical Components

There are no custom mechanical elements for this project, so there is no information or file under this section.

<!-- Should there be mechanical elements, display diverse views of the necessary 3D models within the document. Ensure the image's readability and appropriate scaling. Offer explanations as required.

There are no custom mechanical components. All components are COTS; the customer will create their own custom hardware if they decide to adopt our project into a final design. -->

## Buildable Schematic

<!-- Integrate a buildable electrical schematic directly into the document. If the diagram is unreadable or improperly scaled, the supervisor will deny approval. Divide the diagram into sections if the text and components seem too small.

The schematic should be relevant to the design and provide ample details necessary for constructing the model. It must be comprehensive so that someone, with no prior knowledge of the design, can easily understand it. Each related component's value and measurement should be clearly mentioned. -->

### LDO: +11 V, +5 V (MAX6793TPSD2+T)

The below circuit is designed to lower the voltage from the 48 V input and step it down to 11 V and 5 V. The values selected were explained in the Overview of the Proposed Solution.

<img src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/IC_Power/Reports/Images/LDO_Schematic-1.png" width="825" height="638" alt="11 V and 5 V LDO Schematic">

### LDO: +3.3 V (MAX6795TPSD2+T)

The below circuit is designed to lower the voltage from the 48 V input and step it down to 3.3 V. The values selected were explained in the Overview of the Proposed Solution.

<img src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/IC_Power/Reports/Images/LDO_Schematic-3.png" width="825" height="638" alt="3.3 V LDO Schematic">

### LDO: +1.8 V (MAX6795TPSD2+T)

The below circuit is designed to lower the voltage from the 48 V input and step it down to 1.8 V. The values selected were explained in the Overview of the Proposed Solution.

<img src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/IC_Power/Reports/Images/LDO_Schematic-2.png" width="825" height="638" alt="1.8 V LDO Schematic">


## Printed Circuit Board Layout

<!-- Include a manufacturable printed circuit board layout. -->
At this point in the design process, there is no circuit board available for manufacturing. The IC Power, Bias Tee, Communications, and PLL subsystems each contain a schematic that will have to be combined in the end and laid out on two separate PCBs. This will be done during Capstone II.

## Flowchart

There is no flowchart for this part of the project because it there is no software or user input for the system.

<!-- For sections including a software component, produce a chart that demonstrates the decision-making process of the microcontroller. It should provide an overview of the device's function without exhaustive detail. -->

<!-- There is no software component, and consequently, no flowchart. -->

## BOM

<!-- Provide a comprehensive list of all necessary components along with their prices and the total cost of the subsystem. This information should be presented in a tabular format, complete with the manufacturer, part number, distributor, distributor part number, quantity, price, and purchasing website URL. If the component is included in your schematic diagram, ensure inclusion of the component name on the BOM (i.e R1, C45, U4). -->

The below bill of materials encompasses the equipment required to produce one subsystem. The integrated system of all components will be more and is spread across the various other subsystems.

| Type       | Designator       | Quantity | Supplier Unit Price | Value   | MFG No.            | Manufacturer                      | Distributor           | Distributor Part No.        | Purchasing Website                                                                                                    |
|------------|------------------|----------|---------------------|---------|--------------------|-----------------------------------|-----------------------|-----------------------------|-----------------------------------------------------------------------------------------------------------------------|
| Capacitor  | C2, C5, C8       | 3        |  $0.25              | 10 uf   | GRM188Z71A106KA73D | Murata Electronics                | DigiKey               | 490-GRM188Z71A106KA73DCT-ND | https://www.digikey.com/en/products/detail/murata-electronics/GRM188Z71A106KA73D/13693280?curr=usd                    |
| Capacitor  | C3, C6, C9       | 3        |  $0.47              | 1 uF    | 490-10918-1-ND     | Murata Electronics                | DigiKey               | 490-10918-1-ND              | https://www.digikey.com/en/products/detail/murata-electronics/GRJ21BC72A105KE11L/5321010                              |
| Capacitor  | C4, C7, C10      | 3        |  $1.12              | 10 uf   | GRM32EC72A106KE05L | Murata Electronics                | DigiKey               | 490-16266-1-ND              | https://www.digikey.com/en/products/detail/murata-electronics/GRM32EC72A106KE05L/7319356?curr=usd                     |
| Capacitor  | C1               | 1        |  $0.25              | 10 uf   | GRM188Z71A106KA73D | Murata Electronics                | DigiKey               | 490-GRM188Z71A106KA73DCT-ND | https://www.digikey.com/en/products/detail/murata-electronics/GRM188Z71A106KA73D/13693280?curr=usd                    |
| Transistor | Q1, Q2, Q3       | 3        |  $1.07              | N/A     | BSP316P            | Infineon Technologies             | DigiKey               | BSP316PH6327XTSA1CT-ND      | https://www.digikey.com/en/products/detail/infineon-technologies/BSP316PH6327XTSA1/5409992?curr=usd                   |
| Resistor   | R1, R5, R11, R20 | 4        |  $0.10              | 100 kΩ  | RC0402FR-07100KL   | YAGEO                             | DigiKey               | 311-100KLRCT-ND             | https://www.digikey.com/en/products/detail/yageo/RC0402FR-07100KL/729473?curr=usd                                     |
| Resistor   | R2               | 1        |  $0.10              | 12 kΩ   | RC0402FR-0712KL    | YAGEO                             | DigiKey               | 311-12.0KLRCT-ND            | https://www.digikey.com/en/products/detail/yageo/RC0402FR-0712KL/729479?curr=usd                                      |
| Resistor   | R3               | 1        |  $0.13              | 6.9 kΩ  | RN73R1ETTP6901B25  | KOA Speer Electronics, Inc.       | DigiKey               | 2019-RN73R1ETTP6901B25CT-ND | https://www.digikey.com/en/products/detail/koa-speer-electronics-inc/RN73R1ETTP6901B25/12553982?curr=usd              |
| Resistor   | R4               | 1        |  $0.10              | 15 kΩ   | RT0402BRD0715KL    | YAGEO                             | DigiKey               | YAG2302CT-ND                | https://www.digikey.com/en/products/detail/yageo/RT0402BRD0715KL/5252416?curr=usd                                     |
| Resistor   | R6, R12, R21     | 3        |  $0.10              | 909 kΩ  | RC0402FR-07909KL   | YAGEO                             | DigiKey               | YAG2377CT-ND                | https://www.digikey.com/en/products/detail/yageo/RC0402FR-07909KL/5282121?curr=usd                                    |
| Resistor   | R7, R13, R22     | 3        |  $0.10              | 36.5 kΩ | RC0402FR-0736K5L   | YAGEO                             | DigiKey               | YAG3135CT-ND                | https://www.digikey.com/en/products/detail/yageo/RC0402FR-0736K5L/5282000?curr=usd                                    |
| Resistor   | R8, R14, R23     | 3        |  $0.11              | 30 kΩ   | ERA-2AEB303X       | Panasonic                         | Mouser                | 667-ERA-2AEB303X            | https://www.mouser.com/ProductDetail/Panasonic/ERA-2AEB303X?qs=YFwoyZoVY0hvnLe9839SdQ%3D%3D                           |
| Resistor   | R9, R15, R24     | 3        |  $0.10              | 10 MΩ   | CRGCQ0402J10M      | TE Connectivity Passive Product   | DigiKey               | A130072CT-ND                | https://www.digikey.com/en/products/detail/te-connectivity-passive-product/CRGCQ0402J10M/8577904?curr=usd             |
| Resistor   | R10, R16, R25    | 3        |  $0.10              | 1 MΩ    | RC0402FR-071ML     | YAGEO                             | DigiKey               | 311-1.00MLRCT-ND            | https://www.digikey.com/en/products/detail/yageo/RC0402FR-071ML/729462?curr=usd                                       |
| Resistor   | R17              | 1        |  $0.10              | 1 kΩ    | RC0402FR-071KL     | YAGEO                             | DigiKey               | 311-1.00KLRCT-ND            | https://www.digikey.com/en/products/detail/yageo/RC0402FR-071KL/729460?curr=usd                                       |
| Resistor   | R18              | 1        |  $0.10              | 8.2 kΩ  | RC0402FR-078K2L    | YAGEO                             | DigiKey               | 311-8.20KLRCT-ND            | https://www.digikey.com/en/products/detail/yageo/RC0402FR-078K2L/729609?curr=usd                                      |
| Resistor   | R19              | 1        |  $0.10              | 20 kΩ   | RC0402FR-0720KL    | YAGEO                             | DigiKey               | 311-20.0KLRCT-ND            | https://www.digikey.com/en/products/detail/yageo/RC0402FR-0720KL/729504?curr=usd                                      |
| LDO IC     | U1               | 1        |  $9.23              | N/A     | MAX6793TPSD2+T     | Analog Devices / Maxim Integrated | Mouser                | 700-MAX6793TPSD2T           | https://www.mouser.com/ProductDetail/Analog-Devices-Maxim-Integrated/MAX6793TPSD2%2bT?qs=1THa7WoU59GtgngGvyHjCQ%3D%3D |
| LDO IC     | U2, U3           | 2        |  $2.32              | N/A     | MAX6795TPSD2+      | Analog Devices / Maxim Integrated | Rochester Electronics | N/A                         | https://www.rocelec.com/part/01t4w00000PPbgpAAD-MAX6795TPSD2                                                          |

## Analysis

<!-- Deliver a full and relevant analysis of the design demonstrating that it should meet the constraints and accomplish the intended function. This analysis should be comprehensive and well articulated for persuasiveness. -->

Much of the analysis was discussed in the overview of the proposed solution, as the percentage differences in choosing commercial off the shelf components versus exact resistance values was documented and explained above. However, the calculations performed on the exact values is listed in the excel table below. This uses the equations stated above to calculate the values as well as determining the division of resistor values for the large resistors.

<img src="https://raw.githubusercontent.com/TnTech-ECE/S26_Team3_Siemens-Combined-Power-Signal/refs/heads/IC_Power/Reports/Images/Analysis_Calculations.png" width="1655" height="459" alt="Calculations for resistor values">

As seen in the chart, the first four columns are calculating the resistor value for setting the output of the MAX6793 to 11 V. The value of V_SET is 1.2315 V, and using the calculations in the overview section for the voltage divider, The values of R1 and R2 can be determined. The ratios are displayed, and then multiplied by a scaling factor and adjusted until a suitable resistance value was found. The R2 value was easily obtained, but the R1 value was more difficult, so the scaling was adjusted until an R2 was obtained as well as an R1 that could fairly simply be split up into two or three resistors and implemented in hardware. Additionally, the power dissipation capacity of the resistors was important to determine that parameter when selecting actual resistors. All of the power consumption is fairly low, so the lowest dissipation value of a resistor selected was 1/16 W, which is greater than the maximum amount of power dissipated across a single resistor. The current through each resistor is also calculated, which offers interesting insight as well, but did not pertain to direct selection of parts when designing the circuit. At the bottom of the column is the percentage difference between the expected value and the realistic value determined from component availability. As seen, a difference of 0.06191 % is sufficiently low and well within the tolerance range, as discussed in the overview section. The same process was followed for the MAX6795, and the values for R1 were also shown. The percentage difference for this difference in resistor value was slightly higher at 0.1117 %, but this is still within the tolerance range of the set output voltage. The final column shows the calculations for selecting R5, R6, R7, and R8, which are the power fail voltage divider resistor network resistors, and the hysteresis resistors. The ratio is shown along with the multiplier set to obtain an easily found R6, and the R5 value is estimated. The resulting difference between the expected R5 and implemented R5 value is 0.00103%, which is well within the tolerance limit. The minimum value of R7 is also shown which is an order of magnitude greater than R5. The selected values are shown at the bottom for R7 and R8, which the explanation for these values is explained in the overview section as well. Finally, the current flowing through R5 and R6 is shown since the datasheet recommended that there be at least 10 µA of current flowing through them. Here, a value of 41 µA is calculated, which is greater than the minimum value.

## References

[1] Analog Devices, "MAX6791–MAX6796 High-Voltage, Micropower, Single/Dual Linear Regulators with Supervisory Functions," MAX6793 Rev 3 Data Sheet, Oct. 2005 Revised [Oct. 2017].

[2] STMicroelectronics, "FSK, PSK multi-mode power line networking system-on-chip," ST7580 Rev 2 Data Sheet, Jan. 2012 Revised [May 2016].

[3] Skyworks, "10-Channel, Any-Frequency, Any-Output Jitter Attenuator/Clock Multiplier," Si5345/44/42 Rev D Data Sheet, July 2016 Revised [Sept. 2018].

[4] A. Grob, "Setting Standards: The IEC 60601 Series: Quick-Use Guide," Biomedical Instrumentation & Technology, vol. 54, (3), pp. 220-222, 2020. Available: https://ezproxy.tntech.edu/login?url=https://www.proquest.com/scholarly-journals/i-setting-standards-iec-60601-series-quick-use/docview/2414388374/se-2. DOI: https://doi.org/10.2345/0899-8205-54.3.220.

[5] infineon, "SIPMOS Small-Signal-Transistor," BSP316P Rev 2 Data Sheet, Aug. 2015 Revised [June. 2016].