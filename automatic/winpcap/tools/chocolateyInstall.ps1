$ErrorActionPreference = 'Stop'

Write-Output "Running Autohotkey installer"
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$file = "$toolsPath\"
$ahkScript = "$toolsPath\winpcapInstall.ahk"
AutoHotkey $ahkScript install $file
