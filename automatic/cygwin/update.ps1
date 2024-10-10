Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://cygwin.com/'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\[Software Changelog\])\(.*\)" = "`${1}($($Latest.ReleaseNotes))"
    }
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re = '\.exe$'
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 2 -expand href | ForEach-Object { $releases + $_ }
  $rn = $download_page.links | Where-Object href -match 'announce'

  $result = @{
    URL64        = $url | Where-Object {$_ -match 'x86_64' } | Select-Object -First 1
    ReleaseNotes = $rn.href
    Version      = $rn.innerText
    PackageName  = 'Cygwin'
  }

  $result
}

update -ChecksumFor none
