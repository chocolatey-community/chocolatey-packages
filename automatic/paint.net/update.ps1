Import-Module AU


$domain   = 'https://github.com'
$releases = "$domain/repos/paintdotnet/release/releases/latest"
$owner = "paintdotnet"
$repository = "release"

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

function global:au_BeforeUpdate {
Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -Owner $owner -RepositoryName $repository -Latest


    $re = 'winmsi.x64.zip'
    $re32 = 'winmsi.x86.zip'

    $url = $tags.assets.browser_download_url | ? {$_ -match $re}
    $url32 = $tags.assets.browser_download_url | ? {$_ -match $re32}
    $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)

    return @{
        Version = $version
        Url64   = "https://github.com" + $url
        Url     = "https://github.com" + $url32
        ReleaseURL  = "$domain/paintdotnet/release/releases/tag/v${version}"
        PackageName = 'paint.net'
    }
}

update -ChecksumFor none
