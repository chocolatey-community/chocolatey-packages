$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.9.835.exe'
  softwareName   = '1Password*'
  checksum       = '3d43ea28c46a1dac9cc645c5d9f4692cd1be009145ffe5260a910a2d9c89dd52'
  checksumType   = 'sha256'
  silentArgs     = "--silent"
  validExitCodes = @(0)

  BeforeInstall  = {
    $cache_dir = Join-Path -Path $env:LocalAppData -ChildPath "1password\logs\setup"

    # Installer blocks at the end and never returns. Successfull installation is visible in the log file, but only if it is the first installation
    $null = Start-Job -ScriptBlock { param($cache_dir)
      Remove-Item $cache_dir\*.log -Recurse -ea 0
      $seconds = 0; $max_seconds = 120

      while ($seconds -lt $max_seconds) {
        Start-Sleep 1; $seconds++

        $logFilePath = Get-ChildItem $cache_dir\*.log -Recurse | Select-Object -First 1

        # We will only wait up to a minute for a log file being available.
        if (!$logFilePath ) { continue }

        $log = Get-Content $logFilePath
        if ($log -like '*Installation successful!' -or $log -like '*Installation completed successfully!*') {
          break
        }
      }

      # We will wait a couple of seconds to ensure as the installer haven't fully finished when this message
      # is outputted. We also need to stop the executable no matter what for the package to finish.
      Start-Sleep -Seconds 2
      Get-Process '1password' -ea 0 | Stop-Process
    } -ArgumentList ($cache_dir)
  }
}

Install-ChocolateyPackage @packageArgs
