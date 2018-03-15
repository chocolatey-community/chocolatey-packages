Import-Module au

$releases = "https://www.sublimetext.com/3dev"
$versionPattern = "([\d]+)"
$archPattern = "(x64 |)"
$filePattern = "Sublime Text Build $versionPattern $($archPattern)Setup.exe"

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"           = "`${1} $($Latest.URL32)"
            "(?i)(\s+x64:).*"           = "`${1} $($Latest.URL64)"
            "(?i)(checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
            "(?i)(checksum32\:).*"      = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64\:).*"      = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $history_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $urls = $history_page.Links | ? href -Match "$($filePattern)$" | % href
    $version = $Matches[1]

    @{
        Version  = "3.0.0.$($version)"
        URL32    = "$(($urls | Select -First 1) -Replace ' ', '%20')"
        URL64    = "$(($urls | Select -Last 1) -Replace ' ', '%20')"
        FileType = 'exe'
    }
}

update -ChecksumFor none
