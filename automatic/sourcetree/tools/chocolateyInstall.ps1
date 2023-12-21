$ErrorActionPreference = 'Stop'

# Check if Sourcetree standard (with Squirrel installer) is installed 
[array] $key = Get-UninstallRegistryKey "sourcetree" | Where-Object { -Not ($_.WindowsInstaller) }
if ($key.Count -gt 0) {
  Write-Warning "Found installation of standard version of Sourcetree."
  Write-Warning "This package will install the enterprise version of Sourcetree."
  Write-Warning "Both applications can be installed side-by-side. Settings won't be migrated from the existing installation. If you no longer want the standard version installed you can uninstall it from Windows control panel."
}

# Install Sourcetree Enterprise
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Sourcetree*'
  fileType      = 'msi'
  silentArgs    = "/qn /norestart ACCEPTEULA=1 /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1641,3010)
  url           = 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.4.16.msi'
  checksum      = '5cf870928372e04415ec86a573fa416f1d6af0830cd15db814cc962a93d1de9e'
  checksumType  = 'sha256'
  url64bit      = ''
  checksum64    = ''
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs
