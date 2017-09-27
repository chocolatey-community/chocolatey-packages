import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://cygwin.com/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
   @{
    "$($Latest.PackageName).nuspec" = @{
      "(\[Software Changelog\])\(.*\)" = "`${1}($($Latest.ReleaseNotes))"
    }
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | select -First 2 -expand href | % { $releases + $_ }
    $rn  = $download_page.links | ? href -match 'announce'

    @{
        URL32        = $url -notmatch 'x86_64' | select -First 1
        URL64        = $url -match 'x86_64' | select -First 1
        ReleaseNotes = $rn.href
        Version      = $rn.innerText
        PackageName  = 'Cygwin'
    }
}

update -ChecksumFor none
