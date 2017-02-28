import-module au

$releases = "http://dist.nuget.org/index.json"

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $client = New-Object System.Net.WebClient
  try
  {
    $filePath32 = "$PSScriptRoot\tools\$($Latest.FileName32)"
    $client.DownloadFile($Latest.URL32, "$filePath32")
  }
  finally
  {
    $client.Dispose()
  }

  $Latest.ChecksumType = "sha256"
  $Latest.Checksum32 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath32 | ForEach-Object Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $json = Invoke-WebRequest -UseBasicParsing -Uri $releases | ConvertFrom-Json

  $commandlineArtifacts = $json.artifacts | Where-Object {$_.name -eq "win-x86-commandline"} 
  $versionDescription = $commandlineArtifacts.versions |  Where-Object {$_.displayName -eq "nuget.exe - latest"}

  return @{
    URL32 = $versionDescription.url
    FileName32 = [IO.Path]::GetFileName($versionDescription.url)
    Version = $versionDescription.version
  }
}

update -ChecksumFor 32