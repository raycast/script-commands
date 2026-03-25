#!/usr/bin/env pwsh
# @raycast.schemaVersion 1
# @raycast.title Increase Brightness
# @raycast.mode compact
# @raycast.platform windows


# @raycast.icon ⬆️
# @raycast.packageName System
# @raycast.description Increase screen brightness by a given percentage.
# @raycast.author muhammadrizo
# @raycast.authorURL https://raycast.com/muhammadrizo

# @raycast.argument1 { "type": "text", "placeholder": "Increase by (%) – default 10", "optional": true }

param(
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$Delta
)

if ([string]::IsNullOrWhiteSpace($Delta)) {
    $Delta = "10"
}

[int]$DeltaInt = $Delta

$brightnessInfo = Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightness
$current = $brightnessInfo.CurrentBrightness

$new = $current + $DeltaInt
if ($new -lt 0) { $new = 0 }
if ($new -gt 100) { $new = 100 }

$methods = Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightnessMethods
$methods.WmiSetBrightness(1, [byte]$new)

Write-Output "Set to: $new"