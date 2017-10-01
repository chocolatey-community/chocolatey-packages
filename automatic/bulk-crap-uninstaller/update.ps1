import-module au

$releases = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
 
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*"  = "`${1} $($Latest.Checksum32)"
        }
     }
 }

 function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = ($url -split '/' | select -Last 1 -Skip 1).Replace('v','')
    @{
        URL32        = 'https://github.com' + $url
        Version      = $version
        ReleaseNotes = "https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/tag/v${version}"
    }
}

update -ChecksumFor none
