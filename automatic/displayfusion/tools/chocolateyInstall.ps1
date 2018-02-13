$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$localeTwoLetter = (Get-UICulture).TwoLetterISOLanguageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\"
  softwareName   = 'displayfusion*'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP-  /LANG=$localeTwoLetter /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyInstallPackage @packageArgs

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }
