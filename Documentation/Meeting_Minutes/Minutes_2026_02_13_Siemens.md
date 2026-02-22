# Minutes of Siemens Meeting on 2026-02-13
**Started at 8:35 AM**

## Roll Call
Levi Cantrell
Tyler Chan
Jonas Cross
Ryan Shipwash

Harrison Rudd was tardy but excused

## Business
- Introductions
- Questions pasted Below
- Still need a DCS-doesn't replace DCS.
- 2.5MHz has been settled on 
- 100 W is the target for Bias Tee 
- Hyperlinx can do simulations
- Required to use Si5345B
- Jitter needs to be low not only between input output but also between two different device outputs
- Focus 3 has high risk for scope creep. UART Speed is fine.
- Jitter is most important thing.
- Boards designed before summer would be particularly easy
- 



## Questions for Siemens
- What specifications for our power supply?
  - We don't need to build power supply. 
  - What will we be given then?
    - Switching Power Supplies
    - Will provide specs later
    - We will need to use 48VDC to power RF side
- What other I/O will we have?
  - PoE is another version of same concept. 
  - Connectors are up to us.
  - Make clock measurement easy (SMA for both input clock and output)
  - Header for some GUI (I missed that)
- Necessity for access to Xpedition tools?
  - Component library
  - Not Impossible, but probably difficult
  - Altium would be fine.
- Any parts we must use?
  - PLL is the only specific part to use.
- Logistics for recurring meetings
  - 9-10:o0 AM Friday biweekly
  - Next Meeting 2026-02-27
- How granular do you want this?
  - Matlab for Sims?
  - Cable type? (Hopefully Coaxial)
    - Provide us with the cables
  - How hard should we push this?
  - They will provide us with sims
- What constraints?
  - Standards
    - They'll worry about that
  - EMI
    - If we want to concern ourselves with it. 
- Budget?
  - Whatever it costs, but about 5 grand is a good amount.
- Are you willing to have us visit your facilities/test our designs if necessary?
  - We can go there
- Describe Team Composition and ask what skills we need
- Any expectations for when we complete which focuses
  - Boards before summer would be ideal, but a reach
- If they provide us materials, how should we cite that? -- Ask Storm first
- Recommendations for resources?
  - How-to-PCB Document
  - Altium Student Course
- Whatever size is convenient (bigger is fine)
- Specific way we want it laid out
  - Look at datasheet
  - Clock synth

**Adjourned at 9:45 AM**
