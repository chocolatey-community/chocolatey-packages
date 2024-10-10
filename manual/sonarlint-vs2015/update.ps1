﻿Import-Module Chocolatey-AU

$releases = 'https://marketplace.visualstudio.com/items?itemName=SonarSource.SonarLintforVisualStudio'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase $Latest.FileName }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(PackageName\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.PackageName)`""
      "(^[$]filePath\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName).$($Latest.FileType)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re      = 'SonarLintforVisualStudio/.+?/vspackage$'
  $url     = $download_page.links | ? href -match $re | % { "https://marketplace.visualstudio.com" + $_.href  }
  $version = $url -split '/' | select -Last 1 -Skip 1

  @{
    Version   = $version
    URL32     = $url
    Filename  = "SonarLint.VSIX-${version}-2015"
    FileType  = 'vsix'
  }
}

update -ChecksumFor none
