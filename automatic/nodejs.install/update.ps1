[CmdletBinding()]
param($IncludeStream, [switch] $Force)

import-module au

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
  function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]filePath32\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32)`""
      "(^[$]filePath64\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName64)`""
    }
    ".\legal\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  $urlsToGrabMsis = @(
    "https://nodejs.org/en/download"
    "https://nodejs.org/en/download/current"
  )

  $lts_page = Invoke-WebRequest -Uri "https://github.com/nodejs/Release/blob/master/README.md" -UseBasicParsing

  $urlsToGrabMsis += $lts_page.links | ? href -match "\/latest\-v.*\/$" | select -expand href

  $streams = @{ }

  $urlsToGrabMsis | % {
    $uri = $_
    $download_page = Invoke-WebRequest -Uri $uri -UseBasicParsing

    $msis = $download_page.links | ? href -match '\.msi$' | select -expand href | % {
      if (!$_.StartsWith('http')) { return $uri + $_ } else { $_ }
    }

    $url32 = $msis | ? { $_ -match 'x86' } | select -first 1
    $version = $url32 -split '\-v?' | select -last 1 -skip 1
    $versionTwoPart = $version -replace '(^\d+\.\d+).*',"`$1"
    if ($streams.ContainsKey($versionTwoPart)) { return ; }

    $url64 = $msis | ? { $_ -match "\-x64" } | select -first 1

    if ($url32 -eq $url64) { throw "The 64bit executable is the same as the 32bit" }

    $streams.Add($versionTwoPart, @{ Version = $version ; URL32 = $url32; URL64 = $url64 } )
  }

  return @{ Streams = $streams }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
}
