# Minutes of 2026-03-06
**Called to order 9:00 AM**

## Roll Call 
- Levi Cantrell
- Tyler Chan
- Jonas Cross (tardy)
- Harrison Rudd
- Ryan Shipwash

## Meeting Notes 
- sine wave input instead of square wave clock
- Use function generator with BNC cable to provide reference clock (BNC connector?)
- Use 48 standard 48 volt power supply (make it switching benchtop power supply)
	- Use a switcher
- Check if we have access to a 48 V 100 W power supply
	- Put banana jacks or a terminal strip on the board for power
- No large fluctuations in power except for the beginning during startup sequence
	- Make power sequence
	- Biggest current draw is when the high voltage detector power is turned on

- Work with BNC coax connector will be nice since it is smaller
	- May have to use N type if cable would need to be bigger
	- Shielded coax cable would be best
	- Consider cabling more (DB9 cables or other cables with more pins?)
	- Look at/simulate different cable lengths to get more information (probably actually 4-5 meters)
	- Care about relative jitter, not necessarily difference in delta time/length

- IEC 60601 Standards with creepage and clearance
	- Standards for medical devices 
	- Operator protection
	- Check under isolation
- Single Fault testing

- Cabling and size savings makes a big difference in the system

- Back-channel communications is very important actually. This will be done if it gets implemented, either by us or someone else. So make sure we are the ones to do it!
	- Greatly improves troubleshooting for system and diagnostics.
	- Implementation: Just connect a header (USB to UART) or it's completely up to us.
	- Need to decide if the modulation will be performed digitally or in analog. This will greatly influence hardware.
	- Ensure that square waves and sine waves wouldn't interfere with each other
	- Look into filters for pulse shaping 

Take inventory:
- Check if we have equipment. If not, send an email to Josh

Current Solution
- Dual high speed twisted pair USB 3 cables from DCS

**Adjourned 10:00 AM**

