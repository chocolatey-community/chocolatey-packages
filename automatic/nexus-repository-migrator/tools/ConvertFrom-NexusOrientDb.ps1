<#
  .Synopsis
    Migrates Sonatype Nexus Repository 3.70.1-02 to the H2 database type

  .Example
    .\ConvertFrom-NexusOrientDb.ps1

  .Example
    .\ConvertFrom-NexusOrientDb.ps1 -JavaPath .\path\to\java.exe
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  # A path to a Java.exe file, major version 8 or 11.
  [string]$JavaPath,

  # The hostname of the machine used by Nexus, if using an SSL certificate.
  [string]$Hostname,

  # Forces migration even if the test doesn't think it is required.
  [switch]$Force
)

Import-Module $PSScriptRoot\nexus-helpers.ps1 -Verbose:$false

foreach ($Service in Get-NexusRepositoryServiceInstall) {
  if ($Force -or (Test-NexusMigratorRequired -DataDir (Split-Path $Service.DataFolder) -ProgramDir $Service.ProgramFolder)) {
    Write-Host "Preparing for database migration..."
    $MigrationFiles = Join-Path $env:Temp "dbmigration-$($Service.ServiceName)"
    $MigratorDownload = @{FileFullPath = Join-Path $PSScriptRoot "nexus-db-migrator.jar"}
    $PreMigrationIssues = @()

    if (Test-NexusMigratorFreeSpaceProblem -Drive $MigrationFiles.Split(':')[0] -DatabaseFolder (Join-Path $Service.DataFolder "db")) {
      $PreMigrationIssues += "Cannot migrate database with available disk space"
    }

    if (Test-NexusMigratorMemoryProblem) {
      $PreMigrationIssues += "Cannot migrate database with available memory"
    }

    # Test if contained JRE is compatible, otherwise check JAVA_HOME, otherwise...
    $JavaPath = @(
      $JavaPath
      Join-Path $Service.ProgramFolder "\jre\bin\java.exe"
      Convert-Path $env:JAVA_HOME\bin\java.exe -ErrorAction SilentlyContinue
      Convert-Path $env:ProgramFiles\*\jre-*\bin\java.exe -ErrorAction SilentlyContinue
    ) | Where-Object {
      $_ -and
      (Test-Path $_) -and
      (([version](Get-ItemProperty -Path $_).VersionInfo.ProductVersion).Major -in 8, 11)
    } | Select-Object -First 1

    if (-not $JavaPath) {
      $PreMigrationIssues += "Nexus Migrator requires JRE 8 or JRE 11. Please provide a -JavaPath to a compatible version."
    }

    if ($PreMigrationIssues) {
      Write-Error -Message ($PreMigrationIssues -join "`n") -ErrorAction Stop
    }

    $ServiceState = (Get-Service $Service.ServiceName).Status

    New-NexusOrientDbBackup -DataDir (Split-Path $Service.DataFolder) -ServiceName $Service.ServiceName -DestinationPath $MigrationFiles

    try {
      Push-Location $MigrationFiles
      Write-Host "Migrating database from 'OrientDb' to 'H2'"
      # We could adjust the memory values to work on more systems,
      # but these are the recommended arguments from Sonatype.
      $JavaArgs = @(
        "-Xmx16G"
        "-Xms16G"
        "-XX:+UseG1GC"
        "-XX:MaxDirectMemorySize=28672M"
        "-jar"
        $MigratorDownload.FileFullPath
        "--migration_type=h2"
        "--yes"
      )
      & $JavaPath @JavaArgs

      if ($LASTEXITCODE -ne 0) {
        throw "Migration of the database failed."
      }

      if ($PSCmdlet.ShouldProcess("$MigrationFiles\nexus.mv.db", "Moving migrated database")) {
        Copy-Item -Path $MigrationFiles\nexus.mv.db -Destination (Join-Path $Service.DataFolder "db")
      }
      $NexusConfigFile = Join-Path $Service.DataFolder "etc\nexus.properties"
      if ((Get-NexusConfiguration -Path $NexusConfigFile).'nexus.datastore.enabled' -ne 'true' -and $PSCmdlet.ShouldProcess($NexusConfigFile, 'Updating Datastore Configuration')) {
        (Get-Content $NexusConfigFile) | Where-Object {$_ -notmatch '^\W*nexus\.datastore\.enabled='} | Set-Content $NexusConfigFile
        Add-Content -Path $NexusConfigFile -Value "nexus.datastore.enabled=true"
      }

      if ($ServiceState -eq 'Running') {
        try {
          Write-Host "Restarting '$($Service.ServiceName)'"
          Restart-Service $Service.ServiceName
          # The post-migration launch can take significantly longer than normal
          Wait-NexusAvailability -Hostname $Hostname -Config $NexusConfigFile -Timeout 15 -ErrorAction Stop
        } catch {
          Write-Error -Message (@(
            "The Nexus service '$($Service.ServiceName)' was restarted, but did not recover."
            "Check the logs at '$(Join-Path $Service.DataFolder "log")'"
          ) -join "`n")
        }
      }
    } finally {
      Pop-Location
      Remove-Item $MigrationFiles -Recurse
    }
  } else {
    Write-Warning "'$($Service.DataFolder)' was not migrated"
  }
}