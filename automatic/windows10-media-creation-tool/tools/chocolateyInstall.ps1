$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = ''
  Checksum     = ''
  ChecksumType = ''
}
Get-ChocolateyWebFile @packageArgs

$AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$($exeName)"
If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value "$($packageArgs.FileFullPath)" -Force
Set-ItemProperty -Path $AppPathKey -Name "Path" -Value "$toolsDir" -Force

Write-Output "******************************************************************************************************************"
Write-Output "*  INSTRUCTIONS: In a prompt type `"$exeName`" to start the Windows 10 Media Creation Tool.           *"
Write-Output "*  You may also type `"$exeName`" in the search prompt of your start menu                             *"
Write-Output "******************************************************************************************************************"
