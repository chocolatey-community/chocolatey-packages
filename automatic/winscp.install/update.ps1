﻿Import-Module Chocolatey-AU

$releases = 'https://winscp.net/eng/downloads.php'
$re  = 'WinSCP.+\.exe/download$'

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
        "tools\chocolateyInstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
        }
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge -FileNameBase $Latest.FileName32.Replace('.exe','') }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url = @($download_page.links | Where-Object href -match $re) -notmatch 'beta|rc' | ForEach-Object href
    $url = 'https://winscp.net/eng' + $url
    $version   = $url -split '-' | Select-Object -Last 1 -Skip 1
    $file_name = $url -split '/' | Select-Object -last 1 -Skip 1
    @{
        Version      = $version
        URL32        = "https://sourceforge.net/projects/winscp/files/WinSCP/$version/$file_name/download"
        FileName32   = $file_name
        ReleaseNotes = "https://winscp.net/download/WinSCP-${version}-ReadMe.txt"
        FileType     = 'exe'
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none -NoCheckUrl
}


