import-module au

$releases = 'https://github.com/assaultcube/AC/releases'
$softwareName = 'AssaultCube*'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"             = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\)[^`"]*`"" = "`${1}$($Latest.FileName32)`""
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = ($url -split '/' | select -last 1 -skip 1).Substring(1)
    @{
        URL32        = 'https://github.com' + $url
        Version      =  $version
        ReleaseNotes = "https://github.com/assaultcube/AC/releases/tag/v${version}"
    }
}

$global:au_Version = '1.2.0.201'
update -ChecksumFor none -Force
$global:au_Version = $null
