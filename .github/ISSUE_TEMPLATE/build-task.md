---
name: "Build Task"
about: "Child issue for a specific Duender build step."
title: "[BUILD] "
labels: ["build"]
assignees: []
---

## Scope

Describe the build step in one sentence.

## Depends On

- Parent issue: #
- Blocking issues: 

## Print

- [ ] Confirm the part set for this step
- [ ] Slice all required STL files
- [ ] Print required parts
- [ ] Reprint failed or weak parts if needed

## Order

- [ ] Identify non-reused hardware required for this step
- [ ] Add missing hardware and consumables to the BOM
- [ ] Order missing parts
- [ ] Verify received parts match the build step

## Assembly

- [ ] Dry-fit printed parts
- [ ] Complete mechanical assembly
- [ ] Verify alignment, travel, and clearances
- [ ] Document any deviations from the default build

## Done When

- [ ] This step is mechanically complete
- [ ] This step is ready for the next issue in the build order

## References

- STEP/STL folders:
- Manual/BOM references: