[CmdletBinding()]
param($IncludeStream, [switch] $Force)

import-module au

$releases = 'https://sourceforge.net/projects/ext2fsd/files/Ext2fsd'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }
function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
          "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\)(.*)`""   = "`$1$($Latest.FileName32)`""
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(location on\s*)<.*>" = "`${1}<$releases>"
          "(?i)(1\..+)\<.*\>"       = "`${1}<$($Latest.URL32)>"
          "(?i)(checksum type:).*"  = "`${1} $($Latest.ChecksumType32)"
          "(?i)(checksum:).*"       = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    # We only take the latest 5 releases, to keep web requests to a maintainable level
    $versions = $download_page.links | ? href -match "[\d]+\.[\d\.]+\/$" | select -expand href | % { $_ -split '\/' | select -last 1 -skip 1} | select -first 5

    $streams = @{}

    $versions | % {
      $version = Get-Version $_
      $verReleases = "$releases/$_"
      $download_page = Invoke-WebRequest -Uri $verReleases -UseBasicParsing

      $url = $download_page.links | ? href -match "$_\.exe/download$" | select -first 1 -expand href

      if ($url) {
        $streams.Add($version.ToString(2), @{ Version = $version.ToString(); URL32 = $url; FileType = 'exe' })
      }
    }

    return @{ Streams = $streams }
}

try {
    update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
} catch {
    $ignore = "Unable to connect to the remote server"
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}

