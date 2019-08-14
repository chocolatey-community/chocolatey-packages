$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$Installer = (Get-ChildItem $toolsDir -filter "*.exe").FullName

$packageArgs = @{
   packageName   = $env:ChocolateyPackageName
   file          = $Installer
   fileType      = "exe"
   silentArgs    = "/S /allusers"
   validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

New-Item "$Installer.ignore" -Type file -Force | Out-Null
