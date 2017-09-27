import-module au

$releases = 'https://winscp.net/eng/download.php'
$re  = 'WinSCP.+\.exe$'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
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

    $url = @($download_page.links | ? href -match $re) -notmatch 'beta|rc' | % href
    $url = 'https://winscp.net/eng/' + $url
    $version   = $url -split '-' | select -Last 1 -Skip 1
    $file_name = $url -split '/' | select -last 1
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


