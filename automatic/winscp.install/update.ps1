import-module au
import-module $PSScriptRoot\..\..\scripts\au_extensions.psm1

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

function global:au_BeforeUpdate {
    'Determine download link from the latest url'
    $download_page = Invoke-WebRequest $Latest.URL32 -UseBasicParsing
    $url = @($download_page.links | ? href -match $re | % href) -match 'files' | select -First 1

    "Downloading from $url"
    Invoke-WebRequest $url -OutFile "tools\$($Latest.FileName32)"
}
function global:au_AfterUpdate  {  Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url = @($download_page.links | ? href -match $re) -notmatch 'beta' | % href
    $url = 'https://winscp.net/eng/' + $url
    $version  =$url -split '-' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = $url
        FileName32   = $url -split '/' | select -last 1
        ReleaseNotes = "https://winscp.net/download/WinSCP-${version}-ReadMe.txt"
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none -NoCheckUrl
}


