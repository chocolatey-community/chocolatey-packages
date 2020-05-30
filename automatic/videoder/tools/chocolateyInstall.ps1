$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installer_32 = (Get-ChildItem $toolsDir -filter "Videoder%20Setup%20*_x32.exe").FullName
$installer_64 = (Get-ChildItem $toolsDir -filter "Videoder%20Setup%20*_x64.exe").FullName

$packageArgs = @{
   packageName   = $env:ChocolateyPackageName
   file          = $installer_32
   file64        = $installer_64
   fileType      = "exe"
   silentArgs    = "/S /allusers"
   validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
