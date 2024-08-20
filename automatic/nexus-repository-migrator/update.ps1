Import-Module Chocolatey-AU

function global:au_GetLatest {
  $R = Invoke-WebRequest -Uri https://help.sonatype.com/en/orientdb-downloads.html -UseBasicParsing
  $MigratorUrl = $R.Links.href | Where-Object {
    $_ -like 'https://download.sonatype.com/nexus/nxrm3-migrator/nexus-db-migrator-3.70.*.jar'
  }

  if ($MigratorUrl.Count -ne 1) {
    throw "Found $($MigratorUrl.Count) URLs that look like the migrator:`n  $($MigratorUrl -join "`n  ")"
  }

  if ($MigratorUrl -match "/nexus-db-migrator-(?<Version>3\.70\.\d+-\d+)\.jar$") {
    $NexusMigratorVersion = $Matches.Version
  }

  $null = [System.Reflection.Assembly]::LoadFrom("$env:ChocolateyInstall\choco.exe")
  $LatestPackageVersion = [Chocolatey.NugetVersionExtensions]::ToNormalizedStringChecked(
    "$($NexusMigratorVersion -replace '-','.')"
  )

  @{
    NexusVersion = $NexusMigratorVersion
    Version      = $LatestPackageVersion
    URL          = $MigratorUrl
    SHA256       = (Invoke-RestMethod "$MigratorUrl.sha256" -UseBasicParsing).Trim()
  }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
      "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.SHA256)'"
    }
  }
}

update -ChecksumFor none