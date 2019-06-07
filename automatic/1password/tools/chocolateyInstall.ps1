$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.3.684.BETA.exe'
  softwareName   = '1Password*'
  checksum       = '8d4896a083d60171ba7db3c20f02656f48f1d65b6052598faef025da79cce94e'
  checksumType   = 'sha256'
  silentArgs     = '--log_path .'
  validExitCodes = @(0)
}

# Installer blocks at the end and never returns. Successifull installation is visible in the log file
Start-Job -ScriptBlock { param($cache_dir)
  rm $cache_dir\*.log -Recurse -ea 0
  $seconds = 0; $max_seconds = 600

  while ($seconds -lt $max_seconds) {
    sleep 1; $seconds++
    
    $logFilePath = ls $cache_dir\*.log -Recurse | select -First 1    
    if (!$logFilePath) { continue }
    
    $log = Get-Content $logFilePath
    if ($log -like '*Installation successful!') {
      ps $env:ChocolateyPackageName -ea 0 | kill
      exit
    }
  }
} -ArgumentList (Get-PackageCacheLocation)
Install-ChocolateyPackage @packageArgs
