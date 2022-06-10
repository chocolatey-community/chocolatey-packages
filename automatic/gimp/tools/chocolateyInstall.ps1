$ErrorActionPreference = 'Stop'

$fallbackUrl32 = 'https://download.gimp.org/pub/gimp/v2.10/windows/gimp-2.10.30-setup.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.10/windows/gimp-2.10.30-setup.exe'
  softwareName   = 'GIMP'
  checksum       = '5b8db574966d2427fa02202b591173905f64806559e37fbdca4654e55b568c8e'
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
