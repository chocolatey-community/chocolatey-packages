$ErrorActionPreference = 'Stop'

$fallbackUrl32 = 'https://download.gimp.org/gimp/v3.0/windows/gimp-3.0.8-setup-1.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/gimp/v3.0/windows/gimp-3.0.8-setup-1.exe'
  softwareName   = 'GIMP'
  checksum       = 'fa3553e9659d50acebe580828114d53920f73977777a1468749446f391cd3a6a'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Try {
    Get-WebHeaders -Url $packageArgs.url
} Catch {
    Write-Warning "The mirror URL is not available, falling back to the main site"
    $packageArgs.url = $fallbackUrl32
}

Install-ChocolateyPackage @packageArgs
