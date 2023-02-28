$ErrorActionPreference = 'Stop'

$fallbackUrl32 = 'https://download.gimp.org/gimp/v2.10/windows/gimp-2.10.34-setup.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/gimp/v2.10/windows/gimp-2.10.34-setup.exe'
  softwareName   = 'GIMP'
  checksum       = '1cf2f422e4ab887415222d736313a38372012c5f3f46a2d2cff18245b22d04cd'
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
