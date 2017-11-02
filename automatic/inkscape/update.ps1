import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain = 'https://inkscape.org'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
  $redirUrl = Get-RedirectedUrl "$domain/en/release/"

  $version = $redirUrl -split '\/' | select -last 1 -skip 1

  $32bit_page = Invoke-WebRequest "$redirUrl/windows/32-bit/msi/dl/" -UseBasicParsing
  $64bit_page = Invoke-WebRequest "$redirUrl/windows/64-bit/msi/dl/" -UseBasicParsing

  $re = '\.msi$'
  $url32 = $32bit_page.links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }
  $url64 = $64bit_page.links | ? href -match $re | select -first 1 -expand href | % { $domain + $_ }

  @{
    Version      = $version
    URL32        = $url32
    URL64        = $url64
    ReleaseNotes = $redirUrl + "#left-column"
    PackageName  = 'InkScape'
  }
}

update
