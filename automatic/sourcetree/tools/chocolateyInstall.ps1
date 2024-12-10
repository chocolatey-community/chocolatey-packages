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
  url           = 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.4.21.msi'
  checksum      = '7aec40ffa4e28210c49467c56b5679934094e4b861557ec71b6776f419b0e125'
  checksumType  = 'sha256'
  url64bit      = ''
  checksum64    = ''
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs
