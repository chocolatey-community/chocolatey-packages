﻿Import-Module Chocolatey-AU

$releases = 'https://files.gpg4win.org/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"        = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"  = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $packageName = Split-Path -Leaf $PSScriptRoot
    $re  = "$packageName-[0-9.]+.exe$"
    $url = $download_page.links | Where-Object href -match $re | Select-Object -Last 1 -Expand href | ForEach-Object { $releases + $_ }

    @{
        Version = $url -split '-|.exe' | Select-Object -Last 1 -Skip 1
        URL32   = $url
    }
}

update -ChecksumFor none
