function Backup-NexusSSL {
  [CmdletBinding()]
  param(
    [Parameter()]
    [String]$BackupLocation = $(Join-Path $env:UserProfile "NexusSSLBackup")
  )
  begin {
    if (-not (Test-Path $BackupLocation)) {
      Write-Host "Creating SSL Backup location"
      $null = New-Item $BackupLocation -ItemType Directory
    }
  }
  process {
    if (Test-Path "$env:ProgramData\nexus\etc\ssl\keystore.jks") {
      Copy-Item "$env:ProgramData\nexus\etc\ssl\keystore.jks" $BackupLocation
    }

    if (Test-Path "$env:ProgramData\nexus\etc\jetty\jetty-https.xml") {
      Copy-Item "$env:ProgramData\nexus\etc\jetty\jetty-https.xml" $BackupLocation
    }
  }
}

function Restore-NexusSSL {
  [CmdletBinding()]
  param(
    [Parameter()]
    [String]$BackupLocation = $(Join-Path $env:UserProfile "NexusSSLBackup")
  )
  process {
    Write-Host "Shutting down nexus Service to re-apply ssl configuration"
    $null = Stop-Service nexus

    Write-Host "Reapplying SSL Configuration"
    if (Test-Path "$BackupLocation\keystore.jks") {
      Copy-Item "$BackupLocation\keystore.jks" "$env:ProgramData\nexus\etc\ssl"
    }

    if (Test-Path "$BackupLocation\jetty-https.xml") {
      Copy-Item "$BackupLocation\jetty-https.xml" "$env:ProgramData\nexus\etc\jetty"
    }

    Write-Host "Nexus is now available with the restored SSL configuration"
  }
}

function Wait-NexusAvailability {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Hostname,

    [Parameter(Mandatory)]
    [Alias("Config")]
    [string]$NexusConfigFile = (Join-Path $env:ProgramData "\sonatype-work\nexus3\etc\nexus.properties")
  )
  # As the service is started, this should be present momentarily
  $Timer = [System.Diagnostics.Stopwatch]::StartNew()
  while (-not ($ConfigPresent = Test-Path $NexusConfigFile) -and $Timer.Elapsed.TotalSeconds -le 60) {
    Write-Verbose "Waiting for '$($NexusConfigFile)' to become available ($($Timer.Elapsed.TotalSeconds) seconds waited)..."
    Start-Sleep -Seconds 5
  }

  $nexusScheme, $nexusPort, $nexusPath = if ($ConfigPresent) {
    $Config = Get-NexusConfiguration -Path $NexusConfigFile

    if ($Config.'application-port-ssl' -gt 0) {
      # This is to combat Package Internalizer's over-enthusiastic URL matching
      ('http' + 's')
      $Config.'application-port-ssl'
    } elseif ($Config.'application-port' -gt 0) {
      'http'
      $Config.'application-port'
    }

    $Config.'nexus-context-path'
  }

  # Set defaults if not present
  if (-not $nexusScheme) {$nexusScheme = 'http'}
  if (-not $nexusPort) {$nexusPort = '8081'}

  $NexusUri = "$($nexusScheme)://$($Hostname):$($nexusPort)$($nexusPath)"

  Write-Host "Waiting on Nexus Web UI to be available at '$($NexusUri)'"
  while ($Response.StatusCode -ne '200' -and $Timer.Elapsed.TotalMinutes -lt 3) {
    try {
      $Response = Invoke-WebRequest -Uri $NexusUri -UseBasicParsing
    } catch {
      Write-Verbose "Waiting on Nexus Web UI to be available at '$($NexusUri)'"
      Start-Sleep -Seconds 1
    }
  }

  if ($Response.StatusCode -eq '200') {
    Write-Host "Nexus is ready!"
  } else {
    Write-Error "Nexus did not respond to requests at '$($NexusUri)' within 3 minutes of the service being started."
  }
}

function Get-NexusConfiguration {
  <#
    .Synopsis
      Returns a list of settings configured in nexus.properties

    .Example
      Get-NexusConfiguration
      # Returns all properties and values

    .Example
      (Get-NexusConfiguration).'application-port-ssl'
      # Returns the value for a single property, 'application-port-ssl'
  #>
  [CmdletBinding()]
  param(
    $Path = (Join-Path $env:ProgramData "\sonatype-work\nexus3\etc\nexus.properties")
  )
  Get-Content $Path | Where-Object {
    $_ -and $_ -notmatch "^\W*#"
  } | ConvertFrom-StringData
}

function Get-NexusVersion {
  <#
    .Synopsis
      Returns the currently installed version of Sonatype Nexus Repository

    .Example
      Get-NexusVersion
  #>
  [CmdletBinding()]
  param(
    [string]$ProgramDir = (Join-Path $env:ProgramData 'nexus')
  )
  # This isn't a very appropriate file to target.
  ([xml](Get-Content (Join-Path $ProgramDir "\.install4j\i4jparams.conf") -ErrorAction SilentlyContinue)).config.general.applicationVersion
}

function Test-NexusDatabaseType {
  <#
    .Synopsis
      Checks the currently configured database type in use by Nexus

    .Example
      Test-NexusDatabaseType -is "OrientDb"
  #>
  [OutputType([bool])]
  [CmdletBinding()]
  param(
    [ValidateSet("OrientDb","H2","PostgreSQL")]
    [Parameter(Mandatory)]
    [Alias('is','eq')]
    [string]$Type,
    [string]$ProgramDir = (Join-Path $env:ProgramData 'nexus'),
    [string]$DataDir = (Join-Path $env:ProgramData 'sonatype-work')
  )
  $JdbcUrl = if ($env:NEXUS_DATASTORE_NEXUS_JDBCURL) {
    $env:NEXUS_DATASTORE_NEXUS_JDBCURL
  } elseif ((Test-Path "$DataDir\etc\fabric\nexus-store.properties") -and ($Properties = Select-String -Path "$DataDir\etc\fabric\nexus-store.properties" -Pattern '^jdbcUrl=(?<Url>.+)$')) {
    $Properties.Matches.Groups[1].Value
  } elseif ($Properties = Select-String -Path "$ProgramDir\bin\nexus.vmoptions" -Pattern '^(?!#)\W*-Dnexus\.datastore\.nexus\.jdbcUrl=(?<Url>.+)') {
    $Properties.Matches.Groups[1].Value
  }

  $FoundType = if ($JdbcUrl) {
    if ($JdbcUrl -match 'jdbc\\?:h2') {
      "H2"
    } elseif ($JdbcUrl -match 'jdbc\\?:postgresql') {
      "PostgreSQL"
    }
  } else {
    if (Test-Path $DataDir\nexus3\db\nexus.mv.db) {
      "H2"
    } else {
      "OrientDb"
    }
  }

  $Type -eq $FoundType
}

function New-NexusOrientDbBackup {
  <#
    .Synopsis
      Produces a nearly-authentic backup file for all specified database types

    .Example
      New-NexusOrientDbBackup
      # Backs up all the databases needed for a migration.

    .Example
      New-NexusOrientDbBackup -IncludedDatabases 'config' -DestinationPath $PWD
      # Backs up the config database to the present working directory.
  #>
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [string]$DestinationPath = (Join-Path $env:TEMP 'sonatype-backup'),
    [string]$DataDir = (Join-Path $env:ProgramData 'sonatype-work'),
    [string]$BaseName = "-$(Get-Date -Format 'yyyy-MM-dd-HH-mm-ss')-$(Get-NexusVersion).bak",
    [string[]]$IncludedDatabases = @(
      # "analytics"
      "component"
      "config"
      "security"
    ),
    [string]$ServiceName = "nexus",
    [switch]$PassThru
  )
  if (($Service = Get-Service $ServiceName -ErrorAction SilentlyContinue).Status -ne 'Stopped') {
    if ($PSCmdlet.ShouldProcess($ServiceName, "Stopping Service")) {
      Stop-Service $ServiceName
    }
  }
  try {
    if (-not (Test-Path $DestinationPath) -and $PSCmdlet.ShouldProcess($DestinationPath, "Ensuring Folder")) {
      $null = New-Item -Path $DestinationPath -ItemType Directory -Force
    }
    $PreviousProgress, $ProgressPreference = $ProgressPreference, "SilentlyContinue"
    foreach ($Database in $IncludedDatabases) {
      Push-Location (Join-Path $DataDir "nexus3/db/$Database")
      $ArchiveArgs = @{
        Path = Get-ChildItem -Path (Join-Path $DataDir "nexus3/db/$Database/*") -Exclude "cache.stt" -File
        DestinationPath = Join-Path $DestinationPath "$($Database.ToLower())$BaseName.zip"
        CompressionLevel = 'NoCompression'  # Not efficient, but sufficient for this migration.
      }
      if ($PSCmdlet.ShouldProcess($Database, "Creating Backup of Database")) {
        Compress-ArchiveCompat @ArchiveArgs
        Rename-Item $ArchiveArgs.DestinationPath -NewName "$($Database.ToLower())$BaseName" -PassThru:$PassThru
      }
      Pop-Location
    }
  } finally {
    $ProgressPreference = $PreviousProgress
    if ($Service.Status -eq 'Running') {
      if ($PSCmdlet.ShouldProcess($ServiceName, "Starting Service")) {
        Start-Service $ServiceName
      }
    }
  }
}

function Compress-ArchiveCompat {
  <#
    .Synopsis
      A drop in for creating an archive on PowerShell versions that don't have Compress-Archive

    .Notes
      Specifically written to be able to create Nexus database backups,
      this probably shouldn't be used for other stuff.

    .Example
      $ArchiveArgs = @{
        Path = Get-ChildItem (Join-Path $DataDir "nexus3/db/$Database/*") -File -Recurse
        DestinationPath = Join-Path $DestinationPath "SomeName.zip"
        CompressionLevel = 'NoCompression'
      }
      Compress-Archive @ArchiveArgs
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [System.IO.FileInfo[]]$Path,

    [Parameter(Mandatory)]
    [string]$DestinationPath,

    [ValidateSet("Fastest", "NoCompression", "Optimal")]
    [string]$CompressionLevel = "Optimal"
  )
  begin {
    Add-Type -Assembly System.IO.Compression, System.IO.Compression.FileSystem
    if (-not (Test-Path (Split-Path $DestinationPath))) {$null = mkdir (Split-Path $DestinationPath) -Force}
    $Archive = [System.IO.Compression.ZipFile]::Open($DestinationPath, [System.IO.Compression.ZipArchiveMode]::Update)
  }
  process {
    foreach ($File in $Path) {
      $null = [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
        $Archive,
        $File.FullName,
        "$((Resolve-Path -Path $File.FullName -Relative).TrimStart('\.'))",
        [System.IO.Compression.CompressionLevel]::$CompressionLevel
      )
    }
  }
  end {
    $Archive.Dispose()
  }
}

function Test-NexusMigratorRequired {
  <#
    .Synopsis
      Tests if we need to migrate this system's database

    .Example
      Test-NexusMigratorRequired -DataDir $TargetDataFolder -ProgramDir $TargetFolder
      # Returns if a migration is required, based on the existing version and database.
  #>
  [OutputType([Nullable[bool]])]
  [CmdletBinding()]
  param(
    # The installed version of Nexus
    $CurrentVersion = (Get-NexusVersion -ProgramDir $ProgramDir),

    # The only version of Nexus we should be upgrading from
    $RequiredVersion = "3.70.1",

    # Nexus' working directory
    $DataDir = (Join-Path $env:ProgramData 'sonatype-work'),

    # Nexus' program directory
    $ProgramDir = (Join-Path $env:ProgramData 'nexus')
  )
  if ($CurrentVersion) {
    [version]$CurrentDeNexusVersion = $CurrentVersion -replace '-\d+$'

    if ($CurrentDeNexusVersion -lt $RequiredVersion) {
      Write-Error (@(
        "Please upgrade nexus-repository to version 3.70.1-02 before upgrading further."
        "You can do this by running 'choco upgrade nexus-repository --version 3.70.1.2 --confirm'"
        "For more details, please see: https://help.sonatype.com/en/orient-pre-3-70-java-8-or-11.html"
      ) -join "`n")
      throw "Package cannot upgrade from '$($CurrentVersion)' to '$($env:ChocolateyPackageVersion)'"
    } elseif ($CurrentDeNexusVersion -eq $RequiredVersion) {
      # We will upgrade if we are on OrientDb, otherwise leave it alone.
      Test-NexusDatabaseType -Type "OrientDb" -DataDir $DataDir -ProgramDir $ProgramDir
    }
  }
}

function Test-NexusMigratorFreeSpaceProblem {
  <#
    .Synopsis
      Tests to see if we don't have more free space than we think we require.

    .Example
      Test-NexusMigratorFreeSpaceProblem -FreeSpace 1GB -RequiredSpace 5GB
      # Should be a problem, because 1GB is less than 5GB

    .Example
      Test-NexusMigratorFreeSpaceProblem -Drive C -DatabaseFolder $env:ProgramData\sonatype-work\nexus3\db
      # Will test for the values found.
  #>
  [OutputType([bool])]
  [CmdletBinding()]
  param(
    # The name of the drive we care about.
    [Parameter(Mandatory, ParameterSetName="Location")]
    [string]$Drive,

    # The folder the database lives in
    [Parameter(Mandatory, ParameterSetName="Location")]
    [string]$DatabaseFolder,

    # This is the free space on the drive that we'll be manipulating the migration files.
    [Parameter(Mandatory, ParameterSetName="Values")]
    $FreeSpace =  (Get-PSDrive $Drive).Free,

    # The migrator requires 3 times the size of the database files, or 10GB - whichever is larger.
    [Parameter(Mandatory, ParameterSetName="Values")]
    $RequiredSpace = $(
      [Math]::Max(
        (3 * (Get-ChildItem -Path $DatabaseFolder -Recurse | Measure-Object Length -Sum).Sum),
        10GB
      )
    )
  )
  $Result = $FreeSpace -lt $RequiredSpace

  if ($Result) {
    Write-Error -Message (@(
      "The Sonatype Nexus Database Migrator requires at least $([Math]::Round(($RequiredSpace / 1GB), 2))GB free space."
      "There is only $([Math]::Floor($FreeSpace / 1GB))GB free. For more details, please see: "
      "https://help.sonatype.com/en/orient-3-70-java-8-or-11.html#considerations-before-migrating-252166"
    ) -join "`n")
  }

  return $Result
}

function Test-NexusMigratorMemoryProblem {
  <#
    .Synopsis
      Tests to see if we don't have enough memory for the migration.

    .Example
      Test-NexusMigratorMemoryProblem -Memory 10GB -Requirement 5GB
      # Should be fine, no problem.

    .Example
      Test-NexusMigratorMemoryProblem
      # Tests the expected values against the existing memory on this system.
  #>
  [OutputType([bool])]
  [CmdletBinding()]
  param(
    # The current amount of memory, in bytes.
    $Memory = (Get-CimInstance Win32_PhysicalMemory).Capacity,

    # The migrator requires 16GB of memory.
    $Requirement = 16GB
  )
  $Result = $Memory -lt $Requirement

  if ($Result) {
    Write-Error -Message (@(
      "The Sonatype Nexus Database Migrator requires at least $($Requirement / 1GB)GB of memory."
      "There is only $($Memory/1GB)GB available. For more details, please see: "
      "https://help.sonatype.com/en/orient-3-70-java-8-or-11.html#considerations-before-migrating-252166"
    ) -join "`n")
  }

  return $Result
}