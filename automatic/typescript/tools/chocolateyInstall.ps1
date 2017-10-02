$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

$npmPath = Get-Command npm | % { $_.Path }
"Installing $env:chocolateyPackageName using nodejs..."
Start-ChocolateyProcess $npmPath -statements install,"-g","typescript@0.0"
