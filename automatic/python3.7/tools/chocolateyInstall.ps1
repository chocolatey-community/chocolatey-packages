$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$targetDir = "$($Env:SystemDrive)\Python37"
if ((Get-OSArchitectureWidth 32) -or $env:ChocolateyForceX86 -eq 'true') {
    $targetDir += '-32'
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\python-3.7.9.exe"
  file64         = "$toolsPath\python-3.7.9-amd64.exe"
  silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $targetDir
  validExitCodes = @(0)
  softwareName   = 'Python 3.7.*'
}

Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
Install-BinFile $env:ChocolateyPackageName "$targetDir\python.exe"
