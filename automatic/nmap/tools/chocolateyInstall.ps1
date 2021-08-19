$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$file = "$toolsPath\nmap-7.92-setup.exe"
Start-Process -Wait $toolsPath\install.ahk $file

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}
