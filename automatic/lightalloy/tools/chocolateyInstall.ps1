$ErrorActionPreference = 'Stop'

$toolsPath     = Split-Path $MyInvocation.MyCommand.Definition
$ahk		   = Join-Path $toolsPath 'lightalloy.ahk'
$embedded_path = gi "$toolsPath\*.exe"

Write-Output "Running AutoHotkey script"
Start-ChocolateyProcessAsAdmin "`"$ahk`" `"$embedded_path`"" 'AutoHotkey.exe'

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}