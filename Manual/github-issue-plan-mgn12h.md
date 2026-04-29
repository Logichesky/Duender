# GitHub Issue Plan: Duender MGN12H Build

This document defines a practical GitHub issue structure for building a Duender in the MGN12H configuration.

Use one parent meta issue and a set of ordered child issues. Each child issue should use the build task template so every step has separate print, order, and assembly checklists.

## Recommended Labels

- `meta`
- `build`
- `mgn12h`
- `print`
- `assembly`
- `ordering`
- `blocked`

## Parent Issue

Title: `[META] Build Duender MGN12H`

Suggested checklist:

- [ ] #<issue-number> Audit donor printers and reusable parts
- [ ] #<issue-number> Order MGN12H rails and missing motion hardware
- [ ] #<issue-number> Print XY Axis MGN12H parts
- [ ] #<issue-number> Assemble XY Axis MGN12H
- [ ] #<issue-number> Print Z Axis MGN12H parts
- [ ] #<issue-number> Assemble Z Axis MGN12H
- [ ] #<issue-number> Print electronics enclosures and mounts
- [ ] #<issue-number> Order electronics, wiring, and remaining hardware
- [ ] #<issue-number> Assemble electronics and control box
- [ ] #<issue-number> Print extruder and toolhead parts
- [ ] #<issue-number> Assemble Sherpa Mini, Dragon Burner, and MGN12H carriage
- [ ] #<issue-number> Final frame integration, belts, and wiring
- [ ] #<issue-number> First power-on, firmware, and baseline tuning

## Print Order

Print the mechanical motion parts before support parts and cosmetic parts.

1. XY Axis MGN12H parts
2. Z Axis MGN12H parts
3. Electronics boxes and mounts
4. Extruder and toolhead parts
5. Optional covers and cosmetic parts

## Child Issues

### 1. Audit donor printers and reusable parts

Labels: `build`, `ordering`

Purpose:
Confirm what can be reused from the two donor printers before ordering missing parts.

Subtasks:

- [ ] Identify both donor printers and their exact hardware differences
- [ ] Confirm the frame parts that will be reused
- [ ] Confirm motors, power supplies, endstops, fans, and hotend parts available on hand
- [ ] Confirm whether the control path will use Manta M5P or RPi plus SKR E3 Mini
- [ ] Record missing rails, pulleys, belts, fasteners, spacers, and wiring

### 2. Order MGN12H rails and missing motion hardware

Labels: `build`, `ordering`, `mgn12h`

Purpose:
Order the mandatory motion hardware before starting assembly-critical prints.

Subtasks:

- [ ] Order the MGN12H rails and carriages required for the selected build
- [ ] Order missing belt path hardware, including pulleys and idlers
- [ ] Order missing fasteners, heat-set inserts, and spacers
- [ ] Confirm all ordered motion hardware against the selected STEP kit

### 3. Print XY Axis MGN12H parts

Labels: `build`, `print`, `mgn12h`

Print these first:

- [ ] `STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H L/X 1 MGN12H L.stl`
- [ ] `STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H L/X 2 MGN12H L.stl`
- [ ] `STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H L/9.5mm Spacer.stl`
- [ ] `STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H R/X 1 MGN12H R.stl`
- [ ] `STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H R/X 2 MGN12H R.stl`
- [ ] `STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H R/9.5mm Spacer.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H L/Y Back 1 MGN12H L.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H L/Y Back 2 MGN12H L.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H L/9.5mm Spacer.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H R/Y Back 1 MGN12H R.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H R/Y Back 2 MGN12H R.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H R/9.5mm Spacer.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H L/Y Front MGN12H L.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H L/Tensioner 1 L.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H L/Tensioner 2 L.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H R/Y Front MGN12H R.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H R/Tensioner 1 R.stl`
- [ ] `STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H R/Tensioner 2 R.stl`

### 4. Assemble XY Axis MGN12H

Labels: `build`, `assembly`, `mgn12h`

Subtasks:

- [ ] Verify all left and right XY parts are printed and dimensionally usable
- [ ] Install the X mounts on the MGN12H X carriage path
- [ ] Assemble the Y front and Y back structures on both sides
- [ ] Install spacers, tensioner parts, and idler hardware
- [ ] Verify full XY travel without binding before moving to Z

### 5. Print Z Axis MGN12H parts

Labels: `build`, `print`, `mgn12h`

Print after XY:

- [ ] `STLs/Z Axis MGN12H/Z Axis MGN12H L/Bed Hold L.stl`
- [ ] `STLs/Z Axis MGN12H/Z Axis MGN12H L/Z Mount L.stl`
- [ ] `STLs/Z Axis MGN12H/Z Axis MGN12H L/Z Top Mount L.stl`
- [ ] `STLs/Z Axis MGN12H/Z Axis MGN12H R/Bed Hold R.stl`
- [ ] `STLs/Z Axis MGN12H/Z Axis MGN12H R/Z Mount R.stl`
- [ ] `STLs/Z Axis MGN12H/Z Axis MGN12H R/Z Top Mount R.stl`

### 6. Assemble Z Axis MGN12H

Labels: `build`, `assembly`, `mgn12h`

Subtasks:

- [ ] Install left and right Z mounts
- [ ] Install top Z mounts and bed holds
- [ ] Confirm Z rail alignment and bed support geometry
- [ ] Verify synchronized movement before mounting the rest of the build

### 7. Print electronics enclosures and mounts

Labels: `build`, `print`

Choose only the controller path you will use.

Print options:

- [ ] `STLs/Electronics/Box Manta M5P/Manta Box Main.stl`
- [ ] `STLs/Electronics/Box Manta M5P/Manta Box Cover.stl`
- [ ] `STLs/Electronics/Box Rpi + SKR E3 mini/Electronic Box Main.stl`
- [ ] `STLs/Electronics/Box Rpi + SKR E3 mini/Electronc Box Cover.stl`
- [ ] `STLs/Electronics/BTT HDMI5 Mount/HDMI5 Mount Main.stl`
- [ ] `STLs/Electronics/BTT HDMI5 Mount/HDMI5  mount frame.stl`
- [ ] `STLs/Electronics/BTT TFT35-SPI Mount/TFT35 Main.stl`
- [ ] `STLs/Electronics/BTT TFT35-SPI Mount/TFT35 Front Cover.stl`
- [ ] `STLs/Electronics/BTT TFT35-SPI Mount/Duender Logo.stl`

### 8. Order electronics, wiring, and remaining hardware

Labels: `build`, `ordering`

Subtasks:

- [ ] Order only the electronics path selected in issue 1
- [ ] Order missing display hardware if using HDMI5 or TFT35-SPI
- [ ] Order missing wiring, connectors, ferrules, and cable management parts
- [ ] Confirm PSU, board, Pi, display, fans, and probes are available or ordered

### 9. Assemble electronics and control box

Labels: `build`, `assembly`

Subtasks:

- [ ] Assemble the chosen control box
- [ ] Mount controller, power, and interface hardware
- [ ] Route wiring with service loops and strain relief
- [ ] Verify fan clearance and enclosure fit before final mounting

### 10. Print extruder and toolhead parts

Labels: `build`, `print`, `mgn12h`

Print after the motion system is committed:

- [ ] `STLs/Extruder/MGN12H Mount/Carriage _Bases_1 (1).stl`
- [ ] `STLs/Extruder/MGN12H Mount/MGN12H_X_Carriage_Lite.stl`
- [ ] `STLs/Extruder/Dragonburner_Bambu_Sherpa/Bambu_Mount.stl`
- [ ] `STLs/Extruder/Dragonburner_Bambu_Sherpa/Cowl.stl`
- [ ] `STLs/Extruder/Dragonburner_Bambu_Sherpa/Cowl Bltouch.stl`
- [ ] `STLs/Extruder/Dragonburner_Bambu_Sherpa/Sherpa_Mini_Mount.stl`
- [ ] `STLs/Extruder/Sherpa Mini/housing_core_std^housing_sherpa_mini_a3_r17_FDM.stl`
- [ ] `STLs/Extruder/Sherpa Mini/housing_front^housing_sherpa_mini_a3_r17_FDM.stl`
- [ ] `STLs/Extruder/Sherpa Mini/housing_rear_nema14^housing_sherpa_mini_a3_r17_FDM.stl`
- [ ] `STLs/Extruder/Sherpa Mini/idler_arm_long^housing_sherpa_mini_a3_r17_FDM.stl`

### 11. Assemble Sherpa Mini, Dragon Burner, and MGN12H carriage

Labels: `build`, `assembly`, `mgn12h`

Subtasks:

- [ ] Assemble the Sherpa Mini extruder body
- [ ] Assemble the Dragon Burner toolhead shell and fan parts
- [ ] Install the MGN12H carriage mount
- [ ] Mount the complete toolhead on the XY carriage
- [ ] Verify toolhead clearance through the full XY range

### 12. Final frame integration, belts, and wiring

Labels: `build`, `assembly`

Subtasks:

- [ ] Integrate the motion system into the reused frame structure
- [ ] Install and tension belts
- [ ] Complete final wiring and cable management
- [ ] Verify endstop, probe, and fan placement
- [ ] Perform a manual motion check on all axes

### 13. First power-on, firmware, and baseline tuning

Labels: `build`, `assembly`

Subtasks:

- [ ] Verify wiring continuity and PSU polarity before power-on
- [ ] Power on with the motion system unloaded where practical
- [ ] Flash or configure the selected firmware stack
- [ ] Confirm motor directions, endstops, probe, and heaters
- [ ] Run initial motion tests and baseline tuning for the MGN12H setup

## Notes

- This issue plan is derived from the current repository structure and STL layout.
- The full manual and BOM are not yet fully integrated into the repository, so ordering issues should be updated as the BOM is finalized.
- If you want finer granularity later, split any child issue into separate `print`, `order`, and `assembly` issues while keeping the same parent meta issue.