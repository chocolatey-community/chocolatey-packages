Import-Module Chocolatey-AU

$releases = 'https://winscp.net/eng/downloads.php'
$re  = 'WinSCP.+Portable\.zip/download$'

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

function global:au_BeforeUpdate {
    Remove-Item tools\* -ea 0
    Get-RemoteFiles -NoSuffix -FileNameBase $Latest.FileName32.Replace('.zip','')

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    7z x "tools\$($Latest.FileName32)" -otools
    Remove-Item "tools\$($Latest.FileName32)"

    Copy-Item $PSScriptRoot\..\winscp.install\README.md $PSScriptRoot\README.md
}

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
        FileType     = 'zip'
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none -NoCheckUrl
}


