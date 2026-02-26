$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$localeTwoLetter = (Get-UICulture).TwoLetterISOLanguageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\DisplayFusionSetup-12.0.2.exe"
  softwareName   = 'displayfusion*'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP-  /LANG=$localeTwoLetter /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
