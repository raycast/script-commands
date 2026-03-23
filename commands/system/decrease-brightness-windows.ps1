#!/usr/bin/env pwsh
# @raycast.schemaVersion 1
# @raycast.title Decrease Brightness
# @raycast.mode compact
# @raycast.platform windows


# @raycast.icon ⬇️
# @raycast.packageName System
# @raycast.description Decrease screen brightness by a given percentage.
# @raycast.author muhammadrizo
# @raycast.authorURL https://raycast.com/muhammadrizo

# @raycast.argument1 { "type": "text", "placeholder": "Decrease by (%) – default 10", "optional": true }

param(
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$Delta
)

if ([string]::IsNullOrWhiteSpace($Delta)) {
    $Delta = "10"
}

[int]$DeltaInt = -[math]::Abs([int]$Delta)

$brightnessInfo = Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightness
$current = $brightnessInfo.CurrentBrightness

$new = $current + $DeltaInt
if ($new -lt 0) { $new = 0 }
if ($new -gt 100) { $new = 100 }

$methods = Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightnessMethods
$methods.WmiSetBrightness(1, [byte]$new)

Write-Output "Set to: $new"