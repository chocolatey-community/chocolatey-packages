<#
  .Synopsis
    Repairs a broken upgrade of Sonatype Nexus Repository OSS
  
  .Example
    .\Repair-Nexus371FailedUpgrade.ps1
    # Repairs the Nexus install, ending with a migrated database and version 3.71.0.6

  .Example
    .\Repair-Nexus371FailedUpgrade.ps1 -Rollback
    # Repairs the Nexus install, ending with an unmodified database and version 3.70.1.2
#>
[CmdletBinding(DefaultParameterSetName="Upgrade")]
param(
  # If selected, rolls the install back to 3.70.x instead of upgrading.
  [Parameter(ParameterSetName="Repair")]
  [Alias("Repair")]
  [switch]$Rollback,

  # Temporary Path for extracting files
  [string]$ExtractPath = (Join-Path $env:Temp "nexus")
)
$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"

Import-Module $PSScriptRoot\nexus-helpers.ps1 -Verbose:$false

# Test if Nexus JRE matches
$JavaPath = @(
  Join-Path $env:ProgramData "\nexus\jre\bin\java.exe"
  Convert-Path $env:JAVA_HOME\bin\java.exe
  Convert-Path $env:ProgramFiles\*\jre-*\bin\java.exe
) | Where-Object {
  $_ -and
  (Test-Path $_) -and
  (([version](Get-ItemProperty -Path $_).VersionInfo.ProductVersion).Major -in 8, 11)
} | Select-Object -First 1

# Download Java if it's missing, via the old version of Nexus Repository
if (-not $JavaPath -and -not ($JavaPath = Convert-Path "$ExtractPath\nexus-3.70.1-02\jre\bin\java.exe" -ErrorAction SilentlyContinue)) {
  Invoke-WebRequest -Uri https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.70.1-02-win64.zip -OutFile "$env:Temp\nexus-3.70.1-02.zip"
  Expand-Archive -Path "$env:Temp\nexus-3.70.1-02.zip" -DestinationPath $ExtractPath
  $JavaPath = Convert-Path "$ExtractPath\nexus-3.70.1-02\jre\bin\java.exe"
  Remove-Item "$env:Temp\nexus-3.70.1-02.zip"
}

$BackupLocation = "$PSScriptRoot\$(New-Guid)"
Backup-NexusSSL -BackupLocation $BackupLocation

# Get the "installed" and package version of Nexus
$NexusVersion = Get-NexusVersion
$null = [System.Reflection.Assembly]::LoadFrom("$env:ChocolateyInstall\choco.exe")
$LatestPackageVersion = [Chocolatey.NugetVersionExtensions]::ToNormalizedStringChecked(
  "$($NexusVersion -replace '-','.')"
)

if ((Get-Service nexus).Status -ne 'running') {
  if ($PSCmdlet.ParameterSetName -eq 'Upgrade') {
    & $PSScriptRoot\ConvertFrom-NexusOrientDb.ps1 -JavaPath $JavaPath -Force
  }

  # The combined installation of old and new Nexus Java versions and supports
  # causes the install to become un-startable. We'll replace it.
  Remove-Item $env:ProgramData\nexus -Recurse

  switch ($PSCmdlet.ParameterSetName) {
    "Repair" {
      Copy-Item -Path "$ExtractPath\nexus-3.70.1-02\" -Destination "$env:ProgramData\nexus" -Recurse
    }
    "Upgrade" {
      # Download the matching version of Nexus
        Invoke-WebRequest -Uri https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-$($NexusVersion)-win64.zip -OutFile "$env:Temp\nexus-$($NexusVersion)-win64.zip"
        Expand-Archive -Path "$env:Temp\nexus-$($NexusVersion)-win64.zip" -DestinationPath $ExtractPath -Force
        Copy-Item -Path "$ExtractPath\nexus-$NexusVersion\" -Destination "$env:ProgramData\nexus" -Recurse
        Remove-Item "$env:Temp\nexus-$($NexusVersion)-win64.zip"

      # Ensure the package is in a good state, from CCR as we know the local repository isn't running.
      choco upgrade nexus-repository --version $LatestPackageVersion --confirm --no-progress --source https://community.chocolatey.org/api/v2/ --skip-powershell
    }
  }
} else {
  Write-Warning "The service is already running. You don't need to repair."
}

try {
  Restore-NexusSSL -BackupLocation $BackupLocation
} finally {
  Remove-Item $BackupLocation -Recurse
}

Restart-Service nexus