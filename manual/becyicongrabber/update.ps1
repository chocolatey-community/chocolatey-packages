import-module au

$releases = 'http://www.becyhome.de/download_eng.htm'
$versions = 'http://www.becyhome.de/becyicongrabber/description_eng.htm'

function downloadAndHash([string]$url)
{
  "Downloading $url"
  $stream = Invoke-WebRequest $url | select -ExpandProperty RawContentStream
  Get-FileHash -Algorithm SHA256 -InputStream $stream
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "'.*'(\s*#urlEN)$" = "'$($Latest.URLEN)'`$1"
            "'.*'(\s*#urlDE)$" = "'$($Latest.URLDE)'`$1"
            "'.*'(\s*#checksumEN)$" = "'$($Latest.ChecksumEN)'`$1"
            "'.*'(\s*#checksumDE)$" = "'$($Latest.ChecksumDE)'`$1"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = 'BeCyIGrab.*\.zip$'
    $urlEN = $download_page.links | ? href -match $re | select -First 1 -expand href
    $urlDE = $urlEN -replace 'Eng(\.zip)', 'Ger$1'
    $checksumEN = downloadAndHash $urlEN;
    $checksumDE = downloadAndHash $urlDE

    $version_page = Invoke-WebRequest -Uri $versions;

    $version = ($version_page.ParsedHTML.getElementsByClassName("section") | ? innerText -match "^\s*[0-9\.]+\s*$" `
      | select -first 1 -expand innerText).Trim();

    return @{
      URLEN = $urlEN
      URLDE = $urlDE
      ChecksumEN = $checksumEN.Hash
      ChecksumDE = $checksumDE.Hash

      ChecksumType = $checksumEN.Algorithm.ToLower()
      Version = $version
    }
}

update -ChecksumFor none
