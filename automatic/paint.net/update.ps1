Import-Module AU

$releases = 'https://github.com/paintdotnet/release/releases/latest'

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
  }
}

function global:au_BeforeUpdate {Get-RemoteFiles -Purge}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $latest_tag = (($download_page.BaseResponse).ResponseUri -split '\/')[-1]
    $expanded_assets = Invoke-WebRequest "https://github.com/paintdotnet/release/releases/expanded_assets/$($latest_tag)" -UseBasicParsing

    $re = '*.winmsi.x64.zip'
    $re32 = '*.winmsi.x86.zip'

    $url = $expanded_assets.Links | ? {$_.href -like $re} | select -First 1 -expand href
    $url32 = $expanded_assets.Links | ? {$_.href -like $re32} | select -First 1 -expand href
    $version = $url -split '/' | select -Last 1 -Skip 1

    @{
        Version = $version.Substring(1)
        Url64   = "https://github.com" + $url
        Url     = "https://github.com" + $url32
    }
}

update -ChecksumFor none