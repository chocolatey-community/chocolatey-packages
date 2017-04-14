$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  fileType       = 'exe'
  url = 'http://haali.su/mkv/MatroskaSplitter.exe'
  softwareName   = 'Haali Media Splitter'
  checksum = '2fbfe6761c98b332b4342353be2cef945d6a1e46bb5c7c406e6f0eb4c92db07d'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
