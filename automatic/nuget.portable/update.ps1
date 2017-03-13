import-module au

$releases = "http://dist.nuget.org/index.json"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $json = Invoke-WebRequest -UseBasicParsing -Uri $releases | ConvertFrom-Json

  $commandlineArtifacts = $json.artifacts | Where-Object {$_.name -eq "win-x86-commandline"} 
  $versionDescription = $commandlineArtifacts.versions |  Where-Object {$_.displayName -eq "nuget.exe - recommended latest"}

  return @{
    URL32 = $versionDescription.url
    FileName32 = [IO.Path]::GetFileName($versionDescription.url)
    Version = $versionDescription.version
  }
}

update -ChecksumFor 32
