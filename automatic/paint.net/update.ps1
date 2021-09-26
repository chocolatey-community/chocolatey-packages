Import-Module AU

$releases = 'https://github.com/paintdotnet/release/releases'

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
        "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
      }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix

  Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
  7z e tools\*.zip -otools *.exe -r -y
  rm tools\*.zip -ea 0
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $re = 'paint.net.+.install.x64.zip'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '/' | select -Last 1 -Skip 1

    @{
        Version = $version.Substring(1)
        Url64   = $domain + $url
    }
}

update -ChecksumFor none
