$PackageName = 'windows10-media-creation-tool'
$exeName = "MediaCreationTool.exe"
$url = 'http://go.microsoft.com/fwlink/?LinkId=691209'
$Checksum = '2a1a018652a554c16dcccabd228961205e9064581e12c00fbd6ebcf541d0bcf5'
$ChecksumType = 'sha256'
$validExitCodes = @(0)
$packageArgs = @{
  PackageName   = $PackageName
  FileFullPath  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\$exeName"
  Url           = $url
  Checksum      = $Checksum
  ChecksumType  = $ChecksumType
  }
Get-ChocolateyWebFile @packageArgs

$AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value "$env:chocolateyinstall\lib\$packagename\tools\$exeName" -Force
Set-ItemProperty -Path $AppPathKey -Name "Path" -Value "$env:chocolateyinstall\lib\$packagename\tools\" -Force

Write-Output "******************************************************************************************************************"
Write-Output "*  INSTRUCTIONS: In a prompt type `"$exeName`" to start the Windows 10 Media Creation Tool.           *"
Write-Output "*  You may also type `"$exeName`" in the search prompt of your start menu                             *"
Write-Output "******************************************************************************************************************"
