$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.3.705.exe'
  softwareName   = '1Password*'
  checksum       = '51d40968ea17d497bc2360987d3b3f9e626020d2c954fa12bbdf18391cebeeaa'
  checksumType   = 'sha256'
  silentArgs     = '--log_path .'
  validExitCodes = @(0)
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
    if ($log -like '*Installation successful!') {
      Get-Process $env:ChocolateyPackageName -ea 0 | Stop-Process
      exit
    }
  }
} -ArgumentList (Get-PackageCacheLocation)
Install-ChocolateyPackage @packageArgs
