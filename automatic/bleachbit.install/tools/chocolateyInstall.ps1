$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
packageName   = $env:ChocolateyPackageName
file          = "$toolsDir\BleachBit-1.17-setup.exe"
fileType      = 'exe'
silentArgs    = "/S"
}

Install-ChocolateyInstallPackage @packageArgs
