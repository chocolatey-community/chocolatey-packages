$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = gi $toolsPath\*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'TV-Browser*'  
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }

$jreDir = gi $Env:ProgramFiles\AdoptOpenJDK\jdk-11*-jre | select -First 1
if (!$jreDir) { Write-Warning "Couldn't find AdoptOpenJDK JRE folder"; return }

$installDir = Get-AppInstallLocation $packageArgs.softwareName
if (!$installDir) { Write-Warning "Unable to find install directory"; return }

Write-Host "Symlinking AdoptOpenJDK JRE"
#New-Item -Type SymbolicLink -Path $installDir -Value $jreDir
cmd.exe /C mklink /D "$installDir\java" $jreDir
