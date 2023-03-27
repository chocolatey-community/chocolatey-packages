$ErrorActionPreference = 'Stop'
$ServiceName = 'nexus'
$InstallFolder = "$env:ProgramData\Nexus"

if (Test-Path "$Installfolder\bin\nexus.exe") {
  if (Get-Process $ServiceName -ErrorAction SilentlyContinue) {
    Get-Process $ServiceName | Stop-Process -Force
  }

  if (Get-Service $ServiceName -ErrorAction SilentlyContinue) {
    Stop-Service $ServiceName
  }

  Start-Sleep -Seconds 5

  $ProcessArgs = @{
    ExeToRun       = "$InstallFolder\bin\nexus.exe"
    Statements     = "/uninstall $ServiceName"
    ValidExitCodes = @(0)
  }
  Start-ChocolateyProcessAsAdmin @ProcessArgs
  Remove-Item $InstallFolder -Recurse -Force
} else {
  Write-Warning "It appears that the uninstall may have been run outside of chocolatey, skipping..."
}
