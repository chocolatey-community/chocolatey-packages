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

    [Parameter(Mandatory = $true)]
    [uint16]$Port,

    [Parameter(Mandatory = $true)]
    [Alias("Config")]
    [string]$NexusConfigFile,

    [switch]$SSL
  )
  # Even though windows reports service is ready - web url will not respond until Nexus is actually ready to serve content
  # We need to use this method to collect the port number so we can properly test the website has returned OK.
  $nexusScheme, $portConfigLine = if ($SSL) {
    # This is to combat Package Internalizer's over-enthusiastic URL matching
        ('http' + 's'), 'application-port-ssl'
  } else {
    'http', 'application-port'
  }

  # As the service is started, this should be present momentarily
  $Timer = [System.Diagnostics.Stopwatch]::StartNew()
  while (-not ($ConfigPresent = Test-Path $NexusConfigFile) -and $Timer.Elapsed.TotalSeconds -le 60) {
    Write-Verbose "Waiting for '$($NexusConfigFile)' to become available ($($Timer.Elapsed.TotalSeconds) seconds waited)..."
    Start-Sleep -Seconds 5
  }

  if ($ConfigPresent) {
    $nexusPort = (Get-Content $NexusConfigFile | Where-Object {
        $_ -match $portConfigLine
      }).Split('=')[-1]

    $nexusPath = (Get-Content $NexusConfigFile | Where-Object {
        $_ -match "nexus-context-path"
      }).Split("=")[-1]
  } else {
    Write-Warning "Expected Nexus Config file '$($NexusConfigFile)' is not present."
    $nexusPath, $nexusPort = '/', $Port
  }

  $NexusUri = "$($nexusScheme)://$($hostname):$($nexusPort)$($nexusPath)"

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
