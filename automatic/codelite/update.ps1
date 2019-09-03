Import-Module AU

$releases = "https://github.com/eranif/codelite/releases/latest"

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_BeforeUpdate { 
  Get-RemoteFiles -Purge -NoSuffix
  set-alias 7z $Env:chocolateyInstall\tools\7z.exe
  $path = gi tools\*.7z
  7z x $path -otools -aoa
  rm $path
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re      = 'exe\.7z$'
  $domain  =  $releases -split '(?<=//.+)/' | select -First 1
  $url     = $download_page.links | ? href -match $re | select -First 1 -Expand href | % { $domain + $_ }
  $version = $url -split '/' | select -last 1 -skip 1

  @{
    URL64        = $url
    Version      = $version
    ReleaseNotes = "https://github.com/eranif/codelite/releases/tag/$version"
  }
}

update -ChecksumFor none
