Import-Module au
. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

$source = "https://screencloud.net/pages/download"
$pattern = "ScreenCloud-(.+)-x86.msi$"

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate {
    Set-DescriptionFromReadme -SkipFirst 2
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)'$($pattern)'" = "`${1}'$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
            "(?i)(\checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $res = Invoke-WebRequest -Uri $source -UseBasicParsing

    $url = $res.Links | ? href -match $pattern | select -First 1 -Expand href
    $version = $matches[1]

    @{
        Version = $version
        URL32 = "https:$url"
    }
}

update -ChecksumFor none
