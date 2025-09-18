Import-Module Chocolatey-AU

$releases = 'https://www.codeblocks.org/downloads/binaries/'
function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        "(?i)(^\s*url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
    ".\codeblocks.nuspec"           = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re = 'sourceforge.*mingw-32bit-setup\.exe$'
  $url = $download_page.links | Where-Object href -match $re | Select-Object -first 1 -expand href

  $re64 = 'sourceforge.*mingw-setup\.exe$'
  $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -first 1 -expand href

  if (!$url.StartsWith("https")) {
    $url = $url -replace "^http", "https"
  }

  if (!$url64.StartsWith("https")) {
    $url64 = $url64 -replace "^http", "https"
  }

  $version = Get-ChocolateyNormalizedVersion ($url64 -split '[-]|mingw' | Select-Object -Last 1 -Skip 2)

  $changelog = $download_page.links | Where-Object href -match "\/changelogs\/$version" | Select-Object -first 1 | ForEach-Object { [uri]::new([uri]$releases, $_.href) }

  return @{
    URL32        = $url
    URL64        = $url64
    Version      = $version
    ReleaseNotes = $changelog
    FileType     = 'exe'
  }
}

update -NoCheckUrl
