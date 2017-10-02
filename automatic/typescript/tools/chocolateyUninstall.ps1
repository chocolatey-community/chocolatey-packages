$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

$npmPath = Get-Command npm | % { $_.Path }
"Uninstalling $env:chocolateyPackageName using nodejs..."
Start-ChocolateyProcessAsAdmin $npmPath -statements uninstall,"-g",typescript
