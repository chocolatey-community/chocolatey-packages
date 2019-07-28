$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'http://www.alldup.info/download/AllDupSetup.exe'
  softwareName   = 'AllDup*'
  checksum       = '2a56b053c21143ce2b84db0ac8083b56cddeb95bc4cdd17d04f2333f98327092'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
