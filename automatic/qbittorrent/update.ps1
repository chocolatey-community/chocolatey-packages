import-module au
import-module "./../../extensions/extensions.psm1"
. "./../../extensions/chocolatey-fosshub.extension/extensions/Get-FosshubWebFile.ps1"

$releases = 'https://www.fosshub.com/qBittorrent.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]fosshubUrl\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '\.exe$'
    $urlElement   = $download_page.links | ? href -match $re | select -First 1
    $urlPart = $urlElement | select -expand href
    $url = "https://www.fosshub.com$urlPart"

    $dlUrl = $urlElement.PSObject.Properties | ? {
      $_.Value -match "^https:\/\/download\.fosshub\.com"
    } | select -first 1 -expand Value

    $version  = $url -split '[_]' | select -Last 1 -Skip 1

    return @{ URL32 = $url; Version = $version; DownloadURL = $dlUrl }
}

function global:au_BeforeUpdate {
  # Since We need a referer header we can't use Get-RemoteChecksum
  $stream = Invoke-WebRequest $Latest.DownloadURL -Headers @{ 'Referer' = $Latest.URL32 } | select -expand RawContentStream

  $Latest.Checksum32 = Get-FileHash -Algorithm SHA256 -InputStream $stream | % Hash
  $Latest.ChecksumType32 = 'sha256'

  $stream.Dispose()
}

update -ChecksumFor none -NoCheckUrl
