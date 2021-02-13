import-module au

[uri]$releases = 'https://curl.se/windows/'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(Go to)\s*[^,]*"        = "`${1} $releases"
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\tools\chocolateyInstall.ps1" = @{
          "(?i)(FullPath.*`"`[$]toolsPath\\).*`""   = "`${1}$($Latest.FileName32)`""
          "(?i)(FullPath64.*`"`[$]toolsPath\\).*`"" = "`${1}$($Latest.FileName64)`""
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    # Download and include the ssl certificate, due to issue <https://github.com/chocolatey/chocolatey-coreteampackages/issues/957>
    if (Test-Path "tools\cacert.pem") { remove-Item "tools\cacert.pem" }
    Invoke-WebRequest -Uri "https://curl.se/ca/cacert.pem" -OutFile "tools\cacert.pem" -UseBasicParsing
}
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.zip'
    $url   = $download_page.links | ? href -match $re | % { [uri]::new($releases, $_.href) }
    $version  = ($url[0] -split '/'  | select -Last 1) -split '(_\d+)?-' | select -Index 1
    $releaseNotes = $download_page.links | ? href -match "changes\.html" | select -first 1 -expand href

    @{
        Version      = $version
        URL32        = $url -match 'win32' | select -first 1
        URL64        = $url | ? { $_ -notmatch 'win32' -and $_ -match $version } | select -first 1
        ReleaseNotes = $releaseNotes
    }
}

update -ChecksumFor none
