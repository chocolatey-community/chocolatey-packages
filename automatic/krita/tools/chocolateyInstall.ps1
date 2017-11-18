$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
file          = "$toolsDir\krita-3.3.2-x86-setup.exe"
file64        = "$toolsDir\krita-3.3.2-x64-setup.exe"
fileType      = 'exe'
packageName   = 'krita'
softwareName  = 'Krita'
silentArgs    = "/S"
}

Install-ChocolateyInstallPackage @packageArgs
