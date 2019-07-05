$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.3.700.BETA.exe'
  softwareName   = '1Password*'
  checksum       = '11cce95bc4d9e03e517ec1a9315fdbe403b9b098244f4e1e33075f8a64514c94'
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
