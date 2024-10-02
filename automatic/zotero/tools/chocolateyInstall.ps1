$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$Installers = Get-ChildItem -Path $toolsPath -Filter '*.exe' |
                  Sort-Object lastwritetime | 
                  Select-Object -Last 2 -ExpandProperty FullName

$packageArgs = @{
   packageName    = $env:ChocolateyPackageName
   softwareName   = "$env:ChocolateyPackageName*"
   fileType       = 'exe'
   file           = $Installers | Where-Object {$_ -match "win32"}
   file64         = $Installers | Where-Object {$_ -match "x64"}
   silentArgs     = '/S'
   validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $Installers -Force -ea 0
