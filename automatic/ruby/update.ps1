import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1

$releases = 'https://rubyinstaller.org/downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 2 -expand href
    @{
        Version      = $url[0] -split '-|.exe' | select -Last 1 -Skip 1
        URL32        = $url -notmatch 'x64' | select -first 1
        URL64        = $url -match 'x64'    | select -first 1
    }
}

update -ChecksumFor none
