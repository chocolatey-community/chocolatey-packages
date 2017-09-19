import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://www.gpg4win.org/download.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"  = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $packageName = Split-Path -Leaf $PSScriptRoot
    $re  = "$packageName-[0-9.]+.exe.sig$"
    $url = $download_page.links | ? href -match $re | select -First 1 -Expand href
    $url = $url -replace '.sig$'
    @{
        Version = $url -split '-|.exe' | select -Last 1 -Skip 1
        URL32   = $url
    }
}

update -ChecksumFor none
