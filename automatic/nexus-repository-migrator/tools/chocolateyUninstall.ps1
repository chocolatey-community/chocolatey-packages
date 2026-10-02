$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

Uninstall-BinFile -Name "ConvertFrom-NexusOrientDb" -Path $toolsDir\ConvertFrom-NexusOrientDb.ps1