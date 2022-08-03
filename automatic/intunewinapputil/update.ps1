Import-Module AU

$releases = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/releases/latest"

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $urlRegex = '\.zip'
  $url = $download_page.Links | Where-Object href -Match $urlRegex | Select-Object -First 1 -ExpandProperty href

  $version = ($url -split '\/v?' | Select-Object -Last 1).Replace('.zip', '')

  @{
    Url32   = "https://github.com$url"
    Version = $version
  }

}

function global:au_SearchReplace {
  @{
    "./tools/chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*)"           = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

update -ChecksumFor 32
