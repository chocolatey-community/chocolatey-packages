$ErrorActionPreference = 'Stop'

$programFiles = Join-Path ${env:ProgramFiles(x86)} 'DisplayFusion'
$localeTwoLetter = (Get-Culture).TwoLetterISOLanguageName
$arguments = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'DisplayFusion'
  url            = 'https://binaryfortressdownloads.com/Download/BFSFiles/101/DisplayFusionSetup-9.1.exe'
  checksum       = '8f1cfafda844c018a87fc216b38bc38c69269a1a0798bdd1b41cca17f9ed6c08'
  fileType       = 'exe'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$programFiles`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
