$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$PackageParameters = Get-PackageParameters

$MigratorDownload = @{
  PackageName = $env:ChocolateyPackageName
  Url = 'https://download.sonatype.com/nexus/nxrm3-migrator/nexus-db-migrator-3.70.2-01.jar'
  FileFullPath = Join-Path $toolsDir "nexus-db-migrator.jar"
  Checksum = '69aebd05589a730af54d7b2cacba7d7bb5ea1f13dccd5e0d7eec002837068df0'
  ChecksumType = 'SHA256'
}
Get-ChocolateyWebFile @MigratorDownload

$PowerShellScript = @{
  packageName = $env:ChocolateyPackageName
  PsFileFullPath = Join-Path $toolsDir "ConvertFrom-NexusOrientDb.ps1"
}
Install-ChocolateyPowershellCommand @PowerShellScript

if ($PackageParameters.AttemptMigration) {
  $ConvertArguments = @{}
  if ($PackageParameters.FQDN) {
    $ConvertArguments.Hostname = $PackageParameters.FQDN
  }
  & $toolsDir\ConvertFrom-NexusOrientDb.ps1 @ConvertArguments -ErrorAction Stop
  Write-Host "You may now uninstall this package with 'choco uninstall $($env:ChocolateyPackageName) --confirm'."
}
