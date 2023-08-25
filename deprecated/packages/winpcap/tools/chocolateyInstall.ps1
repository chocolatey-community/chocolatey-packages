$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file = "$toolsPath\WinPcap_4_1_3.exe"

Write-Output "Running Autohotkey installer"
$ahkScript = "$toolsPath\winpcapInstall.ahk"

# program cannot install properly on top of itself
# so if already installed (running choco install winpap --force)
# we first remove it
$softwareNamePattern = 'WinPcap*'
[array] $key = Get-UninstallRegistryKey $softwareNamePattern
if ($key.Count -eq 1) {
	$key | ForEach-Object {
		AutoHotkey $ahkScript uninstall $_.UninstallString
	}
}

AutoHotkey $ahkScript install $file
