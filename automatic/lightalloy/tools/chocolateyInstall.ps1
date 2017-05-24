$ErrorActionPreference = 'Stop'

$toolsPath     = Split-Path $MyInvocation.MyCommand.Definition
$au3		   = Join-Path $toolsPath 'lightalloy.au3'
$embedded_path = gi "$toolsDir\*.exe"

Write-Output "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "`"$au3`" `"$tempFile`"" 'AutoIt3.exe'

ls $toolsDir\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" }}