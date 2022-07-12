$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.9.832-BETA.exe'
  softwareName   = '1Password*'
  checksum       = '578022880cbb9f9dc1e0d61e77077ad105e51727ad09f2565fe512ba06107611'
  checksumType   = 'sha256'
  silentArgs     = "--silent"
  validExitCodes = @(0)
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
