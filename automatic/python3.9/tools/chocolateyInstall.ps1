$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$targetDir = "$($Env:SystemDrive)\Python39"
if ((Get-OSArchitectureWidth 32) -or $env:ChocolateyForceX86 -eq 'true') {
    $targetDir += '-32'
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\"
  file64         = "$toolsPath\"
  silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $targetDir
  validExitCodes = @(0)
  softwareName   = 'Python 3.9.*'
}

Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
Install-BinFile $env:ChocolateyPackageName "$targetDir\python.exe"
