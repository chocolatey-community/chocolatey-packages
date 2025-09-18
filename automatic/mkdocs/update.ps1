Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
     }
}

function global:au_GetLatest {
    $LatestRelease = Get-GitHubRelease mkdocs mkdocs

    return @{ Version = Get-Version $LatestRelease.tag_name }
}

update -ChecksumFor none
