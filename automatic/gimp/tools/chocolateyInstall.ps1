$ErrorActionPreference = 'Stop'

$fallbackUrl32 = 'https://download.gimp.org/gimp/v3.0/windows/gimp-3.0.0-setup-1.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/gimp/v3.0/windows/gimp-3.0.0-setup-1.exe'
  softwareName   = 'GIMP'
  checksum       = 'c1101f6fe5103c2986bd39a8c4162b52ea915c1d8066c79a86497329afd01fe4'
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
