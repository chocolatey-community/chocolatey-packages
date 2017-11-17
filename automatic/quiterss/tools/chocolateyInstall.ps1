$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
file          = "$toolsDir\QuiteRSS-0.18.8-Setup.exe"
fileType      = 'exe'
packageName   = 'quiterss'
softwareName  = 'QuiteRSS'
silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).Install.log`""
}

Install-ChocolateyInstallPackage @packageArgs
