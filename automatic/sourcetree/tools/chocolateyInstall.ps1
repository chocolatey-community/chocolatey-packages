$ErrorActionPreference = 'Stop'
$checksum = 'd9794507e3f319971e27da1679de2d09c7306ee78b0b2445ee118855abec1704'
$url = 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.4.6.msi'

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
  url            = $url
  silentArgs    = "/qn /norestart ACCEPTEULA=1 /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1641,3010)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
