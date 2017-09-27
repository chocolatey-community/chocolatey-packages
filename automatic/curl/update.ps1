import-module au

$releases = 'https://curl.haxx.se/download.html'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    rm tools\curl_* -Recurse
    7z e tools\*win32* curl.exe libcurl.dll -r -otools\curl_x32
    7z e tools\*win64* curl.exe libcurl.dll -r -otools\curl_x64
    rm tools\*.7z
}
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '/vszakats/.+\.7z'
    $url   = $download_page.links | ? href -match $re | % href
    $version  = ($url[0] -split '/'  | select -Last 1) -split '-' | select -Index 1

    @{
        Version      = $version
        URL32        = $url -match 'win32' | select -first 1
        URL64        = $url -notmatch 'win32' | select -first 1
    }
}

update -ChecksumFor none
