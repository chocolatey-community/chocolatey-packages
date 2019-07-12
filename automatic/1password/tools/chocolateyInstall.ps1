$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.3.702.BETA.exe'
  softwareName   = '1Password*'
  checksum       = 'b2bd43ce885e4a97227e22c14630d8774fe3b9448fcd318df73aff5f94305c7b'
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
