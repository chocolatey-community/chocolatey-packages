import-module au
. "$PSScriptRoot\update_helper.ps1"

$releases = 'https://www.sourcetreeapp.com/update/windowsupdates.txt'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    # Read and parse update versions.
    $content = Invoke-WebRequest -UseBasicParsing -Uri $releases | Get-IniContent

    # Determine current version.
    $currentVersion = $content.GetEnumerator() | where {$_.Key -ne "No-Version"} | %{[System.Version]$_.Key} | sort -Descending | select -first 1
    $currentProps = $content[$currentVersion.ToString()]

    @{
        Version   = $currentProps.ProductVersion
        URL32     = $currentProps.URL
        URL64     = $currentProps.URL
    }
}

update