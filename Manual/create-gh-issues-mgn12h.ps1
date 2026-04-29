Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repo = 'Logichesky/Duender'

function Invoke-Gh {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [switch]$AllowFailure
    )

    $output = & gh @Arguments 2>&1 | Out-String
    if (-not $AllowFailure -and $LASTEXITCODE -ne 0) {
        throw $output.Trim()
    }

    return $output.Trim()
}

function Ensure-Label {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$Color,
        [Parameter(Mandatory = $true)]
        [string]$Description
    )

    $result = Invoke-Gh -Arguments @('label', 'create', $Name, '--repo', $repo, '--color', $Color, '--description', $Description) -AllowFailure
    if ($LASTEXITCODE -ne 0 -and $result -notmatch 'already exists') {
        throw $result
    }
}

function New-Issue {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,
        [Parameter(Mandatory = $true)]
        [string]$Body,
        [Parameter(Mandatory = $true)]
        [string[]]$Labels
    )

    $args = @('issue', 'create', '--repo', $repo, '--title', $Title, '--body', $Body)
    foreach ($label in $Labels) {
        $args += @('--label', $label)
    }

    $url = Invoke-Gh -Arguments $args
    if ($url -notmatch '/issues/(\d+)') {
        throw "Could not parse issue number from output: $url"
    }

    [PSCustomObject]@{
        Number = [int]$Matches[1]
        Url = $url
        Title = $Title
    }
}

Invoke-Gh -Arguments @('repo', 'set-default', $repo) | Out-Null
Invoke-Gh -Arguments @('repo', 'edit', $repo, '--enable-issues') | Out-Null

$labels = @(
    @{ Name = 'meta'; Color = '5319e7'; Description = 'Parent tracking issues and project-level coordination' },
    @{ Name = 'build'; Color = '0e8a16'; Description = 'Build tasks for the Duender project' },
    @{ Name = 'mgn12h'; Color = '1d76db'; Description = 'Tasks specific to the MGN12H configuration' },
    @{ Name = 'print'; Color = 'fbca04'; Description = '3D printing tasks and print batches' },
    @{ Name = 'assembly'; Color = 'c2e0c6'; Description = 'Mechanical or electrical assembly tasks' },
    @{ Name = 'ordering'; Color = 'f9d0c4'; Description = 'Parts sourcing and ordering tasks' },
    @{ Name = 'blocked'; Color = 'b60205'; Description = 'Work blocked by missing parts or dependencies' }
)

foreach ($label in $labels) {
    Ensure-Label -Name $label.Name -Color $label.Color -Description $label.Description
}

$parentSeedBody = @"
Parent tracker for building a Duender in the MGN12H configuration.

Child issues will be linked here after creation.

Recommended print-first order:

1. XY Axis MGN12H structural parts
2. Z Axis MGN12H structural parts
3. Electronics boxes and mounts
4. Extruder and toolhead parts
5. Optional covers and cosmetic parts
"@

$parent = New-Issue -Title '[META] Build Duender MGN12H' -Body $parentSeedBody -Labels @('meta', 'build', 'mgn12h')

$childIssues = @(
    @{
        Title = '[BUILD] Audit donor printers and reusable parts'
        Labels = @('build', 'ordering')
        Body = @"
## Scope

Confirm what can be reused from the two donor printers before ordering missing parts.

## Depends On

- Parent issue: #$($parent.Number)

## Order

- [ ] Identify both donor printers and note any hardware differences
- [ ] Confirm frame parts available for reuse
- [ ] Confirm motors, PSUs, endstops, fans, hotend parts, and wiring on hand
- [ ] Decide whether the control path will use Manta M5P or RPi plus SKR E3 Mini
- [ ] Record all missing rails, pulleys, belts, fasteners, spacers, and wiring

## Done When

- [ ] Reusable hardware is inventoried
- [ ] Missing hardware is clearly listed for the next ordering issue
"@
    },
    @{
        Title = '[BUILD] Order MGN12H rails and missing motion hardware'
        Labels = @('build', 'ordering', 'mgn12h')
        Body = @"
## Scope

Order the mandatory motion hardware for the MGN12H build.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: #$($parent.Number) tracker, donor audit

## Order

- [ ] Order the MGN12H rails and carriages required for the selected build
- [ ] Order missing belt path hardware, including pulleys and idlers
- [ ] Order missing fasteners, inserts, and spacers
- [ ] Confirm ordered motion hardware against the selected STEP kit

## Done When

- [ ] Motion hardware is ordered
- [ ] Delivery risk for XY and Z assembly is known
"@
    },
    @{
        Title = '[BUILD] Print XY Axis MGN12H parts'
        Labels = @('build', 'print', 'mgn12h')
        Body = @"
## Scope

Print the primary XY structural parts first for the MGN12H path.

## Depends On

- Parent issue: #$($parent.Number)

## Print

- [ ] STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H L/X 1 MGN12H L.stl
- [ ] STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H L/X 2 MGN12H L.stl
- [ ] STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H L/9.5mm Spacer.stl
- [ ] STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H R/X 1 MGN12H R.stl
- [ ] STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H R/X 2 MGN12H R.stl
- [ ] STLs/XY Axis MGN12H/X Axis MGN12H/X Mount MGN12H R/9.5mm Spacer.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H L/Y Back 1 MGN12H L.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H L/Y Back 2 MGN12H L.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H L/9.5mm Spacer.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H R/Y Back 1 MGN12H R.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H R/Y Back 2 MGN12H R.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Back MGN12H R/9.5mm Spacer.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H L/Y Front MGN12H L.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H L/Tensioner 1 L.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H L/Tensioner 2 L.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H R/Y Front MGN12H R.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H R/Tensioner 1 R.stl
- [ ] STLs/XY Axis MGN12H/Y Axis MGN12H/Y Front MGN12H R/Tensioner 2 R.stl

## Done When

- [ ] All XY MGN12H print parts are complete and usable
- [ ] The assembly issue can start without re-slicing parts
"@
    },
    @{
        Title = '[BUILD] Assemble XY Axis MGN12H'
        Labels = @('build', 'assembly', 'mgn12h')
        Body = @"
## Scope

Assemble the full XY motion structure for the MGN12H configuration.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: print XY parts, motion hardware order

## Assembly

- [ ] Verify all left and right XY parts are printed and dimensionally usable
- [ ] Install the X mounts on the MGN12H X carriage path
- [ ] Assemble the Y front and Y back structures on both sides
- [ ] Install spacers, tensioners, and idler hardware
- [ ] Verify full XY travel without binding

## Done When

- [ ] XY motion is assembled
- [ ] Travel is smooth enough to proceed to Z assembly
"@
    },
    @{
        Title = '[BUILD] Print Z Axis MGN12H parts'
        Labels = @('build', 'print', 'mgn12h')
        Body = @"
## Scope

Print the Z structural parts after the XY batch.

## Depends On

- Parent issue: #$($parent.Number)

## Print

- [ ] STLs/Z Axis MGN12H/Z Axis MGN12H L/Bed Hold L.stl
- [ ] STLs/Z Axis MGN12H/Z Axis MGN12H L/Z Mount L.stl
- [ ] STLs/Z Axis MGN12H/Z Axis MGN12H L/Z Top Mount L.stl
- [ ] STLs/Z Axis MGN12H/Z Axis MGN12H R/Bed Hold R.stl
- [ ] STLs/Z Axis MGN12H/Z Axis MGN12H R/Z Mount R.stl
- [ ] STLs/Z Axis MGN12H/Z Axis MGN12H R/Z Top Mount R.stl

## Done When

- [ ] All Z MGN12H print parts are complete and usable
"@
    },
    @{
        Title = '[BUILD] Assemble Z Axis MGN12H'
        Labels = @('build', 'assembly', 'mgn12h')
        Body = @"
## Scope

Assemble the Z motion components for the MGN12H configuration.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: print Z parts, motion hardware order

## Assembly

- [ ] Install left and right Z mounts
- [ ] Install top Z mounts and bed holds
- [ ] Confirm Z rail alignment and bed support geometry
- [ ] Verify synchronized movement before final integration

## Done When

- [ ] Z axis is mechanically assembled
- [ ] The frame integration step can begin once XY is also complete
"@
    },
    @{
        Title = '[BUILD] Print electronics enclosures and mounts'
        Labels = @('build', 'print')
        Body = @"
## Scope

Print the electronics enclosure and display mount parts after the motion system parts.

## Depends On

- Parent issue: #$($parent.Number)

## Print

- [ ] Choose one controller path: Manta M5P or RPi plus SKR E3 Mini
- [ ] STLs/Electronics/Box Manta M5P/Manta Box Main.stl
- [ ] STLs/Electronics/Box Manta M5P/Manta Box Cover.stl
- [ ] STLs/Electronics/Box Rpi + SKR E3 mini/Electronic Box Main.stl
- [ ] STLs/Electronics/Box Rpi + SKR E3 mini/Electronc Box Cover.stl
- [ ] STLs/Electronics/BTT HDMI5 Mount/HDMI5 Mount Main.stl
- [ ] STLs/Electronics/BTT HDMI5 Mount/HDMI5  mount frame.stl
- [ ] STLs/Electronics/BTT TFT35-SPI Mount/TFT35 Main.stl
- [ ] STLs/Electronics/BTT TFT35-SPI Mount/TFT35 Front Cover.stl
- [ ] STLs/Electronics/BTT TFT35-SPI Mount/Duender Logo.stl

## Done When

- [ ] The chosen electronics enclosure path is printed
- [ ] Optional display hardware is printed if needed
"@
    },
    @{
        Title = '[BUILD] Order electronics, wiring, and remaining hardware'
        Labels = @('build', 'ordering')
        Body = @"
## Scope

Order the electronics path, display parts, and wiring that are not being reused.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: donor audit

## Order

- [ ] Order only the selected controller path hardware
- [ ] Order display hardware if using HDMI5 or TFT35-SPI
- [ ] Order missing wiring, connectors, ferrules, and cable management parts
- [ ] Confirm PSU, board, Pi, display, fans, and probes are available or ordered

## Done When

- [ ] Electronics sourcing is complete
- [ ] The electronics assembly step is unblocked
"@
    },
    @{
        Title = '[BUILD] Assemble electronics and control box'
        Labels = @('build', 'assembly')
        Body = @"
## Scope

Assemble and mount the selected electronics enclosure and control hardware.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: print electronics parts, electronics ordering

## Assembly

- [ ] Assemble the chosen control box
- [ ] Mount controller, power, and interface hardware
- [ ] Route wiring with service loops and strain relief
- [ ] Verify fan clearance and enclosure fit

## Done When

- [ ] Electronics are mounted cleanly and safely
- [ ] Final machine wiring can proceed
"@
    },
    @{
        Title = '[BUILD] Print extruder and toolhead parts'
        Labels = @('build', 'print', 'mgn12h')
        Body = @"
## Scope

Print the MGN12H carriage, Dragon Burner, and Sherpa Mini parts after the core motion system is committed.

## Depends On

- Parent issue: #$($parent.Number)

## Print

- [ ] STLs/Extruder/MGN12H Mount/Carriage _Bases_1 (1).stl
- [ ] STLs/Extruder/MGN12H Mount/MGN12H_X_Carriage_Lite.stl
- [ ] STLs/Extruder/Dragonburner_Bambu_Sherpa/Bambu_Mount.stl
- [ ] STLs/Extruder/Dragonburner_Bambu_Sherpa/Cowl.stl
- [ ] STLs/Extruder/Dragonburner_Bambu_Sherpa/Cowl Bltouch.stl
- [ ] STLs/Extruder/Dragonburner_Bambu_Sherpa/Sherpa_Mini_Mount.stl
- [ ] STLs/Extruder/Sherpa Mini/housing_core_std^housing_sherpa_mini_a3_r17_FDM.stl
- [ ] STLs/Extruder/Sherpa Mini/housing_front^housing_sherpa_mini_a3_r17_FDM.stl
- [ ] STLs/Extruder/Sherpa Mini/housing_rear_nema14^housing_sherpa_mini_a3_r17_FDM.stl
- [ ] STLs/Extruder/Sherpa Mini/idler_arm_long^housing_sherpa_mini_a3_r17_FDM.stl

## Done When

- [ ] All toolhead and extruder print parts are complete and usable
"@
    },
    @{
        Title = '[BUILD] Assemble Sherpa Mini, Dragon Burner, and MGN12H carriage'
        Labels = @('build', 'assembly', 'mgn12h')
        Body = @"
## Scope

Assemble the toolhead and mount it to the MGN12H carriage.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: print extruder and toolhead parts

## Assembly

- [ ] Assemble the Sherpa Mini extruder body
- [ ] Assemble the Dragon Burner shell and fan parts
- [ ] Install the MGN12H carriage mount
- [ ] Mount the complete toolhead on the XY carriage
- [ ] Verify clearance through the full XY range

## Done When

- [ ] Toolhead is mechanically complete
- [ ] The printer is ready for final integration
"@
    },
    @{
        Title = '[BUILD] Final frame integration, belts, and wiring'
        Labels = @('build', 'assembly')
        Body = @"
## Scope

Integrate the motion system, belts, electronics, and wiring into the reused frame.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: XY assembly, Z assembly, electronics assembly, toolhead assembly

## Assembly

- [ ] Integrate the motion system into the reused frame structure
- [ ] Install and tension belts
- [ ] Complete final wiring and cable management
- [ ] Verify endstop, probe, and fan placement
- [ ] Perform a manual motion check on all axes

## Done When

- [ ] The printer is fully assembled
- [ ] The machine is ready for first power-on
"@
    },
    @{
        Title = '[BUILD] First power-on, firmware, and baseline tuning'
        Labels = @('build', 'assembly', 'mgn12h')
        Body = @"
## Scope

Bring the MGN12H build online safely and complete baseline setup.

## Depends On

- Parent issue: #$($parent.Number)
- Blocking issues: final integration

## Assembly

- [ ] Verify wiring continuity and PSU polarity before power-on
- [ ] Power on with the motion system unloaded where practical
- [ ] Flash or configure the selected firmware stack
- [ ] Confirm motor directions, endstops, probe, and heaters
- [ ] Run initial motion tests and baseline tuning for the MGN12H setup

## Done When

- [ ] The machine powers on safely
- [ ] Baseline motion and configuration checks are complete
"@
    }
)

$createdChildren = foreach ($issue in $childIssues) {
    New-Issue -Title $issue.Title -Body $issue.Body -Labels $issue.Labels
}

$parentBody = @"
Parent tracker for building a Duender in the MGN12H configuration.

Close child issues in order.

## Build Order

- [ ] #$($createdChildren[0].Number) Audit donor printers and reusable parts
- [ ] #$($createdChildren[1].Number) Order MGN12H rails and missing motion hardware
- [ ] #$($createdChildren[2].Number) Print XY Axis MGN12H parts
- [ ] #$($createdChildren[3].Number) Assemble XY Axis MGN12H
- [ ] #$($createdChildren[4].Number) Print Z Axis MGN12H parts
- [ ] #$($createdChildren[5].Number) Assemble Z Axis MGN12H
- [ ] #$($createdChildren[6].Number) Print electronics enclosures and mounts
- [ ] #$($createdChildren[7].Number) Order electronics, wiring, and remaining hardware
- [ ] #$($createdChildren[8].Number) Assemble electronics and control box
- [ ] #$($createdChildren[9].Number) Print extruder and toolhead parts
- [ ] #$($createdChildren[10].Number) Assemble Sherpa Mini, Dragon Burner, and MGN12H carriage
- [ ] #$($createdChildren[11].Number) Final frame integration, belts, and wiring
- [ ] #$($createdChildren[12].Number) First power-on, firmware, and baseline tuning

## Recommended Print-First Sequence

1. XY Axis MGN12H structural parts
2. Z Axis MGN12H structural parts
3. Electronics boxes and mounts
4. Extruder and toolhead parts
5. Optional covers and cosmetic parts
"@

Invoke-Gh -Arguments @('issue', 'edit', $parent.Number.ToString(), '--repo', $repo, '--body', $parentBody) | Out-Null

Write-Host "Created parent issue: $($parent.Url)"
foreach ($child in $createdChildren) {
    Write-Host "Created child issue: $($child.Url)"
}