import-module au

$releases = 'http://www.apachehaus.com/cgi-bin/download.plx'

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64

  $lines = @(
    @('vc9'; $Latest.URL32; $Latest.URL64; $Latest.Checksum32; $Latest.Checksum64) -join '|'
    @('vc11'; $Latest.URL32; $Latest.URL64; $Latest.Checksum32; $Latest.Checksum64) -join '|'
    @('vc14'; $Latest.URL32; $Latest.URL64; $Latest.Checksum32; $Latest.Checksum64) -join '|'
  )

  [System.IO.File]::WriteAllLines("$PSScriptRoot\tools\downloadInfo.csv", $lines);
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"                        = "`$1'$($Latest.PackageName)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = 'httpd-\d.+-vc\d.+\.zip$'
    $url     = $download_page.links | ? href -match $re  | % href | select -First 2
    $version = $url[0] -split '-' | select -Index 1
    $majorVersion = $version -split '\.' | select -first 1
    $Result = @{
        Version      = $version
        URL32     = "http://www.apachehaus.com/downloads/" + ($url -match 'x86' | select -First 1)
        URL64     = "http://www.apachehaus.com/downloads/" + ($url -match 'x64' | select -First 1)
        ReleaseNotes = "http://www.apache.org/dist/httpd/CHANGES_${majorVersion}.#${version}"
    }

    $Result
}

update -ChecksumFor none
