import-module au
import-module $PSScriptRoot\..\..\scripts\au_extensions.psm1

$releases = 'https://winscp.net/eng/download.php'
$re  = 'WinSCP.+Portable\.zip$'

function global:au_SearchReplace {
   @{

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate {
    mkdir tools -ea 0 | Out-Null

    'Determine download link from the latest url'
    $download_page = Invoke-WebRequest $Latest.URL32 -UseBasicParsing
    $url = @($download_page.links | ? href -match $re | % href) -match 'files' | select -First 1

    "Downloading from $url"
    Invoke-WebRequest $url -OutFile $Latest.FileName32

    cp $PSScriptRoot\..\winscp.install\README.md $PSScriptRoot\README.md

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    rm tools\*
    7z x $Latest.FileName32 -otools
    rm $Latest.FileName32
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


