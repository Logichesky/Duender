name: "Build Tracker: MGN12H"
about: "Parent issue for building a Duender in the MGN12H configuration."
title: "[META] Build Duender MGN12H"
labels: ["meta", "build", "mgn12h"]
assignees: []
---

# Build Tracker: Duender MGN12H

Use this parent issue to track the full MGN12H build. Create the child issues below, link them back here, and close them in order.

## Build Order

### 1. Project Setup and Hardware Gate
- [ ] Create child issue: donor printer audit and reusable parts check
- [ ] Create child issue: order MGN12H rails, motion hardware, belts, pulleys, and missing fasteners

### 2. Print the MGN12H Motion Parts First
- [ ] Create child issue: print XY Axis MGN12H parts
- [ ] Create child issue: assemble XY Axis MGN12H
- [ ] Create child issue: print Z Axis MGN12H parts
- [ ] Create child issue: assemble Z Axis MGN12H

### 3. Print and Prepare Electronics Parts
- [ ] Create child issue: print electronics enclosures and display mounts
- [ ] Create child issue: order electronics, wiring, and remaining control hardware
- [ ] Create child issue: assemble and mount electronics

### 4. Print and Assemble the Toolhead
- [ ] Create child issue: print extruder and toolhead parts for MGN12H
- [ ] Create child issue: assemble Sherpa Mini, Dragon Burner, and MGN12H carriage mount

### 5. Final Integration
- [ ] Create child issue: final frame integration, belts, wiring, and motion checks
- [ ] Create child issue: first power-on, firmware setup, and baseline tuning

## Recommended Print-First Sequence

Print these groups before cosmetic or optional parts:

1. XY Axis MGN12H structural parts
2. Z Axis MGN12H structural parts
3. Electronics boxes and mounts
4. Extruder and toolhead parts
5. Covers, logos, and optional finish parts

---

## Notes

- Use the child issue template for every build step so print, order, and assembly subtasks stay consistent.
- The current repository contains the part structure, but the full BOM is still external to the repo. Keep ordering issues focused on the parts you cannot reuse from the donor printers.
- For the exact issue list and the STL grouping used for the MGN12H path, copy from `Manual/github-issue-plan-mgn12h.md`.