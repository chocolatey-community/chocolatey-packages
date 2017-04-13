import-module au
. "$PSScriptRoot\..\..\scripts\Get-Padded-Version.ps1"

$releases = 'http://omahaproxy.appspot.com/all?os=win&amp;channel=stable'
$paddedUnderVersion = '57.0.2988'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(?i)(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.RemoteVersion)'"
        }
    }
}

function global:au_GetLatest {
    $release_info = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = $release_info | % Content | ConvertFrom-Csv | % current_version

    @{
        URL32 = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
        URL64 = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
        Version = Get-Padded-Version -Version $version -OnlyBelowVersion $paddedUnderVersion -RevisionLength 5
        RemoteVersion = $version
    }
}

update
