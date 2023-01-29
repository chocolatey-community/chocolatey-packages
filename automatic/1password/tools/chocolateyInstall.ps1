$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.9.832.exe'
  softwareName   = '1Password*'
  checksum       = '578022880cbb9f9dc1e0d61e77077ad105e51727ad09f2565fe512ba06107611'
  checksumType   = 'sha256'
  silentArgs     = "--silent"
  validExitCodes = @(0)
}

# [System.Version] doesn't support "-BETA" pre-release parts, so remove them beforehand
$safeVersion = $env:ChocolateyPackageVersion -replace "-.*$", ""

if ( # The package version is greater than or equal to 8, and the Windows version is less than 10
  ([Version]($safeVersion) -ge [Version]"8.0") -and
  ([Version]($env:OS_VERSION) -lt [Version]"10.0")
) {
  throw -join @(
    "ERROR! 1password 8.0+ is not supported on desktop versions of "
    "Windows below 10, nor server versions of Windows below 2016. If you want "
    "chocolatey to maintain your current version of 1password you can use the "
    "command ``choco pin add --name=`"1password`" --version=`"7.9.832`"``. Note "
    "that this will also prevent chocolatey from noticing newer versions of "
    "1password 7.x if any are released.")
}

if ($env:ChocolateyPackageName -eq "1password4") {
  $cache_dir = Get-PackageCacheLocation
}
else {
  $cache_dir = Join-Path -Path $env:LocalAppData -ChildPath "1password\logs\setup"
}

# Installer blocks at the end and never returns. Successifull installation is visible in the log file
Start-Job -ScriptBlock { param($cache_dir)
  Remove-Item $cache_dir\*.log -Recurse -ea 0
  $seconds = 0; $max_seconds = 600

  while ($seconds -lt $max_seconds) {
    Start-Sleep 1; $seconds++

    $logFilePath = Get-ChildItem $cache_dir\*.log -Recurse | Select-Object -First 1
    if (!$logFilePath) { continue }

    $log = Get-Content $logFilePath
    if ($log -like '*Installation successful!' -or $log -like '*Installation completed successfully!*') {
      Get-Process $env:ChocolateyPackageName -ea 0 | Stop-Process
      exit
    }
  }
} -ArgumentList ($cache_dir)
Install-ChocolateyPackage @packageArgs
