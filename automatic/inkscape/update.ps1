import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain = 'https://inkscape.org'

function global:au_BeforeUpdate { Get-RemoteFIles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.UpdateUrl)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
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
    Version       = $version
    RemoteVersion = $version
    URL32         = $url32
    URL64         = $url64
    ReleaseNotes  = $redirUrl + "#left-column"
    UpdateUrl     = $redirUrl + "windows"
    PackageName   = 'InkScape'
  }
}

update -ChecksumFor none
