. "$PSScriptRoot\..\7zip\update.ps1"

$softwareNamePrefix = '7-zip'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -FileNameBase '7zip'
  $Latest.ChecksumType = 'sha256'

  $client = New-Object System.Net.WebClient
  try {
    $filePath = "$PSScriptRoot\tools\7zip_extra.7z"
    Remove-Item $filePath -Force -ea 0
    Write-Host "Downloading to 7zip_extra.7z"
    $client.DownloadFile($Latest.URL_EXTRA, $filePath)
    $Latest.ChecksumExtra = Get-FileHash $filePath | % Hash

  } catch { throw $_ }
  finally { $client.Dispose(); }
}

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(Extra.+)\<.*\>"  = "`${1}<$($Latest.URL_EXTRA)>"
      "(?i)(checksum type\s*:).*" = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum32\s*:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64\s*:).*" = "`${1} $($Latest.Checksum64)"
      "(?i)(checksumExtra\s*:).*" = "`${1} $($Latest.ChecksumExtra)"
    }
  }
}

update -ChecksumFor none
