$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

$npmPath = Get-Command npm | % { $_.Path }
"Installing $env:chocolateyPackageName using nodejs..."
Start-ChocolateyProcessAsAdmin $npmPath -statements install,"-g","typescript@2.6.2"
