$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'no-ip-duc'
  fileType       = 'exe'
  url            = 'https://www.noip.com/client/DUCSetup_v4_1_1.exe'
  softwareName   = 'No-IP DUC'
  checksum       = 'a515d57b7fe9751106fb9ed6cbbc492765b4f470e20b427d6930630f379f0804'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
