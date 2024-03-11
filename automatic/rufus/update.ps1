Import-Module Chocolatey-AU

$releases = 'https://rufus.ie/en/'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase 'rufus' -NoSuffix }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href

  $version = $url -split '-|.exe' | Select-Object -Last 1 -Skip 1

  @{
    Version = $version
    URL32   = New-Object uri([uri]$releases, $url)
  }
}

update -ChecksumFor none
